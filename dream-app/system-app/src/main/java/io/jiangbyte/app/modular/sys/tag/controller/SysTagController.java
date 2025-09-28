package io.jiangbyte.app.modular.sys.tag.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.modular.sys.tag.param.SysTagPageParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagAddParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagEditParam;
import io.jiangbyte.app.modular.sys.tag.param.SysTagIdParam;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.modular.sys.tag.service.SysTagService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 标签表 控制器
*/
@Tag(name = "标签表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class SysTagController {
    private final SysTagService sysTagService;

    @Operation(summary = "获取标签分页")
    @SaCheckPermission("/sys/tag/page")
    @GetMapping("/sys/tag/page")
    public Result<?> page(@ParameterObject SysTagPageParam sysTagPageParam) {
        return Result.success(sysTagService.page(sysTagPageParam));
    }

    @Operation(summary = "添加标签")
    @SaCheckPermission("/sys/tag/add")
    @PostMapping("/sys/tag/add")
    public Result<?> add(@RequestBody @Valid SysTagAddParam sysTagAddParam) {
        sysTagService.add(sysTagAddParam);
        return Result.success();
    }

    @Operation(summary = "编辑标签")
    @SaCheckPermission("/sys/tag/edit")
    @PostMapping("/sys/tag/edit")
    public Result<?> edit(@RequestBody @Valid SysTagEditParam sysTagEditParam) {
        sysTagService.edit(sysTagEditParam);
        return Result.success();
    }

    @Operation(summary = "删除标签")
    @SaCheckPermission("/sys/tag/delete")
    @PostMapping("/sys/tag/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<SysTagIdParam> sysTagIdParam) {
        sysTagService.delete(sysTagIdParam);
        return Result.success();
    }

    @Operation(summary = "获取标签详情")
    @SaCheckPermission("/sys/tag/detail")
    @GetMapping("/sys/tag/detail")
    public Result<?> detail(@ParameterObject @Valid SysTagIdParam sysTagIdParam) {
        return Result.success(sysTagService.detail(sysTagIdParam));
    }

    @Operation(summary = "获取标签N最新")
    @SaCheckPermission("/sys/tag/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysTagService.latest(n));
    }

    @Operation(summary = "获取标签Top N")
    @SaCheckPermission("/sys/tag/top")
    @GetMapping("/sys/tag/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysTagService.topN(n));
    }

}