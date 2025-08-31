<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>1:1 문의 ${mode == "update" ? "수정" : "작성"}</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<%-- Controller에서 사용하는 URL 인코딩/디코딩을 위해 JSTL Functions 태그 라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
/* ==========================================================================
   디자인 시스템 (기존 코드 기반)
   ========================================================================== */
:root{
  --bg:#f8fafc; --card:#ffffff; --ink:#111827; --muted:#6b7280; --line:#e5e7eb;
  --brand:#10b981; --brand-dark:#059669; --brand-soft:#ecfdf5;
}
.page-title{ display:none !important; }
body{ background:var(--bg) !important; color:var(--ink) !important; }
.container{ max-width:1140px !important; }
.board-section{
  background:var(--card) !important; border:1px solid var(--line) !important; border-radius:16px !important;
  box-shadow:0 8px 24px rgba(0,0,0,.05) !important; padding:24px !important; margin-top:16px !important;
}
.btn-default{
  background:var(--brand) !important; color:#fff !important; border:1px solid var(--brand) !important;
  padding:9px 16px !important; border-radius:10px !important; font-weight:700 !important; cursor:pointer !important;
  transition:background-color .12s ease, filter .12s ease !important; box-shadow:none !important;
}
.btn-default:hover,.btn-default:focus{
  background:var(--brand-dark) !important; border-color:var(--brand-dark) !important; filter:brightness(1.02) !important;
}
.btn-secondary {
  background:#f1f5f9 !important; color:#334155 !important; border:1px solid #e2e8f0 !important;
}
.btn-secondary:hover,.btn-secondary:focus {
  background:#e2e8f0 !important; border-color:#cbd5e1 !important;
}

/* ==========================================================================
   문의 작성 폼 스타일
   ========================================================================== */
.container{
	margin-top: 100px;
}   
   
.qna-form-table {
  width:100%; border-collapse: separate; border-spacing: 0;
  border:1px solid var(--line); border-radius:12px;
}
.qna-form-table td {
  padding:12px 14px; vertical-align:middle; background:#fff;
  border-bottom:1px solid var(--line);
}
.qna-form-table tr:last-child td { border-bottom:none; }
.qna-form-table .form-label{
  background:#fafafa; font-weight:700; text-align:center;
  width:130px; color:#374151; border-right:1px solid var(--line);
}
.form-control{
  width:100%; border:1px solid #d1d5db; border-radius:8px;
  padding:8px 12px; font-size:16px; box-shadow:none;
  transition:border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}
.form-control:focus{
  border-color:var(--brand); outline:0;
  box-shadow:0 0 0 .2rem rgba(16, 185, 129, .25);
}
.form-control[readonly]{ background-color:#f3f4f6; cursor:not-allowed; }
textarea.form-control{ min-height:200px; resize:vertical; }
.form-buttons { margin-top:20px; text-align:right; display:flex; justify-content:flex-end; gap:8px; }
</style>
</head>
<body>

<header>
  <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-10 board-section">

        <h2 class="small-title mb-3">
          <c:if test="${mode == 'write'}">1:1 문의하기 📝</c:if>
          <c:if test="${mode == 'update'}">1:1 문의 수정 ✍️</c:if>
        </h2>

        <%-- mode에 따라 form의 action 경로를 동적으로 설정 --%>
        <form name="inquiryForm" method="post" action="${pageContext.request.contextPath}/inquiry/${mode}">
          <table class="qna-form-table">
            <tbody>
              <tr>
                <td class="form-label">제목</td>
                <td>
                  <input type="text" name="subject" class="form-control" value="${dto.subject}" placeholder="제목을 입력하세요." required>
                </td>
              </tr>
              <tr>
			    <td class="form-label">작성자</td>
			    <td>
			        <input type="text" name="userName" class="form-control" value="${sessionScope.member.loginId}" readonly>
			    </td>
              <tr>
                <td class="form-label">문의유형</td>
                <td>
                    <select name="category" class="form-control">
                        <option value="일반" ${dto.category=="일반" ? "selected" : "" }>일반</option>
                        <option value="계정" ${dto.category=="계정" ? "selected" : "" }>계정</option>
                        <option value="결제" ${dto.category=="결제" ? "selected" : "" }>결제</option>
                        <option value="기타" ${dto.category=="기타" ? "selected" : "" }>기타</option>
                    </select>
                </td>
              </tr>
              <tr>
                <td class="form-label">내용</td>
                <td>
                  <textarea name="content" class="form-control" placeholder="문의하실 내용을 상세히 작성해주세요." required>${dto.content}</textarea>
                </td>
              </tr>
            </tbody>
          </table>

          <c:if test="${mode == 'update'}">
            <input type="hidden" name="inquiryNum" value="${dto.inquiryNum}">
            <input type="hidden" name="page" value="${page}">
            <input type="hidden" name="schType" value="${schType}">
            <input type="hidden" name="kwd" value="${kwd}">
          </c:if>

          <div class="form-buttons">
            <button type="submit" class="btn-default">${mode == 'update' ? '수정 완료' : '문의 등록'}</button>
          </div>
        </form>

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