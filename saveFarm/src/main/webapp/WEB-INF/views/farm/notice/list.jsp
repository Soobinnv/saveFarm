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

	<section id="comment-form" class="comment-form section mt-5">
		<div class="container">
			<div class="row g-2 align-items-end mb-3">
				<div class="col-md-7">
					<span class="small text-muted">
						총 <strong>${dataCount}</strong>건
						<c:if test="${totalPage > 0}"> _ <strong>${page}</strong> / ${totalPage} 페이지</c:if>
					</span>
				</div>
				
				<div class="col-md-5">
				  <div class="d-flex justify-content-end align-items-center gap-2">
				    <label for="categoryNum" class="form-label mb-0">카테고리</label>
				    <select id="categoryNum" name="categoryNum" class="form-select" style="max-width: 220px;">
				      <c:forEach var="cg" items="${categoryList}">
				        <option value="${cg.categoryNum}" ${cg.categoryNum == categoryNum ? 'selected' : ''}>
				          ${cg.categoryName}
				        </option>
				      </c:forEach>
				    </select>
				  </div>
				</div>
				
				<form name="searchForm" method="get" action="${pageContext.request.contextPath}/farm/notice/list" class="mb-3">
				  <input type="hidden" name="page" value="${page}" />
				  <input type="hidden" name="size" value="${size}" />
				  <input type="hidden" name="categoryNum" value="${categoryNum}" />
				
				<table class="table datatables" id="dataTable-1">
				  <thead>
				    <tr>
				      <th class="text-center">번호</th>
				      <th class="text-center">제목</th>
				      <th class="text-center">작성일</th>
				      <th class="text-center">조회수</th>
				      <th class="text-center">첨부파일개수</th>
				      <th class="text-center">첨부</th>
				    </tr>
				  </thead>
				  <tbody>
				    <c:forEach var="dto" items="${list}" varStatus="status">
				      <tr>
				        <td class="text-center">${dataCount - (page - 1) * size - status.index}</td>
				        <td class="text-center">
				        	<c:url var="articleUrl" value="/farm/notice/article/${dto.noticeNum}">
							  <c:param name="categoryNum" value="${categoryNum}" />
							  <c:param name="page" value="${page}" />
							  <c:param name="schType" value="${schType}" />
							  <c:param name="kwd" value="${kwd}" />
							</c:url>
				          <a href="${articleUrl}">${dto.subject}</a>
				        </td>
				        <td class="text-center"><fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd"/></td>
				        <td class="text-center">${dto.hitCount}</td>
				        <td class="text-center">
				        	<c:choose>
				        		<c:when test="${dto.fileCount != 0}">
				        			${dto.fileCount} 개
				        		</c:when>
				        		<c:when test="${dto.fileCount == 0}">
				        			-
				        		</c:when>
				        	</c:choose>
				        </td>
				        <td class="text-center">
							<c:if test="${dto.fileCount != 0}">
	                           	<a href="${pageContext.request.contextPath}/farm/notice/zipdownload/${dto.noticeNum}" class="text-reset"> <i class="bi bi-download" style="font-size:18px;"></i></a>
							</c:if>
                        </td>
				      </tr>
				    </c:forEach>
				  </tbody>
				</table>
				
				<div class="page-navigation d-flex justify-content-center my-3">
				  ${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
				</div>
				
				<div class="row mt-3">
				  <div class="col-md-3">
				    <button type="button" class="btn-default"
				            onclick="location.href='${pageContext.request.contextPath}/farm/notice/list'"
				            title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
				  </div>
				  <div class="col-md-6 text-center">
				    <select name="schType">
				      <option value="all"      ${schType == 'all'      ? 'selected' : ''}>제목+내용</option>
				      <option value="reg_date" ${schType == 'reg_date' ? 'selected' : ''}>작성일</option>
				      <option value="subject"  ${schType == 'subject'  ? 'selected' : ''}>제목</option>
				      <option value="content"  ${schType == 'content'  ? 'selected' : ''}>내용</option>
				    </select>
				    <input type="text" name="kwd" value="${kwd}">
				    <button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
				  </div>
				</div>
				</form>
			</div>
		</div>
	</section><!-- /Comment Form Section -->
    
</main>


<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
function buildSearchParams() {
  const f = document.forms['searchForm'];
  const params = new URLSearchParams(new FormData(f));

  // 폼 밖 검색 UI
  const schSel = document.querySelector('select[name="schType"]');
  const kwdEl  = document.querySelector('input[name="kwd"]');
  const catSel = document.getElementById('categoryNum');

  if (schSel) params.set('schType', schSel.value || 'all');
  if (kwdEl)  params.set('kwd', (kwdEl.value || '').trim());
  if (catSel) params.set('categoryNum', catSel.value);

  return { f, params };
}

function searchList() {
  const { f, params } = buildSearchParams();
  params.delete('page'); // 새 검색은 1페이지부터
  location.href = f.action + '?' + params.toString();
}

// 카테고리 변경 시 재조회
document.getElementById('categoryNum')?.addEventListener('change', () => {
  const { f, params } = buildSearchParams();
  params.delete('page');
  location.href = f.action + '?' + params.toString();
});

// 엔터키 검색
document.querySelector('input[name="kwd"]')?.addEventListener('keydown', (e) => {
  if (e.key === 'Enter') { e.preventDefault(); searchList(); }
});
</script>
</body>
</html>