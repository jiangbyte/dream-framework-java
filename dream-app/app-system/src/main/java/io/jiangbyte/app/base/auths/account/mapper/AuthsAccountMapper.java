package io.jiangbyte.app.base.auths.account.mapper;

import icu.mhb.mybatisplus.plugln.base.mapper.JoinBaseMapper;
import io.jiangbyte.framework.cache.MybatisPlusRedisCache;
import io.jiangbyte.app.base.auths.account.entity.AuthsAccount;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Mapper;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-12
* @description 核心账户表 Mapper 接口
*/
@Mapper
//@CacheNamespace(implementation = MybatisPlusRedisCache.class, eviction = MybatisPlusRedisCache.class)
//public interface AuthsAccountMapper extends BaseMapper<AuthsAccount> {
public interface AuthsAccountMapper extends JoinBaseMapper<AuthsAccount> {

}
