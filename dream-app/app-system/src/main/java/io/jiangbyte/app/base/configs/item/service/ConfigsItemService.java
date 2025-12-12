package io.jiangbyte.app.base.configs.item.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.base.configs.item.dto.WebsiteConfigInfo;
import io.jiangbyte.app.base.configs.item.entity.ConfigsItem;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemDto;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemPageQuery;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 系统配置表 服务类
*/
public interface ConfigsItemService extends IService<ConfigsItem> {
    Page<ConfigsItem> page(ConfigsItemPageQuery req);

    void add(ConfigsItemDto req);

    void edit(ConfigsItemDto req);

    void delete(List<String> ids);

    ConfigsItem detail(String id);

    List<ConfigsItem> latest(int n);

    List<ConfigsItem> topN(int n);

    List<ConfigsItem> lists();

    WebsiteConfigInfo websiteConfig();
}