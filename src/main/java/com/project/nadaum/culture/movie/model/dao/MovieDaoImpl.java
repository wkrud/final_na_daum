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
	public int checkScrap(Map<String, Object> map) {
		return session.selectOne("movie.checkScrap", map);
	}

	@Override
	public int insertScrap(Map<String, Object> map) {
		return session.insert("movie.insertScrap", map);
	}

	@Override
	public int deleteScrap(Map<String, Object> map) {
		return session.delete("movie.deleteScrap", map);
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


//	@Override
//	public List<Movie> selectMovieList() {
//		return session.selectList("movie.selectMovieList");
//	}

//	@Override
//	public Movie selectOneMovie(String code) {
//		return session.selectOne("movie.selectOneMovie", code);
//	}

//	@Override
//	public List<Movie> selectMovieList(Map<String, Object> param) {
//		int offset = (int) param.get("offset");
//		int limit = (int) param.get("limit");
//		RowBounds rowBounds = new RowBounds(offset, limit);
//		return session.selectList("board.selectMovieList", null, rowBounds);
//	}
	
	
//	@Override
//	public int selectTotalContent() {
//		return session.selectOne("movie.selectTotalContent");
//	}

//	@Override
//	public Movie selectOneMovieCollection(String code) {
//		return session.selectOne("movie.selectOneMovieCollection", code);
//	}

	


	
}
