package edu.taru.project.admin.system.entity;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Name;
import org.nutz.dao.entity.annotation.Table;

/**
 * 一句话 名言 谚语 等等
 * @author iFan
 *
 */
@Table("admin_sentence")
public class Sentence {

	@Name
	@Column("id")
	private String id;
	
	@Column("title")
	private String title;
	
	@Column("words")
	private String words;
	
	@Column("author")
	private String author;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWords() {
		return words;
	}

	public void setWords(String words) {
		this.words = words;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	
	
}
