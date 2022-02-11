package com.project.nadaum.culture.movie.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.nadaum.culture.movie.model.service.MovieService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
//@RequestMapping("/movie")
public class JsonApiController {
	
	//	@Autowired
	//	private MovieService movieService;

	 public void widgetMovie(Model model) {
	        // TMDB api
			List<Map<String, Object>> widgetMovieList = new ArrayList<>();
		
	        try {
	            // 인증키
	            String serviceKey = "5640ea577618caa1d5cefe4b2fea1683";
	            
	            String urlStr = "https://api.themoviedb.org/3/movie/upcoming";
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + serviceKey;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
	            
	            URL url = new URL(urlStr);
	            
	            String line = "";
	            String result = "";
	            
	            BufferedReader br;
	            br = new BufferedReader(new InputStreamReader(url.openStream()));
	            System.out.println(br);                
	            
	            while ((line = br.readLine()) != null) {
	                result = result.concat(line);
	                System.out.println("line = "+ line);                
	            }            
	            
	            // JSON parser 만들어 문자열 데이터를 객체화한다.
	            JSONParser parser = new JSONParser();
	            JSONObject obj = (JSONObject)parser.parse(result);
	            System.out.println("obj = "+ obj); 
	            
	            // list 아래가 배열형태로
	            // "dates": {"maximum": "2022-03-09", "minimum": "2022-02-16"	        
	            JSONArray parse_listArr = (JSONArray)obj.get("results");
	            System.out.println(parse_listArr); 
	            String miseType = "";
	            
	            // 객체형태로
	            // {"returnType":"json","clearDate":"--",.......},... 
	            for (int i=0; i< parse_listArr.size(); i++) {
	                JSONObject movie = (JSONObject) parse_listArr.get(i);
	                
	                String id = String.valueOf(movie.get("id"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
	                String overview = (String) movie.get("overview");	// 상세정보
	                String posterPath = (String) movie.get("poster_path");        // 포스터
	                String releaseDate = (String) movie.get("release_date");	// 개봉날짜
	                String title = (String) movie.get("title");            // 제목
	                Double voteAverage = Double.parseDouble(String.valueOf(movie.get("vote_average")));        // 평균 평점
	                
//	                String issueVal  = (String) movie.get("issueVal");        // 발령농도
//	                String itemCode  = (String) movie.get("itemCode");        // 미세먼지 구분 PM10, PM25
//	                String issueGbn  = (String) movie.get("issueGbn");        // 경보단계 : 주의보/경보
//	                String clearDate = (String) movie.get("clearDate");        // 해제일자
//	                String clearTime = (String) movie.get("clearTime");        // 해제시간
//	                String clearVal = (String) movie.get("clearVal");            // 해제시 미세먼지농도
	                
	                Map<String, Object> map = new HashMap<>();
	                map.put("apiCode", id);
	                map.put("overview", overview);
	                map.put("posterPath", posterPath);
	                map.put("releaseDate", releaseDate);
	                map.put("title", title);
	                map.put("voteAverage", voteAverage);
	                
//	                log.debug("map = {}" ,map);
	                System.out.println("map = "+ map);                
	                
	                widgetMovieList.add(map);
	            }
	            
//	            log.debug("widgetMovieList = {}" , widgetMovieList);
	            System.out.println("widgetMovieList = "+ widgetMovieList);                
	            br.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        	model.addAttribute("widgetMovieList", widgetMovieList);
	    }
	
	
}
