package com.project.nadaum.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.extern.slf4j.Slf4j;

public class NadaumUtils {
	
	public static String rename(String originalFilename) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");
		
		String ext = "";
		int dot = originalFilename.lastIndexOf(".");
		if(dot > -1)
			ext = originalFilename.substring(dot);
		
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}
	
	public static String getPagebar(int cPage, int limit, int totalContent, String url, String category) {
		
		StringBuilder pagebar = new StringBuilder();
		
		String categoryUrl = url + "?category=" + category + "&cPage=";
		url = url + "?cPage=";
		
		int pagebarSize = 5;
		int totalPage = (int) Math.ceil((double) totalContent / limit);
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;
		
		pagebar.append("<nav aria-label=\"Page navigation example\">\r\n"
					 + "<ul class=\"pagination\">");
		
		if(cPage == 1) {
			pagebar.append("<li class='page-item disabled'><a class='page-link' href=" + "javascript:paging(" + (cPage - 1) + ")" + ">Previous</a></li>\n");
		}else {
			pagebar.append("<li class='page-item'><a class='page-link' href=" + "javascript:paging(" + (cPage - 1) + ")" + ">Previous</a></li>\n");
		}
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				pagebar.append("<li class='page-item active'><a class='page-link' href=" + "javascript:paging(" + pageNo + ")" + ">" + pageNo +"</a></li>\n");
			} else {
				pagebar.append("<li class='page-item'><a class='page-link' href=" + "javascript:paging(" + pageNo + ")" + ">" + pageNo +"</a></li>\n");
			}
			
			pageNo++;
		}
		
		// [다음]
		if(cPage == totalPage) {
			pagebar.append("<li class='page-item disabled'><a class='page-link' href=" +"javascript:paging(" + pageNo + ")" + ">Next</a></li>\n");
		} else {
			pagebar.append("<li class='page-item'><a class='page-link' href=" + "javascript:paging(" + pageNo + ")" + ">Next</a></li>\n");
		}
		
		if("all".equals(category)) {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + url + "${pageNo}`;};"
					+ "</script>"
					);				
		}else {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + categoryUrl + "${pageNo}`;};"
					+ "</script>"
					);	
		}
		
		return pagebar.toString();
	}
	
	public static boolean isBirthday(Date birthday) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		Date today = new Date();
		String todayStr = sdf.format(today);
		String birthStr = sdf.format(birthday);
		
		if(todayStr.equals(birthStr)) {
			return true;
		}		
		
		return false;
	}

}
