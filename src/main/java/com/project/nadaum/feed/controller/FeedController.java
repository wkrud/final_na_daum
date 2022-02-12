package com.project.nadaum.feed.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.common.vo.Attachment;
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
	
    @Autowired 
    private ServletContext application;
	
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
			
			if(member.getBirthday() != null) {
				boolean bool = NadaumUtils.isBirthday(member.getBirthday());
				model.addAttribute("hostBirth", bool);
			}
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
	public void feedMain(Model model) {
		List<Feed> feed = feedService.feedMain();
		log.debug("feed = {}", feed);
		
		model.addAttribute("feed", feed);
	}

	@GetMapping("/addFeedPage.do")
	public ResponseEntity<?> addFeedPage(@RequestParam Map<String, Object> map, @AuthenticationPrincipal Member member){
		log.debug("map = {}", map);
		int page = Integer.parseInt((String) map.get("page"));
		int limit = 8;		
		int offset = (page - 1) * limit;
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("id", member.getId());
		
		List<Map<String, Object>> addFeed = feedService.selectAddFeed(map);
		log.debug("addFeed = {}", addFeed);
		return ResponseEntity.ok(addFeed);
	}
	
	@PostMapping("/feedEnroll.do")
    public String feedEnroll(Feed feed, RedirectAttributes redirectAttr, 
            @RequestParam(required = false) MultipartFile upFile) throws IllegalStateException, IOException {
        
        // 첨부파일 경로
        String saveDirectory = application.getRealPath("/resources/upload/feed/img");
        List<Attachment> attachments = new ArrayList<>();
        
        // attachment 저장
        if(!upFile.isEmpty()) {
            log.debug("upFile = {}, size = {}", upFile.getOriginalFilename(), upFile.getSize());
            // 저장경로, renamedFilename
            String originalFilename = upFile.getOriginalFilename();
            String renamedFilename = NadaumUtils.rename(originalFilename);
            File dest = new File(saveDirectory, renamedFilename);
            upFile.transferTo(dest);
            
            Attachment attach = new Attachment();
            attach.setOriginalFilename(originalFilename);
            attach.setRenamedFilename(renamedFilename);
            attachments.add(attach);
        }
        if(!attachments.isEmpty())
            feed.setAttachments(attachments);
        log.debug("feed = {}", feed);
        
        int result = feedService.feedEnroll(feed);
        String msg = "피드를 등록했습니다.";
        redirectAttr.addFlashAttribute("msg", msg);
        
        return "redirect:/feed/feedMain.do";
    }
	
	@GetMapping("/addFeedMain.do")
	public ResponseEntity<?> addFeedMain(@RequestParam Map<String, Object> map, Model model, @AuthenticationPrincipal Member member){
		log.debug("map = {}", map);
		int page = Integer.parseInt((String) map.get("page"));
		int limit = 2;
		int offset = (page - 1) * limit;
		map.put("limit", limit);
		map.put("offset", offset);
		map.put("id", member.getId());
		
		List<Map<String, Object>> addFeed = feedService.addFeedMain(map);
		log.debug("addFeed = {}", addFeed);
		
		model.addAttribute("addFeed", addFeed);
		return ResponseEntity.ok(addFeed);
	}
	
	@PostMapping("/deleteFeed.do")
	public ResponseEntity<?> deleteFeed(@RequestParam Map<String, Object> map){
		try {
			log.debug("map = {}", map);
			feedService.deleteFeed(map);			
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}
		return ResponseEntity.ok(1);
	}
	
}
