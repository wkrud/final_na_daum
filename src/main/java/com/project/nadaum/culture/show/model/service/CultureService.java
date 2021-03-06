package com.project.nadaum.culture.show.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.RiotSchedule;
import com.project.nadaum.culture.schedule.model.vo.Schedule;
import com.project.nadaum.culture.show.model.vo.Scrap;


public interface CultureService {

	int insertCultureLike(Map<String, Object> map);

	int deleteCultureLike(Map<String, Object> map);

	List<Scrap> selectCultureLikes(String id);

	//===================================
	int selectCountLikes(Map<String, Object> map);

	int selectCountLikes(String apiCode);

	//======================================

	double avgRating(String apiCode);

	List<Integer> listStar(String apiCode);

	int starCount1(String apiCode);
	int starCount2(String apiCode);
	int starCount3(String apiCode);
	int starCount4(String apiCode);
	int starCount5(String apiCode);

	int totalStarCount(String apiCode);

	//==========================================

	List<Scrap> selectCultureWidget(String id);



	
}
