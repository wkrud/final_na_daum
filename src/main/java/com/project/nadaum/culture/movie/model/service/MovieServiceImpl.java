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
	public List<Object> avgRating(String apiCode) {
		return movieDao.avgRating(apiCode);
	}

	@Override
	public List<Integer> listStar(String apiCode) {
		return movieDao.listStar(apiCode);
	}
	


}