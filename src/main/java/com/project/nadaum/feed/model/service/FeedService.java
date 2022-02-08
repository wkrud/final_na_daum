package com.project.nadaum.feed.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.feed.model.vo.FeedComment;

public interface FeedService {

	int countAllHostFeed(Map<String, Object> param);
	
	List<Feed> selectOnePersonFeed(Map<String, Object> param);

	Map<String, Object> selectAllHostSocialCount(Map<String, Object> param);

	Feed selectOneFeed(Map<String, Object> map);

	int selectFeedLikesCheck(Map<String, Object> guestInfo);

	FeedComment selectOneFeedComment(Map<String, Object> map);

	FeedComment insertFeedComment(Map<String, Object> map);

	int deleteComment(Map<String, Object> map);

	

}
