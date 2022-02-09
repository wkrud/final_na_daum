package com.project.nadaum.riot.model.dao;

import java.util.Map;

import com.project.nadaum.riot.model.vo.RiotFavo;
import com.project.nadaum.riot.model.vo.Summoner;

public interface RiotDao {
	
	int insertSummoner(Summoner summoner);
	
	Summoner selectOneSummoner(String puuid);
	
	int insertRiotFavo(Map<String, Object> map);
	
	RiotFavo selectOneAccount(Map<String, Object> map);

	int deleteFav(Map<String, Object> map);


}
