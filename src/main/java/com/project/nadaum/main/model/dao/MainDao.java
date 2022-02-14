package com.project.nadaum.main.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.main.model.vo.Widget;

public interface MainDao {

	List<Widget> allWidgetList(Map<String, Object> param);

	int insertWidget(Map<String, Object> param);
	
	int deleteWidget(Map<String, Object> map);

	int insertTodoList(Map<String, Object> param);

	List<TodoList> userTodoList(Map<String, Object> param);

	int deleteTodoList(Map<String, Object> map);

	int insertMemo(Map<String, Object> param);

	List<TodoList> userMemoList(Map<String, Object> param);

	int updateMemoList(Map<String, Object> param);



}
