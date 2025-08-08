<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle1.css"
	type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle2.css"
	type="text/css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

</body>
</html>