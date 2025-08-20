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
		
		console.log(classifyCode);
		
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
		
		loadProducts(kwd);
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


// 마감 임박 구출 상품 타이머
const startTimers = function() {
    $('.deadline-timer').each(function() {
        const $timerEL = $(this);
        
        const deadline = $timerEL.data('deadline');
        const deadlineTime = new Date(deadline).getTime();
        
        const $timeLeftEL = $timerEL.find('.time-left');

		// 1초마다 무한 반복
        const intervalId = setInterval(() => {
            const now = new Date().getTime();
            const distance = deadlineTime - now;

            // 시간이 남았을 경우
            if (distance > 0) {
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                
                $timeLeftEL.text(
                    `${String(hours).padStart(2, '0')}:${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')} 남음`
                );

            } else {
				// 타이머 종료
                clearInterval(intervalId);
                $timeLeftEL.text('마감');
            }
        }, 1000);
    });
};
