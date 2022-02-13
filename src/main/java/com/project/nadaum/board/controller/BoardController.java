package com.project.nadaum.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.project.nadaum.board.model.service.BoardService;
import com.project.nadaum.board.model.vo.Board;
import com.project.nadaum.board.model.vo.BoardComment;
import com.project.nadaum.board.model.vo.Likes;
import com.project.nadaum.board.model.vo.RiotSchedule;
import com.project.nadaum.common.BoardUtils;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.vo.Member;
import com.project.nadaum.member.model.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private ServletContext application;

	@Autowired
	private MemberService memberService;

	// 추천수
	@ResponseBody
	@GetMapping("/boardLikeDelete.do")
	public Map<String, Object> boardLikeDelete(@RequestParam String code, @RequestParam String id) {

		Map<String, Object> param = new HashMap<>();
		param.put("code", code);
		param.put("id", id);

		int result = boardService.boardLikeDelete(param);
		log.debug("좋아요 삭제 result = {}", result);

		// 좋아요 삭제하고 새로 추가된 좋아요 갯수 받아오기
		int selectCountLikes = boardService.selectCountLikes(code);
		log.debug("좋아요 수 삭제해서 0이어야함 = {}", selectCountLikes);

		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("selectCountLikes", selectCountLikes);

		return map;
	}

	@ResponseBody
	@GetMapping("/boardLikeAdd.do")
	public Map<String, Object> boardLikeAdd(@RequestParam String code, @RequestParam String id) {

		Map<String, Object> param = new HashMap<>();
		param.put("code", code);
		param.put("id", id);

		int result = boardService.boardLikeAdd(param);
		log.debug("좋아요 추가 result = {}", result);

		// 좋아요 추가하고 새로 추가된 좋아요 갯수 받아오기
		int selectCountLikes = boardService.selectCountLikes(code);

		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("selectCountLikes", selectCountLikes);

		return map;
	}

	@ResponseBody
	@GetMapping("/boardLikeTotalAdd.do")
	public Map<String, Object> boardLikeTotalAdd(@RequestParam String code, @RequestParam String id) {

		Map<String, Object> param = new HashMap<>();
		param.put("code", code);
		param.put("id", id);

		// 좋아요 추가하고 새로 추가된 좋아요 갯수 받아오기
		int selectCountLikes = boardService.selectCountLikes(code);

		Map<String, Object> map = new HashMap<>();

		map.put("selectCountLikes", selectCountLikes);

		return map;
	}

	@ResponseBody
	@GetMapping("/boardLikeIdCount.do")
	public Map<String, Object> boardLikeIdCount(@RequestParam String code, @RequestParam String id) {

		Map<String, Object> param = new HashMap<>();
		param.put("code", code);
		param.put("id", id);

		// 좋아요 추가하고 새로 추가된 좋아요 갯수 받아오기
		int selectIdCountLikes = boardService.selectIdCountLikes(param);

		Map<String, Object> map = new HashMap<>();

		map.put("selectIdCountLikes", selectIdCountLikes);

		return map;
	}

	// 게시물 댓글삭제
	@PostMapping("/boardCommentDelete.do")
	public String boardCommentDelete(@RequestParam String code, @RequestParam String commentCode,
			RedirectAttributes redirectAttr) throws Exception {

		int result = boardService.boardCommentDelete(commentCode);
		String msg = "댓글 삭제 성공";
		redirectAttr.addFlashAttribute(msg);

		return "redirect:/board/boardDetail.do?code=" + code;
	}

	// 게시물 댓글등록
