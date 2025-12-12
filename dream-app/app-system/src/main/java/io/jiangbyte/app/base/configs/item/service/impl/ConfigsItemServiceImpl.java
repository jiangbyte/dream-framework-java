package io.jiangbyte.app.base.configs.item.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollStreamUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.jiangbyte.app.base.configs.item.dto.WebsiteConfigInfo;
import io.jiangbyte.app.base.configs.item.entity.ConfigsItem;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemDto;
import io.jiangbyte.app.base.configs.item.dto.ConfigsItemPageQuery;
import io.jiangbyte.app.base.configs.item.mapper.ConfigsItemMapper;
import io.jiangbyte.app.base.configs.item.service.ConfigsItemService;
import io.jiangbyte.framework.utils.SortUtils;
import io.jiangbyte.framework.enums.ISortOrderEnum;
import io.jiangbyte.framework.exception.BusinessException;
import io.jiangbyte.framework.pojo.BasePageRequest;
import io.jiangbyte.framework.result.ResultCode;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-06-23
* @description 系统配置表 服务实现类
*/
@Slf4j
@Service
@RequiredArgsConstructor
public class ConfigsItemServiceImpl extends ServiceImpl<ConfigsItemMapper, ConfigsItem> implements ConfigsItemService {

    @Override
    public Page<ConfigsItem> page(ConfigsItemPageQuery req) {
        QueryWrapper<ConfigsItem> queryWrapper = new QueryWrapper<ConfigsItem>().checkSqlInjection();
        if (ObjectUtil.isNotEmpty(req.getKeyword())) {
            queryWrapper.lambda().like(ConfigsItem::getName, req.getKeyword());
        }
        SortUtils.handleSort(ConfigsItem.class, queryWrapper, req.getSortField(), req.getSortOrder());
        return this.page(BasePageRequest.Page(
                        Optional.ofNullable(req.getCurrent()).orElse(1),
                        Optional.ofNullable(req.getPageSize()).orElse(10)),
                queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void add(ConfigsItemDto req) {
        ConfigsItem bean = BeanUtil.toBean(req, ConfigsItem.class);
        bean.setId(null);
        this.save(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void edit(ConfigsItemDto req) {
        if (!this.exists(new LambdaQueryWrapper<ConfigsItem>().eq(ConfigsItem::getId, req.getId()))) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        ConfigsItem bean = BeanUtil.toBean(req, ConfigsItem.class);
        BeanUtil.copyProperties(req, bean);
        this.updateById(bean);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void delete(List<String> ids) {
        if (ObjectUtil.isEmpty(ids)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        this.removeByIds(ids);
    }

    @Override
    public ConfigsItem detail(String id) {
        ConfigsItem configsItem = this.getById(id);
        if (ObjectUtil.isEmpty(configsItem)) {
            throw new BusinessException(ResultCode.PARAM_ERROR);
        }
        return configsItem;
    }

    @Override
    public List<ConfigsItem> latest(int n) {
        return this.list(new QueryWrapper<ConfigsItem>()
            .lambda()
            .orderByDesc(ConfigsItem::getId)
            .last("limit " + n));
    }

    @Override
    public List<ConfigsItem> topN(int n) {
        return this.list(new QueryWrapper<ConfigsItem>()
            .lambda()
            .orderByDesc(ConfigsItem::getId)
            .last("limit " + n));
    }


    @Override
    public List<ConfigsItem> lists() {
        return this.list(new QueryWrapper<ConfigsItem>()
            .lambda()
            .orderByDesc(ConfigsItem::getId));
    }

    @Override
    public WebsiteConfigInfo websiteConfig() {
        List<ConfigsItem> configItems = this.list(new QueryWrapper<ConfigsItem>()
                .lambda()
                .eq(ConfigsItem::getGroupCode, "WEBSITE")
        );

        if (configItems == null || configItems.isEmpty()) {
            return null;
        }

        // 创建配置信息对象
        WebsiteConfigInfo configInfo = new WebsiteConfigInfo();

        // 将配置项映射到对象属性
        for (ConfigsItem item : configItems) {
            setConfigValue(configInfo, item.getCode(), item.getValue());
        }

        return configInfo;
    }

    /**
     * 根据配置项代码设置对应的属性值
     */
    private void setConfigValue(WebsiteConfigInfo configInfo, String code, String value) {
        if (value == null) return;

        switch (code) {
            // 网站信息
            case "WEBSITE_NAME":
                configInfo.setWebsiteName(value);
                break;
            case "WEBSITE_LOGO":
                configInfo.setWebsiteLogo(value);
                break;
            case "WEBSITE_DESCRIPTION":
                configInfo.setWebsiteDescription(value);
                break;
            case "WEBSITE_KEYWORDS":
                configInfo.setWebsiteKeywords(value);
                break;
            case "WEBSITE_AUTHOR":
                configInfo.setWebsiteAuthor(value);
                break;
            case "WEBSITE_COPYRIGHT":
                configInfo.setWebsiteCopyright(value);
                break;
            case "WEBSITE_VERSION":
                configInfo.setWebsiteVersion(value);
                break;

            // 联系信息
            case "CONTACT_QQ":
                configInfo.setContactQQ(value);
                break;
            case "CONTACT_EMAIL":
                configInfo.setContactEmail(value);
                break;
            case "CONTACT_WECHAT":
                configInfo.setContactWeChat(value);
                break;

            // 社交链接（JSON格式）
            case "SOCIAL_LINKS":
                if (StringUtils.isNotBlank(value)) {
                    try {
                        List<WebsiteConfigInfo.SocialLink> socialLinks = JSON.parseArray(value, WebsiteConfigInfo.SocialLink.class);
                        configInfo.setSocialLinks(socialLinks);
                    } catch (Exception e) {
                        log.warn("解析社交链接JSON失败: {}", value, e);
                    }
                }
                break;
        }
    }

}