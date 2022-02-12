package com.project.nadaum.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.BoardEntity;
import com.project.nadaum.board.model.vo.Likes;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public List<Board> selectBoardList(Map<String, Object> param) {
		int offset = (int) param.get("offset");
		int limit = (int) param.get("limit");
		RowBounds rowBounds = new RowBounds(offset, limit);
		return session.selectList("board.selectBoardList", null, rowBounds);
	}

	@Override
	public int selectTotalContent() {
		return session.selectOne("board.selectTotalContent");
	}
	
//	@Override
//	public int insertBoard(Board board) {
//		return session.insert("board.insertBoard", board);
//	}
	
//	@Override
//	public int insertAttachment(Attachment attach) {
//		return session.insert("board.insertAttachment", attach);
//	}
	
	@Override
	public int insertBoard(Map<String, Object> map) {
		return session.insert("board.insertBoard", map);
	}
	
	@Override
	public int updateBoard(Board board) {
		return session.update("board.updateBoard", board);
	}

	@Override
	public int deleteBoard(String code) {
		return session.delete("board.deleteBoard", code);
	}
	
	//게시물한건조회
	@Override
	public Board selectOneBoard(String code) {
		return session.selectOne("board.selectOneBoard", code);
	}
	
	

	//여러건조회
//	@Override
//	public List<Attachment> selectAttachmentListByBoardCode(String code) {
//		return session.selectList("board.selectAttachmentListByBoardCode", code);
//	}

	

	@Override
	public Board selectOneBoardCollection(String code) {
		return session.selectOne("board.selectOneBoardCollection", code);
	}

	//조회수
	@Override
	public int updateBoardReadCount(String code) {
		return session.update("board.updateBoardReadCount", code);
	}

	//게시판 댓글
	@Override
	public List<BoardComment> selectBoardCommentList(String code) {
		return session.selectList("board.selectBoardCommentList", code);
	}

	@Override
	public int insertBoardComment(BoardComment bc) {
		return session.insert("board.insertBoardComment", bc);
	}

	@Override
	public int boardCommentDelete(String commentCode) {
		return session.delete("board.boardCommentDelete", commentCode);
	}

	//좋아요
	@Override
	public int boardLikeAdd(Map<String, Object> param) {
		return session.insert("board.boardLikeAdd", param);
	}

	

	@Override
	public int boardLikeDelete(Map<String, Object> param) {
		return session.delete("board.boardLikeDelete", param);
	}

	@Override
	public int selectCountLikes(String code) {
		
		return session.selectOne("board.selectCountLikes", code);
	}

	@Override
	public int selectIdCountLikes(Map<String, Object> param) {
		
		return session.selectOne("board.selectIdCountLikes", param);
	}

	@Override
	public Board selectOneRiotBoard(String code) {
		
		return session.selectOne("board.selectOneRiotBoard", code);
	}

	@Override
	public int insertSchedule(Map<String, Object> map) {
		
		return session.insert("board.insertSchedule", map);
	}

	


	

	
}