//	@ResponseBody
	@PostMapping("/boardCommentEnroll.do")
	public String boardCommentEnroll(@AuthenticationPrincipal Member member, @RequestParam String code,
			@RequestParam int commentLevel, // 댓글-1, 대댓글-2 확인
			@RequestParam String commentRef, // 참조하는 댓글코드 (대댓글인 경우 참고하는 댓글코드, 댓글인 경우 null)
			@RequestParam String id, @RequestParam String content,
//			HttpSession session,
			BoardComment bc) throws Exception {
		try {
//		id = (String) session.getAttribute("");

			log.debug("bc = {}", bc);

			int result = boardService.insertBoardComment(bc);
			log.debug("commentList = {}", bc);

			return "redirect:/board/boardDetail.do?code=" + code;

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return "redirect:error.do";
		}

	}

	// 게시물 삭제하기
	@PostMapping("/boardDelete.do")
	public String boardDelete(@RequestParam String code, RedirectAttributes redirectAttr) throws Exception {

		int result = boardService.deleteBoard(code);
		String msg = "게시글 삭제 성공";
		redirectAttr.addFlashAttribute(msg);

		return "redirect:/board/boardList.do";
	}

	// 게시물 수정
	@GetMapping("/boardUpdateView.do")
	public String boardUpdate(@AuthenticationPrincipal Member member, @RequestParam String code, Model model)
			throws Exception {

		Board board = boardService.selectOneBoard(code);
		model.addAttribute("board", board);

		return "board/boardUpdateView";
	}

	// 게시물 수정하기
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board board, @AuthenticationPrincipal Member member, RedirectAttributes redirectAttr)
			throws Exception {

		Map<String, Object> param = new HashMap<>();

		param.put("board", board);

		int result = boardService.updateBoard(board);
		log.debug("delete result = {}", result);
		String msg = "게시물 수정 성공!";
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/board/boardList.do";
	}

	// 게시물 상세보기
	@GetMapping("/boardDetail.do")
	public String boardDetail(@AuthenticationPrincipal Member member, @RequestParam Map<String, Object> map,
			Model model,
//			@CookieValue(value="boardCount", required=false, defaultValue="0") String value,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String code = (String) map.get("code");
	
		String schedulecode = (String) map.get("schedulecode");
		
		log.info("schedulecode={}", schedulecode);
		try {
			// 상세보기를 요청하면, 해당글에 대한 boardCookie가 존재하지 않을때 조회수를 1증가한다.
			// a.검사
			Cookie[] cookies = request.getCookies();
			boolean hasRead = false;
			String boardCookieVal = "";
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					String name = cookie.getName();
					String value = cookie.getValue();
					if ("boardCookie".equals(name)) {
						boardCookieVal = value; // 기존쿠키값
						if (value.contains("[" + code + "]")) {
							hasRead = true;
							break;
						}
					}
				}
			}
			// b.조회수 증가 및 쿠키생성
			if (!hasRead) {
				int result = boardService.updateBoardReadCount(code);

				Cookie cookie = new Cookie("boardCookie", boardCookieVal + "[" + code + "]");
				cookie.setPath(request.getContextPath() + "/board/boardDetail.do");
				cookie.setMaxAge(365 * 24 * 60 * 60); // 365일짜리 영속쿠키
				response.addCookie(cookie);
				log.debug("게시판쿠키 = {}", cookie);

				System.out.println("[BoardViewServlet] 조회수 증가 및 boardCookie 생성");

			}

			// 게시글 가져오기
			Board board = boardService.selectOneBoard(code);
			Board boardriot = boardService.selectOneRiotBoard(code);
//			Board board = boardService.selectOneBoardCollection(code);
			log.debug("boardDetail board ={}", board);
			log.debug("code = {} ", code);

			// 댓글목록 조회
			List<BoardComment> commentList = boardService.selectBoardCommentList(code);
			// log.debug("commentList = {} ", commentList);

//			String nickname = boardService.boardGetNickname()

			// int selectCountLikes = boardService.selectCountLikes(code);
			log.debug("boardDetail board ={}", board);
			// model.addAttribute("selectCountLikes",selectCountLikes);

			List<Map<String, Object>> friends = memberService.selectAllFriend(member);
			List<Member> memberList = memberService.selectAllNotInMe(member);

			// Schedule schedule = boardService.selectOneSchedule();
			map.put("schedulecode",schedulecode);
			log.info("checkcode ={}", map);

			model.addAttribute("memberList", memberList);
			model.addAttribute("friends", friends);
			model.addAttribute("board", board);
			model.addAttribute("boardriot", boardriot);
			model.addAttribute("commentList", commentList);
			model.addAttribute("check", map);
			

		} catch (Exception e) {
			log.error(e.getMessage());

		}
		return "board/boardDetail";
	}

	// 게시글 목록
	@GetMapping("/boardList.do")
	public void boardList(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model)
			throws Exception {

		// content 영역
		int limit = 10;
		int offset = (cPage - 1) * limit;

		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);

		// 리스트 보여주기
		List<Board> list = boardService.selectBoardList(param);
		log.debug("(boardList) list = {}", list);

		// pagebar 영역
		int totalContent = boardService.selectTotalContent();
		String url = request.getRequestURI();
//		String pagebar = NadaumUtils.getPagebar(cPage, limit, totalContent, url, null );
		String pagebar = BoardUtils.getPagebar(cPage, limit, totalContent, url);

