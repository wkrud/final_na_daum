package com.project.nadaum.common.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/error")
public class ErrorController {
	
	@GetMapping("/notEnoughRole.do")
	public void notEnoughRole() {}
	
}
