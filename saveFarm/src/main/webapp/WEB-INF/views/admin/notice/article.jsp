<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스마트팜</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
</head>
<body class="vertical light">
<div class="wrapper"> 
<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>
<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

<main class="main-container">

	<div class="right-panel">
		<div class="page-title" data-aos="fade-up" data-aos-delay="200">
			<h2>공지사항</h2>
		</div>

		<div class="section p-5" data-aos="fade-up" data-aos-delay="200">
			<div class="section-body p-5">
				<div class="col-lg-7 board-section mx-auto" data-aos="fade-up" data-aos-delay="200"> <%-- padding 제거, mx-auto 유지 --%>
					<div class="card shadow mb-4"> <%-- 카드 추가 --%>
						<div class="card-body p-4"> <%-- card-body 추가, 내부 패딩 설정 --%>
							<div class="pb-2">
								<span class="small-title">상세정보</span>
							</div>
												
							<table class="table board-article table-bordered"> <%-- table-bordered 추가 --%>
								<thead>
									<tr>
										<td colspan="2" class="text-center">
											<h4 class="my-2">${dto.subject}</h4> <%-- 제목을 더 강조 --%>
										</td>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td width="50%" class="fw-bold"> <%-- 글씨를 굵게 --%>
											작성자 : ${dto.loginId}
										</td>
										<td width="50%" class="text-end">
											작성일 : <fmt:formatDate value="${dto.regDate}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									</tr>
									
									<c:if test="${not empty dto.updateId}">
										<tr>
											<td width="50%" class="fw-bold">
												수정자 : ${dto.updateName}(${dto.loginUpdate})
											</td>
											<td width="50%" class="text-end">
												수정일 : <fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
											</td>
										</tr>
									</c:if>

									<tr>
										<td width="50%" class="fw-bold">
											조회수 : ${dto.hitCount}
										</td>
										<td width="50%" class="text-end">
											출 력 : ${dto.showNotice == 1 ? "표시" : "숨김" }
										</td>
									</tr>
									
									<tr>
										<td colspan="2" valign="top" height="200" class="article-content" style="border-bottom:none;">
											${dto.content}
										</td>
									</tr>

									<tr>
										<td colspan="2">
										<c:if test="${listFile.size() != 0}">
											<p class="border text-secondary mb-1 p-2">
												<i class="bi bi-folder2-open"></i>
												<c:forEach var="vo" items="${listFile}" varStatus="status">
													<a href="${pageContext.request.contextPath}/admin/notice/download/${vo.fileNum}">
														${vo.originalFilename}
														(<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
													</a>
													<c:if test="${not status.last}">|</c:if>
												</c:forEach>
											</p>
											<p class="border text-secondary mb-1 p-2">
												<i class="bi bi-folder2-open"></i>
												<a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeNum}">파일 전체 압축 다운로드(zip)</a>
											</p>
										</c:if>
									</td>
									</tr>

									<tr>
										<td colspan="2">
											<div class="d-flex align-items-center py-2 border-top"> 
												<span class="me-3 fw-bold">이전글 : </span>
												<c:if test="${not empty prevDto}">
													<a href="${pageContext.request.contextPath}/admin/notice/article/${itemId}?noticeNum=${prevDto.noticeNum}&${query}" class="text-decoration-none">${prevDto.subject}</a>
												</c:if>
												<c:if test="${empty prevDto}">
													<span class="text-muted">이전글 없음</span>
												</c:if>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div class="d-flex align-items-center py-2 border-bottom">
												<span class="me-3 fw-bold">다음글 : </span>
												<c:if test="${not empty nextDto}">
													<a href="${pageContext.request.contextPath}/admin/notice/article/${itemId}?noticeNum=${nextDto.noticeNum}&${query}" class="text-decoration-none">${nextDto.subject}</a>
												</c:if>
												<c:if test="${empty nextDto}">
													<span class="text-muted">다음글 없음</span>
												</c:if>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="row mt-4"> <%-- 마진 탑 추가 --%>
								<div class="col-md-6 align-self-center">
									<button type="button" class="btn btn-secondary me-2" onclick="location.href='${pageContext.request.contextPath}/admin/notice/update/${itemId}?noticeNum=${dto.noticeNum}&page=${page}';">수정</button>
									<button type="button" class="btn btn-secondary" onclick="deleteOk();">삭제</button>
								</div>
								<div class="col-md-6 align-self-center text-end">
									<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/notice/${itemId < 100 ? 'guideLineslist' : 'noticeList' }/${itemId}?${query}';">리스트</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>	

<%-- Summernote 스크립트 제거 (이 페이지에서는 에디터가 필요 없음) --%>
<%-- <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script> --%>

<script type="text/javascript">
	function deleteOk() {
		let params = 'noticeNum=${dto.noticeNum}&${query}';
		let url = '${pageContext.request.contextPath}/admin/notice/delete/'+ ${itemId} + '?' + params;
	
		if(confirm('위 자료를 삭제 하시 겠습니까 ? ')) {
			location.href = url;
		}
	}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>
