SET NAMES 'utf8mb4';

CREATE
    DATABASE IF NOT EXISTS dream_db;

use
dream_db;

-- ----------------------------
-- 用户组表
-- ----------------------------
DROP TABLE IF EXISTS sys_group;
CREATE TABLE sys_group
(
    id          VARCHAR(32)  NOT NULL COMMENT '用户组',
    parent_id   VARCHAR(32) COMMENT '父级用户组',
    name        VARCHAR(100) NOT NULL COMMENT '名称',
    code        VARCHAR(50)  NOT NULL COMMENT '编码',
    description VARCHAR(255) COMMENT '描述',
    sort        TINYINT     DEFAULT 99 COMMENT '排序',
    admin_id    VARCHAR(32) COMMENT '负责人',
    group_type  TINYINT(1)  DEFAULT 0 COMMENT '系统组',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id),
    INDEX idx_group_code (code)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci COMMENT ='用户组表';

-- ----------------------------
-- 用户表
-- ----------------------------
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user
(
    id             VARCHAR(32)  NOT NULL COMMENT '主键',
    group_id       VARCHAR(32) COMMENT '用户组',
    username       VARCHAR(64)  NOT NULL COMMENT '用户名',
    password       VARCHAR(100) NOT NULL COMMENT '密码',
    nickname       VARCHAR(128) NOT NULL COMMENT '昵称',
    avatar         VARCHAR(255) NULL COMMENT '头像',
    background     VARCHAR(255) NULL COMMENT '背景图片',
    quote          VARCHAR(255) NULL COMMENT '签名',
    gender         TINYINT(1)  DEFAULT 0 COMMENT '性别',
    email          VARCHAR(128) NOT NULL COMMENT '邮箱',
    student_number VARCHAR(20)  NULL COMMENT '学号',
    telephone      VARCHAR(20)  NULL COMMENT '电话',
    -- 登录时间
    login_time     DATETIME    DEFAULT NULL COMMENT '登录时间',
    # ------------------------------------------------
    deleted        TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time    DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user    VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time    DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user    VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id),
    INDEX idx_username (username),
    INDEX idx_telephone (telephone),
    INDEX idx_email (email)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT
        '用户表';

-- ----------------------------
-- 角色表
-- ----------------------------
DROP TABLE IF EXISTS sys_role;
CREATE TABLE sys_role
(
    id          VARCHAR(32) NOT NULL COMMENT '主键',
    name        VARCHAR(255) DEFAULT NULL COMMENT '名称',
    code        VARCHAR(50)  DEFAULT NULL COMMENT '编码',
    description VARCHAR(255) COMMENT '描述',
    level       TINYINT      DEFAULT 5 COMMENT '角色层级',
    -- 1顶级角色（超级管理员） 2普通管理员 3用户组管理员以及子组管理员 4用户组管理员 5普通用户
    # ------------------------------------------------
    deleted     TINYINT(1)   DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME     DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32)  DEFAULT NULL COMMENT '创建者',
    update_time DATETIME     DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32)  DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id),
    INDEX idx_role_code (code)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT
        '角色表';

