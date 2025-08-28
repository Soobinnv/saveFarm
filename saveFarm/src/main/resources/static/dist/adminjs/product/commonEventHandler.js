// 공통 이벤트 핸들러 정의 및 설정 객체 정의 //

// 설정 객체 정의 
// - 메인 탭(상품 리스트, 농가 상품 등)
const mainTabConfig = {
    'productList': { url: '/api/admin/products', render: renderProductListHTML, pagingMethodName: 'productListPage'},
    'supplyManagement': { url: '/api/admin/supplies', params: {size:10}, render: renderFarmProductListHTML, pagingMethodName: 'supplyListPage' },
    'productQna': { url: '/api/admin/inquiries', render: renderProductQnaListHTML, pagingMethodName: 'inquiryListPage' },
    'productReview': { url: '/api/admin/reviews', render: renderProductReviewListHTML, pagingMethodName: 'reviewListPage' },
    'refund': { url: '/api/admin/claims', params: {type:"refund"}, render: renderRefundListHTML, pagingMethodName: 'refundListPage' },
    'return': { url: '/api/admin/claims', params: {type:"return"}, render: renderReturnListHTML, pagingMethodName: 'returnListPage' },
    'refundReturn': { url: '/api/admin/claims', render: renderAllClaimListHTML, pagingMethodName: 'allClaimListPage' }
};

// - 상품 리스트 하위 탭(전체, 일반, 구출)
const productTabConfig = {
    'tab-product-all': { url: '/api/admin/products', params: '', pagingMethodName: 'productListPage', render: renderProductListHTML},
    'tab-product-normal': { url: '/api/admin/products', params: { classifyCode: 100 }, pagingMethodName: 'productListPage', render: renderProductListHTML},
    'tab-product-rescued': { url: '/api/admin/products', params: { classifyCode: 200 }, pagingMethodName: 'productListPage', render: renderProductListHTML}
};

// - 농가 상품 리스트 하위 탭(전체, 승인대기, 승인)
const supplyTabConfig = {
    'tab-status-all': { url: '/api/admin/supplies', params: {size:10}, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-unapproved': { url: '/api/admin/supplies', params: {size:10, state: 1 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-approved': { url: '/api/admin/supplies', params: {size:10, state: 2 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-shipping': { url: '/api/admin/supplies', params: {size:10, state: 4 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-delivered': { url: '/api/admin/supplies', params: {size:10, state: 5 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML }
};

// - 상품 문의 하위 탭(전체, 답변대기, 답변완료)
const qnaTabConfig = {
    'tab-status-all': { url: '/api/admin/inquiries', params: '', pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-unanswered': { url: '/api/admin/inquiries', params: { isAnswerd: 0 }, pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-answered': { url: '/api/admin/inquiries', params: { isAnswerd: 1 }, pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML }
};

// - 상품 리뷰 하위 탭(전체, 보임, 숨김)
const reviewTabConfig = {
    'tab-status-all': { url: '/api/admin/reviews', params: '', pagingMethodName: 'reviewListPage', render: renderProductReviewListHTML },
    'tab-status-visible': { url: '/api/admin/reviews', params: { reviewBlock: 0 }, pagingMethodName: 'reviewListPage', render: renderProductReviewListHTML },
    'tab-status-hidden': { url: '/api/admin/reviews', params: { reviewBlock: 1 }, pagingMethodName: 'reviewListPage', render: renderProductReviewListHTML }
};


// - 상세 정보 조회
const detailViewConfig = {
    'product': { baseUrl: '/api/admin/products/', idAttr: 'productNum', render: renderProductDetailHTML },
    'supply': { baseUrl: '/api/admin/supplies/', idAttr: 'supplyNum', render: renderFarmProductDetailHTML },
    'productQna': { baseUrl: '/api/admin/inquiries/', idAttr: 'qnaNum', render: renderProductQnaDetailHTML },
    'productReview': { baseUrl: '/api/admin/reviews/', idAttr: 'reviewNum', render: renderProductReviewDetailHTML },
    'refund': { baseUrl: '/api/admin/reviews/', idAttr: 'reviewNum', render: renderProductReviewDetailHTML },
    'return': { baseUrl: '/api/admin/reviews/', idAttr: 'reviewNum', render: renderProductReviewDetailHTML },
    'refundReturn': { baseUrl: '/api/admin/reviews/', idAttr: 'reviewNum', render: renderProductReviewDetailHTML },
};

// 이벤트 핸들러 등록
$(function() {
	// 사이드바 상품 관리 - 상품 리스트 / 농가 상품 등록 / 상품 문의 / 상품 리뷰 tab
	$('#ui-elements-product').on('click', '.nav-link', function() {
		const navId = $(this).attr('id');
		const config = mainTabConfig[navId];
		
		if (config) {
			loadContent(config.url, config.render, config.params, config.pagingMethodName);
		}
	});
	
	// 테이블 - 필터 tab, 상세 - 목록 불러오기 버튼
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
			loadContent(config.url, config.render, config.params, config.pagingMethodName);
		}
	});
	
	// 상세 보기
	$('main').on('click', '#contentTable tbody tr', function(e) {
		
		// 드롭다운 버튼 클릭 시
		if ($(e.target).closest('td').is(':last-child')) {
		    return;
		}
		 
		const tableType = $('#contentTable').data('type');
		const config = detailViewConfig[tableType];
		
		if (config) {
			let url = config.baseUrl;
			// 상세 조회를 위한 id
			if (config.idAttr) {
				const entityId = $(this).data(config.idAttr);
				url += entityId;
			}
			loadContent(url, config.render, '');
		}
	});
});