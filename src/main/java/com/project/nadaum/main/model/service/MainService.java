package com.project.nadaum.main.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.main.model.vo.TodoList;

public interface MainService {

	int insertTodoList(TodoList todoList);

	List<TodoList> userTodoList(Map<String, Object> param);

}
