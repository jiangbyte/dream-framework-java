package io.jiangbyte.app.base.auths.account.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import icu.mhb.mybatisplus.plugln.core.JoinLambdaWrapper;
import io.jiangbyte.app.base.auths.account.entity.AuthsAccount;
import io.jiangbyte.app.base.auths.account.dto.AuthsAccountDto;
import io.jiangbyte.app.base.auths.account.dto.AuthsAccountPageQuery;
import io.jiangbyte.app.base.auths.account.entity.AuthsAccountGroup;
import io.jiangbyte.app.base.auths.account.mapper.AuthsAccountMapper;
import io.jiangbyte.app.base.auths.account.service.AuthsAccountService;
import io.jiangbyte.app.base.auths.group.entity.AuthsGroup;
import io.jiangbyte.app.base.users.info.entity.UsersInfo;
import io.jiangbyte.app.base.users.profile.entity.UsersProfile;
import io.jiangbyte.app.base.users.stats.entity.UsersStats;
import io.jiangbyte.framework.utils.SortUtils;
import io.jiangbyte.framework.enums.ISortOrderEnum;
import io.jiangbyte.framework.exception.BusinessException;
import io.jiangbyte.framework.pojo.BasePageRequest;
import io.jiangbyte.framework.result.ResultCode;
import org.apache.commons.lang3.StringUtils;
import org.dromara.trans.service.impl.TransService;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * @author Charlie Zhang
 * @version v1.0
 * @date 2025-06-23
 * @description 核心账户表 服务实现类
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AuthsAccountServiceImpl extends ServiceImpl<AuthsAccountMapper, AuthsAccount> implements AuthsAccountService {
    private final TransService transService;

    @Override
    public Page<AuthsAccount> page(AuthsAccountPageQuery req) {
        // 1. 创建 JoinLambdaWrapper，主表为 AuthsAccount
        JoinLambdaWrapper<AuthsAccount> wrapper = new JoinLambdaWrapper<>(AuthsAccount.class);

        wrapper
                // 2. LEFT JOIN users_info
                .leftJoin(UsersInfo.class, UsersInfo::getAccountId, AuthsAccount::getId)
                .oneToOneSelect(AuthsAccount::getUsersInfo, UsersInfo.class)
                .eq(StringUtils.isNotBlank(req.getKeyword()), UsersInfo::getNickname, req.getKeyword())
                .end()
                // 3. LEFT JOIN users_profile
                .leftJoin(UsersProfile.class, UsersProfile::getAccountId, AuthsAccount::getId)
                .oneToOneSelect(AuthsAccount::getUsersProfile, UsersProfile.class)
                .end()
                // 4. LEFT JOIN users_stats
                .leftJoin(UsersStats.class, UsersStats::getAccountId, AuthsAccount::getId)
                .oneToOneSelect(AuthsAccount::getUsersStats, UsersStats.class)
                .end()
                .leftJoin(AuthsAccountGroup.class, AuthsAccountGroup::getAccountId, AuthsAccount::getId)
                .eq(StringUtils.isNotBlank(req.getGroupId()), AuthsAccountGroup::getGroupId, req.getGroupId())
                .end()
                .leftJoin(AuthsGroup.class, AuthsGroup::getId, AuthsAccountGroup::getGroupId)
                .end()
        ;

        Page<AuthsAccount> authsAccountPage = wrapper.joinPage(BasePageRequest.Page(
                Optional.ofNullable(req.getCurrent()).orElse(1),
                Optional.ofNullable(req.getPageSize()).orElse(10)), AuthsAccount.class);
        // 密码不返回
        authsAccountPage.getRecords().forEach(authsAccount -> authsAccount.setPassword(null));
        transService.transBatch(authsAccountPage.getRecords());
        return authsAccountPage;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(AuthsAccountDto req) {
        AuthsAccount bean = BeanUtil.toBean(req, AuthsAccount.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(AuthsAccountDto req) {
        if (!this.exists(new LambdaQueryWrapper<AuthsAccount>().eq(AuthsAccount::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        AuthsAccount bean = BeanUtil.toBean(req, AuthsAccount.class);
        BeanUtil.copyProperties(req, bean);
        this.updateById(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<String> ids) {
        if (ObjectUtil.isEmpty(ids)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        this.removeByIds(ids);
    }

    @Override
    public AuthsAccount detail(String id) {
        AuthsAccount authsAccount = this.getById(id);
        if (ObjectUtil.isEmpty(authsAccount)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return authsAccount;
    }

    @Override
    public List<AuthsAccount> latest(int n) {
        return this.list(new QueryWrapper<AuthsAccount>()
                .lambda()
                .orderByDesc(AuthsAccount::getId)
                .last("limit " + n));
    }

    @Override
    public List<AuthsAccount> topN(int n) {
        return this.list(new QueryWrapper<AuthsAccount>()
                .lambda()
                .orderByDesc(AuthsAccount::getId)
                .last("limit " + n));
    }


    @Override
    public List<AuthsAccount> lists() {
        return this.list(new QueryWrapper<AuthsAccount>()
                .lambda()
                .orderByDesc(AuthsAccount::getId));
    }

}