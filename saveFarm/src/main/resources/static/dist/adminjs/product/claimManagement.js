// 관리자 클레임(환불, 반품) 관리 - 이벤트 처리 및 기능 //

// 이벤트 핸들러 등록
$(function() {
	// 통합 내역 상세 보기
	$('main').on('click', '#claimContentTable tbody tr', function(e) {
		
		const $tr = $(e.target).closest('tr');
		
		const num = $tr.attr('data-num');
		const type = $tr.attr('data-type');
		
		let url = '/api/admin/claims/' + num;
		let params = '';
		let render = '';
		
		switch(type) {
			case 'refund': 
				params = {type:"refund"};
				render = renderRefundHTML;
				break;
			case 'return': 
				params = {type:"return"};
				render = renderReturnHTML;
				break;
		}
		
		loadContent(url, render, params);
	});
});

function updateRefundStatus(num, status, orderQuantity=-1) {
	let msg = '';
	
	switch(status) {
		case 1: 
			msg = '환불 요청을 승인하시겠습니까 ?'
			break;
		case 2: 
			msg = '환불 처리를 완료하시겠습니까 ?'
			break;
		case 3: 
			msg = '환불을 기각하시겠습니까 ?'
			break;
	}
	
	if(! confirm(msg)) {
		return;
	}
	
	let url = '/api/admin/claims/' + num;
	const params = {listType:"refund", num:num, status:status, orderQuantity:orderQuantity};
	
	loadContent(url, renderRefundListHTML, params, 'refundListPage', 'patch');
}

function updateReturnStatus(num, status, orderQuantity=-1) {
	let msg = '';

	switch(status) {
		case 1: 
			msg = '반품 요청을 승인하시겠습니까 ?'
			break;
		case 2: 
			msg = '반품을 기각하시겠습니까 ?'
			break;
		case 3: 
			msg = '반품 및 교환 처리를 완료하시겠습니까 ?'
			break;
	}

	if(! confirm(msg)) {
		return;
	}
	
	let url = '/api/admin/claims/' + num;
	const params = {listType:"return", num:num, status:status, orderQuantity:orderQuantity};
	
	loadContent(url, renderReturnListHTML, params, 'returnListPage', 'patch');
}

function deleteRefund(num) {
	if(! confirm('클레임 내역을 삭제하시겠습니까 ?')) {
		return;
	}
	
	let url = '/api/admin/claims/' + num;
	const params = {type:"refund"};
	
	loadContent(url, renderRefundListHTML, params, 'refundListPage', 'delete');
}

function deleteReturn(num) {
	if(! confirm('클레임 내역을 삭제하시겠습니까 ?')) {
		return;
	}
	
	let url = '/api/admin/claims/' + num;
	const params = {type:"return"};
	
	loadContent(url, renderReturnListHTML, params, 'returnListPage', 'delete');
}