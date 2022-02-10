package com.project.nadaum.culture.movie.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.culture.movie.model.dao.MovieDao;
import com.project.nadaum.culture.movie.model.vo.Movie;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
//@Transactional(rollbackFor = Exception.class)
public class MovieServiceImpl implements MovieService {

	@Autowired
	private MovieDao movieDao;

	@Override
	public int checkScrap(Map<String, Object> map) {
		return movieDao.checkScrap(map);
	}

	@Override
	public int insertScrap(Map<String, Object> map) {
		return movieDao.insertScrap(map);
	}

	@Override
	public int deleteScrap(Map<String, Object> map) {
		return movieDao.deleteScrap(map);
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
	


}