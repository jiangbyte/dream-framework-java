package io.jiangbyte.app.base.systems.log.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.systems.log.entity.SysLog;
import io.jiangbyte.app.base.systems.log.dto.SysLogDto;
import io.jiangbyte.app.base.systems.log.dto.SysLogPageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 系统活动日志记录表 服务类
*/
public interface SysLogService extends IService<SysLog> {
    Page<SysLog> page(SysLogPageQuery req);

    void add(SysLogDto req);

    void edit(SysLogDto req);

    void delete(List<String> ids);

    SysLog detail(String id);

    List<SysLog> latest(int n);

    List<SysLog> topN(int n);

    List<SysLog> lists();
}