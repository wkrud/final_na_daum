package com.project.nadaum.culture.movie.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.movie.model.vo.*;

public interface MovieDao {

//	List<Movie> selectMovieList();

//	Movie selectOneMovie(String code);

//	List<Movie> selectMovieList(Map<String, Object> param);
	
//	int selectTotalContent();

//	Movie selectOneMovieCollection(String code);

	int checkScrap(Map<String, Object> map);

	int insertScrap(Map<String, Object> map);

	int deleteScrap(Map<String, Object> map);

	List<Object> avgRating(String apiCode);

	List<Integer> listStar(String apiCode);
}
