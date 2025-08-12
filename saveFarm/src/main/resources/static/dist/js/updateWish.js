/**
 * 상품 찜 등록 / 취소
 * @param {string} productNum - 상품 번호
 * @param {object} btnEL - 찜 버튼 요소
 */
function updateWish(productNum, btnEL) {
	let url = contextPath + '/api/products/' + productNum + '/wish';
	let params = "";
	
	// 찜 여부 0: false  / 1: true 
	let method = $(btnEL).data('wish') === 0 ? 'post' : 'delete';
	
	const fn = function(data) {
		if(method === 'post') {
			$(btnEL).find('.wishIcon').attr('icon', 'mdi:heart');
			$(btnEL).data('wish', 1);
		} else if(method === 'delete') {
			$(btnEL).find('.wishIcon').attr('icon', 'lucide:heart');		
			$(btnEL).data('wish', 0);			
		}
	}
	
	ajaxRequest(url, method, params, 'json', fn);
}