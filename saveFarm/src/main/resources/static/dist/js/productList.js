/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} kwd - 검색어
 * @param {Array<object>} data.list - 상품 객체 배열
 */
function loadProducts(url, params = '') {
	url = contextPath + url;
	
	const isAppending = params && params.pageNo && params.pageNo > 1;
	
	const fn = function(data){
		
		
		if (data.productList && data.productList.length > 0) {
			const productHtml = renderProductListHtml(data);
			
			if (isAppending) {
				$('#productLayout').append(productHtml); // 내용 추가
			} else {
				$('#productLayout').html(productHtml); // 내용 교체
			}
		}

		if (data.rescuedProductList && data.rescuedProductList.length > 0) {
			const rescuedProductHtml = renderRescuedProductListHtml(data);
			$('#rescuedProductLayout').html(rescuedProductHtml);	
			
			// 구출 상품 타이머 호출
			startTimers();
		} 
		
		scroll(data);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

/**
 * 상품 리스트 HTML 문자열 생성
 * @param {object} data - 전체 상품 데이터
 * @param {Array<object>} data.productList - 일반 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductListHtml = function(data) {
	const html = data.productList.map(item => {
		
		return `
	        <div class="col-md-6 col-lg-3">
	            <div class="card text-center card-product" 
					data-product-num="${item.productNum}"
					data-wish="${item.userWish}"
					data-classify-code="${item.productClassification}"
					>
	                <div class="card-product__img">
	                    <img class="card-img product-main-image"
							src="${contextPath}/uploads/product/${item.mainImageFilename}"
	                        alt="${item.productName} 이미지"
							onerror="this.onerror=null; this.src='${contextPath}/dist/images/product/product1.png';">
	                    <ul class="card-product__imgOverlay">
	                        <li>
	                            <button class="btn-product-info" type="button">
	                                <iconify-icon icon="tabler:search" class="fs-4"></iconify-icon>
	                            </button>
	                        </li>
	                        <li>
								<form name="buyForm">
									<input type="hidden" name="productNums" id="product-productNum" value="${item.productNum}"> 
									<input type="hidden" name="buyQtys" id="qty" value="1"> 
									<input type="hidden" name="units" id="unit" value="${item.unit}">
			                        <button type="button" class="btn-cart">
			                        	<iconify-icon icon="mdi:cart" class="fs-4"></iconify-icon>
			                        </button>
								</form>
	                        </li>
	                        <li>
								<button type="button" class="btn-wish-save">
								${item.userWish == '1'
		                            ?`<iconify-icon icon="mdi:heart" class="wishIcon fs-4"></iconify-icon>`
		                            :`<iconify-icon icon="lucide:heart" class="wishIcon fs-4"></iconify-icon>` 
		                        }
								</button>
								<input type="hidden" name="thumbnail" value="${item.mainImageFilename}">
								<input type="hidden" name="unit" value="${item.unit}">
								<input type="hidden" name="productName" value="${item.productName}">
								<input type="hidden" name="unitPrice" value="${item.unitPrice}">
								<input type="hidden" name="stockQuantity" value="${item.stockQuantity}">
								
	                        </li>
	                    </ul>
	                </div>
	                <div class="card-body">
	                    <h4 class="card-product__title mt-1">
	                        <a href="${contextPath}/products/${item.productNum}?classifyCode=${item.productClassification}">${item.productName}&nbsp;${item.unit}</a>
	                    </h4>
						<div class="d-flex align-items-center justify-content-center mt-2">
							${item.discountRate != 0 
								? `<span class="fs-5 fw-bold text-danger me-2">${item.discountRate}%</span>
								   <span class="text-muted text-decoration-line-through">${item.unitPrice}원</span>
								   <span class="ms-1 fw-bold text-dark">${item.discountedPrice}원</span>`
								: `<span class="final-price fs-5">${item.unitPrice}원</span>`
							}
						</div>
	                </div>
	            </div>
	        </div>
	`}).join('');
	
	return html;
}

/**
 * 구출 상품 리스트 HTML 문자열 생성
 * @param {object} data - 전체 상품 데이터
 * @param {Array<object>} data.rescuedProductList - 구출 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderRescuedProductListHtml = function(data) {
	const html = data.rescuedProductList.map(item => {
		
			return `
			<div class="col-md-6 col-lg-3">
			    <div class="card text-center card-product" 
					data-product-num="${item.productNum}"
					data-wish="${item.userWish}"
					data-classify-code="${item.productClassification}"
					>
			        <div class="card-product__img">

					${(() => {
					    if (!item.endDate) return '';

					    if (item.isUrgent === 1) {
					        return `
					        <span class="badge bg-danger position-absolute top-0 end-0 m-2 fs-6 deadline-timer" 
					              data-deadline="${item.endDate}">
					            <iconify-icon icon="mdi:clock-alert-outline" class="me-1"></iconify-icon>
					            <span class="time-left">마감 임박 !</span>
					        </span>`;
					    } 
					    else {
					        return `
					        <span class="badge bg-danger position-absolute top-0 end-0 m-2 fs-6">
					            <iconify-icon icon="mdi:clock-outline" class="me-1"></iconify-icon>
					            마감: ${item.endDate}
					        </span>`;
					    }
					})()}
					
			            <img class="card-img product-main-image"
							src="${contextPath}/uploads/product/${item.mainImageFilename}"
			                alt="${item.productName} 이미지"
							onerror="this.onerror=null; this.src='${contextPath}/dist/images/product/product1.png';">
			            <ul class="card-product__imgOverlay">
			                <li>
			                    <button class="btn-product-info" type="button">
			                        <iconify-icon icon="tabler:search" class="fs-4"></iconify-icon>
			                    </button>
			                </li>
			                <li>
								<form name="buyForm">
									<input type="hidden" name="productNums" id="product-productNum" value="${item.productNum}"> 
									<input type="hidden" name="buyQtys" id="qty" value="1"> 
									<input type="hidden" name="units" id="unit" value="${item.unit}">
			                        <button type="button" class="btn-cart">
			                        	<iconify-icon icon="mdi:cart" class="fs-4"></iconify-icon>
			                        </button>
								</form>
			                </li>
			                <li>
								<button type="button" class="btn-wish-save">
								${item.userWish == '1'
			                        ?`<iconify-icon icon="mdi:heart" class="wishIcon fs-4"></iconify-icon>`
			                        :`<iconify-icon icon="lucide:heart" class="wishIcon fs-4"></iconify-icon>` 
			                    }
								</button>
								<input type="hidden" name="thumbnail" value="${item.mainImageFilename}">
								<input type="hidden" name="unit" value="${item.unit}">
								<input type="hidden" name="productName" value="${item.productName}">
								<input type="hidden" name="unitPrice" value="${item.unitPrice}">
								<input type="hidden" name="stockQuantity" value="${item.stockQuantity}">
								
			                </li>
			            </ul>
			        </div>
			        <div class="card-body">
			            <h4 class="card-product__title mt-1">
			                <a href="${contextPath}/products/${item.productNum}">${item.productName}&nbsp;${item.unit}</a>
			            </h4>
						<div class="d-flex align-items-center justify-content-center mt-2">
							${item.discountRate != 0 
								? `<span class="fs-5 fw-bold text-danger me-2">${item.discountRate}%</span>
								   <span class="text-muted text-decoration-line-through">${item.unitPrice}원</span>
								   <span class="ms-1 fw-bold text-dark">${item.discountedPrice}원</span>`
								: `<span class="final-price fs-5">${item.unitPrice}원</span>`
							}
						</div>
			        </div>
			    </div>
			</div>
		`}).join('');;

	return html;
}
