package io.jiangbyte.app.base.auths.role.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import io.jiangbyte.app.base.auths.group.entity.AuthsGroup;
import io.jiangbyte.app.constants.Dict;
import io.jiangbyte.framework.pojo.BaseEntity;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.io.Serial;
import java.util.Date;
import java.util.List;

import io.jiangbyte.framework.enums.SortType;
import io.jiangbyte.framework.utils.SortConfig;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.dromara.core.trans.anno.Trans;
import org.dromara.core.trans.constant.TransType;

/**
 * @author Charlie Zhang
 * @version v1.0
 * @date 2025-12-12
 * @description 角色表
 */
@EqualsAndHashCode(callSuper = true)
@Data
@TableName(value = "auths_role", autoResultMap = true)
@Schema(name = "AuthsRole", description = "角色表")
public class AuthsRole extends BaseEntity {
    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    @Schema(description = "主键ID")
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @SortConfig(type = SortType.NUMERIC_STRING)
    private String id;

    @Schema(description = "角色名称")
    private String name;

    @Schema(description = "角色编码")
    private String code;

    @Schema(description = "数据权限范围")
    @Trans(type = TransType.DICTIONARY, key = Dict.SYS_DATA_SCOPE)
    private String dataScope;

    @Schema(description = "角色描述")
    private String description;

    @Schema(description = "分配的用户组ID列表(JSON数组)")
    @TableField(typeHandler = JacksonTypeHandler.class)
    private List<String> assignGroupIds;
}
