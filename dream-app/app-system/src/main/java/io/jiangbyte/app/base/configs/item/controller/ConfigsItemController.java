package io.jiangbyte.app.base.configs.item.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemDto;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemPageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.configs.item.service.ConfigsItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 系统配置表 控制器
*/
@Tag(name = "系统配置表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class ConfigsItemController {
    private final ConfigsItemService configsItemService;

    @Operation(summary = "获取系统配置分页")
    @SaCheckPermission("/configs/item/page")
    @GetMapping("/configs/item/page")
    public Result<?> page(@ParameterObject ConfigsItemPageQuery req) {
        return Result.success(configsItemService.page(req));
    }

    @Operation(summary = "添加系统配置")
    @SaCheckPermission("/configs/item/add")
    @PostMapping("/configs/item/add")
    public Result<?> add(@RequestBody @Valid ConfigsItemDto req) {
        configsItemService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑系统配置")
    @SaCheckPermission("/configs/item/edit")
    @PostMapping("/configs/item/edit")
    public Result<?> edit(@RequestBody @Valid ConfigsItemDto req) {
        configsItemService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除系统配置")
    @SaCheckPermission("/configs/item/delete")
    @PostMapping("/configs/item/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        configsItemService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取系统配置详情")
    @SaCheckPermission("/configs/item/detail")
    @GetMapping("/configs/item/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(configsItemService.detail(id));
    }

    @Operation(summary = "获取系统配置N最新")
    @SaCheckPermission("/configs/item/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(configsItemService.latest(n));
    }

    @Operation(summary = "获取系统配置TopN")
    @SaCheckPermission("/configs/item/top")
    @GetMapping("/configs/item/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(configsItemService.topN(n));
    }

    @Operation(summary = "获取系统配置Lists")
    @SaCheckPermission("/configs/item/lists")
    @GetMapping("/configs/item/lists")
    public Result<?> lists() {
        return Result.success(configsItemService.lists());
    }

    @Operation(summary = "获取网站配置")
    @GetMapping("/configs/item/website")
    public Result<?> websiteConfig() {
        return Result.success(configsItemService.websiteConfig());
    }

}