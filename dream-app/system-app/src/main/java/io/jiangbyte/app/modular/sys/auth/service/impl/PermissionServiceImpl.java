package io.jiangbyte.app.modular.sys.auth.service.impl;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import io.jiangbyte.app.modular.sys.auth.service.PermissionService;
import io.jiangbyte.app.modular.sys.menu.entity.SysMenu;
import io.jiangbyte.app.modular.sys.menu.mapper.SysMenuMapper;
import io.jiangbyte.app.modular.sys.relation.entity.SysRoleMenu;
import io.jiangbyte.app.modular.sys.relation.entity.SysUserRole;
import io.jiangbyte.app.modular.sys.relation.mapper.SysRoleMenuMapper;
import io.jiangbyte.app.modular.sys.relation.mapper.SysUserRoleMapper;
import io.jiangbyte.app.modular.sys.relation.utils.RoleLevelTool;
import io.jiangbyte.app.modular.sys.role.entity.SysRole;
import io.jiangbyte.app.modular.sys.role.mapper.SysRoleMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ZhangJiangHu
 * @version v1.0
 * @date 25/09/2025
 * @description TODO
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PermissionServiceImpl implements PermissionService {
    private final SysRoleMapper sysRoleMapper;
    private final SysUserRoleMapper sysUserRoleMapper;
    private final SysRoleMenuMapper sysRoleMenuMapper;
    private final SysMenuMapper sysMenuMapper;

    @Override
    public List<String> getPermissionList(String loginId, String loginType) {
        // 先查询全部的角色
        List<SysUserRole> list = sysUserRoleMapper.selectList(new LambdaQueryWrapper<SysUserRole>()
                .eq(SysUserRole::getUserId, loginId)
        );
        log.info("用户角色映射 {}", JSONUtil.toJsonStr(list));
        // 无角色不能
        if (ObjectUtil.isEmpty(list)) {
            return List.of();
        }

        List<String> stringList = list.stream().map(SysUserRole::getRoleId).toList();
        // 查询全部的角色实体
        List<SysRole> sysRoles = sysRoleMapper.selectByIds(stringList);
        log.info("角色列表 {}", JSONUtil.toJsonStr(sysRoles));
        SysRole highLevelRole = RoleLevelTool.getHighLevelRole(sysRoles);
        log.info("最高角色 {}", JSONUtil.toJsonStr(highLevelRole));

        List<SysRoleMenu> sysRoleMenus = sysRoleMenuMapper.selectList(new LambdaQueryWrapper<SysRoleMenu>()
                .eq(SysRoleMenu::getRoleId, highLevelRole.getId())
        );
        log.info("角色菜单映射 {}", JSONUtil.toJsonStr(sysRoleMenus));

        List<String> stringList1 = sysRoleMenus.stream().map(SysRoleMenu::getMenuId).toList();
        List<SysMenu> sysMenus = sysMenuMapper.selectByIds(stringList1);
        if (ObjectUtil.isEmpty(sysMenus)) {
            return List.of();
        }

        List<String> permissions = new ArrayList<>();
        for (SysMenu sysMenu : sysMenus) {
            if (sysMenu.getExJson() != null || ObjectUtil.isNotEmpty(sysMenu.getExJson())) {
                permissions.addAll(sysMenu.getExJson());
            }
        }

        return permissions;
    }
}
