<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/notice.css" type="text/css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
  <!-- Title -->
  <section class="page-title">
    <div class="wrap">
      <h1>공지사항</h1>
    </div>
  </section>

  <!-- Board -->
  <section class="wrap">
    <div class="board-card">

      <div class="board-head">
        <div>
          <span class="small-title">글목록</span>
          <span class="dataCount">${dataCount}개&nbsp;(${page}/${total_page} 페이지)</span>
        </div>
        <div><!-- (우측 공간 비움: 향후 버튼 추가 시 사용) --></div>
      </div>

      <table class="table">
        <thead>
          <tr>
            <th class="col-num">번호</th>
            <th class="col-subject">제목</th>
            <th class="col-name">글쓴이</th>
            <th class="col-date">작성일</th>
            <th class="col-hit">조회수</th>
            <th class="col-file">첨부</th>
          </tr>
        </thead>
        <tbody>
          <!-- 고정 공지 (1페이지에서만) -->
          <c:forEach var="dto" items="${noticeList}">
            <tr>
              <td class="col-num"><span class="badge-notice">공지</span></td>
              <td class="col-subject">
                <c:url var="url" value="/notice/article/${dto.noticeNum}">
                  <c:param name="page" value="${page}"/>
                  <c:if test="${not empty kwd}">
                    <c:param name="schType" value="${schType}"/>
                    <c:param name="kwd" value="${kwd}"/>
                  </c:if>
                </c:url>
                <div class="text-wrap"><a class="link" href="${url}">${dto.subject}</a></div>
              </td>
              <td class="col-name">관리자</td>
              <td class="col-date">${dto.updateDate}</td>
              <td class="col-hit">${dto.hitCount}</td>
              <td class="col-file">
                <c:if test="${dto.fileCount != 0}">
                  <a class="link" href="${pageContext.request.contextPath}/notice/zipdownload/${dto.noticeNum}" title="첨부파일 일괄 다운로드">ZIP</a>
                </c:if>
              </td>
            </tr>
          </c:forEach>

          <!-- 일반 목록 -->
          <c:forEach var="dto" items="${list}" varStatus="status">
            <tr>
              <td class="col-num">${dataCount - (page-1) * size - status.index}</td>
              <td class="col-subject">
                <c:url var="url" value="/notice/article/${dto.noticeNum}">
                  <c:param name="page" value="${page}"/>
                  <c:if test="${not empty kwd}">
                    <c:param name="schType" value="${schType}"/>
                    <c:param name="kwd" value="${kwd}"/>
                  </c:if>
                </c:url>
                <div class="text-wrap">
                  <a class="link" href="${url}">${dto.subject}</a>
                  <c:if test="${dto.gap < 10}">
                    <span class="badge-new">NEW</span>
                  </c:if>
                </div>
              </td>
              <td class="col-name">관리자</td>
              <td class="col-date">${dto.updateDate}</td>
              <td class="col-hit">${dto.hitCount}</td>
              <td class="col-file">
                <c:if test="${dto.fileCount != 0}">
                  <a class="link" href="${pageContext.request.contextPath}/notice/zipdownload/${dto.noticeNum}" title="첨부파일 일괄 다운로드">ZIP</a>
                </c:if>
              </td>
            </tr>
          </c:forEach>

          <!-- 비어있을 때 -->
          <c:if test="${dataCount == 0}">
            <tr>
              <td colspan="6"><div class="empty">등록된 게시물이 없습니다.</div></td>
            </tr>
          </c:if>
        </tbody>
      </table>

      <!-- Pager -->
      <div class="page-navigation">
        ${dataCount == 0 ? "" : paging}
      </div>

      <!-- Actions -->
      <div class="row mt-3 space-between">
        <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/notice/list';" title="새로고침">새로고침</button>

        <form name="searchForm" class="searchbar">
          <select name="schType">
            <option value="all"     ${schType=="all"?"selected":""}>제목+내용</option>
            <option value="regDate" ${schType=="regDate"?"selected":""}>작성일</option>
            <option value="subject" ${schType=="subject"?"selected":""}>제목</option>
            <option value="content" ${schType=="content"?"selected":""}>내용</option>
          </select>
          <input type="text" name="kwd" value="${kwd}" placeholder="검색어를 입력하세요" />
          <button type="button" class="btn" onclick="searchList();" title="검색">검색</button>
        </form>

        <span></span>
      </div>

    </div>
  </section>
</main>

<script>
  // Enter로 검색
  window.addEventListener('DOMContentLoaded', () => {
    const input = document.querySelector('form[name=searchForm] input[name=kwd]');
    if (input) {
      input.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
          e.preventDefault();
          searchList();
        }
      });
    }
  });

  function searchList() {
    const f = document.searchForm;
    if(!f.kwd.value.trim()) return;

    const formData = new FormData(f);
    const params = new URLSearchParams(formData).toString();
    location.href = '${pageContext.request.contextPath}/notice/list?' + params;
  }
</script>




<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>


</body>
</html>