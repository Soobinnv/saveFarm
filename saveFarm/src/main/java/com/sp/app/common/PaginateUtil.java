package com.sp.app.common;

import org.springframework.stereotype.Service;

@Service
public class PaginateUtil {
	/**
	 * 전체 페이지수를 구하는 메소드
	 * 
	 * @param dataCount 총 데이터 개수
	 * @param size      한 화면에 출력할 데이터 개수
	 * @return 총 페이지 수
	 */
	public int pageCount(int dataCount, int size) {
		if (dataCount <= 0 || size <= 0) {
			return 0;
		}

		return dataCount / size + (dataCount % size > 0 ? 1 : 0);
	}

	/**
	 * 페이징(paging) 처리를 하는 메소드(GET 방식, a 태그를 이용하여 해당 페이지의 URL로 이동)
	 * 
	 * @param current_page 화면에 출력할 페이지 번호
	 * @param total_page   총 페이지 수
	 * @param list_url     페이지 번호에 link를 설정할 URL
	 * @return 페이징 처리 결과
	 */
	public String paging(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();

		int numPerBlock = 10;
		int currentPageSetup;
		int n, page;

		if (current_page < 1 || total_page < current_page) {
			return "";
		}

		list_url += list_url.contains("?") ? "&" : "?";

		// currentPageSetup : 표시할첫페이지-1
		currentPageSetup = (current_page / numPerBlock) * numPerBlock;
		if (current_page % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}

		sb.append("<div class='paginate'>");
		// 처음페이지, 이전(10페이지 전)
		n = current_page - numPerBlock;
		if (total_page > numPerBlock && currentPageSetup > 0) {
			sb.append(createLinkUrl(list_url, 1, "&#x226A", "처음"));
			sb.append(createLinkUrl(list_url, n, "&#x003C", "이전"));
		}

		// 페이징
		page = currentPageSetup + 1;
		while (page <= total_page && page <= (currentPageSetup + numPerBlock)) {
			if (page == current_page) {
				sb.append("<span>" + page + "</span>");
			} else {
				sb.append(createLinkUrl(list_url, page, String.valueOf(page)));
			}

			page++;
		}

		// 다음(10페이지 후), 마지막페이지
		n = current_page + numPerBlock;
		if (n > total_page)
			n = total_page;
		if (total_page - currentPageSetup > numPerBlock) {
			sb.append(createLinkUrl(list_url, n, "&#x003E", "다음"));
			sb.append(createLinkUrl(list_url, total_page, "&#x226B", "마지막"));
		}
		sb.append("</div>");

		return sb.toString();
	}

	/**
	 * javascript를 이용하여 페이징 처리를하는 메소드 : javascript의 지정한 함수(methodName)를 호출
	 * 
	 * @param current_page 화면에 출력할 페이지 번호
	 * @param total_page   총 페이지 수
	 * @param methodName   호출할 자바스크립트 함수명
	 * @return 페이징 처리 결과
	 */
	public String pagingMethod(int current_page, int total_page, String methodName) {
		StringBuilder sb = new StringBuilder();

		int numPerBlock = 10; // 리스트에 나타낼 페이지 수
		int currentPageSetUp;
		int n, page;

		if (current_page < 1 || total_page < current_page) {
			return "";
		}

		// currentPageSetup : 표시할첫페이지-1
		currentPageSetUp = (current_page / numPerBlock) * numPerBlock;
		if (current_page % numPerBlock == 0) {
			currentPageSetUp = currentPageSetUp - numPerBlock;
		}

		sb.append("<div class='paginate'>");

		// 처음페이지, 이전(10페이지 전)
		n = current_page - numPerBlock;
		if ((total_page > numPerBlock) && (currentPageSetUp > 0)) {
			sb.append(createLinkClick(methodName, 1, "&#x226A"));
			sb.append(createLinkClick(methodName, n, "&#x003C"));
		}

		// 페이징
		page = currentPageSetUp + 1;
		while ((page <= total_page) && (page <= currentPageSetUp + numPerBlock)) {
			if (page == current_page) {
				sb.append("<span>" + page + "</span>");
			} else {
				sb.append(createLinkClick(methodName, page, String.valueOf(page)));
			}

			page++;
		}

		// 다음(10페이지 후), 마지막 페이지
		n = current_page + numPerBlock;
		if (n > total_page)
			n = total_page;
		if (total_page - currentPageSetUp > numPerBlock) {
			sb.append(createLinkClick(methodName, n, "&#x003E"));
			sb.append(createLinkClick(methodName, total_page, "&#x226B"));
		}
		sb.append("</div>");

		return sb.toString();
	}

