function sendOk(mode) {
	const contextPath = document.getElementById('web-contextPath').value;
	$('.quantity').each(function() {
		let qty = parseInt($(this).text());

		totalQty = qty;
		
		$('#qty').val(totalQty);
	});

	if (totalQty <= 0) {
		alert('구매 상품의 수량을 선택하세요 !!! ');
		return;
	}

	const f = document.buyForm;
	if (mode === 'buy') {
		// GET 방식으로 전송. 로그인 후 결제화면으로 이동하기 위해
		// 또는 자바스크립트 sessionStorage를 활용 할 수 있음
		f.method = 'get';
		f.action = contextPath + '/order/payment';
	} else {
		if (!confirm('선택한 상품을 장바구니에 담으시겠습니까 ? ')) {
			return false;
		}

		f.method = 'post';
		f.action = contextPath + '/myShopping/saveCart';
	}

	f.submit();
}