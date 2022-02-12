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

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
		if(limit > 8)
			limit = 8;
		for(int i = 0; i < limit; i++) {
			param.put("rownum", i+1);
			Feed feed = feedDao.selectOnePersonFeedOnebyOne(param);
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

	@Override
	public int selectFeedLikesCheck(Map<String, Object> guestInfo) {
		return feedDao.selectFeedLikesCheck(guestInfo);
	}

	@Override
	public FeedComment selectOneFeedComment(Map<String, Object> map) {
		return feedDao.selectOneFeedComment(map);
	}

	@Override
	public FeedComment insertFeedComment(Map<String, Object> map) {
		int no = feedDao.insertFeedComment(map);
		no = feedDao.selectCommentNo(map);
		map.put("no", no);
		FeedComment feedComment = feedDao.selectOneFeedComment(map);
		return feedComment;
	}

	@Override
	public int deleteComment(Map<String, Object> map) {
		return feedDao.deleteComment(map);
	}

	@Override
	public List<Map<String, Object>> selectAddFeed(Map<String, Object> map) {
		return feedDao.selectAddFeed(map);
	}

	@Override
    public int feedEnroll(Feed feed) {
        int result = feedDao.feedEnroll(feed);
        log.debug("code = {}", feed.getCode());
        
        List<Attachment> attachments = feed.getAttachments();
        if(attachments != null) {
            for(Attachment attach : attachments) {
                attach.setCode(feed.getCode());
                result = insertAttachment(attach);
                
            }
        }
        return result;
    }
    public int insertAttachment(Attachment attach) {
        return feedDao.insertAttachment(attach);
    }

	@Override
	public List<Map<String, Object>> addFeedMain(Map<String, Object> map) {
		return feedDao.addFeedMain(map);
	}

	@Override
	public List<Feed> feedMain() {
		return feedDao.feedMain();
	}

	@Override
	public void deleteFeed(Map<String, Object> map) {
		feedDao.deleteFeed(map);
	}

	
	
	
}
