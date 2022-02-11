package com.project.nadaum.riot.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.riot.model.vo.LeagueEntry;
import com.project.nadaum.riot.model.vo.RiotFavo;
import com.project.nadaum.riot.model.vo.Summoner;

@Repository
public class RiotDaoImpl implements RiotDao {

	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertSummoner(Summoner summoner) {
		
		return session.insert("riot.insertSummoner",summoner);
	}
	
	
	@Override
	public Summoner selectOneSummoner(String puuid) {
		
		return session.selectOne("riot.selectOneSummoner",puuid);
	}


	@Override
	public int insertRiotFavo(Map<String, Object> map) {
		return session.insert("riot.insertRiotFavo", map);
	}




	@Override
	public int deleteFav(Map<String, Object> map) {
		
		return session.delete("riot.deleteFav", map);
	}


	@Override
	public int selectOneAccount(Map<String, Object> map) {
		
		return session.selectOne("riot.selectOneAccount", map);
	}


	@Override
	public int selectOneDetailAccount(Map<String, Object> map) {
		
		return session.selectOne("riot.selectOneDetailAccount", map);
	}


	@Override
	public RiotFavo selectOneAccountName(Map<String, Object> map) {
	
		return session.selectOne("riot.selectOneAccountName", map);
	}


	@Override
	public int selectOneMemberAccount(Map<String, Object> map) {
		
		return session.selectOne("riot.selectOneMemberAccount", map);
	}


	@Override
	public int insertLeagueEntry(LeagueEntry leagueentry) {
		
		return session.insert("riot.insertLeagueEntry", leagueentry);
	}


	@Override
	public LeagueEntry selectOneLeagueEntry(String summonerId) {
		
		return session.selectOne("riot.selectOneLeagueEntry",summonerId);

	}
	

}
