package com.project.nadaum.riot.model.vo.riotDto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ObjectivesDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private ObjectiveDto baron;
	private ObjectiveDto champion;
	private ObjectiveDto dragon;
	private ObjectiveDto inhibitor;
	private ObjectiveDto riftHerald;
	private ObjectiveDto tower;
	



}
