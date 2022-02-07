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
public class InfoDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private long gameCreation;
	private long gameDuration;
	private long gameEndTimestamp;
	private long gameId;
	private String gameMode;
	private String gameName;
	private long gameStartTimestamp;
	private String gameType;
	private String gameVersion;
	private int mapId;
	private List<ParticipantDto> participants;
	private String platformId;
	private int queueId;
	private List<TeamDto> teams;
	private String tournamentCode;
	
	
	



}
