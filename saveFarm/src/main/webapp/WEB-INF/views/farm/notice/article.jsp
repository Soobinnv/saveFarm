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
:root{ --sf-accent:#2f855a; } /* 페이지용 포인트 컬러 */

.article-card{
  border:1px solid rgba(0,0,0,.12);
  border-radius:12px;
  box-shadow:0 8px 24px rgba(0,0,0,.06);
  background:#fff;
}
.article-card::before{
  content:"";
  display:block;
  height:4px;
  margin:-24px -24px 16px;           /* article-card의 p-4/p-md-5 여백보다 살짝 크게 */
  background:linear-gradient(90deg,var(--sf-accent),#55b59a);
  border-radius:12px 12px 0 0;
}

/* 제목 라벨 */
.board-section h2:first-of-type{
  font-weight:700; letter-spacing:-.02em; margin-bottom:.75rem;
  position:relative; padding-left:12px;
}
.board-section h2:first-of-type::before{
  content:""; position:absolute; left:0; top:52%; transform:translateY(-50%);
  width:4px; height:1.2em; background:var(--sf-accent); border-radius:2px;
}

/* 표 디테일 */
.board-article thead td{ font-size:1.1rem; font-weight:600; padding:1rem; }
.board-article tbody td{ padding:.9rem 1rem; }
.board-article tbody tr+tr td{ border-top:1px dashed rgba(0,0,0,.08); }
.article-content{ line-height:1.8; font-size:1.05rem; }

/* 파일 박스(기존 border/p-2 유지하면서 톤만 업) */
.board-section .file-box{
  background:#f8fafb; border:1px solid rgba(0,0,0,.08);
  border-radius:.5rem; display:flex; align-items:center; gap:.5rem;
}
.board-section .file-box i{ color:var(--sf-accent); }
.board-section .file-box a{ text-decoration:none; }
.board-section .file-box a:hover{ text-decoration:underline; }
.board-section .file-box:hover{ background:#f3f7f9; }

/* 이전/다음 줄 톤 다운 + 화살표 */
.board-article .prevnext a{ position:relative; padding-left:16px; }
.board-article .prevnext a::before{
  content:"›"; position:absolute; left:0; top:50%; transform:translateY(-50%);
  color:var(--sf-accent); font-size:1.1rem;
}

/* 이 페이지 안에서만 버튼 톤 업 (전역 영향 X) */
.board-section .btn-default{
  background:var(--sf-accent); color:#fff; border:0;
  padding:.5rem 1rem; border-radius:.5rem;
  box-shadow:0 6px 14px rgba(47,133,90,.15);
}
.board-section .btn-default:hover{ filter:brightness(.96); }
</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/noticeTitle.webp);">
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
				<form>
				<h2>공지사항</h2>
				<div class="article-card p-4 p-md-5 mb-4">
					<div class="pb-2">
						<span class="small-title">상세내용</span>
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
									<p class="text-secondary mb-1 p-1"></p>
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
</form>
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