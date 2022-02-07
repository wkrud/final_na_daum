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
public class TeamDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private List<BanDto> bans;
	private ObjectivesDto objectives;
	private int teamId;
	private boolean win;
	
	



}
