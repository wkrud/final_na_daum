package com.project.nadaum.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.board.model.dao.BoardDao;
import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.Likes;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public List<Board> selectBoardList(Map<String, Object> param) {
		return boardDao.selectBoardList(param);
	}

	@Override
	public int selectTotalContent() {
		return boardDao.selectTotalContent();
	}
	
	//게시물 등록
//	@Transactional(
//		propagation=Propagation.REQUIRED,
//		isolation = Isolation.READ_COMMITTED,
//		rollbackFor = Exception.class
//			)
//	@Override
//	public int insertBoard(Board board) {
//		int result = boardDao.insertBoard(board); //boardEntity에 있는 보드정보들은 board테이블에 들어감. 
//		log.debug("boardCode = {}", board.getCode());
//		List<Attachment> attachments = board.getAttachments();
//		if(attachments != null) { //attachments가 null이 아니라면 반복문을 통해 insert
//			for(Attachment attach : attachments) {
//				// fk컬럼 boardNo값 설정
//		//list에서 첨부파일을 하나씩 꺼낸다음에 insertattachment 메소드를 호출함. 즉 첨부파일있는 개수만큼 insertattachment 메소드를 호출할꺼임.
//				//즉 한건 씩 처리가 됨.
//				attach.setCode(board.getCode());
//				result = insertAttachment(attach);
//			}
//		}
//		
//		return result;  //정수하나를 돌려줘야하기 때문에 result return
//	}
//
//	//게시물의 파일첨부건 등록
////	@Transactional(rollbackFor = Exception.class)
//	public int insertAttachment(Attachment attach) {
//		return boardDao.insertAttachment(attach);
//	}

	@Override
	public int insertBoard(Map<String, Object> map) {
		return boardDao.insertBoard(map);
	}

	//게시물 상세보기
	@Override
	public Board selectOneBoard(String code) {
		Board board = boardDao.selectOneBoard(code);
//		List<Attachment> attachments = boardDao.selectAttachmentListByBoardCode(code);
//		List<BoardComment> comments = boardDao.selectBoardCommentListByBoardCode(code);
		
//		board.setAttachments(attachments);
		
		return board;
	}

	@Override
	public int updateBoard(Board board) {
		return boardDao.updateBoard(board);
	}

	@Override
	public int deleteBoard(String code) {
		return boardDao.deleteBoard(code);
	}

	@Override
	public Board selectOneBoardCollection(String code) {
		return boardDao.selectOneBoardCollection(code);
	}
	
	//조회수
	@Override
	public int updateBoardReadCount(String code) {
		return boardDao.updateBoardReadCount(code);
	}
	
	//게시판 댓글
	@Override
	public List<BoardComment> selectBoardCommentList(String code) {
		return boardDao.selectBoardCommentList(code);
	}

	@Override
	public int insertBoardComment(BoardComment bc) {
		return boardDao.insertBoardComment(bc);
	}

	@Override
	public int boardCommentDelete(String commentCode) {
		return boardDao.boardCommentDelete(commentCode);
	}

	//좋아요
	@Override
	public int boardLikeAdd(Map<String, Object> param) {
		return boardDao.boardLikeAdd(param);
	}

	

	@Override
	public int boardLikeDelete(Map<String, Object> param) {
		return boardDao.boardLikeDelete(param);
	}

	@Override
	public int selectCountLikes(String code) {
		
		return boardDao.selectCountLikes(code);
	}

	@Override
	public int selectIdCountLikes(Map<String, Object> param) {
		
		return boardDao.selectIdCountLikes(param);
	}

	@Override
	public Board selectOneRiotBoard(String code) {
		
		return boardDao.selectOneRiotBoard(code);
	}

	@Override
	public int insertSchedule(Map<String, Object> map) {
		
		return boardDao.insertSchedule(map);
	}
	

	
	
	
}
