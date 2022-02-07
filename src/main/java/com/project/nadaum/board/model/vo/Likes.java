package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Likes implements Serializable{/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String id;
	private String code;

	
}
