package com.project.nadaum.main.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.main.model.vo.TodoList;

@Repository
public class MainDaoImpl implements MainDao {
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertTodoList(TodoList todoList) {
		return session.insert("main.insertTodoList", todoList);
	}
	
	

}
