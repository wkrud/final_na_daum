package com.project.nadaum.websocket.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.socket.TextMessage;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.websocket.model.service.WebsocketService;
import com.project.nadaum.websocket.model.vo.Alarm;
import com.project.nadaum.websocket.model.vo.Message;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MessageController {

	@Autowired
	private ServletContext application;
	
	@Autowired
	private WebsocketService websocketService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private SimpMessagingTemplate template;
	
	@GetMapping("/member/mypage/chat.do")
	public void chatMain(Model model, @RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member) {
		log.debug("map = {}", map);
		log.debug("member = {}", member);
		List<Map<String, Object>> friends = websocketService.selectAllFriendForInvite(member);
		model.addAttribute("friends", friends);
		model.addAttribute("member", member);
		model.addAttribute("room", (String)map.get("room"));
		model.addAttribute("guest", (String) map.get("guest"));
	}
	
	@MessageMapping("/chat/join")
	public Message sendMsg(Message message, @AuthenticationPrincipal Member member) {
		
		log.debug("message = {}", message);
		log.debug("member = {}", member);
				
		Gson gson = new GsonBuilder().create();
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HH.mm");
		String now = sdf.format(d);
		
		message.setGreeting(message.getWriter() + "님이 입장했습니다.");
		message.setTime(now);
		message.setType("GREETING");
		gson.toJson(message);
		
		
		template.convertAndSend("/topic/" + message.getRoom(), gson.toJson(message));
		return message;
	}
		
	@MessageMapping("/chat/{room}")
	@SendTo("/topic/{room}")
	public void showUsers(@AuthenticationPrincipal Member member, Message message) {
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("a HH.mm", Locale.KOREA);
		String now = sdf.format(d);
				
		String profile = application.getContextPath() + "/resources/upload/member/profile/";
		log.debug("profile = {}", profile);
		log.debug("member = {}", member);
		Gson gson = new GsonBuilder().create();
		if("D".equals(member.getLoginType()) && "Y".equals(member.getProfileStatus())) {
			message.setProfile(profile + member.getProfile());
		}else if("D".equals(member.getLoginType()) && "N".equals(member.getProfileStatus())) {
			message.setProfile(profile + "default_profile_cat.png");
		}else if("K".equals(member.getLoginType())) {			
			message.setProfile(member.getProfile());
		}
		message.setTime(now);
		
		if(message.getType() != null && "EMOTION".equals(message.getType())) {
			
		}else {
			message.setType("CHAT_TYPE");			
		}
		
		log.debug("message = {}", message);
		
		template.convertAndSend("/topic/" + message.getRoom(), gson.toJson(message));
		
	}
	
	@MessageMapping("/chat/out/{room}")
	@SendTo("/topic/{room}")
	public void out(Message message) {
		log.debug("out message = {}", message);
		message.setOut(message.getWriter() + "님이 퇴장하셨습니다.");
		message.setType("OUT");
		template.convertAndSend("/topic/" + message.getRoom(), new Gson().toJson(message));
	}
	
	@MessageMapping("/chat/invite/{guest}")
	@SendTo("/topic/{guest}")
	public void chatInvite(@Payload Alarm alarm) {
		log.debug("alarm = {}", alarm);
		Gson gson = new GsonBuilder().create();
		
		template.convertAndSend("/topic/" + alarm.getGuest(), gson.toJson(alarm));
	}
	
	@MessageMapping("/chat/friendStatus/{friendNickname}")
	@SendTo("/topic/{friendNickname}")
	public void friendAlarm(@Payload Alarm alarm) {
		
		Gson gson = new GsonBuilder().create();
		
		template.convertAndSend("/topic/" + alarm.getFriendNickname(), gson.toJson(alarm));
	}
	
	@MessageMapping("/chat/answerAlarm/{guest}")
	@SendTo("/topic/{guest}")
	public void answerAlarm(@Payload Alarm alarm) {
		log.debug("answerAlarm = {}", alarm);
		Gson gson = new GsonBuilder().create();
		
		template.convertAndSend("/topic/" + alarm.getGuest(), gson.toJson(alarm));
	}
	
	
	
	
}
