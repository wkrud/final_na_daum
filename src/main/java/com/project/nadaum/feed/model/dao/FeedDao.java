package com.project.nadaum.feed.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.feed.model.vo.Feed;
import com.project.nadaum.feed.model.vo.FeedComment;

public interface FeedDao {

	int countAllHostFeed(Map<String, Object> param);

	Feed selectOnePersonFeed(Map<String, Object> param);

	List<Attachment> selectAllOneFeedAttachments(Feed feed);

	List<FeedComment> selectAllOneFeedComments(Feed feed);

	int countAllHostFeedLikes(Feed feed);

	Map<String, Object> selectAllHostSocialCount(Map<String, Object> param);

	int countOneFeedComment(Feed feed);

	int selectFeedLikesCheck(Map<String, Object> guestInfo);

	FeedComment selectOneFeedComment(Map<String, Object> map);

	int insertFeedComment(Map<String, Object> map);

	int selectCommentNo(Map<String, Object> map);

}
