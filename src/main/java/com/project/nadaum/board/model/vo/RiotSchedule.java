package com.project.nadaum.board.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RiotSchedule implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;
	private String friendId;
	private char accept;
	private String apiCode;
	private Date startDate;
	private int allDay;
	private String id;
	private String title;
	
}