	// 화면에 표시할 페이지를 중앙에 출력
	public String pagingUrl(int current_page, int total_page, String list_url) {
		StringBuilder sb = new StringBuilder();

		int numPerBlock = 10;
		int n, page;

		if (current_page < 1 || total_page < current_page) {
			return "";
		}

		list_url += list_url.contains("?") ? "&" : "?";

		page = 1; // 출력할 시작 페이지
		if (current_page > (numPerBlock / 2) + 1) {
			page = current_page - (numPerBlock / 2);

			n = total_page - page;
			if (n < numPerBlock) {
				page = total_page - numPerBlock + 1;
			}

			if (page < 1)
				page = 1;
		}

		sb.append("<div class='paginate'>");

		// 처음페이지
		if (page > 1) {
			sb.append(createLinkUrl(list_url, 1, "&#x226A"));
		}

		// 이전(한페이지 전)
		n = current_page - 1;
		if (current_page > 1) {
			sb.append(createLinkUrl(list_url, n, "&#x003C"));
		}

		n = page;
		while (page <= total_page && page < n + numPerBlock) {
			if (page == current_page) {
				sb.append("<span>" + page + "</span>");
			} else {
				sb.append(createLinkUrl(list_url, page, String.valueOf(page)));
			}
			page++;
		}

		// 다음(한페이지 다음)
		n = current_page + 1;
		if (current_page < total_page) {
			sb.append(createLinkUrl(list_url, n, "&#x003E"));
		}

		// 마지막페이지
		if (page <= total_page) {
			sb.append(createLinkUrl(list_url, total_page, "&#x226B"));
		}

		sb.append("</div>");

		return sb.toString();
	}

	// 화면에 표시할 페이지를 중앙에 출력 : javascript 함수 호출
	public String pagingFunc(int current_page, int total_page, String methodName) {
		StringBuilder sb = new StringBuilder();

		int numPerBlock = 10;
		int n, page;

		if (current_page < 1 || total_page < current_page) {
			return "";
		}

		page = 1; // 출력할 시작 페이지
		if (current_page > (numPerBlock / 2) + 1) {
			page = current_page - (numPerBlock / 2);

			n = total_page - page;
			if (n < numPerBlock) {
				page = total_page - numPerBlock + 1;
			}

			if (page < 1)
				page = 1;
		}

		sb.append("<div class='paginate'>");

		// 처음페이지
		if (page > 1) {
			sb.append(createLinkClick(methodName, 1, "&#x226A"));
		}

		// 이전(한페이지 전)
		n = current_page - 1;
		if (current_page > 1) {
			sb.append(createLinkClick(methodName, n, "&#x003C"));
		}

		n = page;
		while (page <= total_page && page < n + numPerBlock) {
			if (page == current_page) {
				sb.append("<span>" + page + "</span>");
			} else {
				sb.append(createLinkClick(methodName, page, String.valueOf(page)));
			}
			page++;
		}

		// 다음(한페이지 다음)
		n = current_page + 1;
		if (current_page < total_page) {
			sb.append(createLinkClick(methodName, n, "&#x003E"));
		}

		// 마지막페이지
		if (page <= total_page) {
			sb.append(createLinkClick(methodName, total_page, "&#x226B"));
		}

		sb.append("</div>");

		return sb.toString();
	}

