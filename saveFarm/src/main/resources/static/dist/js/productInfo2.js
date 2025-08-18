const productNum = $('#product-productNum').val();

// 처음 페이지 로딩 시
$(function() {
	// 상품 상세 출력
	loadContent('/api/products/' + productNum, renderProductDetailHtml);
});

// 이벤트 핸들러 등록
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
	            renderRefund(); 
	            break;
	        case 'nav-qna-tab':
	        	loadContent('/api/products/' + productNum + '/qnas', renderProductQnaHtml); 
	            break;
    	}
	});
	
	// 문의 하기
	$('#productInfoLayout').on('click', '.btn-product-qna', function() {
		sendQna();
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
		    </div>
		`;
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
		<div class="mb-4">
			<h4 class="">상품 리뷰</h4>		
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
			<div class="card mb-4 shadow-sm review-item">
		        <div class="card-body p-4">
		            <div class="d-flex justify-content-between align-items-start mb-3">
		                <div class="d-flex align-items-center">
		                    <img src="${contextPath}/uploads/product/${item.mainImageFilename}" 
		                         class="rounded me-3" 
		                         style="width: 60px; height: 60px; object-fit: cover;"
		                         onerror="this.onerror=null;this.src='/uploads/product/apple.jpg';">
		                    <div>
		                        <p class="card-title mb-0">${item.productName}&nbsp;${item.unit}</p>
		                        <small class="text-muted">${item.reviewerName} · ${formattedDate}</small>
		                    </div>
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
		
	return html;
}

/**
 * 상품 반품 / 환불 HTML 렌더링
 * 상품 반품 / 환불 안내
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderRefund = function() {	
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
			<li>
				1. 수령 후 단순 변심, 기호 등에 의한 요청인 경우 <br>2. 수령 후 7일 이상
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
	
	$('#productInfoLayout').html(html);
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
		`;
	} else {	
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
	
	html += `
		</div></div>
		<div class="text-center mt-3 p-5">
			<button class="btn btn-success btn-lg" type="button" data-bs-toggle="modal" data-bs-target="#qnaFormModal">상품 문의</button>
		</div>
		<div class="modal fade" id="qnaFormModal" tabindex="-1" aria-labelledby="qnaFormModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h2 class="modal-title fs-5" id="qnaFormModalLabel">상품 문의하기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form id="productQnaForm">
		          <div class="mb-3">
		            <label for="qna-title-input" class="form-label"><strong>제목</strong></label>
		            <input type="text" name="title" class="form-control" id="qna-title-input" placeholder="제목을 입력하세요." required>
		          </div>
		          <div class="mb-3">
		            <label for="qna-question-textarea" class="form-label"><strong>문의 내용</strong></label>
		            <textarea class="form-control" name="question" id="qna-question-textarea" rows="6" placeholder="문의하실 내용을 자세하게 입력해주세요." required></textarea>
		          </div>
		          <div class="mb-3">
		            <input type="checkbox" name="secret" id="qna-secret-check">
		            <label class="form-check-label" for="qna-secret-check">비공개 문의</label>
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" form="productQnaForm" class="btn btn-success btn-product-qna">문의 등록</button>
		      </div>
		    </div>
		  </div>
		</div>
	`;
	
	return html;
}
