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
						<h3 class="text-center pt-3">${title}</h3>
						<hr class="mt-4">
						
						<div class="my-5">
							<div class="text-center">
								<p class="text-center">${message}</p>
							</div>
						</div>
	                    
						<div>
							<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/';">
								메인화면 <i class="bi bi-check2"></i>
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