	protected String createLinkUrl(String url, int page, String label) {
		return "<a href='" + url + "page=" + page + "'>" + label + "</a>";
	}

	protected String createLinkUrl(String url, int page, String label, String title) {
		StringBuilder link = new StringBuilder();
		link.append("<a href='").append(url).append("page=").append(page).append("'");

		if (title != null && !title.isEmpty()) {
			link.append(" title='").append(title).append("'");
		}

		link.append(">").append(label).append("</a>");

		return link.toString();
	}

	protected String createLinkClick(String methodName, int page, String label) {
		return "<a onclick='" + methodName + "(" + page + ");'>" + label + "</a>";
	}

	protected String createLinkClick(String methodName, int page, String label, String title) {
		StringBuilder link = new StringBuilder();
		link.append("<a onclick='").append(methodName).append("(").append(page).append(");'");

		if (title != null && !title.isEmpty()) {
			link.append(" title='").append(title).append("'");
		}

		link.append(">").append(label).append("</a>");

		return link.toString();
	}
	
	// 페이징 HTML 생성 - Ajax용
	public String adminPaging(int currentPage, int totalPage, String functionName) {
	    StringBuilder sb = new StringBuilder();
	    int numPerBlock = 10; // 한 블록에 표시할 페이지 수
	    int currentPageSetup;
	    int page;
	    int prevPage, nextPage;
	    if (currentPage < 1 || totalPage < currentPage) {
	        return "";
	    }

	    currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
	    if (currentPage % numPerBlock == 0) {
	        currentPageSetup -= numPerBlock;
	    }

	    sb.append("<div class=\"dataTables_paginate paging_simple_numbers\" id=\"dataTable-1_paginate\">");
	    sb.append("<ul class=\"pagination\">");

	    // 이전 블록	
	    prevPage = currentPage - 1;
	    if (currentPage > 1) {
	        sb.append(createPageItem(functionName, 1, "fe fe-chevrons-left", "first", false)); // 처음
	        sb.append(createPageItem(functionName, prevPage, "fe fe-chevron-left", "previous", false)); // 이전
	    } else {
	        sb.append(createPageItem(functionName, 1, "fe fe-chevrons-left", "first", true)); // 처음 비활성
	        sb.append(createPageItem(functionName, 1, "fe fe-chevron-left", "previous", true)); // 이전 비활성
	    }

	    // 페이지 번호
	    page = currentPageSetup + 1;
	    while (page <= totalPage && page <= currentPageSetup + numPerBlock) {
	        boolean isCurrent = (page == currentPage);
	        sb.append(createPageItem(functionName, page, "", "", isCurrent));
	        page++;
	    }

	    // 다음 블록
	    nextPage = currentPage + 1;
	    if (currentPage < totalPage) {
	        sb.append(createPageItem(functionName, nextPage, "fe fe-chevron-right", "next", false)); // 이후
	        sb.append(createPageItem(functionName, totalPage, "fe fe-chevrons-right", "next", false)); // 마지막
	    } else {
	        sb.append(createPageItem(functionName, totalPage, "fe fe-chevron-right", "next", true));
	        sb.append(createPageItem(functionName, totalPage, "fe fe-chevrons-right", "next", true));
	    }

	    sb.append("</ul>");
	    sb.append("</div>");

	    return sb.toString();
	}
	
