package com.project.nadaum.board.model.service;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.BoardEntity;
import com.project.nadaum.board.model.vo.Likes;

public interface BoardService {

	//게시판 목록
	List<Board> selectBoardList(Map<String, Object> param);

	//pagebar
	int selectTotalContent();
	
	
	//게시판 등록
//	int insertBoard(Board board);
//	int insertAttachment(Attachment attach);
	int insertBoard(Map<String, Object> map);

	int updateBoard(Board board);

	int deleteBoard(String code);

	Board selectOneBoard(String code);

	Board selectOneBoardCollection(String code);
	
	//조회수
	int updateBoardReadCount(String code);

	//댓글
	List<BoardComment> selectBoardCommentList(String code);

	int insertBoardComment(BoardComment bc);

	int boardCommentDelete(String commentCode);

	//좋아요
	int boardLikeAdd(Map<String, Object> param);

	int selectCountLikes(String code);
	
	int selectIdCountLikes(Map<String, Object> param);

	int boardLikeDelete(Map<String, Object> param);





}
