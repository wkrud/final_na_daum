package com.project.nadaum.culture.show.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.show.model.vo.Scrap;

public interface CultureDao {

	int insertCultureLike(Map<String, Object> map);

	int deleteCultureLike(String apiCode);

	List<Scrap> selectCultureLikes(String id);
}