	// 페이지 아이템 생성 - Ajax용
	private String createPageItem(String functionName, int page, String iconClass, String ariaLabel, boolean isDisabledOrCurrent) {
	    StringBuilder sb = new StringBuilder();
	    String liClass = "paginate_button page-item";

	    // disabled 처리
	    if (isDisabledOrCurrent) liClass += " disabled";

	    sb.append("<li class=\"" + liClass + "\"");

	    if (ariaLabel != null && !ariaLabel.isEmpty()) {
	        sb.append(" id=\"dataTable-1_" + ariaLabel + "\"");
	    }
	    sb.append(">");

	    if (isDisabledOrCurrent) {
	        // 클릭 불가
	        sb.append("<a href=\"#\" class=\"page-link\">");
	        if (!iconClass.isEmpty()) {
	            sb.append("<i class=\"" + iconClass + "\"></i>");
	        } else {
	            sb.append(page);
	        }
	        sb.append("</a>");
	    } else {
	        // 클릭 가능 (JS 호출)
	        sb.append("<a href=\"#\" class=\"page-link\" onclick=\"" + functionName + "(" + page + "); return false;\">");
	        if (!iconClass.isEmpty()) {
	            sb.append("<i class=\"" + iconClass + "\"></i>");
	        } else {
	            sb.append(page);
	        }
	        sb.append("</a>");
	    }

	    sb.append("</li>");
	    return sb.toString();
	}


	public String adminPagingUrl(int currentPage, int totalPage, String listUrl) {
	    StringBuilder sb = new StringBuilder();
	    int numPerBlock = 10; // 한 블록에 표시할 페이지 수
	    int currentPageSetup;

	    if (currentPage < 1 || totalPage < currentPage) return "";

	    currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
	    if (currentPage % numPerBlock == 0) currentPageSetup -= numPerBlock;

	    sb.append("<div class=\"dataTables_paginate paging_simple_numbers\" id=\"dataTable-1_paginate\">");
	    sb.append("<ul class=\"pagination\">");

	    // 이전 블록
	    int prevPage = currentPage - 1;
	    if (currentPage > 1) {
	        sb.append(createPageItemUrl(listUrl, 1, "fe-chevrons-left", false)); // 처음
	        sb.append(createPageItemUrl(listUrl, prevPage, "fe-chevron-left", false)); // 이전
	    } else {
	        sb.append(createPageItemUrl(listUrl, 1, "fe-chevrons-left", true));
	        sb.append(createPageItemUrl(listUrl, 1, "fe-chevron-left", true));
	    }

	    // 페이지 번호
	    int page = currentPageSetup + 1;
	    while (page <= totalPage && page <= currentPageSetup + numPerBlock) {
	        boolean isCurrent = (page == currentPage);
	        sb.append(createPageItemUrl(listUrl, page, "", isCurrent));
	        page++;
	    }

	    // 다음 블록
	    int nextPage = currentPage + 1;
	    if (currentPage < totalPage) {
	        sb.append(createPageItemUrl(listUrl, nextPage, "fe-chevron-right", false)); // 다음
	        sb.append(createPageItemUrl(listUrl, totalPage, "fe-chevrons-right", false)); // 마지막
	    } else {
	        sb.append(createPageItemUrl(listUrl, totalPage, "fe-chevron-right", true));
	        sb.append(createPageItemUrl(listUrl, totalPage, "fe-chevrons-right", true));
	    }

	    sb.append("</ul>");
	    sb.append("</div>");

	    return sb.toString();
	}
	
	private String createPageItemUrl(String url, int page, String iconClass, boolean isDisabledOrCurrent) {
	    StringBuilder sb = new StringBuilder();
	    String liClass = "paginate_button page-item";
	    if (isDisabledOrCurrent) liClass += " disabled";

	    sb.append("<li class=\"fe " + liClass + "\">");

	    sb.append("<a href=\"" + (isDisabledOrCurrent ? "#" : url + "?page=" + page) + "\" class=\"page-link\">");

	    if (iconClass != null && !iconClass.isEmpty()) {
	        sb.append("<i class=\"fe " + iconClass + "\"></i>");
	    } else {
	        sb.append(page);
	    }

	    sb.append("</a>");
	    sb.append("</li>");
	    return sb.toString();
	}

}
