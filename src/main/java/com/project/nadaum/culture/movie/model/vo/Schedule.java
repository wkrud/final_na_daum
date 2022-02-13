package com.project.nadaum.culture.movie.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Schedule implements Serializable {

	private String code; //스케줄 테이블 코드
	private String friendId ;
	private boolean accept; //default 'n' 수락여부
	private String apiCode;
	private Date startDate;
	private int allDay; //default 0 종일 일정
	private String id; //주선자 약속잡은 사람
	private String title;
}
