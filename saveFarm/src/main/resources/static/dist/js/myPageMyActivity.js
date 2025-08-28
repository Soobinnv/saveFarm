const contextPath = $('body').data('context-path');

// 처음 페이지 로딩 시
$(function() {
	const accessType = $('main').attr('data-access-type');
	
	switch(accessType) {
		case "myPage" : 
			// 마이페이지 메인 불러오기
			loadContent('/api/myPage/paymentList', renderMyPageMainHtml);
			break;
		case "wishList" : 
			// 내 찜 목록 불러오기
			loadContent('/api/myPage/wish', renderMyWishListHtml);
			break;
	}
	
});

/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} url - URL (contextPath 제외)
 * @param {Function} renderFn - AJAX 응답 데이터를 인자로 받아 HTML 문자열을 반환하는 callback 함수
 */
function loadContent(url, renderFn, params) {
	// 요청 경로 생성
	url = contextPath + url;
	params ? params : '';
	// 렌더링할 HTML 요소 선택자
	let selector = '#content';
	
	const fn = function(data) {
		const html = renderFn(data);
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

// 이벤트 핸들러 등록
$(function() {
	// 장보기
	$('#content').on('click', '.btn-product-list', function() {
		location.href='${contextPath}/products';
	});
	
	// 장바구니
	$('#content').on('click', '.btn-cart', function() {
		sendOk('cart', this);
	});
	
	// 바로 구매
	$('#content').on('click', '.btn-buy', function() {
		sendOk('buy', this);
	});
	
	// 리뷰 등록 / 수정
	$('#content').on('click', '.btn-review-save', function() {
		const orderDetailNum = $(this).data('orderDetailNum');
		const mode = $(this).data('mode');

		manageReview(orderDetailNum, mode);
	});

	// 반품 신청
	$('#content').on('click', '.btn-return-insert', function() {
		const $form = $(this).closest('#returnForm');
		const orderDetailNum = $(this).data('orderDetailNum');
		
		let url = contextPath + '/api/myPage/return/' + orderDetailNum;
		let params = new FormData($form[0]);
		
		const fn = function(data) {
			loadContent('/api/myPage/paymentList', renderMyPageMainHtml);
		}
		
		ajaxRequest(url, 'post', params, false, fn, true);
	});

	// 환불 신청
	$('#content').on('click', '.btn-refund-insert', function() {
		const $form = $(this).closest('#refundForm');
		const orderDetailNum = $(this).data('orderDetailNum');
		
		let url = contextPath + '/api/myPage/refund/' + orderDetailNum;
		let params = new FormData($form[0]);

		const fn = function(data) {
			loadContent('/api/myPage/paymentList', renderMyPageMainHtml);
		}

		ajaxRequest(url, 'post', params, false, fn, true);
	});
	
	// 리뷰 수정 form
	$('#content').on('click', '.btn-review-edit', function() {
		const $reviewItem = $(this).closest('.review-item');
		const reviewImageList = $reviewItem.data('reviewImageList');
		
		if(reviewImageList !== undefined && reviewImageList !== null) {
			reviewImageList = JSON.parse(reviewImageList);
		}
		
		const orderDetailObject = {
			orderDetailNum: $reviewItem.data('orderDetailNum'),
			mainImageFilename: $reviewItem.data('mainImageFilename'),
			productName: $reviewItem.data('productName'),
			orderDate: $reviewItem.data('orderDate'),
			productNum: $reviewItem.data('productNum'),
		}
		
		const reviewObject = {
			reviewTitle: $reviewItem.data('reviewtitle'),
			star: $reviewItem.data('star'),
			review: $reviewItem.data('review')
		};
		
		renderReviewForm(orderDetailObject, reviewObject);
	});
	
	// 리뷰 삭제
	$('#content').on('click', '.btn-review-delete', function() {
		const orderDetailNum = $(this).data('orderDetailNum');
				
		if(! confirm("리뷰를 삭제하시겠습니까?")) {
			return false;
		}
		
		manageReview(orderDetailNum, "delete");
	});
	
	// 리뷰 등록 form
	$('#content').on('click', '.btn-review-write', function() {
		const $orderItem = $(this).closest('.order-card');
		
		const orderDetailObject = {
			orderDetailNum: $orderItem.data('orderdetailnum'),
			mainImageFilename: $orderItem.data('mainimagefilename'),
			productName: $orderItem.data('productname'),
			orderDate: $orderItem.data('orderdate'),
			productNum: $orderItem.data('productnum'),
		}
		
		// 등록 - 리뷰 객체 X
		renderReviewForm(orderDetailObject, null);
	});
	
	// 반품 form
	$('#content').on('click', '.btn-return-request', function() {
		const $orderItem = $(this).closest('.order-card');
		
		const orderDetailObject = {
			orderDetailNum: $orderItem.data('orderdetailnum'),
			mainImageFilename: $orderItem.data('mainimagefilename'),
			productName: $orderItem.data('productname'),
			orderDate: $orderItem.data('orderdate'),
			productNum: $orderItem.data('productnum'),
			qty: $orderItem.data('qty')
		}
		
		renderReturnForm(orderDetailObject);
	});
	
	// 환불 form
	$('#content').on('click', '.btn-cancel-order', function() {
		const $orderItem = $(this).closest('.order-card');
		
		const orderDetailObject = {
			orderDetailNum: $orderItem.data('orderdetailnum'),
			mainImageFilename: $orderItem.data('mainimagefilename'),
			productName: $orderItem.data('productname'),
			orderDate: $orderItem.data('orderdate'),
			productNum: $orderItem.data('productnum'),
		}
		
		renderRefundForm(orderDetailObject);
	});
	
	
});

/**
 * 마이 페이지 - 내 활동 - 찜
 * @param {object} data - 내가 찜한 상품 데이터
 * @param {Array<object>} data.list - 내가 찜한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyWishListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">찜한 상품</h3>
				<p class="mt-2 text-muted">관심 있는 상품을 저장하고 관리하세요.</p>
			</div>			
			<div class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-4 p-3 bg-light rounded">
			    <div class="d-flex align-items-center">
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" value="" id="selectAll">
			            <label class="form-check-label fw-medium" for="selectAll">전체선택</label>
			        </div>
			        <span class="text-muted mx-3">|</span>
			        <button id="deleteSelected" class="btn btn-link text-decoration-none text-danger p-0 fw-medium">선택삭제</button>
			    </div>
			    <div class="mt-3 mt-sm-0 text-body-secondary">
			        총 <strong class="text-primary fw-bold">${data.list.length}</strong>개의 상품
			    </div>
			</div>
			<div id="wishlist-container">
	
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">찜한 상품이 없습니다.</p>
		    </div>
			<div class="text-center mt-3 p-5">
				<button class="btn btn-success btn-lg btn-product-list" type="button">장보러가기</button>	
			</div>
		`;
		return html;
	}
	
	html += data.list.map(item => `
        <div class="card product-card mb-4 shadow-sm position-relative">
            <div class="card-body p-4">
                <div class="row align-items-center">
                    <div class="col-12 col-sm-auto d-flex align-items-center mb-3 mb-sm-0">
                        <input class="form-check-input me-4" type="checkbox" style="width: 1.25rem; height: 1.25rem;">
                        <img src="${contextPath}/uploads/product/${item.mainImageFilename}" alt="상품 이미지" class="rounded" style="width: 8rem; height: 8rem; object-fit: cover;">
                    </div>

                    <div class="col-12 col-sm text-center text-sm-start">
                        <p class="small text-muted mb-1">${item.wishDate}</p>
                        <h3 class="h5 fw-semibold text-dark mb-2">
                            <a href="${contextPath}/products/${item.productNum}" class="text-decoration-none text-dark">${item.productName}&nbsp;${item.unit}</a>
                        </h3>
                        <div class="d-flex align-items-center justify-content-center justify-content-sm-start mb-1">
							${item.discountRate != 0 
								? `<span class="fs-5 fw-bold text-danger me-2">${item.discountRate}%</span>
								   <span class="text-muted text-decoration-line-through">${item.unitPrice}원</span>
								   <span class="ms-1 fw-bold text-dark">${item.discountedPrice}원</span>`
								: `<span class="final-price fs-5">${item.unitPrice}원</span>`
							}
                        </div>
                        <p class="small text-muted">배송비: ${item.deliveryFee}원</p>
                    </div>

                    <div class="col-12 col-md-auto mt-3 mt-md-0">
						<form name="buyForm" class="d-grid d-md-flex gap-2">
							<input type="hidden" name="productNums" value="${item.productNum}"> 
							<input type="hidden" name="buyQtys" value="1"> 
							<input type="hidden" name="units" value="${item.unit}">
							<button class="btn btn-outline-success btn-cart" type="button">장바구니</button>
							<button class="btn btn-success btn-buy" type="button">바로 구매</button>
						</form>
                    </div>
                    </div>
            </div>
            <button type="button" class="btn-close position-absolute top-0 end-0 p-3" aria-label="Close"></button>
        </div>
	`).join('');
	html += `</div></div>`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 나의 리뷰
 * @param {object} data - 내가 리뷰한 상품 데이터
 * @param {Array<object>} data.list - 내가 리뷰한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyReviewListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">나의 리뷰</h3>
				<p class="text-muted">내가 작성한 상품 리뷰를 확인하고 관리할 수 있습니다.</p>		
			</div>
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 작성한 리뷰가 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => {
		const formattedDate = new Date(item.reviewDate).toLocaleDateString();
		const reviewText = item.review.replace(/\n/g, '<br>');
		
		return `
		<div class="card mb-4 shadow-sm review-item"
			data-orderDetailNum = "${item.orderDetailNum}"
			data-productNum = "${item.productNum}"
			data-mainImageFilename = "${item.mainImageFilename}"
			data-productName = "${item.productName}"
			data-reviewDate = "${formattedDate}"
			data-unit = "${item.unit}"
			data-reviewTitle = "${item.reviewTitle}"
			data-star = "${item.star}"
			data-review = "${item.review}"
			data-reviewImageList = "${JSON.stringify(item.reviewImageList || [])}"
			data-helpfulCount = "${item.helpfulCount}"
			>
	        <div class="card-body p-4">
	            <div class="d-flex justify-content-between align-items-start mb-3">
	                <div class="d-flex align-items-center">
	                    <img src="${contextPath}/uploads/product/${item.mainImageFilename}" 
	                         class="rounded me-3" 
	                         style="width: 60px; height: 60px; object-fit: cover;"
	                         onerror="this.onerror=null;this.src='/uploads/product/apple.jpg';">
	                    <div>
	                        <small class="text-muted">작성일: ${formattedDate}</small>
	                        <p class="card-title mb-0">${item.productName}&nbsp;${item.unit}</p>
	                    </div>
	                </div>
	                <div class="dropdown">
	                    <button type="button" data-bs-toggle="dropdown" aria-expanded="false">
	                        <iconify-icon icon="basil:menu-outline" class="align-middle"></iconify-icon>
	                    </button>
	                    <ul class="dropdown-menu dropdown-menu-end">
	                        <li><a class="dropdown-item review-dropdown-item btn-review-edit" href="javascript:void(0)">
	                            <iconify-icon icon="mdi:pencil-outline" class="me-2"></iconify-icon>수정하기
	                        </a></li>
	                        <li><a data-order-detail-num=${item.orderDetailNum} class="dropdown-item review-dropdown-item text-danger btn-review-delete" href="javascript:void(0)">
	                            <iconify-icon icon="mdi:trash-can-outline" class="me-2"></iconify-icon>삭제하기
	                        </a></li>
	                    </ul>
	                </div>
	            </div>	
				<div class="mb-3">
					<h5 class="card-title mb-0 fw-semibold">${item.reviewTitle}</h5>
				</div>
	            <div class="mb-3 d-flex align-items-center">
	                <div class="me-2">
	                    ${[...Array(5)].map((_, i) => `
	                        <iconify-icon icon="${i < item.star ? 'mdi:star' : 'mdi:star-outline'}" class="text-warning"></iconify-icon>
	                    `).join('')}
	                </div>
	                <span class="fw-bold text-warning align-middle">${item.star}.0</span>
	            </div>
	
	            <p class="card-text text-secondary mb-3">${reviewText}</p>
	
	            ${item.reviewImageList && item.reviewImageList.length > 0 ? `
	            <div class="review-images d-flex overflow-auto mb-3 pb-2">
	                ${item.reviewImageList.map(imgUrl => `
	                    <img src="${imgUrl}" class="rounded me-2" alt="리뷰 이미지" 
							style="width: 90px; height: 90px; object-fit: cover; cursor: pointer;
							onerror="this.onerror=null;this.src='/uploads/product/apple.jpg'";>
	                `).join('')}
	            </div>
	            ` : ''}
	
	            <div class="d-flex justify-content-end align-items-center text-muted">
	                <iconify-icon icon="stash:thumb-up" class="me-1"></iconify-icon>
	                <span>도움돼요 ${item.helpfulCount}</span>
	            </div>
	        </div>
	    </div>
	`}).join('');
	
	html += `
		<div class="myPagePaginate">
			${data.paging}
		</div>`
	
	return html;
}

/**
 * 마이 페이지 - 리뷰 작성/수정 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderReviewForm = function(orderDetailObject = null, reviewObject = null) {	

	let mode = reviewObject === null ? "insert" : "update";
	
	const html = `
	<div class="container-lg p-4 p-sm-5">
		<div class="mb-5">
			<h3 class="display-6 fw-bold text-dark">리뷰 작성</h3>
		</div>

		<h4 class="display-8 text-dark">이 상품 어떠셨나요?</h4>
		<div class="reivew-form-product-info d-flex align-items-center mb-4">
			<img src="${contextPath}/uploads/product/${orderDetailObject.mainImageFilename}" class="reivew-form-product-image me-3">
			<div>
				<p class="reivew-form-product-name mb-1">${orderDetailObject.productName}</p>
				<p class="reivew-form-order-date text-muted">주문일자: ${orderDetailObject.orderDate}</p>
			</div>
		</div>
		<form name="reviewForm" id="reviewForm" enctype="multipart/form-data">
		  <div class="mb-3">
		    <label for="starRating" class="form-label">별점</label>
		    <div class="star-rating" id="starRating">
		      <input type="radio" id="5-stars" name="star" value="5" required />
		      <label for="5-stars" class="star">&#9733;</label>
		      <input type="radio" id="4-stars" name="star" value="4" required />
		      <label for="4-stars" class="star">&#9733;</label>
		      <input type="radio" id="3-stars" name="star" value="3" required />
		      <label for="3-stars" class="star">&#9733;</label>
		      <input type="radio" id="2-stars" name="star" value="2" required />
		      <label for="2-stars" class="star">&#9733;</label>
		      <input type="radio" id="1-star" name="star" value="1" required />
		      <label for="1-star" class="star">&#9733;</label>
		    </div>
		  </div>
		  <div class="mb-3">
		    <label for="review" class="form-label">리뷰 제목</label>
		    <input value="${mode === "update" ? `${reviewObject.reviewTitle}` : ''}" class="form-control" id="reviewTitle" name="reviewTitle" placeholder="리뷰의 제목을 작성해주세요." maxlength="1000" required>
			</input>
		  </div>
		  <div class="mb-3">
		    <label for="review" class="form-label">리뷰 내용</label>
		    <textarea class="form-control" id="review" name="review" rows="5" placeholder="솔직한 리뷰를 남겨주세요." maxlength="4000" required>${mode === "update" ? `${reviewObject.review}` : ""}</textarea>
		  </div>
		  <div class="mb-3">
			<label for="reviewImages" class="form-label">사진 첨부 (선택)</label>
          	<input class="form-control" type="file" id="reviewImages" name="reviewImages" name="selectFile" multiple accept="image/*">
          </div>
		  <input type="hidden" name="productNum" value="${orderDetailObject.productNum}">
		  <div class="mt-4 d-grid">
		    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" data-mode="${mode}" type="button" class="btn btn-success btn-lg btn-review-save">리뷰 ${mode === "update" ? "수정" : "등록"}</button>
		  </div>
		</form>
	</div>
	`
	$('#content').html(html);
	
	// 별점 활성화
	if (mode === "update") {
		const star = reviewObject.star;
		$(`#starRating input[value="${star}"]`).prop('checked', true);
	}
}

/**
 * 마이 페이지 - 반품 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderReturnForm = function(orderDetailObject = null) {	
	const html = `
	<div class="container mt-5">
	    <div class="card">
	        <div class="card-header">
	            <h3 class="mb-0">반품 신청 📦</h3>
	        </div>
	        <div class="card-body">
	            <div class="row mb-4 align-items-center">
	                <div class="col-md-2">
	                    <img src="${contextPath}/uploads/product/${orderDetailObject.mainImageFilename}" class="img-fluid rounded" alt="상품 이미지">
	                </div>
	                <div class="col-md-10">
	                    <h5 class="card-title">${orderDetailObject.productName}</h5>
	                    <p class="card-text text-muted">주문일자: ${orderDetailObject.orderDate}</p>
	                </div>
	            </div>

	            <form id="returnForm">
	                <div class="mb-3">
	                    <label for="returnReason" class="form-label fw-bold">반품 사유</label>
	                    <textarea class="form-control" id="reason" name="reason" rows="4" placeholder="상세한 반품 사유를 입력해주세요." required></textarea>
	                </div>
	                
	                <div class="mb-3">
	                    <label for="quantity" class="form-label fw-bold">반품 수량</label>
	                    <input type="number" class="form-control" id="quantity" name="quantity" min="1" max="${orderDetailObject.qty}" value="1" required>
	                </div>
	                
	                <div class="mb-4">
	                    <label for="returnPhotos" class="form-label fw-bold">사진 첨부</label>
	                    <input class="form-control" type="file" id="returnPhotos" name="returnPhotos" multiple>
	                    <div class="form-text">상품의 상태를 확인할 수 있는 사진을 첨부해주세요.</div>
	                </div>
	                
	                <div class="d-grid gap-2">
	                    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" type="button" class="btn-return-insert btn btn-success btn-lg">반품 신청하기</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	`;
	
	$('#content').html(html);
	
}

/**
 * 마이 페이지 - 환불 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderRefundForm = function(orderDetailObject = null) {	
	const html = `
	<div class="container mt-5">
	    <div class="card">
	        <div class="card-header">
	            <h3 class="mb-0">환불 신청 💳</h3>
	        </div>
	        <div class="card-body">
	            <div class="row mb-4 align-items-center">
	                <div class="col-md-2">
	                    <img src="${contextPath}/uploads/product/${orderDetailObject.mainImageFilename}" class="img-fluid rounded" alt="상품 이미지">
	                </div>
	                <div class="col-md-10">
	                    <h5 class="card-title">${orderDetailObject.productName}</h5>
	                    <p class="card-text text-muted">주문일자: ${orderDetailObject.orderDate}</p>
	                </div>
	            </div>

	            <form id="refundForm">
	                <div class="mb-3">
	                    <label for="refundMethod" class="form-label fw-bold">환불 수단</label>
	                    <select class="form-select" id="refundMethod" name="refundMethod" required>
	                        <option selected disabled value="">환불받을 결제수단을 선택하세요.</option>
	                        <option value="credit_card">카드 환불</option>
	                        <option value="bank_transfer">계좌 이체</option>
	                    </select>
	                </div>

	                <div id="bankInfo" class="border p-3 rounded mb-4" style="display: none;">
	                    <h6 class="mb-3">환불 계좌 정보 입력</h6>
	                    <div class="mb-3">
	                        <label for="bankName" class="form-label">은행명</label>
	                        <input type="text" class="form-control" id="bankName" name="bankName" placeholder="예: 국민은행">
	                    </div>
	                    <div class="mb-3">
	                        <label for="accountNumber" class="form-label">계좌번호</label>
	                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" placeholder="'-' 없이 숫자만 입력">
	                    </div>
	                    <div>
	                        <label for="accountHolder" class="form-label">예금주명</label>
	                        <input type="text" class="form-control" id="accountHolder" name="accountHolder">
	                    </div>
	                </div>
	                
	                <div class="d-grid gap-2">
	                    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" type="button" class="btn-refund-insert btn btn-success btn-lg text-white">환불 신청하기</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	`;
	
	$('#content').html(html);
}

/**
 * 상품 리뷰 CUD
 * @param {string} orderDetailNum - 주문 상세 번호
 */
function manageReview(orderDetailNum, mode) {
	let url = contextPath + '/api/myPage/reviews/' + orderDetailNum;
	// const params = new FormData($('#reviewForm')[0]); 
	// const method = mode === "insert" ? "POST" : "PUT";
	let params = null;
	
	switch (mode) {
		case 'insert':
			method = 'POST';
			params = new FormData($('#reviewForm')[0]);
			break;
		case 'update':
			method = 'PUT';
			params = new FormData($('#reviewForm')[0]);
			break;
		case 'delete':
			method = 'DELETE';
			break;
		default:
			console.error('manageReview - mode: ', mode);
			return; 
	}
	
	const fn = function(data) {
		// 나의 리뷰 불러오기
		loadContent('/api/myPage/reviews', renderMyReviewListHtml);
	}
	
	ajaxRequest(url, method, params, false, fn, true);
}

/**
 * 상품 리뷰 삭제
 * @param {string} orderDetailNum - 주문 상세 번호
 */
function deleteReview(orderDetailNum, mode) {
	let url = contextPath + '/api/myPage/reviews/' + orderDetailNum;
	
	const fn = function(data) {
		// 나의 리뷰 불러오기
		loadContent('/api/myPage/reviews', renderMyReviewListHtml);
	}
	
	ajaxRequest(url, "DELETE", params, false, fn, false);
}


/**
 * 마이 페이지 - 내 활동 - 1:1 문의
 * @param {object} data - 나의 문의 데이터
 * @param {Array<object>} data.list - 내가 문의한 inquiry 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyInquiryListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">1:1 문의</h3>
				<p class="text-muted">내가 문의한 내용을 확인하고, 관리자의 답변을 확인할 수 있습니다.</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 문의한 내용이 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => `

		
	`).join('');
	html += `</div>`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 나의 상품 문의
 * @param {object} data - 내가 문의한 상품 데이터
 * @param {Array<object>} data.list - 내가 문의한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyQnaListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">나의 상품 문의</h3>
				<p class="text-muted">내가 문의한 상품을 확인하고, 관리자의 답변을 확인할 수 있습니다.</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 문의한 상품이 없습니다.</p>
		    </div>
		`;
		return html;
	} else {
			html += `
				<h4>상품 문의</h4>
				<div class="qna-list-wrapper mt-3">
					<div class="qna-list-header">
						<span class="qna-status">상태</span> <span
							class="qna-title text-center">제목</span> 
						<span class="qna-author">작성자</span>
							<span class="qna-date">등록일</span>
					</div>
				<div class="accordion accordion-flush" id="qna-list-body">
			`;
			
			
			html += data.list.map(item => {
				const isAnswered = item.answer && item.answer.trim() !== '';
				const statusClass = isAnswered ? 'answered' : '';
				const statusText = isAnswered ? '답변완료' : '답변대기';
				const collapseId = `qna-answer-${item.qnaNum}`;

				let itemHtml = `
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button 
				                class="accordion-button ${isAnswered ? '' : 'collapsed'} ${!isAnswered ? 'disabled' : ''}" 
					                type="button" 
									${isAnswered ? `data-bs-toggle="collapse" data-bs-target="#${collapseId}"` : 'aria-disabled="true"'}>
								<span class="qna-status ${statusClass}">${statusText}</span>
								<span class="qna-title">${item.secret == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 17c1.1 0 2-.9 2-2s-.9-2-2-2s-2 .9-2 2s.9 2 2 2m6-9h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2m-6 9c-2.21 0-4-1.79-4-4s1.79-4 4-4s4 1.79 4 4s-1.79 4-4 4M9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2z"></path></svg> ' : ''}${item.title}</span>
								<span class="qna-author">${item.name}</span>
								<span class="qna-date">${item.qnaDate}</span>
							</button>
						</h2>`;

				if (isAnswered) {
					itemHtml += `
						<div id="${collapseId}" class="accordion-collapse collapse" data-bs-parent="#qna-list-body">
							<div class="accordion-body">
								<div class="qna-question-wrapper">
									<strong class="qna-prefix q-prefix">Q.</strong>
									<div class="qna-content">${item.question}</div>
								</div>
								<div class="qna-answer-wrapper">
									<strong class="qna-prefix a-prefix">A.</strong>
									<div class="qna-content">${item.answer}</div>
								</div>
							</div>
						</div>
					`;
				}

				itemHtml += `</div>`;
				return itemHtml;
					
			}).join('');
		}	
	
	html += `</div></div></div>
		<div class="myPagePaginate">
			${data.paging}
		</div>
	`;
	
	return html;
}


/**
 * 마이 페이지 - 내 활동 - 상품 문의 페이징 처리
 * @param {number} page - 현재 페이지
 */
function qnaListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/myPage/qnas', renderMyQnaListHtml, parameter)
}

/**
 * 마이 페이지 - 내 활동 - 내 리뷰 페이징 처리
 * @param {number} page - 현재 페이지
 */
function reviewListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/myPage/reviews', renderMyReviewListHtml, parameter)
}

/**
 * 마이 페이지 - 내 활동 - FAQ
 * @param {object} data - FAQ 데이터
 * @param {Array<object>} data.list - FAQ 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderFaqListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">FAQ</h3>
				<p class="text-muted">자주 묻는 질문</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 등록된 FAQ가 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => `

		
	`).join('');
	html += `</div>`;
	
	return html;
}