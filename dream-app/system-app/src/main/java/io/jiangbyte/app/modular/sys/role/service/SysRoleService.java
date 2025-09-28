package io.jiangbyte.app.modular.sys.role.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.role.entity.SysRole;
import io.jiangbyte.app.modular.sys.role.param.SysRoleAddParam;
import io.jiangbyte.app.modular.sys.role.param.SysRoleEditParam;
import io.jiangbyte.app.modular.sys.role.param.SysRoleIdParam;
import io.jiangbyte.app.modular.sys.role.param.SysRolePageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 角色表 服务类
*/
public interface SysRoleService extends IService<SysRole> {
    Page<SysRole> page(SysRolePageParam sysRolePageParam);

    void add(SysRoleAddParam sysRoleAddParam);

    void edit(SysRoleEditParam sysRoleEditParam);

    void delete(List<SysRoleIdParam> sysRoleIdParamList);

    SysRole detail(SysRoleIdParam sysRoleIdParam);

    List<SysRole> latest(int n);

    List<SysRole> topN(int n);
}