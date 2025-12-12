package io.jiangbyte.app.base.systems.code.dto;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.jiangbyte.framework.pojo.BaseEntity;
import java.io.Serializable;
import java.time.LocalDateTime;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import java.io.Serial;
import java.util.Date;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务模块明细 DTO
*/
@Data
@Schema(name = "SysCodeTaskModule", description = "代码生成任务模块明细 DTO")
public class SysCodeTaskModuleDto implements Serializable {
    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    private Long id;

    @Schema(description = "关联 gen_code_task.id")
    private Long taskId;

    @Schema(description = "模块类型，如：biz, sys, auth")
    private String moduleType;

    @Schema(description = "Java 包路径")
    private String packagePath;

    @Schema(description = "表名称，如：\"biz_normal_category\"")
    private String tableName;

}