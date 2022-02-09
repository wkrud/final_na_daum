package com.project.nadaum.member.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.admin.model.vo.Announcement;
import com.project.nadaum.admin.model.vo.Help;
import com.project.nadaum.common.vo.Attachment;
import com.project.nadaum.member.model.vo.Member;

public interface MemberService {

	Member selectOneMember(Map<String, Object> idMap);

	int insertMember(Member member);

	int confirmMember(Map<String, String> map);

	int insertRole(Member member);

	int updateMember(Member member);

	List<Map<String, Object>> selectAllAlarm(Map<String, Object> param);

	List<Map<String, Object>> selectAllMyQuestions(Map<String, Object> param);

	int insertKakaoMember(Map<String, Object> map);

	Member selectOneMemberNickname(String nickname);

	List<Map<String, Object>> selectAllAnnouncement(Map<String, Object> param);

	int countAllAnnouncementList();

	List<Member> selectAllNotInMe(Member member);

	List<Map<String, Object>> selectAllFriend(Member member);

	List<Map<String, Object>> selectAllRequestFriend(Member member);

	List<Map<String, Object>> selectAllRequestFriendByMe(Member member);

	int updateMemberProfile(Member member);

	List<Map<String, Object>> selectAllHelpTitle(String value);

	List<Map<String, Object>> selectHelpByInput(String title);

	Map<String, Object> selectOneSelectedHelp(String code);

	List<Map<String, Object>> selectSearchMemberNickname(String value);

	Member selectOneMemberNicknameNotMe(Map<String, Object> nicknames);

	Map<String, Object> selectFollower(Map<String, Object> nicknames);

	Map<String, Object> selectFollowing(Map<String, Object> nicknames);

	Map<String, Object> selectFriend(Map<String, Object> nicknames);

	int updateRequestFriend(Map<String, Object> nicknames);

	int insertFriend(Map<String, Object> nicknames);

	int insertAlarm(Map<String, Object> alarm);

	int deleteRequestFriend(Map<String, Object> nicknames);

	int deleteFriend(Map<String, Object> nicknames);

	int insertRequestFriend(Map<String, Object> nicknames);

	int updateMemberNickname(Member member);

	Member selectOneMemberByEmail(Map<String, Object> map);

	Member selectOneMemberByIdEmail(Map<String, Object> map);

	int updateMemberPassword(Map<String, Object> map);

	Member selectOneMemberByPhone(Map<String, Object> map);

	Member selectOneMemberByIdPhone(Map<String, Object> map);

	int insertMemberHelp(Map<String, Object> map);

	List<Map<String, Object>> selectHelpOneCategory(Map<String, Object> param);

	int countHelpOneCategoryCount(String category);

	List<Map<String, Object>> selectLikesCheck(Map<String, Object> param);

	int insertHelpLike(Map<String, Object> map);

	int deleteHelpLike(Map<String, Object> map);

	List<Map<String, Object>> selectMostHelp();

	int updateMemberPhone(Map<String, Object> map);

	int deleteMember(Member member);

	Announcement selectOneAnnouncement(Map<String, Object> map);

	int updateAnnounceReadCount(String board);

	int updateProfile(Map<String, Object> map);

	int updateAlarm(Map<String, Object> map);

	List<Help> selectAllMembersDyQuestions(Map<String, Object> map);

	List<Help> selectAllMembersAbQuestions(Map<String, Object> map);

	List<Help> selectAllMembersFrQuestions(Map<String, Object> map);

	List<Help> selectAllMembersQuestions(Map<String, Object> map);

	int countAllMyHelp(Member member);

	int updateMemberHobby(Member member);

	int updateHelpReadCount(String code);

	int updateMemberIntroduce(Map<String, Object> map);

	Map<String, Object> selectHelpCategoyCount();




}
