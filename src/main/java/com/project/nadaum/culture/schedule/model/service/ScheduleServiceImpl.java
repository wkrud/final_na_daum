package com.project.nadaum.culture.schedule.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.culture.schedule.model.dao.ScheduleDao;
import com.project.nadaum.culture.schedule.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	private ScheduleDao scheduleDao;
	@Override
	public String insertSchedule(Schedule schedule) {
		int result = scheduleDao.insertSchedule(schedule);
		log.debug("code={}", schedule.getCode());
		String scheduleCode = schedule.getCode();
		return scheduleCode;
	}

	@Override
	public Schedule selectOneboardScheduleCheck(String schedulecode) {
		return scheduleDao.selectOneBoardScheduleCheck(schedulecode);
	}

	@Override
	public int insertFinalSchedule(Map<String, Object> map) {
		return scheduleDao.insertFinalSchedule(map);
	}

	@Override
	public int insertFinalSecondSchedule(Map<String, Object> map) {
		return scheduleDao.insertFinalSecondSchedule(map);
	}
	


	
}
