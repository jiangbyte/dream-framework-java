package io.jiangbyte.app.base.configs.group.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.configs.group.entity.ConfigsGroup;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupDto;
import io.jiangbyte.app.base.configs.group.dto.ConfigsGroupPageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 配置分组表 服务类
*/
public interface ConfigsGroupService extends IService<ConfigsGroup> {
    Page<ConfigsGroup> page(ConfigsGroupPageQuery req);

    void add(ConfigsGroupDto req);

    void edit(ConfigsGroupDto req);

    void delete(List<String> ids);

    ConfigsGroup detail(String id);

    List<ConfigsGroup> latest(int n);

    List<ConfigsGroup> topN(int n);

    List<ConfigsGroup> lists();
}