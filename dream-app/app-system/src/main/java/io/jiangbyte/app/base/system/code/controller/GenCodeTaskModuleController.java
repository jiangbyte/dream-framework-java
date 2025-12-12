package io.jiangbyte.app.base.system.code.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskModuleDto;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskModulePageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.system.code.service.GenCodeTaskModuleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务模块明细表 控制器
*/
@Tag(name = "代码生成任务模块明细表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class GenCodeTaskModuleController {
    private final GenCodeTaskModuleService genCodeTaskModuleService;

    @Operation(summary = "获取代码生成任务模块明细分页")
    @SaCheckPermission("/gen/code/task/module/page")
    @GetMapping("/gen/code/task/module/page")
    public Result<?> page(@ParameterObject GenCodeTaskModulePageQuery req) {
        return Result.success(genCodeTaskModuleService.page(req));
    }

    @Operation(summary = "添加代码生成任务模块明细")
    @SaCheckPermission("/gen/code/task/module/add")
    @PostMapping("/gen/code/task/module/add")
    public Result<?> add(@RequestBody @Valid GenCodeTaskModuleDto req) {
        genCodeTaskModuleService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑代码生成任务模块明细")
    @SaCheckPermission("/gen/code/task/module/edit")
    @PostMapping("/gen/code/task/module/edit")
    public Result<?> edit(@RequestBody @Valid GenCodeTaskModuleDto req) {
        genCodeTaskModuleService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除代码生成任务模块明细")
    @SaCheckPermission("/gen/code/task/module/delete")
    @PostMapping("/gen/code/task/module/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        genCodeTaskModuleService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取代码生成任务模块明细详情")
    @SaCheckPermission("/gen/code/task/module/detail")
    @GetMapping("/gen/code/task/module/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(genCodeTaskModuleService.detail(id));
    }

    @Operation(summary = "获取代码生成任务模块明细N最新")
    @SaCheckPermission("/gen/code/task/module/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(genCodeTaskModuleService.latest(n));
    }

    @Operation(summary = "获取代码生成任务模块明细TopN")
    @SaCheckPermission("/gen/code/task/module/top")
    @GetMapping("/gen/code/task/module/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(genCodeTaskModuleService.topN(n));
    }

}