package edu.taru;

import org.nutz.dao.Dao;
import org.nutz.dao.util.Daos;
import org.nutz.integration.quartz.NutQuartzCronJobFactory;
import org.nutz.ioc.Ioc;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;

import edu.taru.common.base.RedisService;

public class MainSetup implements Setup {

	private static final Log log = Logs.get();
	
	public void init(NutConfig conf) {
        Ioc ioc = conf.getIoc();
        Dao dao = ioc.get(Dao.class);
        Daos.createTablesInPackage(dao, "edu.taru", false);
        // 获取NutQuartzCronJobFactory从而触发计划任务的初始化与启动
        ioc.get(NutQuartzCronJobFactory.class);
        
        /*
         * 测试发送邮件
         */
//        try {
//            HtmlEmail email = ioc.get(HtmlEmail.class);
//            email.setSubject("测试淘学网");
//            email.setMsg("This is a test mail ... :-)" + System.currentTimeMillis());
//            email.addTo("316217330@qq.com");
//            email.buildMimeMessage();
//            email.sendMimeMessage();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        
        /*
         * 测试redis
         */
//        JedisPool jedisPool = ioc.get(JedisPool.class);
//        try (Jedis jedis = jedisPool.getResource()) { // Java7的语法
//            String re = jedis.set("zhangfan", "zhangfan-1993/12/10");
//            log.debug("redis say : " + re);
//            re = jedis.get("zhangfan");
//            log.debug("redis say : " + re);
//        } finally {}
        
        /*
         * redis aop 测试
         */
        RedisService redis = ioc.get(RedisService.class);
        redis.set("redis", "##########缓存服务开启##########");
        log.info("redis open : "  + redis.get("redis"));
        log.info("redis flushAll : ##########清空缓存##########");
        redis.flushAll();
    }

    public void destroy(NutConfig conf) {
    	log.debug("##########over##########");
    }

}
