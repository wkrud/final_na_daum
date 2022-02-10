package com.project.nadaum.websocket.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.member.model.vo.Member;

public interface WebsocketDao {

	List<Map<String, Object>> selectAlarmCount(Member member);

	int updateAlarm(Map<String, Object> map);

	List<Map<String, Object>> selectAllFriendForInvite(Member member);

}
