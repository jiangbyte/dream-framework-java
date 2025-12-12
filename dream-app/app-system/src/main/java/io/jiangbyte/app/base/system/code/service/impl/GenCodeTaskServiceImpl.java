package io.jiangbyte.app.base.system.code.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.system.code.entity.GenCodeTask;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskDto;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskPageQuery;
import io.jiangbyte.app.base.system.code.mapper.GenCodeTaskMapper;
import io.jiangbyte.app.base.system.code.service.GenCodeTaskService;
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
public class GenCodeTaskServiceImpl extends ServiceImpl<GenCodeTaskMapper, GenCodeTask> implements GenCodeTaskService {

    @Override
    public Page<GenCodeTask> page(GenCodeTaskPageQuery req) {
        QueryWrapper<GenCodeTask> queryWrapper = new QueryWrapper<GenCodeTask>().checkSqlInjection();
        SortUtils.handleSort(GenCodeTask.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(GenCodeTaskDto req) {
        GenCodeTask bean = BeanUtil.toBean(req, GenCodeTask.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(GenCodeTaskDto req) {
        if (!this.exists(new LambdaQueryWrapper<GenCodeTask>().eq(GenCodeTask::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        GenCodeTask bean = BeanUtil.toBean(req, GenCodeTask.class);
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
    public GenCodeTask detail(String id) {
        GenCodeTask genCodeTask = this.getById(id);
        if (ObjectUtil.isEmpty(genCodeTask)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return genCodeTask;
    }

    @Override
    public List<GenCodeTask> latest(int n) {
        return this.list(new QueryWrapper<GenCodeTask>()
            .lambda()
            .orderByDesc(GenCodeTask::getId)
            .last("limit " + n));
    }

    @Override
    public List<GenCodeTask> topN(int n) {
        return this.list(new QueryWrapper<GenCodeTask>()
            .lambda()
            .orderByDesc(GenCodeTask::getId)
            .last("limit " + n));
    }

}