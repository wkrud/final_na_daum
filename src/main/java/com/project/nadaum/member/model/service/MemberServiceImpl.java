package com.project.nadaum.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.admin.model.vo.Announcement;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.member.model.dao.MemberDao;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member selectOneMember(Map<String, Object> idMap) {
		return memberDao.selectOneMember(idMap);
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public int confirmMember(Map<String, String> map) {
		return memberDao.confirmMember(map);
	}

	@Override
	public int insertRole(Member member) {
		return memberDao.insertRole(member);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public List<Map<String, Object>> selectAllAlarm(Map<String, Object> param) {
		return memberDao.selectAllAlarm(param);
	}

	@Override
	public List<Map<String, Object>> selectAllMyQuestions(Map<String, Object> param) {
		return memberDao.selectAllMyQuestions(param);
	}

	@Override
	public int insertKakaoMember(Map<String, Object> map) {
		return memberDao.insertKakaoMember(map);
	}

	@Override
	public Member selectOneMemberNickname(String nickname) {
		return memberDao.selectOneMemberNickname(nickname);
	}

	@Override
	public List<Map<String, Object>> selectAllAnnouncement(Map<String, Object> param) {
		return memberDao.selectAllAnnouncement(param);
	}

	@Override
	public int countAllAnnouncementList() {
		return memberDao.countAllAnnouncementList();
	}

	@Override
	public List<Member> selectAllNotInMe(Member member) {
		return memberDao.selectAllNotInMe(member);
	}

	@Override
	public List<Map<String, Object>> selectAllFriend(Member member) {
		return memberDao.selectAllFriend(member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriend(Member member) {
		return memberDao.selectAllRequestFriend(member);
	}

	@Override
	public List<Map<String, Object>> selectAllRequestFriendByMe(Member member) {
		return memberDao.selectAllRequestFriendByMe(member);
	}

	@Override
	public int updateMemberProfile(Member member) {
		return memberDao.updateMemberProfile(member);
	}

	@Override
	public List<Map<String, Object>> selectAllHelpTitle(String value) {
		return memberDao.selectAllHelpTitle(value);
	}

	@Override
	public List<Map<String, Object>> selectHelpByInput(String title) {
		return memberDao.selectHelpByInput(title);
	}

	@Override
	public Map<String, Object> selectOneSelectedHelp(String code) {
		return memberDao.selectOneSelectedHelp(code);
	}

	@Override
	public List<Map<String, Object>> selectSearchMemberNickname(String value) {
		return memberDao.selectSearchMemberNickname(value);
	}

	@Override
	public Member selectOneMemberNicknameNotMe(Map<String, Object> nicknames) {
		return memberDao.selectOneMemberNicknameNotMe(nicknames);
	}

	@Override
	public Map<String, Object> selectFollower(Map<String, Object> nicknames) {
		return memberDao.selectFollower(nicknames);
	}

	@Override
	public Map<String, Object> selectFollowing(Map<String, Object> nicknames) {
		return memberDao.selectFollowing(nicknames);
	}

	@Override
	public Map<String, Object> selectFriend(Map<String, Object> nicknames) {
		return memberDao.selectFriend(nicknames);
	}

	@Override
	public int updateRequestFriend(Map<String, Object> nicknames) {
		return memberDao.updateRequestFriend(nicknames);
	}

	@Override
	public int insertFriend(Map<String, Object> nicknames) {
		return memberDao.insertFriend(nicknames);
	}

	@Override
	public int insertAlarm(Map<String, Object> alarm) {
		return memberDao.insertAlarm(alarm);
	}

	@Override
	public int deleteRequestFriend(Map<String, Object> nicknames) {
		return memberDao.deleteRequestFriend(nicknames);
	}

	@Override
	public int deleteFriend(Map<String, Object> nicknames) {
		return memberDao.deleteFriend(nicknames);
	}

	@Override
	public int insertRequestFriend(Map<String, Object> nicknames) {
		return memberDao.insertRequestFriend(nicknames);
	}

	@Override
	public int updateMemberNickname(Member member) {
		return memberDao.updateMemberNickname(member);
	}

	@Override
	public Member selectOneMemberByEmail(Map<String, Object> email) {
		return memberDao.selectOneMemberByEmail(email);
	}

	@Override
	public Member selectOneMemberByIdEmail(Map<String, Object> map) {
		return memberDao.selectOneMemberByIdEmail(map);
	}

	@Override
	public int updateMemberPassword(Map<String, Object> map) {
		return memberDao.updateMemberPassword(map);
	}

	@Override
	public Member selectOneMemberByPhone(Map<String, Object> map) {
		return memberDao.selectOneMemberByPhone(map);
	}

	@Override
	public Member selectOneMemberByIdPhone(Map<String, Object> map) {
		return memberDao.selectOneMemberByIdPhone(map);
	}

	@Override
	public int insertMemberHelp(Map<String, Object> map) {
		return memberDao.insertMemberHelp(map);
	}

	@Override
	public List<Map<String, Object>> selectHelpOneCategory(Map<String, Object> param) {
		return memberDao.selectHelpOneCategory(param);
	}

	@Override
	public int countHelpOneCategoryCount(String category) {
		return memberDao.countHelpOneCategoryCount(category);
	}

	@Override
	public List<Map<String, Object>> selectLikesCheck(Map<String, Object> param) {
		return memberDao.selectLikesCheck(param);
	}

	@Override
	public int insertHelpLike(Map<String, Object> map) {
		return memberDao.insertHelpLike(map);
	}

	@Override
	public int deleteHelpLike(Map<String, Object> map) {
		return memberDao.deleteHelpLike(map);
	}

	@Override
	public List<Map<String, Object>> selectMostHelp() {
		return memberDao.selectMostHelp();
	}

	@Override
	public int updateMemberPhone(Map<String, Object> map) {
		return memberDao.updateMemberPhone(map);
	}

	@Override
	public int deleteMember(Member member) {
		return memberDao.deleteMember(member);
	}

	@Override
	public Announcement selectOneAnnouncement(Map<String, Object> map) {
		return memberDao.selectOneAnnouncement(map);
	}

	@Override
	public int updateAnnounceReadCount(String board) {
		return memberDao.updateAnnounceReadCount(board);
	}

	@Override
	public int updateProfile(Map<String, Object> map) {
		return memberDao.updateProfile(map);
	}

	@Override
	public int updateAlarm(Map<String, Object> map) {
		return memberDao.updateAlarm(map);
	}

	@Override
	public List<Help> selectAllMembersDyQuestions(Map<String, Object> map) {
		return memberDao.selectAllMembersDyQuestions(map);
	}

	@Override
	public List<Help> selectAllMembersAbQuestions(Map<String, Object> map) {
		return memberDao.selectAllMembersAbQuestions(map);
	}

	@Override
	public List<Help> selectAllMembersFrQuestions(Map<String, Object> map) {
		return memberDao.selectAllMembersFrQuestions(map);
	}

	@Override
	public List<Help> selectAllMembersQuestions(Map<String, Object> map) {
		return memberDao.selectAllMembersQuestions(map);
	}

	@Override
	public int countAllMyHelp(Member member) {
		return memberDao.countAllMyHelp(member);
	}

	@Override
	public int updateMemberHobby(Member member) {
		return memberDao.updateMemberHobby(member);
	}

	@Override
	public int updateHelpReadCount(String code) {
		return memberDao.updateHelpReadCount(code);
	}

	@Override
	public int updateMemberIntroduce(Map<String, Object> map) {
		return memberDao.updateMemberIntroduce(map);
	}

	@Override
	public Map<String, Object> selectHelpCategoyCount() {
		return memberDao.selectHelpCategoyCount();
	}

	
	
	
	
}
