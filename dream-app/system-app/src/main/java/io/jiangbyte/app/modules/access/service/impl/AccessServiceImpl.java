package io.jiangbyte.app.modules.access.service.impl;

import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.SaLoginModel;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.captcha.generator.RandomGenerator;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import io.jiangbyte.app.modules.access.dto.*;
import io.jiangbyte.app.modules.access.service.AccessService;
import io.jiangbyte.app.modules.auths.account.entity.AuthsAccount;
import io.jiangbyte.app.modules.auths.account.mapper.AuthsAccountMapper;
import io.jiangbyte.app.modules.users.info.entity.UsersInfo;
import io.jiangbyte.app.modules.users.info.mapper.UsersInfoMapper;
import io.jiangbyte.app.modules.users.preference.entity.UsersPreference;
import io.jiangbyte.app.modules.users.preference.mapper.UsersPreferenceMapper;
import io.jiangbyte.app.modules.users.profile.entity.UsersProfile;
import io.jiangbyte.app.modules.users.profile.mapper.UsersProfileMapper;
import io.jiangbyte.app.modules.users.stats.entity.UsersStats;
import io.jiangbyte.app.modules.users.stats.mapper.UsersStatsMapper;
import io.jiangbyte.app.utils.IpUtil;
import io.jiangbyte.framework.exception.BusinessException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ZhangJiangHu
 * @version v1.0
 * @date 18/11/2025
 * @description TODO
 */
@Service
@RequiredArgsConstructor
public class AccessServiceImpl implements AccessService {
    private final RedisTemplate<String, Object> redisTemplate;

    private final AuthsAccountMapper authsAccountMapper;
    private final UsersInfoMapper usersInfoMapper;
    private final UsersPreferenceMapper usersPreferenceMapper;
    private final UsersProfileMapper usersProfileMapper;
    private final UsersStatsMapper usersStatsMapper;

    @Override
    public CaptchaResp captcha() {
        CaptchaResp captchaResult = new CaptchaResp();

//        CircleCaptcha circleCaptcha = CaptchaUtil.createCircleCaptcha(100, 38, 4, 10);
//        String imageBase64Data = circleCaptcha.getImageBase64Data();

        RandomGenerator randomGenerator = new RandomGenerator("0123456789", 4);
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(120, 40, 4, 5);
        lineCaptcha.setGenerator(randomGenerator);
        String imageBase64Data = lineCaptcha.getImageBase64Data();

        captchaResult.setCaptchaImg(imageBase64Data);
        String uuid = IdUtil.fastSimpleUUID();
        captchaResult.setCaptchaId(uuid);
        redisTemplate.opsForValue().set("captcha:" + uuid, lineCaptcha.getCode(), Duration.ofSeconds(5 * 60L));
        return captchaResult;
    }

    @Override
    public LoginResp doLogin(LoginReq loginReq) {
        // 数据库用户名是否存在
        AuthsAccount authAccount = authsAccountMapper.selectOne(new LambdaQueryWrapper<AuthsAccount>().eq(AuthsAccount::getUsername, loginReq.getUsername()));
        if (ObjectUtil.isEmpty(authAccount)) {
            throw new BusinessException("用户不存在");
        }

        // IP 记录
        String clientIp = IpUtil.getClientIp();
        authAccount.setLastLoginIp(clientIp);
        // 更新登录时间
        authAccount.setLastLoginTime(new Date());
        // 更新登录次数
        authAccount.setLoginCount(authAccount.getLoginCount() + 1);
        authsAccountMapper.updateById(authAccount);

        SaLoginModel loginModel = new SaLoginModel();
        Map<String, Object> extraData = new HashMap<>();
        extraData.put("id", authAccount.getId());
        loginModel.setExtraData(extraData);
        StpUtil.login(authAccount.getId(), loginModel);

        LoginResp loginResp = new LoginResp();
        loginResp.setToken(StpUtil.getTokenValue());

        UserPublicAssociatedInfo userPublicAssociatedInfo = new UserPublicAssociatedInfo();
        // INFO
        UsersInfo usersInfo = usersInfoMapper.selectOne(new LambdaQueryWrapper<UsersInfo>().eq(UsersInfo::getAccountId, authAccount.getId()));
        BeanUtil.copyProperties(usersInfo, userPublicAssociatedInfo);
        // PROFILE
        UsersProfile usersProfile = usersProfileMapper.selectOne(new LambdaQueryWrapper<UsersProfile>().eq(UsersProfile::getAccountId, authAccount.getId()));
        BeanUtil.copyProperties(usersProfile, userPublicAssociatedInfo);
        // STATS
        UsersStats usersStats = usersStatsMapper.selectOne(new LambdaQueryWrapper<UsersStats>().eq(UsersStats::getAccountId, authAccount.getId()));
        BeanUtil.copyProperties(usersStats, userPublicAssociatedInfo);

        loginResp.setUser(userPublicAssociatedInfo);

        return loginResp;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public RegisterResp doRegister(RegisterReq registerReq) {
        // 唯一性校验
        // 用户名
        if (authsAccountMapper.exists(new LambdaQueryWrapper<AuthsAccount>()
                .eq(AuthsAccount::getUsername, registerReq.getUsername())
        )) {
            throw new BusinessException("用户名已存在");
        }
        // 邮箱
        if (authsAccountMapper.exists(new LambdaQueryWrapper<AuthsAccount>()
                .eq(AuthsAccount::getEmail, registerReq.getEmail())
        )) {
            throw new BusinessException("邮箱已存在");
        }

        // 创建账户
        AuthsAccount authsAccount = new AuthsAccount();
        authsAccount.setUsername(registerReq.getUsername());
        authsAccount.setPassword(BCrypt.hashpw(registerReq.getPassword(), BCrypt.gensalt()));
        authsAccount.setEmail(registerReq.getEmail());
        authsAccountMapper.insert(authsAccount);

        // 创建用户信息
        UsersInfo usersInfo = new UsersInfo();
        usersInfo.setAccountId(authsAccount.getId());
        usersInfo.setNickname(registerReq.getNickname());
        usersInfo.setAvatar(null);
        usersInfo.setSignature(null);
        usersInfoMapper.insert(usersInfo);

        // 创建用户偏好
        UsersPreference entity = new UsersPreference();
        entity.setAccountId(authsAccount.getId());
        usersPreferenceMapper.insert(entity);

        // 创建用户统计
        UsersStats usersStats = new UsersStats();
        usersStats.setAccountId(authsAccount.getId());
        usersStatsMapper.insert(usersStats);

        // 创建用户档案
        UsersProfile usersProfile = new UsersProfile();
        usersProfile.setAccountId(authsAccount.getId());
        usersProfileMapper.insert(usersProfile);

        RegisterResp registerResp = new RegisterResp();
        registerResp.setUserId(authsAccount.getId());
        return registerResp;
    }

    @Override
    public void doLogout() {
        StpUtil.logout();
    }
}
