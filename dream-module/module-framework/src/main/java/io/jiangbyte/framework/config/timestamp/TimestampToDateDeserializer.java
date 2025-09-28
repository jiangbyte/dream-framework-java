package io.jiangbyte.framework.config.timestamp;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.util.Date;

/**
 * @author charlie-zhang-code
 * @version v1.0
 * @date 2025/4/13
 * @description 时间戳转日期
 */
public class TimestampToDateDeserializer extends JsonDeserializer<Date> {
    @Override
    public Date deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
        try {
            // 尝试解析为时间戳
            long timestamp = p.getLongValue();
            return new Date(timestamp);
        } catch (Exception e) {
            // 解析失败，使用当前时间
            return new Date();
        }
    }
}