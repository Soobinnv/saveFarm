<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm - 장보기</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle2.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle.css"
	type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css" type="text/css">
</head>
<body data-page-id="product-list">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>
<main>
	<div class="container-xxl py-5 mt-5">
		<section class="blog-banner-area" id="category">
		</section>
		<section class="content-section">
			<div class="search-bar border rounded-2 border-dark-subtle mb-4">
				<div id="search-form" class="text-center d-flex align-items-center">
					<input type="text" class="searchInput form-control border-0 bg-transparent" placeholder="Search Here" />
					<iconify-icon icon="tabler:search" class="searchIcon fs-4 ms-3 me-3"></iconify-icon>
				</div>
			</div>
			<section class="lattest-product-area pb-40 category-list m-2">
					<div class="">
						<div class="section-intro pb-60px">
							<p>위험에 빠진 상품을 구출해주세요!</p>
							<h2>
								<span class="section-intro__style">구출 상품</span>
							</h2>
						</div>
					</div>
				<div class="row" id="rescuedProductLayout"></div>
			</section>
			<section class="lattest-product-area pb-40 category-list m-2">
					<div class="">
						<div class="section-intro pb-60px">
							<p>자연의 맛 그대로, 개성만점 못난이들</p>
							<h2>
								<span class="section-intro__style">상품</span>
							</h2>
						</div>
					</div>
				<div class="row content-list" id="productLayout"></div>
				<div class="sentinel" data-loading="false"></div>
			</section>
		</section>
	</div>
<input type="hidden" id="web-contextPath" value="${pageContext.request.contextPath}">
</main>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/product/productListService.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/product/productListRenderer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/product/productTimer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/product/productList.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/product/productAction.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/infiniteScroll.js"></script>
</body>
</html>