package com.lemon.lemonbiz.common.vo;


public class Paging {
	
	public static String getPageBarHtml(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pageBar = new StringBuilder();
		
		//cPage앞에 붙을 구분자를 지정
		char delim = url.indexOf("?") > -1 ? '&' : '?';  
		url = url + delim;
		
		int pageBarSize = 5; //페이지바에 나열될 페이지번호의 개수
		//115 / 10 => 12
		int totalPage = (int)Math.ceil((double)totalContents/numPerPage);
		
		// x * pageBarSize + 1
		// 1 2 3 4 5 -> 1      
		// 6 7 8 9 10 -> 6
		// 11 12 13 14 15 -> 11
		int pageStart = ((cPage - 1)/pageBarSize) * pageBarSize + 1; 
		int pageEnd = pageStart + pageBarSize - 1;
		int pageNo = pageStart;
		
	
		//이전 
		if(pageNo == 1) {
			
		}
		else {
			pageBar.append("<li class='page-item'><a class='page-link' href='" + url + "cPage=" + (pageNo - 1) + "'>이전</a></li>");
		}
		
		//PageNo
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			//현재페이지인 경우
			if(pageNo == cPage) {
				pageBar.append("<li class='page-item'><span class='page-link'>" + pageNo + "</span></li>");
			}
			//현재페이지가 아닌 경우
			else {
				pageBar.append("<li class='page-item'><a class='page-link' href='" + url + "cPage=" + pageNo + "'>" + pageNo + "</a></li>");
			}
			pageNo++;
		}
		//다음
		if(pageNo > totalPage) {
			
		}
		else {
			pageBar.append("<li class='page-item'><a class='page-link' href='" + url + "cPage=" + pageNo + "'>다음</a></li>");
		}

		return pageBar.toString();
	}
}