package com.project.nadaum.main.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.main.model.dao.MainDao;
import com.project.nadaum.main.model.vo.TodoList;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainDao mainDao;

	@Override
	public int insertTodoList(TodoList todoList) {
		return mainDao.insertTodoList(todoList);
	}
	
	

}
