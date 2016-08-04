package edu.taru.common.base;

/**
 * 
 * @author 张帆
 * @date 2016年3月28日
 */
public interface EmailService {

	boolean send(String to, String subject, String html);
}
