package io.jiangbyte.app.base.system.code.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.system.code.entity.GenCodeTaskModule;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskModuleDto;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskModulePageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务模块明细表 服务类
*/
public interface GenCodeTaskModuleService extends IService<GenCodeTaskModule> {
    Page<GenCodeTaskModule> page(GenCodeTaskModulePageQuery req);

    void add(GenCodeTaskModuleDto req);

    void edit(GenCodeTaskModuleDto req);

    void delete(List<String> ids);

    GenCodeTaskModule detail(String id);

    List<GenCodeTaskModule> latest(int n);

    List<GenCodeTaskModule> topN(int n);
}