package com.project.nadaum.culture.scrap.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.nadaum.board.model.vo.Likes;
import com.project.nadaum.culture.scrap.model.dao.ScrapDao;
import com.project.nadaum.culture.scrap.model.vo.Scrap;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScrapServiceImpl implements ScrapService {

		@Autowired
		private ScrapDao scrapDao;

		@Override
		public List<Scrap> selectScrapList(Map<String, Object> param) {
			return scrapDao.selectScrapList(param);
		}

		@Override
		public int selectTotalContent() {
			return scrapDao.selectTotalContent();
		}
}
