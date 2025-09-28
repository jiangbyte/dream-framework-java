package io.jiangbyte.app.modular.sys.config.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.config.entity.SysConfig;
import io.jiangbyte.app.modular.sys.config.param.SysConfigAddParam;
import io.jiangbyte.app.modular.sys.config.param.SysConfigEditParam;
import io.jiangbyte.app.modular.sys.config.param.SysConfigIdParam;
import io.jiangbyte.app.modular.sys.config.param.SysConfigPageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 系统配置表 服务类
*/
public interface SysConfigService extends IService<SysConfig> {
    Page<SysConfig> page(SysConfigPageParam sysConfigPageParam);

    void add(SysConfigAddParam sysConfigAddParam);

    void edit(SysConfigEditParam sysConfigEditParam);

    void delete(List<SysConfigIdParam> sysConfigIdParamList);

    SysConfig detail(SysConfigIdParam sysConfigIdParam);

    List<SysConfig> latest(int n);

    List<SysConfig> topN(int n);

    String getValueByCode(String code);
}