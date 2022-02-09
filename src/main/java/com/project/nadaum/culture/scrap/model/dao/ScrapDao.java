package com.project.nadaum.culture.scrap.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.scrap.model.vo.Scrap;


public interface ScrapDao  {

	List<Scrap> selectScrapList(Map<String, Object> param);

	int selectTotalContent();

	
}
