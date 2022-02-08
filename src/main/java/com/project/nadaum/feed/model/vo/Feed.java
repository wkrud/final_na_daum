package com.project.nadaum.feed.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper = true)
@NoArgsConstructor
public class Feed extends FeedEntity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int likes;
	private int attachCount;
	private List<Attachment> attachments;
	private int commentCount;
	private List<FeedComment> comments;
	private Member member;
	
	public Feed(String code, String writer, String content, Date regDate, String nickname, int attachCount,
			List<Attachment> attachments, int commentCount, List<FeedComment> comments, Member member) {
		super(code, writer, content, regDate, nickname);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.commentCount = commentCount;
		this.comments = comments;
		this.member = member;
	}
	
}
