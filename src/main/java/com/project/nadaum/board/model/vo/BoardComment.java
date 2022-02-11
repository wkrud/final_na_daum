package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.project.nadaum.member.model.vo.MemberEntity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private String commentCode;
	private String id;
	private String code; //보드 고유코드
	private String content;
	private int commentLevel; // 댓글 -> 1, 대댓글 -> 2
	private String commentRef; //대댓글인 경우, 참조하는 댓글번호 code,  댓글인 경우 null
	private Date regDate;
	private String profile;
    private String loginType;
    private String profileStatus;
	private String nickname;
}
