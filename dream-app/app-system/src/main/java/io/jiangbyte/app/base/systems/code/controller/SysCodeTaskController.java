package io.jiangbyte.app.base.systems.code.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskDto;
import io.jiangbyte.app.base.systems.code.dto.SysCodeTaskPageQuery;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.base.systems.code.service.SysCodeTaskService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 代码生成任务主表 控制器
*/
@Tag(name = "代码生成任务主表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class SysCodeTaskController {
    private final SysCodeTaskService sysCodeTaskService;

    @Operation(summary = "获取代码生成任务主分页")
    @SaCheckPermission("/sys/code/task/page")
    @GetMapping("/sys/code/task/page")
    public Result<?> page(@ParameterObject SysCodeTaskPageQuery req) {
        return Result.success(sysCodeTaskService.page(req));
    }

    @Operation(summary = "添加代码生成任务主")
    @SaCheckPermission("/sys/code/task/add")
    @PostMapping("/sys/code/task/add")
    public Result<?> add(@RequestBody @Valid SysCodeTaskDto req) {
        sysCodeTaskService.add(req);
        return Result.success();
    }

    @Operation(summary = "编辑代码生成任务主")
    @SaCheckPermission("/sys/code/task/edit")
    @PostMapping("/sys/code/task/edit")
    public Result<?> edit(@RequestBody @Valid SysCodeTaskDto req) {
        sysCodeTaskService.edit(req);
        return Result.success();
    }

    @Operation(summary = "删除代码生成任务主")
    @SaCheckPermission("/sys/code/task/delete")
    @PostMapping("/sys/code/task/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<String> ids) {
        sysCodeTaskService.delete(ids);
        return Result.success();
    }

    @Operation(summary = "获取代码生成任务主详情")
    @SaCheckPermission("/sys/code/task/detail")
    @GetMapping("/sys/code/task/detail/{id}")
    public Result<?> detail(@PathVariable("id") String id) {
        return Result.success(sysCodeTaskService.detail(id));
    }

    @Operation(summary = "获取代码生成任务主N最新")
    @SaCheckPermission("/sys/code/task/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysCodeTaskService.latest(n));
    }

    @Operation(summary = "获取代码生成任务主TopN")
    @SaCheckPermission("/sys/code/task/top")
    @GetMapping("/sys/code/task/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysCodeTaskService.topN(n));
    }

    @Operation(summary = "获取代码生成任务主Lists")
    @SaCheckPermission("/sys/code/task/lists")
    @GetMapping("/sys/code/task/lists")
    public Result<?> lists() {
        return Result.success(sysCodeTaskService.lists());
    }

}