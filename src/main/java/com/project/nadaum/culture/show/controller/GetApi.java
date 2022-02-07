package com.project.nadaum.culture.show.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONException;
import org.json.XML;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/culture")
public class GetApi {

	@GetMapping("/xmlParser.do")
	public static Map<String, Object> GetApi(Model model) throws IOException {

		Map<String, Object> resultMap = new HashMap<>();

		try {
			StringBuilder urlBuilder = new StringBuilder(
					"http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period"); /* URL */
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=p%2B16HHPYFEvCkanGQCoGc9CAAG7x66tc5u3xrBmJpM8avVLTGiJ%2FjJaIvItRCggk79J9k%2Byn47IjYUHr%2FdzlgA%3D%3D"); 
			urlBuilder.append("&" + URLEncoder.encode("MsgBody", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /**/
			urlBuilder.append("&" + URLEncoder.encode("MsgBody", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /**/
			urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("cPage", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /**/

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
			
			resultMap.put("Result", "0000");
			resultMap.put("rows", msgBody.get("rows"));
			resultMap.put("cPage", msgBody.get("cPage"));
			resultMap.put("totalCount", msgBody.get("totalCount"));
			resultMap.put("data", perforList);

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
				  
				  System.out.println(area);
				  System.out.println(thumbnail);
				  System.out.println(startDate);
				  System.out.println(endDate);
				  System.out.println(realmName);
				  System.out.println(place);
				  System.out.println(title);
				  System.out.println(seq);
				  
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
			model.addAttribute("msgBody", msgBody);
			model.addAttribute("perforList", perforList);

		} catch (JSONException | IOException e) {
			e.printStackTrace();
			resultMap.clear();
			resultMap.put("Result", "0001");
		}
		return resultMap;
	}
}