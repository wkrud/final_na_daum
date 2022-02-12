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

	private Likes like;
	private int commentCount;
	private int likeCount;
	private String nickname;
	private String profile;
    private String loginType;
    private String profileStatus;
    private String name;
	private String tier;
	private String rank;
	private int leaguePoints;
	private int wins;
	private int losses;
	public Board(String code, String title, String id, String content, String category, int readCount, Date regDate,
			MemberEntity member, Likes like, int commentCount, int likeCount, String nickname, String profile,
			String loginType, String profileStatus, String name, String tier, String rank, int leaguePoints, int wins,
			int losses) {
		super(code, title, id, content, category, readCount, regDate);
		this.like = like;
		this.commentCount = commentCount;
		this.likeCount = likeCount;
		this.nickname = nickname;
		this.profile = profile;
		this.loginType = loginType;
		this.profileStatus = profileStatus;
		this.name = name;
		this.tier = tier;
		this.rank = rank;
		this.leaguePoints = leaguePoints;
		this.wins = wins;
		this.losses = losses;
	}
	
	
	
	
	
	
	
	
	
}
