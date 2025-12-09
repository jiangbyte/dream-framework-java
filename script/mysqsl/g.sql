CREATE TABLE `gen_code_task`
(
    `id`            BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `task_name`     VARCHAR(200) NOT NULL COMMENT '任务名称，如：系统模块代码生成',
    `author`        VARCHAR(100) NOT NULL COMMENT '作者',
    `output_dir`    VARCHAR(500) NOT NULL COMMENT '代码输出目录',
    `db_url`        VARCHAR(500) NOT NULL COMMENT '数据库JDBC URL',
    `db_username`   VARCHAR(100) NOT NULL COMMENT '数据库用户名',
    -- 注意：密码通常不建议明文存储！可选存或加密
    `db_password`   VARCHAR(200)      DEFAULT NULL COMMENT '数据库密码（建议加密或留空）',
    `database_name` VARCHAR(100) NOT NULL COMMENT '数据库名',
    `add_backend`   TINYINT           DEFAULT 1 COMMENT '生成后端：1-是，0-否',
    `add_frontend`  TINYINT           DEFAULT 1 COMMENT '生成后端：1-是，0-否',
    `executed_at`   DATETIME          DEFAULT NULL COMMENT '实际执行时间',
    `status`        TINYINT           DEFAULT 0 COMMENT '状态：0-待执行，1-成功，2-失败',
    `remark`        VARCHAR(500)      DEFAULT NULL COMMENT '备注',

    `is_deleted`    tinyint(1)   NULL DEFAULT 0 COMMENT '逻辑删除标识：0-未删除 1-已删除',
    `deleted_at`    datetime     NULL DEFAULT NULL COMMENT '逻辑删除时间',
    `deleted_by`    varchar(64)  NULL DEFAULT NULL COMMENT '删除人（账号/ID）',
    `created_at`    datetime     NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `created_by`    varchar(64)  NULL DEFAULT NULL COMMENT '创建人（账号/ID）',
    `updated_at`    datetime     NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
    `updated_by`    varchar(64)  NULL DEFAULT NULL COMMENT '最后更新人（账号/ID）',
    PRIMARY KEY (`id`) USING BTREE,
    KEY `idx_author` (`author`),
    KEY `idx_created_at` (`created_at`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='代码生成任务主表';


CREATE TABLE `gen_code_task_module`
(
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `task_id`      BIGINT       NOT NULL COMMENT '关联 gen_code_task.id',
    `module_type`  VARCHAR(50)  NOT NULL COMMENT '模块类型，如：biz, sys, auth',
    `package_path` VARCHAR(300) NOT NULL COMMENT 'Java 包路径',
    `table_name`   VARCHAR(300) NOT NULL COMMENT '表名称，如："biz_normal_category"',

    `is_deleted`   tinyint(1)   NULL DEFAULT 0 COMMENT '逻辑删除标识：0-未删除 1-已删除',
    `deleted_at`   datetime     NULL DEFAULT NULL COMMENT '逻辑删除时间',
    `deleted_by`   varchar(64)  NULL DEFAULT NULL COMMENT '删除人（账号/ID）',
    `created_at`   datetime     NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `created_by`   varchar(64)  NULL DEFAULT NULL COMMENT '创建人（账号/ID）',
    `updated_at`   datetime     NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
    `updated_by`   varchar(64)  NULL DEFAULT NULL COMMENT '最后更新人（账号/ID）',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='代码生成任务模块明细表';