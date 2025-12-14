/*
 Navicat Premium Dump SQL

 Source Server         : mysql-dev
 Source Server Type    : MySQL
 Source Server Version : 90500 (9.5.0)
 Source Host           : localhost:3306
 Source Schema         : dream_db

 Target Server Type    : MySQL
 Target Server Version : 90500 (9.5.0)
 File Encoding         : 65001

 Date: 14/12/2025 19:06:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auths_account
-- ----------------------------
DROP TABLE IF EXISTS `auths_account`;
CREATE TABLE `auths_account`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名，登录标识',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '加密后的密码',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `telephone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  `status` smallint NULL DEFAULT 0 COMMENT '账户状态：0-正常, 1-锁定, 2-禁用',
  `password_strength` smallint NULL DEFAULT 0 COMMENT '密码强度等级：0-3',
  `last_password_change` timestamp NULL DEFAULT NULL COMMENT '最后修改密码的时间',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后登录IP地址',
  `login_count` int NULL DEFAULT 0 COMMENT '登录次数统计',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_account_username`(`username` ASC) USING BTREE,
  INDEX `idx_account_email`(`email` ASC) USING BTREE,
  INDEX `idx_account_telephone`(`telephone` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '核心账户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_account
-- ----------------------------
INSERT INTO `auths_account` VALUES ('1', 'superadmin', '$2a$10$GO4/.3q0l/d/HWYaGKM2d.C4H.ZJmF4RhKVpFlC3sLuzFddlyucmK', 'jiangbyte@163.com', NULL, 0, 1, '2025-11-26 14:08:50', '2025-12-14 19:01:02', '127.0.0.1', 49, 0, NULL, NULL, '2025-11-25 09:22:21', NULL, '2025-12-14 19:01:02', NULL);
INSERT INTO `auths_account` VALUES ('1993255249205997569', 'menus', '$2a$10$wvXNOmOZ8fW1ipstwjgu4OC2IM1/cJLNV0rTHnENtveDOEUcr26Cm', '3317229064@qq.com', NULL, 0, 0, NULL, '2025-11-25 17:47:54', NULL, 0, 0, NULL, NULL, '2025-11-25 17:47:39', NULL, '2025-11-25 17:47:54', NULL);
INSERT INTO `auths_account` VALUES ('2', 'admin', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'admin@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:23', NULL, '2025-11-25 09:22:23', NULL);
INSERT INTO `auths_account` VALUES ('3', 'deptadmin', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'dept_admin@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:27', NULL, '2025-11-25 09:22:27', NULL);
INSERT INTO `auths_account` VALUES ('4', 'zhangsan', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'zhangsan@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:32', NULL, '2025-11-25 09:22:32', NULL);
INSERT INTO `auths_account` VALUES ('5', 'lisi', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'lisi@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:36', NULL, '2025-11-25 09:22:36', NULL);
INSERT INTO `auths_account` VALUES ('6', 'wangwu', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'wangwu@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:41', NULL, '2025-11-25 09:22:41', NULL);
INSERT INTO `auths_account` VALUES ('7', 'zhaoliu', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'zhaoliu@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:45', NULL, '2025-11-25 09:22:45', NULL);
INSERT INTO `auths_account` VALUES ('8', 'sunqi', '$2a$10$eE2quG/tVgyPBeHfA7EQyOYBd36hpxBEVK6wh/HdAV9Nd9Wh.MjGi', 'sunqi@company.com', NULL, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, '2025-11-25 09:22:49', NULL, '2025-11-25 09:22:49', NULL);

-- ----------------------------
-- Table structure for auths_account_group
-- ----------------------------
DROP TABLE IF EXISTS `auths_account_group`;
CREATE TABLE `auths_account_group`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `group_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_account_role_account`(`account_id` ASC) USING BTREE,
  INDEX `idx_account_role_group`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '账户用户组关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_account_group
-- ----------------------------
INSERT INTO `auths_account_group` VALUES ('1', '1', '1993559342860390401');

-- ----------------------------
-- Table structure for auths_account_role
-- ----------------------------
DROP TABLE IF EXISTS `auths_account_role`;
CREATE TABLE `auths_account_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_account_role_account`(`account_id` ASC) USING BTREE,
  INDEX `idx_account_role_role`(`role_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '账户角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_account_role
-- ----------------------------
INSERT INTO `auths_account_role` VALUES ('1', '1', '1');
INSERT INTO `auths_account_role` VALUES ('2', '2', '2');
INSERT INTO `auths_account_role` VALUES ('3', '3', '3');
INSERT INTO `auths_account_role` VALUES ('4', '4', '4');
INSERT INTO `auths_account_role` VALUES ('5', '5', '4');
INSERT INTO `auths_account_role` VALUES ('6', '6', '4');
INSERT INTO `auths_account_role` VALUES ('7', '7', '4');
INSERT INTO `auths_account_role` VALUES ('8', '8', '4');

-- ----------------------------
-- Table structure for auths_group
-- ----------------------------
DROP TABLE IF EXISTS `auths_group`;
CREATE TABLE `auths_group`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `pid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '父级组ID',
  `pid_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '父级组路径',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户组名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户组编码',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户组描述',
  `sort` smallint NULL DEFAULT 99 COMMENT '排序号，数字越小越靠前',
  `admin_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '管理员ID',
  `max_user_count` int NULL DEFAULT NULL COMMENT '最大用户数量限制',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_group_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_group
-- ----------------------------
INSERT INTO `auths_group` VALUES ('1993559342860390401', '0', NULL, '默认用户组', 'DEFAULT', '默认用户组', 0, NULL, NULL, 0, NULL, NULL, '2025-11-26 13:56:01', NULL, '2025-12-11 22:25:29', NULL);
INSERT INTO `auths_group` VALUES ('2000141845662466050', '0', '0', '123', '123', '123', 4, '', 2, 0, NULL, NULL, '2025-12-14 17:52:32', NULL, '2025-12-14 17:52:32', NULL);
INSERT INTO `auths_group` VALUES ('2000141923894624258', '0', '0', '456', '456', '456', 3, '', 1, 0, NULL, NULL, '2025-12-14 17:52:50', NULL, '2025-12-14 17:52:50', NULL);
INSERT INTO `auths_group` VALUES ('2000143355616083969', '2000141923894624258', '0,2000141923894624258', '098', '0978', '0978', 5, '', 7, 0, NULL, NULL, '2025-12-14 17:58:32', NULL, '2025-12-14 17:58:51', NULL);
INSERT INTO `auths_group` VALUES ('2000143539897024514', '2000141845662466050', '0,2000141845662466050', '543234', '54234234', '542324', 8, '', 3, 0, NULL, NULL, '2025-12-14 17:59:15', NULL, '2025-12-14 17:59:37', NULL);

-- ----------------------------
-- Table structure for auths_role
-- ----------------------------
DROP TABLE IF EXISTS `auths_role`;
CREATE TABLE `auths_role`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色编码',
  `data_scope` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '数据权限范围',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色描述',
  `assign_group_ids` json NULL COMMENT '分配的用户组ID列表(JSON数组)',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_role
-- ----------------------------
INSERT INTO `auths_role` VALUES ('1', '超级管理员', 'SUPER_ADMIN', 'ALL', '系统超级管理员，拥有所有权限', NULL, 0, NULL, NULL, '2025-11-25 09:22:19', NULL, '2025-11-25 09:22:19', NULL);
INSERT INTO `auths_role` VALUES ('2', '系统管理员', 'ADMIN', 'GROUP_AND_CHILD', '系统管理员，拥有大部分管理权限', NULL, 0, NULL, NULL, '2025-11-25 09:22:19', NULL, '2025-11-25 09:22:19', NULL);
INSERT INTO `auths_role` VALUES ('3', '部门管理员', 'GROUP_ADMIN', 'GROUP', '部门管理员，管理本部门用户和权限', NULL, 0, NULL, NULL, '2025-11-25 09:22:19', NULL, '2025-11-25 09:22:19', NULL);
INSERT INTO `auths_role` VALUES ('4', '普通用户', 'USER', 'SELF', '普通用户，只能查看和操作自己的数据', NULL, 0, NULL, NULL, '2025-11-25 09:22:19', NULL, '2025-11-25 09:22:19', NULL);

-- ----------------------------
-- Table structure for auths_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `auths_role_menu`;
CREATE TABLE `auths_role_menu`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `role_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色ID',
  `menu_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_role_menu_role`(`role_id` ASC) USING BTREE,
  INDEX `idx_role_menu_menu`(`menu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auths_role_menu
-- ----------------------------
INSERT INTO `auths_role_menu` VALUES ('1000', '1', '1000');
INSERT INTO `auths_role_menu` VALUES ('1001', '1', '1001');
INSERT INTO `auths_role_menu` VALUES ('101681065508208678', '1', '101681065508208678');
INSERT INTO `auths_role_menu` VALUES ('101681065508208679', '1', '101681065508208679');
INSERT INTO `auths_role_menu` VALUES ('101681065508208680', '1', '101681065508208680');
INSERT INTO `auths_role_menu` VALUES ('101681065508208681', '1', '101681065508208681');
INSERT INTO `auths_role_menu` VALUES ('101681065508208682', '1', '101681065508208682');
INSERT INTO `auths_role_menu` VALUES ('101681065508208683', '1', '101681065508208683');
INSERT INTO `auths_role_menu` VALUES ('101681065508208684', '1', '101681065508208684');
INSERT INTO `auths_role_menu` VALUES ('101681065508208685', '1', '101681065508208685');
INSERT INTO `auths_role_menu` VALUES ('101681065508208686', '1', '101681065508208686');
INSERT INTO `auths_role_menu` VALUES ('101681065508208687', '1', '101681065508208687');
INSERT INTO `auths_role_menu` VALUES ('101681065508208688', '1', '101681065508208688');
INSERT INTO `auths_role_menu` VALUES ('101681065508208689', '1', '101681065508208689');
INSERT INTO `auths_role_menu` VALUES ('101681065508208690', '1', '101681065508208690');
INSERT INTO `auths_role_menu` VALUES ('101681065508208691', '1', '101681065508208691');
INSERT INTO `auths_role_menu` VALUES ('101681065508208692', '1', '101681065508208692');
INSERT INTO `auths_role_menu` VALUES ('101681065508208693', '1', '101681065508208693');
INSERT INTO `auths_role_menu` VALUES ('101681065508208694', '1', '101681065508208694');
INSERT INTO `auths_role_menu` VALUES ('101681065508208695', '1', '101681065508208695');
INSERT INTO `auths_role_menu` VALUES ('101681065508208696', '1', '101681065508208696');
INSERT INTO `auths_role_menu` VALUES ('101681065508208697', '1', '101681065508208697');
INSERT INTO `auths_role_menu` VALUES ('101681065508208698', '1', '101681065508208698');

-- ----------------------------
-- Table structure for config_group
-- ----------------------------
DROP TABLE IF EXISTS `config_group`;
CREATE TABLE `config_group`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组代码',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分组描述',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统分组',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_config_group_code`(`code` ASC) USING BTREE COMMENT '分组代码唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '配置分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_group
-- ----------------------------
INSERT INTO `config_group` VALUES ('1', '网站配置', 'WEBSITE', '网站基础信息配置', 1, 1, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);

-- ----------------------------
-- Table structure for config_item
-- ----------------------------
DROP TABLE IF EXISTS `config_item`;
CREATE TABLE `config_item`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `group_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置项名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置项代码',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置值',
  `component_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件类型',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配置描述',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_item_group_code`(`group_code` ASC) USING BTREE,
  INDEX `idx_config_item_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_item
-- ----------------------------
INSERT INTO `config_item` VALUES ('1', 'WEBSITE', '网站名称', 'WEBSITE_NAME', 'Dream Framework', 'input', '网站的名称', 1, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 14:39:02', NULL);
INSERT INTO `config_item` VALUES ('10', 'WEBSITE', '微信联系方式', 'CONTACT_WECHAT', '', 'input', '微信联系方式', 10, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('11', 'WEBSITE', '社交媒体链接', 'SOCIAL_LINKS', '[{\"image\": \"/static/images/github.png\", \"title\": \"GitHub\", \"url\": \"https://github.com/galaxy-cms\"}]', 'json-editor', '社交媒体链接配置，JSON格式', 11, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('2', 'WEBSITE', '网站Logo', 'WEBSITE_LOGO', '/static/images/logo.png', 'upload', '网站的Logo图片路径', 2, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('3', 'WEBSITE', '网站描述', 'WEBSITE_DESCRIPTION', '一个个人用的基础脚手架，基于 Java/Go/Python 语言开发', 'textarea', '网站的简要描述', 3, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 15:19:21', NULL);
INSERT INTO `config_item` VALUES ('4', 'WEBSITE', '网站关键字', 'WEBSITE_KEYWORDS', 'CMS,内容管理,Go,Golang,Galaxy', 'input', '网站SEO关键字，用逗号分隔', 4, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('5', 'WEBSITE', '网站作者', 'WEBSITE_AUTHOR', 'Galaxy Team', 'input', '网站的作者或开发团队', 5, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('6', 'WEBSITE', '版权信息', 'WEBSITE_COPYRIGHT', '© 2025 Charlie Zhang. All Rights Reserved.', 'input', '网站版权信息', 6, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 14:38:18', NULL);
INSERT INTO `config_item` VALUES ('7', 'WEBSITE', '网站版本', 'WEBSITE_VERSION', '1.1.0', 'input', '网站的版本号', 7, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('8', 'WEBSITE', 'QQ联系方式', 'CONTACT_QQ', '', 'input', 'QQ联系方式', 8, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `config_item` VALUES ('9', 'WEBSITE', '联系邮箱', 'CONTACT_EMAIL', 'contact@galaxy-cms.com', 'input', '网站联系邮箱', 9, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);

-- ----------------------------
-- Table structure for configs_group
-- ----------------------------
DROP TABLE IF EXISTS `configs_group`;
CREATE TABLE `configs_group`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组代码',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分组描述',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `is_system` tinyint(1) NULL DEFAULT 0 COMMENT '是否系统分组',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_config_group_code`(`code` ASC) USING BTREE COMMENT '分组代码唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '配置分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of configs_group
-- ----------------------------
INSERT INTO `configs_group` VALUES ('1', '网站配置', 'WEBSITE', '网站基础信息配置', 1, 1, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);

-- ----------------------------
-- Table structure for configs_item
-- ----------------------------
DROP TABLE IF EXISTS `configs_item`;
CREATE TABLE `configs_item`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `group_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分组编码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置项名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置项代码',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置值',
  `component_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件类型',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '配置描述',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_config_item_group_code`(`group_code` ASC) USING BTREE,
  INDEX `idx_config_item_code`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of configs_item
-- ----------------------------
INSERT INTO `configs_item` VALUES ('1', 'WEBSITE', '网站名称', 'WEBSITE_NAME', 'Dream Framework', 'input', '网站的名称', 1, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 14:39:02', NULL);
INSERT INTO `configs_item` VALUES ('10', 'WEBSITE', '微信联系方式', 'CONTACT_WECHAT', '', 'input', '微信联系方式', 10, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('11', 'WEBSITE', '社交媒体链接', 'SOCIAL_LINKS', '[{\"image\": \"/static/images/github.png\", \"title\": \"GitHub\", \"url\": \"https://github.com/galaxy-cms\"}]', 'json-editor', '社交媒体链接配置，JSON格式', 11, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('2', 'WEBSITE', '网站Logo', 'WEBSITE_LOGO', '/static/images/logo.png', 'upload', '网站的Logo图片路径', 2, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('3', 'WEBSITE', '网站描述', 'WEBSITE_DESCRIPTION', '一个个人用的基础脚手架，基于 Java/Go/Python 语言开发', 'textarea', '网站的简要描述', 3, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 15:19:21', NULL);
INSERT INTO `configs_item` VALUES ('4', 'WEBSITE', '网站关键字', 'WEBSITE_KEYWORDS', 'CMS,内容管理,Go,Golang,Galaxy', 'input', '网站SEO关键字，用逗号分隔', 4, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('5', 'WEBSITE', '网站作者', 'WEBSITE_AUTHOR', 'Galaxy Team', 'input', '网站的作者或开发团队', 5, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('6', 'WEBSITE', '版权信息', 'WEBSITE_COPYRIGHT', '© 2025 Charlie Zhang. All Rights Reserved.', 'input', '网站版权信息', 6, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 14:38:18', NULL);
INSERT INTO `configs_item` VALUES ('7', 'WEBSITE', '网站版本', 'WEBSITE_VERSION', '1.1.0', 'input', '网站的版本号', 7, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('8', 'WEBSITE', 'QQ联系方式', 'CONTACT_QQ', '', 'input', 'QQ联系方式', 8, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);
INSERT INTO `configs_item` VALUES ('9', 'WEBSITE', '联系邮箱', 'CONTACT_EMAIL', 'contact@galaxy-cms.com', 'input', '网站联系邮箱', 9, 0, NULL, NULL, '2025-11-25 09:22:17', NULL, '2025-11-25 09:22:17', NULL);

-- ----------------------------
-- Table structure for gen_code_task
-- ----------------------------
DROP TABLE IF EXISTS `gen_code_task`;
CREATE TABLE `gen_code_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称，如：系统模块代码生成',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作者',
  `output_dir` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代码输出目录',
  `db_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库JDBC URL',
  `db_username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库用户名',
  `db_password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据库密码（建议加密或留空）',
  `database_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库名',
  `add_backend` tinyint NULL DEFAULT 1 COMMENT '生成后端：1-是，0-否',
  `add_frontend` tinyint NULL DEFAULT 1 COMMENT '生成后端：1-是，0-否',
  `executed_at` datetime NULL DEFAULT NULL COMMENT '实际执行时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-待执行，1-成功，2-失败',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_author`(`author` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成任务主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_code_task
-- ----------------------------

-- ----------------------------
-- Table structure for gen_code_task_module
-- ----------------------------
DROP TABLE IF EXISTS `gen_code_task_module`;
CREATE TABLE `gen_code_task_module`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL COMMENT '关联 gen_code_task.id',
  `module_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模块类型，如：biz, sys, auth',
  `package_path` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Java 包路径',
  `table_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '表名称，如：biz_normal_category',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成任务模块明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_code_task_module
-- ----------------------------

-- ----------------------------
-- Table structure for sys_code_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_code_task`;
CREATE TABLE `sys_code_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `task_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称，如：系统模块代码生成',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作者',
  `output_dir` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代码输出目录',
  `db_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库JDBC URL',
  `db_username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库用户名',
  `db_password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '数据库密码（建议加密或留空）',
  `database_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据库名',
  `add_backend` tinyint NULL DEFAULT 1 COMMENT '生成后端：1-是，0-否',
  `add_frontend` tinyint NULL DEFAULT 1 COMMENT '生成后端：1-是，0-否',
  `executed_at` datetime NULL DEFAULT NULL COMMENT '实际执行时间',
  `status` tinyint NULL DEFAULT 0 COMMENT '状态：0-待执行，1-成功，2-失败',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_author`(`author` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成任务主表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_code_task
-- ----------------------------

-- ----------------------------
-- Table structure for sys_code_task_module
-- ----------------------------
DROP TABLE IF EXISTS `sys_code_task_module`;
CREATE TABLE `sys_code_task_module`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL COMMENT '关联 gen_code_task.id',
  `module_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模块类型，如：biz, sys, auth',
  `package_path` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Java 包路径',
  `table_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '表名称，如：biz_normal_category',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成任务模块明细表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_code_task_module
-- ----------------------------

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `dict_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典类型',
  `type_label` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型标签',
  `dict_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字典值',
  `dict_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '字典标签',
  `sort` int NULL DEFAULT 0 COMMENT '排序号',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统字典表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1991796032439787522', 'SYS_BOOLEAN', '布尔', 'true', '是', 1, 0, NULL, NULL, '2025-11-21 17:09:14', '1', '2025-11-21 17:36:08', '1');
INSERT INTO `sys_dict` VALUES ('1991798667876143106', 'SYS_BOOLEAN', '布尔', 'false', '否', 2, 0, NULL, NULL, '2025-11-21 17:19:42', '1', '2025-11-21 17:36:15', '1');
INSERT INTO `sys_dict` VALUES ('1991806439812411393', 'SYS_GENDER', '性别', '0', '未知', 1, 0, NULL, NULL, '2025-11-21 17:50:36', '1', '2025-11-21 17:50:36', '1');
INSERT INTO `sys_dict` VALUES ('1991806502106214402', 'SYS_GENDER', '性别', '1', '男', 2, 0, NULL, NULL, '2025-11-21 17:50:51', '1', '2025-11-21 17:50:51', '1');
INSERT INTO `sys_dict` VALUES ('1991806537300619265', 'SYS_GENDER', '性别', '2', '女', 3, 0, NULL, NULL, '2025-11-21 17:50:59', '1', '2025-11-21 17:50:59', '1');
INSERT INTO `sys_dict` VALUES ('1991807086897049601', 'SYS_MENU_TYPE', '菜单类型', '0', '内部菜单', 1, 0, NULL, NULL, '2025-11-21 17:53:10', '1', '2025-12-12 03:08:22', '1');
INSERT INTO `sys_dict` VALUES ('1991807169059270657', 'SYS_MENU_TYPE', '菜单类型', '1', '外部菜单', 2, 0, NULL, NULL, '2025-11-21 17:53:30', '1', '2025-12-12 03:08:22', '1');
INSERT INTO `sys_dict` VALUES ('1991807231617314818', 'SYS_MENU_TYPE', '菜单类型', '2', '重定向菜单', 3, 0, NULL, NULL, '2025-11-21 17:53:45', '1', '2025-12-12 03:08:23', '1');
INSERT INTO `sys_dict` VALUES ('1991807311690772481', 'SYS_MENU_TYPE', '菜单类型', '3', 'Iframe嵌入', 4, 0, NULL, NULL, '2025-11-21 17:54:04', '1', '2025-12-12 03:08:24', '1');
INSERT INTO `sys_dict` VALUES ('1991807706479636481', 'SYS_OPEN_TARGET', '打开方式', '0', '当前窗口', 1, 0, NULL, NULL, '2025-11-21 17:55:38', '1', '2025-12-12 03:19:56', '1');
INSERT INTO `sys_dict` VALUES ('1991807767821332482', 'SYS_OPEN_TARGET', '打开方式', '1', '新窗口打开', 2, 0, NULL, NULL, '2025-11-21 17:55:53', '1', '2025-12-12 03:19:57', '1');
INSERT INTO `sys_dict` VALUES ('1993294975594102785', 'SYS_ACCOUNT_STATUS', '账户状态', '0', '正常', 1, 0, NULL, NULL, '2025-11-25 20:25:30', NULL, '2025-11-25 20:25:30', NULL);
INSERT INTO `sys_dict` VALUES ('1993295048461746177', 'SYS_ACCOUNT_STATUS', '账户状态', '1', '锁定', 2, 0, NULL, NULL, '2025-11-25 20:25:48', NULL, '2025-11-25 20:25:48', NULL);
INSERT INTO `sys_dict` VALUES ('1993295131907424258', 'SYS_ACCOUNT_STATUS', '账户状态', '2', '禁用', 3, 0, NULL, NULL, '2025-11-25 20:26:08', NULL, '2025-11-25 20:26:13', NULL);
INSERT INTO `sys_dict` VALUES ('1999109237272993793', 'TEST', 'TEST', 'TEST1', 'TEST1', 1, 0, NULL, NULL, '2025-12-11 21:29:18', NULL, '2025-12-11 21:29:18', NULL);
INSERT INTO `sys_dict` VALUES ('1999109280595959809', 'TEST', 'TEST', 'TEST2', 'TEST2', 2, 0, NULL, NULL, '2025-12-11 21:29:29', NULL, '2025-12-11 21:29:29', NULL);
INSERT INTO `sys_dict` VALUES ('1999111186613493761', 'SYS_DATA_SCOPE', '数据权限', 'ALL', '全部范围', 1, 0, NULL, NULL, '2025-12-11 21:37:03', NULL, '2025-12-12 03:08:35', NULL);
INSERT INTO `sys_dict` VALUES ('1999111359209103362', 'SYS_DATA_SCOPE', '数据权限', 'GROUP_AND_CHILD', '组和子组', 2, 0, NULL, NULL, '2025-12-11 21:37:44', NULL, '2025-12-12 03:08:35', NULL);
INSERT INTO `sys_dict` VALUES ('1999111403240906754', 'SYS_DATA_SCOPE', '数据权限', 'GROUP', '本组范围', 3, 0, NULL, NULL, '2025-12-11 21:37:55', NULL, '2025-12-12 03:08:37', NULL);
INSERT INTO `sys_dict` VALUES ('1999111457850744834', 'SYS_DATA_SCOPE', '数据权限', 'SELF', '本人数据', 4, 0, NULL, NULL, '2025-12-11 21:38:08', NULL, '2025-12-12 03:08:36', NULL);
INSERT INTO `sys_dict` VALUES ('1999316534091796482', 'SYS_CRYPTOGRAPHIC_STRENGTH', '密码强度', '1', '弱', 1, 0, NULL, NULL, '2025-12-12 11:13:02', NULL, '2025-12-12 11:13:02', NULL);
INSERT INTO `sys_dict` VALUES ('2000136395260874753', 'SYS_DATA_SCOPE', '数据权限', 'CUSTOM', '自定义', 5, 0, NULL, NULL, '2025-12-14 17:30:52', NULL, '2025-12-14 17:30:52', NULL);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户ID',
  `operation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作类型',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求参数',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `operation_time` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '日志分类',
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作模块',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作描述',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作状态',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '日志消息',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统活动日志记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `pid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '父级ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单路径',
  `component_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件路径',
  `redirect` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '重定向路径',
  `external_url` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '外部链接地址',
  `menu_type` int NULL DEFAULT 0 COMMENT '菜单类型：0-内部菜单 1-外链菜单 2-重定向菜单 3-iframe嵌入',
  `open_target` int NULL DEFAULT 0 COMMENT '打开方式：0-当前窗口 1-新窗口打开',
  `iframe_attrs` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'iframe属性',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单标题',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `sort` int NULL DEFAULT 0 COMMENT '排序',
  `keep_alive` tinyint(1) NULL DEFAULT 0 COMMENT '缓存',
  `visible` tinyint(1) NULL DEFAULT 1 COMMENT '可见',
  `pined` tinyint(1) NULL DEFAULT 0 COMMENT '钉钉',
  `without_tab` tinyint(1) NULL DEFAULT 0 COMMENT '无标签页',
  `parameters` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头部参数',
  `extra_params` json NULL COMMENT '路由参数',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sys_menu_name`(`name` ASC) USING BTREE,
  INDEX `idx_sys_menu_path`(`path` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1000', '0', 'dashboard', '/dashboard', '/dashboard/index.vue', NULL, NULL, 0, 0, NULL, '仪表盘', 'dashboard', 1, 1, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-11-19 02:41:47', NULL, '2025-12-12 07:39:29', NULL);
INSERT INTO `sys_menu` VALUES ('1001', '0', '404', '/code/404', '/code/404.vue', NULL, NULL, 0, 0, NULL, '404页面', 'battery', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-11-19 02:41:47', NULL, '2025-12-14 07:19:03', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208678', '0', 'p_authsaccountgroup', '/auths', NULL, NULL, NULL, 0, 0, NULL, '基础账户', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:03:43', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208679', '101681065508208678', 'authsaccountgroup', '/auths/authsaccountgroup', '/auths/authsaccountgroup/index.vue', NULL, NULL, 0, 0, NULL, '账户用户组关联', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:06:19', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208680', '101681065508208678', 'authsaccount', '/auths/authsaccount', '/auths/authsaccount/index.vue', NULL, NULL, 0, 0, NULL, '核心账户管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:03:51', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208681', '101681065508208678', 'authsaccountrole', '/auths/authsaccountrole', '/auths/authsaccountrole/index.vue', NULL, NULL, 0, 0, NULL, '账户角色关联', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:06:26', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208682', '101681065508208678', 'authsgroup', '/auths/authsgroup', '/auths/authsgroup/index.vue', NULL, NULL, 0, 0, NULL, '用户组管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:03:52', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208683', '101681065508208678', 'authsrole', '/auths/authsrole', '/auths/authsrole/index.vue', NULL, NULL, 0, 0, NULL, '角色管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:03:52', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208684', '101681065508208678', 'authsrolemenu', '/auths/authsrolemenu', '/auths/authsrolemenu/index.vue', NULL, NULL, 0, 0, NULL, '角色菜单关联', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:43', '1', '2025-12-14 11:06:29', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208685', '0', 'p_configsgroup', '/configs', NULL, NULL, NULL, 0, 0, NULL, '配置分组', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:46', '1', '2025-12-14 11:03:53', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208686', '101681065508208685', 'configsgroup', '/configs/configsgroup', '/configs/configsgroup/index.vue', NULL, NULL, 0, 0, NULL, '配置分组管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:46', '1', '2025-12-14 11:03:53', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208687', '101681065508208685', 'configsitem', '/configs/configsitem', '/configs/configsitem/index.vue', NULL, NULL, 0, 0, NULL, '系统配置管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:46', '1', '2025-12-14 11:03:53', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208688', '0', 'p_syscodetask', '/systems', NULL, NULL, NULL, 0, 0, NULL, '基础系统', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:54', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208689', '101681065508208688', 'syscodetask', '/systems/syscodetask', '/systems/syscodetask/index.vue', NULL, NULL, 0, 0, NULL, '代码生成任务主管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:54', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208690', '101681065508208688', 'syscodetaskmodule', '/systems/syscodetaskmodule', '/systems/syscodetaskmodule/index.vue', NULL, NULL, 0, 0, NULL, '代码生成任务模块明细管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:54', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208691', '101681065508208688', 'sysdict', '/systems/sysdict', '/systems/sysdict/index.vue', NULL, NULL, 0, 0, NULL, '系统字典管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:55', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208692', '101681065508208688', 'syslog', '/systems/syslog', '/systems/syslog/index.vue', NULL, NULL, 0, 0, NULL, '系统活动日志记录管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:55', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208693', '101681065508208688', 'sysmenu', '/systems/sysmenu', '/systems/sysmenu/index.vue', NULL, NULL, 0, 0, NULL, '菜单管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:50', '1', '2025-12-14 11:03:55', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208694', '0', 'p_usersinfo', '/users', NULL, NULL, NULL, 0, 0, NULL, '用户信息', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:53', '1', '2025-12-14 11:03:55', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208695', '101681065508208694', 'usersinfo', '/users/usersinfo', '/users/usersinfo/index.vue', NULL, NULL, 0, 0, NULL, '用户基本信息管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:53', '1', '2025-12-14 11:03:56', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208696', '101681065508208694', 'userspreference', '/users/userspreference', '/users/userspreference/index.vue', NULL, NULL, 0, 0, NULL, '用户偏好设置管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:53', '1', '2025-12-14 11:03:56', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208697', '101681065508208694', 'usersprofile', '/users/usersprofile', '/users/usersprofile/index.vue', NULL, NULL, 0, 0, NULL, '用户档案详情管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:53', '1', '2025-12-14 11:03:56', NULL);
INSERT INTO `sys_menu` VALUES ('101681065508208698', '101681065508208694', 'usersstats', '/users/usersstats', '/users/usersstats/index.vue', NULL, NULL, 0, 0, NULL, '用户统计信息管理', 'app', 1, 0, 1, 0, 0, NULL, NULL, 0, NULL, NULL, '2025-12-14 09:06:53', '1', '2025-12-14 11:03:57', NULL);

-- ----------------------------
-- Table structure for users_info
-- ----------------------------
DROP TABLE IF EXISTS `users_info`;
CREATE TABLE `users_info`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` smallint NULL DEFAULT 0 COMMENT '性别：0-未知 1-男 2-女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `signature` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个性签名',
  `background` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人背景图片',
  `interests` json NULL COMMENT '兴趣标签',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人网站',
  `github` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'GitHub',
  `gitee` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'GitTee',
  `blog` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '博客',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_users_info_account`(`account_id` ASC) USING BTREE,
  INDEX `idx_users_info_nickname`(`nickname` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户基本信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_info
-- ----------------------------
INSERT INTO `users_info` VALUES ('1', '1', '超级管理员', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:21', NULL, '2025-11-25 09:22:21', NULL);
INSERT INTO `users_info` VALUES ('1993255249856114689', '1993255249205997569', 'menus', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 17:47:39', NULL, '2025-11-25 17:47:39', NULL);
INSERT INTO `users_info` VALUES ('2', '2', '系统管理员', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:24', NULL, '2025-11-25 09:22:24', NULL);
INSERT INTO `users_info` VALUES ('3', '3', '技术部经理', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:28', NULL, '2025-11-25 09:22:28', NULL);
INSERT INTO `users_info` VALUES ('4', '4', '张三', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:33', NULL, '2025-11-25 09:22:33', NULL);
INSERT INTO `users_info` VALUES ('5', '5', '李四', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:37', NULL, '2025-11-25 09:22:37', NULL);
INSERT INTO `users_info` VALUES ('6', '6', '王五', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:41', NULL, '2025-11-25 09:22:41', NULL);
INSERT INTO `users_info` VALUES ('7', '7', '赵六', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:46', NULL, '2025-11-25 09:22:46', NULL);
INSERT INTO `users_info` VALUES ('8', '8', '孙七', 'https://ts1.tc.mm.bing.net/th/id/R-C.6a6d08e2769800fe626bdf3ccbd7b2bf?rik=f2hCf09zz%2f9k3w&riu=http%3a%2f%2fpic.imeitou.com%2fuploads%2fallimg%2f240318%2f10-24031Q62553.jpg&ehk=xiruSwoAcF8DeN%2bzMk5g%2bRv%2baNwdPsxj4YUV4CLEe2A%3d&risl=&pid=ImgRaw&r=0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2025-11-25 09:22:50', NULL, '2025-11-25 09:22:50', NULL);

-- ----------------------------
-- Table structure for users_preference
-- ----------------------------
DROP TABLE IF EXISTS `users_preference`;
CREATE TABLE `users_preference`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `theme` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'light' COMMENT '主题',
  `language` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'zh-CN' COMMENT '系统语言',
  `email_notifications` tinyint(1) NULL DEFAULT 1 COMMENT '邮件通知',
  `push_notifications` tinyint(1) NULL DEFAULT 1 COMMENT '推送通知',
  `allow_direct_message` tinyint(1) NULL DEFAULT 1 COMMENT '允许私信',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_users_preference_account`(`account_id` ASC) USING BTREE COMMENT '账户ID唯一索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户偏好设置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_preference
-- ----------------------------
INSERT INTO `users_preference` VALUES ('1', '1', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:22', NULL, '2025-11-25 09:22:22', NULL);
INSERT INTO `users_preference` VALUES ('1993255250665615361', '1993255249205997569', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 17:47:39', NULL, '2025-11-25 17:47:39', NULL);
INSERT INTO `users_preference` VALUES ('2', '2', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:25', NULL, '2025-11-25 09:22:25', NULL);
INSERT INTO `users_preference` VALUES ('3', '3', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:30', NULL, '2025-11-25 09:22:30', NULL);
INSERT INTO `users_preference` VALUES ('4', '4', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:34', NULL, '2025-11-25 09:22:34', NULL);
INSERT INTO `users_preference` VALUES ('5', '5', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:39', NULL, '2025-11-25 09:22:39', NULL);
INSERT INTO `users_preference` VALUES ('6', '6', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:43', NULL, '2025-11-25 09:22:43', NULL);
INSERT INTO `users_preference` VALUES ('7', '7', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:47', NULL, '2025-11-25 09:22:47', NULL);
INSERT INTO `users_preference` VALUES ('8', '8', 'light', 'zh-CN', 1, 1, 1, 0, NULL, NULL, '2025-11-25 09:22:51', NULL, '2025-11-25 09:22:51', NULL);

-- ----------------------------
-- Table structure for users_profile
-- ----------------------------
DROP TABLE IF EXISTS `users_profile`;
CREATE TABLE `users_profile`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `school` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学校',
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '专业',
  `student_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '学号',
  `company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公司',
  `job_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职位',
  `industry` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '行业',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国家',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '城市',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '详细地址',
  `qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信',
  `show_birthday` tinyint(1) NULL DEFAULT 0 COMMENT '是否显示生日',
  `show_location` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示地理位置',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_users_profile_account`(`account_id` ASC) USING BTREE COMMENT '账户ID唯一索引',
  INDEX `idx_users_profile_location`(`country` ASC, `province` ASC, `city` ASC) USING BTREE COMMENT '地理位置联合索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户档案详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_profile
-- ----------------------------
INSERT INTO `users_profile` VALUES ('1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:22', NULL, '2025-11-25 09:22:22', NULL);
INSERT INTO `users_profile` VALUES ('1993255252259450881', '1993255249205997569', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 17:47:40', NULL, '2025-11-25 17:47:40', NULL);
INSERT INTO `users_profile` VALUES ('2', '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:24', NULL, '2025-11-25 09:22:24', NULL);
INSERT INTO `users_profile` VALUES ('3', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:29', NULL, '2025-11-25 09:22:29', NULL);
INSERT INTO `users_profile` VALUES ('4', '4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:34', NULL, '2025-11-25 09:22:34', NULL);
INSERT INTO `users_profile` VALUES ('5', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:38', NULL, '2025-11-25 09:22:38', NULL);
INSERT INTO `users_profile` VALUES ('6', '6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:42', NULL, '2025-11-25 09:22:42', NULL);
INSERT INTO `users_profile` VALUES ('7', '7', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:46', NULL, '2025-11-25 09:22:46', NULL);
INSERT INTO `users_profile` VALUES ('8', '8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, NULL, NULL, '2025-11-25 09:22:51', NULL, '2025-11-25 09:22:51', NULL);

-- ----------------------------
-- Table structure for users_stats
-- ----------------------------
DROP TABLE IF EXISTS `users_stats`;
CREATE TABLE `users_stats`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '主键ID',
  `account_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '账户ID',
  `level` int NULL DEFAULT 1 COMMENT '等级',
  `exp` bigint NULL DEFAULT 0 COMMENT '经验值',
  `total_exp` bigint NULL DEFAULT 0 COMMENT '累计经验值',
  `login_days` int NULL DEFAULT 0 COMMENT '登录天数',
  `continuous_login_days` int NULL DEFAULT 0 COMMENT '连续登录天数',
  `post_count` bigint NULL DEFAULT 0 COMMENT '发帖数',
  `comment_count` bigint NULL DEFAULT 0 COMMENT '评论数',
  `like_count` bigint NULL DEFAULT 0 COMMENT '获赞数',
  `follow_count` bigint NULL DEFAULT 0 COMMENT '关注数',
  `fans_count` bigint NULL DEFAULT 0 COMMENT '粉丝数',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除标识',
  `deleted_at` datetime NULL DEFAULT NULL COMMENT '逻辑删除时间',
  `deleted_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '删除人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `updated_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '最后更新人',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_users_stats_level`(`level` ASC) USING BTREE,
  INDEX `idx_users_stats_exp`(`exp` ASC) USING BTREE,
  INDEX `idx_users_stats_total_exp`(`total_exp` ASC) USING BTREE,
  INDEX `idx_users_stats_login_days`(`login_days` ASC) USING BTREE,
  INDEX `idx_users_stats_continuous_login_days`(`continuous_login_days` ASC) USING BTREE,
  INDEX `idx_users_stats_post_count`(`post_count` ASC) USING BTREE,
  INDEX `idx_users_stats_comment_count`(`comment_count` ASC) USING BTREE,
  INDEX `idx_users_stats_like_count`(`like_count` ASC) USING BTREE,
  INDEX `idx_users_stats_follow_count`(`follow_count` ASC) USING BTREE,
  INDEX `idx_users_stats_fans_count`(`fans_count` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户统计信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users_stats
-- ----------------------------
INSERT INTO `users_stats` VALUES ('1', '1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:22', NULL, '2025-11-25 09:22:22', NULL);
INSERT INTO `users_stats` VALUES ('1993255251559002113', '1993255249205997569', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 17:47:40', NULL, '2025-11-25 17:47:40', NULL);
INSERT INTO `users_stats` VALUES ('2', '2', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:26', NULL, '2025-11-25 09:22:26', NULL);
INSERT INTO `users_stats` VALUES ('3', '3', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:31', NULL, '2025-11-25 09:22:31', NULL);
INSERT INTO `users_stats` VALUES ('4', '4', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:35', NULL, '2025-11-25 09:22:35', NULL);
INSERT INTO `users_stats` VALUES ('5', '5', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:39', NULL, '2025-11-25 09:22:39', NULL);
INSERT INTO `users_stats` VALUES ('6', '6', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:43', NULL, '2025-11-25 09:22:43', NULL);
INSERT INTO `users_stats` VALUES ('7', '7', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:48', NULL, '2025-11-25 09:22:48', NULL);
INSERT INTO `users_stats` VALUES ('8', '8', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, '2025-11-25 09:22:52', NULL, '2025-11-25 09:22:52', NULL);

SET FOREIGN_KEY_CHECKS = 1;
