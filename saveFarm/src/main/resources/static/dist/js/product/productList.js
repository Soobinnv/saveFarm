// 이벤트 핸들러 등록
$(function() {
	// 상품 이미지 링크
	$('#container').on('click', '.product-main-image', function() {
		const productNum = $(this).closest('.card').data('product-num');
		const classifyCode = Number($(this).closest('.card').data('classify-code'));
				
		location.href= `${contextPath}/products/${productNum}?classifyCode=` + classifyCode;
	});
	
	// 상품 상세
	$('#container').on('click', '.btn-product-info', function() {
		const productNum = $(this).closest('.card').data('product-num');
		const classifyCode = $(this).closest('.card').data('classify-code');
		
		location.href= `${contextPath}/products/${productNum}?classifyCode=` + classifyCode;
	});
	
	// 찜 등록 / 수정
	$('#container').on('click', '.btn-wish-save', function() {
		const productNum = $(this).closest('.card').data('product-num');
		
		updateWish(productNum, this);
	});
	
	// 장바구니
	$('#container').on('click', '.btn-cart', function() {
		sendOk('cart', this);
	});
	
});

$(function() {
	// 상품 검색
	$('.searchIcon').on('click', function() {
		let kwd = $('.searchInput').val().trim();
		if(kwd === '') {
			return false;
		}
		
		loadProducts("/api/products/normal", {kwd:kwd});
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
