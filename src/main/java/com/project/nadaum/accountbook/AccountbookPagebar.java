package com.project.nadaum.accountbook;

public class AccountbookPagebar {
public static String getPagebar(int cPage, int limit, int totalContent, String url, String incomeExpense, String category, String detail) {
		
		StringBuilder pagebar = new StringBuilder();
		
		String searchUrl = url + "?incomeExpense=" + incomeExpense + "&category=" + category + "&detail=" + detail + "&cPage=";
		String incomeExpenseUrl = url + "?incomeExpense=" + incomeExpense + "&cPage=";
		
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
		
//		메인에서 전체 리스트 페이징 
		if("all".equals(category) && "all".equals(incomeExpense) && "all".equals(detail)) {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + url + "${pageNo}`;};"
					+ "</script>"
					);		
		//incomeExpense pagebar -> category와 detail은 all
		} else if("all".equals(category) && "all".equals(detail)) {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + incomeExpenseUrl + "${pageNo}`;};"
					+ "</script>"
					);	
		} else {
			pagebar.append(" </ul>\r\n"
					+ "</nav>"
					+ "<script>"
					+ "const paging = (pageNo) => {location.href=`" + searchUrl + "${pageNo}`;};"
					+ "</script>"
					);	
		}
		
		return pagebar.toString();
	}
}
