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
	
	private int attachCount;
	private List<Attachment> attachments;
	private Member member;
	
	public Feed(String code, String writer, String content, Date regDate, int attachCount, List<Attachment> attachments,
			Member member) {
		super(code, writer, content, regDate);
		this.attachCount = attachCount;
		this.attachments = attachments;
		this.member = member;
	}
	
	
	
}
