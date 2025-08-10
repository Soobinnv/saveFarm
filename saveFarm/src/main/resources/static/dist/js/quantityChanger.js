$(function() {
	
	// plus 버튼
	let $plusBtns = $('.btn-plus');
	// minus 버튼
	let $minusBtns = $('.btn-minus');
	
	$plusBtns.on('click', function() {
		// p 태그
		let $quantity = $(this).closest('div').find('.quantity');
		// 수량
		let quantity = Number($quantity.text());
		// 재고
		let stock = $quantity.data('stock');
		
		if(quantity < stock) {
			$quantity.text(quantity + 1);
			
			// 구매 개수 변경	
			$quantity.attr('data-quantity', quantity + 1);	
		}
	});

	$minusBtns.on('click', function() {
		let $quantity = $(this).closest('div').find('.quantity');
		let quantity = Number($quantity.text());
		
		if(quantity > 1) {
			$quantity.text(quantity - 1);
			
			// 구매 개수 변경
			$quantity.attr('data-quantity', quantity - 1);					
		}
	});
	
})