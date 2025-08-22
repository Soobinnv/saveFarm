// AJAX 등 서버 API 호출 //

const webContextPath = document.getElementById('web-contextPath').value;

/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} url - URL (contextPath 제외)
 * @param {Function} renderFn - AJAX 응답 데이터를 인자로 받아 HTML 문자열을 반환하는 callback 함수
 */
function loadContent(url, renderFn, params = '') {
	// 요청 경로 생성
	url = webContextPath + url;
	// 렌더링할 HTML 요소 선택자
	let selector = 'main';
	
	const fn = function(data) {
		const html = renderFn(data);
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

