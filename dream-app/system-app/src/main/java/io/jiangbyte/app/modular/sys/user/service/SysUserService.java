package io.jiangbyte.app.modular.sys.user.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.user.entity.SysUser;
import io.jiangbyte.app.modular.sys.user.param.SysUserAddParam;
import io.jiangbyte.app.modular.sys.user.param.SysUserEditParam;
import io.jiangbyte.app.modular.sys.user.param.SysUserIdParam;
import io.jiangbyte.app.modular.sys.user.param.SysUserPageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 用户表 服务类
*/
public interface SysUserService extends IService<SysUser> {
    Page<SysUser> page(SysUserPageParam sysUserPageParam);

    void add(SysUserAddParam sysUserAddParam);

    void edit(SysUserEditParam sysUserEditParam);

    void delete(List<SysUserIdParam> sysUserIdParamList);

    SysUser detail(SysUserIdParam sysUserIdParam);

    List<SysUser> latest(int n);

    List<SysUser> topN(int n);
}