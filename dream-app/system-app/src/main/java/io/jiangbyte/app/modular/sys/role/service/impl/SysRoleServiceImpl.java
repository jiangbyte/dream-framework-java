package io.jiangbyte.app.modular.sys.role.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.modular.sys.role.entity.SysRole;
import io.jiangbyte.app.modular.sys.role.param.SysRoleAddParam;
import io.jiangbyte.app.modular.sys.role.param.SysRoleEditParam;
import io.jiangbyte.app.modular.sys.role.param.SysRoleIdParam;
import io.jiangbyte.app.modular.sys.role.param.SysRolePageParam;
import io.jiangbyte.app.modular.sys.role.mapper.SysRoleMapper;
import io.jiangbyte.app.modular.sys.role.service.SysRoleService;
import io.jiangbyte.framework.enums.ISortOrderEnum;
import io.jiangbyte.framework.exception.BusinessException;
import io.jiangbyte.framework.pojo.CommonPageRequest;
import io.jiangbyte.framework.result.ResultCode;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-06-23
* @description 角色表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {

    @Override
    public Page<SysRole> page(SysRolePageParam sysRolePageParam) {
        QueryWrapper<SysRole> queryWrapper = new QueryWrapper<SysRole>().checkSqlInjection();
        // 关键字
        if (ObjectUtil.isNotEmpty(sysRolePageParam.getKeyword())) {
            queryWrapper.lambda().like(SysRole::getName, sysRolePageParam.getKeyword());
        }
        if (ObjectUtil.isAllNotEmpty(sysRolePageParam.getSortField(), sysRolePageParam.getSortOrder()) && ISortOrderEnum.isValid(sysRolePageParam.getSortOrder())) {
            queryWrapper.orderBy(
                    true,
                    sysRolePageParam.getSortOrder().equals(ISortOrderEnum.ASCEND.getValue()),
                    StrUtil.toUnderlineCase(sysRolePageParam.getSortField()));
        }

        return this.page(CommonPageRequest.Page(
                        Optional.ofNullable(sysRolePageParam.getCurrent()).orElse(1),
                        Optional.ofNullable(sysRolePageParam.getSize()).orElse(10),
                null
                ),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(SysRoleAddParam sysRoleAddParam) {
        SysRole bean = BeanUtil.toBean(sysRoleAddParam, SysRole.class);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(SysRoleEditParam sysRoleEditParam) {
        if (!this.exists(new LambdaQueryWrapper<SysRole>().eq(SysRole::getId, sysRoleEditParam.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        SysRole bean = BeanUtil.toBean(sysRoleEditParam, SysRole.class);
        BeanUtil.copyProperties(sysRoleEditParam, bean);
        this.updateById(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<SysRoleIdParam> sysRoleIdParamList) {
        if (ObjectUtil.isEmpty(sysRoleIdParamList)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        this.removeByIds(CollStreamUtil.toList(sysRoleIdParamList, SysRoleIdParam::getId));
    }

    @Override
    public SysRole detail(SysRoleIdParam sysRoleIdParam) {
        SysRole sysRole = this.getById(sysRoleIdParam.getId());
        if (ObjectUtil.isEmpty(sysRole)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return sysRole;
    }

    @Override
    public List<SysRole> latest(int n) {
        return this.list(new QueryWrapper<SysRole>()
            .lambda()
            .orderByDesc(SysRole::getId)
            .last("limit " + n));
    }

    @Override
    public List<SysRole> topN(int n) {
        return this.list(new QueryWrapper<SysRole>()
            .lambda()
            .orderByDesc(SysRole::getId)
            .last("limit " + n));
    }

}