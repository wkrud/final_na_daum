package com.project.nadaum.feed.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FeedComment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String fCode;
	private String commentWriter;
	private String content;
	private Date regDate;
	private String nickname;
	private String loginType;
	private String profile;

}
