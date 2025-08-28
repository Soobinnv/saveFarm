// 관리자 - 상품관리 paging // 
let paging = "";

const pagingManagement = function(methodName, params) {
	let page = $('#dataTables').data('page');
	let dataCount = $('#dataTables').data('datacount');
	let totalPage = $('#dataTables').data('totalpage');
	
	// 요청 파라미터 저장
	$('#dataTables').data('params', JSON.stringify(params));
	
	let schType = $('#dataTables').data('schtype');
	let kwd = $('#dataTables').data('kwd');	

	paging = pagingMethod(page, totalPage, methodName);
	
	$('.page-navigation').html(dataCount === 0 ? '' : paging);
	
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function productListPage(page) {
	const paramsString = $('#dataTables').data('params');
	// 요청 파라미터 가져오기
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,classifyCode:params.classifyCode};
	
	loadContent('/api/admin/products', renderProductListHTML, parameter, 'productListPage'); 
}

/**
 * 관리자 페이지 - 상품 관리 - 농가 상품 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function supplyListPage(page) {
	const paramsString = $('#dataTables').data('params');
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,state:params.state, size:params.size};
		
	loadContent('/api/admin/supplies', renderFarmProductListHTML, parameter, 'supplyListPage'); 
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 문의 페이징 처리
 * @param {number} page - 현재 페이지
 */
function inquiryListPage(page) {
	const paramsString = $('#dataTables').data('params');
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,isAnswerd:params.isAnswerd};
	
	loadContent('/api/admin/inquiries', renderProductQnaListHTML, parameter, 'inquiryListPage');
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 리뷰 페이징 처리
 * @param {number} page - 현재 페이지
 */
function reviewListPage(page) {
	const paramsString = $('#dataTables').data('params');
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,reviewBlock:params.reviewBlock};
	
	loadContent('/api/admin/reviews', renderProductReviewListHTML, parameter, 'reviewListPage');
}

/**
 * 관리자 페이지 - 고객 서비스 - 환불 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function refundListPage(page) {
	const paramsString = $('#dataTables').data('params');
	// 요청 파라미터 가져오기
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,type:"refund"};
	
	loadContent('/api/admin/claims', renderRefundListHTML, parameter, 'refundListPage'); 
}

/**
 * 관리자 페이지 - 고객 서비스 - 반품 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function returnListPage(page) {
	const paramsString = $('#dataTables').data('params');
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page,type:"return"};
		
	loadContent('/api/admin/claims', renderReturnListHTML, parameter, 'returnListPage'); 
}

/**
 * 관리자 페이지 - 고객 서비스 - 전체 클레임 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function allClaimListPage(page) {
	const paramsString = $('#dataTables').data('params');
	const params = JSON.parse(paramsString);
	
	let parameter = {pageNo:page};
	
	loadContent('/api/admin/claims', renderAllClaimListHTML, parameter, 'allClaimListPage');
}

