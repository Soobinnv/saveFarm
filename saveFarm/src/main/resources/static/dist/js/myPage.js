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