-- ----------------------------
-- 用户-角色 关联表(1-N)
-- ----------------------------
DROP TABLE IF EXISTS sys_user_role;
CREATE TABLE sys_user_role
(
    user_id VARCHAR(32) NOT NULL COMMENT '用户ID',
    role_id VARCHAR(32) NOT NULL COMMENT '角色ID'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT
        '用户-角色 关联表(1-N)';

-- ----------------------------
-- 公告表
-- ----------------------------
DROP TABLE IF EXISTS sys_notice;
CREATE TABLE sys_notice
(
    id          VARCHAR(32)  NOT NULL COMMENT '主键',
    title       VARCHAR(64)  NOT NULL COMMENT '标题',
    cover       VARCHAR(255) NULL COMMENT '封面',
    url         VARCHAR(255) NULL COMMENT '链接',
    sort        TINYINT     DEFAULT 99 COMMENT '排序',
    content     TEXT         NULL COMMENT '内容',
    is_visible  TINYINT(1)  DEFAULT 1 COMMENT '是否可见',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT '公告表';

-- ----------------------------
-- 横幅表
-- ----------------------------
DROP TABLE IF EXISTS sys_banner;
CREATE TABLE sys_banner
(
    id          VARCHAR(32)  NOT NULL COMMENT '主键',
    title       VARCHAR(255) NOT NULL COMMENT '标题',
    banner      VARCHAR(255) NULL COMMENT '横幅',
    button_text VARCHAR(255) NULL COMMENT '按钮文字',
    to_url      VARCHAR(255) NULL COMMENT '链接',
    sort        TINYINT     DEFAULT 99 COMMENT '排序',
    subtitle    VARCHAR(255) NOT NULL COMMENT '子标题',
    is_visible  TINYINT(1)  DEFAULT 1 COMMENT '是否可见',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT '横幅表';

-- ----------------------------
-- 字典类型表
-- ----------------------------
DROP TABLE IF EXISTS sys_dict;
CREATE TABLE sys_dict
(
    id          varchar(32)  NOT NULL COMMENT '主键ID',
    -- 字典类型
    dict_type   varchar(64)  NOT NULL COMMENT '字典类型',
    type_label  varchar(64)  NULL COMMENT '类型名称',
    -- 字典数据
    dict_value  varchar(255) NOT NULL COMMENT '字典值',
    dict_label  varchar(255) NOT NULL COMMENT '字典标签',
    sort_order  int         DEFAULT '0' COMMENT '排序',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    PRIMARY KEY (id),
    UNIQUE KEY uk_type_code (dict_type, dict_value) COMMENT '类型和编码唯一索引'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='系统字典表';

-- ----------------------------
-- 系统配置表
-- ----------------------------
DROP TABLE IF EXISTS sys_config;
CREATE TABLE sys_config
(
    id             VARCHAR(32)  NOT NULL COMMENT '主键',
    config_type    VARCHAR(255) COMMENT '配置分类',
    name           VARCHAR(255) NOT NULL COMMENT '名称',
    code           VARCHAR(255) NOT NULL COMMENT '编码',
    value          VARCHAR(255) NOT NULL COMMENT '值',
    component_type VARCHAR(255) COMMENT '组件类型', -- 默认输入框
    description    VARCHAR(255) COMMENT '描述',
    # ------------------------------------------------
    deleted        TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time    DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user    VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time    DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user    VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT
        '系统配置表';

-- ----------------------------
-- 系统文章表（关于，协议，帮助等）
-- ----------------------------
DROP TABLE IF EXISTS sys_article;
CREATE TABLE sys_article
(
    id          VARCHAR(32)  NOT NULL COMMENT '主键',
    title       VARCHAR(255) NOT NULL COMMENT '标题',
    subtitle    VARCHAR(255) NOT NULL COMMENT '子标题',
    cover       VARCHAR(255) NULL COMMENT '封面',
    author      VARCHAR(255) NULL COMMENT '作者',
    summary     VARCHAR(255) NULL COMMENT '摘要',
    sort        TINYINT     DEFAULT 99 COMMENT '排序',
    to_url      VARCHAR(255) NULL COMMENT '链接',
    parent_id   VARCHAR(32) DEFAULT '0' COMMENT '父级',
    type        VARCHAR(32) DEFAULT 0 COMMENT '类型',
    category    VARCHAR(32) DEFAULT 0 COMMENT '分类',
    content     TEXT         NOT NULL COMMENT '内容',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT '系统文章表';


-- 系统核心角色
INSERT INTO sys_role(id, name, code, description, level)
VALUES (1, '超级管理员', 'super', '超级管理员', 1),
       (2, '普通管理员', 'admin', '管理员', 2),
       (3, '子组管理员', 'admin_group', '用户组管理员以及子组管理员', 3),
       (4, '用户组管理员', 'group', '用户组管理员', 4),
       (5, '普通用户', 'user', '普通用户', 5);

-- 初始化用户组
INSERT INTO sys_group(id, code, name, description, parent_id, create_time, create_user, update_time, update_user)
VALUES (1, 'SUPER_GROUP', '超级管理员组', '超级管理员组', 0, NOW(), 1, NOW(), 1);
INSERT INTO sys_group(id, code, name, description, parent_id, create_time, create_user, update_time, update_user)
VALUES (2, 'ADMIN_GROUP', '管理员组', '管理员组', 1, NOW(), 1, NOW(), 1);
INSERT INTO sys_group(id, code, name, description, parent_id, create_time, create_user, update_time, update_user)
VALUES (0, 'USER_GROUP', '默认用户组', '默认用户组', 2, NOW(), 1, NOW(), 1);

-- 初始化用户数据
INSERT INTO sys_user(id, group_id, username, password, nickname, email, telephone, create_time, create_user, update_time, update_user)
VALUES (1, 0, 'super', '$2a$10$TePd3nIT3FJguI2Vp4BdfuqWONoa6xnIyK5QnHak.s3DT/8N9CXSS', '超级管理员', 'super@example.com', '13800000000', NOW(), 1, NOW(), 1),
       (2, 0, 'admin', '$2a$10$TePd3nIT3FJguI2Vp4BdfuqWONoa6xnIyK5QnHak.s3DT/8N9CXSS', '管理员', 'admin@example.com', '13800000001', NOW(), 1, NOW(), 1);

-- ----------------------------
-- 分类表
-- ----------------------------
DROP TABLE IF EXISTS sys_category;
CREATE TABLE sys_category
(
    id          VARCHAR(32)  NOT NULL COMMENT '主键',
    name        VARCHAR(255) NOT NULL COMMENT '名称',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT '分类表';

-- ----------------------------
-- 标签表
-- ----------------------------
DROP TABLE IF EXISTS sys_tag;
CREATE TABLE sys_tag
(
    id          VARCHAR(32)  NOT NULL COMMENT '主键',
    name        VARCHAR(255) NOT NULL COMMENT '名称',
    # ------------------------------------------------
    deleted     TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT '标签表';

-- ----------------------------
-- 菜单表
-- ----------------------------
DROP TABLE IF EXISTS sys_menu;
CREATE TABLE sys_menu
(
    id             VARCHAR(32) COMMENT '菜单ID',
    pid            VARCHAR(32) DEFAULT '0' COMMENT '父菜单ID',
    name           VARCHAR(100) NOT NULL COMMENT '菜单名称（英文标识）',
    path           VARCHAR(200) COMMENT '路由路径',
    component_path VARCHAR(500) COMMENT '组件路径',
    title          VARCHAR(100) NOT NULL COMMENT '菜单标题',
    icon           VARCHAR(100) COMMENT '图标',
    keep_alive     TINYINT(1)  DEFAULT 0 COMMENT '是否缓存',
    visible        TINYINT(1)  DEFAULT 1 COMMENT '是否可见',
    sort           INT         DEFAULT 0 COMMENT '排序',
    pined          TINYINT(1)  DEFAULT 0 COMMENT '是否固定',
    menu_type      INT         DEFAULT 0 COMMENT '菜单类型：0-目录，1-菜单',
    ex_json        JSON        DEFAULT NULL COMMENT '额外信息',
    # ------------------------------------------------
    deleted        TINYINT(1)  DEFAULT 0 COMMENT '删除状态',
    create_time    DATETIME    DEFAULT NULL COMMENT '创建时间戳',
    create_user    VARCHAR(32) DEFAULT NULL COMMENT '创建者',
    update_time    DATETIME    DEFAULT NULL COMMENT '更新时间戳',
    update_user    VARCHAR(32) DEFAULT NULL COMMENT '更新者',
    -- 添加索引
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT ='菜单表';

-- ----------------------------
-- 角色-菜单表 关联表(N-N)
-- ----------------------------
DROP TABLE IF EXISTS sys_role_menu;
CREATE TABLE sys_role_menu
(
    role_id VARCHAR(32) NOT NULL COMMENT '角色ID',
    menu_id VARCHAR(32) NOT NULL COMMENT '菜单ID'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci
    COMMENT
        '角色-菜单 关联表(1-N)';
