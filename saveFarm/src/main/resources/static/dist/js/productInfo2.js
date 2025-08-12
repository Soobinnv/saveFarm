const contextPath = $('#web-contextPath').val();
const productNum = $('#product-productNum').val();

// 처음 페이지 로딩 시
$(function() {
	// 상품 상세 출력
	loadContent('/api/products/' + productNum, renderProductDetailHtml);
});

$(function() {
	// 상품 상세 / 상품 리뷰 / 상품 반풀, 환불 / 상품 문의 tab 클릭
	$('.nav-link').on('click', function() {
		// 다른 비활성화 tab - css 적용
		$('.nav-link').removeClass('active');
		
		// 활성화 tab - css 적용
		$(this).addClass('active');
		
		// 선택한 tab id
		let navId = $(this).attr('id');
		
		// tab 컨텐츠 AJAX 요청 및 렌더링
		switch (navId) {
	    	case 'nav-detail-tab':
	            loadContent('/api/products/' + productNum, renderProductDetailHtml); 
	            break;
	        case 'nav-review-tab':
	            loadContent('/api/products/' + productNum + '/reviews', renderProductReviewHtml);  
	            break;
	        case 'nav-refund-tab':
	            loadContent('/api/products/' + productNum + '/refundInfo', renderRefundHtml); 
	            break;
	        case 'nav-qna-tab':
	        	loadContent('/api/products/' + productNum + '/qnas', renderProductQnaHtml); 
	            break;
    	}
	});
});

/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} url - URL (contextPath 제외)
 * @param {Function} renderFn - AJAX 응답 데이터를 인자로 받아 HTML 문자열을 반환하는 callback 함수
 */
function loadContent(url, renderFn) {
	// 요청 경로 생성
	url = contextPath + url;
	let params = '';
	// 렌더링할 HTML 요소 선택자
	let selector = '#productInfoLayout';
	
	const fn = function(data) {
		const html = renderFn(data);
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

/**
 * 상품 상세 HTML 문자열 생성
 * 상품 설명 / 추천 상품 목록
 * @param {object} data - 상품 상세 정보 / 추천 상품 목록 데이터
 * @param {object} data.productInfo - 상품 객체
 * @param {string} data.productInfo.productDesc - 상품 설명
 * @param {Array<object>} data.list - 추천 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductDetailHtml = function(data) {	
	let html = `
		<h4>상품 상세 정보</h4>
		<br>
		<p>
			${data.productInfo.productDesc}
		</p>
		`
	html += data.list.map(item => `
		<div class="recommendation-section">
			<h4>📢 이 상품은 어때요?</h4>
			<div class="recommendation-list">
				<div class="recommendation-item">
					<img
						src="${contextPath}/dist/images/product/product1.png"
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
				<div class="recommendation-item">
					<img
						src="${contextPath}/dist/images/product/product1.png"
						alt="아삭 양상추" class="recImage">
					<div class="item-info">
						<p class="item-title">[산지직송] 아삭 양상추 1통</p>
						<div class="item-price">
							<span class="final-price">2,800원</span>
						</div>
					</div>

				</div>
				<div class="recommendation-item">
					<img
						src="${contextPath}/dist/images/product/product1.png"
						alt="파프리카" class="recImage">
					<div class="item-info">
						<p class="item-title">[과일처럼] 달콤 파프리카 2입</p>
						<div class="item-price">
							<span class="discount-rate">20%</span> <span
								class="final-price">3,120원</span> <span
								class="original-price">3,900원</span>
						</div>
					</div>

				</div>
				<div class="recommendation-item">
					<img
						src="${contextPath}/dist/images/product/product1.png"
						alt="친환경 브로콜리" class="recImage">
					<div class="item-info">
						<p class="item-title">[친환경] 신선 브로콜리</p>
						<div class="item-price">
							<span class="final-price">2,500원</span>
						</div>
					</div>

				</div>
				<div class="recommendation-item">
					<img
						src="${contextPath}/dist/images/product/product1.png"
						alt="미니 양배추" class="recImage">
					<div class="item-info">
						<p class="item-title">[간편채소] 미니 양배추 300g</p>
						<div class="item-price">
							<span class="discount-rate">10%</span> <span
								class="final-price">3,780원</span> <span
								class="original-price">4,200원</span>
						</div>
					</div>

				</div>
			</div>
		</div>
	`).join('');
	
	return html;
}

/**
 * 상품 리뷰 HTML 문자열 생성
 * 상품 리뷰 목록
 * @param {object} data - 상품 리뷰 데이터
 * @param {Array<object>} data.list - 상품 리뷰 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductReviewHtml = function(data) {
	const html = data.list.map(item => `
			
		
		
	`).join('');
		
	return html;
}

/**
 * 상품 반품 / 환불 HTML 문자열 생성
 * 상품 반품 / 환불 안내
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderRefundHtml = function(data) {	
	const html = `
	<h4>반품 / 환불 안내</h4>
	<div class="info-section mt-4 p-3 border rounded">
		<h4>
			<i class="bi bi-box-seam"></i> 반품 / 환불 안내
		</h4>
		<p class="text-muted">상품 수령일로부터 7일 이내에 신청하실 수 있습니다.</p>
		<ul>
			<li><h5>상품을 받으신 직후 상태를 확인해주세요.</h5>이상이 있는 부분이 있다면 사진을
				촬영해주세요.<br> 수령 후 7일 이내에 접수가 가능합니다.<br>파손 사고 시 배송 송장
				사진도 함께 촬영해주세요.<br>문제 부분을 확인할 수 있도록 3~4장 이상 촬영해주세요.<br>
				사진은 이상이 있는 부분과 없는 부분 전체를 확인할 수 있어야 해요.</li>
		</ul>

		<h4 class="mt-4">
			<i class="bi bi-x-circle"></i> 반품 / 환불 불가능 사유
		</h4>
		<ul>
			<li>1. 수령 후 단순 변심, 기호 등에 의한 요청인 경우 <br>2. 수령 후 7일 이상
				경과, 제품의 30%이상 섭취 한 경우 <br>3. 접수 내용에 사진이 첨부되지 않아 품질 문제를 확인하기
				어려운 경우 <br>4. 고객의 책임 사유(지연 개봉, 부적절한 보관 방법 등)로 상품이 손실 또는 훼손
				된 경우 <br>5. 수령 후 시간이 지나 상품 가치가 현저히 감소한 경우 <br>6. 연락처 및
				주소를 잘못 기입하여 배송 사고가 일어난 경우 <br>7. 상품 상세 페이지에 안내되어 있는 내용인 경우
				<br>8. 택배사 배송 완료 후 상품이 분실된 경우
			</li>
		</ul>
		<div class="d-flex gap-5 mt-5 mb-4 justify-content-center align-items-center">
			<button class="btn btn-success btn-lg" type="button">반품 문의
				</button>
			<button class="btn btn-success btn-lg" type="button">환불 문의
				</button>
		</div>
	</div>
	`
	
	return html;
}

/**
 * 상품 문의 HTML 문자열 생성
 * 상품 문의 목록
 * @param {object} data - 상품 문의 데이터
 * @param {Array<object>} data.list - 상품 문의 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductQnaHtml = function(data) {
	const html = data.list.map(item => `
		
		
		
	`).join('');
	
	return html;
}
