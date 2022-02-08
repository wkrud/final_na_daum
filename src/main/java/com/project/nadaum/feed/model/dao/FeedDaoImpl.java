package com.project.nadaum.feed.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.feed.model.vo.FeedComment;

@Repository
public class FeedDaoImpl implements FeedDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int countAllHostFeed(Map<String, Object> param) {
		return session.selectOne("feed.countAllHostFeed", param);
	}

	@Override
	public Feed selectOnePersonFeed(Map<String, Object> param) {
		return session.selectOne("feed.selectOnePersonFeed", param);
	}

	@Override
	public List<Attachment> selectAllOneFeedAttachments(Feed feed) {
		return session.selectList("feed.selectAllOneFeedAttachments", feed);
	}

	@Override
	public List<FeedComment> selectAllOneFeedComments(Feed feed) {
		return session.selectList("feed.selectAllOneFeedComments", feed);
	}

	@Override
	public int countAllHostFeedLikes(Feed feed) {
		return session.selectOne("feed.countAllHostFeedLikes", feed);
	}

	@Override
	public Map<String, Object> selectAllHostSocialCount(Map<String, Object> param) {
		return session.selectOne("feed.selectAllHostSocialCount", param);
	}

	@Override
	public int countOneFeedComment(Feed feed) {
		return session.selectOne("feed.countOneFeedComment", feed);
	}

	@Override
	public int selectFeedLikesCheck(Map<String, Object> guestInfo) {
		return session.selectOne("feed.selectFeedLikesCheck", guestInfo);
	}
	
	
	
	
}
