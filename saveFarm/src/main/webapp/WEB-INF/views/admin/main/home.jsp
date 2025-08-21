<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper">
<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
<main role="main" class="main-content">
		<div class="container-fluid">
			<div class="row justify-content-center">
				<div class="col-12">
					메인화면입니다
	
				</div>
			</div>				
		</div>
	</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>