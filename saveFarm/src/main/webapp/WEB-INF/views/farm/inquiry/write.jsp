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
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>1:1 문의</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">

					<div class="pb-2">
						<span class="small-title">${mode=='update' ? '문의 수정' : '문의 등록'}</span>
					</div>
				
					<form name="postForm" action="" method="post">
						<table class="table write-form">
							<tr>
								<td class="col-md-2 bg-light">구 분</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<select name="category" class="form-select">
												<option value="강좌" ${dto.category=="강좌"?"selected":"" }>강좌</option>
												<option value="결제문의" ${dto.category=="결제문의"?"selected":"" }>결제문의</option>
												<option value="회원가입" ${dto.category=="회원가입"?"selected":"" }>회원가입</option>
												<option value="기타문의" ${dto.category=="기타문의"?"selected":"" }>기타문의</option>
											</select>
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">제 목</td>
								<td>
									<input type="text" name="subject" class="form-control" maxlength="100" placeholder="Subject" value="${dto.subject}">
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이 름</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.member.name}">
										</div>
									</div>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">내 용</td>
								<td>
									<textarea name="question" class="form-control" placeholder="Question">${dto.question}</textarea>
								</td>
							</tr>
						</table>
						
						<div class="text-center">
							<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/inquiry/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>						
					</form>

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

	str = f.question.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.question.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/inquiry/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>