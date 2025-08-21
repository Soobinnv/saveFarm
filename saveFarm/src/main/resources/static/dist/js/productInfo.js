const contextPath = document.getElementById('web-contextPath').value;
 
// function sendOk(mode) -> product.js로 이동

function sendQna() {
	const isSecret = $('#qna-secret-check').checked;

	let url = contextPath + '/api/products/' + productNum + '/qnas';
	const title = $('#qna-title-input').val();
	const question = $('#qna-question-textarea').val();
	const secret = isSecret ? '1' : '0';

	const params = {
		title: title,
		question: question,
		secret: secret
	};
	
	const fn = function(data) {
		loadContent('/api/products/' + productNum + '/qnas', renderProductQnaHtml);
	}
	
	$('#qnaFormModal').modal('hide');
	
	ajaxRequest(url, 'post', params, 'json', fn);
}

/**
 * 리뷰 추천 등록 / 취소
 * @param {string} orderDetailNum - 주문 상세 번호(리뷰 테이블 기본키)
 * @param {object} btnEL - 추천 버튼 요소
 */
function updateReviewLike(orderDetailNum, btnEL) {
	let url = contextPath + '/api/reviews/' + orderDetailNum + '/like';
	let params = "";
	
	// 추천 여부 0: false  / 1: true 
	let method = $(btnEL).data('like') === 0 ? 'post' : 'delete';
	
	const fn = function(data) {
		if(method === 'post') {
			// 아이콘 변경
			$(btnEL).find('.likeIcon').attr('icon', 'teenyicons:thumb-up-solid');
			
			// 도움돼요 수
			let helpfulCount = $(btnEL).find('span').text();
			
			$(btnEL).find('span').text(Number(helpfulCount) + 1);
			$(btnEL).data('like', 1);
		} else if(method === 'delete') {
			$(btnEL).find('.likeIcon').attr('icon', 'teenyicons:thumb-up-outline');		
			
			let helpfulCount = $(btnEL).find('span').text();
			
			if(helpfulCount != 0) {
				$(btnEL).find('span').text(Number(helpfulCount) - 1);			
			}
			$(btnEL).data('like', 0);			
		}
	}
	
	ajaxRequest(url, method, params, 'json', fn);
}