// 상품 상세 페이지 - 이벤트 처리 및 기능 // 

const productNum = $('#product-productNum').val();
const urlParams = new URLSearchParams(window.location.search);
const classifyCode = urlParams.get('classifyCode');

// 이벤트 핸들러 등록
$(function() {
	// 상품 상세 / 상품 리뷰 / 상품 반풀, 환불 / 상품 문의
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
	            loadContent('/api/products/' + productNum, renderProductDetailHtml, {classifyCode:classifyCode}); 
	            break;
	        case 'nav-review-tab':
	            loadContent('/api/products/' + productNum + '/reviews', renderProductReviewHtml);  
	            break;
	        case 'nav-refund-tab':
	            renderRefund(); 
	            break;
	        case 'nav-qna-tab':
	        	loadContent('/api/products/' + productNum + '/qnas', setupQnaVirtualScroll); 
	            break;
    	}
	});
	
	// 문의 하기
	$('#productInfoLayout').on('click', '.btn-product-qna', function() {
		sendQna();
	});
	
	// 환불 하기
	$('#productInfoLayout').on('click', '.btn-refund', function() {
		location.href=`${contextPath}/myPage`;
	});
	
	// 반품 하기
	$('#productInfoLayout').on('click', '.btn-return', function() {
		location.href=`${contextPath}/myPage`;
	});
	
	
});

$(function() {
	// 상품 분류 코드 확인
	const urlParams = new URLSearchParams(window.location.search);
	const classifyCode = urlParams.get('classifyCode');
	
	if (classifyCode === '200') {
		// 구출 상품 타이머 호출
	    startTimers();
	}
})



