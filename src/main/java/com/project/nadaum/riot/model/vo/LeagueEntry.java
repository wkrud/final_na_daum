package com.project.nadaum.riot.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class LeagueEntry implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int no;
	private String leagueId;
	private String queueType;
	private String tier;
	private String rank;
	private int leaguePoints;
	private int wins;
	private int losses;

}
