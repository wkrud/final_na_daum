package com.project.nadaum.websocket.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String room;
	private String writer;
	private String message;
	private String type;
	private String profile;
	private String time;
	private String greeting;
	private String out;
	private String[] check;

}
