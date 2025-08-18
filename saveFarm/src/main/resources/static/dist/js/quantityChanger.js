$(function() {
	// plus 버튼
	$('#extraItems').on('click', 'button.btn-plus', function() {
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

	// minus 버튼
	$('#extraItems').on('click', 'button.btn-minus', function() {
		let $quantity = $(this).closest('div').find('.quantity');
		let quantity = Number($quantity.text());
		
		if(quantity > 1) {
			$quantity.text(quantity - 1);
			
			// 구매 개수 변경
			$quantity.attr('data-quantity', quantity - 1);					
		}
	});
	
})