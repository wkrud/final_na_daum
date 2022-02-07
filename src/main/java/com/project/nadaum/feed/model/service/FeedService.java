package com.project.nadaum.feed.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.feed.model.vo.Feed;

public interface FeedService {

	int countAllHostFeed(Map<String, Object> param);
	
	List<Feed> selectOnePersonFeed(Map<String, Object> param);

	Map<String, Object> selectAllHostSocialCount(Map<String, Object> param);

	Feed selectOneFeed(Map<String, Object> map);



}
