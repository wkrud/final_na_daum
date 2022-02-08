package com.project.nadaum.audiobook.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.Set;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
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
	public static final String DEFAULT_IMG= "default.png";
	public static final String AUDIO_PATH = "C:\\Workspaces\\finalProject\\na_daum\\src\\main\\webapp\\resources\\upload\\audiobook\\mp3\\";
	public static final String IMG_PATH = "C:\\Workspaces\\finalProject\\na_daum\\src\\main\\webapp\\resources\\upload\\audiobook\\img\\";
	
	
	@GetMapping("/")
	@RequestMapping
	public String audiobookMain(Model model) {
		
		//메인화면 (중복코드 제거할것)
		List<Map<String,Object>> recentList = albumService.selectListAlbumInfoRecentMain();
		List<Map<String,Object>> classicList = albumService.selectListAlbumInfoByKindMain("Classic");
		List<Map<String,Object>> jazzList = albumService.selectListAlbumInfoByKindMain("Jazz");
		List<Map<String,Object>> asmrList = albumService.selectListAlbumInfoByKindMain("ASMR");
		model.addAttribute("recentList",recentList);
		model.addAttribute("classicList",classicList);
		model.addAttribute("jazzList",jazzList);
		model.addAttribute("asmrList",asmrList);
		return "audiobook/main";
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

	@GetMapping("/search/list/select")
	public String albumSearch(@RequestParam String searchType, 
							  @RequestParam String searchKeyword,
							  ModelMap model) {
		Map<String,Object> param =new HashMap<>();
		param.put("searchType",searchType);
		param.put("searchKeyword", searchKeyword);
		log.debug("searchType={}, searchKeyword={}",searchType,searchKeyword);
		List<Map<String, Object>> selectList = new ArrayList<>();
		if(searchType == null || searchKeyword == null) {
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
		model.addAttribute("selectList",selectList);
		log.debug("selectList={}",selectList);
		return "/audiobook/search/selectList";
	}

	/*
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


	/* Album (Old Code 모두 전환예정)*/

	@GetMapping("/album/enrollList")
	public String albumEnrollList(Model model) {
		return "/audiobook/albumEnrollList";
	}

	@GetMapping("/album/enroll")
	public String albumForm() {

		// 관리자 여부 확인 or aop, filter처리
		// if(ADMIN!=member.role) {}
		// else(){}
		return "/audiobook/albumForm";
	}
	
	@GetMapping("/album/enroll/list")
	public String albumList(@RequestParam(defaultValue = "1") int cPage, HttpServletRequest request, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		Map<String, Object> param = new HashMap<>();
		param.put("offset", offset);
		param.put("limit", limit);

		List<AlbumInfo> list = albumService.selectListAlbumInfo(param);
		log.debug("list ={}", list);

		int totalContent = albumService.selectTotalContent();
		String url = request.getRequestURI();
		String pagebar = NadaumUtils.getPagebar(offset, limit, totalContent, url,"");

		model.addAttribute("list", list);
		model.addAttribute("pagebar", pagebar);
		return "/audiobook/albumEnrollList";
	}

	@PostMapping("/album/enroll")
	public String albumEnroll(Album album, @RequestParam(name = "trkFile") MultipartFile[] trkFiles,
			@RequestParam(name = "imgFile") MultipartFile[] imgFiles, ModelMap model, RedirectAttributes redirectAttr)
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
				// 디폴트 이미지 설정
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
			return "redirect:/audiobook/album/enrollList";
		} else {
			msg = "앨범등록 실패 재시도 해주세요";
			redirectAttr.addFlashAttribute("msg", msg);
			return "/audiobook/albumForm";
		}
	}

	@GetMapping("/album/update")
	public String albumUpdate(@RequestParam String code, ModelMap model) {
		// 관리자 권한 확인 or Filter등록

		/*
		 * 앨범 정보 불러오기 : 한번에 다불러오면 다시 객체를 생성해서 매핑해야되므로 따로 불러와서 바로 넘겨주는것이 나음.
		 */
		
		// Album result = albumService.selectOneAlbumCollection(code);

		AlbumInfo albumInfo = albumService.selectOneAlbumInfo(code);
		List<AlbumTrack> tracksList = albumService.selectListAlbumTrack(code);
		List<AlbumImg> imgsList = albumService.selectListAlbumImg(code);
		model.clear();

		model.addAttribute("albumInfo", albumInfo);
		model.addAttribute("albumTrackList", tracksList);
		model.addAttribute("albumImgList", imgsList);
		return "/audiobook/album/updateForm";
	}

	@PostMapping("/album/update")
	public String albumUpdate(Album album, @RequestParam(name = "trkFile") MultipartFile[] trkFiles,
			@RequestParam(name = "imgFile") MultipartFile[] imgFiles, ModelMap model, RedirectAttributes redirectAttr)
			throws IllegalStateException, IOException {

		String saveAudioDirectory = application.getRealPath("/resources/upload/audiobook/mp3");
		String saveImgDirectory = application.getRealPath("/resources/upload/audiobook/img");
		log.debug("saveDirectory={}", saveAudioDirectory);
		log.debug("track1={}", trkFiles[0].getOriginalFilename());
		log.debug("imgFiles={}", imgFiles[0].getOriginalFilename());

		// 삭제전 이전리스트 목록
		String code = album.getCode();
		AlbumInfo albumOriginInfo = albumService.selectOneAlbumInfo(code);
		List<AlbumTrack> trackOriginList = albumService.selectListAlbumTrack(code);
		List<AlbumImg> imgOriginList = albumService.selectListAlbumImg(code);
		
		List<String> trackNameList = trackOriginList.stream()
									.map(x -> x.getOriginalFilename())
									.collect(Collectors.toList());
		List<String> imgNameList = imgOriginList.stream()
									.map(x -> x.getOriginalFilename())
									.collect(Collectors.toList());

		// 새로입력
		List<AlbumTrack> trackList = new ArrayList<>();
		List<AlbumImg> imgList = new ArrayList<>();

		for (int i = 0; i < trkFiles.length; i++) {
			MultipartFile trkFile = trkFiles[i];
			if (!trkFile.isEmpty()) {
				String originalFilename = trkFile.getOriginalFilename();
				log.debug(originalFilename);

				if (!trackNameList.contains(originalFilename)) {
					String renamedFilename = NadaumUtils.rename(originalFilename);
					File dest = new File(saveAudioDirectory, renamedFilename);
					trkFile.transferTo(dest);

					AlbumTrack attach = new AlbumTrack();
					attach.setOriginalFilename(originalFilename);
					attach.setRenamedFilename(renamedFilename);
					trackList.add(attach);
				}
			}
		}
		
		for (int i = 0; i < imgFiles.length; i++) {
			MultipartFile imgFile = imgFiles[i];
			if (!imgFile.isEmpty()) {
				String originalFilename = imgFile.getOriginalFilename();
				log.debug(originalFilename);

				if (!imgNameList.contains(originalFilename)) {
					String renamedFilename = NadaumUtils.rename(originalFilename);
					File dest = new File(saveImgDirectory, renamedFilename);
					imgFile.transferTo(dest);

					AlbumImg attach = new AlbumImg();
					attach.setOriginalFilename(originalFilename);
					attach.setRenamedFilename(renamedFilename);
					imgList.add(attach);
				}
			} else {
				AlbumImg attach = new AlbumImg();
				attach.setOriginalFilename(DEFAULT_IMG);
				attach.setRenamedFilename(DEFAULT_IMG);
				imgList.add(attach);
			}
		}

		if (!trackList.isEmpty()) {
			album.setAlbumTracks(trackList);
			album.setAlbumImgs(imgList);
		}

		log.debug("album = {}", album);
		log.debug("trkfile={}", trkFiles[0].getOriginalFilename());
		log.debug("trkfile={}", trkFiles[1].getOriginalFilename());

		int result = albumService.updateAlbum(album);
		String msg = "";
		model.clear();
		//
		if (1 == result) {
			
			trackNameList.removeAll(trackList.stream().map(x->x.getOriginalFilename()).collect(Collectors.toList()));
			imgNameList.removeAll(imgList.stream().map(x->x.getOriginalFilename()).collect(Collectors.toList()));
			log.debug("trackNameList={}",trackNameList);
			log.debug("imgNameList={}",imgNameList);
			
			List<String> delTracks = trackOriginList.stream()
								.filter(x->trackNameList.contains(x.getOriginalFilename()))
								.map(AlbumTrack::getRenamedFilename)
								.collect(Collectors.toList());
			List<String> delImgs = imgOriginList.stream()
								.filter(x->imgNameList.contains(x.getOriginalFilename()))
								.map(AlbumImg::getRenamedFilename)
								.collect(Collectors.toList());
			
			String audioPath = saveAudioDirectory;
			String imgPath = saveImgDirectory;
			
			File folder = new File(imgPath);
			File[] imgFileList =  folder.listFiles();
			File folder2 = new File(audioPath);
			File[] trackFileList = folder2.listFiles();
			
			Stream.of(imgFileList).filter(x->delImgs.contains(x.getName())).forEach(File::delete);
			Stream.of(trackFileList).filter(x->delTracks.contains(x.getName())).forEach(File::delete);
			
			msg = "앨범 수정 성공!";
			redirectAttr.addFlashAttribute("msg", msg);
			return "redirect:/audiobook/album/enroll/list";
		} else {
			msg = "앨범수정 실패 재시도 해주세요";
			redirectAttr.addFlashAttribute("msg", msg);
			return "/audiobook/albumForm";
		}
	}

	@GetMapping("/album/delete")
	public String albumDelete(@RequestParam String code, ModelMap modelMap) {
		modelMap.addAttribute("code",code);
		return "/audiobook/album/deleteForm";
	}

	/*
	 * DB삭제요청을 먼저하면 삭제할 정보가 날아감.
	 */
	@PostMapping("/album/delete")
	public String albumDeleteTest(
			//@RequestParam Member member,
			@RequestParam String code, ModelMap modelMap) {
		// 권한 검사
//		if(!member.getMemberRole().contains("ADMIN")) {
//			return "redirect:/audiobook/albumEnrollList";
//		}
		
		
		AlbumInfo album = albumService.selectOneAlbumInfo(code);
		if(null==album) {
			modelMap.addAttribute("msg","잘못된 요청입니다.");
			return "redirect:/audiobook/search/list";
		}
		// 단일 for문 방식
		List<AlbumTrack> trackOriginList = albumService.selectListAlbumTrack(code);
		List<AlbumImg> imgOriginList = albumService.selectListAlbumImg(code);
		log.debug("trackOriginList={},imgORiginList={}",trackOriginList.get(0),imgOriginList.get(0));
		
		String audioPath = application.getRealPath("/resources/upload/audiobook/mp3");
		String imgPath = application.getRealPath("/resources/upload/audiobook/img");
		log.debug("audioPath={}, imgPath={}",audioPath,imgPath);
		
		List<String> trackRenameList = trackOriginList
										.stream()
										.map(x->x.getRenamedFilename())
										.collect(Collectors.toList());
		List<String> imgRenameList= imgOriginList
										.stream()
										.map(x->x.getRenamedFilename())
										.collect(Collectors.toList());
		log.debug("tRenameList={}, iRenameList={}",trackRenameList.toString(),imgRenameList.toString());
		
		/*
		 * Old Code 
		 * for(int i=0;i<trackOriginList.size();i++) { 
		 * String delFile = AUDIO_PATH+trackOriginList.get(i).getRenamedFilename();
		 * System.out.println(delFile); 
		 * File f = new File(delFile); 
		 * f.delete();
		 * log.debug("{}파일이 삭제되었습니다.",trackOriginList.get(i).getRenamedFilename()); }
		 * 
		 * for(int i=0;i<imgOriginList.size();i++) { 
		 * String delImg = IMG_PATH+imgOriginList.get(i).getRenamedFilename(); 
		 * File f= new File(delImg);
		 * f.delete();
		 * log.debug("{}파일이 삭제되었습니다.",imgOriginList.get(i).getRenamedFilename()); }
		 */
		
		/*Stream방식*/
		HashSet<String> trackSet = (HashSet<String>) trackOriginList.stream().map(x->x.getRenamedFilename()).collect(Collectors.toSet());
		HashSet<String> imgSet = (HashSet<String>) imgOriginList.stream().map(x->x.getRenamedFilename()).collect(Collectors.toSet());
		
		log.debug("trackSet={}",trackSet.toString());
		log.debug("imgSet={}",imgSet.toString());
		
		trackOriginList.stream()
						.map(x->AUDIO_PATH+x.getRenamedFilename())
						.peek(x->log.debug("path={}",x))
						.map(File::new)
						.peek(x->log.debug("file={}",x))
						.forEach(f->f.delete());
		
		imgOriginList.stream()
					.map(x->IMG_PATH+x.getRenamedFilename())
					.peek(x->log.debug("path={}",x))
					.map(File::new)
					.peek(x->log.debug("file={}",x))
					.forEach(f->f.delete());

		
		  File imgFolder = new File(imgPath); 
		  File[] imgFileList =imgFolder.listFiles(); 
		  log.debug("imgFileList={}",imgFileList); 
		  File trackFolder = new File(audioPath); 
		  File[] trackFileList = trackFolder.listFiles();
		/*
		 * for(int i=0; i<trackFileList.length;i++) { String s
		 * =trackFileList[i].getName(); log.debug("s={}",s); }
		 */
		 
		
		log.debug("trackFileList={}",trackFileList);
		//Set<File> tfSet = new HashSet<>(Arrays.asList(trackFileList)); 
		//Set<File> ifSet = new HashSet<>(Arrays.asList(imgFileList));
		Stream.of(trackFileList)
			.filter(x->trackSet.contains(x.getName()))
			//.peek(System.out::println)
			.forEach(File::delete);
		Stream.of(imgFileList)
			.filter(x->imgSet.contains(x.getName()))
			//.peek(System.out::println)
			.forEach(File::delete);
		log.debug("imgFileList={}",imgFileList);
		log.debug("trackFileList={}",trackFileList);
		
		String msg = "";
		int result = albumService.deleteAlbum(code);
		
		if (1 == result) {
			msg = "삭제성공";
		} else {
			msg = "삭제실패";
		}
		modelMap.addAttribute("msg", msg);
		return "redirect:/audiobook/album/enrollList";
	}

	/*
	 * sample
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
	@GetMapping("/album/sample/ajax")
	public ResponseEntity albumAudioListAjax() {

		return ResponseEntity.ok().build();
	}

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

}