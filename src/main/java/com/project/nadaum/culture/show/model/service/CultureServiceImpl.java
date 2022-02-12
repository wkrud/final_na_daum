package com.project.nadaum.culture.show.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.board.model.vo.Likes;
import com.project.nadaum.culture.show.model.dao.CultureDao;
import com.project.nadaum.culture.show.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CultureServiceImpl implements CultureService {
	
	@Autowired
	private CultureDao cultureDao;
	

	@Override
	public int deleteCultureLike(String apiCode) {
		return cultureDao.deleteCultureLike(apiCode);
	}

	@Override
	public int insertCultureLike(Map<String, Object> map) {
		return cultureDao.insertCultureLike(map);
	}

	@Override
	public List<Scrap> selectCultureLikes(String id) {
		return cultureDao.selectCultureLikes(id);
	}

	//==========================================
	@Override
	public int selectCountLikes(Map<String, Object> map) {
		return cultureDao.selectCountLikes(map);
	}
	
	@Override
	public int selectCountLikes(String apiCode) {
		return cultureDao.selectCountLikes(apiCode);
	}

	//===========================================
	@Override
	public double avgRating(String apiCode) {
		return cultureDao.avgRating(apiCode);
	}

	@Override
	public List<Integer> listStar(String apiCode) {
		return cultureDao.listStar(apiCode);
	}

	@Override
	public int starCount1(String apiCode) {
		return cultureDao.starCount1(apiCode);
	}

	@Override
	public int starCount2(String apiCode) {
		return cultureDao.starCount2(apiCode);
	}

	@Override
	public int starCount3(String apiCode) {
		return cultureDao.starCount3(apiCode);
	}

	@Override
	public int starCount4(String apiCode) {
		return cultureDao.starCount4(apiCode);
	}

	@Override
	public int starCount5(String apiCode) {
		return cultureDao.starCount5(apiCode);
	}

	@Override
	public int totalStarCount(String apiCode) {
		return cultureDao.totalStarCount(apiCode);
	}

	@Override
	public int insertSchedule(Map<String, Object> map) {
		return cultureDao.insertSchedule(map);
	}

	@Override
	public List<Scrap> selectCultureWidget(String id) {
		return cultureDao.selectCultureWidget(id);
	}
	


	



}
