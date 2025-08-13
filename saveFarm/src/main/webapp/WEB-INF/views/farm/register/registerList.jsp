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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.webp);">
      <div class="container position-relative">
        <h1>납품 신청 및 신청보기</h1>
        <p>납품할 농산물을 등록하고, 신청한 목록을 확인합니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm/guide">홈</a></li>
            <li class="current">과정</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
	<section id="comment-form" class="comment-form section">
		<div class="container">
		    <form action="">
		      <h4>Post Comment</h4>
		      <p>Your email address will not be published. Required fields are marked * </p>
		      <div class="row">
		        <div class="col-md-6 form-group">
		          <input name="name" type="text" class="form-control" placeholder="Your Name*">
		        </div>
		        <div class="col-md-6 form-group">
		          <input name="email" type="text" class="form-control" placeholder="Your Email*">
		        </div>
		      </div>
		      <div class="row">
		        <div class="col form-group">
		          <input name="website" type="text" class="form-control" placeholder="Your Website">
		        </div>
		      </div>
		      <div class="row">
		        <div class="col form-group">
		          <textarea name="comment" class="form-control" placeholder="Your Comment*"></textarea>
		        </div>
		      </div>
		
		      <div class="text-center">
		        <button type="submit" class="btn btn-primary">Post Comment</button>
		      </div>
		    </form>
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

</body>
</html>