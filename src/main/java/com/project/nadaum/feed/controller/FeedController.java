package com.project.nadaum.feed.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.feed.model.service.FeedService;
import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.member.model.service.MemberService;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/feed")
public class FeedController {
	
	@Autowired
	private FeedService feedService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/socialFeed.do")
	public void socialFeed(@RequestParam Map<String, Object> param, Model model) {
		log.debug("id param = {}", param);
		
		Member member = memberService.selectOneMember(param);
		
		// feed
		int totalCount = feedService.countAllHostFeed(param);
		param.put("totalCount", totalCount);
		List<Feed> feed = feedService.selectOnePersonFeed(param);
				
		// 친구, 팔로잉
		Map<String, Object> socialCount = feedService.selectAllHostSocialCount(param);
		
		model.addAttribute("feed", feed);
		model.addAttribute("socialCount", socialCount);
	}
	
	@GetMapping("/selectedFeed.do")
	public ResponseEntity<?> selectedFeed(@RequestParam Map<String, Object> map){
		log.debug("map = {}", map);
		map.put("id", "admin");
		String profile = "";
		Member member = memberService.selectOneMember(map);
		if(member.getLoginType().equals("K"))
			profile = member.getProfile();
		else if(member.getLoginType().equals("D") && member.getProfileStatus().equals("N")) 
			profile = "/nadaum/resources/upload/member/profile/default_profile_cat.png";
		else if(member.getLoginType().equals("D") && member.getProfileStatus().equals("Y"))
			profile = "/nadaum/resources/upload/member/profile/" + member.getProfile();
		member.setProfile(profile);
		Feed feed = feedService.selectOneFeed(map);
		Map<String, Object> param = new HashMap<>();
		param.put("member", member);
		param.put("feed", feed);
		return ResponseEntity.ok(param);
	}

}
