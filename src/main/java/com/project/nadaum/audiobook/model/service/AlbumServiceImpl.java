package com.project.nadaum.audiobook.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.nadaum.audiobook.model.dao.AlbumDao;
import com.project.nadaum.audiobook.model.vo.Album;
import com.project.nadaum.audiobook.model.vo.AlbumComment;
import com.project.nadaum.audiobook.model.vo.AlbumInfo;
import com.project.nadaum.audiobook.model.vo.AlbumImg;
import com.project.nadaum.audiobook.model.vo.AlbumTrack;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor = Exception.class)
public class AlbumServiceImpl implements AlbumService {

	@Autowired
	private AlbumDao albumDao;

	// 페이징
	@Override
	public int selectTotalContent() {
		return albumDao.selectTotalContent();
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfo(Map<String, Object> param) {
		return albumDao.selectListAlbumInfo(param);
	}

	// 앨범

	@Override
	public int insertAlbum(Album album) {
		int result = albumDao.insertAlbumInfo(album);

		log.debug("albumNo={}", album.getClass());

		List<AlbumTrack> albumTracks = album.getAlbumTracks();

		if (albumTracks != null) {
			for (AlbumTrack trkAttach : albumTracks) {
				trkAttach.setAlbumCode(album.getCode());
				result = insertAlbumTrack(trkAttach);
			}
		}
		// result = insertAlbumTracks(albumTracks);

		List<AlbumImg> albumImgs = album.getAlbumImgs();
		if (albumImgs != null) {
			for (AlbumImg imgAttach : albumImgs) {
				imgAttach.setAlbumCode(album.getCode());
				result = insertAlbumImg(imgAttach);
			}
		}
		// result = insertAlbumImgs(albumImgs);

		return result;
	}

	@Override
	public int deleteAlbum(String code) {
		return albumDao.deleteAlbum(code);
	}

	@Override
	public int updateAlbum(Album album) {
		int result1 = albumDao.updateAlbumInfo((AlbumInfo) album);
		int result2 = albumDao.updateAlbumImgs(album.getAlbumImgs());
		int result3 = albumDao.updateAlbumTracks(album.getAlbumTracks());
		if(1==result1&&1==result2&&1==result3) 
			return 1;
		else { 
			//rollback 처리 필요 
			return 0;
		}
	}

	@Override
	public int updateAlbumInfo(AlbumInfo albumInfo) {
		return albumDao.updateAlbumInfo(albumInfo);
	}

	@Override
	public Album selectOneAlbumCollection(String code) {
		return albumDao.selectOneAlbumCollection(code);
	}

	@Override
	public AlbumInfo selectOneAlbumInfo(String code) {
		AlbumInfo albumInfo = albumDao.selectOneAlbumInfo(code);
		return albumInfo;
	}

	@Override
	public List<AlbumInfo> selectListAlbumInfo() {
		return albumDao.selectListAlbumInfo();
	}

	// 트랙

	@Override
	public int insertAlbumTrack(AlbumTrack altrk) {
		return albumDao.insertAlbumTrack(altrk);
	}

	@Override
	public int insertAlbumTracks(List<AlbumTrack> list) {
		return albumDao.insertAlbumTracks(list);
	}

	@Override
	public int updateAlbumTrack(AlbumTrack altrk) {
		return albumDao.updateAlbumTrack(altrk);
	}

	@Override
	public int deleteAlbumTracks(int[] delArray) {
		return albumDao.deleteAlbumTracks(delArray);
	}
	
	@Override
	public int deleteAllAlbumTracks(String code) {
		return albumDao.deleteAllAlbumTracks(code);
	}

	@Override
	public List<AlbumTrack> selectListAlbumTrack(String code) {
		return albumDao.selectListAlbumTrack(code);
	}

	@Override
	public AlbumTrack selectOneAlbumTrack(Map<String, Object> param) {
		return albumDao.selectOneAlbumTrack(param);
	}

	// 앨범이미지
	@Override
	public int insertAlbumImg(AlbumImg imgAttach) {
		return albumDao.insertAlbumImg(imgAttach);
	}

	@Override
	public int insertAlbumImgs(List<AlbumImg> imgList) {
		return albumDao.insertAlbumImgs(imgList);
	}

	@Override
	public int updateAlbumImg(AlbumImg imgAttach) {
		return albumDao.updateAlbumImg(imgAttach);
	}

	@Override
	public int deleteAlbumImg(AlbumImg imgAttach) {
		return albumDao.deleteAlbumImg(imgAttach);
	}
	
	@Override
	public int deleteAllAlbumImgs(String code) {
		return albumDao.deleteAllAlbumImgs(code);
	}

	@Override
	public AlbumImg selectOneAlbumImg(AlbumImg imgAttach) {
		return albumDao.selectOneAlbumImg(imgAttach);
	}

	@Override
	public List<AlbumImg> selectListAlbumImg(String code) {
		return albumDao.selectListAlbumImg(code);
	}

	// 코멘트
	@Override
	public int insertAlbumComment(AlbumComment comment) {
		return albumDao.insertAlbumComment(comment);
	}

	@Override
	public int updateAlbumComment(AlbumComment comment) {
		return albumDao.updateAlbumComment(comment);
	}

	@Override
	public int deleteAlbumComment(AlbumComment comment) {
		return albumDao.deleteAlbumComment(comment);
	}

	@Override
	public List<AlbumComment> selectListAlbumComment(String code) {
		return albumDao.selectListAlbumComment(code);
	}

	@Override
	public AlbumComment selectOneAlbumComment(AlbumComment comment) {
		return albumDao.selectOneAlbumComment(comment);
	}

	@Override
	public List<AlbumComment> selectListAlbumComment(Map<String, Object> param) {
		return albumDao.selectListAlbumComment(param);
	}

	// 검색
	@Override
	public List<Map<String, Object>> selectListAlbumInfoByWord(Map<String, Object> param) {
		return albumDao.selectListAlbumInfoByWord(param);
	}

	@Override
	public List<Map<String, Object>> selectListAlbum(Map<String, Object> param) {
		return albumDao.selectListAlbum(param);
	}

	/*
	 * @Override public List<Map<String, Object>>
	 * selectListAlbumInfoByType(Map<String, Object> param) { return
	 * albumDao.selectListAlbumInfoByType(param); }
	 */

	@Override
	public List<Map<String, Object>> selectListAlbumInfoByKind(String kind) {
		return albumDao.selectListAlbumInfoByKind(kind);
	}

	@Override
	public List<Map<String, Object>> selectListAlbumInfoByProvider(String provider) {
		return albumDao.selectListAlbumInfoByProvider(provider);
	}

	@Override
	public List<Map<String, Object>> selectListAlbumInfoByCreator(String creator) {
		return albumDao.selectListAlbumInfoByCreator(creator);
	}

	@Override
	public List<Map<String, Object>> selectListAlbumInfoByKindMain(String kind) {
		return albumDao.selectListAlbumInfoByKindMain(kind);
	}

	@Override
	public List<Map<String, Object>> selectListAlbumInfoRecentMain() {
		return albumDao.selectListAlbumInfoRecentMain();
	}

	@Override
	public int updateAlbumTrackList(List<AlbumTrack> newAlbumTrackList) {
		
		int result1=0;
		int result2=0;
		try {
			if(null==newAlbumTrackList.get(0).getAlbumCode()) 
				return 1;
			result1 = albumDao.deleteAlbumTrackByCode(newAlbumTrackList.get(0).getAlbumCode());
			result2 = albumDao.insertAlbumTracks(newAlbumTrackList);
		} catch (Exception e) {
			log.debug("error={}","오류");
		}
		return 1==result1&&1==result2?1:0;
	}

	@Override
	public int updateAlbumImgList(List<AlbumImg> newAlbumImgList) {
		int result1=0;
		int result2=0;
		try {
			if(null==newAlbumImgList.get(0).getAlbumCode()) 
				return 1;
			result1 = albumDao.deleteAlbumImgByCode(newAlbumImgList.get(0).getAlbumCode());
			result2 = albumDao.insertAlbumImgs(newAlbumImgList);
		} catch (Exception e) {
			log.debug("error={}","오류");
		}
		return 1==result1&&1==result2?1:0;
	}

	@Override
	public AlbumInfo selectWidgetAlbumInfo(Map<String,Object> map) {
		return albumDao.selectWidgetAlbumInfo(map);
	}

	

	

}
