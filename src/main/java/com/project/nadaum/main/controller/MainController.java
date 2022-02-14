package com.project.nadaum.main.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.main.model.service.MainService;
import com.project.nadaum.main.model.vo.TodoList;
import com.project.nadaum.main.model.vo.Widget;
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
		String id = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		
		List<Widget> widgetList = mainService.allWidgetList(param);
		log.debug("widgetList={}", widgetList);
		
		model.addAttribute("widgetList", widgetList);
	}
	
	//드래그존에 드롭시 위젯 테이블에 insert
	@ResponseBody
	@GetMapping(value="/insertWidget.do")
	public int insertWidget(@AuthenticationPrincipal Member member, @RequestParam String widgetName) {
		String id = member.getId();
		
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("widgetName", widgetName);
		
		int insertWidget = mainService.insertWidget(param);
		
		return insertWidget;
	}
	
	//위젯 삭제
	@ResponseBody
	@PostMapping(value="/deleteWidget.do")
	public Map<String, Object> deleteWidget (@AuthenticationPrincipal Member member, int no) {
		log.info("no={}",no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		int result = mainService.deleteWidet(map);
		return map;
	}
	
	//투두리스트 생성
	@ResponseBody
	@GetMapping(value="/insertTodoList.do")
	public int insertTodoList(@AuthenticationPrincipal Member member, Model model) {
		String id = member.getId();
		String content = "일정을 입력하세요.";
		Map<String, Object> param = new HashMap<>(); 
		param.put("id", id);
		param.put("content", content);
		
		int insertTodoList = mainService.insertTodoList(param);
		
		return insertTodoList;
	}
	
	//투두리스트 목록 조회
	@ResponseBody
	@RequestMapping(value="/userTodoList.do")
	public List<TodoList> userTodoList(@AuthenticationPrincipal Member member, Model model) {
		String id = member.getId();
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Date date = new Date();
		String title = format.format(date);
		
		Map<String, Object> param = new HashMap<>(); 
		param.put("id", id);
		param.put("title", title);
		//로그인한 아이디로 등록된 투두리스트 중 title이 사용자 입력값인 리스트
		List<TodoList> allTodoList = mainService.userTodoList(param);
		log.debug("allTodoList={}",allTodoList);

		return allTodoList;
	}
	
	//투두리스트 삭제
	@ResponseBody
	@PostMapping(value="/deleteTodoList.do")
	public Map<String, Object> deleteTodoList (@AuthenticationPrincipal Member member, int no) {
		log.info("no={}",no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", no);
		int result = mainService.deleteTodoList(map);
		return map;
	}
	
	//메모 insert
	@ResponseBody
	@GetMapping(value="/insertMemo.do")
	public int insertMemo(@AuthenticationPrincipal Member member, Model model) {
		String id = member.getId();
		String content = "메모를 입력하세요.";
		Map<String, Object> param = new HashMap<>(); 
		param.put("id", id);
		param.put("content", content);
		
		int insertMemo = mainService.insertMemo(param);
		
		return insertMemo;
	}
	
	//메모 목록 조회
		@ResponseBody
		@RequestMapping(value="/userMemoList.do")
		public List<TodoList> userMemoList(@AuthenticationPrincipal Member member, Model model) {
			String id = member.getId();
			Map<String, Object> param = new HashMap<>(); 
			param.put("id", id);

			//로그인한 아이디로 등록된 메모
			List<TodoList> allMemoList = mainService.userMemoList(param);
			log.debug("allMemo={}",allMemoList);

			return allMemoList;
		}
	//메모 업데이트
		@PostMapping(value="/updateMemoList.do")
		public String updateMemoList(@AuthenticationPrincipal Member member, @RequestParam String content, @RequestParam String code) {
			String id = member.getId();
			Map<String, Object> param = new HashMap<>(); 
			param.put("id", id);
			param.put("content", content);
			param.put("code", code);
			
			int updateMemoList = mainService.updateMemoList(param);
			
			return "redirect:/main/main.do";
		}
}