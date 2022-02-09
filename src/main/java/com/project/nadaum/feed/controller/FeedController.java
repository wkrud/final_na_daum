package com.project.nadaum.feed.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.feed.model.service.FeedService;
import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.feed.model.vo.FeedComment;
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
		try {
			log.debug("id param = {}", param);
			Member member = memberService.selectOneMember(param);
			log.debug("member = {}", member);
			List<String> hobby = new ArrayList<>();
			if(member.getHobby() != null) {
				for(int i = 0; i < member.getHobby().length; i++) {
					hobby.add(member.getHobby()[i]);
				}
			}
			// feed
			int totalCount = feedService.countAllHostFeed(param);
			param.put("totalCount", totalCount);
			List<Feed> feed = feedService.selectOnePersonFeed(param);
					
			// 친구, 팔로잉
			Map<String, Object> socialCount = feedService.selectAllHostSocialCount(param);
			
			model.addAttribute("check", param);
			model.addAttribute("hobby", hobby);
			model.addAttribute("member", member);
			model.addAttribute("feed", feed);
			model.addAttribute("socialCount", socialCount);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}
	
	@GetMapping("/selectedFeed.do")
	public ResponseEntity<?> selectedFeed(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member guest){
		Map<String, Object> param = new HashMap<>();
		try {
			log.debug("map = {}", map);
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
			
			Map<String, Object> guestInfo = new HashMap<>();
			guestInfo.put("id", guest.getId());
			guestInfo.put("code", feed.getCode());
			int likeCheck = feedService.selectFeedLikesCheck(guestInfo);
			
			param.put("likeCheck", likeCheck);
			param.put("member", member);
			param.put("feed", feed);
			param.put("guest", guest);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return ResponseEntity.ok(param);
	}
	
	@PostMapping("/feedLikeChange.do")
	public ResponseEntity<?> feedLikeChange(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member guest){
		int result = 0;
		try {
			log.debug("map = {}", map);
			map.put("id", guest.getId());
			String check = (String) map.get("check");
			if("1".equals(check)) {
				result = memberService.insertHelpLike(map);
			}else {
				result = memberService.deleteHelpLike(map);
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
		return ResponseEntity.ok(result);
	}
	
	@PostMapping("/writeComment.do")
	public ResponseEntity<?> writeComment(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member guest){
		FeedComment feedComment = new FeedComment();
		try {
			log.debug("map = {}", map);
			map.put("id", guest.getId());
			feedComment = feedService.insertFeedComment(map);
			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}		
		return ResponseEntity.ok(feedComment);
	}
	
	@PostMapping("/deleteComment.do")
	public ResponseEntity<?> deleteComment(@RequestParam Map<String, Object> map){
		log.debug("map = {}", map);
		int result = feedService.deleteComment(map);
		return ResponseEntity.ok(1);
	}
	
	@GetMapping("/feedMain.do")
	public void feedMain() {}

}
