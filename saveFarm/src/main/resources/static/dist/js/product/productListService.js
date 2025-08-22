// AJAX 등 서버 API 호출 //

const contextPath = document.getElementById('web-contextPath').value;

// 처음 접속 시 일반 상품, 구출 상품 리스트 호출
$(function() {	
	loadProducts("/api/products/rescued");
	loadProducts("/api/products/normal");
});

/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} kwd - 검색어
 * @param {Array<object>} data.list - 상품 객체 배열
 */
function loadProducts(url, params = '') {
	url = contextPath + url;
	
	// 추가 로딩 여부
	const isAppending = params && params.pageNo && params.pageNo > 1;
	
	const fn = function(data){
		
		
		if (data.productList && data.productList.length > 0) {
			const productHtml = renderProductListHtml(data);
			
			if (isAppending) {
				$('#productLayout').append(productHtml); // 내용 추가
			} else {
				$('#productLayout').html(productHtml); // 내용 교체
			}
		} else if(data.rescuedProductList && data.rescuedProductList.length > 0) {
			const rescuedProductHtml = renderRescuedProductListHtml(data);
			$('#rescuedProductLayout').html(rescuedProductHtml);	
			
			// 구출 상품 타이머 호출
			startTimers();
		} 
		
		updateInfiniteScroll(data);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}


