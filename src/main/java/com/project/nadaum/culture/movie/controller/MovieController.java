package com.project.nadaum.culture.movie.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.nadaum.culture.movie.model.service.MovieService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class MovieController {
	
	//네이버 api 키값
//	private final String CLIENT_ID = "WH5aVPOr1A2Izr2MHbez";
//	private final String CLIENT_SECRET = "pMaufGCz0_";
//	private final String OpenNaverMovieUrl_getMovies = "https://openapi.naver.com/v1/search/movie.json?query={keyword}";

	@Autowired
	private MovieService movieService;
	
	
	//평점 평균
	
	
	//스크랩
	@ResponseBody
	@GetMapping("/movieDeleteScrap.do")
	public Map<String, Object> movieDeleteScrap(@RequestParam String apiCode, @RequestParam String id) {
		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", apiCode);
		param.put("id", id);
		log.debug("Scrapmap {}",param);
		
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
		log.debug("Scrapmap {}",param);
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
	public Map<String, Object> movieCheckScrap(@RequestParam String apiCode, @RequestParam String id){
//		log.debug("Scrapmap {}",param);
		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", apiCode);
		param.put("id", id);
		
		log.debug("ScraCheckpmap {}",param);
		
		
		int checkScrap = movieService.checkScrap(param);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("checkScrap", checkScrap);
		
		return map;
	}

	


}

