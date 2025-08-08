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
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="section bg-light">
		<div class="container">

			<div class="row justify-content-center" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					<div class="bg-white box-shadow mt-5 mb-5 p-5">
	                    <h3 class="text-center pt-3 text-danger"><i class="bi bi-exclamation-triangle"></i> 경고 !</h3>

	                    <div class="my-5">
	                    	<div class="text-center">
								<p class="mb-1"><strong>해당 정보를 접근 할 수 있는 권한 이 없습니다.</strong></p>
								<p>메인화면으로 이동하시기 바랍니다.</p>
	                    	</div>
	                    </div>
	                    
	                    <div>
							<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/';">
		                        메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
		                    </button>	                    
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