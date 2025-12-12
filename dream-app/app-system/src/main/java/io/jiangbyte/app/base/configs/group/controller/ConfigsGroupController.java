package io.jiangbyte.app.base.configs.group.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupDto;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupPageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.configs.group.service.ConfigsGroupService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 配置分组表 控制器
*/
@Tag(name = "配置分组表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class ConfigsGroupController {
    private final ConfigsGroupService configsGroupService;

    @Operation(summary = "获取配置分组分页")
    @SaCheckPermission("/configs/group/page")
    @GetMapping("/configs/group/page")
    public Result<?> page(@ParameterObject ConfigsGroupPageQuery req) {
        return Result.success(configsGroupService.page(req));
    }

    @Operation(summary = "添加配置分组")
    @SaCheckPermission("/configs/group/add")
    @PostMapping("/configs/group/add")
    public Result<?> add(@RequestBody @Valid ConfigsGroupDto req) {
        configsGroupService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑配置分组")
    @SaCheckPermission("/configs/group/edit")
    @PostMapping("/configs/group/edit")
    public Result<?> edit(@RequestBody @Valid ConfigsGroupDto req) {
        configsGroupService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除配置分组")
    @SaCheckPermission("/configs/group/delete")
    @PostMapping("/configs/group/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        configsGroupService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取配置分组详情")
    @SaCheckPermission("/configs/group/detail")
    @GetMapping("/configs/group/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(configsGroupService.detail(id));
    }

    @Operation(summary = "获取配置分组N最新")
    @SaCheckPermission("/configs/group/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(configsGroupService.latest(n));
    }

    @Operation(summary = "获取配置分组TopN")
    @SaCheckPermission("/configs/group/top")
    @GetMapping("/configs/group/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(configsGroupService.topN(n));
    }

    @Operation(summary = "获取配置分组Lists")
    @SaCheckPermission("/configs/group/lists")
    @GetMapping("/configs/group/lists")
    public Result<?> lists() {
        return Result.success(configsGroupService.lists());
    }

}