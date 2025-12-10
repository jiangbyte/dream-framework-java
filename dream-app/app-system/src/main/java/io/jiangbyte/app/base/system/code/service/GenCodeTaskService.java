package io.jiangbyte.app.base.system.code.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.system.code.entity.GenCodeTask;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskDto;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskPageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-10
* @description 代码生成任务主表 服务类
*/
public interface GenCodeTaskService extends IService<GenCodeTask> {
    Page<GenCodeTask> page(GenCodeTaskPageQuery req);

    void add(GenCodeTaskDto req);

    void edit(GenCodeTaskDto req);

    void delete(List<String> ids);

    GenCodeTask detail(String id);

    List<GenCodeTask> latest(int n);

    List<GenCodeTask> topN(int n);

    void genCode(String id);
}