package com.project.nadaum.culture.movie.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.culture.movie.model.service.MovieService;
import com.project.nadaum.culture.schedule.model.vo.Schedule;
import com.project.nadaum.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class MovieController {

	// 네이버 api 키값
//	private final String CLIENT_ID = "WH5aVPOr1A2Izr2MHbez";
//	private final String CLIENT_SECRET = "pMaufGCz0_";
//	private final String OpenNaverMovieUrl_getMovies = "https://openapi.naver.com/v1/search/movie.json?query={keyword}";

	final static String SERVICEKEY = "5640ea577618caa1d5cefe4b2fea1683";

	@Autowired
	private MovieService movieService;

	@Autowired
	private ServletContext application;

	@Autowired
	private MemberService memberService;
	
//	@Autowired
//	private SheduleService sheduleService;
	
	@GetMapping("/schedulePopup.do")
	public void schedulePopup () {}
	
	//약속 수락 -> 캘린더
//	@PostMapping("/insertCalendarMovie")
//	public ResponseEntity<?> insertCalendarMovie(
//			@RequestParam Map<String, Object> map, 
//			Schedule schedule,
//			Model model) {
//		
//		log.debug("insertCalendarMovie map = {}", map);
//		
//		try {
//			String code = (String) map.get("code");
//			
//			// 수락여부가 n -> y로 변경 되면 캘린더에 insert
//			int updateAccept = movieService.updateAccept(code);
//			
//			System.out.println(map);
//			if (updateAccept == 1) {
//				int result = movieService.insertCalendarMovie(map);
//				log.debug("result={}", result);
//				String msg = (result > 0) ? "캘린더추가 성공" : "캘린더추가 실패";
//
//				map.put("result", result);
//				map.put("msg", msg);
//				return ResponseEntity.ok(map);
//
//			} else {
//				return ResponseEntity.status(404).build();
//			}
//
//		} catch (Exception e) {
//			log.error(e.getMessage(), e);
//			return ResponseEntity.badRequest().build();
//		}
//	}
	@PostMapping("/movieDetail/{apiCode}/insertCalendar")
	public ResponseEntity<?> insertCalendarMovie(@RequestParam Map<String, Object> map, @PathVariable String schedulecode) throws ParseException {

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
			 int result = movieService.insertCalendarMovie(map);
			 	map.put("friendid",friendid);
			 	map.remove("id");
			 	log.debug("map = {}", map);
			 int result2 = movieService.insertCalendarMovieFriend(map);
			 
			 log.debug("result2={}", result2);
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

		//약속체크하기
		@ResponseBody
		@GetMapping("/movieDetail/{apiCode}/movieScheduleCheck")
		public Map<String, Object> selectOneSchedule(@PathVariable String schedulecode){
			
			Map<String, Object> param = new HashMap<>();
			log.info("schedulecode = {}", schedulecode);
			
			Schedule checkresult = movieService.selectOneSchedule(schedulecode);
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
	
	// 약속
//	@ResponseBody
	@PostMapping("/movieDetail/{apiCode}/schedule")
	public ResponseEntity<?> insertSchedule( @RequestParam Map<String, Object> map, Model model) throws Exception {
		try {
			log.debug("insertSchedule map = {}", map);
			
			String title = (String) map.get("title");
			String startDatebefore = (String) map.get("startDate");
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = format.parse(startDatebefore);
			String friendId = (String) map.get("friendId");
			String apiCode = (String) map.get("apiCode");
			String id = (String) map.get("id");
			
			Schedule movieSchedule = new Schedule(null, friendId, '\u0000', apiCode, startDate, 1, id, title);
			
			String schedulecode = movieService.insertSchedule(movieSchedule);
			log.info("Schedulecode={}", schedulecode);
			if (schedulecode != null) {
				int result = 1;
				log.debug("result={}", result);
				
				String msg = (result > 0) ? "약속잡기 성공" : "약속잡기 실패";
				
				map.put("schedulecode", schedulecode);
				map.put("result", result);
				map.put("msg", msg);
				System.out.println(map);

				return ResponseEntity.ok(map);
			} else {
				return ResponseEntity.status(404).build();
			}

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}
	}
	
	
	 @GetMapping("/movieDetail/{apiCode}/schedule/{schedulecode}") 
	 public String movieScheduleDetail(@RequestParam String schedulecode, @RequestParam Map<String,Object> map, Model model) {
		 log.debug("scheduleDetail code = {}", schedulecode);
		 log.debug("scheduleDetail map = {}", map);
		 
		 Map<String, Object> param = new HashMap<>();
		 
//		 String code = (String) map.get("code");
		 Schedule checkresult = movieService.selectOneSchedule(schedulecode);
		 
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
		 
//		 model.addAttribute("scheduleDetail", scheduleDetail);
		 
		 return "common/movieScheduleDetail";
	 }
	
	
	
	
	
	// 스크랩
	@ResponseBody
	@GetMapping("/movieDeleteScrap.do")
	public Map<String, Object> movieDeleteScrap(@RequestParam String apiCode, @RequestParam String id) {
		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", apiCode);
		param.put("id", id);
		log.debug("Scrapmap {}", param);

		int result = movieService.deleteScrap(param);
		log.debug("스크랩 삭제 result = {}", result);

		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		return map;
	}

	@ResponseBody
	@GetMapping("/movieInsertScarp.do")
	public Map<String, Object> movieInsertScarp(@RequestParam String apiCode, @RequestParam String id) {
		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", apiCode);
		param.put("id", id);
		log.debug("Scrapmap {}", param);
		int result = 0;

		result = movieService.insertScrap(param);
//		//스크랩을 했었는지 중복확인
//		int scrap = movieService.checkScrap(param);
//		if(scrap == 0) {
//			result = movieService.insertScrap(param);
//		}else if(scrap == 1) {
//			result = movieService.deleteScrap(param);
//		}
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);

		return map;

	}

	@ResponseBody
	@GetMapping("/movieCheckScrap.do")
	public Map<String, Object> movieCheckScrap(@RequestParam String apiCode, @RequestParam String id) {
//		log.debug("Scrapmap {}",param);
		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", apiCode);
		param.put("id", id);

		log.debug("ScraCheckpmap {}", param);

		int checkScrap = movieService.checkScrap(param);

		Map<String, Object> map = new HashMap<>();

		map.put("checkScrap", checkScrap);

		return map;
	}

	

}
