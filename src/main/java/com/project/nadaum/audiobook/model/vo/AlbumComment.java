package com.project.nadaum.audiobook.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlbumComment implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int no;
	private String albumCode;
	private String writer;
	private String comments;
	private Date regDate;
	private boolean status; 
	
}
