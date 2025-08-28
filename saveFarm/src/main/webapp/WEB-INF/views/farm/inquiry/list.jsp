<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm</title>
<jsp:include page="/WEB-INF/views/farm/layout/farmHeaderResources.jsp"/>

<style type="text/css">
#dataTable-1 thead th{
  background-color: var(--sf-soft, #E9F5EC) !important;  /* 연한 초록 */
  color: var(--sf-primary, #116530) !important;          /* 진한 초록 */
  border-bottom: 2px solid var(--sf-primary, #116530) !important;
  font-weight: 600;
}

/* 헤더 안의 링크도 동일 색상 유지 */
#dataTable-1 thead th a{
  color: inherit;
}

/* 행 호버 시 아주 옅은 초록 하이라이트 (기존 디자인 방해 X) */
#dataTable-1 tbody tr:hover{
  background-color: rgba(17, 101, 48, 0.06);
}

/* 표 외곽선 살짝만 강조 (옵션) */
.outerDesign {
  background:#fff;
  border:1px solid rgba(17,101,48,.12);
  border-radius:12px;
  box-shadow:
    0 6px 18px rgba(17,101,48,.10),
    0 2px 6px rgba(0,0,0,.04);
  padding: 50px;
  margin: 30px 0 70px 0;
}

/* 테이블 바깥선 살리고 모서리 맞추기(선택) */
#dataTable-1{
  border:1px solid rgba(17,101,48,.12) !important;
  overflow:hidden; /* 둥근 모서리 안 깨지게 */
}

#dataTable-1 tbody tr[data-href] { 
	cursor: pointer; 
}
</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/guideTitle.webp);">
      <div class="container position-relative">
        <h1>1:1 문의</h1>
        <p>사용 중 불편·문의 사항을 보내 주세요. 신속하고 정확하게 안내드립니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
            <li class="current">문의</li>
          </ol>
        </nav>
      </div>
    </div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-3">
				
					<div class="row py-1 mb-2">
						<div class="col-md-6 align-self-center">
							<span class="small-title">글목록</span> <span class="dataCount">${dataCount}개(${page}/${total_page} 페이지)</span>
						</div>	
						<div class="col-md-6 align-self-center text-end">
						</div>
					</div>				
				
				<div class="outerDesign">
					<table class="table datatables" id="dataTable-1">
						<thead>
							<tr>
								<th width="100" class="text-center">번호</th>
								<th class="text-center">제목</th>
								<th width="100" class="text-center">처리여부</th>
								<th width="150" class="text-center">문의일자</th>
								<th width="150" class="text-center">답변일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dto" items="${list}">
								<tr data-href="${articleUrl}&inquiryNum=${dto.inquiryNum}">
									<td class="text-center">${dataCount - (page - 1) * size - status.index}</td>
									<td class="text-center">
										<div class="text-wrap">
											${dto.subject}
										</div>
									</td>
									<td class="text-center">
										${dto.processResult == 0 ? "답변대기":"답변완료"}
									</td>
									<td class="text-center">${dto.regDate}</td>
									<td class="text-center">
										<c:choose>
											<c:when test="${dto.answerDate != null}">
												${dto.answerDate}
											</c:when>
											<c:when test="${dto.answerDate == null}">
												-
											</c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>					
					</table>
				
					<div class="page-navigation text-center <c:if test="${dataCount == 0}">p-5</c:if>">
						${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
					</div>
					</div>

					<div class="row mt-3">
						<div class="col-md-3">
							<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/inquiry/list';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
						</div>
						<div class="col-md-6 text-center">
							<form name="searchForm" class="form-search">
								<select name="schType">
									<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
									<option value="regDate" ${schType=="regDate"?"selected":""}>작성일</option>
									<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
									<option value="content" ${schType=="content"?"selected":""}>내용</option>
								</select>
								<input type="text" name="kwd" value="${kwd}">
								<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
							</form>
						</div>
						<div class="col-md-3 text-end">
							<button type="button" class="btn-accent btn-md" onclick="location.href='${pageContext.request.contextPath}/farm/inquiry/write';">문의등록</button>
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
	
	let url = '${pageContext.request.contextPath}/farm/inquiry/list';
	location.href = url + '?' + params;
}

document.addEventListener('click', function(e){
  const tr = e.target.closest('tr[data-href]');
  if(!tr) return;
  if(e.target.closest('a, button, input, select, textarea, label')) return;
  window.location.href = tr.getAttribute('data-href').replace(/&amp;/g, '&');
});

</script>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

</body>
</html>