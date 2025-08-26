<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/paginate.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>${title}</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
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
			                       		</tr>
                       			 	</thead>
	                       			<tbody>
			                        	<c:forEach var="dto" items="${list}" varStatus="status">
				                        	<tr>
												<td>${dataCount - (page - 1) * size - status.index}</td>
					                            <td>
					                            	<a href="javascript:void(0);" onclick="goArticle(${dto.noticeNum}, ${itemId})" class="text-secondary">${dto.subject}</a>
					                            </td>
												<td>관리자</td>
					                            <td>
					                         	   <fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
					                            </td>
				                            	<td>${dto.hitCount}</td>
					                            <td>
													<c:if test="${dto.fileCount != 0}">
						                            	<a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeNum}" class="text-reset"><i class="fe fe-download" style="font-size:18px;"></i></a>
													</c:if>
					                            </td>
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

</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>