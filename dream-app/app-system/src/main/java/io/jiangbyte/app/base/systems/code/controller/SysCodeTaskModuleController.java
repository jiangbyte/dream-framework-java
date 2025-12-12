package io.jiangbyte.app.base.systems.code.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModuleDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskModulePageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.systems.code.service.SysCodeTaskModuleService;
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
public class SysCodeTaskModuleController {
    private final SysCodeTaskModuleService sysCodeTaskModuleService;

    @Operation(summary = "获取代码生成任务模块明细分页")
    @SaCheckPermission("/sys/code/task/module/page")
    @GetMapping("/sys/code/task/module/page")
    public Result<?> page(@ParameterObject SysCodeTaskModulePageQuery req) {
        return Result.success(sysCodeTaskModuleService.page(req));
    }

    @Operation(summary = "添加代码生成任务模块明细")
    @SaCheckPermission("/sys/code/task/module/add")
    @PostMapping("/sys/code/task/module/add")
    public Result<?> add(@RequestBody @Valid SysCodeTaskModuleDto req) {
        sysCodeTaskModuleService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑代码生成任务模块明细")
    @SaCheckPermission("/sys/code/task/module/edit")
    @PostMapping("/sys/code/task/module/edit")
    public Result<?> edit(@RequestBody @Valid SysCodeTaskModuleDto req) {
        sysCodeTaskModuleService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除代码生成任务模块明细")
    @SaCheckPermission("/sys/code/task/module/delete")
    @PostMapping("/sys/code/task/module/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        sysCodeTaskModuleService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取代码生成任务模块明细详情")
    @SaCheckPermission("/sys/code/task/module/detail")
    @GetMapping("/sys/code/task/module/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(sysCodeTaskModuleService.detail(id));
    }

    @Operation(summary = "获取代码生成任务模块明细N最新")
    @SaCheckPermission("/sys/code/task/module/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysCodeTaskModuleService.latest(n));
    }

    @Operation(summary = "获取代码生成任务模块明细TopN")
    @SaCheckPermission("/sys/code/task/module/top")
    @GetMapping("/sys/code/task/module/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysCodeTaskModuleService.topN(n));
    }

    @Operation(summary = "获取代码生成任务模块明细Lists")
    @SaCheckPermission("/sys/code/task/module/lists")
    @GetMapping("/sys/code/task/module/lists")
    public Result<?> lists() {
        return Result.success(sysCodeTaskModuleService.lists());
    }

}