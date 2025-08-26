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
<style type="text/css">
/* 전체 배경 */
/* 전체 배경 */
body {
    background-color: #f8f9fa; /* 밝은 회색 배경 */
    color: #333; /* 어두운 기본 글자색 */
    font-family: 'Noto Sans KR', sans-serif;
}

/* 메시지 박스를 화면 중앙에 위치시키기 위한 컨테이너 */
.message-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 80vh;
}

/* 메시지 박스 스타일 */
.content-box {
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 15px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
    padding: 40px;
    color: #333;
}

/* 제목(h3) 스타일 */
.content-box h3 {
    color: #16a085;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 구분선 스타일 */
.title-divider {
    border-color: #16a085;
}

/* 메시지 텍스트 스타일 */
.message-text {
    font-size: 1.1rem;
}

/* 메인 버튼 스타일 */
.btn-main {
    background-color: #16a085;
    color: #fff;
    border: none;
    border-radius: 10px;
    font-size: 18px;
    padding: 12px;
    transition: all 0.3s ease-in-out;
}

.btn-main:hover {
    background-color: #13856b;
    transform: translateY(-2px); /* 살짝 떠오르는 효과 */
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="container message-container">
		<div class="col-md-6">
			<div class="content-box text-center">
				
				<h3>
                    <i class="${not empty iconClass ? iconClass : 'bi bi-info-circle'} me-2"></i>
                    <c:out value="${title}"/>
                </h3>
				<hr class="mt-4 mb-4 title-divider">
				
				<p class="mb-5 message-text">
                    <c:out value="${message}" escapeXml="false"/>
                </p>
                
                <c:url value="${not empty redirectUrl ? redirectUrl : '/'}" var="destinationUrl"/>
				<button type="button" class="btn-main w-100" onclick="location.href='${destinationUrl}';">
					<c:out value="${not empty buttonLabel ? buttonLabel : '메인화면'}"/> <i class="bi bi-check2"></i>
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