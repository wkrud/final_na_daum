package com.project.nadaum.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.accountbook.model.vo.AccountBook;
import com.project.nadaum.main.model.service.MainService;
import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private MainService mainService;

	@RequestMapping(value="/main.do")
	public void main(@AuthenticationPrincipal Member member, Model model) {
		
	}
	
	@RequestMapping(value="/todoList.do")
	public void todoList(@AuthenticationPrincipal Member member, Model model) {
		
	}
	
	@PostMapping(value="/insertTodoList.do")
	public String insertTodoList(TodoList todoList, Model model) {
		int insertTodoList = mainService.insertTodoList(todoList);
		return "redirect:/main/main.do";
	}
	
//	@RequestMapping(value="/userTodoList.do")
//	public String userTodoList(@AuthenticationPrincipal Member member, Model model) {
//		String id = member.getId();
//		 Map<String, Object> param = new HashMap<>(); 
//		 param.put("id", id);
//		  //로그인한 아이디로 등록된 가계부 전체 목록
//		 List<TodoList> allTodoList = mainService.userTodoList(param);
//
//		 model.addAttribute("allTodoList",allTodoList);
//	}

}