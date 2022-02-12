package com.project.nadaum.main.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.main.model.vo.Widget;

public interface MainService {

	List<Widget> allWidgetList(Map<String, Object> param);

	int insertTodoList(Map<String, Object> param);

	List<TodoList> userTodoList(Map<String, Object> param);

	int deleteTodoList(Map<String, Object> map);

	int insertWidget(Map<String, Object> param);


}
