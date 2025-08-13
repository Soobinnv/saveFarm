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
	            loadContent('/api/products/' + productNum + '/refund-info', renderRefundHtml); 
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
	let html = '';
	
	if(! data.productInfo) {
		html += `
			<h4>상품 상세 정보</h4>
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">등록된 상품 정보가 없습니다.</p>
		    </div>`;
		return html;
	}
	
	html += `
		<h4>상품 상세 정보</h4>
		<br>
		<p>
			${data.productInfo.productDesc}
		</p>
	`;
	
	if(! data.list || data.list.length === 0) {
		html += `
			<br>
			<h4>📢 이 상품은 어때요?</h4>
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">추천 상품 목록이 없습니다.</p>
		    </div>`;
		return html;
	}
		
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
	let html = 	`
		<h4>상품 리뷰</h4>
		<div class="review-list-wrapper mt-3">
		<ul class="list-unstyled">`;
	
	if(! data.list || data.list.length === 0) {
		html += `
			<li class="text-center p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">등록된 리뷰가 없습니다.<br>상품을 구매하고 첫 번째 리뷰를 작성해보세요!</p>
		    </li>`;
		
		return html;
	}
			
	html += data.list.map(item => `
				<li class="review-item border rounded p-3 mb-3">
					<div class="review-header">
						<span class="badge bg-primary me-1">BEST</span> <span
							class="badge bg-success me-1">MEMBERSHIP</span> <span
							class="review-author fw-bold">김**</span>
					</div>

					<h5 class="mt-2">[비비고] 순살 삼치구이 60G</h5>

					<div class="review-body mt-3">
						<p>
							제가 최근 접해본 '비비고 순살삼치구이 60G'입니다.<br> 비비고 순살삼치구이는 60g 용량으로,
							한 끼 반찬으로 딱 좋은 양이에요.<br> 삼치는 영양가가 높고 맛도 좋아 많은 분들이 좋아하는
							생선이죠.<br> 하지만 집에서 직접 요리하기엔 냄새도 나고 손질도 번거로운데, 이 제품은 그런 걱정
							없이 간편하게 즐길 수 있어요.
						</p>

						<p>
							첫 입을 먹었을 때 느낀 건 '와, 이게 정말 편의점 도시락 속 생선구이 맛이 아니구나!'였어요. 삼치 본연의
							고소하고 담백한 맛이 잘 살아있으면서도, 적절한 간이 되어 있어 밥과 함께 먹기 좋았습니다.<br>
							특히 순살이라 가시 걱정 없이 편하게 먹을 수 있다는 점이 큰 장점이에요.<br> 생선 특유의 비린내도
							거의 없어서 생선을 좋아하지 않는 분들도 부담 없이 즐길 수 있을 것 같아요.
						</p>

						<p>
							이 제품의 가장 큰 매력은 바로 간편한 조리 방법이에요!<br> 전자레인지에 1분 30초만 돌리면 끝!<br>
							또는 프라이팬에 약간의 기름을 두르고 3~4분 정도 구워주면 됩니다.<br> 정말 간단하죠?
							전자레인지로 데우면 빠르게 먹을 수 있고, 프라이팬으로 구우면 겉면이 조금 더 바삭해져서 식감이 좋아져요.
							개인의 취향에 따라 선택할 수 있어 좋았습니다.
						</p>

						<p>
							비비고 순살삼치구이 맛과 편의성 면에서 정말 만족스러운 제품이었어요.<br> 특히 조리 방법이 간편해서
							요리에 서툰 분들이나 바쁜 직장인들에게 강력 추천합니다!<br> 냉동실에 몇 개 구비해두면 급하게
							반찬이 필요할 때 정말 요긴하게 사용할 수 있을 것 같아요. 건강한 한 끼를 위해, 또는 도시락 반찬으로도 좋을
							것 같네요.<br> 여러분도 한번 시도해보시는 건 어떨까요? 간편하면서도 맛있는 삼치구이로 든든한 한
							끼 되세요!
						</p>
					</div>
					<div class="review-images mt-3 d-flex overflow-auto">
						<img
							src="${contextPath}/dist/images/product/product1.png"
							class="rounded me-2" alt="리뷰 이미지 1"
							style="width: 100px; height: 100px; object-fit: cover;">
						<img
							src="${contextPath}/dist/images/product/product2.png"
							class="rounded me-2" alt="리뷰 이미지 2"
							style="width: 100px; height: 100px; object-fit: cover;">
						<img
							src="${contextPath}/dist/images/product/product1.png"
							class="rounded me-2" alt="리뷰 이미지 3"
							style="width: 100px; height: 100px; object-fit: cover;">
						<img
							src="${contextPath}/dist/images/product/product1.png"
							class="rounded me-2" alt="리뷰 이미지 4"
							style="width: 100px; height: 100px; object-fit: cover;">
						<img
							src="${contextPath}/dist/images/product/product1.png"
							class="rounded me-2" alt="리뷰 이미지 5"
							style="width: 100px; height: 100px; object-fit: cover;">
						<img
							src="${contextPath}/dist/images/product/product1.png"
							class="rounded me-2" alt="리뷰 이미지 6"
							style="width: 100px; height: 100px; object-fit: cover;">
					</div>

					<div
						class="review-footer mt-3 d-flex justify-content-between align-items-center">
						<span class="review-date text-muted">2024.07.08</span>
						<button type="button" class="btn rounded-pill">
							<iconify-icon icon="stash:thumb-up" class="fs-4 blackIcon"></iconify-icon>
							<span>도움돼요 90</span>
						</button>
					</div>
				</li>
	`).join('');
	
	html += `</ul></div>`;
		
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
	
	let html = '';
	
	if(! data.list || data.list.length === 0) {
		html += `
			<h4>상품 문의</h4>
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">등록된 문의가 없습니다.</p>
		    </div>
			<div class="text-center mt-1 p-5">
				<button onclick="" class="btn btn-success btn-lg" type="button">상품 문의</button>
			</div>
		`;
		return html;
	}
	
	html += `
		<h4>상품 문의</h4>
		<div class="qna-list-wrapper mt-3">
			<div class="qna-list-header">
				<span class="qna-status">상태</span> <span
					class="qna-title text-center">제목</span> <span class="qna-date">등록일</span>
				<span class="qna-author">작성자</span>
			</div>
		<div class="accordion accordion-flush" id="qna-list-body">
	`;
	
	
	html += data.list.map(item => `
				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button collapsed" type="button"
							data-bs-toggle="collapse" data-bs-target="#qna-answer-1">
							<span class="qna-status answered">답변완료</span> <span
								class="qna-title">재입고 문의드립니다.</span> <span class="qna-date">2025-08-07</span>
							<span class="qna-author">김*빈</span>
						</button>
					</h2>
					<div id="qna-answer-1" class="accordion-collapse collapse"
						data-bs-parent="#qna-list-body">
						<div class="accordion-body">안녕하세요, 고객님. 문의하신 상품은 다음 주
							금요일(8/15) 오후에 재입고될 예정입니다. 감사합니다.</div>
					</div>
				</div>

				<div class="accordion-item">
					<h2 class="accordion-header">
						<button class="accordion-button disabled" type="button">
							<span class="qna-status">답변대기</span> <span class="qna-title">배송
								얼마나 걸리나요?</span> <span class="qna-date">2025-08-08</span> <span
								class="qna-author">이*정</span>
						</button>
					</h2>
				</div>

			</div>
		</div>
			
	`).join('');
	
	html += `
		<div class="text-center mt-3 p-5">
			<button onclick="" class="btn btn-success btn-lg" type="button">상품 문의</button>
		</div>
	`;
	
	return html;
}
