package com.project.nadaum.culture.scrap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.nadaum.common.BoardUtils;
import com.project.nadaum.culture.scrap.model.service.ScrapService;
import com.project.nadaum.culture.scrap.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/scrap")
public class ScrapController {

	@Autowired
	private ScrapService scrapService;
	
	@GetMapping("/scrapCultureList")
	public void scrapCultureList(
			Scrap scrap,
			HttpServletRequest request, Model model)
			throws Exception {

		Map<String, Object> param = new HashMap<>();
		param.put("apiCode", scrap.getApiCode());
		
		
		// 리스트 보여주기
		List<Scrap> list = scrapService.selectScrapList(param);
		log.debug("(boardList) list = {}", list);




		model.addAttribute("list", list);
		
	}
	
	

	@GetMapping("/scrapList.do")
	public void scrapList(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model)
			throws Exception {

		// content 영역
		int limit = 10;
		int offset = (cPage - 1) * limit;

		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);

		// 리스트 보여주기
		List<Scrap> list = scrapService.selectScrapList(param);
		log.debug("(boardList) list = {}", list);

		// pagebar 영역
		int totalContent = scrapService.selectTotalContent();
		String url = request.getRequestURI();
//		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url, null );
		String pagebar = BoardUtils.getPagebar(cPage, limit, totalContent, url);

//		int commentCount = boardService.boardCommentCount(code);

		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
	}
	
	
	
}
