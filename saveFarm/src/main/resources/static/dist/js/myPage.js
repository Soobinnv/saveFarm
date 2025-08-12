const contextPath = $('body').data('context-path');

// 처음 페이지 로딩 시
$(function() {
	// 상품 상세 출력
	loadContent('/api/myPage', renderMyPageMainHtml);
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
		<div class="container-lg p-4 p-sm-5">
			<div class="mb-5">
				<h1 class="display-5 fw-bold text-dark">찜한 상품</h1>
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
                            <span class="fs-5 fw-bold text-danger me-2">${item.discountRate}%</span>
                            <span class="text-muted text-decoration-line-through me-3">${item.unitPrice}</span>
                            <span class="fs-5 fw-bold text-dark">${item.discountedPrice}</span>
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

