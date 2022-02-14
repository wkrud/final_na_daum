package com.project.nadaum.main.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Memo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String code;
	private String content;
	private String id;

}
