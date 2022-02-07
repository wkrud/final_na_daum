package com.project.nadaum.feed.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.nadaum.feed.model.service.FeedService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/feed")
public class FeedController {
	
	@Autowired
	private FeedService feedService;

}
