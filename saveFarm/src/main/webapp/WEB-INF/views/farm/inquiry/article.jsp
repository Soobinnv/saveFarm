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

					<div class="row p-2">
						<div class="col-md-12 ps-0 pb-1">
							<span class="sm-title fw-bold">문의사항</span>
						</div>

					
						<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
							제 목
						</div>
						<div class="col-md-10  border-top border-bottom p-2">
							${dto.subject}
						</div>

						<div class="col-md-2 text-center bg-light border-bottom p-2">
							카테고리
						</div>
						<div class="col-md-4 border-bottom p-2">
							${dto.category}
						</div>
						<div class="col-md-2 text-center bg-light border-bottom p-2">
							이 름
						</div>
						<div class="col-md-4 border-bottom p-2">
							${dto.name}
						</div>

						<div class="col-md-2 text-center bg-light border-bottom p-2">
							문의일자
						</div>
						<div class="col-md-4 border-bottom p-2">
							${dto.reg_date}
						</div>
						<div class="col-md-2 text-center bg-light border-bottom p-2">
							처리결과
						</div>
						<div class="col-md-4 border-bottom p-2">
							${(empty dto.answer_date)?"답변대기":"답변완료"}
						</div>
					
						<div class="col-md-12 border-bottom mh-px-150">
							<div class="row h-100">
								<div class="col-md-2 text-center bg-light p-2 h-100 d-none d-md-block">
									내 용
								</div>
								<div class="col-md-10 p-2 h-100">
									${dto.question}
								</div>
							</div>
						</div>
					
						<c:if test="${not empty dto.answer}">
							<div class="col-md-12 ps-0 pt-3 pb-1">
								<span class="sm-title fw-bold">답변내용</span>
							</div>

							<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
								담당자
							</div>
							<div class="col-md-4 border-top border-bottom p-2">
								관리자
							</div>
							<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
								답변일자
							</div>
							<div class="col-md-4 border-top border-bottom p-2">
								${dto.answer_date}
							</div>
							
							<div class="col-md-12 border-bottom mh-px-150">
								<div class="row h-100">
									<div class="col-md-2 text-center bg-light p-2 h-100 d-none d-md-block">
										답 변
									</div>
									<div class="col-md-10 p-2 h-100">
										${dto.answer}
									</div>
								</div>
							</div>
						</c:if>
					</div>

					<div class="row py-2 mb-2">
						<div class="col-md-6 align-self-center">
							<button type="button" class="btn-default" onclick="deleteOk();">질문삭제</button>
						</div>
						<div class="col-md-6 align-self-center text-end">
							<c:if test="${empty prevDto}">
								<button type="button" class="btn-default" disabled>이전글</button>
							</c:if>
							<c:if test="${not empty prevDto}">
								<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/inquiry/article?${query}&num=${prevDto.num}';">이전글</button>
							</c:if>
							<c:if test="${empty nextDto}">
								<button type="button" class="btn-default" disabled>다음글</button>
							</c:if>
							<c:if test="${not empty nextDto}">
								<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/inquiry/article?${query}&num=${nextDto.num}';">다음글</button>
							</c:if>

							<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/inquiry/list?${query}';">리스트</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
function deleteOk() {
	if(confirm('문의를 삭제 하시겠습니까 ?')) {
		let params = 'num=${dto.num}&${query}';
		let url = '${pageContext.request.contextPath}/inquiry/delete?' + params;
		location.href = url;
	}
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>