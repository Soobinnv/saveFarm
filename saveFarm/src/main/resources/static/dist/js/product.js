function sendOk(mode, btnEL) {
	let totalQty = 0;
	let currentPage = "info";
	
	if($('.quantity').length !== 0) {
		// '상품 정보'에서 장바구니에 담는 경우
		$('.quantity').each(function() {
			let qty = parseInt($(this).text());
	
			totalQty = qty;
			
			$('#qty').val(totalQty);
		});
		
		if (totalQty <= 0) {
			alert('구매 상품의 수량을 선택하세요 !!! ');
			return;
		}
		
	} else {
		// '상품 목록'에서 장바구니에 담는 경우
		$('#qty').val(1);
		currentPage = "list";
	}
	
	let f = $('form[name="buyForm"]');
	
	if(currentPage === "list") {
		f = $(btnEL).closest('form[name="buyForm"]');
	}
	
	if (mode === 'buy') {
		// GET 방식으로 전송. 로그인 후 결제화면으로 이동하기 위해
		// 또는 자바스크립트 sessionStorage를 활용 할 수 있음
		f.attr('method', 'get');
		f.attr('action', contextPath + '/order/payment');
	} else {
		if (confirm('선택한 상품을 장바구니에 담으시겠습니까 ? ')) {
			const fn = function(data) {
				const state = data.state;
				
				if(state === 'false') {
					return false;
				}
			}
			
			f.attr('method', 'post');
			f.attr('action', contextPath + '/myShopping/saveCart');
			
		} else {
			return false;
		}
	}
	f.submit();	
}


/**
 * 상품 찜 등록 / 취소
 * @param {string} productNum - 상품 번호
 * @param {object} btnEL - 찜 버튼 요소
 */
function updateWish(productNum, btnEL) {
	let url = contextPath + '/api/products/' + productNum + '/wish';
	let params = "";
	
	// 찜 여부 0: false  / 1: true 
	let method = $(btnEL).data('wish') === 0 ? 'post' : 'delete';
	
	const fn = function(data) {
		if(method === 'post') {
			$(btnEL).find('.wishIcon').attr('icon', 'mdi:heart');
			$(btnEL).data('wish', 1);
		} else if(method === 'delete') {
			$(btnEL).find('.wishIcon').attr('icon', 'lucide:heart');		
			$(btnEL).data('wish', 0);			
		}
	}
	
	ajaxRequest(url, method, params, 'json', fn);
}

