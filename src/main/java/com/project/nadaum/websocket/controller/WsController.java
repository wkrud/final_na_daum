package com.project.nadaum.websocket.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.websocket.model.service.WebsocketService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class WsController {
	
	@Autowired
	private WebsocketService websocketService;
	
	@GetMapping("/websocket/wsCountAlarm.do")
	public ResponseEntity<?> wsCountAlarm(@AuthenticationPrincipal Member member){
		List<Map<String, Object>> alarmList = websocketService.selectAlarmCount(member);
		return ResponseEntity.ok(alarmList);
	}
	
	@PostMapping("/websocket/checkAlarm.do")
	public ResponseEntity<?> checkAlarm(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member){
		map.put("id", member.getId());
		int result = websocketService.updateAlarm(map);
		return ResponseEntity.ok(result);
	}
	
	
	
}
