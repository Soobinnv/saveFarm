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
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/memberTitle1.webp);">
      <div class="container position-relative">
        <h1>
        	<span class="title">권한없음</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li class="current">  </li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-5" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
				
				<form name="pwdForm" action="" method="post" class="row g-3 mb-2">
					<h3 class="text-center pt-3"><i class="bi bi-exclamation-triangle"></i> 경고 !</h3>                    	                    
	                <div class="col-12">
	                	<div class="text-center">
							<p class="mb-1"><strong>해당 정보를 접근 할 수 있는 권한 이 없습니다.</strong></p>
							<p>메인화면으로 이동하시기 바랍니다.</p>
	                   	</div>
					</div>
					<div class="col-12">
						<button type="button" class="btn-accent btn-lg w-100" onclick="location.href='${pageContext.request.contextPath}/farm';">
							메인화면으로 이동 <i class="bi bi-arrow-counterclockwise"></i>
						</button>	 
					</div>
	                <div>
						<p class="form-control-plaintext text-center text-danger">${message}</p>
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