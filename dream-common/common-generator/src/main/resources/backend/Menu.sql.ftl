<#assign moduleName = GModule>
<#assign entityName = table.entityName?uncap_first?lower_case>
<#assign menuTitle = (table.comment!entityName)?replace("表", "") + "管理">
<#assign menuPath = "/" + moduleName + "/" + entityName>
<#assign componentPath = "/" + moduleName + "/" + entityName + "/index.vue">

# ======================== ${menuTitle} ========================
set @MENU_PID = '0';
set @ROLE_ID = '1';

set @MENU_ID = UUID_SHORT();
set @ROLE_MENU_ID = UUID_SHORT();

INSERT INTO sys_menu (id, pid, name, path, component_path, menu_type, title, sort, visible, keep_alive, created_by)
VALUES (@MENU_ID, @MENU_PID, '${entityName}', '${menuPath}', '${componentPath}', 0, '${menuTitle}', 1, 1, 0, 1);

INSERT INTO auths_role_menu (id, role_id, menu_id)
VALUES (@ROLE_MENU_ID, @ROLE_ID, @MENU_ID);

#