package com.project.nadaum.websocket.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.member.model.vo.Member;

@Repository
public class WebsocketDaoImpl implements WebsocketDao {
	
	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Map<String, Object>> selectAlarmCount(Member member) {
		return session.selectList("ws.selectAlarmCount", member);
	}

	@Override
	public int updateAlarm(Map<String, Object> map) {
		return session.update("ws.updateAlarm", map);
	}

	@Override
	public List<Map<String, Object>> selectAllFriendForInvite(Member member) {
		return session.selectList("ws.selectAllFriendForInvite", member);
	}
	
	

}
