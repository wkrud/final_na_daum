package com.project.nadaum.culture.comment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.project.nadaum.culture.comment.model.service.CommentService;
import com.project.nadaum.culture.comment.model.vo.Comment;
import com.project.nadaum.culture.show.model.service.CultureService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/culture")
public class CommentController{
	
	@Autowired
	private CultureService cultureService;
	
	@Autowired
	private CommentService commentService;

	//============================= 댓  글 =================================================
	
	///등록
	@PostMapping("/board/view/{apiCode}")
	public ResponseEntity<?> insertCultureComment(@RequestParam Map<String,Object> map) {
		log.debug("map = {}", map);
		try {
			int result = commentService.insertCultureComment(map);
			
			
			
			map.put("msg", "댓글 등록성공!");
			map.put("result", result);
			if(result == 1) {
                return ResponseEntity.ok(map);
            } 
            else {
            	return ResponseEntity.status(404).build();
            }
		}
		catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}
	}
	
	//삭제
		@DeleteMapping("/board/view/{apiCode}/{code}")
		public ResponseEntity<?> deleteMenu(@PathVariable String code){
			log.info("code = {}", code);
			 
			try {
				int result = commentService.deleteCultureComment(code);
				
				Map<String, Object> map = new HashMap<>();
				
				map.put("msg", "댓글 삭제 성공!");
				map.put("result", result);
				System.out.println(map);
				
				if(result == 1) {
	                return ResponseEntity.ok(map);
	            } 
	            else {
	            	return ResponseEntity.status(404).build();
	            }
			} catch (Exception e) {
				log.error(e.getMessage(), e);
				return ResponseEntity.badRequest().build();
			}
		}
		
		
		
	//수정
	@PutMapping("/board/view/{apiCode}")
	public ResponseEntity<?> updateMenu(@RequestParam Map<String,Object> map){
		log.debug("map = {}", map);
		try {
			int result = commentService.updateCultureComment(map);
			log.debug("result = {}", result);
			
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("msg", "댓글 수정 성공!");
			resultMap.put("result", result);
			return ResponseEntity.ok(resultMap);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}
	}
	
	

}
