$(function() {
	let $plusBtn = $('#btn-plus');
	let $minusBtn = $('#btn-minus');
	
	$plusBtn.on('click', function() {
		let quantity = $('#quantity').text();
		let stock = $('#quantity').data('stock');
		
		if(quantity < stock) {
			$('#quantity').text(Number(quantity) + 1);	
			$('#quantity').attr('data-quantity', Number(quantity) + 1);	
		}
	});

	$minusBtn.on('click', function() {
		let quantity = $('#quantity').text();
		
		if(quantity > 1) {
			$('#quantity').text(Number(quantity) - 1);
			$('#quantity').attr('data-quantity', Number(quantity) - 1);					
		}
	});
	
})