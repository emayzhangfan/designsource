package edu.taru.common.base;

import static edu.taru.common.base.RedisInterceptor.jedis; // 静态导入

import org.nutz.ioc.aop.Aop;
import org.nutz.ioc.loader.annotation.IocBean;

@IocBean
public class RedisService {

    @Aop("redis")
    public void set(String key, String val) {
        jedis().set(key, val);
    }

    @Aop("redis") // 加上这个拦截器后jedis()才能返回Jedis实例
    public String get(String key) {
        return jedis().get(key);
    }
    
    @Aop("redis")
    public void del(String key) {
        jedis().del(key);
    }
    
    @Aop("redis")
    public void expire(String key, int seconds) {
        jedis().expire(key, seconds);
    }
    
    @Aop("redis")
    public void setex(String key, int seconds, String value) {
        jedis().setex(key, seconds, value);
    }
    
    @Aop("redis")
    public void flushAll() {
        jedis().flushAll();
    }
}
