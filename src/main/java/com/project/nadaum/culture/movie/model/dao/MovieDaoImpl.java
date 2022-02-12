package com.project.nadaum.culture.movie.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.movie.model.vo.Movie;


@Repository
public class MovieDaoImpl implements MovieDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int checkScrap(Map<String, Object> param) {
		return session.selectOne("movie.checkScrap", param);
	}

	@Override
	public int insertScrap(Map<String, Object> param) {
		return session.insert("movie.insertScrap", param);
	}

	@Override
	public int deleteScrap(Map<String, Object> param) {
		return session.delete("movie.deleteScrap", param);
	}

	@Override
	public double avgRating(String apiCode) {
		return session.selectOne("movie.avgRating", apiCode);
	}

	@Override
	public List<Integer> listStar(String apiCode) {
		return session.selectList("movie.listStar", apiCode);
	}

	@Override
	public int starCount1(String apiCode) {
		return session.selectOne("movie.starCount1",apiCode);
	}

	@Override
	public int starCount2(String apiCode) {
		return session.selectOne("movie.starCount2",apiCode);
	}

	@Override
	public int starCount3(String apiCode) {
		return session.selectOne("movie.starCount3",apiCode);
	}

	@Override
	public int starCount4(String apiCode) {
		return session.selectOne("movie.starCount4",apiCode);
	}

	@Override
	public int starCount5(String apiCode) {
		return session.selectOne("movie.starCount5", apiCode);
	}

	@Override
	public int totalStarCount(String apiCode) {
		return session.selectOne("movie.totalStarCount", apiCode);
	}

	


	
}
