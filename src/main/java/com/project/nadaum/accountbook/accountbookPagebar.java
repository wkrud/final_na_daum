package com.project.nadaum.accountbook;

public class accountbookPagebar {
public static String getPagebar(int cPage, int limit, int totalContent, String url, String incomeExpense, String category, String detail) {
		
		StringBuilder pagebar = new StringBuilder();
		
		String categoryUrl = url + "?category=" + category + "&cPage=";
		String incomeExpenseUrl = url + "?incomeExpense=" + category + "&cPage=";
		String detailUrl = url + "?detail=" + category + "&cPage=";

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
		
		if("all".equals(category) || "all".equals(incomeExpense) || "all".equals(detail)) {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + url + "${pageNo}`;};"
					+ "</script>"
					);				
		} else if("all".equals(category)) {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + categoryUrl + "${pageNo}`;};"
					+ "</script>"
					);	
		} else {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + categoryUrl + "${pageNo}`;};"
					+ "</script>"
					);	
		}
		
		return pagebar.toString();
	}
}
