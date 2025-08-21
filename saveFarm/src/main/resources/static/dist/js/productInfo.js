const contextPath = document.getElementById('web-contextPath').value;
 
// function sendOk(mode) -> product.js로 이동

function sendQna() {
	const isSecret = $('#qna-secret-check').checked;

	let url = contextPath + '/api/products/' + productNum + '/qnas';
	const title = $('#qna-title-input').val();
	const question = $('#qna-question-textarea').val();
	const secret = isSecret ? '1' : '0'; 
	const name = $('#user-name').val();

	const params = {
		title: title,
		question: question,
		secret: secret
	};
	
	const fn = function(data) {
		loadContent('/api/products/' + productNum + '/qnas', setupQnaVirtualScroll);
	}
	
	$('#qnaFormModal').modal('hide');
	
	ajaxRequest(url, 'post', params, 'json', fn);
}