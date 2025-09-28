package io.jiangbyte.app.modular.sys.category.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.category.entity.SysCategory;
import io.jiangbyte.app.modular.sys.category.param.SysCategoryAddParam;
import io.jiangbyte.app.modular.sys.category.param.SysCategoryEditParam;
import io.jiangbyte.app.modular.sys.category.param.SysCategoryIdParam;
import io.jiangbyte.app.modular.sys.category.param.SysCategoryPageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 分类表 服务类
*/
public interface SysCategoryService extends IService<SysCategory> {
    Page<SysCategory> page(SysCategoryPageParam sysCategoryPageParam);

    void add(SysCategoryAddParam sysCategoryAddParam);

    void edit(SysCategoryEditParam sysCategoryEditParam);

    void delete(List<SysCategoryIdParam> sysCategoryIdParamList);

    SysCategory detail(SysCategoryIdParam sysCategoryIdParam);

    List<SysCategory> latest(int n);

    List<SysCategory> topN(int n);
}