package com.project.nadaum.feed.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.feed.model.dao.FeedDao;
import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.feed.model.vo.FeedComment;

@Service
@Transactional(rollbackFor=Exception.class)
public class FeedServiceImpl implements FeedService {

	@Autowired
	private FeedDao feedDao;
		
	@Override
	public int countAllHostFeed(Map<String, Object> param) {
		return feedDao.countAllHostFeed(param);
	}

	@Override
	public List<Feed> selectOnePersonFeed(Map<String, Object> param) {
		List<Feed> list = new ArrayList<>();
		int limit = (int) param.get("totalCount");
		for(int i = 0; i < limit; i++) {
			Feed feed = feedDao.selectOnePersonFeed(param);
			List<Attachment> attach = feedDao.selectAllOneFeedAttachments(feed);
			int comment = feedDao.countOneFeedComment(feed);
			int likes = feedDao.countAllHostFeedLikes(feed);			
			feed.setLikes(likes);
			feed.setCommentCount(comment);				
			
			if(attach != null && !attach.isEmpty()) {
				feed.setAttachments(attach);
				feed.setAttachCount(attach.size());				
			}
			
			list.add(feed);
		}
		return list;
	}

	@Override
	public Map<String, Object> selectAllHostSocialCount(Map<String, Object> param) {
		return feedDao.selectAllHostSocialCount(param);
	}

	@Override
	public Feed selectOneFeed(Map<String, Object> map) {
		Feed feed = feedDao.selectOnePersonFeed(map);
		List<Attachment> attach = feedDao.selectAllOneFeedAttachments(feed);
		List<FeedComment> comment = feedDao.selectAllOneFeedComments(feed);
		int likes = feedDao.countAllHostFeedLikes(feed);
		feed.setLikes(likes);
		feed.setAttachments(attach);
		if(attach != null && !attach.isEmpty())
			feed.setAttachCount(attach.size());
		else
			feed.setAttachCount(0);
		feed.setComments(comment);
		return feed;
	}

	
	
	
}
