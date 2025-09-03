<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<style>
  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }

#sidebar {
  position: fixed;
  top: 0;
  left: 0;
  width: 240px;
  height: 100vh;
  background-color: #343a40;
  transition: transform 0.3s ease-in-out;
  z-index: 1030;
}

/* 숨겨졌을 때 */
.sidebar-collapsed #sidebar {
  transform: translateX(-100%);
}

#leftSidebar {
    width: 250px;
    transition: width 0.3s ease;
  }

  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }
  

.nav-tabs .nav-link {
  background-color: transparent; 
  color: inherit;  
  border: none;           
}  

#dataTable-1 th, 
#dataTable-1 td {
  text-align: center;
}

#dataTable-1 th:nth-child(2),
#dataTable-1 td:nth-child(2) {
  width: 600px;  /* 원하는 너비로 조절 */
  white-space: nowrap; /* 줄바꿈 방지 (필요하면) */
} 
</style>

<title>세이브팜</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper">
<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
<main role="main" class="main-content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<h2 class="mb-2 page-title text-center">${title}</h2>
				<div class="row my-4">
					<div class="col-md-12">
						<div class="card shadow">
							<div class="card-body">
								<div class="row m-0">
			                     	<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">
										${dataCount}개 (${page}/${totalPage}페이지)
									</div>
             		  			</div> 
                      			<table class="table datatables" id="dataTable-1">
                      				<thead>
		                        		<tr>
				                            <th>번호</th>
											<th>제목</th>
											<th>작성자</th>
											<th>작성일</th>
											<th>조회수</th>
											<th>첨부</th>
											<th>표시</th>
			                       		</tr>
                       			 	</thead>
	                       			<tbody>
			                        	<c:forEach var="dto" items="${list}" varStatus="status">
				                        	<tr>
												<td>${dataCount - (page - 1) * size - status.index}</td>
					                            <td>
					                            	<a href="javascript:void(0);" onclick="goArticle(${dto.noticeNum}, ${itemId})" class="text-secondary">${dto.subject}</a>
					                            </td>
												<td>${dto.updateName}</td>
					                            <td>
					                         	   <fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
					                            </td>
				                            	<td>${dto.hitCount}</td>
					                            <td>
													<c:if test="${dto.fileCount != 0}">
						                            	<a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeNum}" class="text-reset"><i class="fe fe-download" style="font-size:18px;"></i></a>
													</c:if>
					                            </td>
					                            <td>${dto.showNotice == 1 ? '표시' : '숨김'}</td>
				                          	</tr>
			                          	</c:forEach>
			                        </tbody>
		                      	</table>
		                        <div class="row justify-content-center">
								 	${paging}
			                    </div>
			                     
		                     	<form action="${pageContext.request.contextPath}/admin/notice/noticeList/${itemId}" method="get">
								    <div class="row align-items-start">
								        <div class="col-sm-12 col-md-3"></div>
								
								        <div class="col-sm-12 col-md-6 d-flex justify-content-center flex-column text-center"> 
								
								            <!-- 검색 폼 -->
								            <div class="d-flex justify-content-center align-items-center mb-3"> 
								                <button type="reset" class="fe fe-rotate-ccw btn  btn-outline-primary me-2 mr-1"></button>
								                <select class="form-control me-2 col-2" name="schType"> 
								                    <option value="all" ${schType == 'all' ? 'selected' : ''}>제목+내용</option>
								                    <option value="loginId" ${schType == 'loginId' ? 'selected' : ''}>글쓴이</option>
								                    <option value="reg_date" ${schType == 'reg_date' ? 'selected' : ''}>작성일</option>
								                    <option value="subject" ${schType == 'subject' ? 'selected' : ''}>제목</option>
								                    <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
								                </select>
								                <input type="text" class="form-control me-2 mr-1 col-3" name="kwd" id="search1" value="${kwd}" placeholder="Search"> 
								                <button type="submit" class="btn  btn-outline-primary">검색</button>
								            </div>
								        </div>
								
								        <!-- 오른쪽 버튼 영역 -->
								        <div class="col-sm-12 col-md-3 d-flex justify-content-end align-items-start">
								            <button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write/${itemId}';">공지등록</button>
								        </div>
								    </div>
								</form>
								<form name="articleForm" action="${pageContext.request.contextPath}/admin/notice/article/${itemId}">
                                    <input type="hidden" name="noticeNum">
                                    <input type="hidden" name="schType" value="loginId">
									<input type="hidden" name="kwd" value="">
									<input type="hidden" name="page" value="${page}">
                                </form>
							</div>
						</div>
					</div> 
				</div> 
			</div> 
		</div> 
	</div> 
</main>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	// id가 'content'인 textarea를 Summernote로 초기화
	$('#content').summernote({
		height: 300 // 에디터 높이 설정
	});
});

//검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/notice/noticeList/${itemId}';
	location.href = url + '?' + params;
}

function goArticle(noticeNum, itemId) {
    const f = document.articleForm;
    f.noticeNum.value = noticeNum;
    f.action = '${pageContext.request.contextPath}/admin/notice/article/' + itemId; // itemId도 URL에 포함
    f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>