// 관리자 상품 관리 - 이벤트 처리 및 기능 // 

// 이벤트 핸들러 등록
$(function() {
	// 상품 리스트 / 농가 상품 등록 / 상품 문의 / 상품 리뷰
	$('#ui-elements-product').on('click', '.nav-link',function() {
		
		// 다른 비활성화 tab - css 적용
		$('.nav-link').removeClass('activeTab');
		
		// 활성화 tab - css 적용
		$(this).addClass('activeTab');
		
		// 선택한 tab id
		let navId = $(this).attr('id');
		
		let params = '';
		
		// tab 컨텐츠 AJAX 요청 및 렌더링
		switch (navId) {
	    	case 'productList':
	            loadContent('/api/admin/products', renderProductListHTML, params, 'productListPage'); 
	            break;
	        case 'supplyManagement':
	            loadContent('/api/admin/supplies', renderFarmProductListHTML, params, 'supplyListPage');  
	            break;
	        case 'productQna':				
				loadContent('/api/admin/inquiries', renderProductQnaListHTML, params, 'inquiryListPage');  
				break;
	        case 'productReview':
	        	loadContent('/api/admin/reviews', renderProductReviewListHTML, params, 'qnaListPage');  
				break;
    	}
	});
});