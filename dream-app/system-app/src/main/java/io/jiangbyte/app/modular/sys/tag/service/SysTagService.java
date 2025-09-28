package io.jiangbyte.app.modular.sys.tag.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.tag.entity.SysTag;
import io.jiangbyte.app.modular.sys.tag.param.SysTagAddParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagEditParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagIdParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagPageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 标签表 服务类
*/
public interface SysTagService extends IService<SysTag> {
    Page<SysTag> page(SysTagPageParam sysTagPageParam);

    void add(SysTagAddParam sysTagAddParam);

    void edit(SysTagEditParam sysTagEditParam);

    void delete(List<SysTagIdParam> sysTagIdParamList);

    SysTag detail(SysTagIdParam sysTagIdParam);

    List<SysTag> latest(int n);

    List<SysTag> topN(int n);
}