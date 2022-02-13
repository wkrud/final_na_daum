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
public class GetMovieDetailApi {

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CommentService commentService;
	
	// 인증키
	final static String SERVICEKEY = "5640ea577618caa1d5cefe4b2fea1683";
	
	// 영화 상세정보API
		@GetMapping("/movieDetail/{apiCode}")
		public ModelAndView getMovieDetailApi(@PathVariable String apiCode, Model model) {
			log.debug("apiCode = {} ", apiCode);
			
			  // TMDB api
			List<Map<String, Object>> list = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();			
	        
			try {
	            
	            String urlStr = "https://api.themoviedb.org/3/movie/" + apiCode;
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
//	            urlStr += "&"+ URLEncoder.encode("page","UTF-8") +"=1";
//	            urlStr += "&"+ URLEncoder.encode("year","UTF-8") +"=2019";
//	            urlStr += "&"+ URLEncoder.encode("_returnType","UTF-8") +"=json";
	            
	            URL url = new URL(urlStr);
	            System.out.println("url = "+url);                
	            
	            String line = "";
	            String result = "";
	            
	            BufferedReader br;
	            br = new BufferedReader(new InputStreamReader(url.openStream()));
	            System.out.println("br = "+br);                
	            
	            while ((line = br.readLine()) != null) {
	                result = result.concat(line);
	                System.out.println("line = "+ line); //api 불러서 그냥읽음 null이 아닌지 확인 가공x        
	            }            
	            
	            // JSON parser 만들어 문자열 데이터를 객체화한다.
	            //JSONObject -> 데이터를 key:value
	            JSONParser parser = new JSONParser(); // JSONParser -> 파싱
	            JSONObject obj = (JSONObject)parser.parse(result); 
	            System.out.println("obj = "+ obj); 
	            
	            // list 아래가 배열형태로 []
	            // "dates": {"maximum": "2022-03-09", "minimum": "2022-02-16"	        
	            JSONArray parse_listArr = (JSONArray)obj.get("genres"); //name(key)안의 value값을 객체안에 배열로 담음.
	            System.out.println("parse_listArr = "+parse_listArr); 
	            JSONObject movie = (JSONObject) parse_listArr.get(1);
	            
//	            JSONArray id = (JSONArray)obj.get("id");
	            String id = String.valueOf(obj.get("id"));
	            String overview = (String) obj.get("overview");	// 상세정보	                
	            String posterPath = (String) obj.get("poster_path");        // 포스터
	            String title = (String) obj.get("title");            // 제목
	            Double voteAverage = Double.parseDouble(String.valueOf(obj.get("vote_average")));        // 평균 평점
	            String releaseDate = (String) obj.get("release_date");	// 개봉날짜
	            String genre = String.valueOf(movie.get("name"));
//	            System.out.println("id = "+id); 
//	            System.out.println("overview = "+overview);
	            
	            map.put("id", id);
	            map.put("overview", overview);
	            map.put("posterPath", posterPath);
	            map.put("title", title);
	            map.put("voteAverage", voteAverage);
	            map.put("releaseDate", releaseDate);
	            map.put("genre", genre);
	            
	            list.add(map);	                
	            
	            // 객체형태로 {}
	            // {"returnType":"json","clearDate":"--",.......},... 
//	            for (int i=0; i< parse_listArr.size(); i++) {
//	                JSONObject movie = (JSONObject) parse_listArr.get(i);
//	                String genre = String.valueOf(movie.get("name"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
//
//	                map.put("genre", genre);
//	                log.debug("map = {}" ,map);
//	                
//	                list.add(map);	                
//	            }
	            
	            //api list
	            model.addAttribute("list",list);
	            log.debug("list = {}" , list);
	            
	            //댓글목록 불러오기
	            List<Comment> commentList = commentService.selectMovieCommentList(apiCode);
				model.addAttribute("commentList",commentList);

				//평점 평균
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
	