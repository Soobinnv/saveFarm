<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${productInfo.productName}&nbsp;${productInfo.unit}</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/style.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle2.css"
	type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main>

		<div class="container product-container">
			<div class="row">
				<div class="col-md-6">
					<div id="productImageCarousel" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#productImageCarousel"
								data-bs-slide-to="0" class="active" aria-current="true"
								aria-label="Slide 1"></button>

							<c:if test="${not empty productImageList}">
								<c:forEach var="image" items="${productImageList}"
									varStatus="status">
									<button type="button" data-bs-target="#productImageCarousel"
										data-bs-slide-to="${status.index + 1}"
										aria-label="Slide ${status.index + 2}"></button>
								</c:forEach>
							</c:if>
						</div>

						<div class="carousel-inner">
							<div class="carousel-item active">
								<img class="d-block w-100 carousel-img-fixed"
									src="${contextPath}/uploads/product/${productInfo.mainImageFilename}"
									alt="Main product image">
								<c:if test="${not empty productInfo.endDate}">
									<span
										class="badge bg-danger position-absolute top-0 end-0 m-2 fs-6">
										<iconify-icon icon="mdi:clock-alert-outline" class="me-1"></iconify-icon>
										마감: ${productInfo.endDate}
									</span>
								</c:if>
							</div>

							<c:if test="${not empty productImageList}">
								<c:forEach var="image" items="${productImageList}">
									<div class="carousel-item">
										<img class="d-block w-100 carousel-img-fixed"
											src="${contextPath}/uploads/product/${image.savedFilename}"
											alt="Product detail image">
									</div>
								</c:forEach>
							</c:if>
						</div>
						<c:if test="${not empty productImageList}">
							<button class="carousel-control-prev" type="button"
								data-bs-target="#productImageCarousel" data-bs-slide="prev">
								<span class="carousel-control-prev-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Previous</span>
							</button>
							<button class="carousel-control-next" type="button"
								data-bs-target="#productImageCarousel" data-bs-slide="next">
								<span class="carousel-control-next-icon" aria-hidden="true"></span>
								<span class="visually-hidden">Next</span>
							</button>
						</c:if>
						<button data-wish="${productInfo.userWish}"
							onclick="updateWish(${productInfo.productNum}, this);"
							class="wishBtn p-2 position-absolute bottom-0 end-0 m-3 border-0 bg-transparent text-white z-3">
							<iconify-icon class="fs-4"
								icon="${productInfo.userWish == '1' ? 'mdi:heart' : 'lucide:heart'}"></iconify-icon>
						</button>
					</div>
				</div>

				<div class="col-md-6">
					<h4>${productInfo.productName}&nbsp;${productInfo.unit}</h4>

					<div class="mt-3 mb-3">
						<c:choose>
							<c:when test="${productInfo.discountRate != 0}">
								<span class="badge bg-danger discount-badge">${productInfo.discountRate}%</span>
								<span class="original-price">${productInfo.unitPrice}원</span>
								<span class="sale-price">${productInfo.discountedPrice}원</span>
							</c:when>
							<c:otherwise>
								<span class="final-price">${productInfo.unitPrice}원</span>
							</c:otherwise>
						</c:choose>
					</div>

					<hr>

					<div class="mb-3">
						<h5>
							<i class="bi bi-truck"></i> 배송 정보
						</h5>
						<p class="mb-1">
							<strong>배송비:</strong> ${productInfo.deliveryFee}원 (50,000원 이상 구매
							시 무료)
						</p>
						<p class="mb-1">
							<strong>배송 예상:</strong> 1~2 영업일 이내 출고
						</p>
					</div>

					<div class="mb-3">
						<label for="quantity-input" class="form-label">수량</label>

						<div class="d-flex align-items-center" id="extraItems">
							<button class="btn btn-minus" type="button">
								<iconify-icon icon="ic:baseline-minus" class="fs-4 blackIcon"></iconify-icon>
							</button>
							&nbsp;&nbsp;
							<p class="quantity my-0"
								data-stock="${productInfo.stockQuantity}" data-quantity="3"
								data-productNum="${productInfo.productNum}">1</p>
							&nbsp;&nbsp;
							<button class="btn btn-plus" type="button">
								<iconify-icon icon="ic:baseline-plus" class="fs-4 blackIcon"></iconify-icon>
							</button>
						</div>
					</div>

					<hr>

					<div class="d-grid gap-2">
						<button onclick="sendOk('cart', this);"
							class="btn btn-success btn-lg" type="button">장바구니 담기</button>
						<button onclick="sendOk('buy', this);"
							class="btn btn-success btn-lg" type="button">바로 구매</button>
					</div>
				</div>
			</div>
			<nav>
				<div class="nav nav-tabs nav-fill mt-5" id="nav-tab">
					<button class="nav-link active" id="nav-detail-tab" type="button">상품
						상세</button>
					<button class="nav-link" id="nav-review-tab" type="button">
						상품 리뷰&nbsp;<span>(5231)</span>
					</button>
					<button class="nav-link" id="nav-refund-tab" type="button">반품
						/ 환불</button>
					<button class="nav-link" id="nav-qna-tab" type="button">상품
						문의</button>
				</div>
			</nav>
			<div class="tab-content pt-4" id="nav-tabContent">

				<div id="productInfoLayout">
					<h4>상품 상세 정보</h4>
					<br>
					<p>${productInfo.productDesc}</p>

					<c:choose>
						<c:when test="${not empty productImageList}">
							<c:forEach items="${productImageList}" var="dto">
								<div class="recommendation-section">
									<h4>📢 이 상품은 어때요?</h4>
									<div class="recommendation-list">
									
										<div class="recommendation-item">
											<img
												src="${pageContext.request.contextPath}/dist/images/product/product1.png"
												onerror="this.onerror=null; this.src='${contextPath}/dist/images/product/product1.png';"
												alt="유기농 방울토마토" class="recImage">
											<div class="item-info">
												<p class="item-title">[유기농] 달콤한 방울토마토 500g</p>
												<div class="item-price">
													<span class="discount-rate">15%</span> <span
														class="final-price">5,950원</span> <span
														class="original-price">7,000원</span>
												</div>
											</div>

										</div>
										
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<br>
							<h4>📢 이 상품은 어때요?</h4>
							<div class="text-center mt-3 p-5 border rounded">
								<iconify-icon icon="mdi:comment-off-outline"
									class="fs-1 text-muted"></iconify-icon>
								<p class="mt-3 mb-0 text-muted">추천 상품 목록이 없습니다.</p>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

			</div>

		</div>
	</main>

	<div id="product-template">
		<form name="buyForm">
			<input type="hidden" name="productNums" id="product-productNum"
				value="${productInfo.productNum}"> <input type="hidden"
				name="buyQtys" id="qty" value=""> <input type="hidden"
				name="units" id="unit" value="${productInfo.unit}">
		</form>
		<input type="hidden" id="web-contextPath"
			value="${pageContext.request.contextPath}"> <input
			type="hidden" id="product-productName"
			value="${productInfo.productName}"> <input type="hidden"
			id="product-price" value="${productInfo.unitPrice}"> <input
			type="hidden" id="product-salePrice"
			value="${productInfo.discountedPrice}"> <input type="hidden"
			id="product-totalStock" value="${productInfo.stockQuantity}">
		<input type="hidden" id="product-thumbnail"
			value="${productInfo.mainImageFilename}"> <input
			type="hidden" id="user-name" value="${sessionScope.member.name}">
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>
	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/quantityChanger.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/productInfo.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/productInfo2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/product.js"></script>
</body>
</html>