package io.jiangbyte.app.base.systems.code.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.systems.code.entity.SysCodeTask;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskPageQuery;
import io.jiangbyte.app.base.systems.code.mapper.SysCodeTaskMapper;
import io.jiangbyte.app.base.systems.code.service.SysCodeTaskService;
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
* @description 代码生成任务主表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class SysCodeTaskServiceImpl extends ServiceImpl<SysCodeTaskMapper, SysCodeTask> implements SysCodeTaskService {

    @Override
    public Page<SysCodeTask> page(SysCodeTaskPageQuery req) {
        QueryWrapper<SysCodeTask> queryWrapper = new QueryWrapper<SysCodeTask>().checkSqlInjection();
        SortUtils.handleSort(SysCodeTask.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(SysCodeTaskDto req) {
        SysCodeTask bean = BeanUtil.toBean(req, SysCodeTask.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(SysCodeTaskDto req) {
        if (!this.exists(new LambdaQueryWrapper<SysCodeTask>().eq(SysCodeTask::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        SysCodeTask bean = BeanUtil.toBean(req, SysCodeTask.class);
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
    public SysCodeTask detail(String id) {
        SysCodeTask sysCodeTask = this.getById(id);
        if (ObjectUtil.isEmpty(sysCodeTask)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return sysCodeTask;
    }

    @Override
    public List<SysCodeTask> latest(int n) {
        return this.list(new QueryWrapper<SysCodeTask>()
            .lambda()
            .orderByDesc(SysCodeTask::getId)
            .last("limit " + n));
    }

    @Override
    public List<SysCodeTask> topN(int n) {
        return this.list(new QueryWrapper<SysCodeTask>()
            .lambda()
            .orderByDesc(SysCodeTask::getId)
            .last("limit " + n));
    }


    @Override
    public List<SysCodeTask> lists() {
        return this.list(new QueryWrapper<SysCodeTask>()
            .lambda()
            .orderByDesc(SysCodeTask::getId));
    }

}