// input submit 방지
document.addEventListener('keydown', function(event) {
  if (event.keyCode === 13) {
    event.preventDefault();
  };
});

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
		const html = data.list.map(item => `
		        <div class="col-md-6 col-lg-3">
		            <div class="card text-center card-product">
		                <div class="card-product__img">
		                    <img onclick="location.href='${contextPath}/products/${item.productNum}'" class="card-img"
		                        src="${contextPath}/uploads/product/${item.mainImageFilename}"
		                        alt="${item.productName} 이미지"
								onerror="this.onerror=null; this.src='${contextPath}/dist/images/product/product1.png';">
		                    <ul class="card-product__imgOverlay">
		                        <li>
		                            <button type="button" onclick="location.href='${contextPath}/products/${item.productNum}'">
		                                <iconify-icon icon="tabler:search" class="fs-4"></iconify-icon>
		                            </button>
		                        </li>
		                        <li>
									<form name="buyForm">
										<input type="hidden" name="productNums" id="product-productNum" value="${item.productNum}"> 
										<input type="hidden" name="buyQtys" id="qty" value="1"> 
										<input type="hidden" name="units" id="unit" value="${item.unit}">
				                        <button type="button" onclick="sendOk('cart', this);"">
				                        	<iconify-icon icon="mdi:cart" class="fs-4"></iconify-icon>
				                        </button>
									</form>
		                        </li>
		                        <li>
									<button type="button" data-wish="${item.userWish}" onclick="updateWish(${item.productNum}, this);">
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
		`).join('');;
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

$(function() {
	// 상품 검색
	$('.searchIcon').on('click', function() {
		let kwd = $('.searchInput').val().trim();
		if(kwd === '') {
			return false;
		}
		
		loadProducts(kwd);
	});
	
});

$(function() {
	// 상품 검색창 엔터키 입력
	$('.searchInput').on('keydown', function(event) {
		if (event.keyCode === 13) {
			// 검색 버튼 클릭 트리거
			$('.searchIcon').trigger('click');
		};
	});
});
