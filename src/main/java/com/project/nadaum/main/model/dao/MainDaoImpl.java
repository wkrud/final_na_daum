package com.project.nadaum.main.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.main.model.vo.Widget;

@Repository
public class MainDaoImpl implements MainDao {
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Widget> allWidgetList(Map<String, Object> param) {
		return session.selectList("main.allWidgetList", param);
	}
	
	@Override
	public int insertWidget(Map<String, Object> param) {
		return session.insert("main.insertWidget", param);
	}

	@Override
	public int deleteWidget(Map<String, Object> map) {
		return session.delete("main.deleteWidget", map);
	}

	@Override
	public int insertTodoList(Map<String, Object> param) {
		return session.insert("main.insertTodoList", param);
	}

	@Override
	public List<TodoList> userTodoList(Map<String, Object> param) {
		return session.selectList("main.userTodoList", param);
	}

	@Override
	public int deleteTodoList(Map<String, Object> map) {
		return session.delete("main.deleteTodoList", map);
	}

	
	

}
