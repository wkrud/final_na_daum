package com.project.nadaum.culture.movie.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;
import com.project.nadaum.culture.movie.model.service.MovieService;
import com.project.nadaum.culture.show.model.vo.Scrap;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/movie")
public class GetMovieDetailApi {

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private MemberService memberService;
	
	// 인증키
	final static String SERVICEKEY = "5640ea577618caa1d5cefe4b2fea1683";
	
		// 영화 상세정보API
		@GetMapping("/movieDetail/{apiCode}")
		public ModelAndView getMovieDetailApi(
				@AuthenticationPrincipal Member member,
				@PathVariable String apiCode, 
				@RequestParam Map<String, Object> scheduleMap,
				Model model) {
			
			String schedulecode = (String) scheduleMap.get("schedulecode");
			model.addAttribute("check", scheduleMap);
			log.debug("schedulecode={}",schedulecode);
			
			log.debug("apiCode = {} ", apiCode);
			
			// TMDB api
			List<Map<String, Object>> list = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();			
	        
			try {
	            
	            String urlStr = "https://api.themoviedb.org/3/movie/" + apiCode;
	            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
	            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
	            
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
	            
	          //similar movie
	            List<Map<String, Object>> similarList = new ArrayList<>();

	            String urlStr2 = "https://api.themoviedb.org/3/movie/"+ apiCode + "/similar";
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
	                
	                String id2 = String.valueOf(movie2.get("id"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
	                String overview2 = (String) movie2.get("overview");	// 상세정보
	                String posterPath2 = (String) movie2.get("poster_path");        // 포스터
	                String releaseDate2 = (String) movie2.get("release_date");	// 개봉날짜
	                String title2 = (String) movie2.get("title");            // 제목
	                Double voteAverage2 = Double.parseDouble(String.valueOf(movie2.get("vote_average")));        // 평균 평점
	               
	                       
	                
	                Map<String, Object> map2 = new HashMap<>();
	                map2.put("apiCode", id2);
	                map2.put("overview", overview2);
	                map2.put("posterPath", posterPath2);
	                map2.put("releaseDate", releaseDate2);
	                map2.put("title", title2);
	                map2.put("voteAverage", voteAverage2);
	                
	                log.debug("map2 = {}" ,map2);
	                
	                similarList.add(map2);
	            }
	            
	            //api list
	            model.addAttribute("list",list);
	            model.addAttribute("similarList",similarList);
	            log.debug("list = {}" , list);
	            log.debug("similarList = {}" , similarList);
	            
	            
	            //댓글목록 불러오기
	            List<Comment> commentList = commentService.selectMovieCommentList(apiCode);
				model.addAttribute("commentList",commentList);
				
				//약속 친구리스트 불러오기
				List<Map<String, Object>> friends = memberService.selectAllFriend(member);
				List<Member> memberList = memberService.selectAllNotInMe(member);
				
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

		
		// 영화 약속 상세정보API
				@GetMapping("/movieDetail/{apiCode}/{schedulecode}")
				public String MovieScheduleDetail(
						@AuthenticationPrincipal Member member,
						@PathVariable String apiCode,
						@PathVariable String schedulecode,
						Model model) {
					
					log.debug("apiCode = {} ", apiCode);
					log.debug("schedulecode={}",schedulecode);
					
					// TMDB api
					List<Map<String, Object>> list = new ArrayList<>();
					Map<String, Object> map = new HashMap<>();			
			        
					try {
			            
			            String urlStr = "https://api.themoviedb.org/3/movie/" + apiCode;
			            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
			            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
			            
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
			            
//			            JSONArray id = (JSONArray)obj.get("id");
			            String id = String.valueOf(obj.get("id"));
			            String overview = (String) obj.get("overview");	// 상세정보	                
			            String posterPath = (String) obj.get("poster_path");        // 포스터
			            String title = (String) obj.get("title");            // 제목
			            Double voteAverage = Double.parseDouble(String.valueOf(obj.get("vote_average")));        // 평균 평점
			            String releaseDate = (String) obj.get("release_date");	// 개봉날짜
			            String genre = String.valueOf(movie.get("name"));
//			            System.out.println("id = "+id); 
//			            System.out.println("overview = "+overview);
			            
			            map.put("id", id);
			            map.put("overview", overview);
			            map.put("posterPath", posterPath);
			            map.put("title", title);
			            map.put("voteAverage", voteAverage);
			            map.put("releaseDate", releaseDate);
			            map.put("genre", genre);
			            
			            list.add(map);	                
			            
			            //similar movie
			            List<Map<String, Object>> similarList = new ArrayList<>();

			            String urlStr2 = "https://api.themoviedb.org/3/movie/"+ apiCode + "/similar";
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
			                
			                String id2 = String.valueOf(movie2.get("id"));	// id코드 /int 타입을 String 타입으로 곧바로 캐스팅 하면 오류 나서 캐스팅 변환이 아닌 String 클래스의 valueOf(Object) 를 사용하여 처리
			                String overview2 = (String) movie2.get("overview");	// 상세정보
			                String posterPath2 = (String) movie2.get("poster_path");        // 포스터
			                String releaseDate2 = (String) movie2.get("release_date");	// 개봉날짜
			                String title2 = (String) movie2.get("title");            // 제목
			                Double voteAverage2 = Double.parseDouble(String.valueOf(movie2.get("vote_average")));        // 평균 평점
			               
			                       
			                
			                Map<String, Object> map2 = new HashMap<>();
			                map2.put("apiCode", id2);
			                map2.put("overview", overview2);
			                map2.put("posterPath", posterPath2);
			                map2.put("releaseDate", releaseDate2);
			                map2.put("title", title2);
			                map2.put("voteAverage", voteAverage2);
			                
			                log.debug("map2 = {}" ,map2);
			                
			                similarList.add(map2);
			            }
			            
			            //api list
			            model.addAttribute("list",list);
			            model.addAttribute("similarList",similarList);
			            log.debug("list = {}" , list);
			            log.debug("similarList = {}" , similarList);
			            
			            //댓글목록 불러오기
			            List<Comment> commentList = commentService.selectMovieCommentList(apiCode);
						model.addAttribute("commentList",commentList);
						
						//약속 친구리스트 불러오기
						List<Map<String, Object>> friends = memberService.selectAllFriend(member);
						List<Member> memberList = memberService.selectAllNotInMe(member);
						
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
						model.addAttribute("schedulecode", schedulecode);
						
						
						
			            br.close();
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			        return "/movie/movieShedule";
			    }
				
				// 영화 스크랩
				@GetMapping("/movieScrap.do")
				public String scrapList(
						@AuthenticationPrincipal Member member,
						Model model) {
					
					try {
					String id = member.getId();
					List<Scrap> list = movieService.selectMovieScrap(id);
					
					//api저장할 list
					List<Object> resultList = new ArrayList<>();
					List<Object> scrapList = new ArrayList<>();
					List<Object> scrapList2 = new ArrayList<>();
					Map<String, Object> map = new HashMap<>();			
					
					//apiCode 꺼내서 resultList에 담기
					for (int i = 0; i < list.size(); i++) {
						String apiCode = list.get(i).getApiCode();
						resultList.add(apiCode);
						System.out.println("333 Scrap resultList = " + resultList);
					}
					
					//resultList에 담은 apiCode 꺼내기
					for (int j = 0; j < resultList.size(); j++) {
						String apiCode = resultList.get(j).toString();
						log.debug("apiCode={}",apiCode);
						
					 
			            String urlStr = "https://api.themoviedb.org/3/movie/" + apiCode;
			            urlStr += "?"+ URLEncoder.encode("api_key","UTF-8") +"=" + SERVICEKEY;
			            urlStr += "&"+ URLEncoder.encode("language","UTF-8") +"=ko-kr";
			            
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
			            
			            for(int h = 0; h <= 1;  h++) {
//			            JSONArray id = (JSONArray)obj.get("id");
			            String code = String.valueOf(obj.get("id"));
			            String overview = (String) obj.get("overview");	// 상세정보	                
			            String posterPath = (String) obj.get("poster_path");        // 포스터
			            String title = (String) obj.get("title");            // 제목
			            Double voteAverage = Double.parseDouble(String.valueOf(obj.get("vote_average")));        // 평균 평점
			            String releaseDate = (String) obj.get("release_date");	// 개봉날짜
			            String genre = String.valueOf(movie.get("name"));
//			            System.out.println("id = "+id); 
//			            System.out.println("overview = "+overview);
			            
			            map.put("code", code);
			            map.put("overview", overview);
			            map.put("posterPath", posterPath);
			            map.put("title", title);
			            map.put("voteAverage", voteAverage);
			            map.put("releaseDate", releaseDate);
			            map.put("genre", genre);
//			            scrapList2.add(map);	                
//			            log.debug("394 scrapList2 = {}" , scrapList2);
			            scrapList.add(map);	                
			            }
			            
			            log.debug("398 scrapList = {}" , scrapList);
			            br.close();
						} 
					
			            model.addAttribute("scrapList",scrapList);
			            log.debug("403 scrapList = {}" , scrapList);
			           
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
			        return "/movie/movieScrap";
			    }
}
	