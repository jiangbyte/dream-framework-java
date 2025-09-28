package io.jiangbyte.app.modular.sys.tag.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.modular.sys.tag.entity.SysTag;
import io.jiangbyte.app.modular.sys.tag.param.SysTagAddParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagEditParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagIdParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagPageParam;
import io.jiangbyte.app.modular.sys.tag.mapper.SysTagMapper;
import io.jiangbyte.app.modular.sys.tag.service.SysTagService;
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
* @description 标签表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class SysTagServiceImpl extends ServiceImpl<SysTagMapper, SysTag> implements SysTagService {

    @Override
    public Page<SysTag> page(SysTagPageParam sysTagPageParam) {
        QueryWrapper<SysTag> queryWrapper = new QueryWrapper<SysTag>().checkSqlInjection();
        // 关键字
        if (ObjectUtil.isNotEmpty(sysTagPageParam.getKeyword())) {
            queryWrapper.lambda().like(SysTag::getName, sysTagPageParam.getKeyword());
        }
        if (ObjectUtil.isAllNotEmpty(sysTagPageParam.getSortField(), sysTagPageParam.getSortOrder()) && ISortOrderEnum.isValid(sysTagPageParam.getSortOrder())) {
            queryWrapper.orderBy(
                    true,
                    sysTagPageParam.getSortOrder().equals(ISortOrderEnum.ASCEND.getValue()),
                    StrUtil.toUnderlineCase(sysTagPageParam.getSortField()));
        }

        return this.page(CommonPageRequest.Page(
                        Optional.ofNullable(sysTagPageParam.getCurrent()).orElse(1),
                        Optional.ofNullable(sysTagPageParam.getSize()).orElse(10),
                null
                ),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(SysTagAddParam sysTagAddParam) {
        SysTag bean = BeanUtil.toBean(sysTagAddParam, SysTag.class);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(SysTagEditParam sysTagEditParam) {
        if (!this.exists(new LambdaQueryWrapper<SysTag>().eq(SysTag::getId, sysTagEditParam.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        SysTag bean = BeanUtil.toBean(sysTagEditParam, SysTag.class);
        BeanUtil.copyProperties(sysTagEditParam, bean);
        this.updateById(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<SysTagIdParam> sysTagIdParamList) {
        if (ObjectUtil.isEmpty(sysTagIdParamList)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        this.removeByIds(CollStreamUtil.toList(sysTagIdParamList, SysTagIdParam::getId));
    }

    @Override
    public SysTag detail(SysTagIdParam sysTagIdParam) {
        SysTag sysTag = this.getById(sysTagIdParam.getId());
        if (ObjectUtil.isEmpty(sysTag)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return sysTag;
    }

    @Override
    public List<SysTag> latest(int n) {
        return this.list(new QueryWrapper<SysTag>()
            .lambda()
            .orderByDesc(SysTag::getId)
            .last("limit " + n));
    }

    @Override
    public List<SysTag> topN(int n) {
        return this.list(new QueryWrapper<SysTag>()
            .lambda()
            .orderByDesc(SysTag::getId)
            .last("limit " + n));
    }

}