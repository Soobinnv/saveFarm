<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>hShop</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style>
	/* 전체 배경 초록색 */
	body {
		background: linear-gradient(135deg, #1abc9c, #16a085);
		color: #fff;
		font-family: 'Noto Sans KR', sans-serif;
	}

	/* 박스 스타일 */
	.content-box {
		background-color: rgba(255, 255, 255, 0.95);
		border-radius: 15px;
		box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
		padding: 40px;
		color: #333;
	}

	h3 {
		color: #16a085;
		font-weight: bold;
	}

	.btn-main {
		background-color: #16a085;
		color: #fff;
		border: none;
		border-radius: 10px;
		font-size: 18px;
		padding: 12px;
		transition: 0.3s;
	}
	.btn-main:hover {
		background-color: #13856b;
		transform: scale(1.03);
	}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
		<div class="col-md-6">
			<div class="content-box text-center">
				<h3>${title}</h3>
				<hr class="mt-4 mb-4" style="border-color:#16a085;">
				
				<p class="mb-5">${message}</p>
                
				<button type="button" class="btn-main w-100" onclick="location.href='${pageContext.request.contextPath}/';">
					메인화면 <i class="bi bi-check2"></i>
				</button>
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
