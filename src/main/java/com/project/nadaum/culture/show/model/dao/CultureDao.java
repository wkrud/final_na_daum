package com.project.nadaum.culture.show.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.show.model.vo.Scrap;

public interface CultureDao {

	int insertCultureLike(Map<String, Object> map);

	int deleteCultureLike(String apiCode);

	List<Scrap> selectCultureLikes(String id);

	//=====================================
	int selectCountLikes(Map<String, Object> map);
	
	int selectCountLikes(String apiCode);
	
	//========================================
	double avgRating(String apiCode);

	List<Integer> listStar(String apiCode);

	int starCount1(String apiCode);
	int starCount2(String apiCode);
	int starCount3(String apiCode);
	int starCount4(String apiCode);
	int starCount5(String apiCode);

	int totalStarCount(String apiCode);

	int insertSchedule(Map<String, Object> map);

	List<Scrap> selectCultureWidget(String id);
}
