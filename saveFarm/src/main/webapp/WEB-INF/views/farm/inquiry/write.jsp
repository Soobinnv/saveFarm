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
:root{ --sf-accent:#2f855a; } /* 페이지 포인트 컬러 */

/* ====== 공통: 상단 라벨 ====== */
.sf-eyebrow{
  font-size:1.8rem;   /* ★ 글씨 크기 키움 */
  font-weight:700;
  color:#222;
  letter-spacing:-.01em;
  margin-bottom:1rem;
}
.sf-eyebrow::first-letter{
  color: var(--sf-accent);  /* 초록 포인트 */
  font-size:2.0rem;         /* | 기호 조금 더 크게 */
}

/* ====== 상세 페이지 카드 ====== */
.article-card{
  position:relative;              /* ★추가: 내부 바 포지셔닝용 */
  overflow:hidden;                /* ★추가: 바 모서리 자연스럽게 */
  border:1px solid rgba(0,0,0,.12);
  border-radius:12px;
  box-shadow:0 8px 24px rgba(0,0,0,.06);
  background:#fff;
  padding-top:2.25rem;            /* ★추가: 카드 top과 바 사이 살짝 여백 확보 */
}
/* ★수정: 바를 카드 ‘안쪽’에 위치시키고, 카드 윗부분이 바보다 위에 오도록 */
.article-card::before{
  content:"";
  position:absolute;              /* ★변경: block→absolute */
  left:16px; right:16px;          /* ★추가: 좌우 안쪽으로 살짝 인셋 */
  top:10px;                       /* ★추가: 카드 윗선보다 ‘조금’ 아래에서 시작 */
  height:4px;
  background:linear-gradient(90deg,var(--sf-accent),#55b59a);
  border-radius:999px;
}

/* ====== 등록/수정 페이지 카드 ====== */
.form-card{
  position:relative;              /* ★추가 */
  overflow:hidden;                /* ★추가 */
  border:1px solid rgba(0,0,0,.12);
  border-radius:12px;
  box-shadow:0 8px 24px rgba(0,0,0,.06);
  background:#fff;
  padding:1.5rem;
  padding-top:2.25rem;            /* ★추가: 상세와 동일하게 윗여백 */
}
/* ★수정: 바를 카드 ‘안쪽’에, 윗선보다 조금 아래 */
.form-card::before{
  content:"";
  position:absolute;              /* ★변경 */
  left:16px; right:16px;          /* ★추가 */
  top:10px;                       /* ★추가 */
  height:4px;
  background:linear-gradient(90deg,var(--sf-accent),#55b59a);
  border-radius:999px;
}

/* ====== 소제목 라벨/표/버튼 기존 정의 유지 ====== */
.board-section .sm-title,
.small-title{ display:inline-block; font-weight:700; letter-spacing:-.02em; padding:.25rem .5rem; border-left:4px solid var(--sf-accent); }

.board-article thead td{ font-size:1.1rem; font-weight:600; padding:1rem; }
.board-article tbody td{ padding:.9rem 1rem; vertical-align:middle; }
.board-article tbody tr+tr td{ border-top:1px dashed rgba(0,0,0,.08); }
.board-article .article-content{ line-height:1.8; font-size:1.05rem; }

.board-section .bg-light{ background:#f6f7f9 !important; }
.mh-px-150{ min-height:150px; }

.board-section .btn-default{
  background:var(--sf-accent); color:#fff; border:0;
  padding:.5rem 1rem; border-radius:.5rem;
  box-shadow:0 6px 14px rgba(47,133,90,.15);
}
.board-section .btn-default:hover{ filter:brightness(.96); }

.write-form td{ vertical-align:middle; }
.write-form .bg-light{ background:#f6f7f9 !important; }
.write-form input[type="text"], .write-form textarea{ border-radius:.5rem; }
.write-form textarea{ min-height:200px; }

.btn-accent{
  background:var(--sf-accent); color:#fff; border:0;
  padding:.5rem 1rem; border-radius:.5rem;
  box-shadow:0 6px 14px rgba(47,133,90,.15);
}
.btn-accent:hover{ filter:brightness(.96); }
.btn-default{
  background:#eef3ef; color:#2b5240; border:1px solid rgba(0,0,0,.06);
  padding:.5rem 1rem; border-radius:.5rem;
}
.btn-default:hover{ filter:brightness(.98); }

</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/inquiryTitle2.webp);">
      <div class="container position-relative">
        <h1>1:1 문의</h1>
        <p>작성해주신 문의 내용에 대해 신속히 답변드리겠습니다.</p>
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
				<div class="col-md-10 board-section my-4 p-5">
				
					<div class="sf-eyebrow mb-2">| 1:1 문의</div>
				
					<div class="form-card p-4">
					<div class="pb-2">
						<span class="small-title">${mode=='update' ? '문의 수정' : '문의 등록'}</span>
					</div>
				
					<form name="postForm" action="" method="post">
						<table class="table write-form">
							<tr>
								<td class="col-md-2 bg-light text-center">문의 제목</td>
								<td>
									<input type="text" name="subject" class="form-control" maxlength="100" placeholder="Subject" value="${dto.subject}">
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light text-center">농가 이름</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.farm.farmName}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light text-center">내 용</td>
								<td>
									<textarea name="content" class="form-control" placeholder="Question">${dto.content}</textarea>
								</td>
							</tr>
						</table>
						
						<div class="text-center">
							<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/farm/inquiry/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.inquiryNum}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>						
					</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
function sendOk() {
	const f = document.postForm;
	let str;
	
	str = f.subject.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.subject.focus();
		return;
	}

	str = f.content.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.question.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/farm/inquiry/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

</body>
</html>