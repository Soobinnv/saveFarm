// -- 관리자 상품 관리 - 이벤트 처리 및 기능 -- //

// 설정 객체 정의 - switch문 반복 제거

// - 메인 탭(상품 리스트, 농가 상품 등)
const mainTabConfig = {
    'productList': { url: '/api/admin/products', render: renderProductListHTML, pagingMethodName: 'productListPage'},
    'supplyManagement': { url: '/api/admin/supplies', render: renderFarmProductListHTML, pagingMethodName: 'supplyListPage' },
    'productQna': { url: '/api/admin/inquiries', render: renderProductQnaListHTML, pagingMethodName: 'inquiryListPage' },
    'productReview': { url: '/api/admin/reviews', render: renderProductReviewListHTML, pagingMethodName: 'qnaListPage' }
};

// - 상품 리스트 하위 탭(전체, 일반, 구출)
const productTabConfig = {
    'tab-product-all': { url: '/api/admin/products', params: '', pagingMethodName: 'productListPage', render: renderProductListHTML},
    'tab-product-normal': { url: '/api/admin/products', params: { classifyCode: 100 }, pagingMethodName: 'productListPage', render: renderProductListHTML},
    'tab-product-rescued': { url: '/api/admin/products', params: { classifyCode: 200 }, pagingMethodName: 'productListPage', render: renderProductListHTML}
};

