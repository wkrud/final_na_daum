package com.project.nadaum.culture.schedule.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.show.model.service.CultureService;
import com.project.nadaum.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/culture")
public class ScheduleController {
	@Autowired
	private CultureService cultureService;
	
		//약속
	
			@PostMapping("/board/view/{apiCode}/schedule")
			public ResponseEntity<?> insertSchedule(@RequestParam Map<String,Object> map){
				
				log.debug("map = {}", map);
				
				try{
					int result = cultureService.insertSchedule(map);
					

					log.debug("result={}", result);
					String msg = (result > 0) ? "약속잡기 성공" : "약속잡기 실패";	
					
					map.put("result", result);
					map.put("msg", msg);
					
					System.out.println(map);
						if(result == 1) {
				            return ResponseEntity.ok(map);
				        } 
				        else {
				        	return ResponseEntity.status(404).build();
				        }
				
					}catch (Exception e) {
						log.error(e.getMessage(), e);
						return ResponseEntity.badRequest().build();
					}
			}
}
