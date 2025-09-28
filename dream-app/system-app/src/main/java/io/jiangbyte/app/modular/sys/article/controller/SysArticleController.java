package io.jiangbyte.app.modular.sys.article.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import io.jiangbyte.framework.result.Result;
import io.jiangbyte.app.modular.sys.article.param.SysArticlePageParam;
import io.jiangbyte.app.modular.sys.article.param.SysArticleAddParam;
import io.jiangbyte.app.modular.sys.article.param.SysArticleEditParam;
import io.jiangbyte.app.modular.sys.article.param.SysArticleIdParam;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import org.springdoc.core.annotations.ParameterObject;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.jiangbyte.app.modular.sys.article.service.SysArticleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 系统文章表 控制器
*/
@Tag(name = "系统文章表控制器")
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1")
@RestController
@Validated
public class SysArticleController {
    private final SysArticleService sysArticleService;

    @Operation(summary = "获取系统文章分页")
    @SaCheckPermission("/sys/article/page")
    @GetMapping("/sys/article/page")
    public Result<?> page(@ParameterObject SysArticlePageParam sysArticlePageParam) {
        return Result.success(sysArticleService.page(sysArticlePageParam));
    }

    @Operation(summary = "添加系统文章")
    @SaCheckPermission("/sys/article/add")
    @PostMapping("/sys/article/add")
    public Result<?> add(@RequestBody @Valid SysArticleAddParam sysArticleAddParam) {
        sysArticleService.add(sysArticleAddParam);
        return Result.success();
    }

    @Operation(summary = "编辑系统文章")
    @SaCheckPermission("/sys/article/edit")
    @PostMapping("/sys/article/edit")
    public Result<?> edit(@RequestBody @Valid SysArticleEditParam sysArticleEditParam) {
        sysArticleService.edit(sysArticleEditParam);
        return Result.success();
    }

    @Operation(summary = "删除系统文章")
    @SaCheckPermission("/sys/article/delete")
    @PostMapping("/sys/article/delete")
    public Result<?> delete(@RequestBody @Valid @NotEmpty(message = "集合不能为空") List<SysArticleIdParam> sysArticleIdParam) {
        sysArticleService.delete(sysArticleIdParam);
        return Result.success();
    }

    @Operation(summary = "获取系统文章详情")
    @SaCheckPermission("/sys/article/detail")
    @GetMapping("/sys/article/detail")
    public Result<?> detail(@ParameterObject @Valid SysArticleIdParam sysArticleIdParam) {
        return Result.success(sysArticleService.detail(sysArticleIdParam));
    }

    @Operation(summary = "获取系统文章N最新")
    @SaCheckPermission("/sys/article/latest")
    public Result<?> latest(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysArticleService.latest(n));
    }

    @Operation(summary = "获取系统文章Top N")
    @SaCheckPermission("/sys/article/top")
    @GetMapping("/sys/article/top")
    public Result<?> topN(@RequestParam(value = "n", required = false) Integer n) {
        return Result.success(sysArticleService.topN(n));
    }

}