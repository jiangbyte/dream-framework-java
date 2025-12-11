package io.jiangbyte.app.utils;

import java.util.Arrays;
import java.util.List;

/**
 * @author CharlieZhang
 * @version v1.0
 * @date 11/12/2025
 * @description TODO
 */
public class DataScopeUtil {
    public static final String DATASCOPE_ALL = "ALL"; // 1
    public static final String DATASCOPE_GROUP_AND_CHILD = "GROUP_AND_CHILD"; // 2
    public static final String DATASCOPE_GROUP = "GROUP"; // 3
    public static final String DATASCOPE_SELF = "SELF"; // 4

    // 权限优先级顺序（从高到低）
    private static final List<String> SCOPE_ORDER = Arrays.asList(
            DATASCOPE_ALL,
            DATASCOPE_GROUP_AND_CHILD,
            DATASCOPE_GROUP,
            DATASCOPE_SELF
    );

    /**
     * 比较两个数据权限范围，返回权限更大的那个（即数据可见范围更广）
     *
     * @param scope1 权限范围1
     * @param scope2 权限范围2
     * @return 权限更大的范围
     */
    public static String getHigherScope(String scope1, String scope2) {
        if (scope1 == null) return scope2;
        if (scope2 == null) return scope1;

        int index1 = SCOPE_ORDER.indexOf(scope1);
        int index2 = SCOPE_ORDER.indexOf(scope2);

        // 如果某个 scope 不在预定义列表中，默认视为最低权限（SELF）
        if (index1 == -1) index1 = SCOPE_ORDER.size();
        if (index2 == -1) index2 = SCOPE_ORDER.size();

        return index1 <= index2 ? scope1 : scope2;
    }

    /**
     * 从多个数据权限中获取最大的（即权限最高、范围最广的）
     *
     * @param scopes 多个权限范围
     * @return 最大的权限范围，若为空则返回 null
     */
    public static String getMaxScope(String... scopes) {
        if (scopes == null || scopes.length == 0) {
            return null;
        }
        String max = scopes[0];
        for (int i = 1; i < scopes.length; i++) {
            max = getHigherScope(max, scopes[i]);
        }
        return max;
    }

    /**
     * 从 List 中获取最大的数据权限范围
     *
     * @param scopes 权限范围列表，可为 null 或空
     * @return 最大的权限范围；若列表为空或全为 null，返回 null
     */
    public static String getMaxScope(List<String> scopes) {
        if (scopes == null || scopes.isEmpty()) {
            return null;
        }

        String max = null;
        for (String scope : scopes) {
            max = getHigherScope(max, scope);
        }
        return max;
    }

    /**
     * 判断某个权限是否包含另一个权限的数据范围（即 scope1 的权限 >= scope2）
     *
     * @param scope1 高权限范围
     * @param scope2 低权限范围
     * @return true 表示 scope1 能覆盖 scope2 的数据
     */
    public static boolean covers(String scope1, String scope2) {
        if (scope2 == null) return true;
        if (scope1 == null) return false;

        int index1 = SCOPE_ORDER.indexOf(scope1);
        int index2 = SCOPE_ORDER.indexOf(scope2);

        if (index1 == -1) index1 = Integer.MAX_VALUE;
        if (index2 == -1) index2 = Integer.MAX_VALUE;

        return index1 <= index2;
    }

}
