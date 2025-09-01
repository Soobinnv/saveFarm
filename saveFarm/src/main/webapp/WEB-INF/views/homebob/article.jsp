<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세이브팜</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/vendor/glightbox/css/glightbox.min.css" type="text/css">

<style type="text/css">
.photo-section img { transition: 0.3s; cursor: pointer; }
.photo-section img:hover { transform: scale(1.03); }
main {
    padding-top: 100px; /* 헤더의 높이(예시 100px)에 맞춰 조정 */
}
</style>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center">
			<h1>나의 음식일기</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">

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
									작성자 : ${dto.name}
								</td>
								<td width="50%" class="text-end">
									작성일 : ${dto.regDate}
								</td>
							</tr>
							
							<tr>
								<td colspan="2" valign="top" height="200" style="border-bottom:none;">
									${dto.content}
								</td>
							</tr>

							<tr>
								<td colspan="2">
									<div class="row row-cols-6 g-3 photo-section">
										<c:forEach var="vo" items="${listFile}">
											<div class="col p-1">
												<img src="${pageContext.request.contextPath}/uploads/homebob/${vo.imageFilename}" class="glightbox img-fluid border rounded" style="width:100%; height: 130px;">
											</div>
										</c:forEach>
									</div>
								</td>
							</tr>

							<tr>
								<td colspan="2">
									이전글 : 
									<c:if test="${not empty prevDto}">
										<a href="${pageContext.request.contextPath}/homebob/article?${query}&num=${prevDto.num}">${prevDto.subject}</a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									다음글 : 
									<c:if test="${not empty nextDto}">
										<a href="${pageContext.request.contextPath}/homebob/article?${query}&num=${nextDto.num}">${nextDto.subject}</a>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>

					<div class="row mb-2">
						<div class="col-md-6 align-self-center">
							<c:if test="${dto.memberId == info.memberId}">
								<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/homebob/update?num=${dto.num}&page=${page}';">수정</button>
								<button type="button" class="btn-default" onclick="deleteOk();">삭제</button>
							</c:if>
						</div>
						<div class="col-md-6 align-self-center text-end">
							<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/homebob/list?${query}';">리스트</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</main>

<script src="${pageContext.request.contextPath}/dist/vendor/glightbox/js/glightbox.min.js"></script>
<script type="text/javascript">
// Initiate glightbox
const glightbox = GLightbox({
  selector: '.glightbox'
});

function deleteOk() {
    if(confirm('게시글을 삭제 하시 겠습니까 ? ')) {
	    let params = 'num=${dto.num}&${query}';
	    let url = '${pageContext.request.contextPath}/homebob/delete?' + params;
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