package io.jiangbyte.app.base.systems.code.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.systems.code.entity.SysCodeTaskModule;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModuleDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModulePageQuery;
import io.jiangbyte.app.base.systems.code.mapper.SysCodeTaskModuleMapper;
import io.jiangbyte.app.base.systems.code.service.SysCodeTaskModuleService;
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
* @description 代码生成任务模块明细表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class SysCodeTaskModuleServiceImpl extends ServiceImpl<SysCodeTaskModuleMapper, SysCodeTaskModule> implements SysCodeTaskModuleService {

    @Override
    public Page<SysCodeTaskModule> page(SysCodeTaskModulePageQuery req) {
        QueryWrapper<SysCodeTaskModule> queryWrapper = new QueryWrapper<SysCodeTaskModule>().checkSqlInjection();
        SortUtils.handleSort(SysCodeTaskModule.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(SysCodeTaskModuleDto req) {
        SysCodeTaskModule bean = BeanUtil.toBean(req, SysCodeTaskModule.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(SysCodeTaskModuleDto req) {
        if (!this.exists(new LambdaQueryWrapper<SysCodeTaskModule>().eq(SysCodeTaskModule::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        SysCodeTaskModule bean = BeanUtil.toBean(req, SysCodeTaskModule.class);
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
    public SysCodeTaskModule detail(String id) {
        SysCodeTaskModule sysCodeTaskModule = this.getById(id);
        if (ObjectUtil.isEmpty(sysCodeTaskModule)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return sysCodeTaskModule;
    }

    @Override
    public List<SysCodeTaskModule> latest(int n) {
        return this.list(new QueryWrapper<SysCodeTaskModule>()
            .lambda()
            .orderByDesc(SysCodeTaskModule::getId)
            .last("limit " + n));
    }

    @Override
    public List<SysCodeTaskModule> topN(int n) {
        return this.list(new QueryWrapper<SysCodeTaskModule>()
            .lambda()
            .orderByDesc(SysCodeTaskModule::getId)
            .last("limit " + n));
    }


    @Override
    public List<SysCodeTaskModule> lists() {
        return this.list(new QueryWrapper<SysCodeTaskModule>()
            .lambda()
            .orderByDesc(SysCodeTaskModule::getId));
    }

}