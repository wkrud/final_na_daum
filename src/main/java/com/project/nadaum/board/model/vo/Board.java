package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.project.nadaum.member.model.vo.MemberEntity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString(callSuper=true)
@NoArgsConstructor
public class Board extends BoardEntity implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private MemberEntity member;
	private Likes like;
	private int commentCount;
	private int likeCount;
	private String nickname;
	
	
	public Board(String code, String title, String id, String content, String category, int readCount, Date regDate,
			MemberEntity member, Likes like, int commentCount, int likeCount, String nickname) {
		super(code, title, id, content, category, readCount, regDate);
		this.member = member;
		this.like = like;
		this.commentCount = commentCount;
		this.likeCount = likeCount;
		this.nickname = nickname;
	}
	
	
	
	
	
	
	
	
	
}
