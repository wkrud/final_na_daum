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
public class MetadataDto implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private String dataVersion;
	private String matchId;
	private List<String> participants;
	
	



}
