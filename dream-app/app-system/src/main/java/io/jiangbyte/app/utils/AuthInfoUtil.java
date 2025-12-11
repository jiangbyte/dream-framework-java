package io.jiangbyte.app.utils;

import cn.dev33.satoken.stp.StpUtil;

import java.util.List;

/**
 * @author CharlieZhang
 * @version v1.0
 * @date 11/12/2025
 * @description TODO
 */
public class AuthInfoUtil {
    public static String getAccountId() {
        return (String) StpUtil.getExtra("accountId");
    }

    public static List<String> getRoleIds() {
        return (List<String>) StpUtil.getExtra("roleIds");
    }

    public static List<String> getRoleCodes() {
        return (List<String>) StpUtil.getExtra("roleCodes");
    }

    public static List<String> getGroupIds() {
        return (List<String>) StpUtil.getExtra("groupIds");
    }

    public static List<String> getGroupCodes() {
        return (List<String>) StpUtil.getExtra("groupCodes");
    }

    public static String getMaxScope() {
        return (String) StpUtil.getExtra("maxScope");
    }

}
