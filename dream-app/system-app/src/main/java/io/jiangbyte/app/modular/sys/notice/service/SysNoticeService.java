package io.jiangbyte.app.modular.sys.notice.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import io.jiangbyte.app.modular.sys.notice.entity.SysNotice;
import io.jiangbyte.app.modular.sys.notice.param.SysNoticeAddParam;
import io.jiangbyte.app.modular.sys.notice.param.SysNoticeEditParam;
import io.jiangbyte.app.modular.sys.notice.param.SysNoticeIdParam;
import io.jiangbyte.app.modular.sys.notice.param.SysNoticePageParam;

import java.util.List;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-09-28
* @description 公告表 服务类
*/
public interface SysNoticeService extends IService<SysNotice> {
    Page<SysNotice> page(SysNoticePageParam sysNoticePageParam);

    void add(SysNoticeAddParam sysNoticeAddParam);

    void edit(SysNoticeEditParam sysNoticeEditParam);

    void delete(List<SysNoticeIdParam> sysNoticeIdParamList);

    SysNotice detail(SysNoticeIdParam sysNoticeIdParam);

    List<SysNotice> latest(int n);

    List<SysNotice> topN(int n);
}