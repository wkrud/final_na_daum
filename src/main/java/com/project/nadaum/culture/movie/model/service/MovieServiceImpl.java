package com.project.nadaum.culture.movie.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.culture.movie.model.dao.MovieDao;
import com.project.nadaum.culture.schedule.model.vo.Schedule;
import com.project.nadaum.culture.show.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
//@Transactional(rollbackFor = Exception.class)
public class MovieServiceImpl implements MovieService {

	@Autowired
	private MovieDao movieDao;

	@Override
	public int checkScrap(Map<String, Object> param) {
		return movieDao.checkScrap(param);
	}

	@Override
	public int insertScrap(Map<String, Object> param) {
		return movieDao.insertScrap(param);
	}

	@Override
	public int deleteScrap(Map<String, Object> param) {
		return movieDao.deleteScrap(param);
	}

	@Override
	public List<Scrap> selectMovieScrap(String id) {
		return movieDao.selectMovieScrap(id);
	}
	
	@Override
	public double avgRating(String apiCode) {
		return movieDao.avgRating(apiCode);
	}

	@Override
	public List<Integer> listStar(String apiCode) {
		return movieDao.listStar(apiCode);
	}

	@Override
	public int starCount1(String apiCode) {
		return movieDao.starCount1(apiCode);
	}

	@Override
	public int starCount2(String apiCode) {
		return movieDao.starCount2(apiCode);
	}

	@Override
	public int starCount3(String apiCode) {
		return movieDao.starCount3(apiCode);
	}

	@Override
	public int starCount4(String apiCode) {
		return movieDao.starCount4(apiCode);
	}

	@Override
	public int starCount5(String apiCode) {
		return movieDao.starCount5(apiCode);
	}

	@Override
	public int totalStarCount(String apiCode) {
		return movieDao.totalStarCount(apiCode);
	}

	@Override
	public String insertSchedule(Schedule movieSchedule) {
		
		int result = movieDao.insertSchedule(movieSchedule);
		log.debug("code = {}", movieSchedule.getCode());
		String Schedulecode = movieSchedule.getCode();
		
		return Schedulecode;
	}

//	@Override
//	public Map<String, Object> selectOneSchedule(String code) {
//		return movieDao.selectOneSchedule(code);
//	}

	@Override
	public Schedule selectOneSchedule(String schedulecode) {
		return movieDao.selectOneSchedule(schedulecode);
	}

	@Override
	public int insertCalendarMovie(Map<String, Object> map) {
		return movieDao.insertCalendarMovie(map);
	}

	@Override
	public int updateAccept(String code) {
		return movieDao.updateAccept(code);
	}

	@Override
	public int insertCalendarMovieFriend(Map<String, Object> map) {
		return movieDao.insertCalendarMovieFriend(map);
	}

	
	


}