//		int commentCount = boardService.boardCommentCount(code);

		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
	}

	// 썸머노트 게시물 등록
	@GetMapping("/boardEnroll.do")
	public void boardEnroll() throws Exception {
	}

	@PostMapping("/boardEnroll.do")
	public String boardEnroll(Board board, @AuthenticationPrincipal Member member,
			@RequestParam Map<String, Object> map, RedirectAttributes redirectAttr) throws Exception {

		map.put("id", member.getId());
		map.put("board", board);
		log.debug("boardEnroll map = {}", map);

		int result = boardService.insertBoard(map);
		String msg = "게시물 등록 성공!";
		redirectAttr.addFlashAttribute("msg", msg);

		return "redirect:/board/boardList.do";
	}

	@RequestMapping(value = "/uploadSummernoteImageFile.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) {

		JsonObject jsonObject = new JsonObject();

		String fileRoot = application.getRealPath("/resources/upload/board/img/");
		log.debug("fileRoot = {}", fileRoot);
		String originalFileName = file.getOriginalFilename();
		String renamedFileName = NadaumUtils.rename(originalFileName);

		File targetFile = new File(fileRoot, renamedFileName);
		try {
			file.transferTo(targetFile);
		} catch (IllegalStateException | IOException e) {
			log.error(e.getMessage(), e);
		}

		jsonObject.addProperty("url", "/nadaum/resources/upload/board/img/" + renamedFileName);
		jsonObject.addProperty("responseCode", "success");
		log.debug("root = {}", jsonObject.toString());

		return jsonObject.toString();
	}

	


	@PostMapping(value = "/deleteSummernoteImageFile.do")
	public ResponseEntity<?> deleteSummernoteImageFile(@RequestParam Map<String, Object> map,Model model) {

		log.debug("map = {}", map);

		String fileRoot = application.getRealPath("/resources/upload/board/img");
		String url = (String) map.get("val");
		String[] strs = url.split("/");
		String filename = strs[strs.length - 1];

		String lastDest = url.substring(url.length() - 26, url.length());
		String allDest = fileRoot + lastDest;

		File img = new File(allDest);
		img.delete();

		return ResponseEntity.ok(1);
	}

	@PostMapping("/boardSchedule.do")
	public ResponseEntity<?> insertSchedule(@RequestParam Map<String, Object> map, Model model) throws ParseException {

		String title = (String) map.get("title");
		String startDatebefore = (String) map.get("startDate");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = format.parse(startDatebefore);
		String friendId = (String) map.get("friendId");
		String apiCode = (String) map.get("apiCode");
		String id = (String) map.get("id");

		RiotSchedule riotSchedule = new RiotSchedule(null, friendId, '\u0000', apiCode, startDate, 1, id, title);

		log.info("title={}", title);

		try {

			String schedulecode = boardService.insertSchedule(riotSchedule);
			log.info("Schedulecode={}", schedulecode);
			if (schedulecode != null) {
				int result = 1;
				log.debug("result={}", result);
				String msg = (result > 0) ? "약속잡기 성공" : "약속잡기 실패";
				map.put("schedulecode", schedulecode);
				map.put("result", result);
				map.put("msg", msg);
				
				
					return ResponseEntity.ok(map);
				
					
				
			}
			else {
				
				return ResponseEntity.status(404).build();
			}
	


		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}

	}
	@ResponseBody
	@GetMapping("/boardScheduleCheck.do")
	public Map<String, Object> boardScheduleCheck(@RequestParam String schedulecode) {

		Map<String, Object> param = new HashMap<>();
	
		RiotSchedule checkresult = boardService.selectOneboardScheduleCheck(schedulecode);
		char accept = checkresult.getAccept();
		int allDay = checkresult.getAllDay();
		String friendnickname = checkresult.getFriendId();
		String mynickname = checkresult.getId();
		Date startDate = checkresult.getStartDate();
		String content = checkresult.getTitle();
		String friendid = checkresult.getId();
		
		param.put("accept", accept);
		param.put("allDay", allDay);
		param.put("friendnickname", friendnickname);
		param.put("mynickname", mynickname);
		param.put("startDate", startDate);
		param.put("content", content);
		param.put("friendid", friendid);
		
		
		

		

		return param;
	}

	@PostMapping("/boardReceiveSchedule.do")
	public ResponseEntity<?> insertReceiveSchedule(@RequestParam Map<String, Object> map ) {

		log.debug("map = {}", map);
		String id = (String) map.get("id");
		String friendid = (String) map.get("friendid");
		
	
		try {
				map.remove("friendid");
				log.debug("map = {}", map);
			 int result = boardService.insertFinalSchedule(map);
			 	map.put("friendid",friendid);
			 	map.remove("id");
			 	log.debug("map = {}", map);
			 int result2 = boardService.insertFinalSecondSchedule(map);
			 
			 log.debug("result={}", result2);
			 String msg = (result2 > 0) ? "약속수락 성공" : "약속수락 실패";
			 map.put("msg", msg);
			
						
			
			if (result == 1) {

				return ResponseEntity.ok(map);
			} else {
				return ResponseEntity.status(404).build();
			}

		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return ResponseEntity.badRequest().build();
		}

	}

}
