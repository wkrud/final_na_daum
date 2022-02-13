package com.project.nadaum.board.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.BoardEntity;
import com.project.nadaum.board.model.vo.Likes;
import com.project.nadaum.board.model.vo.RiotSchedule;

public interface BoardDao {

	List<Board> selectBoardList(Map<String, Object> param);
	
	int selectTotalContent();

//	int insertBoard(Board board);
//	int insertAttachment(Attachment attach);
	int insertBoard(Map<String, Object> map);
	
//	List<Attachment> selectAttachmentListByBoardCode(String code);

	int updateBoard(Board board);

	int deleteBoard(String code);
	
	Board selectOneBoard(String code);

	Board selectOneRiotBoard(String code);
	
	Board selectOneBoardCollection(String code);

	//조회수
	int updateBoardReadCount(String code);
	
	//게시물 댓글
	List<BoardComment> selectBoardCommentList(String code);

	int insertBoardComment(BoardComment bc);

	int boardCommentDelete(String commentCode);

	int boardLikeAdd(Map<String, Object> param);

	int selectCountLikes(String code);
	
	int selectIdCountLikes(Map<String, Object> param);
	
	

	int boardLikeDelete(Map<String, Object> param);

	int insertSchedule(RiotSchedule riotSchedule);

	RiotSchedule selectOneboardScheduleCheck(String schedulecode);

	


}
