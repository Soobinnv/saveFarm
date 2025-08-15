const contextPath = $('body').data('context-path');

// 처음 페이지 로딩 시
$(function() {
	// 마이페이지 메인 불러오기
	loadContent('/api/myPage', renderMyPageMainHtml);
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

/**
 * 마이 페이지 - 메인 HTML 문자열 생성
 * @param {object} data
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyPageMainHtml = function(data) {	
	const html = `
	  <div class="welcome-box">
	    <div class="welcome-left">
	      <img src="${contextPath}/dist/images/person.png" class="profile-avatar" alt="프로필 사진">
	      <div>
	        <strong>회원님 반갑습니다.</strong><br />
	        가입하신 회원은 <span style="color: red;">WELCOME</span> 입니다.
	      </div>
	    </div>
	    <div class="welcome-right">
	      <div>쿠폰<br><strong>1</strong></div>
	      <div style="margin-top: 10px;">구매후기<br><strong>0</strong></div>
	    </div>
	  </div>

	  <section class="tab-section">
		  <div class="tab-menu">
		    <button class="active" data-tab="tab1">일반택배</button>
		    <button data-tab="tab2">정기배송 구독</button>
		    <button data-tab="tab3">취소/교환/반품</button>
		  </div>
		
		  <div class="tab-content" id="tab1">
		    <div class="order-steps">
		      <div><i class="fas fa-clipboard-list"></i>주문접수</div>
		      <div><i class="fas fa-credit-card"></i>결제완료</div>
		      <div><i class="fas fa-box"></i>상품준비중</div>
		      <div><i class="fas fa-truck"></i>배송중</div>
		      <div><i class="fas fa-gift"></i>배송완료</div>
		    </div>
		    <p style="text-align:center; color:#aaa; margin-top: 20px;">내역이 없습니다.</p>
		  </div>
		
		  <div class="tab-content" id="tab2" style="display:none;">
		    <p>정기배송 구독 내역이 없습니다.</p>
		  </div>
		
		  <div class="tab-content" id="tab3" style="display:none;">
		    <p>취소/교환/반품 내역이 없습니다.</p>
		  </div>
	  </section>

	  <section class="like-section">
	    <h3>MY LIKE ITEMS</h3>
	    <p>MY LIKE ITEMS가 없습니다.</p>
	  </section>
	`
	
	return html;
}

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
				<button onclick="location.href='${contextPath}/products';" class="btn btn-success btn-lg" type="button">장보러가기</button>	
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
                            <a href="#" class="text-decoration-none text-dark">${item.productName}(4개입)</a>
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
                        <div class="d-grid gap-2 d-sm-block">
							<button onclick="sendOk('cart');" class="btn btn-success btn-lg" type="button">장바구니 담기</button>
							<button onclick="sendOk('buy');" class="btn btn-success btn-lg" type="button">바로 구매</button>
                        </div>
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
			<div class="mt-3 d-flex justify-content-center">
				<button onclick="renderReviewForm();" class="btn btn-success btn-lg" type="button">리뷰 작성</button>
			</div>
		`;
		return html;
	}
	
	html += data.list.map(item => `
		<div class="card mb-4 shadow-sm">
	        <div class="card-body p-4">
	            <div class="d-flex justify-content-between align-items-start mb-3">
	                <div class="d-flex align-items-center">
	                    <img src="${item.reviewImageFilename}" 
	                         class="rounded me-3" 
	                         alt="${item.productName}" 
	                         style="width: 60px; height: 60px; object-fit: cover;"
	                         onerror="this.onerror=null;this.src=' ';">
	                    <div>
	                        <small class="text-muted">작성일: ${new Date(item.reviewDate).toLocaleDateString()}</small>
	                        <h5 class="card-title mb-0 fw-semibold">${item.productName}</h5>
	                    </div>
	                </div>
	                <div class="dropdown">
	                    <button class="btn btn-light btn-sm rounded-circle" type="button" data-bs-toggle="dropdown" aria-expanded="false" style="width: 32px; height: 32px;">
	                        <iconify-icon icon="mdi:dots-vertical" class="align-middle"></iconify-icon>
	                    </button>
	                    <ul class="dropdown-menu dropdown-menu-end">
	                        <li><a class="dropdown-item" href="#">
	                            <iconify-icon icon="mdi:pencil-outline" class="me-2"></iconify-icon>수정하기
	                        </a></li>
	                        <li><a class="dropdown-item text-danger" href="#">
	                            <iconify-icon icon="mdi:trash-can-outline" class="me-2"></iconify-icon>삭제하기
	                        </a></li>
	                    </ul>
	                </div>
	            </div>	
	            <div class="mb-3 d-flex align-items-center">
	                <div class="me-2">
	                    ${[...Array(5)].map((_, i) => `
	                        <iconify-icon icon="${i < item.star ? 'mdi:star' : 'mdi:star-outline'}" class="text-warning fs-5"></iconify-icon>
	                    `).join('')}
	                </div>
	                <span class="fw-bold text-warning align-middle">${item.star.toFixed(1)}</span>
	            </div>
	
	            <p class="card-text text-secondary mb-3">${item.content.replace(/\n/g, '<br>')}</p>
	
	            ${item.reviewImageList && item.reviewImageList.length > 0 ? `
	            <div class="review-images d-flex overflow-auto mb-3 pb-2">
	                ${item.reviewImageList.map(imgUrl => `
	                    <img src="${imgUrl}" class="rounded me-2" alt="리뷰 이미지" style="width: 90px; height: 90px; object-fit: cover; cursor: pointer;">
	                `).join('')}
	            </div>
	            ` : ''}
	
	            <div class="d-flex justify-content-end align-items-center text-muted">
	                <iconify-icon icon="mdi:thumb-up-outline" class="me-1"></iconify-icon>
	                <span>도움돼요 ${item.helpfulCount}</span>
	            </div>
	        </div>
	    </div>
	`).join('');
	html += `</div>`;
	
	return html;
}

/**
 * 마이 페이지 - 리뷰 작성 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderReviewForm = function(orderDetailObject) {	
	// sample data
	orderDetailObject = {
		orderDetailNum:2,
		productImageUrl: contextPath + "/uploads/product/apple.jpg",
		productName:"햇살농장 유기농 사과 1박스(5kg)",
		orderDate:"2025-08-16",
		productNum:1
	}
	
	const html = `
	<div class="container-lg p-4 p-sm-5">
		<div class="mb-5">
			<h3 class="display-6 fw-bold text-dark">리뷰 작성</h3>
		</div>

		<h4 class="display-8 text-dark">이 상품 어떠셨나요?</h4>
		<div class="reivew-form-product-info d-flex align-items-center mb-4">
			<img src="${orderDetailObject.productImageUrl}" class="reivew-form-product-image me-3">
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
		    <label for="review" class="form-label">리뷰 내용</label>
		    <textarea class="form-control" id="review" name="review" rows="5" placeholder="솔직한 리뷰를 남겨주세요." maxlength="4000" required></textarea>
		  </div>
		  <div class="mb-3">
			<label for="reviewImages" class="form-label">사진 첨부 (선택)</label>
          	<input class="form-control" type="file" id="reviewImages" name="reviewImages" name="selectFile" multiple accept="image/*">
          </div>
		  <input type="hidden" name="productNum" value="${orderDetailObject.productNum}">
		  <div class="mt-4 d-grid">
		    <button type="button" class="btn btn-success btn-lg" onclick="insertReview(${orderDetailObject.orderDetailNum})">리뷰 등록</button>
		  </div>
		</form>
	</div>
	`
	$('#content').html(html);
	
}

/**
 * 상품 리뷰 등록
 * @param {string} orderDetailNum - 주문 상세 번호
 */
function insertReview(orderDetailNum) {
	let url = contextPath + '/api/myPage/reviews/' + orderDetailNum;
	const params = new FormData($('#reviewForm')[0]); 
	
	const fn = function(data) {
		// 나의 리뷰 불러오기
		loadContent('/api/myPage/reviews', renderMyReviewListHtml);
	}
	
	ajaxRequest(url, 'post', params, false, fn, true);
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
		<div class="qnaPaginate">
			${data.paging}
		</div>
	`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 상품 문의 페이징 처리
 * @param {number} page - 현재 페이지
 */
function listPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/myPage/qnas', renderMyQnaListHtml, parameter)
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
