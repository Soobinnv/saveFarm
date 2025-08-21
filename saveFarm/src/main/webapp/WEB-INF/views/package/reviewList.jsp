<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>구독 리뷰</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style>
  :root{ --ink:#1f2937; --muted:#6b7280; --border:#e6efe9; --primary:#18a05b; }
  *{ box-sizing: border-box }
  body{ margin:0; padding:40px 16px; background:#f6faf8; color:var(--ink); font-family:"Pretendard","Noto Sans KR",sans-serif }
  .wrap{ max-width:1100px; margin:0 auto }
  .heading{
    text-align:center; margin:10px 0 28px;
  }
  .heading .pill{
    display:inline-block; padding:12px 24px; border-radius:999px; background:#ffd6cc; color:#7a4b44; font-weight:700;
  }

  /* GRID (3 x 3) */
  .grid{ display:grid; grid-template-columns:repeat(3, minmax(0,1fr)); gap:22px; }
  @media (max-width:900px){ .grid{ grid-template-columns:repeat(2, minmax(0,1fr)); } }
  @media (max-width:560px){ .grid{ grid-template-columns:1fr; } }

  /* CARD */
  .card{ background:#fff; border:2px solid var(--border); border-radius:14px; overflow:hidden; box-shadow:0 6px 16px rgba(17,24,39,.05); display:flex; flex-direction:column }
  .thumb{ width:100%; aspect-ratio: 4/3; object-fit:cover; display:block }
  .meta{ padding:12px 14px 4px; color:var(--muted); font-size:13px }
  .title{ padding:0 14px; font-weight:800; font-size:16px; line-height:1.4; margin:6px 0 6px; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical }
  .excerpt{ padding:0 14px 12px; color:var(--muted); font-size:13px; line-height:1.5; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical }
  .foot{ padding:12px 14px 14px; display:flex; justify-content:space-between; align-items:center; border-top:1px solid var(--border) }
  .stars{ font-size:14px; letter-spacing:1px }
  .stars .on{ color:#f4b400 }
  .btn-view{ font-size:13px; padding:8px 12px; border-radius:10px; border:1px solid var(--border); background:#fff; cursor:pointer }
  .btn-view:hover{ border-color:#d7e7de }

  /* 하단 영역 */
  .actions{ display:flex; justify-content:center; margin-top:26px }
  .btn-write{
    background:var(--primary); color:#fff; border:none; border-radius:999px; padding:12px 18px; font-weight:800; cursor:pointer;
  }

  /* 페이징 */
  .paging{ margin:28px 0 6px; display:flex; gap:6px; justify-content:center; align-items:center; flex-wrap:wrap }
  .paging a, .paging span{
    min-width:36px; height:36px; display:inline-flex; justify-content:center; align-items:center;
    padding:0 10px; border-radius:10px; border:1px solid var(--border); background:#fff; color:var(--ink); text-decoration:none; font-size:14px;
  }
  .paging .active{ background:var(--primary); color:#fff; border-color:var(--primary) }
  .paging .disabled{ opacity:.5; pointer-events:none }
</style>
</head>
<body>

<div class="wrap">
  <div class="heading">
    <div class="pill">우리 농가를 구하는 구독자님들의 소중한 후기</div>
  </div>

  <!-- 3x3 GRID -->
  <div class="grid">
    <c:forEach var="r" items="${list}">
      <div class="card">
        <!-- 대표이미지: 없으면 플레이스홀더 -->
        <c:set var="thumb" value="${empty r.imageFilename ? '/resources/img/no-image.png' : '/uploads/review/' += r.imageFilename}" />
        <img class="thumb" src="${pageContext.request.contextPath}${thumb}" alt="${r.subject}">

        <div class="meta">
          <c:choose>
            <c:when test="${not empty r.regDate}">${r.regDate}</c:when>
            <c:otherwise><fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/></c:otherwise>
          </c:choose>
          · 구독번호 ${r.subNum}
        </div>

        <div class="title">${r.subject}</div>
        <div class="excerpt">${r.content}</div>

        <div class="foot">
          <!-- 별점 -->
          <div class="stars">
            <c:forEach begin="1" end="5" var="i">
              <span class="${i <= r.star ? 'on':''}">★</span>
            </c:forEach>
          </div>

          <!-- 상세로 이동(원하는 URL로 변경) -->
          <a class="btn-view" href="${pageContext.request.contextPath}/sub/review/detail?subNum=${r.subNum}">자세히</a>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- 페이징 -->
  <c:choose>
    <!-- 컨트롤러에서 paging HTML을 이미 만들어줬다면 그대로 출력 -->
    <c:when test="${not empty paging}">
      <div class="paging">${paging}</div>
    </c:when>

    <!-- 직접 페이지 번호를 그릴 때: page, total_page, size 필요 -->
    <c:otherwise>
      <c:set var="cp" value="${pageContext.request.contextPath}"/>
      <c:set var="baseUrl" value="${cp}/sub/review/list?size=${size}"/>
      <div class="paging">
        <c:set var="prevPage" value="${page-1}"/>
        <a class="${page==1?'disabled':''}" href="${baseUrl}&page=${prevPage}">이전</a>

        <!-- 간단한 5개 창구 페이징 -->
        <c:set var="start" value="${page-2 < 1 ? 1 : page-2}"/>
        <c:set var="end" value="${start+4 > total_page ? total_page : start+4}"/>
        <c:forEach begin="${start}" end="${end}" var="p">
          <c:choose>
            <c:when test="${p==page}">
              <span class="active">${p}</span>
            </c:when>
            <c:otherwise>
              <a href="${baseUrl}&page=${p}">${p}</a>
            </c:otherwise>
          </c:choose>
        </c:forEach>

        <c:set var="nextPage" value="${page+1}"/>
        <a class="${page==total_page?'disabled':''}" href="${baseUrl}&page=${nextPage}">다음</a>
      </div>
    </c:otherwise>
  </c:choose>

  <!-- 작성 버튼 -->
  <div class="actions">
    <a class="btn-write" href="${pageContext.request.contextPath}/sub/review/write">후기 작성</a>
  </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>
