package com.project.nadaum.culture.show.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.show.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CultureDaoImpl implements CultureDao {

	@Autowired
	private SqlSessionTemplate session;


	@Override
	public int deleteCultureLike(String apiCode) {
		return session.delete("culture.deleteCultureLike", apiCode);
	}

	@Override
	public int insertCultureLike(Map<String, Object> map) {
		return session.insert("culture.insertCultureLike", map);
	}

	@Override
	public List<Scrap> selectCultureLikes(String id) {
		return session.selectList("culture.selectCultureLikes",id);
	}

	@Override
	public int selectCountLikes(Map<String, Object> map) {
		return session.selectOne("culture.selectCountLikes", map);
	}

	@Override
	public int selectCountLikes(String apiCode) {
		return session.selectOne("culture.selectCountLikes", apiCode);

	}

}
