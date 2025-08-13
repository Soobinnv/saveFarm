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
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />
</header>
<main>
	<!-- ================ start banner area ================= -->
	<section class="blog-banner-area" id="category">
		<div class="container h-100 bannerImage">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shop Category</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Shop
								Category</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->


	<div class="container-xxl py-5">
		<div class="container">
			<!-- Start Filter Bar -->
			<div class="search-bar border rounded-2 border-dark-subtle mb-4">
				<div id="search-form" class="text-center d-flex align-items-center">
					<input type="text" class="searchInput form-control border-0 bg-transparent" placeholder="Search Here" />
					<iconify-icon icon="tabler:search" class="searchIcon fs-4 ms-3 me-3"></iconify-icon>
				</div>
			</div>
			<!-- End Filter Bar -->
			<!-- Start Best Seller -->
			<section class="lattest-product-area pb-40 category-list m-3">
					<div class="container">
						<div class="section-intro pb-60px">
							<p>Popular Item in the market</p>
							<h2>
								<span class="section-intro__style">상품</span>
							</h2>
						</div>
					</div>
				<div class="row" id="productLayout"></div>
			</section>
			<!-- End Best Seller -->


			<!-- ================ top product area start ================= -->
			<section class="related-product-area">
				<div class="container">
					<div class="section-intro pb-60px">
						<p>Popular Item in the market</p>
						<h2>
							Top <span class="section-intro__style">Product</span>
						</h2>
					</div>
					<div class="row mt-30">
						<div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
							<div class="single-search-product-wrapper">
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-1.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-2.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-3.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
							<div class="single-search-product-wrapper">
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-4.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-5.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-6.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
							<div class="single-search-product-wrapper">
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-7.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-8.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-8.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
							<div class="single-search-product-wrapper">
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-1.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-2.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
								<div class="single-search-product d-flex">
									<a href="#"><img
										src="${pageContext.request.contextPath}/dist/images/product/product-sm-3.png"
										alt=""></a>
									<div class="desc">
										<a href="#" class="title">Gray Coffee Cup</a>
										<div class="price">$170.00</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<!-- ================ top product area end ================= -->

	<div class="container py-5">
		<div class="row g-5 justify-content-start">
			<div class="section-intro pb-60px">
				<p>Popular Item in the market</p>
				<h2>
					Top <span class="section-intro__style">Product</span>
				</h2>
			</div>
			<div
				class="col-md-6 col-lg-6 col-xl-4 wow fadeIn "
				data-wow-delay="0.1s">
				<div class="events-item bgGreen rounded">
					<div class="events-inner position-relative">
						<div
							class="events-img overflow-hidden">
							<img
								src="${pageContext.request.contextPath}/dist/images/product/product1.png"
								class="img-fluid w-100 " alt="Image">
						</div>
						<div class="px-4 py-2 bgGreen text-center events-rate">29
							Nov ~ 31 Nov</div>
						<div
							class="d-flex justify-content-between px-4 py-2 bg-white dateBox">
							<small class="text-black"><i
								class="fas fa-calendar me-1 text-primary"></i> 10:00am - 12:00pm</small>
							<small class="text-black"><i
								class="fas fa-map-marker-alt me-1 text-primary"></i> New York</small>
						</div>
					</div>
					<div
						class="events-text p-4 border bg-white border-top-0 rounded-bottom">
						<a href="#" class="h4">Music  drawing workshop</a>
						<p class="mb-0 mt-3">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Donec sed purus consectetur,</p>
					</div>
				</div>
			</div>
			<div
				class="col-md-6 col-lg-6 col-xl-4 wow fadeIn "
				data-wow-delay="0.1s">
				<div class="events-item bgGreen rounded">
					<div class="events-inner position-relative">
						<div
							class="events-img overflow-hidden">
							<img
								src="${pageContext.request.contextPath}/dist/images/product/product1.png"
								class="img-fluid w-100 " alt="Image">
						</div>
						<div class="px-4 py-2 bgGreen text-center events-rate">29
							Nov ~ 31 Nov</div>
						<div
							class="d-flex justify-content-between px-4 py-2 bg-white dateBox">
							<small class="text-black"><i
								class="fas fa-calendar me-1 text-primary"></i> 10:00am - 12:00pm</small>
							<small class="text-black"><i
								class="fas fa-map-marker-alt me-1 text-primary"></i> New York</small>
						</div>
					</div>
					<div
						class="events-text p-4 border bg-white border-top-0 rounded-bottom">
						<a href="#" class="h4">Music  drawing workshop</a>
						<p class="mb-0 mt-3">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Donec sed purus consectetur,</p>
					</div>
				</div>
			</div>
			<div
				class="col-md-6 col-lg-6 col-xl-4 wow fadeIn "
				data-wow-delay="0.1s">
				<div class="events-item bgGreen rounded">
					<div class="events-inner position-relative">
						<div
							class="events-img overflow-hidden">
							<img
								src="${pageContext.request.contextPath}/dist/images/product/product1.png"
								class="img-fluid w-100 " alt="Image">
						</div>
						<div class="px-4 py-2 bgGreen text-center events-rate">29
							Nov ~ 31 Nov</div>
						<div
							class="d-flex justify-content-between px-4 py-2 bg-white dateBox">
							<small class="text-black"><i
								class="fas fa-calendar me-1 text-primary"></i> 10:00am - 12:00pm</small>
							<small class="text-black"><i
								class="fas fa-map-marker-alt me-1 text-primary"></i> New York</small>
						</div>
					</div>
					<div
						class="events-text p-4 border bg-white border-top-0 rounded-bottom">
						<a href="#" class="h4">Music  drawing workshop</a>
						<p class="mb-0 mt-3">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Donec sed purus consectetur,</p>
					</div>
				</div>
			</div>
			<div
				class="col-md-6 col-lg-6 col-xl-4 wow fadeIn "
				data-wow-delay="0.1s">
				<div class="events-item bgGreen rounded">
					<div class="events-inner position-relative">
						<div
							class="events-img overflow-hidden">
							<img
								src="${pageContext.request.contextPath}/dist/images/product/product1.png"
								class="img-fluid w-100 " alt="Image">
						</div>
						<div class="px-4 py-2 bgGreen text-center events-rate">29
							Nov ~ 31 Nov</div>
						<div
							class="d-flex justify-content-between px-4 py-2 bg-white dateBox">
							<small class="text-black"><i
								class="fas fa-calendar me-1 text-primary"></i> 10:00am - 12:00pm</small>
							<small class="text-black"><i
								class="fas fa-map-marker-alt me-1 text-primary"></i> New York</small>
						</div>
					</div>
					<div
						class="events-text p-4 border bg-white border-top-0 rounded-bottom">
						<a href="#" class="h4">Music  drawing workshop</a>
						<p class="mb-0 mt-3">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Donec sed purus consectetur,</p>
					</div>
				</div>
			</div>
			<div
				class="col-md-6 col-lg-6 col-xl-4 wow fadeIn "
				data-wow-delay="0.1s">
				<div class="events-item bgGreen rounded">
					<div class="events-inner position-relative">
						<div
							class="events-img overflow-hidden">
							<img
								src="${pageContext.request.contextPath}/dist/images/product/product1.png"
								class="img-fluid w-100 " alt="Image">
						</div>
						<div class="px-4 py-2 bgGreen text-center events-rate">29
							Nov ~ 31 Nov</div>
						<div
							class="d-flex justify-content-between px-4 py-2 bg-white dateBox">
							<small class="text-black"><i
								class="fas fa-calendar me-1 text-primary"></i> 10:00am - 12:00pm</small>
							<small class="text-black"><i
								class="fas fa-map-marker-alt me-1 text-primary"></i> New York</small>
						</div>
					</div>
					<div
						class="events-text p-4 border bg-white border-top-0 rounded-bottom">
						<a href="#" class="h4">Music  drawing workshop</a>
						<p class="mb-0 mt-3">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Donec sed purus consectetur,</p>
					</div>
				</div>
			</div>
			

		</div>
	</div>





	<!-- ================ Subscribe section start ================= -->
	<section class="subscribe-position">
		<div class="container">
			<div class="subscribe text-center">
				<h3 class="subscribe__title">Get Update From Anywhere</h3>
				<p>Bearing Void gathering light light his eavening unto dont
					afraid</p>
				<div id="mc_embed_signup">
					<form target="_blank"
						action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93aamp;id=92a4423d01"
						method="get" class="subscribe-form form-inline mt-5 pt-1">
						<div class="form-group ml-sm-auto">
							<input class="form-control mb-1" type="email" name="EMAIL"
								placeholder="Enter your email" onfocus="this.placeholder = ''"
								onblur="this.placeholder = 'Your Email Address '">
							<div class="info"></div>
						</div>
						<button class="button button-subscribe mr-auto mb-1" type="submit">Subscribe
							Now</button>
						<div style="position: absolute; left: -5000px;">
							<input name="b_36c4fd991d266f23781ded980_aefe40901a"
								tabindex="-1" value="" type="text">
						</div>

					</form>
				</div>

			</div>
		</div>
	</section>
	<!-- ================ Subscribe section end ================= -->
</main>
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/productList.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/updateWish.js"></script>
</body>
</html>