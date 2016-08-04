package edu.taru.quartz.job;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import edu.taru.common.base.RedisService;
import edu.taru.project.front.service.SearchTextService;

/**
 * 这个定时任务 用于更新缓存 availableTags
 * 搜索框更新
 * @author zhangfan
 *
 */
@IocBean
public class AvailableTagsRedisUpdateJob implements Job {

	private static final Log log = Logs.get();
	
	@Inject
	private SearchTextService searchTextService;
	
	@Inject 
	private RedisService redisService;
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
		log.debug(">>--执行定时任务-->>");
		log.debug(">>--更新Redis，key : availableTags");
		String availableTags = Json.toJson(searchTextService.availableTagsJson());
		redisService.set("availableTags", availableTags);
		log.debug(">>--更新成功！");
		log.debug(">>--value : " + redisService.get("availableTags"));
	}
}
