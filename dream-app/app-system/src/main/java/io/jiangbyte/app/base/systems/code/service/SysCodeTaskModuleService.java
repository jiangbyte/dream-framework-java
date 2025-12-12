package io.jiangbyte.app.base.systems.code.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.systems.code.entity.SysCodeTaskModule;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModuleDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModulePageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务模块明细表 服务类
*/
public interface SysCodeTaskModuleService extends IService<SysCodeTaskModule> {
    Page<SysCodeTaskModule> page(SysCodeTaskModulePageQuery req);

    void add(SysCodeTaskModuleDto req);

    void edit(SysCodeTaskModuleDto req);

    void delete(List<String> ids);

    SysCodeTaskModule detail(String id);

    List<SysCodeTaskModule> latest(int n);

    List<SysCodeTaskModule> topN(int n);

    List<SysCodeTaskModule> lists();
}