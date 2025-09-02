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

<style>
    body {
        background-color: #fff;
    }
    main {
        min-height: calc(100vh - 160px); /* 헤더, 푸터 높이를 제외한 최소 높이 */
    }
    
    /* 로그인 버튼 스타일 재사용 */
    .btn-login {
        background-color: #039a63;
        color: #fff;
        border: 1px solid #039a63;
    }
    .btn-login:hover {
        background-color: #03c27c;
        color: #fff;
    }

    /* 회원가입 버튼 스타일 재사용 */
    .btn-signup {
        background-color: #fff;
        color: #039a63;
        border: 1px solid #039a63;
    }
    .btn-signup:hover {
        color: #212121;
        border: 1px solid #039a63;
    }
    
    /* 성공 아이콘 색상 */
    .text-success {
        color: #039a63 !important;
    }
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="d-flex align-items-center py-5 mt-5">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-5 mt-5">
				
				<div class="card border-0">
					<div class="card-body text-center p-4 p-md-5">
						
						<%-- 성공 아이콘 --%>
						<div class="mb-4">
							<svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-check-circle-fill text-success" viewBox="0 0 16 16">
							  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
							</svg>
						</div>

						<h2 class="fw-bold mb-3">회원가입을 축하합니다!</h2>
						<p class="lead mb-4">
							회원가입이 성공적으로 완료되었습니다.
						</p>
						<p class="text-muted">
							로그인 후 모든 서비스를 이용하실 수 있습니다.
						</p>

						<%-- 하단 버튼 --%>
						<div class="d-grid gap-2 col-10 mx-auto mt-5">
							<a href="${pageContext.request.contextPath}/member/login" class="btn btn-lg btn-login">로그인 하러 가기</a>
							<a href="${pageContext.request.contextPath}/" class="btn btn-lg btn-signup">메인으로 가기</a>
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