package com.project.nadaum.culture.show.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.poi.util.SystemOutLogger;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;
import com.project.nadaum.culture.show.model.service.CultureService;
import com.project.nadaum.culture.show.model.vo.Scrap;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class CultureController {

	@Autowired
	private CultureService cultureService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private MemberService memberService;
	
	
	@GetMapping("/board/{page}")
	public String getCultureApi(@PathVariable int page,  Model model) {

		 
		try {
			StringBuilder urlBuilder = new StringBuilder
					("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"); 
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"); 
			urlBuilder.append("&" + URLEncoder.encode("rows", "UTF-8") + "=9"); 
			urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=");
			urlBuilder.append("&" + URLEncoder.encode("cPage", "UTF-8") + "=" + page); 

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode()); // 200이면 정상
			BufferedReader rd;

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			System.out.println(sb.toString());

			// =================================================================================
			// xml -> json

			org.json.JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());

			String xmlJSONObjString = xmlJSONObj.toString();
			log.debug("xmlJSONObjString = {}", xmlJSONObjString);

			ObjectMapper objectMapper = new ObjectMapper();

			// map에 data담기
			Map<String, Object> map = new HashMap<>();
			map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
			});

			Map<String, Object> response = (Map<String, Object>) map.get("response");
			Map<String, Object> msgBody = (Map<String, Object>) response.get("msgBody");

			log.debug("response = {}", response);
			log.debug("msgBody = {}", msgBody);

			List<Map<String, Object>> perforList = null;
			perforList = (List<Map<String, Object>>) msgBody.get("perforList");
			log.debug("perforList = {}", perforList);

			List<Object> list = new ArrayList<>();
			
			for (int i = 0; i < perforList.size(); i++) {
				String seq = perforList.get(i).get("seq").toString();
				String title = perforList.get(i).get("title").toString();
				String area = perforList.get(i).get("area").toString();
				String place = perforList.get(i).get("place").toString();
				String thumbnail = perforList.get(i).get("thumbnail").toString();
				String startDate = perforList.get(i).get("startDate").toString();
				String endDate = perforList.get(i).get("endDate").toString();
				String realmName = perforList.get(i).get("realmName").toString();
				
				  Map<String, Object> map2 = new HashMap<>();
					map2.put("seq", seq);
					map2.put("title", title);
					map2.put("startDate", startDate);
					map2.put("endDate", endDate);
					map2.put("area", area);
					map2.put("place", place);
					map2.put("thumbnail", thumbnail);
					map2.put("realmName", realmName);
					
					list.add(map2);
				  
				}
			model.addAttribute("list", list);
			System.out.println("page number : "+page);
			model.addAttribute("page",page);

		} catch (JSONException | IOException e) {
			e.printStackTrace();
		}
		return "/culture/cultureBoardList";
	}
	
	@PostMapping("/search.do")
	public List<Map<String, Object>> Search(
			@RequestParam (value="keyword", defaultValue="") String keyword, 
			@DateTimeFormat(pattern="yyyy-MM-dd") Date startDate, @DateTimeFormat(pattern="yyyy-MM-dd") Date endDate, 
			@RequestParam (value="searchArea", defaultValue="") String searchArea, 
			@RequestParam (value="searchGenre", defaultValue="") String searchGenre,Model model) {
		
		//Date -> String format
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String from = format.format(startDate);
		String to =format.format(endDate);
		
		System.out.println(searchArea);
		System.out.println(searchGenre);
		 

		List<Map<String, Object>> perforList = null;
		try {
			StringBuilder urlBuilder = new StringBuilder();
			
			if(searchArea != "") {
				 urlBuilder = new StringBuilder
						("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/area"); 
				}
			if(searchGenre != "") {
				urlBuilder = new StringBuilder
						("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/realm"); 
				}
			else {
				urlBuilder = new StringBuilder
						("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"); 
			}
		
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
			+ "=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"); 
			urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=" + URLEncoder.encode(keyword, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("from", "UTF-8") + "=" + URLEncoder.encode(from, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("to", "UTF-8") + "=" + URLEncoder.encode(to, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("realmCode", "UTF-8") + "=" + URLEncoder.encode(searchGenre, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("sido", "UTF-8") + "=" + URLEncoder.encode(searchArea, "UTF-8"));
			//urlBuilder.append("&" + URLEncoder.encode("cPage", "UTF-8") + "=" + page); 

			URL url = new URL(urlBuilder.toString());
			
			System.out.println(url);
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode()); // 200이면 정상
			BufferedReader rd;

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			System.out.println(sb.toString());

			// =================================================================================
			// xml -> json

			org.json.JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());

			String xmlJSONObjString = xmlJSONObj.toString();
			ObjectMapper objectMapper = new ObjectMapper();

			log.debug("xmlJSONObjString = {}",xmlJSONObjString);
			// map에 data담기
			Map<String, Object> map = new HashMap<>();
			map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
			});
			log.debug("map = {}",map);
			Map<String, Object> response = (Map<String, Object>) map.get("response");
			Map<String, Object> msgBody = (Map<String, Object>) response.get("msgBody");

			log.debug("response={}", response);
			log.debug("msgBody={}", msgBody);
			
			
				perforList = (List<Map<String, Object>>) msgBody.get("perforList");
				log.debug("perforList = {}", perforList);
				

				List<Object> searchList = new ArrayList<>();

				for (int i = 0; i < perforList.size(); i++) {
					String seq = perforList.get(i).get("seq").toString();
					String title = perforList.get(i).get("title").toString();
					String area = perforList.get(i).get("area").toString();
					String place = perforList.get(i).get("place").toString();
					String thumbnail = perforList.get(i).get("thumbnail").toString();
					String start = perforList.get(i).get("startDate").toString();
					String end = perforList.get(i).get("endDate").toString();
					String realmName = perforList.get(i).get("realmName").toString();
					
					  Map<String, Object> map2 = new HashMap<>();
						map2.put("seq", seq);
						map2.put("title", title);
						map2.put("startDate", start);
						map2.put("endDate", end);
						map2.put("area", area);
						map2.put("place", place);
						map2.put("thumbnail", thumbnail);
						map2.put("realmName", realmName);
						
						searchList.add(map2);
						
					  System.out.println(map2);
					}
				
				model.addAttribute("perforList", perforList);
				System.out.println(perforList);
			
		} catch (JSONException | IOException e) {
			e.printStackTrace();
		}
		return perforList;
	}
	
    // tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		//
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}


	//문화 상세정보API
		@GetMapping("/board/view/{apiCode}")
		public ModelAndView getCultureDetailApi(@AuthenticationPrincipal Member member, @PathVariable String apiCode, Model model) {
			
			List<Object> list = new ArrayList<>();
				try {
					
					// parsing할 url 지정(API 키 포함해서)
					String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/"
							+ "?serviceKey=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"
							+ "&seq="+apiCode ;
					
					DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
					DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
					Document doc = dBuilder.parse(url);
					
					  doc.getDocumentElement().normalize();
					  
					  NodeList nList = doc.getElementsByTagName("perforInfo");
					
					     Node nNode = nList.item(0);
					     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					 
					        Element eElement = (Element) nNode;
					 

					       String title = getTagValue("title", eElement);
							String startDate = getTagValue("startDate", eElement);
							String endDate = getTagValue("endDate", eElement);
							String area = getTagValue("area", eElement);
							String place = getTagValue("place", eElement);
							String placeAddr = getTagValue("placeAddr", eElement);
							String realmName = getTagValue("realmName", eElement);
							String price = getTagValue("price", eElement);
							String phone = getTagValue("phone", eElement);
							String bookingUrl = getTagValue("url", eElement);
							String imgUrl = getTagValue("imgUrl", eElement);
							String placeUrl = getTagValue("placeUrl", eElement);
							Map<String, Object> map = new HashMap<>();
							
							map.put("title", title);
							map.put("startDate", startDate);
							map.put("endDate", endDate);
							map.put("area", area);
							map.put("place", place);
							map.put("placeAddr", placeAddr);
							map.put("realmName", realmName);
							map.put("price", price);
							map.put("phone", phone);
							map.put("bookingUrl", bookingUrl);
							map.put("imgUrl", imgUrl);
							map.put("placeUrl", placeUrl);
							
							list.add(map);
							
					     }//if end
					     List<Comment> commentList = commentService.selectCultureCommentList(apiCode);
					     System.out.println(list);
					     model.addAttribute("list", list);
					     model.addAttribute("commentList", commentList);
					     
					     //friend
					     List<Map<String, Object>> friends = memberService.selectAllFriend(member);
						List<Member> memberList = memberService.selectAllNotInMe(member);
						model.addAttribute("memberList", memberList);
						model.addAttribute("friends", friends);
						
				} catch (Exception e) {
					  e.printStackTrace();
			}		  
			return new ModelAndView("/culture/cultureView","list",list);
		}
		

		//============================= 스크랩 ==========================================
		//스크랩 목록
		@PostMapping("/likes.do")
		public String selectLikes(@AuthenticationPrincipal Member member, Model model){
			String id = member.getId();	
			
			List<Scrap> list = cultureService.selectCultureLikes(id);
		    
		     //apiCode만 쏙 빼와서 저장
		     List<Object> resultList = new ArrayList<>();
		     
		     for (int i = 0; i < list.size(); i++) {
					String apiCode = list.get(i).getApiCode();
					resultList.add(apiCode);
		     }
		     

			Map<String, Object> perforInfo = null;
			List<Object> scrapList = new ArrayList<>();
			
		     for (int i = 0; i < resultList.size(); i++) {
					String apiCode = resultList.get(i).toString();
					log.debug("apiCode={}",apiCode);
					
					try {
						StringBuilder urlBuilder = new StringBuilder();
						
							urlBuilder = new StringBuilder
									("http://www.culture.go.kr/openapi/rest/publicperformancedisplays/d/"); 
					
						urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
						+ "=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"); 
						urlBuilder.append("&" + URLEncoder.encode("seq", "UTF-8") + "=" + URLEncoder.encode(apiCode, "UTF-8"));
						
						URL url = new URL(urlBuilder.toString());
						
						
						HttpURLConnection conn = (HttpURLConnection) url.openConnection();
						conn.setRequestMethod("GET");
						conn.setRequestProperty("Content-type", "application/json");
						BufferedReader rd;

						if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
							rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
						} else {
							rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
						}
						StringBuilder sb = new StringBuilder();
						String line;
						while ((line = rd.readLine()) != null) {
							sb.append(line);
						}
						rd.close();
						conn.disconnect();

						// =================================================================================
						// xml -> json

						org.json.JSONObject xmlJSONObj = XML.toJSONObject(sb.toString());

						String xmlJSONObjString = xmlJSONObj.toString();
						ObjectMapper objectMapper = new ObjectMapper();

						// map에 data담기
						Map<String, Object> map = new HashMap<>();
						map = objectMapper.readValue(xmlJSONObjString, new TypeReference<Map<String, Object>>() {
						});
						Map<String, Object> response = (Map<String, Object>) map.get("response");
						Map<String, Object> msgBody = (Map<String, Object>) response.get("msgBody");

						
						//결과가 한개면 오류나서 List <Map<>>이었는데 List 뺌
							perforInfo = (Map<String, Object>) msgBody.get("perforInfo");
							log.debug("perforInfo={}",perforInfo);

							Map<String, Object> map2 = new HashMap<>();
							for (int j = 0; j < resultList.size(); j++) {
								String title = perforInfo.get("title").toString();
								String startDate = perforInfo.get("startDate").toString();
								String endDate = perforInfo.get("endDate").toString();
								String price = perforInfo.get("price").toString();
								String place = perforInfo.get("place").toString();
								String placeAddr = perforInfo.get("placeAddr").toString();
								String realmName = perforInfo.get("realmName").toString();
								String area = perforInfo.get("area").toString();
								String phone = perforInfo.get("phone").toString();
								String imgUrl = perforInfo.get("imgUrl").toString();
									
								
								
								map2.put("title", title);
								map2.put("startDate", startDate);
								map2.put("endDate", endDate);
								map2.put("area", area);
								map2.put("place", place);
								map2.put("realmName", realmName);
								map2.put("imgUrl", imgUrl);
								map2.put("price", price);
								map2.put("placeAddr", placeAddr);
								map2.put("phone", phone);
								
								}
							//apicode 1개의 정보
							log.debug("map2={}",map2);
							scrapList.add(map2);
					} catch (JSONException | IOException e) {
						e.printStackTrace();
					}
					//scrap한 apiCode의 정보 (여러개)
					model.addAttribute("scrapList", scrapList);
					log.debug("scrapList={}",scrapList);
		     }
		     
		     return "/culture/likes";
		}
		
		//좋아요
		@PostMapping("/board/view/{apiCode}/likes")
		public ResponseEntity<?> insertLikes(@RequestParam Map<String,Object> map){
			
			log.debug("map = {}", map);
			
			try{
				int result = cultureService.insertCultureLike(map);
				
				System.out.println(result);
				String msg = (result > 0) ? "스크랩 성공" : "스크랩 실패";	
				
				map.put("result", result);
				map.put("msg", msg);

				System.out.println(map);
					if(result == 1) {
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
		
		@DeleteMapping("/board/view/{apiCode}/likes")
		public ResponseEntity<?> deleteLikes(@PathVariable String apiCode){
			
			try{
				int result = cultureService.deleteCultureLike(apiCode);
				String msg = (result > 0) ? "스크랩 취소 완료" : "스크랩 취소 실패";	
				
				Map<String, Object> map = new HashMap<>();
				map.put("result", result);
				map.put("msg", msg);
				
					if(result == 1) {
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
		
}