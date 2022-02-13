package com.project.nadaum.feed.model.service;
import java.util.List;
import java.util.Map;
import com.project.nadaum.board.model.vo.Likes;
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
    List<Map<String, Object>> selectAddFeed(Map<String, Object> map);
    int feedEnroll(Feed feed);
    List<Map<String, Object>> addFeedMain(Map<String, Object> map);
    List<Feed> feedMain(String id);
    void deleteFeed(Map<String, Object> map);
    Feed feedMainLikeSave(Likes likes);
    Feed feedMainLikeRemove(Likes likes);
    int addFeedMainCount(Map<String, Object> map);
    
}
