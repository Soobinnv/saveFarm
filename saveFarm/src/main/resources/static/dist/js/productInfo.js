const contextPath = document.getElementById('web-contextPath').value;

function sendQna() {
	const questionDate = new Date();
	
	// 날짜/시간 형식 지정
	const year = questionDate.getFullYear();
	const month = String(questionDate.getMonth() + 1).padStart(2, '0');
	const day = String(questionDate.getDate()).padStart(2, '0');
	const hours = String(questionDate.getHours()).padStart(2, '0');
	const minutes = String(questionDate.getMinutes()).padStart(2, '0');

	const formattedDate = `${year}-${month}-${day}-${hours}:${minutes}`;
	
	const isSecret = $('#qna-secret-check').checked;

	let url = contextPath + '/api/products/' + productNum + '/qnas';
	const title = $('#qna-title-input').val();
	const question = $('#qna-question-textarea').val();
	const secret = isSecret ? '1' : '0'; 
	const name = $('#user-name').val();
	
		
	// 이름 마스킹
	if (name.length === 3) {
		maskedName = name[0] + "*" + name[2];
	} else if (name.length === 4) {
		maskedName = name[0] + "**"+ name[3];
	} else {
		maskedName = name[0] + "*";
	}
	
	const params = {
		title: title,
		question: question,
		secret: secret,
		name: name
	};
	
	const fn = function(data) {
		const qnaNum = data.qnaNum;
		let html = "";
		let newQuestionHTML =`
			<div class="accordion-item" data-qnaNum="${qnaNum}">
				<h2 class="accordion-header">
					<button 
				        class="accordion-button collapsed type="button" aria-disabled="true">
						<span class="qna-status">답변대기</span>
						<span class="qna-title">${isSecret? '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 17c1.1 0 2-.9 2-2s-.9-2-2-2s-2 .9-2 2s.9 2 2 2m6-9h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2m-6 9c-2.21 0-4-1.79-4-4s1.79-4 4-4s4 1.79 4 4s-1.79 4-4 4M9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2z"></path></svg> ' : ''}
							${question}
						</span>
						<span class="qna-author">${maskedName}</span>
						<span class="qna-date">${formattedDate}</span>
					</button>
				</h2>
			</div>
		`;
		
		// 문의 목록이 있는 경우
		if($('#productInfoLayout').find('#qna-list-body').length !== 0) {
			$('#qna-list-body').prepend(newQuestionHTML);
						
			// 문의가 10개 이상인 경우
			if($('#qna-list-body').find('.accordion-item').length >= 10) {
				
				$('#qna-list-body').find('.accordion-item').last().remove();
			}
			
		} else {
			html = `
				<h4>상품 문의</h4>
				<div class="qna-list-wrapper mt-3">
					<div class="qna-list-header">
						<span class="qna-status">상태</span> 
						<span class="qna-title text-center">제목</span> 
						<span class="qna-author">작성자</span>
						<span class="qna-date">등록일</span>
					</div>
					<div class="accordion accordion-flush" id="qna-list-body">
						${newQuestionHTML}
					</div>
				</div>
			`;
	
			$('#productInfoLayout').html(html);
		}	
		
	}
	
	$('#qnaFormModal').modal('hide');
	
	ajaxRequest(url, 'post', params, 'json', fn);
}