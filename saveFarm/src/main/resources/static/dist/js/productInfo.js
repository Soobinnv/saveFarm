const contextPath = document.getElementById('web-contextPath').value;

function sendOk(mode) {
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
		if (confirm('선택한 상품을 장바구니에 담으시겠습니까 ? ')) {
			const fn = function(data) {
				const state = data.state;
				
				if(state === 'false') {
					return false;
				}
			}
			
			f.method = 'post';
			f.action = contextPath + '/myShopping/saveCart';
		}
	}
	f.submit();	
}

function sendQna() {
	const questionDate = new Date();
	const isSecret = $('#qna-secret-check').checked;

	let url = contextPath + '/api/products/' + productNum + '/qnas';
	const title = $('#qna-title-input').val();
	const question = $('#qna-question-textarea').val();
	const secret = isSecret ? '1' : '0'; 
	const name = $('#user-name').val();
	
	
	const params = {
		title: title,
		question: question,
		secret: secret,
		name: name
	};
	
	const fn = function(data) {
		const qnaNum = data.qnaNum;
		
		const html = `
			<h4>상품 문의</h4>
			<div class="qna-list-wrapper mt-3">
				<div class="qna-list-header">
					<span class="qna-status">상태</span> 
					<span class="qna-title text-center">제목</span> 
					<span class="qna-author">작성자</span>
					<span class="qna-date">등록일</span>
				</div>
			<div class="accordion accordion-flush" id="qna-list-body">
			<div class="accordion-item" data-qnaNum="${qnaNum}">
				<h2 class="accordion-header">
					<button 
				        class="accordion-button collapsed type="button" aria-disabled="true">
						<span class="qna-status">답변대기</span>
						<span class="qna-title">${isSecret? '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 17c1.1 0 2-.9 2-2s-.9-2-2-2s-2 .9-2 2s.9 2 2 2m6-9h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2m-6 9c-2.21 0-4-1.79-4-4s1.79-4 4-4s4 1.79 4 4s-1.79 4-4 4M9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2z"></path></svg> ' : ''}
							${question}
						</span>
						<span class="qna-author">${name}</span>
						<span class="qna-date">${questionDate.toLocaleString()}</span>
					</button>
				</h2>
			</div>
		`;
		
		$('#productInfoLayout').html(html);
	}
	
	$('#qnaFormModal').modal('hide');
	
	ajaxRequest(url, 'post', params, 'json', fn);
}