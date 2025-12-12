package io.jiangbyte.app.base.systems.code.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.systems.code.entity.SysCodeTask;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskPageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务主表 服务类
*/
public interface SysCodeTaskService extends IService<SysCodeTask> {
    Page<SysCodeTask> page(SysCodeTaskPageQuery req);

    void add(SysCodeTaskDto req);

    void edit(SysCodeTaskDto req);

    void delete(List<String> ids);

    SysCodeTask detail(String id);

    List<SysCodeTask> latest(int n);

    List<SysCodeTask> topN(int n);

    List<SysCodeTask> lists();
}