// - 농가 상품 리스트 하위 탭(전체, 승인대기, 승인)
const supplyTabConfig = {
    'tab-status-all': { url: '/api/admin/supplies', params: '', pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-unapproved': { url: '/api/admin/supplies', params: { state: 1 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML },
    'tab-status-approved': { url: '/api/admin/supplies', params: { state: 2 }, pagingMethodName: 'supplyListPage', render: renderFarmProductListHTML }
};

// - 상품 문의 하위 탭(전체, 답변대기, 답변완료)
const qnaTabConfig = {
    'tab-status-all': { url: '/api/admin/inquiries', params: '', pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-unanswered': { url: '/api/admin/inquiries', params: { isAnswerd: 0 }, pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML },
    'tab-status-answered': { url: '/api/admin/inquiries', params: { isAnswerd: 1 }, pagingMethodName: 'inquiryListPage', render: renderProductQnaListHTML }
};

// - 상품 리뷰 하위 탭(전체, 보임, 숨김)
const reviewTabConfig = {
    'tab-status-all': { url: '/api/admin/reviews', params: '', pagingMethodName: 'qnaListPage', render: renderProductReviewListHTML },
    'tab-status-visible': { url: '/api/admin/reviews', params: { reviewBlock: 0 }, pagingMethodName: 'qnaListPage', render: renderProductReviewListHTML },
    'tab-status-hidden': { url: '/api/admin/reviews', params: { reviewBlock: 1 }, pagingMethodName: 'qnaListPage', render: renderProductReviewListHTML }
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
			loadContent(config.url, config.render, '', config.pagingMethodName);
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
	
	// 재고 버튼
	$('main').on('click', '.stock-edit-btn', function(e) {
		const $btnEL = $(e.target);
		const productNum = $btnEL.attr('data-num');
		const productName = $btnEL.attr('data-name');
		const unit = $btnEL.attr('data-unit');
		const stock = $btnEL.attr('data-stock');

		$('main').html(renderStockEditHTML(productNum, productName, unit, stock));
				
	});

	// 상품 정보 변경 UI 버튼
	$('main').on('click', '.product-edit-btn', function(e) {
		const num = $(e.target).attr('data-num');
		
		loadContent(`/api/admin/products/${num}`, renderProductEditHTML, '');	
	});
	
	// 리뷰 상태 변경 버튼
	$('main').on('click', '.review-update-block', function(e) {
		const $btnEL = $(e.target);
		const num = $btnEL.attr('data-num');
		const updateBlockCode = $btnEL.attr('data-status') === '보임' ? 1 : 0;
		const statusText = $btnEL.attr('data-status') === '보임' ? '숨김': '보임';
		const params = {reviewBlock:updateBlockCode};
		
		let url = `/api/admin/reviews/${num}`;
		
		const fn = function(data) {
			// UI 변경
			$btnEL.closest('tbody').find('td.status-block').text(statusText);
			$btnEL.attr('data-status', statusText)
		}
		
		ajaxRequest(url, 'put', params, 'json', fn);
	});
	
	// 리뷰 삭제 버튼
	$('main').on('click', '.review-delete', function(e) {
		const num = $(e.target).attr('data-num');
		
		if(! confirm("리뷰를 삭제하시겠습니까?")) {
			return false;
		}
		
		loadContent(`/api/admin/reviews/${num}`, renderProductReviewListHTML, '', 'qnaListPage', 'delete');	
	});
	
	// 재고 조정 수량 입력
	$('main').on('keyup', '#stock-quantity-input', function(e) {
		let mode = $('#stock-change-type').val();
		let stock = Number($('#data-stock').attr('data-stock'));
		let adjStock = Number($(e.target).val());
		let afterStock = Number($('#stock-after-quantity').val());
		
		if(mode === 'in') {
			afterStock = stock + adjStock;
			$('#stock-after-quantity').val(afterStock);
		} else if(mode === 'out') {
			afterStock = stock - adjStock;
			$('#stock-after-quantity').val(afterStock);			
		}
	});
	
	// 재고 조정 유형 변경
	$('main').on('change', '#stock-change-type', function(e) {
		let mode = $(e.target).val();
		let stock = Number($('#data-stock').attr('data-stock'));
		let adjStock = Number($('#stock-quantity-input').val());
		let afterStock = Number($('#stock-after-quantity').val());
		
		if(mode === 'in') {
			afterStock = stock + adjStock;
			$('#stock-after-quantity').val(afterStock);
		} else if(mode === 'out') {
			afterStock = stock - adjStock;
			$('#stock-after-quantity').val(afterStock);			
		}
	});
	
	// 재고 저장 버튼
	$('main').on('click', '#save-stock-btn', function(e) {
		const num = $(e.target).attr('data-num');
		let afterStock = Number($('#stock-after-quantity').val());
		
		const fn = function(data) {
			loadContent('/api/admin/products', renderProductListHTML, '', 'productListPage');
		}
				
		ajaxRequest(`/api/admin/products/${num}`, 'put', {stockQuantity:afterStock}, 'json', fn);		
	});
	
	// 상품 등록/변경 저장 버튼
	$('main').on('click', '.product-save-btn, #save-product-btn', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		const currentRow = $(e.target).closest('.product-edit-row');
		
		const method = $(e.target).attr('data-method');
		
		let params = null;
		
		const fn = function(data) {
			loadContent('/api/admin/products', renderProductListHTML, '', 'productListPage');
		}
		
		if(method === 'post') {
			
			const productForm = $('#product-form');
			params = new FormData(productForm[0]);
			ajaxRequest(`/api/admin/products`, method, params, 'json', fn, true, 'multipart');	
		} else if(method === 'put') {
			params = getProductData(currentRow);		
			ajaxRequest(`/api/admin/products/${num}`, method, params, 'json', fn);	
		}
		
	});
	
	// 상품 등록 폼 버튼
	$('main').on('click', '#btn-product-insert', function(e) {
		$('main').html(renderProductFormHTML);		
	});

	// 상품 분류에 따른 상품 등록 UI 변경
	$('main').on('change', '#productClassification', function(e) {
		
		const $farmInfoSection = $('#farm-info-section');
        if (e.target.value === '200') {
			// 농가 번호 입력창 띄우기
            $farmInfoSection.removeClass('d-none');
        } else {
            $farmInfoSection.addClass('d-none');
        }
		
	});
	
});

// 상품 수정 데이터
function getProductData(editRow) {
  const productNum = editRow.data('product-num');

  const productName = editRow.find('#productName').val();
  const productClassification = editRow.find('#productClassification').val();
  const productDesc = editRow.find('#productDesc').val();
  const unitPrice = editRow.find('#unitPrice').val();
  const unit = editRow.find('#unit').val();
  const farmName = editRow.find('#farmName').val();
  const endDate = editRow.find('#endDate').val();
  
  // const productImageFilename = editRow.find('#productImageFile').prop('files')[0];

  return {
    productNum,
    productName,
    productClassification,
    productDesc,
    unitPrice,
    unit,
    farmName,
    endDate
    // productImageFilename
  };
}