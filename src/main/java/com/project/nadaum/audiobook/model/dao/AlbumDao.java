package com.project.nadaum.audiobook.model.dao;

import java.util.List;
import java.util.Map;

import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;

public interface AlbumDao {

	
	//페이징
	int selectTotalContent();
	
	List<AlbumInfo> selectListAlbumInfo(Map<String, Object> param);

	
	// 앨범 정보
	//int insertAlbum(Album album);
	
	int insertAlbumInfo(AlbumInfo albumInfo);

	int updateAlbumInfo(AlbumInfo albumInfo);

	int deleteAlbum(String code);	
	
	AlbumInfo selectWidgetAlbumInfo(Map<String,Object> map);
	
	AlbumInfo selectOneAlbumInfo(String code);

	Album selectOneAlbumCollection(String code);
	

	List<AlbumInfo> selectListAlbumInfo();

	/*
	 * 트랙 
	 */
	int insertAlbumTrack(AlbumTrack altrk);
	
	int insertAlbumTracks(List<AlbumTrack> altrk);

	int updateAlbumTrack(AlbumTrack altrk);
	
	int updateAlbumTracks(List<AlbumTrack> list);
	
	int updateAlbumTrackList(List<AlbumTrack> newAlbumTrackList);

	int deleteAlbumTracks(int[] delArray);
	
	int deleteAlbumTrack(int no);
	
	int deleteAllAlbumTracks(String code);

	AlbumTrack selectOneAlbumTrack(Map<String, Object> param);

	List<AlbumTrack> selectListAlbumTrack(String code);

	// 앨범 이미지

	int insertAlbumImg(AlbumImg imgAttach);
	
	int insertAlbumImgs(List<AlbumImg> imgList);
	
	int updateAlbumImg(AlbumImg imgAttach);

	int updateAlbumImgs(List<AlbumImg> imgAttach);
	
	int updateAlbumImgList(List<AlbumImg> newAlbumImgList);

	int deleteAlbumImg(AlbumImg imgAttach);
	
	int deleteAllAlbumImgs(String code);
	
	int deleteAlbumImgByCode(String albumCode);

	int deleteAlbumTrackByCode(String albumCode);

	AlbumImg selectOneAlbumImg(AlbumImg imgAttach);
	
	List<AlbumImg> selectListAlbumImg(String code);

	// 댓글

	int insertAlbumComment(AlbumComment comment);

	int updateAlbumComment(AlbumComment comment);

	int deleteAlbumComment(AlbumComment comment);

	AlbumComment selectOneAlbumComment(AlbumComment comment);

	List<AlbumComment> selectListAlbumComment(String code);

	List<AlbumComment> selectListAlbumComment(Map<String, Object> param);

	// 검색

	List<Map<String, Object>> selectListAlbumInfoByWord(Map<String,Object> param);

	//List<AlbumInfo> selectListAlbumInfoByType(Map<String, Object> param);

	List<Map<String,Object>> selectListAlbumInfoByKind(String kind);

	List<Map<String,Object>> selectListAlbumInfoByProvider(String provider);

	List<Map<String,Object>> selectListAlbumInfoByCreator(String creator);

	List<Map<String,Object>> selectListAlbum(Map<String, Object> param);

	List<Map<String, Object>> selectListAlbumInfoRecentMain();

	List<Map<String, Object>> selectListAlbumInfoByKindMain(String kind);

	


}
