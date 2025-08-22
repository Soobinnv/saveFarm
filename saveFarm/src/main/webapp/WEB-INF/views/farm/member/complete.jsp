<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm</title>
<jsp:include page="/WEB-INF/views/farm/layout/farmHeaderResources.jsp"/>

<style type="text/css">

</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-5" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					<form name = "complete">
							
						<h3 class="text-center pt-3">${title}</h3>
						<hr class="mt-4">
						
						<div class="my-5">
							<div class="text-center">
								<p class="text-center">${message}</p>
							</div>
						</div>
		                   
						<div>
							<c:choose>
								<c:when test="${mode == 'pwdFind'}">
									<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/farm/member/pwdChange';">
										변경하기 <i class="bi bi-check2"></i>
									</button>
									<input type="hidden" name="farmerId">								
								</c:when>
								<c:otherwise>								
									<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/farm';">
										메인화면 <i class="bi bi-check2"></i>
									</button>
								</c:otherwise>
							</c:choose>                    
						</div>
				
			    </form>
		    </div>
		 </div>
		 
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>
</body>
</html>