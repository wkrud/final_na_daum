package com.project.nadaum.culture.movie.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.movie.model.vo.Movie;

public interface MovieService {

	int checkScrap(Map<String, Object> param);

	int insertScrap(Map<String, Object> param);

	int deleteScrap(Map<String, Object> param);

	double avgRating(String apiCode);

	List<Integer> listStar(String apiCode);

	int starCount1(String apiCode);
	int starCount2(String apiCode);
	int starCount3(String apiCode);
	int starCount4(String apiCode);
	int starCount5(String apiCode);

	int totalStarCount(String apiCode);

	
	
	
}
