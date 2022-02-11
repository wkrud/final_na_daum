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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;
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
	
	//영화API
	@GetMapping("/movieList.do")
	public ModelAndView getMovieApi(Model model) {
		  // TMDB api
		List<Map<String, Object>> list = new ArrayList<>();
	
        try {
            // 인증키
            String serviceKey = "5640ea577618caa1d5cefe4b2fea1683";
            
            String urlStr = "https://api.themoviedb.org/3/movie/upcoming";
            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + serviceKey;
            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
//            urlStr += "&"+ URLEncoder.encode("year","UTF-8") +"=2019";
//            urlStr += "&"+ URLEncoder.encode("_returnType","UTF-8") +"=json";
            
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
               
                       
                
                Map<String, Object> map = new HashMap<>();
                map.put("apiCode", id);
                map.put("overview", overview);
                map.put("posterPath", posterPath);
                map.put("releaseDate", releaseDate);
                map.put("title", title);
                map.put("voteAverage", voteAverage);
                
                log.debug("map = {}" ,map);
                
                list.add(map);
            }
            
            log.debug("list = {}" , list);
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("/movie/movieList", "list", list);
    }
	
	
	// 영화 상세정보API
		@GetMapping("/movieDetail/{apiCode}")
		public ModelAndView getMovieDetailApi(@PathVariable String apiCode, Model model) {
			log.debug("movieCd = {} ", apiCode);
			
			  // TMDB api
			List<Map<String, Object>> list = new ArrayList<>();
			
			Map<String, Object> map = new HashMap<>();
	        
			try {
	            // 인증키
	            String serviceKey = "5640ea577618caa1d5cefe4b2fea1683";
	            
	            String urlStr = "https://api.themoviedb.org/3/movie/" + apiCode;
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + serviceKey;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
//	            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
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
	            JSONParser parser = new JSONParser();
	            JSONObject obj = (JSONObject)parser.parse(result);
	            System.out.println("obj = "+ obj); 
	            
	            // list 아래가 배열형태로 []
	            // "dates": {"maximum": "2022-03-09", "minimum": "2022-02-16"	        
	            JSONArray parse_listArr = (JSONArray)obj.get("genres");
	            System.out.println(parse_listArr); 
	            String miseType = "";
	            
//	            JSONArray parse_listArr = (JSONArray)obj.get("genres");
	            
	            
	            // 객체형태로 {}
	            // {"returnType":"json","clearDate":"--",.......},... 
	            for (int i=0; i< parse_listArr.size(); i++) {
	                JSONObject movie = (JSONObject) parse_listArr.get(i);
	                
	                String genre = String.valueOf(movie.get("name"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
//	                String overview = (String) movie.get("overview");	// 상세정보
//	                String posterPath = (String) movie.get("poster_path");        // 포스터
//	                String releaseDate = (String) movie.get("release_date");	// 개봉날짜
//	                String title = (String) movie.get("title");            // 제목
//	                Double voteAverage = Double.parseDouble(String.valueOf(movie.get("vote_average")));        // 평균 평점

	                
	                map.put("genre", genre);
//	                map.put("overview", overview);
//	                map.put("posterPath", posterPath);
//	                map.put("releaseDate", releaseDate);
//	                map.put("title", title);
//	                map.put("voteAverage", voteAverage);
	                
	                log.debug("map = {}" ,map);
	                
	                list.add(map);	                
	            }
	            
	            //댓글목록 불러오기
	            List<Comment> commentList = commentService.selectMovieCommentList(apiCode);
				model.addAttribute("commentList",commentList);

				model.addAttribute("list",list);
				log.debug("list = {}" , list);
			
				
				//평점 평균
//				List<Integer> star = movieService.listStar(apiCode); //star 불어오기
//				log.debug("star{}", star);

				int totalStartComment = movieService.totalStarCount(apiCode); //총 star를 준 사람의 수
				if (totalStartComment != 0) {
	                double rating = movieService.avgRating(apiCode); //별점평균
	                log.debug("rating{}", rating);
	                model.addAttribute("rating", rating);
	            }

				int starCount1 = movieService.starCount1(apiCode);
				int starCount2 = movieService.starCount2(apiCode);
				int starCount3 = movieService.starCount3(apiCode);
				int starCount4 = movieService.starCount4(apiCode);
				int starCount5 = movieService.starCount5(apiCode);
				
				model.addAttribute("starCount1", starCount1);
				model.addAttribute("starCount2", starCount2);
				model.addAttribute("starCount3", starCount3);
				model.addAttribute("starCount4", starCount4);
				model.addAttribute("starCount5", starCount5);
				
				model.addAttribute("totalStartComment", totalStartComment);

	            br.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return new ModelAndView("/movie/movieDetail", "list", list);
	    }

	
}
	