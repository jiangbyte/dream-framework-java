package io.jiangbyte.app.base.system.code.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.jiangbyte.framework.pojo.BaseEntity;

import java.io.Serial;

import io.jiangbyte.framework.enums.SortType;
import io.jiangbyte.framework.utils.SortConfig;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-10
* @description 代码生成任务模块明细表
*/
@EqualsAndHashCode(callSuper = true)
@Data
@TableName(value = "gen_code_task_module", autoResultMap = true)
@Schema(name = "GenCodeTaskModule", description = "代码生成任务模块明细表")
public class GenCodeTaskModule extends BaseEntity {
    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Schema(description = "")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @SortConfig(type = SortType.NUMERIC_STRING)
    private String id;

    @Schema(description = "关联 gen_code_task.id")
    private String taskId;

    @Schema(description = "模块类型，如：biz, sys, auth")
    private String moduleType;

    @Schema(description = "Java 包路径")
    private String packagePath;

    @Schema(description = "表名称，如：\"biz_normal_category\"")
    private String tableName;
}
