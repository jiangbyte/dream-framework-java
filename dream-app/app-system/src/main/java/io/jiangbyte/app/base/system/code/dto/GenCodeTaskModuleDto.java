package io.jiangbyte.app.base.system.code.dto;

import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import java.io.Serial;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-10
* @description 代码生成任务模块明细 编辑参数
*/
@Data
@Schema(name = "GenCodeTaskModule", description = "代码生成任务模块明细 编辑参数")
public class GenCodeTaskModuleDto implements Serializable {
    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

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