package com.project.nadaum.riot.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.riot.model.dao.RiotDao;
import com.project.nadaum.riot.model.vo.RiotFavo;
import com.project.nadaum.riot.model.vo.Summoner;


@Service
public class RiotServiceImpl implements RiotService {
	
	@Autowired
	private RiotDao riotDao;

	@Override
	public int insertSummoner(Summoner summoner) {
		
		return riotDao.insertSummoner(summoner);
	}

	@Override
	public Summoner selectOneSummoner(String puuid) {
		
		return riotDao.selectOneSummoner(puuid);
	}

	@Override
	public int insertRiotFavo(Map<String, Object> map) {
		
		return riotDao.insertRiotFavo(map);
	}


	@Override
	public int deleteFav(Map<String, Object> map) {
		
		return riotDao.deleteFav(map);
	}

	@Override
	public int selectOneAccount(Map<String, Object> map) {
		
		return riotDao.selectOneAccount(map);
	}

	@Override
	public int selectOneDetailAccount(Map<String, Object> map) {
		
		return riotDao.selectOneDetailAccount(map);
	}

	@Override
	public RiotFavo selectOneAccountName(Map<String, Object> map) {
		
		return riotDao.selectOneAccountName(map);
	}


}
