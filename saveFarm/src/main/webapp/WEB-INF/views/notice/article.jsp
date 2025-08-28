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

<style>
/* ===== 중립 팔레트 ===== */
:root{
  --bg:#f8fafc; --card:#ffffff; --ink:#111827; --muted:#6b7280; --line:#e5e7eb;
  --brand:#10b981; --brand-dark:#059669; --brand-soft:#ecfdf5;
}

/* 페이지 타이틀 전역 숨김 (헤더 가림 이슈 제거) */
.page-title{ display:none !important; }

/* 레이아웃 */
body{ background:var(--bg) !important; color:var(--ink) !important; }
.container{ max-width:1140px !important; }

/* 카드 */
.board-section{
  background:var(--card) !important; border:1px solid var(--line) !important; border-radius:16px !important;
  box-shadow:0 8px 24px rgba(0,0,0,.05) !important; padding:24px !important; margin-top:16px !important;
}

/* 글표 */
.table.board-article{ width:100% !important; border-collapse:separate !important; border-spacing:0 !important; }
.board-article thead td{
  background:var(--brand-soft) !important; border:1px solid var(--line) !important; border-bottom:none !important;
  padding:18px 16px !important; font-weight:700 !important; font-size:20px !important; text-align:center !important;
  border-radius:12px 12px 0 0 !important; color:#0f172a !important;
}
.board-article tbody td{
  border-left:1px solid var(--line) !important; border-right:1px solid var(--line) !important; border-bottom:1px solid var(--line) !important;
  padding:12px 14px !important; vertical-align:middle !important; background:#fff !important;
}
.board-article tbody tr:last-child td{ border-radius:0 0 12px 12px !important; }

/* 메타 */
.article-meta{ color:var(--muted) !important; font-size:14px !important; }

/* 본문: 최소 높이(약 5줄), 여백 타이트 */
.article-content{
  padding:16px 14px !important; line-height:1.75 !important; color:#111827 !important;
  word-break:break-word !important; background:#fff !important;
  min-height:9rem !important;  /* ≈ 144px ≒ 5줄 */
}
.article-content img{ max-width:100% !important; height:auto !important; }

/* 파일영역: 본문과 간격 제거 */
.file-row{ background:#fafafa !important; color:#374151 !important; }
.file-row .border{ margin:0 !important; }
.file-row .border + .border{ margin-top:6px !important; }
.file-row a{ color:#0f766e !important; text-decoration:none !important; }
.file-row a:hover{ text-decoration:underline !important; }

/* 파일 없을 때 */
.no-file{
  padding:10px 12px !important; color:#6b7280 !important;
  background:#f9fafb !important; border:1px dashed var(--line) !important; border-radius:8px !important;
}

/* 이전/다음 링크 */
.nav-row a{ color:#1f2937 !important; text-decoration:none !important; }
.nav-row a:hover{ color:#0f766e !important; text-decoration:underline !important; }

/* 버튼: 테두리=버튼색, 그림자 없이 */
.btn-default{
  background:var(--brand) !important; color:#fff !important; border:1px solid var(--brand) !important;
  padding:9px 14px !important; border-radius:10px !important; font-weight:700 !important; cursor:pointer !important;
  transition:background-color .12s ease, filter .12s ease !important; box-shadow:none !important;
}
.btn-default:hover,.btn-default:focus{
  background:var(--brand-dark) !important; border-color:var(--brand-dark) !important; filter:brightness(1.02) !important;
}
.btn-default:active{ filter:brightness(.96) !important; }

/* 유틸 */
.text-end{ text-align:right !important; }
.border{ border:1px solid var(--line) !important; border-radius:8px !important; }
.mb-1{ margin-bottom:.25rem !important; }
.p-2{ padding:.5rem !important; }
.pb-2{ padding-bottom:.5rem !important; }
</style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
  <!-- Page Title 제거됨 -->

  <div class="section">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-10 board-section">

          <div class="pb-2">
            <span class="small-title">상세정보</span>
          </div>

          <table class="table board-article">
            <thead>
              <tr>
                <td colspan="2" class="text-center">${dto.subject}</td>
              </tr>
            </thead>

            <tbody>
              <tr class="article-meta">
                <td width="50%">작성자 : 관리자</td>
                <td width="50%" class="text-end">작성일 : ${dto.updateDate} &nbsp;|&nbsp; 조회 ${dto.hitCount}</td>
              </tr>

              <tr>
                <td colspan="2" class="article-content" style="border-bottom:none;">
                  ${dto.content}
                </td>
              </tr>

              <!-- 파일 영역: 비어있으면 안내문구 -->
              <tr class="file-row">
                <td colspan="2">
                  <c:choose>
                    <c:when test="${not empty listFile}">
                      <p class="border mb-1 p-2">
                        <i class="bi bi-folder2-open"></i>
                        <c:forEach var="vo" items="${listFile}" varStatus="status">
                          <a href="${pageContext.request.contextPath}/notice/download/${vo.fileNum}">
                            ${vo.originalFilename}
                            (<fmt:formatNumber value="${vo.fileSize}" type="number"/>byte)
                          </a>
                          <c:if test="${not status.last}"> | </c:if>
                        </c:forEach>
                      </p>
                      <p class="border p-2">
                        <i class="bi bi-file-zip"></i>
                        <a href="${pageContext.request.contextPath}/notice/zipdownload/${dto.noticeNum}">파일 전체 압축 다운로드(zip)</a>
                      </p>
                    </c:when>
                    <c:otherwise>
                      <div class="no-file">공지 폴더 없음</div>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>

              <tr class="nav-row">
                <td colspan="2">
                  이전글 :
                  <c:if test="${not empty prevDto}">
                    <a href="${pageContext.request.contextPath}/notice/article/${prevDto.noticeNum}?${query}">${prevDto.subject}</a>
                  </c:if>
                </td>
              </tr>
              <tr class="nav-row">
                <td colspan="2">
                  다음글 :
                  <c:if test="${not empty nextDto}">
                    <a href="${pageContext.request.contextPath}/notice/article/${nextDto.noticeNum}?${query}">${nextDto.subject}</a>
                  </c:if>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="row mb-2">
            <div class="col-md-6">&nbsp;</div>
            <div class="col-md-6 text-end">
              <button type="button" class="btn-default"
                onclick="location.href='${pageContext.request.contextPath}/notice/list?${query}';">리스트</button>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</main>

<footer>
  <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>
