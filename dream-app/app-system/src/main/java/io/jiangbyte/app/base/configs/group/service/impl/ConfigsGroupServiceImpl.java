package io.jiangbyte.app.base.configs.group.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.configs.group.entity.ConfigsGroup;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupDto;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupPageQuery;
import io.jiangbyte.app.base.configs.group.mapper.ConfigsGroupMapper;
import io.jiangbyte.app.base.configs.group.service.ConfigsGroupService;
import io.jiangbyte.framework.utils.SortUtils;
import io.jiangbyte.framework.enums.ISortOrderEnum;
import io.jiangbyte.framework.exception.BusinessException;
import io.jiangbyte.framework.pojo.BasePageRequest;
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
* @description 配置分组表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class ConfigsGroupServiceImpl extends ServiceImpl<ConfigsGroupMapper, ConfigsGroup> implements ConfigsGroupService {

    @Override
    public Page<ConfigsGroup> page(ConfigsGroupPageQuery req) {
        QueryWrapper<ConfigsGroup> queryWrapper = new QueryWrapper<ConfigsGroup>().checkSqlInjection();
        if (ObjectUtil.isNotEmpty(req.getKeyword())) {
            queryWrapper.lambda().like(ConfigsGroup::getName, req.getKeyword());
        }
        SortUtils.handleSort(ConfigsGroup.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(ConfigsGroupDto req) {
        ConfigsGroup bean = BeanUtil.toBean(req, ConfigsGroup.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(ConfigsGroupDto req) {
        if (!this.exists(new LambdaQueryWrapper<ConfigsGroup>().eq(ConfigsGroup::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        ConfigsGroup bean = BeanUtil.toBean(req, ConfigsGroup.class);
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
    public ConfigsGroup detail(String id) {
        ConfigsGroup configsGroup = this.getById(id);
        if (ObjectUtil.isEmpty(configsGroup)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return configsGroup;
    }

    @Override
    public List<ConfigsGroup> latest(int n) {
        return this.list(new QueryWrapper<ConfigsGroup>()
            .lambda()
            .orderByDesc(ConfigsGroup::getId)
            .last("limit " + n));
    }

    @Override
    public List<ConfigsGroup> topN(int n) {
        return this.list(new QueryWrapper<ConfigsGroup>()
            .lambda()
            .orderByDesc(ConfigsGroup::getId)
            .last("limit " + n));
    }


    @Override
    public List<ConfigsGroup> lists() {
        return this.list(new QueryWrapper<ConfigsGroup>()
            .lambda()
            .orderByDesc(ConfigsGroup::getId));
    }

}