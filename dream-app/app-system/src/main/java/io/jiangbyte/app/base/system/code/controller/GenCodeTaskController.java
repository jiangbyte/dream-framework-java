package io.jiangbyte.app.base.system.code.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskDto;
import io.jiangbyte.app.base.system.code.dto.GenCodeTaskPageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.system.code.service.GenCodeTaskService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
 * @author Charlie Zhang
 * @version v1.0
 * @date 2025-12-10
 * @description 代码生成任务主表 控制器
 */
@Tag(name = "代码生成任务主表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class GenCodeTaskController {
    private final GenCodeTaskService genCodeTaskService;

    @Operation(summary = "获取代码生成任务主分页")
    @SaCheckPermission("/gen/code/task/page")
    @GetMapping("/gen/code/task/page")
    public Result<?> page(@ParameterObject GenCodeTaskPageQuery req) {
        return Result.success(genCodeTaskService.page(req));
    }

    @Operation(summary = "添加代码生成任务主")
    @SaCheckPermission("/gen/code/task/add")
    @PostMapping("/gen/code/task/add")
    public Result<?> add(@RequestBody @Valid GenCodeTaskDto req) {
        genCodeTaskService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑代码生成任务主")
    @SaCheckPermission("/gen/code/task/edit")
    @PostMapping("/gen/code/task/edit")
    public Result<?> edit(@RequestBody @Valid GenCodeTaskDto req) {
        genCodeTaskService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除代码生成任务主")
    @SaCheckPermission("/gen/code/task/delete")
    @PostMapping("/gen/code/task/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        genCodeTaskService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取代码生成任务主详情")
    @SaCheckPermission("/gen/code/task/detail")
    @GetMapping("/gen/code/task/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(genCodeTaskService.detail(id));
    }

    @Operation(summary = "获取代码生成任务主N最新")
    @SaCheckPermission("/gen/code/task/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(genCodeTaskService.latest(n));
    }

    @Operation(summary = "获取代码生成任务主TopN")
    @SaCheckPermission("/gen/code/task/top")
    @GetMapping("/gen/code/task/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(genCodeTaskService.topN(n));
    }

    @Operation(summary = "获取代码生成任务主列表")
    @SaCheckPermission("/gen/code")
    @GetMapping("/gen/code")
    public Result<?> genCode(@RequestParam("taskId") String taskId) {
        genCodeTaskService.genCode(taskId);
        return Result.success();
    }

}