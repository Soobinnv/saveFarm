document.getElementById("selectAll").addEventListener("change", function () {
    const checkboxes = document.querySelectorAll(".itemCheckbox");
    checkboxes.forEach(cb => cb.checked = this.checked);
});

document.querySelectorAll(".itemCheckbox").forEach(cb => {
    cb.addEventListener("change", function () {
        const allChecked = document.querySelectorAll(".itemCheckbox:checked").length === document.querySelectorAll(".itemCheckbox").length;
        document.getElementById("selectAll").checked = allChecked;
    });
});	


$(function(){
	let cartSize = Number('${list.size()}') || 0;
	if(cartSize !== 0) {
		$('.cart-selectAll').prop('checked', true);
		$('form input[name=nums]').prop('checked', true);
	}
	
    $('.cart-selectAll').click(function() {
    	$('form input[name=nums]').prop('checked', $(this).is(':checked'));
    });
    
    $('form input[name=nums]').click(function() {
		$(".cart-selectAll").prop("checked", $("form input[name=nums]").length === $("form input[name=nums]:checked").length);
   });
});

function sendOk() {
	// 구매하기
	const f = document.cartForm;
	
	let cnt = $('form input[name=nums]:checked').length;
    if (cnt === 0) {
		alert('구매할 상품을 먼저 선택 하세요 !!!');
		return;
    }
    
    let b = true;
    $('form input[name=nums]').each(function(index, item) {
		if($(this).is(':checked')) {
			let totalStock = Number($(this).attr('data-stockQuantity'));
			let $tr = $(this).closest('tr');
			let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
			if(qty > totalStock) {
				b = false;
				return false;
			}
		}
	});
    
    if( ! b) {
		alert('상품 재고가 부족합니다.')
		return;
    }
    
    $('form input[name=nums]').each(function(index, item){
		if(! $(this).is(':checked')) {
			$(this).closest('tr').remove();
		}
	});
    
	f.action = '${pageContext.request.contextPath}/order/payment';
	f.submit();
}

function deleteCartAll() {
	// 장바구니 비우기
	if(! confirm('장바구니를 비우시겠습니까 ? ')) {
		return;
	}

	location.href = '${pageContext.request.contextPath}/myShopping/deleteCartAll';	
}

function deleteCartSelect() {
	// 선택된 항목 삭제
	let cnt = $('form input[name=nums]:checked').length;
    if (cnt === 0) {
		alert('삭제할 상품을 먼저 선택 하세요 !!!');
		return;
    }
    
	if(! confirm('선택한 상품을 장바구니에서 비우시겠습니까 ? ')) {
		return;
	}
	
	const f = document.cartForm;
	f.action = '${pageContext.request.contextPath}/myShopping/deleteListCart';
	f.submit();
}

function deleteCartItem(productNum) {
	// 하나의 항목 삭제
	if(! confirm('선택한 상품을 장바구니에서 비우시겠습니까 ? ')) {
		return;
	}

	location.href = '${pageContext.request.contextPath}/myShopping/deleteCart?productNum=' + productNum;	
}

$(function(){
	$('.btn-minus').click(function() {
		const $tr = $(this).closest('tr');
		let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
		let price = Number($tr.find('input[name=prices]').val()) || 0;
		let salePrice = Number($tr.find('input[name=salePrices]').val()) || 0;
		
		if(qty <= 1) {
			return false;
		}
		
		qty--;
		$tr.find('input[name=buyQtys]').val(qty);
		let total = salePrice * qty;
		
		$tr.find('.productMoneys').text(total.toLocaleString());
		$tr.find('input[name=productMoneys]').val(total);
	});

	$('.btn-plus').click(function(){
		const $tr = $(this).closest('tr');
		let totalStock = Number($tr.find('input[name=nums]').attr('data-stockQuantity'));
		
		let qty = Number($tr.find('input[name=buyQtys]').val()) || 1;
		let price = Number($tr.find('input[name=prices]').val()) || 0;
		let salePrice = Number($tr.find('input[name=salePrices]').val()) || 0;
		
		if(totalStock <= qty) {
			alert('상품 재고가 부족 합니다.');
			return false;
		}
		
		if(qty >= 99) {
			return false;
		}
		
		qty++;
		$tr.find('input[name=buyQtys]').val(qty);
		let total = salePrice * qty;
		
		$tr.find('.productMoneys').text(total.toLocaleString());
		$tr.find('input[name=productMoneys]').val(total);
	});
});

$(function(){
	
	let totalMoney = 0;
	const $div = $('.summary');
    $('form input[name=nums]').each(function(index, item) {
		if($(this).is(':checked')) {
			totalMoney += Number($(this).attr('data-productMoney'));
		}
	});
    
    $div.find('.total-money').text(totalMoney.toLocaleString);
    
});