<#assign moduleName = GModule>
<#assign entityName = table.entityName?uncap_first?lower_case>
<#assign menuTitle = (table.comment!entityName)?replace("表", "") + "管理">
<#assign menuPTitle = (table.comment!entityName)?replace("表", "") + "父级管理">
<#assign pPath = "/" + moduleName>
<#assign menuPath = "/" + moduleName + "/" + entityName>
<#assign componentPath = "/" + moduleName + "/" + entityName + "/index.vue">

# ======================== ${menuTitle} ========================
# set @MENU_PID = '0';
# set @MENU_PID = UUID_SHORT();
# set @ROLE_ID = '1';

set @UNIQUENESS_ID = UUID_SHORT();

# 父级目录创建
# INSERT INTO sys_menu (id, pid, name, path, component_path, menu_type, title, sort, visible, keep_alive, created_by)
# VALUES (@MENU_PID, '0', 'p_${entityName}', '${pPath}', NULL, 0, '${menuPTitle}', 1, 1, 0, 1);
# INSERT INTO auths_role_menu (id, role_id, menu_id)
# VALUES (@MENU_PID, @ROLE_ID, @MENU_PID);

# 菜单传入
INSERT INTO sys_menu (id, pid, name, path, component_path, menu_type, title, sort, visible, keep_alive, created_by)
VALUES (@UNIQUENESS_ID, @MENU_PID, '${entityName}', '${menuPath}', '${componentPath}', 0, '${menuTitle}', 1, 1, 0, 1);

# 角色关联
INSERT INTO auths_role_menu (id, role_id, menu_id)
VALUES (@UNIQUENESS_ID, @ROLE_ID, @UNIQUENESS_ID);

#