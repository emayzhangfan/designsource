package edu.taru.quartz.test;

import org.nutz.integration.quartz.annotation.Scheduled;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;

@IocBean
@Scheduled
public class TestJob implements Job {

	private static final Log log = Logs.get();
	
	@Inject Scheduler scheduler;
	
	public void execute(JobExecutionContext context) throws JobExecutionException {
		log.debug("_________________________________");
		log.debug("______________定_________________");
		log.debug("______________时_________________");
		log.debug("______________器_________________");
		log.debug("______________OK_________________");
		log.debug("______________！_________________");
		log.debug("_________________________________");
	}
}
