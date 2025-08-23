// -- 관리자 상품 관리 - 이벤트 처리 및 기능 -- //

// 설정 객체 정의 - switch문 반복 제거
// - 메인 탭(상품 리스트, 농가 상품 등)
const mainTabConfig = {
    'productList': { url: '/api/admin/products', render: renderProductListHTML, page: 'productListPage' },
    'supplyManagement': { url: '/api/admin/supplies', render: renderFarmProductListHTML, page: 'supplyListPage' },
    'productQna': { url: '/api/admin/inquiries', render: renderProductQnaListHTML, page: 'inquiryListPage' },
    'productReview': { url: '/api/admin/reviews', render: renderProductReviewListHTML, page: 'qnaListPage' }
};

// - 상품 리스트 하위 탭(전체, 일반, 구출)
const productTabConfig = {
    'tab-product-all': { url: '/api/admin/products', params: '', page: 'productListPage', render: renderProductListHTML },
    'tab-product-normal': { url: '/api/admin/products', params: { classifyCode: 100 }, page: 'productListPage', render: renderProductListHTML },
    'tab-product-rescued': { url: '/api/admin/products', params: { classifyCode: 200 }, page: 'productListPage', render: renderProductListHTML }
};

// - 농가 상품 리스트 하위 탭(전체, 승인대기, 승인)
const supplyTabConfig = {
    'tab-status-all': { url: '/api/admin/supplies', params: '', page: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-unapproved': { url: '/api/admin/supplies', params: { state: 1 }, page: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-approved': { url: '/api/admin/supplies', params: { state: 2 }, page: 'supplyListPage', render: renderFarmProductListHTML }
};

// - 상품 문의 하위 탭(전체, 답변대기, 답변완료)
const qnaTabConfig = {
    'tab-status-all': { url: '/api/admin/inquiries', params: '', page: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-unanswered': { url: '/api/admin/inquiries', params: { isAnswerd: 0 }, page: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-answered': { url: '/api/admin/inquiries', params: { isAnswerd: 1 }, page: 'inquiryListPage', render: renderProductQnaListHTML }
};

// - 상품 리뷰 하위 탭(전체, 보임, 숨김)
const reviewTabConfig = {
    'tab-status-all': { url: '/api/admin/reviews', params: '', page: 'qnaListPage', render: renderProductReviewListHTML },
    'tab-status-visible': { url: '/api/admin/reviews', params: { reviewBlock: 0 }, page: 'qnaListPage', render: renderProductReviewListHTML },
    'tab-status-hidden': { url: '/api/admin/reviews', params: { reviewBlock: 1 }, page: 'qnaListPage', render: renderProductReviewListHTML }
};


// - 상세 정보 조회
const detailViewConfig = {
    'product': { baseUrl: '/api/admin/products/', idAttr: 'productNum', render: renderProductDetailHTML },
    'supply': { baseUrl: '/api/admin/supplies/', idAttr: 'supplyNum', render: renderProductListHTML },
    'productQna': { baseUrl: '/api/admin/inquiries/', idAttr: 'qnaNum', render: renderProductQnaDetailHTML },
    'productReview': { baseUrl: '/api/admin/reviews/', idAttr: 'reviewNum', render: renderProductReviewDetailHTML }
};


// 이벤트 핸들러 등록
$(function() {
	// 사이드바 상품 관리 - 상품 리스트 / 농가 상품 등록 / 상품 문의 / 상품 리뷰 tab
	$('#ui-elements-product').on('click', '.nav-link', function() {
		const navId = $(this).attr('id');
		const config = mainTabConfig[navId];
		
		if (config) {
			loadContent(config.url, config.render, '', config.page);
		}
	});
	
	// 테이블 - tab
	$('main').on('click', 'button.nav-link', function(e) {
		const navId = $(e.target).attr('id');
		const contentId = $(e.target).closest('div.card-body').attr('id');
		let config = '';
		
		switch (contentId) {
		    case 'product-card':
		        config = productTabConfig[navId];
		        break;
		    case 'supply-card':
		        config = supplyTabConfig[navId];
		        break;
		    case 'review-card':
		        config = reviewTabConfig[navId];
		        break;
		    case 'qna-card':
		        config = qnaTabConfig[navId];
		        break;
		    default:
		        return false;
		}
		
		if (config) {
			loadContent(config.url, config.render, config.params, config.page);
		}
	});
	
	// 상세 정보
	$('main').on('click', '#contentTable tbody tr', function(e) {
		if ($(e.target).closest('td').is(':last-child')) {
			// 드롭다운 버튼 클릭 시 이벤트 제외
		    return;
		}
		 
		const tableType = $('#contentTable').data('type');
		const config = detailViewConfig[tableType];
		
		if (config) {
			let url = config.baseUrl;
			// 상세 조회를 위한 id가 필요한 경우 URL 조합
			if (config.idAttr) {
				const entityId = $(this).data(config.idAttr);
				url += entityId;
			}
			loadContent(url, config.render, '');
		}
	});
});