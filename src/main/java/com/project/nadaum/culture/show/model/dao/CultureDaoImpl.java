package com.project.nadaum.culture.show.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.schedule.model.vo.Schedule;
import com.project.nadaum.culture.show.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CultureDaoImpl implements CultureDao {

	@Autowired
	private SqlSessionTemplate session;


	@Override
	public int deleteCultureLike(Map<String, Object> map) {
		return session.delete("culture.deleteCultureLike", map);
	}

	@Override
	public int insertCultureLike(Map<String, Object> map) {
		return session.insert("culture.insertCultureLike", map);
	}

	@Override
	public List<Scrap> selectCultureLikes(String id) {
		return session.selectList("culture.selectCultureLikes",id);
	}

	@Override
	public int selectCountLikes(Map<String, Object> map) {
		return session.selectOne("culture.selectCountLikes", map);
	}

	@Override
	public int selectCountLikes(String apiCode) {
		return session.selectOne("culture.selectCountLikes", apiCode);

	}

	//============================================
	@Override
	public double avgRating(String apiCode) {
		return session.selectOne("culture.avgRating", apiCode);
	}

	@Override
	public List<Integer> listStar(String apiCode) {
		return session.selectList("culture.listStar", apiCode);
	}

	@Override
	public int starCount1(String apiCode) {
		return session.selectOne("culture.starCount1",apiCode);
	}

	@Override
	public int starCount2(String apiCode) {
		return session.selectOne("culture.starCount2",apiCode);
	}

	@Override
	public int starCount3(String apiCode) {
		return session.selectOne("culture.starCount3",apiCode);
	}

	@Override
	public int starCount4(String apiCode) {
		return session.selectOne("culture.starCount4",apiCode);
	}

	@Override
	public int starCount5(String apiCode) {
		return session.selectOne("culture.starCount5", apiCode);
	}

	@Override
	public int totalStarCount(String apiCode) {
		return session.selectOne("culture.totalStarCount", apiCode);
	}
	
	//==========================================


	@Override
	public List<Scrap> selectCultureWidget(String id) {
		return session.selectList("culture.selectCultureWidget", id);
	}


	
}
