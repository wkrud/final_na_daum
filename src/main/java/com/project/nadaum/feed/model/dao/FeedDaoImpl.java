package com.project.nadaum.feed.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FeedDaoImpl implements FeedDao {

	@Autowired
	private SqlSessionTemplate session;
	
}
