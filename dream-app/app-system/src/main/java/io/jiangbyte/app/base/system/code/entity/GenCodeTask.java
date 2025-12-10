package io.jiangbyte.app.base.system.code.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.jiangbyte.framework.pojo.BaseEntity;

import java.io.Serial;
import java.util.Date;
import io.jiangbyte.framework.enums.SortType;
import io.jiangbyte.framework.utils.SortConfig;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-10
* @description 代码生成任务主表
*/
@EqualsAndHashCode(callSuper = true)
@Data
@TableName(value = "gen_code_task", autoResultMap = true)
@Schema(name = "GenCodeTask", description = "代码生成任务主表")
public class GenCodeTask extends BaseEntity {
    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Schema(description = "主键ID")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @SortConfig(type = SortType.NUMERIC_STRING)
    private String id;

    @Schema(description = "任务名称，如：系统模块代码生成")
    private String taskName;

    @Schema(description = "作者")
    private String author;

    @Schema(description = "代码输出目录")
    private String outputDir;

    @Schema(description = "数据库JDBC URL")
    private String dbUrl;

    @Schema(description = "数据库用户名")
    private String dbUsername;

    @Schema(description = "数据库密码（建议加密或留空）")
    private String dbPassword;

    @Schema(description = "数据库名")
    private String databaseName;

    @Schema(description = "生成后端：1-是，0-否")
    private Boolean addBackend;

    @Schema(description = "生成后端：1-是，0-否")
    private Boolean addFrontend;

    @Schema(description = "实际执行时间")
    private Date executedAt;

    @Schema(description = "状态：0-待执行，1-成功，2-失败")
    private Integer status;

    @Schema(description = "备注")
    private String remark;
}
