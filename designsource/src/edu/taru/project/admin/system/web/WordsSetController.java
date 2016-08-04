package edu.taru.project.admin.system.web;

import java.util.Map;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.View;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.By;
import org.nutz.mvc.annotation.Filters;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.view.JspView;
import org.nutz.mvc.view.ViewWrapper;

import com.google.common.collect.Maps;

import edu.taru.common.Constants;
import edu.taru.common.utils.StringUtils;
import edu.taru.mvc.AdminCheckSession;
import edu.taru.project.admin.system.entity.Bulletin;
import edu.taru.project.admin.system.entity.Sentence;
import edu.taru.project.admin.system.service.WordsSetService;

/**
 * 后台 设置一些字段
 * @author iFan
 *
 */
@IocBean
@At("/admin/system/")
@Ok("json")
@Filters(@By(type=AdminCheckSession.class))
public class WordsSetController {

	@Inject
	private WordsSetService wordsSetService;
	
	/**
	 * View 查看/修改 公告牌
	 * @return
	 */
	public View bulletinInfo (Bulletin bulletin) {
		return new ViewWrapper(new JspView("views/admin/system/bulletinRecord"), bulletin); 
	}
	
	/**
	 * View 查看/修改 名言谚语
	 * @return
	 */
	public View sentenceInfo (Sentence sentence) {
		return new ViewWrapper(new JspView("views/admin/system/sentenceRecord"), sentence); 
	}
	
	/**
	 * 欢迎页 展示
	 * @return
	 */
	@At("ajax/show")
	public Map<String, Object> showAll(){
		Map<String,Object> params = Maps.newHashMap();
		params.put("bulletin", wordsSetService.findBulletin());
		params.put("sentence", wordsSetService.findSentence());
		return params;
	}
	
	/**
	 * 查看/修改 公告牌
	 * @param bulletin
	 * @return
	 */
	@At("bulletinRecord")
	public View bulletinRecord (@Param("..") Bulletin bulletin){
		if(StringUtils.isNotBlank(bulletin.getId())){
			if(wordsSetService.updateBulletin(bulletin))
				return bulletinInfo(wordsSetService.getBulletin(bulletin.getId()));
			else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
		}
		return bulletinInfo(wordsSetService.findBulletin());
	}
	
	/**
	 * 查看/修改 名言谚语
	 * @param sentence
	 * @return
	 */
	@At("sentenceRecord")
	public View sentenceRecord (@Param("..") Sentence sentence){
		if(StringUtils.isNotBlank(sentence.getId())){
			if(wordsSetService.updateSentence(sentence))
				return sentenceInfo(wordsSetService.getSentence(sentence.getId()));
			else return new ViewWrapper(new JspView("views/admin/error"), Constants.OPERATION_FAILE);
		}
		return sentenceInfo(wordsSetService.findSentence());
	}

}
