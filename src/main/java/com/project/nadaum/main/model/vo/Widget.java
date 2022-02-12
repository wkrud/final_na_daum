package com.project.nadaum.main.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Widget implements Serializable {	
	private static final long serialVersionUID = 1L;

	private int no;
	private String id;
	private String widgetName;

}
