package com.project.nadaum.audiobook.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.nadaum.audiobook.model.service.AlbumService;
import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;
import com.project.nadaum.common.NadaumUtils;
import com.project.nadaum.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/audiobook")
public class AlbumController {

	@Autowired
	private AlbumService albumService;

	@Autowired
	private ServletContext application;

	public static final String FILE_PATH = "C:\\Workspaces\\finalProject\\na_daum\\src\\main\\webapp\\resources\\upload\\audiobook";
	public static final String DEFAULT_IMG = "default.jpg";
	public static final String AUDIO_PATH = "C:\\Workspaces\\finalProject\\na_daum\\src\\main\\webapp\\resources\\upload\\audiobook\\mp3\\";
	public static final String IMG_PATH = "C:\\Workspaces\\finalProject\\na_daum\\src\\main\\webapp\\resources\\upload\\audiobook\\img\\";

	@GetMapping("/")
	@RequestMapping
	public String audiobookMain(Model model) {

		// 메인화면
		List<Map<String, Object>> recentList = albumService.selectListAlbumInfoRecentMain();
		List<Map<String, Object>> classicList = albumService.selectListAlbumInfoByKindMain("Classic");
		List<Map<String, Object>> jazzList = albumService.selectListAlbumInfoByKindMain("Jazz");
		List<Map<String, Object>> asmrList = albumService.selectListAlbumInfoByKindMain("ASMR");
		List<Map<String, Object>> novelList = albumService.selectListAlbumInfoByKindMain("Novel");
		// model.addAttribute("loginMember",loginMember);
		model.addAttribute("recentList", recentList);
		model.addAttribute("classicList", classicList);
		model.addAttribute("jazzList", jazzList);
		model.addAttribute("asmrList", asmrList);
		model.addAttribute("novelList", novelList);
		return "audiobook/main";
	}
	
	
	@ResponseBody
	@PostMapping(value = "/widget", produces = "application/json; charset=UTF-8")
	public Map<String,Object> audiobookWidget(){
		Map<String, Object> map = new HashMap<>();
		try {
			AlbumInfo albumInfo = albumService.selectWidgetAlbumInfo(map);
			String imgLink = "/resources/upload/audiobook/img/"
							+ albumService.selectListAlbumImg(albumInfo.getCode()).get(0).getRenamedFilename();
			map.put("albumInfo", albumInfo);// albumInfo.title, albumInfo.kind...
			map.put("imgLink", imgLink); //이미지 표시하시면 img src에 붙여 쓰시면됩니다.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	
	
	@GetMapping("/widgetInfo")
	public ResponseEntity<ModelMap> widgetInfo(ModelMap model) {
		try {
			List<Map<String, Object>> widgetMenu = albumService.selectListAlbumInfoByKindMain("Novel");
			log.debug("widgetMenu={}", widgetMenu);
			model.addAttribute("bookList", widgetMenu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok(model);
	}
	
	@GetMapping("/widgetPage")
	public String widget(ModelMap model) {
		try {
			List<Map<String, Object>> widgetMenu = albumService.selectListAlbumInfoByKindMain("Novel");
			log.debug("widgetMenu={}", widgetMenu);
			model.addAttribute("bookList", widgetMenu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/audiobook/widget";
	}

	@GetMapping("/detail")
	public String albumPage(@RequestParam String code, Model model) {
		log.debug("albumCode={}", code);

		AlbumInfo result = albumService.selectOneAlbumInfo(code);
		List<AlbumImg> imgResult = albumService.selectListAlbumImg(code);
		List<AlbumTrack> trackResult = albumService.selectListAlbumTrack(code);
		model.addAttribute("album", result);
		model.addAttribute("img", imgResult.get(0));
		model.addAttribute("trackList", trackResult);
		return "/audiobook/album/albumDetail";
	}

	/* search by keyword (페이징 바에서 더보기로 전환할 예정) */
	@GetMapping("/search/list")
	public String albumSearch(@RequestParam(defaultValue = "1") int cPage, Model model) {
		Map<String, Object> param = new HashMap<>();
		int limit = 10;
		int offset = (cPage - 1) / limit;
		param.put("offset", offset);
		param.put("limit", limit);
		List<Map<String, Object>> searchList = albumService.selectListAlbum(param);
		log.debug("listMap={}", searchList);
		for (int i = 0; i < searchList.size(); i++) {
			// String imgSrc="/resources/upload/audiobook/"+(String)
			// searchList.get(i).get("renamedFilename");
			String imgSrc = application.getRealPath("/resources/upload/audiobook")
					+ (String) searchList.get(i).get("renamedFilename");

			log.debug("imgSrc={}", imgSrc);
			Map<String, Object> url = new HashMap<>();
			url.put("imgSrc", imgSrc);
			searchList.get(i).put("imgSrc", imgSrc);
		}
		model.addAttribute("searchList", searchList);
		return "/audiobook/search/searchList";
	}

	// Dynamic Search
	@GetMapping("/search/list/select")
	public String albumSearch(@RequestParam String searchType, @RequestParam String searchKeyword, ModelMap model) {
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		log.debug("searchType={}, searchKeyword={}", searchType, searchKeyword);
		List<Map<String, Object>> selectList = new ArrayList<>();
		if (searchType == null || searchKeyword == null) {
			return "/audiobook/search/searchList";
		} else {
			selectList = albumService.selectListAlbumInfoByWord(param);
		}
		for (int i = 0; i < selectList.size(); i++) {
			// String imgSrc="/resources/upload/audiobook/"+(String)
			// searchList.get(i).get("renamedFilename");
			String imgSrc = application.getRealPath("/resources/upload/audiobook")
					+ (String) selectList.get(i).get("renamedFilename");
			log.debug("imgSrc={}", imgSrc);
			Map<String, Object> url = new HashMap<>();
			url.put("imgSrc", imgSrc);
			selectList.get(i).put("imgSrc", imgSrc);
		}

		model.clear();
		model.addAttribute("selectList", selectList);
		log.debug("selectList={}", selectList);
		return "/audiobook/search/selectList";
	}

	/*
	 * 동적 입력으로 전환
	 * 
	 * @GetMapping("/search/type") public String albumSearch(@RequestParam
	 * Map<String, Object> type, ModelMap model) { List<AlbumInfo> list =
	 * albumService.selectListAlbumInfoByType(type); model.addAttribute(list);
	 * return "/audiobook/search/searchList"; }
	 */

	/* comment */
	@GetMapping("/album/comment/list")
	public String albumCommentList(@RequestParam Album album, ModelMap model) {
		List<AlbumComment> list = albumService.selectListAlbumComment(album.getCode());
		model.addAttribute("list", list);
		return "/albumCommentList";
	}

	@GetMapping("/album/comment")
	public void albumCommentsEnroll(@RequestParam AlbumComment alComment, ModelMap model) {

	}

	/**
	 * Comment - Enroll,Update,Delete
	 */
	@PostMapping("/album/comment/enroll")
	public String albumCommentEnroll(@RequestParam AlbumComment alComment, ModelMap model) {
		log.debug("albumComment={}", alComment);
		int result = albumService.insertAlbumComment(alComment);
		model.clear();
		String msg = (1 == result) ? "등록완료" : "등록실패";
		model.addAttribute("msg", msg);
		return "/audiobook/comment/list";
	}

	@PostMapping("/album/comment/update")
	public String albumCommentUpdate(@RequestParam AlbumComment alComment, ModelMap model) {
		log.debug("albumComment={}", alComment);
		int result = albumService.insertAlbumComment(alComment);
		model.clear();
		String msg = (1 == result) ? "수정완료" : "수정실패";
		model.addAttribute("msg", msg);
		//
		return "/album/comment/list";
	}

	@PostMapping("/album/comment/delete")
	public String albumCommentDelete(@RequestParam AlbumComment alComment, ModelMap model) {
		log.debug("albumComment={}", alComment);
		int result = albumService.deleteAlbumComment(alComment);
		model.clear();
		String msg = (1 == result) ? "삭제완료" : "삭제실패";
		model.addAttribute("msg", msg);
		//
		return "/album/comment/list";
	}

	/**
	 * Recommend 
	 */
	@GetMapping("/recommend/list")
	public String recommend() {
		return "/audiobook/recommend/recommendList";
	}
	
	/* Album (Old Code 모두 전환예정) */

	/**
	 * Album - Enroll,Update,Delete
	 */
	@GetMapping("/album/enroll")
	public String albumForm() {
		// 관리자 여부 확인 or aop, filter처리
		// if(ADMIN!=member.role) {}
		// else(){}
		return "/audiobook/album/enrollForm";
	}

	@GetMapping("/album/enroll/list")
	public String albumList(@AuthenticationPrincipal Member member, @RequestParam(defaultValue = "1") int cPage,
			HttpServletRequest request, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);

		List<AlbumInfo> list = albumService.selectListAlbumInfo(param);
		log.debug("list ={}", list);

		int totalContent = albumService.selectTotalContent();
		String url = request.getRequestURI();
		String pagebar = getPageBar(cPage, limit, totalContent, url);

		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);

		return "/audiobook/album/enrollList";
	}

	@PostMapping("/album/enroll")
	public String albumEnroll(@AuthenticationPrincipal Member member,
			Album album, 
			@RequestParam(name = "trkFile") MultipartFile[] trkFiles,
			@RequestParam(name = "imgFile") MultipartFile[] imgFiles, 
			ModelMap model, RedirectAttributes redirectAttr)
			throws IllegalStateException, IOException {

		String saveAudioDirectory = application.getRealPath("/resources/upload/audiobook/mp3");
		String saveImgDirectory = application.getRealPath("/resources/upload/audiobook/img");
		log.debug("saveAudioDirectory={}", saveAudioDirectory);
		log.debug("saveImgDirectory={}", saveImgDirectory);
		log.debug("track1={}", trkFiles[0].getOriginalFilename());
		log.debug("imgFiles={}", imgFiles[0].getOriginalFilename());

		List<AlbumTrack> trackList = new ArrayList<>();
		List<AlbumImg> imgList = new ArrayList<>();

		for (int i = 0; i < trkFiles.length; i++) {
			MultipartFile trkFile = trkFiles[i];
			if (!trkFile.isEmpty()) {
				String originalFilename = trkFile.getOriginalFilename();
				log.debug(originalFilename);
				String renamedFilename = NadaumUtils.rename(originalFilename);
				File dest = new File(saveAudioDirectory, renamedFilename);
				trkFile.transferTo(dest);

				AlbumTrack attach = new AlbumTrack();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				trackList.add(attach);
			}
		}

		// 예외처리 필수
		for (int i = 0; i < imgFiles.length; i++) {
			MultipartFile imgFile = imgFiles[i];
			if (!imgFile.isEmpty()) {
				String originalFilename = imgFile.getOriginalFilename();
				log.debug(originalFilename);
				String renamedFilename = NadaumUtils.rename(originalFilename);
				File dest = new File(saveImgDirectory, renamedFilename);
				imgFile.transferTo(dest);

				AlbumImg attach = new AlbumImg();
				attach.setOriginalFilename(originalFilename);
				attach.setRenamedFilename(renamedFilename);
				imgList.add(attach);
			} else {
				// default Img
				AlbumImg attach = new AlbumImg();
				attach.setOriginalFilename(DEFAULT_IMG);
				imgList.add(attach);
			}
		}

		if (!trackList.isEmpty()) {
			album.setAlbumTracks(trackList);
			album.setAlbumImgs(imgList);
		}

		log.debug("album = {}", album);
		log.debug("trkfile={}", trkFiles[0].getOriginalFilename());

		int result = albumService.insertAlbum(album);
		String msg = "";
		model.clear();

		if (1 == result) {
			msg = "앨범 등록 성공!";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/audiobook/album/enroll/list";
		} else {
			msg = "앨범등록 실패 재시도 해주세요";
			redirectAttr.addFlashAttribute("msg", msg);
			return "/audiobook/album/enrollForm";
		}
	}

	@GetMapping("/album/update")
	public String albumUpdate(@AuthenticationPrincipal Member member,
								@RequestParam String code, ModelMap model) {

		// Album result = albumService.selectOneAlbumCollection(code);
		// 앨범 정보 불러오기 : 한번에 다불러오면 다시 객체를 생성해서 매핑해야되므로 따로 불러와서 바로 넘겨주는것이 나음.
		AlbumInfo oldAlbumInfo = albumService.selectOneAlbumInfo(code);
		List<AlbumTrack> oldTrackList = albumService.selectListAlbumTrack(code);
		List<AlbumImg> oldImgList = albumService.selectListAlbumImg(code);

		model.clear();
		model.addAttribute("oldAlbumInfo", oldAlbumInfo);
		model.addAttribute("oldTrackList", oldTrackList);
		model.addAttribute("oldImgList", oldImgList);
		return "/audiobook/album/updateForm";
	}
	
	@PostMapping("/album/update")
	public String albumUpdate(@AuthenticationPrincipal Member member,
			Album album,ModelMap model,
			@RequestParam(name = "imgFile") MultipartFile[] imgFiles,
			@RequestParam(name = "trkFile") MultipartFile[] trkFiles,
			@RequestParam(name = "trkOriginalFileName", defaultValue="") String[] trkOriginalFileNames,
			RedirectAttributes redirectAttr) {
		
		List<AlbumTrack> trackList = new ArrayList<>();
		List<AlbumImg> imgList = new ArrayList<>();
		String code=album.getCode();
		String saveAudioDirectory = application.getRealPath("/resources/upload/audiobook/mp3");
		String saveImgDirectory = application.getRealPath("/resources/upload/audiobook/img");
		
		int infoResult = albumService.updateAlbumInfo(album); 
		
		int imgDelResult=-1;
		int imgInsertResult=-1;
		//이미지 파일 변경 있으면 동작
		try {
			if(""!=imgFiles[0].getOriginalFilename()) {
				String imgFile0=imgFiles[0].getOriginalFilename();
				log.debug("imgFile0={}", imgFile0);
				//기존 삭제
				List<AlbumImg> oldImgList = albumService.selectListAlbumImg(code);
				oldImgList.stream()
						.map(x -> saveImgDirectory + x.getRenamedFilename())
						.peek(x -> log.debug("path={}", x))
						.map(File::new)
						.peek(x -> log.debug("file={}", x))
						.forEach(f -> f.delete());
				
				imgDelResult = albumService.deleteAllAlbumImgs(code);
				
				//새파일 등록
				for (int i = 0; i < imgFiles.length; i++) {
					MultipartFile imgFile = imgFiles[i];
					if (!imgFile.isEmpty()) {
						String originalFilename = imgFile.getOriginalFilename();
						log.debug(originalFilename);
						String renamedFilename = NadaumUtils.rename(originalFilename);
						File dest = new File(saveImgDirectory, renamedFilename);
						imgFile.transferTo(dest);

						AlbumImg attach = new AlbumImg();
						attach.setAlbumCode(code);
						attach.setOriginalFilename(originalFilename);
						attach.setRenamedFilename(renamedFilename);
						imgList.add(attach);
						log.debug("attach={}",attach);
					} else {
						// default Img
						AlbumImg attach = new AlbumImg();
						attach.setAlbumCode(code);
						attach.setOriginalFilename(DEFAULT_IMG);
						//attach.setRenamedFilename(DEFAULT_IMG);
						imgList.add(attach);
					}
				}
				log.debug("insertImgList={}",imgList);
				imgInsertResult= albumService.insertAlbumImg(imgList.get(0));
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		int trackDelResult=-1;
		
		//조회
		List<AlbumTrack> oldTrackList = albumService.selectListAlbumTrack(code);
	
		//트랙 파일 일부삭제한 경우 
		log.debug("oldTrackSize={}",oldTrackList.size());
		if(oldTrackList.size()!=trkOriginalFileNames.length && 0!=trkOriginalFileNames.length) {
			String trkOriginal0 = trkOriginalFileNames[0];
			log.debug("trkOriginal0={}", trkOriginal0);
			
			//비교
			List<String> trkOriginalList = Arrays.asList(trkOriginalFileNames);
			log.debug("trkOriginalList={}",trkOriginalList);
			List<AlbumTrack> delTrackList = oldTrackList.stream()
					.filter(x->!trkOriginalList.contains(x.getOriginalFilename()))
					.collect(Collectors.toList());
			log.debug("delTrackList={}",delTrackList);
			
			//기존삭제
			delTrackList.stream()
				.map(x -> AUDIO_PATH + x.getRenamedFilename())
				.peek(x -> log.debug("path={}", x))
				.map(File::new)
				.peek(x -> log.debug("file={}", x))
				.forEach(f -> f.delete());
			//DB삭제
			
			/*list 방식
			List<Integer> delList=delTrackList.stream().map(x->x.getNo()).collect(Collectors.toList());
			log.debug("delArrayLen={}",delList.size());
			for(int i=0;i<delList.size();i++) {
				trackDelResult =albumService.deleteAlbumTrack(delList.get(i).intValue());				
			}
			*/
			
			//array방식
			int[] delArray=delTrackList.stream().map(x->x.getNo()).mapToInt(i->i).toArray();
			if(0==delArray.length) {log.debug("{}","could not activate the transaction");}
			
			int temp= 0!=delArray[0]?delArray[0]:-1;
			log.debug("delArrayLen={},delArray={}",delArray.length,temp);
			trackDelResult =albumService.deleteAlbumTracks(delArray);
			log.debug("trackDelResult={}",trackDelResult);
			
	
		} else if(oldTrackList.size()==trkOriginalFileNames.length) {
			
		} else if(0==trkOriginalFileNames.length){
			//모두삭제한경우->code로삭제
			trackDelResult= albumService.deleteAllAlbumTracks(code);
			log.debug("trackDelResult={}",trackDelResult);
		}
		
		int trackInsertResult =-1;
		//첨부 트랙파일 있는경우
		log.debug("CheckNullOnTrkFiles={}",trkFiles!=null&&trkFiles.length!=0);
		try {
			if(null!=trkFiles&&0!=trkFiles.length) {
				String trkFile0=trkFiles[0].getOriginalFilename()=="" ? trkFiles[0].getOriginalFilename():"";
				log.debug("trkFile0={}", trkFile0);
				
				//새파일 등록
				for (int i = 0; i < trkFiles.length; i++) {
					MultipartFile trkFile = trkFiles[i];
					if (!trkFile.isEmpty()) {
						String originalFilename = trkFile.getOriginalFilename();
						log.debug(originalFilename);
						String renamedFilename = NadaumUtils.rename(originalFilename);
						File dest = new File(saveAudioDirectory, renamedFilename);
						trkFile.transferTo(dest);

						AlbumTrack attach = new AlbumTrack();
						attach.setAlbumCode(code);
						attach.setOriginalFilename(originalFilename);
						attach.setRenamedFilename(renamedFilename);
						trackInsertResult = albumService.insertAlbumTrack(attach);
						trackList.add(attach);
					}
				}
				log.debug("insertTrackList={}",trackList);
				//trackInsertResult= albumService.insertAlbumTracks(trackList); 배치방식(작동안됨)
			}
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String msg = "";
		
		model.clear();
		
		int imgResult=imgInsertResult+imgDelResult;
		int trackResult=trackInsertResult+trackDelResult;
		int result =trackInsertResult+trackDelResult+imgInsertResult+imgDelResult;
		
		//모두기본값 -1로 초기화
		//조합가능한경우
		//imgInsertResult+imgDelResult = -2, 0
		//trackInsertResult+trackDelResult= (trackDelResult==-1)?0,-2,(trackDelResult==1)? 0,2
		
		if (-4 == result || imgResult%2==0 ||trackResult%2==0) {
			msg = "앨범 수정 성공!";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/audiobook/album/enroll/list";
		} else {
			msg = "앨범수정 실패 재시도 해주세요";
			redirectAttr.addFlashAttribute("msg", msg);
			return "/audiobook/album/update?code="+code;
		}
		
		//return "redirect:/audiobook/album/enroll/list";
	}
	

	@PostMapping("/album/updateTest")
	public String albumUpdateTest(@AuthenticationPrincipal Member member,Album album, ModelMap model, 
			@RequestParam(name = "trkFile") MultipartFile[] trkFiles,
			@RequestParam(name = "imgFile") MultipartFile[] imgFiles, 
			@RequestParam(name = "trkOriginalFileName") String[] trkOriginalFileNames,
			@RequestParam(name = "imgOriginalFileName") String[] imgOriginalFileNames,
			@RequestParam(name = "trkRenamedFileName") String[] trkRenamedFileNames,
			@RequestParam(name = "imgRenamedFileName") String[] imgRenamedFileNames,
			RedirectAttributes redirectAttr)
			throws IllegalStateException, IOException {
		// 삭제전 이전리스트 목록
		AlbumInfo oldAlbumInfo = albumService.selectOneAlbumInfo(album.getCode());
		List<AlbumTrack> oldTrackList = albumService.selectListAlbumTrack(album.getCode());
		List<AlbumImg> oldImgList = albumService.selectListAlbumImg(album.getCode());

		log.debug("album={}",album.getCode());
		log.debug("trkFiles={}", trkFiles);
		//log.debug("trkOriginalFileNames={}",trkOriginalFileNames.toString());
		// String saveAudioDirectory
		// =application.getRealPath("/resources/upload/audiobook/mp3");
		// String saveImgDirectory
		// =application.getRealPath("/resources/upload/audiobook/img"); String code =
		// album.getCode();
		// AlbumInfo albumOriginInfo =albumService.selectOneAlbumInfo(code);
		// List<AlbumTrack> trackOriginList = albumService.selectListAlbumTrack(code);
		// List<AlbumImg> imgOriginList =albumService.selectListAlbumImg(code);

		String saveImgDirectory = IMG_PATH;
		String saveAudioDirectory = AUDIO_PATH;

		log.debug("saveDirectory={}", saveAudioDirectory);
		log.debug("track1={}", trkFiles[0].getOriginalFilename());
		log.debug("imgFiles={}", imgFiles[0].getOriginalFilename());

		List<String> oldTrackOriginNameList = oldTrackList.stream().map(x -> x.getOriginalFilename())
				.collect(Collectors.toList());
		List<String> oldImgOriginNameList = oldImgList.stream().map(x -> x.getOriginalFilename())
				.collect(Collectors.toList());
		List<String> oldTrackReNameList = oldTrackList.stream().map(x -> x.getRenamedFilename())
				.collect(Collectors.toList());
		List<String> oldImgReNameList = oldImgList.stream().map(x -> x.getRenamedFilename()).collect(Collectors.toList());

		// 새로입력된 파일
		List<AlbumTrack> newTrackList = new ArrayList<>();
		List<AlbumImg> newImgList = new ArrayList<>();
		List<String> delTrackRenamedList = new ArrayList<>();
		List<String> delTrackOriginList = new ArrayList<>();
		List<String> delImgRenamedList = new ArrayList<>();
		List<String> delImgOriginList = new ArrayList<>();
		
		int fileLen =trkOriginalFileNames.length>trkFiles.length?trkOriginalFileNames.length:trkFiles.length;
		log.debug("fileLen={}",fileLen);
		for (int i = 0; i < trkFiles.length; i++) {
			MultipartFile trkFile = trkFiles[i];
			String trkOriginalFileName = null==trkOriginalFileNames[i]? null:trkOriginalFileNames[i];
			String trkRenamedFileName = trkRenamedFileNames[i];
			log.debug("{}",trkOriginalFileName);
			if (!trkFile.isEmpty()) {
				String updateFilename = trkFile.getOriginalFilename();
				log.debug(updateFilename);
				 
				if (trkOriginalFileName!= updateFilename) {
					String renamedUpdateFilename = NadaumUtils.rename(updateFilename);
					File dest = new File(saveAudioDirectory, renamedUpdateFilename);
					trkFile.transferTo(dest);
	
					AlbumTrack attach = new AlbumTrack();
					attach.setOriginalFilename(updateFilename);
					attach.setRenamedFilename(renamedUpdateFilename);
					attach.setAlbumCode(album.getCode());
					
					newTrackList.add(attach);
					delTrackOriginList.add(trkOriginalFileName);
					delTrackRenamedList.add(trkRenamedFileName);
				} else if (oldTrackList.get(i).getOriginalFilename()==updateFilename 
						&& oldTrackList.get(i).getRenamedFilename()!=trkRenamedFileName){
					delTrackOriginList.add(trkOriginalFileName);
					delTrackRenamedList.add(trkRenamedFileName);
				} else {
					AlbumTrack attach = new AlbumTrack();
					attach.setOriginalFilename(oldTrackList.get(i).getOriginalFilename());
					attach.setRenamedFilename(oldTrackList.get(i).getRenamedFilename());
					attach.setAlbumCode(album.getCode());
					newTrackList.add(attach);
					log.debug("oldFromDB={},inputHidden={}",oldTrackList.get(i).getRenamedFilename(),trkRenamedFileName);
				}
			}
		}
		
		int imgLen =imgOriginalFileNames.length>imgFiles.length?imgOriginalFileNames.length:imgFiles.length;
		
		for (int i = 0; i < imgLen; i++) {
			MultipartFile imgFile = imgFiles[i];
			String imgOriginalFileName = imgOriginalFileNames[i];
			String imgRenamedFileName = imgRenamedFileNames[i];
			if (!imgFile.isEmpty()) {
				String updateFilename = imgFile.getOriginalFilename();
				log.debug(updateFilename);
				if (imgOriginalFileName != updateFilename) {
					String renamedUpdateFilename = NadaumUtils.rename(updateFilename);
					File dest = new File(saveImgDirectory, renamedUpdateFilename);
					imgFile.transferTo(dest);
					
					AlbumImg attach = new AlbumImg();
					attach.setOriginalFilename(updateFilename);
					attach.setRenamedFilename(renamedUpdateFilename);
					attach.setAlbumCode(album.getCode());
					newImgList.add(attach);
					
					delImgOriginList.add(imgOriginalFileName);
					delImgRenamedList.add(imgRenamedFileName);
				} else if(oldImgList.get(i).getOriginalFilename()==updateFilename 
						&& oldImgList.get(i).getRenamedFilename()!=imgRenamedFileName) {
					delImgOriginList.add(imgOriginalFileName);
					delImgRenamedList.add(imgRenamedFileName);
				} else {
					AlbumImg attach = new AlbumImg();
					attach.setOriginalFilename(oldImgList.get(i).getOriginalFilename());
					attach.setRenamedFilename(oldImgList.get(i).getRenamedFilename());
					attach.setAlbumCode(album.getCode());
					newImgList.add(attach);
					log.debug("oldFromDB={},inputHidden={}",oldImgList.get(i).getRenamedFilename(),imgRenamedFileName);
				}
			} else {
				AlbumImg attach = new AlbumImg();
				attach.setOriginalFilename(DEFAULT_IMG);
				newImgList.add(attach);
			}
		}
		
		log.debug("newImgList={}", newImgList);
		log.debug("newTrackList={}", newTrackList);
		log.debug("delImgOriginList={}", delImgOriginList);
		log.debug("delTrackOriginList={}", delTrackOriginList);
		log.debug("delImgRenamedList={}", delImgRenamedList);
		log.debug("delTrackRenamedList={}", delTrackRenamedList);

		//
		if (!newTrackList.isEmpty()) {
			album.setAlbumTracks(newTrackList);
			album.setAlbumImgs(newImgList);
		}
		List<AlbumTrack> newAlbumTrackList = new ArrayList<>();
		List<AlbumImg> newAlbumImgList = new ArrayList<>();
		
		int result = albumService.updateAlbumInfo(album); 
		int tResult = albumService.updateAlbumTrackList(newAlbumTrackList);
		int iResult = albumService.updateAlbumImgList(newAlbumImgList);
		
		String msg = "";
		model.clear();
		if(1==result&&1==tResult&&1==iResult) {
			delTrackRenamedList.stream().map(x -> AUDIO_PATH + x)
							//.peek(x -> log.debug("path={}", x))
							.map(File::new)
							//.peek(x -> log.debug("file={}", x))
							.forEach(f -> f.delete());

			delImgRenamedList.stream().map(x -> IMG_PATH + x)
							//.peek(x -> log.debug("path={}", x))
							.map(File::new)
							//.peek(x -> log.debug("file={}", x))
							.forEach(f -> f.delete());
			msg = "앨범 수정 성공!";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/audiobook/album/enroll/list";
		}  else {
			msg = "앨범수정 실패 재시도 해주세요";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/audiobook/album/update?code="+album.getCode();
		}

//		if (1 == result) {
//			File folder = new File(imgPath);
//			File[] imgFileList = folder.listFiles();
//			File folder2 = new File(audioPath);
//			File[] trackFileList = folder2.listFiles();
//
//			Stream.of(imgFileList).filter(x -> delImgs.contains(x.getName())).forEach(File::delete);
//			Stream.of(trackFileList).filter(x -> delTracks.contains(x.getName())).forEach(File::delete);
//
//			msg = "앨범 수정 성공!";
//			redirectAttr.addFlashAttribute("msg", msg);
//			return "redirect:/audiobook/album/enroll/list";
//		} else {
//			msg = "앨범수정 실패 재시도 해주세요";
//			redirectAttr.addFlashAttribute("msg", msg);
//			return "/audiobook/album/enrollForm";
//		}
		
	}

	@GetMapping("/album/delete")
	public String albumDelete(@RequestParam String code, ModelMap modelMap) {
		modelMap.addAttribute("code", code);
		return "/audiobook/album/deleteForm";
	}

	/*
	 * DB삭제요청을 먼저하면 삭제할 정보가 날아감.
	 */
	@PostMapping("/album/delete")
	public String albumDeleteTest(
			// @RequestParam Member member,
			@RequestParam String code, ModelMap modelMap) {
		// 권한 검사
//		if(!member.getMemberRole().contains("ADMIN")) {
//			return "redirect:/audiobook/albumEnrollList";
//		}

		AlbumInfo album = albumService.selectOneAlbumInfo(code);
		if (null == album) {
			modelMap.addAttribute("msg", "잘못된 요청입니다.");
			return "redirect:/audiobook/search/list";
		}
		// 단일 for문 방식
		List<AlbumTrack> trackOriginList = albumService.selectListAlbumTrack(code);
		List<AlbumImg> imgOriginList = albumService.selectListAlbumImg(code);
		if( 0!=trackOriginList.size() && 0!=imgOriginList.size()) {
			log.debug("trackOriginList={},imgORiginList={}", trackOriginList.get(0), imgOriginList.get(0));
		}

		String audioPath = application.getRealPath("/resources/upload/audiobook/mp3");
		String imgPath = application.getRealPath("/resources/upload/audiobook/img");
		log.debug("audioPath={}, imgPath={}", audioPath, imgPath);

		List<String> trackRenameList = trackOriginList.stream().map(x -> x.getRenamedFilename())
				.collect(Collectors.toList());
		List<String> imgRenameList = imgOriginList.stream().map(x -> x.getRenamedFilename())
				.collect(Collectors.toList());
		log.debug("tRenameList={}, iRenameList={}", trackRenameList.toString(), imgRenameList.toString());

		/*
		 * Old Code
		 * 
		 * for(int i=0;i<trackOriginList.size();i++) { String delFile =
		 * AUDIO_PATH+trackOriginList.get(i).getRenamedFilename();
		 * System.out.println(delFile); File f = new File(delFile); f.delete();
		 * log.debug("{}파일이 삭제되었습니다.",trackOriginList.get(i).getRenamedFilename()); }
		 * 
		 * for(int i=0;i<imgOriginList.size();i++) { String delImg =
		 * IMG_PATH+imgOriginList.get(i).getRenamedFilename(); File f= new File(delImg);
		 * f.delete();
		 * log.debug("{}파일이 삭제되었습니다.",imgOriginList.get(i).getRenamedFilename()); }
		 */

		/* Stream방식 */
		HashSet<String> trackSet = (HashSet<String>) trackOriginList.stream().map(x -> x.getRenamedFilename())
				.collect(Collectors.toSet());
		HashSet<String> imgSet = (HashSet<String>) imgOriginList.stream().map(x -> x.getRenamedFilename())
				.collect(Collectors.toSet());

		log.debug("trackSet={}", trackSet.toString());
		log.debug("imgSet={}", imgSet.toString());

		trackOriginList.stream()
				.map(x -> AUDIO_PATH + x.getRenamedFilename())
				.peek(x -> log.debug("path={}", x))
				.map(File::new)
				.peek(x -> log.debug("file={}", x)).forEach(f -> f.delete());

		imgOriginList.stream().map(x -> IMG_PATH + x.getRenamedFilename()).peek(x -> log.debug("path={}", x))
				.map(File::new).peek(x -> log.debug("file={}", x)).forEach(f -> f.delete());

		File imgFolder = new File(imgPath);
		File[] imgFileList = imgFolder.listFiles();
		log.debug("imgFileList={}", imgFileList);
		File trackFolder = new File(audioPath);
		File[] trackFileList = trackFolder.listFiles();
		/*
		 * for(int i=0; i<trackFileList.length;i++) { String s
		 * =trackFileList[i].getName(); log.debug("s={}",s); }
		 */

		log.debug("trackFileList={}", trackFileList);
		// Set<File> tfSet = new HashSet<>(Arrays.asList(trackFileList));
		// Set<File> ifSet = new HashSet<>(Arrays.asList(imgFileList));
		Stream.of(trackFileList).filter(x -> trackSet.contains(x.getName()))
				// .peek(System.out::println) 속도느려짐 deprecated
				.forEach(File::delete);
		Stream.of(imgFileList).filter(x -> imgSet.contains(x.getName()))
				// .peek(System.out::println) 속도느려짐 deprecated
				.forEach(File::delete);
		log.debug("imgFileList={}", imgFileList);
		log.debug("trackFileList={}", trackFileList);

		String msg = "";
		int result = albumService.deleteAlbum(code);

		if (1 == result) {
			msg = "삭제성공";
		} else {
			msg = "삭제실패";
		}
		modelMap.addAttribute("msg", msg);
		return "redirect:/audiobook/album/enroll/list";
	}

	/*
	 * Sample
	 */
	@GetMapping("/detail/sample/collections")
	public String albumSamplePage(
			// @RequestParam Album album,
			Model model) {
		// log.debug("albumSearch={},{}",creator, albumNo);
		// Album album = albumService.selectOneAlbum(creator,albumNo);
		// model.addAttribute("album",album);
		return "/audiobook/sample/detailCollections";
	}

	@GetMapping("/detail/sample/timestamp")
	public String albumSamplePage2(
			// @RequestParam Album album,
			Model model) {
		// log.debug("albumSearch={},{}",creator, albumNo);
		// Album album = albumService.selectOneAlbum(creator,albumNo);
		// model.addAttribute("album",album);
		return "/audiobook/sample/albumDetailTimeStamp";
	}

	/*
	 * (미완) SPA audiobook player
	 */
	@GetMapping("/sample/playList")
	public ResponseEntity<Map<String, Object>> albumAudioListAjax() {
		Map<String, Object> map = new HashMap<>();
		map.put("icon", "iconImage");
		map.put("title", "Recital");
		map.put("file", "https://docs.google.com/uc?export=open&id=1-LennS20yQSBr0Ualiu_12J1HjmtI5ef");
		return ResponseEntity.ok(map);
	}

	/**
	 * Date Form binder
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			PropertyEditor editor = new CustomDateEditor(sdf, true);
			binder.registerCustomEditor(Date.class, editor);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			throw e;
		}
	}

	/**
	 * 페이지바
	 * 
	 * @param cPage        : page that client request
	 * @param limit        : limit for one page
	 * @param totalContent : number of total rows
	 * @param url          : url for mapping page bar button
	 * @return
	 */
	public static String getPageBar(int cPage, int limit, int totalContent, String url) {

		StringBuilder pagebar = new StringBuilder();
		url = url + "?cPage="; // pageNo 추가전 상태

		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / limit);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;

		pagebar.append("<nav>\r\n" + "			  <ul class=\"pagination justify-content-center pagination-sm\">\r\n"
				+ "			    ");
		// [이전]
		if (pageNo == 1) {
			// 이전 영역 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "			      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1)
					+ ");\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Previous</span>\r\n" + "			      </a>\r\n"
					+ "			    </li>");
		} else {
			// 이전 영역 활성화
			pagebar.append(
					"<li class=\"page-item\">\r\n" + "			      <a class=\"page-link\" href=\"javascript:paging("
							+ (pageNo - 1) + ");\" aria-label=\"Previous\">\r\n"
							+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
							+ "			        <span class=\"sr-only\">Previous</span>\r\n"
							+ "			      </a>\r\n" + "			    </li>");
		}

		// pageNo
		while (pageNo <= pageEnd) {
			if (pageNo == cPage) {
				// 현재페이지
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"javascript:paging("
						+ pageNo + ")\">" + pageNo + "</a></li>\r\n");
			} else {
				// 현재페이지가 아닌 경우
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo
						+ ")\">" + pageNo + "</a></li>\r\n");
			}
			pageNo++;
		}

		// [다음]
		if (pageNo > totalPage) {
			// 다음 페이지 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "			      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Next</span>\r\n" + "			      </a>\r\n"
					+ "			    </li>\r\n" + "			  ");
		} else {
			// 다음 페이지 활성화
			pagebar.append(
					"<li class=\"page-item\">\r\n" + "			      <a class=\"page-link\" href=\"javascript:paging("
							+ pageNo + ")\" aria-label=\"Next\">\r\n"
							+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
							+ "			        <span class=\"sr-only\">Next</span>\r\n" + "			      </a>\r\n"
							+ "			    </li>\r\n" + "			  ");
		}

		pagebar.append("			  </ul>\r\n" + "			</nav>\r\n" + "<script>"
				+ "const paging = (pageNo) => { location.href = `" + url + "${pageNo}`;  };" + "</script>");
		return pagebar.toString();
	}

}