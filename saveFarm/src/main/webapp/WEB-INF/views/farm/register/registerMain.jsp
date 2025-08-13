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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle1.webp);">
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
    
     <!-- Blog Posts 2 Section -->
    <section id="blog-posts-2" class="blog-posts-2 section">

      <div class="container">
        <div class="row gy-4">

          <div class="col-lg-6">
            <article class="position-relative h-100">

              <div class="post-img position-relative overflow-hidden">
                <img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle2.png" class="img-fluid" alt="">
              </div>

              <div class="meta d-flex align-items-end">
                <span class="post-date"><span>01</span>납품신청</span>
              </div>

              <div class="post-content d-flex flex-column">

                <h3 class="post-title">새로 납품할 농산물 접수하러 가기</h3>
                <a href="${pageContext.request.contextPath}/farm/registerForm" class="readmore stretched-link"><span>보러가기</span><i class="bi bi-arrow-right"></i></a>

              </div>

            </article>
          </div><!-- End post list item -->

          <div class="col-lg-6">
            <article class="position-relative h-100">

              <div class="post-img position-relative overflow-hidden">
                 <img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.png" class="img-fluid" alt="">
              </div>

              <div class="meta d-flex align-items-end">
                <span class="post-date"><span>02</span>신청목록</span>
              </div>

              <div class="post-content d-flex flex-column">
                <h3 class="post-title">이미 납품 신청한 내역 확인하기</h3>
                <a href="${pageContext.request.contextPath}/farm/registerList" class="readmore stretched-link"><span>보러가기</span><i class="bi bi-arrow-right"></i></a>
              </div>

            </article>
          </div><!-- End post list item -->
        </div>
      </div>

    </section><!-- /Blog Posts 2 Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

</body>
</html>