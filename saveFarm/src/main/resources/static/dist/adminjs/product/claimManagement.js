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