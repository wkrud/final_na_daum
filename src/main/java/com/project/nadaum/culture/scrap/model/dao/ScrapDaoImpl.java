package com.project.nadaum.culture.scrap.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.culture.scrap.model.vo.Scrap;

@Repository
public class ScrapDaoImpl implements ScrapDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Scrap> selectScrapList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("scrap.selectScrapList", null, rowBounds);
	}

	@Override
	public int selectTotalContent() {
		return session.selectOne("scrap.selectTotalContent");
	}
	
}
