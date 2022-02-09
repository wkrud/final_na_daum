package com.project.nadaum.riot.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import com.project.nadaum.riot.model.service.RiotService;
import com.project.nadaum.riot.model.vo.LeagueEntries;
import com.project.nadaum.riot.model.vo.LeagueEntry;
import com.project.nadaum.riot.model.vo.MatchList;
import com.project.nadaum.riot.model.vo.RiotFavo;
import com.project.nadaum.riot.model.vo.Summoner;
import com.project.nadaum.riot.model.vo.riotDto.MatchDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/riot")
@Slf4j
public class ApitestController {

	final static String API_KEY = "RGAPI-7fb187de-1557-408c-8445-84143594181a";

	

	@Autowired
	private RiotService riotService;
	
	public static <T> HttpEntity<T> setHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Origin", "https://developer.riotgames.com");
        headers.set("Accept-Charset", "application/x-www-form-urlencoded; charset=UTF-8");
        headers.set("X-Riot-Token", API_KEY);
        headers.set("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
        headers.set("User-Agent", "내 브라우저 정보");

        return new HttpEntity<T>(headers);
    }

	@RequestMapping("/riotheader.do")
	public void riotheader() {

	}

	@RequestMapping(value = "/riot1.do", method = RequestMethod.GET)
	public String searchSummoner(Model model, HttpServletRequest httpServletRequest, 
			Summoner summoner,LeagueEntry leagueentry,LeagueEntries leagueentries,MatchDto matchDto) {
		BufferedReader br = null;
		String SummonerName = httpServletRequest.getParameter("nickname").replaceAll(" ", "%20");
		RestTemplate restTemplate = new RestTemplate();
		 MatchList[] matchlist =null;
		List<MatchList> wraplist = null;
		List<MatchDto> matchDtolist = new ArrayList();
		
		LinkedHashMap<Integer, Object> map = new LinkedHashMap<>();
		List<LinkedHashMap<Integer,Object>> test= new ArrayList<LinkedHashMap<Integer,Object>>();
		
		
	
		
	
		
		log.info("SummonerName = {}", SummonerName);

		Gson gson = new GsonBuilder().create();
		// 소환사이름으로 검색 - 소환사 정보 가져오기
		try {
			String urlstr = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/" + SummonerName
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
			String resulturl = "";
			String line;
			while ((line = br.readLine()) != null) {
				resulturl = resulturl + line;
			}

			log.info("summoner = {}", resulturl);
			JsonElement element = JsonParser.parseString(resulturl);
			JsonObject object = element.getAsJsonObject();
			
			int profileIconId = object.get("profileIconId").getAsInt();
			String name = object.get("name").getAsString();
			String puuid = object.get("puuid").getAsString();
			int summonerLevel = object.get("summonerLevel").getAsInt();
			int revisionDate = object.get("revisionDate").getAsInt();
			String id = object.get("id").getAsString();
			String accountId = object.get("accountId").getAsString();
			summoner = new Summoner(0, accountId, profileIconId, revisionDate, name, id, puuid, summonerLevel);
			log.info("summoner = {}", summoner);

			Summoner dbsummoner = riotService.selectOneSummoner(puuid);
			log.info("dbsummoner = {}", dbsummoner);

			if (dbsummoner == null) {
				int summonerrecord = riotService.insertSummoner(summoner);

				String msg = summonerrecord > 0 ? "summoner 등록 성공!" : "summoner 등록 실패!";
				log.info("msg = {}", msg);
			} else {
				String msg = "이미 db에 저장되어있는 summoner입니다";
				log.info("msg = {}", msg);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 가져온 소환사id로 검색 - 소환사 개인랭크/ 자유랭크 정보 가져오기
		try {
			String urlstr = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/" + summoner.getId()
					+ "?api_key=" + API_KEY;
			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			urlconnection.setRequestMethod("GET");
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8")); 
			String resulttier = "";
			String line;
			while ((line = br.readLine()) != null) { 
				resulttier =resulttier + line;
			}
			log.info("resulttier = {}", resulttier);
			JsonArray element = (JsonArray) JsonParser.parseString(resulttier);
			JsonObject object = (JsonObject) element.get(0);
			
			String summonerId = summoner.getId();
			int wins = object.get("wins").getAsInt();
			int losses = object.get("losses").getAsInt();
			String rank = object.get("rank").getAsString();
			String tier = object.get("tier").getAsString();
			String queueType = object.get("queueType").getAsString();
			int leaguePoints = object.get("leaguePoints").getAsInt();
			String leagueId = object.get("leagueId").getAsString();
			leagueentry = new LeagueEntry(0,leagueId,queueType,tier,rank,leaguePoints,wins,losses);
			log.info("leagueentry = {}", leagueentry);
			
			if(element.get(1) != null)
			{
				JsonObject object2 = (JsonObject) element.get(1);
				int wins2 = object2.get("wins").getAsInt();
				int losses2 = object2.get("losses").getAsInt();
				String rank2 = object2.get("rank").getAsString();
				String tier2 = object2.get("tier").getAsString();
				String queueType2 = object2.get("queueType").getAsString();
				int leaguePoints2 = object2.get("leaguePoints").getAsInt();
				String leagueId2 = object2.get("leagueId").getAsString();
				leagueentries = new LeagueEntries(0,leagueId2,queueType2,tier2,rank2,leaguePoints2,wins2,losses2);
				log.info("leagueentries = {}", leagueentries);
				
			}
			
	
		
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 가져온 소환사puuid로 검색 - 소환사 매치 정보 가져오기
		try {
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/" + summoner.getPuuid()
					+ "/ids?start=0&count=20&api_key=" + API_KEY;
			     matchlist = restTemplate.getForObject(urlstr,MatchList[].class);
			     log.info("match = {}", matchlist);
			     wraplist = Arrays.asList(matchlist);
			     log.info("list = {}", wraplist);
			    
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		
		try {
			for(int i=0; i< 5; i++)
			{
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/";		
			HttpEntity<MatchDto> request = setHeaders();
			ResponseEntity<MatchDto> response = restTemplate.exchange(urlstr + wraplist.get(i).getMatchId(), HttpMethod.GET, request, MatchDto.class);
			  matchDto = response.getBody();
			  matchDtolist = Arrays.asList(matchDto);
			  map.put(i, matchDtolist);
			  test.add(map);
//			  log.info("test = {}", test);
			}
			for(int i=5; i< 10; i++)
			{
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/";		
			HttpEntity<MatchDto> request = setHeaders();
			ResponseEntity<MatchDto> response = restTemplate.exchange(urlstr + wraplist.get(i).getMatchId(), HttpMethod.GET, request, MatchDto.class);
			  matchDto = response.getBody();
			  matchDtolist = Arrays.asList(matchDto);
			  map.put(i, matchDtolist);
			  test.add(map);
//			  log.info("test = {}", test);
			}
			
			for(int i=10; i< 15; i++)
			{
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/";		
			HttpEntity<MatchDto> request = setHeaders();
			ResponseEntity<MatchDto> response = restTemplate.exchange(urlstr + wraplist.get(i).getMatchId(), HttpMethod.GET, request, MatchDto.class);
			  matchDto = response.getBody();
			  matchDtolist = Arrays.asList(matchDto);
			  map.put(i, matchDtolist);
			  test.add(map);
//			  log.info("test = {}", test);
			}
			
			for(int i=15; i< 20; i++)
			{
			String urlstr = "https://asia.api.riotgames.com/lol/match/v5/matches/";		
			HttpEntity<MatchDto> request = setHeaders();
			ResponseEntity<MatchDto> response = restTemplate.exchange(urlstr + wraplist.get(i).getMatchId(), HttpMethod.GET, request, MatchDto.class);
			  matchDto = response.getBody();
			  matchDtolist = Arrays.asList(matchDto);
			  map.put(i, matchDtolist);
			  test.add(map);
//			  log.info("test = {}", test);
			}
			   
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	
		
		
		  //log.info("test = {}", test);
		model.addAttribute("summoner", summoner);
		model.addAttribute("img", "http://ddragon.leagueoflegends.com/cdn/12.1.1/img/profileicon/"
				+ summoner.getProfileIconId() + ".png");
		model.addAttribute("leagueentry", leagueentry);
		model.addAttribute("leagueentries", leagueentries);
		model.addAttribute("tierImg", "/resources/image/riot/"+leagueentry.getTier()+".png");
		model.addAttribute("tierImg", "/resources/image/riot/"+leagueentries.getTier()+".png");
		model.addAttribute("test", test);
		model.addAttribute("wraplist", wraplist);
		
		
		

		return "riot/riotmain";

	}

	@RequestMapping("/riotmain.do")
	public void riotmain() {

	}
	
	@ResponseBody
	@PostMapping("/riotFav.do")
	public Map<String, Object> riotFav(@RequestBody Map<String, Object> favData , RiotFavo riotfavo,Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> accountmap = new HashMap<String, Object>();
		Map<String, Object> messagemap = new HashMap<String, Object>();
		
		log.debug("favData = " + favData);
		String member_Id = (String) favData.get("member_id");
		String sm_Id = (String) favData.get("summoner_id");
		 log.info("oneaccount = {}", member_Id);
		 accountmap.put("member_Id", member_Id);
		
		map.put("member_Id", favData.get("member_id"));
		map.put("sm_Id", favData.get("summoner_id"));
		
		
		
		RiotFavo oneaccount = riotService.selectOneAccount(accountmap);
		model.addAttribute("oneaccount", oneaccount);
		
		
		 log.info("oneaccount = {}", oneaccount);
		 
		 
		 
		 if(oneaccount == null) {
			 
			 int result = riotService.insertRiotFavo(map);
			 String msg = result > 0 ? "즐겨찾기 등록 성공!" : "즐겨찾기 등록 실패!";
			 messagemap.put("insert", msg);
			 log.info("msg = {}", msg);
			 
		 }
		 else {
			 		
			 
			 		if((oneaccount.getSmId()).equals(sm_Id) ) {
			 			
			 			 int resultdele = riotService.deleteFav(accountmap);
			 			 int result = riotService.insertRiotFavo(map);
			 			 String msg2 = result > 0 ? "즐겨찾기 등록 성공!" : "즐겨찾기 등록 실패!";
			 			 messagemap.put("delete", msg2);
			 			
			 			
			 		}
			 		else {
			 			
			 			 int resultdele = riotService.deleteFav(accountmap);
			 			 int result = riotService.insertRiotFavo(map);
			 			 String msg3 = result > 0 ? "즐겨찾기 등록 성공!" : "즐겨찾기 등록 실패!";
			 			 messagemap.put("delete", msg3);
			 		        
			 		}
			 		
			 
			 
		 }
		 
		 
		 
		return messagemap;
		
	}
}
