package com.project.nadaum.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping(value="/main2.do")
	public void main2(@AuthenticationPrincipal Member member, Model model) {
		
	}
	
	@PostMapping(value="/insertTodoList.do")
	public String insertTodoList(TodoList todoList, Model model) {
		int insertTodoList = mainService.insertTodoList(todoList);
		return "redirect:/main/main.do";
	}

}