package com.project.nadaum.culture.movie.controller;

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
import com.project.nadaum.culture.movie.model.vo.Schedule;
import com.project.nadaum.culture.show.model.vo.Scrap;
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
	
	
	@GetMapping("/schedulePopup.do")
	public void schedulePopup () {}
	
	//약속 수락 -> 캘린더
	@PostMapping("/insertCalendarMovie.do")
	public ResponseEntity<?> insertCalendarMovie(
			@RequestParam Map<String, Object> map, 
			Schedule schedule,
			Model model) {
		
		log.debug("insertCalendarMovie map = {}", map);
		
		try {
			String code = (String) map.get("code");
			
			// 수락여부가 n -> y로 변경 되면 캘린더에 insert
			int updateAccept = movieService.updateAccept(code);
			
			System.out.println(map);
			if (updateAccept == 1) {
				int result = movieService.insertCalendarMovie(map);
				log.debug("result={}", result);
				String msg = (result > 0) ? "캘린더추가 성공" : "캘린더추가 실패";

				map.put("result", result);
				map.put("msg", msg);
				return ResponseEntity.ok(map);

			} else {
				return ResponseEntity.status(404).build();
			}

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}
	}

	// 약속
//	@ResponseBody
	@PostMapping("/movieDetail/{apiCode}/schedule")
	public ResponseEntity<?> insertSchedule(@RequestParam Map<String, Object> map, Model model) {
		log.debug("insertSchedule map = {}", map);

		try {
			int result = movieService.insertSchedule(map);

			log.debug("result={}", result);
			String msg = (result > 0) ? "약속잡기 성공" : "약속잡기 실패";

			map.put("result", result);
			map.put("msg", msg);

			System.out.println(map);
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
	
	
//	 @GetMapping("/movieScheduleDetail.do") 
//	 public String movieScheduleDetail(@RequestParam String code, @RequestParam Map<String,Object> map, Model model) {
//		 log.debug("scheduleDetail code = {}", code);
//		 log.debug("scheduleDetail map = {}", map);
//		 
////		 String code = (String) map.get("code");
//		 Map<String, Object> scheduleDetail = movieService.selectOneSchedule(code);
//		 
//		 model.addAttribute("scheduleDetail", scheduleDetail);
//		 
//		 return "common/movieScheduleDetail";
//	 }
	
	
	//물어보고 schedule 클래스 바꾸기
	@ResponseBody
	@GetMapping("/movieDetail/{apiCode}/schedule/{code}")
	public ResponseEntity<?> selectOneComment(@PathVariable String code){
		log.info("code = {}", code);
		Schedule schedule = movieService.selectOneSchedule(code);
		if(schedule != null) 
			return ResponseEntity.ok(schedule);
		else
			return ResponseEntity.notFound().build();
	}
	
	
//	//수정
//	@PutMapping("/movieDetail/{apiCode}/schedule")
//	public ResponseEntity<?> updateMenu(@RequestBody Comment comment){
//		log.debug("updateComment comment = {}", comment);
//		try {
//			int result = movieService.updateMovieComment(comment);
//			log.debug("updateComment result = {}", result);
//			
//			Map<String, Object> resultMap = new HashMap<>();
//			
//			resultMap.put("msg", "댓글 수정 성공!");
//			resultMap.put("result", result);
//			
////			if(result == 1) {
//                return ResponseEntity.ok(resultMap);
////            } 
////            else {
////            	return ResponseEntity.status(404).build();
////            }
//		} catch (Exception e) {
//			log.error(e.getMessage(), e);
//			return ResponseEntity.badRequest().build();
//		}
//	}
	
	
	
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
