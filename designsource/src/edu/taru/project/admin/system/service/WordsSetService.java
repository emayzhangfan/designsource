package edu.taru.project.admin.system.service;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import edu.taru.project.admin.system.dao.WordsSetDao;
import edu.taru.project.admin.system.entity.Bulletin;
import edu.taru.project.admin.system.entity.Sentence;

@IocBean
public class WordsSetService {

	@Inject
	private WordsSetDao wordsSetDao;
	
	public Bulletin findBulletin() {
		return wordsSetDao.search(Bulletin.class, "id").get(0);
	}
	
	public Sentence findSentence() {
		return wordsSetDao.search(Sentence.class, "id").get(0);
	}
	
	public Bulletin getBulletin(String id) {
		return wordsSetDao.find(Bulletin.class, id);
	}
	
	public Sentence getSentence(String id) {
		return wordsSetDao.find(Sentence.class, id);
	}
	
	public boolean updateBulletin(Bulletin bulletin) {
		return wordsSetDao.update(bulletin);
	} 
	
	public boolean updateSentence(Sentence sentence) {
		return wordsSetDao.update(sentence);
	}
}
