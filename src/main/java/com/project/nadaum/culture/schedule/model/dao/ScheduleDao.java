package com.project.nadaum.culture.schedule.model.dao;

import java.util.Map;

import com.project.nadaum.culture.schedule.model.vo.Schedule;

public interface ScheduleDao {
	//=========================================
	int insertSchedule(Schedule schedule);

	Schedule selectOneBoardScheduleCheck(String schedulecode);

	int insertFinalSchedule(Map<String, Object> map);

	int insertFinalSecondSchedule(Map<String, Object> map);

	int insertMovieSchedule(Schedule schedule);

	Schedule selectOneSchedule(String schedulecode);

	int insertCalendarMovie(Map<String, Object> map);

	int insertCalendarMovieFriend(Map<String, Object> map);
}
