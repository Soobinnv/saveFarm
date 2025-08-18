// 처음 접속 시 상품 리스트 로드
$(function() {	
	loadProducts("");
});

/**
 * AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} kwd - 검색어
 * @param {Array<object>} data.list - 상품 객체 배열
 */
function loadProducts(kwd) {
	let url = contextPath + '/api/products';
	let params = 'kwd=' + kwd;
	let selector = '#productLayout';
	
	const fn = function(data){
		const html = data.list.map(item => {
			// placeholder를 상품 번호로 변경
			
			return `
		        <div class="col-md-6 col-lg-3">
		            <div class="card text-center card-product" 
						data-product-num="${item.productNum}"
						data-wish="${item.userWish}"
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
				                        <button type="button" class="btn-cart" onclick="addToCart(${item.productNum}, this);">
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
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}
