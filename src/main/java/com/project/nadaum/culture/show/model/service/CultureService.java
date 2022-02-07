package com.project.nadaum.culture.show.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.culture.show.model.vo.Culture;

public interface CultureService {

	int insertCultureLike(Map<String, Object> map);

	int deleteCultureLike(String apiCode);

}
