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
			<h1>1:1 문의</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">
				
					<div class="row py-1 mb-2">
						<div class="col-md-6 align-self-center">
							<span class="small-title">글목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page} 페이지)</span>
						</div>	
						<div class="col-md-6 align-self-center text-end">
						</div>
					</div>				
				
					<table class="table table-hover board-list">
						<thead>
							<tr>
								<th width="100">분류</th>
								<th>제목</th>
								<th width="100">작성자</th>
								<th width="100">문의일자</th>
								<th width="90">처리결과</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr>
									<td>${dto.category}</td>
									<td class="left">
										<div class="text-wrap">
											<a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
										</div>
									</td>
									<td>${dto.name}</td>
									<td>${dto.reg_date}</td>
									<td>${(empty dto.answer_date)?"답변대기":"답변완료"}</td>
								</tr>
							</c:forEach>
						</tbody>					
					</table>
				
					<div class="page-navigation">
						${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
					</div>

					<div class="row mt-3">
						<div class="col-md-3">
							<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/inquiry/list';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
						</div>
						<div class="col-md-6 text-center">
							<form name="searchForm" class="form-search">
								<select name="schType">
									<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
									<option value="reg_date" ${schType=="reg_date"?"selected":""}>작성일</option>
									<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
									<option value="question" ${schType=="question"?"selected":""}>내용</option>
								</select>
								<input type="text" name="kwd" value="${kwd}">
								<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
							</form>
						</div>
						<div class="col-md-3 text-end">
							<button type="button" class="btn-accent btn-md" onclick="location.href='${pageContext.request.contextPath}/inquiry/write';">문의등록</button>
						</div>
					</div>
				
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
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
	
	let url = '${pageContext.request.contextPath}/inquiry/list';
	location.href = url + '?' + params;
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>