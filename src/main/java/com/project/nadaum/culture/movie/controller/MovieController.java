package com.project.nadaum.culture.movie.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	@PostMapping("/movieDetail/Scrap")
	public int scrap(Map<String, Object> map) {
		log.debug("Scrapmap {}",map);
		int result = 0;
		//스크랩을 했었는지 중복확인
		int scrap = movieService.checkScrap(map);
		if(scrap == 0) {
			result = movieService.insertScrap(map);
		}else if(scrap == 1) {
			result = movieService.deleteScrap(map);
		}
		return scrap;
		
	}
	
	

	


}

