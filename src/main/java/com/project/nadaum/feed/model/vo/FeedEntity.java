package com.project.nadaum.feed.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FeedEntity implements Serializable {/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;
	private String writer;
	private String content;
	private Date regDate;
	private String nickname;

}
