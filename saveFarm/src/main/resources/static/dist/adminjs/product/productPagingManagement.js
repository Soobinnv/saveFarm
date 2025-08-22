// 관리자 - 상품관리 paging // 
let paging = "";

const pagingManagement = function(methodName) {
	let page = $('#dataTables').data('page');
	let dataCount = $('#dataTables').data('datacount');
	let totalPage = $('#dataTables').data('totalpage');
	
	let schType = $('#dataTables').data('schtype');
	let kwd = $('#dataTables').data('kwd');	

	paging = pagingMethod(page, totalPage, methodName);
	
	$('.page-navigation').html(dataCount === 0 ? '목록이 없습니다.' : paging);
	
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function productListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/admin/products', renderProductListHTML, parameter, 'productListPage'); 
}

/**
 * 관리자 페이지 - 상품 관리 - 농가 상품 리스트 페이징 처리
 * @param {number} page - 현재 페이지
 */
function supplyListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/admin/supplies', renderFarmProductListHTML, parameter, 'supplyListPage'); 
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 문의 페이징 처리
 * @param {number} page - 현재 페이지
 */
function inquiryListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/admin/inquiries', renderProductQnaListHTML, parameter, 'inquiryListPage');
}

/**
 * 관리자 페이지 - 상품 관리 - 상품 리뷰 페이징 처리
 * @param {number} page - 현재 페이지
 */
function qnaListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/admin/reviews', renderProductReviewListHTML, parameter, 'qnaListPage');
}
