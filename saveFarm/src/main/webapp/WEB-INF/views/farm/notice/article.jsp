<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm</title>
<jsp:include page="/WEB-INF/views/farm/layout/farmHeaderResources2.jsp"/>

<style type="text/css">
/* 공지 상세 카드 */
.article-card{
  background:#fff;
  border:1.5px solid #000;           /* 검은색 보더 */
  border-radius:16px;
  padding:24px 24px 8px;
  box-shadow:0 12px 24px rgba(0,0,0,.18), 0 4px 10px rgba(0,0,0,.10); /* 그림자 */
  transition:box-shadow .2s ease, transform .05s ease;
}

/* 살짝 띄워 보이는 효과 (선택) */
.article-card:hover{
  box-shadow:0 16px 32px rgba(0,0,0,.22), 0 6px 14px rgba(0,0,0,.12);
  transform:translateY(-1px);
}

/* 카드 안 표 여백/겹치는 보더 정리 */
.article-card .table{
  margin-bottom:0;
  background:transparent;
}
.article-card .table > :not(caption) > * > *{
  background:transparent; /* 부트스트랩 배경 겹침 방지 */
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
        <h1>공지사항</h1>
        <p>가입서류, 유통, 상품등록 등 각종 가이드라인에 대한 공지를 알려드리는 페이지입니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
            <li class="current">공지</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">

				<div class="article-card">
					<div class="pb-2">
						<span class="small-title">상세정보</span>
					</div>
									
					<table class="table board-article">
						<thead>
							<tr>
								<td colspan="2" class="text-center">
									${dto.subject}
								</td>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td width="50%">
									작성자 : 관리자
								</td>
								<td width="50%" class="text-end">
									작성일 : <fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd"/> | 조회 ${dto.hitCount}
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
												<a href="${pageContext.request.contextPath}/farm/notice/download/${vo.fileNum}">
													${vo.originalFilename}
													(<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
												</a>
												<c:if test="${not status.last}">|</c:if>
											</c:forEach>
										</p>
										<p class="border text-secondary mb-1 p-2">
											<i class="bi bi-folder2-open"></i>
											<a href="${pageContext.request.contextPath}/farm/notice/zipdownload/${dto.noticeNum}">파일 전체 압축 다운로드(zip)</a>
										</p>
									</c:if>
								</td>
							</tr>

							<tr>
								<td colspan="2">
									이전글 :
									<c:if test="${not empty prevDto}">
									  <a href="${pageContext.request.contextPath}/farm/notice/article/${prevDto.noticeNum}?${query}">
									    ${prevDto.subject}
									  </a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									다음글 :
									<c:if test="${not empty nextDto}">
									  <a href="${pageContext.request.contextPath}/farm/notice/article/${nextDto.noticeNum}?${query}">
									  	${nextDto.subject}
									  </a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

					<div class="row mb-2">
						<div class="col-md-6 align-self-center">
							&nbsp;
						</div>
						<div class="col-md-6 align-self-center text-end">
							<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/notice/list?${query}';">리스트</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources2.jsp"/>

</body>
</html>