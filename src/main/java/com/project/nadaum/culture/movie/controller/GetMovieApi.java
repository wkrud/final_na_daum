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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.movie.model.service.MovieService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class GetMovieApi {

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CommentService commentService;
	
	final static String SERVICEKEY = "5640ea577618caa1d5cefe4b2fea1683";
	
	//영화API
		@GetMapping("/movieList.do")
		public String getMovieApi(Model model) {
			  // TMDB api
			List<Map<String, Object>> upcomingList = new ArrayList<>();
			List<Map<String, Object>> topratedList = new ArrayList<>();
			List<Map<String, Object>> popularList = new ArrayList<>();
		
	        try {
	            //upcoming movie
	            String urlStr = "https://api.themoviedb.org/3/movie/upcoming";
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
//	            urlStr += "&"+ URLEncoder.encode("year","UTF-8") +"=2019";
//	            urlStr += "&"+ URLEncoder.encode("_returnType","UTF-8") +"=json";
	            
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
	            
	            JSONParser parser = new JSONParser(); //
	            
	            JSONObject obj = (JSONObject)parser.parse(result); //
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
	               
	                       
	                
	                Map<String, Object> map = new HashMap<>();
	                map.put("apiCode", id);
	                map.put("overview", overview);
	                map.put("posterPath", posterPath);
	                map.put("releaseDate", releaseDate);
	                map.put("title", title);
	                map.put("voteAverage", voteAverage);
	                
	                log.debug("map = {}" ,map);
	                
	                upcomingList.add(map);
	            }
	            
	            //top rated movie
	            String urlStr2 = "https://api.themoviedb.org/3/movie/top_rated";
	            urlStr2 += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr2 += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            urlStr2 += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
	            
	            URL url2 = new URL(urlStr2);
	            
	            String line2 = "";
	            String result2 = "";
	            
	            BufferedReader br2;
	            br2 = new BufferedReader(new InputStreamReader(url2.openStream()));
	            System.out.println("br2 = " + br2);                
	            
	            while ((line2 = br2.readLine()) != null) {
	                result2 = result2.concat(line2);
	                System.out.println("line2 = "+ line2);                
	            }            
	            
	            // JSON parser 만들어 문자열 데이터를 객체화한다.
	            
	            JSONParser parser2 = new JSONParser(); //
	            
	            JSONObject obj2 = (JSONObject)parser2.parse(result2); //
	            System.out.println("obj2 = "+ obj2); 
	            
	            // list 아래가 배열형태로
	            // "dates": {"maximum": "2022-03-09", "minimum": "2022-02-16"	        
	            JSONArray parse_listArr2 = (JSONArray)obj2.get("results");
	            System.out.println(parse_listArr2); 
	            String miseType2 = "";
	            
	            // 객체형태로
	            // {"returnType":"json","clearDate":"--",.......},... 
	            for (int i=0; i< parse_listArr2.size(); i++) {
	                JSONObject movie2 = (JSONObject) parse_listArr2.get(i);
	                
	                String id = String.valueOf(movie2.get("id"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
	                String overview = (String) movie2.get("overview");	// 상세정보
	                String posterPath = (String) movie2.get("poster_path");        // 포스터
	                String releaseDate = (String) movie2.get("release_date");	// 개봉날짜
	                String title = (String) movie2.get("title");            // 제목
	                Double voteAverage = Double.parseDouble(String.valueOf(movie2.get("vote_average")));        // 평균 평점
	               
	                       
	                
	                Map<String, Object> map2 = new HashMap<>();
	                map2.put("apiCode", id);
	                map2.put("overview", overview);
	                map2.put("posterPath", posterPath);
	                map2.put("releaseDate", releaseDate);
	                map2.put("title", title);
	                map2.put("voteAverage", voteAverage);
	                
	                log.debug("map2 = {}" ,map2);
	                
	                topratedList.add(map2);
	            }
	            
	            //top rated movie
	            String urlStr3 = "https://api.themoviedb.org/3/movie/popular";
	            urlStr3 += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr3 += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            urlStr3 += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
	            
	            URL url3 = new URL(urlStr3);
	            
	            String line3 = "";
	            String result3 = "";
	            
	            BufferedReader br3;
	            br3 = new BufferedReader(new InputStreamReader(url3.openStream()));
	            System.out.println("br3 = " + br3);                
	            
	            while ((line3 = br3.readLine()) != null) {
	                result3 = result3.concat(line3);
	                System.out.println("line3 = "+ line3);                
	            }            
	            
	            // JSON parser 만들어 문자열 데이터를 객체화한다.
	            
	            JSONParser parser3 = new JSONParser(); //
	            
	            JSONObject obj3 = (JSONObject)parser3.parse(result3); //
	            System.out.println("obj3 = "+ obj3); 
	            
	            // list 아래가 배열형태로
	            // "dates": {"maximum": "2022-03-09", "minimum": "2022-02-16"	        
	            JSONArray parse_listArr3 = (JSONArray)obj3.get("results");
	            System.out.println("parse_listArr3" + parse_listArr3); 
	   
	            
	            // 객체형태로
	            // {"returnType":"json","clearDate":"--",.......},... 
	            for (int i=0; i< parse_listArr3.size(); i++) {
	                JSONObject movie3 = (JSONObject) parse_listArr3.get(i);
	                
	                String id = String.valueOf(movie3.get("id"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
	                String overview = (String) movie3.get("overview");	// 상세정보
	                String posterPath = (String) movie3.get("poster_path");        // 포스터
	                String releaseDate = (String) movie3.get("release_date");	// 개봉날짜
	                String title = (String) movie3.get("title");            // 제목
	                Double voteAverage = Double.parseDouble(String.valueOf(movie3.get("vote_average")));        // 평균 평점
	               
	                       
	                
	                Map<String, Object> map3 = new HashMap<>();
	                map3.put("apiCode", id);
	                map3.put("overview", overview);
	                map3.put("posterPath", posterPath);
	                map3.put("releaseDate", releaseDate);
	                map3.put("title", title);
	                map3.put("voteAverage", voteAverage);
	                
	                log.debug("map3 = {}" ,map3);
	                
	                popularList.add(map3);
	            }
	            
	            model.addAttribute("upcomingList",upcomingList);
	            model.addAttribute("topratedList",topratedList);
	            model.addAttribute("popularList",popularList);
	            
	            
	            log.debug("upcomingList = {}" , upcomingList);
	            log.debug("topratedList = {}" , topratedList);
	            br.close();
	            br2.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "/movie/movieList";
	    }
		
		
		//검색 결과 movie
		@PostMapping("/movieSearch.do")
		public String movieSearch(
				@RequestParam String keyword,
				Model model) {
			
			  // TMDB api
			List<Map<String, Object>> searchList = new ArrayList<>();
		
		
	        try {
	            //upcoming movie
	            String urlStr = "https://api.themoviedb.org/3/search/movie";
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            urlStr += "&"+ URLEncoder.encode("query","UTF-8") +"="+keyword;
	            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
	            urlStr += "&"+ URLEncoder.encode("include_adult","UTF-8") +"=false";
	            
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
	            
	            JSONParser parser = new JSONParser(); //
	            
	            JSONObject obj = (JSONObject)parser.parse(result); //
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
	               
	                       
	                
	                Map<String, Object> map = new HashMap<>();
	                map.put("apiCode", id);
	                map.put("overview", overview);
	                map.put("posterPath", posterPath);
	                map.put("releaseDate", releaseDate);
	                map.put("title", title);
	                map.put("voteAverage", voteAverage);
	                
	                log.debug("map = {}" ,map);
	                
	                searchList.add(map);
	            }
	            model.addAttribute("searchList",searchList);
	            
	            
	            
	            log.debug("searchList = {}" , searchList);
	         
	            br.close();
	           
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return "/movie/movieSearch";
	    }
}
	