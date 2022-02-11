package com.project.nadaum.riot.model.service;

import java.util.Map;

import com.project.nadaum.riot.model.vo.LeagueEntry;
import com.project.nadaum.riot.model.vo.RiotFavo;
import com.project.nadaum.riot.model.vo.RiotWidget;
import com.project.nadaum.riot.model.vo.Summoner;

public interface RiotService {
	
	int insertSummoner(Summoner summoner);
	
	Summoner selectOneSummoner(String puuid);
	
	int insertRiotFavo(Map<String, Object> map);
	
	int selectOneDetailAccount(Map<String, Object> map);
	
	int selectOneMemberAccount(Map<String, Object> map);
	
	int selectOneAccount(Map<String, Object> map);
	
	RiotFavo selectOneAccountName(Map<String, Object> map);
	
	int deleteFav(Map<String, Object> map);

	int insertLeagueEntry(LeagueEntry leagueentry);

	LeagueEntry selectOneLeagueEntry(String summonerId);

	RiotWidget selectOneWidget(String member_id);
	

	
}
