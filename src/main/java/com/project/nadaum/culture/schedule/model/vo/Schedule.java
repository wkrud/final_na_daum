package com.project.nadaum.culture.schedule.model.vo;

import java.io.Serializable;
import java.util.Date;

import com.project.nadaum.board.model.vo.RiotSchedule;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Schedule implements Serializable {

	private String code;
	private String friendId;
	private char accept;
	private String apiCode;
	private Date startDate;
	private int allDay;
	private String id;
	private String title;
}
