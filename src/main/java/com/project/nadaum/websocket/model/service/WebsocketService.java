package com.project.nadaum.websocket.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.member.model.vo.Member;

public interface WebsocketService {

	List<Map<String, Object>> selectAlarmCount(Member member);

	int updateAlarm(Map<String, Object> map);

	List<Map<String, Object>> selectAllFriendForInvite(Member member);

}
