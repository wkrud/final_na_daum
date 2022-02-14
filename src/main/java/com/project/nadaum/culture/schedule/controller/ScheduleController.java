package com.project.nadaum.culture.schedule.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.nadaum.culture.schedule.model.service.ScheduleService;
import com.project.nadaum.culture.schedule.model.vo.Schedule;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/culture")
public class ScheduleController {
	
	@Autowired
	private ScheduleService scheduleService;
	
		//약속 insert
			@PostMapping("/board/view/{apiCode}/schedule")
			public ResponseEntity<?> insertSchedule(@RequestParam Map<String,Object> map) throws ParseException{
				
				log.debug("map = {}", map);
				String title = (String) map.get("title");
				String startDatebefore = (String) map.get("startDate");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate = format.parse(startDatebefore);
				String friendId = (String) map.get("friendId");
				String apiCode = (String) map.get("apiCode");
				String id = (String) map.get("id");

				Schedule schedule = new Schedule(null, friendId, '\u0000', apiCode, startDate, 1, id, title);
				
				log.debug("title={}",title);
				try{
					
					String schedulecode = scheduleService.insertSchedule(schedule);
//					int result = cultureService.insertSchedule(map);
					
					log.debug("schedulecode={}", schedulecode);
					
					if(schedulecode != null) {
						int result  = 1;
						log.debug("result={}", result);
						String msg = (result > 0) ? "약속잡기 성공" : "약속잡기 실패";
						map.put("schedulecode", schedulecode);
						map.put("result", result);
						map.put("msg", msg);
						
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
			
			@GetMapping("/boardScheduleCheck.do")
			public Map<String, Object> boardScheduleCheck(@RequestParam String schedulecode) {

				Map<String, Object> param = new HashMap<>();
			
				Schedule checkresult = scheduleService.selectOneboardScheduleCheck(schedulecode);
				char accept = checkresult.getAccept();
				int allDay = checkresult.getAllDay();
				String friendnickname = checkresult.getFriendId();
				String mynickname = checkresult.getId();
				Date startDate = checkresult.getStartDate();
				String content = checkresult.getTitle();
				String friendid = checkresult.getId();
				
				param.put("accept", accept);
				param.put("allDay", allDay);
				param.put("friendnickname", friendnickname);
				param.put("mynickname", mynickname);
				param.put("startDate", startDate);
				param.put("content", content);
				param.put("friendid", friendid);
				
				return param;
			}

			
			@PostMapping("/boardReceiveSchedule.do")
			public ResponseEntity<?> insertReceiveSchedule(@RequestParam Map<String, Object> map ) throws ParseException {

				log.debug("map = {}", map);
				String id = (String) map.get("id");
				String friendid = (String) map.get("friendid");
				String a  = (String) map.get("startDate");
				String b  = (String) map.get("endDate");
				
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate = sdf.parse(a);
				Date endDate = sdf.parse(b);
				
				map.put("startDate", startDate);
				map.put("endDate", endDate);
				
				
			
				try {
						map.remove("friendid");
						log.debug("map = {}", map);
					 int result = scheduleService.insertFinalSchedule(map);
					 	map.put("friendid",friendid);
					 	map.remove("id");
					 	log.debug("map = {}", map);
					 int result2 = scheduleService.insertFinalSecondSchedule(map);
					 
					 log.debug("result={}", result2);
					 String msg = (result2 > 0) ? "약속수락 성공" : "약속수락 실패";
					 map.put("msg", msg);
					
								
					
					if (result == 1) {

						return ResponseEntity.ok(map);
					} else {
						return ResponseEntity.status(404).build();
					}

				} catch (Exception e) {
					log.error(e.getMessage(), e);
					return ResponseEntity.badRequest().build();
				}

			}
			
}
