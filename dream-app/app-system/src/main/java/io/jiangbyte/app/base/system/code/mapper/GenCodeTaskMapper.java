package io.jiangbyte.app.base.system.code.mapper;

import io.jiangbyte.app.base.system.code.entity.GenCodeTask;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author Charlie Zhang
* @version v1.0
* @date 2025-12-10
* @description 代码生成任务主表 Mapper 接口
*/
@Mapper
//@CacheNamespace(implementation = MybatisPlusRedisCache.class, eviction = MybatisPlusRedisCache.class)
public interface GenCodeTaskMapper extends BaseMapper<GenCodeTask> {

}
