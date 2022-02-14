package com.project.nadaum.culture.schedule.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.schedule.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ScheduleDaoImpl implements ScheduleDao {
	

	@Autowired
	private SqlSessionTemplate session;
	@Override
	public int insertSchedule(Schedule schedule) {
		return session.insert("schedule.insertSchedule", schedule);
	}

	@Override
	public Schedule selectOneBoardScheduleCheck(String schedulecode) {
		return session.selectOne("schedule.selectOneboardScheduleCheck", schedulecode);
	}

	@Override
	public int insertFinalSchedule(Map<String, Object> map) {
		return session.insert("schedule.insertFinalSchedule", map);
	}

	@Override
	public int insertFinalSecondSchedule(Map<String, Object> map) {
		return session.insert("schedule.insertFinalSecondSchedule", map);
	}

}
