package com.project.nadaum.main.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.main.model.dao.MainDao;
import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.main.model.vo.Widget;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainDao mainDao;

	@Override
	public List<Widget> allWidgetList(Map<String, Object> param) {
		return mainDao.allWidgetList(param);
	}
	
	@Override
	public int insertWidget(Map<String, Object> param) {
		return mainDao.insertWidget(param);
	}
	
	@Override
	public int deleteWidet(Map<String, Object> map) {
		return mainDao.deleteWidget(map);
	}

	@Override
	public int insertTodoList(Map<String, Object> param) {
		return mainDao.insertTodoList(param);
	}

	@Override
	public List<TodoList> userTodoList(Map<String, Object> param) {
		return mainDao.userTodoList(param);
	}

	@Override
	public int deleteTodoList(Map<String, Object> map) {
		return mainDao.deleteTodoList(map);
	}

	
	
	
	

}
