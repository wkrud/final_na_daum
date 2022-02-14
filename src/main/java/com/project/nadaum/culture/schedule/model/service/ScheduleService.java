package com.project.nadaum.culture.schedule.model.service;

import java.util.Map;

import com.project.nadaum.culture.schedule.model.vo.Schedule;

public interface ScheduleService {
	//============================================
	String insertSchedule(Schedule schedule);
	
	Schedule selectOneboardScheduleCheck(String schedulecode);
	
	int insertFinalSchedule(Map<String, Object> map);
	
	int insertFinalSecondSchedule(Map<String, Object> map);
	
	//영화
	String insertMovieSchedule(Schedule schedule);

	Schedule selectOneSchedule(String schedulecode);

	int insertCalendarMovie(Map<String, Object> map);

	int insertCalendarMovieFriend(Map<String, Object> map);
}
