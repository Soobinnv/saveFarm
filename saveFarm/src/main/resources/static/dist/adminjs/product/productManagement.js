// 관리자 상품 관리 - 이벤트 처리 및 기능 //


// 이벤트 핸들러 등록
$(function() {
		
	// 재고 등록 버튼 (납품 목록 등록)
	$('main').on('click', '.stock-insert-btn', function(e) {
		const $btnEL = $(e.target);
		const productNum = $btnEL.attr('data-num');
		const productName = $btnEL.attr('data-name');
		const unit = $btnEL.attr('data-unit');
		const stock = $btnEL.attr('data-stock');
		const varietyNum = $btnEL.attr('data-variety');

		const productInfo = {
			productNum,
			productName,
			unit,
			currentStock:stock
		};

		const fn = function(data) {
			const supplyList = data.list;
			
			$('main').html(renderStockUpdateFromSupplyHTML(productInfo, supplyList));
		}
		
		// 납품 목록 요청
		ajaxRequest('/api/admin/supplies', 'get', {state: 5, varietyNum: varietyNum}, 'json', fn);
			// state: 5 - 납품 완료 (재고 등록 전)			
	});
	
	// 재고 수정 버튼 (실사 조정)
	$('main').on('click', '.stock-edit-btn', function(e) {
		const $btnEL = $(e.target);
		const productNum = $btnEL.attr('data-num');
		const productName = $btnEL.attr('data-name');
		const unit = $btnEL.attr('data-unit');
		const stock = $btnEL.attr('data-stock');

		const productInfo = {
			productNum,
			productName,
			unit,
			stock
		};
		
		$('main').html(renderStockEditHTML(productInfo));
				
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
		
		loadContent(`/api/admin/reviews/${num}`, renderProductReviewListHTML, '', 'reviewListPage', 'delete');	
	});
	
	// 재고 수정 수량 입력
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
	
	// 재고 수정 유형 변경
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
	
	// 납품 내역 선택 - 조정 후 재고 반영 
	$('main').on('change', '.supply-checkbox', function(e) {
		const $checkboxEL = $(e.target);
		const quantity = Number($checkboxEL.attr('data-quantity'));
		let afterStock = Number($('#stock-after-quantity').val());
		
		if($checkboxEL.is(':checked')) {
			afterStock = afterStock + quantity;
		} else {
			afterStock = afterStock - quantity;			
		}
		
		$('#stock-after-quantity').val(afterStock);
	});
	
	// 재고 저장 버튼
	$('main').on('click', '#save-stock-btn', function(e) {
		const num = $(e.target).attr('data-num');
		let afterStock = Number($('#stock-after-quantity').val());
		
		const checkedSupplyNums = $('.supply-checkbox:checked').map(function() {
		    return parseInt($(this).attr('data-num'), 10);
		}).get();
		
		const fn = function(data) {
			loadContent('/api/admin/products', renderProductListHTML, '', 'productListPage');
		}
				
		ajaxRequest(`/api/admin/products/${num}`, 'patch', {stockQuantity:afterStock, supplyNums:checkedSupplyNums}, 'json', fn);		
	});
	
	// 상품 등록/변경 저장 버튼
	$('main').on('click', '.product-save-btn, #save-product-btn', function(e) {
		
		if(! validateProductForm()) {
			return false;
		}
		
		const num = $(e.target).attr('data-num') || 0;
		const currentRow = $(e.target).closest('.product-edit-row');
		
		const method = $(e.target).attr('data-method');
		
		let params = null;
		
		const fn = function(data) {
			loadContent('/api/admin/products', renderProductListHTML, '', 'productListPage');
		}
		
		const productForm = $('#product-form');
		params = new FormData(productForm[0]);
		
		if(method === 'post') {
			
			ajaxRequest(`/api/admin/products`, method, params, 'json', fn, true, 'multipart');	
		} else if(method === 'put') {
			
			ajaxRequest(`/api/admin/products/${num}`, method, params, 'json', fn, true, 'multipart');	
		}
		
	});
	
	// 커스텀 input(이미지) 이벤트 
	$('main').on('change', '#mainImage', function() {
	    const fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
	    $('.custom-file-upload .main-file-name').text(fileName);
	});
	
	// 커스텀 input(이미지) 이벤트 - 2
	$('main').on('change', '#subImages', function() {
	    const fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
	    $('.custom-file-upload .sub-file-name').text(fileName);
	});
	
	
	// 문의 답변 수정 버튼 - UI 변경
	$('main').on('click', '.btn-edit-answer', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		const answer = $('#answerBlock').text() || '';
		
		const answerButtonHTML =
		`
		<div class="d-flex mt-3">
			<button style="margin-right: 7px;" type="button" class="btn btn-primary btn-sm btn-submit-answer" data-num="${num}">답변 수정</button>
			<button type="button" class="btn btn-outline-primary btn-sm btn-delete-answer" data-num="${num}">답변 삭제</button>
		</div>
		`;
		
		const answerSectionHTML =
		`
		<h6 class="mt-3">답변 등록</h6>
		<textarea id="answer-content" class="form-control" rows="5" placeholder="답변을 입력하세요..." style="resize:none;">${answer}
		</textarea>
		`;		 
		
		$('#answerLayout').html(answerSectionHTML + answerButtonHTML);
	});
	
	// 문의 답변 등록/변경 저장 버튼
	$('main').on('click', '.btn-submit-answer', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		
		let params = null;
		
		const fn = function(data) {
			loadContent('/api/admin/inquiries', renderProductQnaListHTML, '', 'inquiryListPage');
		}

		// 문의 답변
		const answer = $('#answer-content').val();
		params = {answer:answer};		
			
		ajaxRequest(`/api/admin/inquiries/${num}`, 'put', params, 'json', fn);	
	});
	
	// 문의 삭제 버튼
	$('main').on('click', '.btn-delete-answer', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		
		if(! confirm('문의를 삭제하시겠습니까?')) {
			return false;
		}
		
		const fn = function(data) {
			loadContent('/api/admin/inquiries', renderProductQnaListHTML, '', 'inquiryListPage');
			
			alert('문의를 삭제하였습니다.');
		}
		
		ajaxRequest(`/api/admin/inquiries/${num}`, 'delete', '', 'json', fn);	
	});
	
	// 상품 삭제 버튼
	$('main').on('click', '.product-delete-btn', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		
		if(! confirm('상품을 삭제하시겠습니까?')) {
			return false;
		}
		
		const stock = $(e.target).attr('data-stock') || 1;
		
		if(stock > 0) {
			alert('납품정보가 있는 경우 상품을 삭제할 수 없습니다. 재고 수정 후 다시 시도해주세요.')
			return false;
		}
		
		const fn = function(data) {
			loadContent('/api/admin/products', renderProductListHTML, '', 'productListPage');
			
			alert('상품을 삭제하였습니다.');
		}
		
		ajaxRequest(`/api/admin/products/${num}`, 'delete', '', 'json', fn);
	});
	
	// 상품 등록 폼 버튼
	$('main').on('click', '#btn-product-insert', function() {
		
		// 카테고리 데이터 가져오기
		ajaxRequest('/api/admin/varietys', 'get', '', 'json', function(varietyData) {
			
			// 납품 데이터 가져오기
			ajaxRequest('/api/admin/supplies', 'get', {state:5}, 'json', function(supplyData) {
				
				const productFormHTML = renderProductFormHTML(varietyData.list, supplyData.list);
				
				$('main').html(productFormHTML);		
				
				// 카테고리 
				setupCategorySelection('varietyCategory', 'varietyCategoryList', 'varietyNum');
				
				// 카테고리 목록 숨기기
				$('#varietyCategoryList').hide();
			});
		});
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
	
	// 납품 목록 - 납품 상태 변경 버튼
	$('main').on('click', '.supply-update-state', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		const targetState = $(e.target).attr('data-target-state') || '';
		
		if(targetState === '2') {
			confirmMsg = '납품을 승인하시겠습니까?';
			afterStatus = '납품준비중';
		} else if(targetState === '3') {
			confirmMsg = '납품을 기각하시겠습니까?';			
			afterStatus = '기각';
		} else if(targetState === '5') {
			confirmMsg = '납품 완료 처리하시겠습니까?';			
			afterStatus = '납품완료';
		} else {
			return false;
		}
		
		if(! confirm(confirmMsg)) {
			return false;
		}
		
		const fn = function(data) {
			const $statusDivEL = $(e.target).closest('tr').find('.status-block');
			
			if($statusDivEL.length === 0) {
				// 납품 상세 페이지인 경우
				// -> 리스트 로드
				loadContent('/api/admin/supplies', renderFarmProductListHTML, {size:10}, 'supplyListPage');
			} else {
				// 납품 목록 페이지인 경우
				// -> UI - 상태 변경
				$statusDivEL.html(afterStatus);
			}
			
		}
		
		ajaxRequest(`/api/admin/supplies/${num}`, 'patch', {supplyNum:num, state:targetState}, 'json', fn);		
	});
	
	// 상품 등록 form - 납품 목록 선택 시 상품 카테고리 자동 갱신
	$('main').on('change', '.supply-input', function(e) {
		const varietyNum = $(e.target).attr('data-variety-num');
		const varietyName = $(e.target).attr('data-variety-name');
		const $categoryInputEL = $('#varietyCategory');
		const $hiddenInputEL = $('#varietyNum');
		
		if($(e.target).is(':checked')) {
			// 품종 변경 막기
			$categoryInputEL.attr('disabled', true);			
			// UI 품종명 변경
			$categoryInputEL.val(varietyName);
			// hidden value 변경
			$hiddenInputEL.val(varietyNum);
		} else {	
			$categoryInputEL.attr('disabled', false);			
			$categoryInputEL.val('');
			$hiddenInputEL.val('');
		}
		
	});
	
	// 상품 수정 form
	$('main').on('click', '.product-edit-btn', function(e) {
		const num = $(e.target).attr('data-num');
		
		loadContent(`/api/admin/products/${num}`, renderProductEditHTML);

	});
	
	// 일반 상품 선택 시 카테고리 초기화
	$('main').on('change', '#productClassification', function(e) {
		const $categoryInputEL = $('#varietyCategory');
		const $hiddenInputEL = $('#varietyNum');
		$categoryInputEL.attr('disabled', false);
		$categoryInputEL.val('');
		$hiddenInputEL.val('');
	});
	
	// 리뷰 목록 - 리뷰 상태 변경 버튼
	$('main').on('click', '.review-update-block', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		const status = $(e.target).attr('data-status') || '';
		let afterBlock = '-1';
		let afterStatus = '보임';
		
		if(status === '보임') {
			afterBlock = '1';
			confirmMsg = '리뷰를 숨김 처리하시겠습니까?';
			afterStatus = '숨김';
		} else if(status === '숨김') {
			afterBlock = '0'
			confirmMsg = '숨긴 리뷰를 게시하시겠습니까?';			
			afterStatus = '보임';
		} else {
			return false;
		}
		
		if(! confirm(confirmMsg)) {
			return false;
		}
		
		const fn = function(data) {
			const $statusDivEL = $(e.target).closest('tr').find('.status-block');
			
			// UI - 상태 변경
			$statusDivEL.html(afterStatus);
		}
		
		ajaxRequest(`/api/admin/reviews/${num}`, 'put', {orderDetailNum:num, reviewBlock:afterBlock}, 'json', fn);		
	});
	
	// 리뷰 상세 - 리뷰 상태 변경 버튼
	$('main').on('click', '.btn-review-block-update', function(e) {
		const num = $(e.target).attr('data-num') || 0;
		const block = $(e.target).attr('data-block') || 0;
		let afterBlock = '-1';
		
		if(block === '0') {
			afterBlock = '1';
			confirmMsg = '리뷰를 숨김 처리하시겠습니까?';
		} else if(block === '1') {
			afterBlock = '0'
			confirmMsg = '숨긴 리뷰를 게시하시겠습니까?';			
		} else {
			return false;
		}
		
		if(! confirm(confirmMsg)) {
			return false;
		}
		
		const fn = function(data) {
			loadContent('/api/admin/reviews', renderProductReviewListHTML, '', 'reviewListPage');
		}
		
		ajaxRequest(`/api/admin/reviews/${num}`, 'put', {orderDetailNum:num, reviewBlock:afterBlock}, 'json', fn);		
	});
	
	
});

// 상품 수정 데이터 반환
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

/**
 * 제품 카테고리(품종) 검색 및 선택 함수 
 */
function setupCategorySelection(categoryId, listId, hiddenInputId) {
	const searchInputEL = document.getElementById(categoryId);
	const categoryListEL = document.getElementById(listId);
	const hiddenInputEL = document.getElementById(hiddenInputId);
	const listItemsELS = categoryListEL.querySelectorAll('li');

	// 카테고리 선택 시 카테고리 목록 표시/숨김
	searchInputEL.addEventListener('click', () => {
		categoryListEL.style.display = categoryListEL.style.display === 'block' ? 'none' : 'block';
	});

	// 리스트 외부 클릭 시 숨김
	document.addEventListener('click', (event) => {
		if (!searchInputEL.contains(event.target) && !categoryListEL.contains(event.target)) {
			categoryListEL.style.display = 'none';
		}
	});

	// 카데고리 리스트 아이템 클릭 시 선택
	listItemsELS.forEach(item => {
		item.addEventListener('click', () => {
			const categoryNo = item.dataset.categoryNo;
			const categoryName = item.textContent;

			hiddenInputEL.value = categoryNo; // 히든에 번호 저장
			searchInputEL.value = categoryName; // 검색창에 이름 표시
			categoryListEL.style.display = 'none'; // 리스트 숨김

			// 유효성 검사 에러 메시지 제거 (선택 시)
			const errorDiv = document.getElementById(categoryId + 'Error');
			if (errorDiv) {
				errorDiv.textContent = '';
			}
		});
	});

	// 검색어를 직접 입력 시 리스트에 있는지 필터링
	searchInputEL.addEventListener('keyup', (event) => {
		const searchTerm = searchInputEL.value.trim();

		// 목록을 다시 보이게 함 (검색 시작 시)
		categoryListEL.style.display = 'block';

		// 모든 리스트 아이템을 순회하며 필터링
		listItemsELS.forEach(item => {
			const itemText = item.textContent.trim(); // 리스트 아이템 텍스트

			// 아이템 텍스트에 검색어가 포함되어 있으면
			if (itemText.includes(searchTerm)) {
				item.style.display = 'block'; // 해당 아이템 보이기
			} else {
				item.style.display = 'none'; // 포함되어 있지 않으면 숨기기
			}

			// 검색어와 리스트 아이템이 일치하면
			if (itemText === searchTerm) {
				// 카테고리 번호 저장
				hiddenInputEL.value = item.dataset.categoryNo;
				hiddenInputEL.closest('.form-group').lastElementChild.classList.remove('active');
			} else {
				hiddenInputEL.value = '';
			}

		});

	});
}

/**
 * 문자열이 긴 경우 '...' 처리 함수
 * @param {string} text - 원본 문자열
 * @param {number} maxLength - 최대 길이
 * @returns {string} 줄임 처리된 문자열
 */
const truncateText = function(text, maxLength) {
    if (!text) return "";
    if (text.length > maxLength) {
        return text.substring(0, maxLength) + '...';
    }
    return text;
};   

/**
 * 신규 상품 등록 폼 유효성 검사
 * @returns {boolean} 유효성 검사 통과 시 true, 실패 시 false
 */
const validateProductForm = function() {
	const productName = $('#productName').val().trim();
	if (!productName) {
		alert('상품명을 입력하세요.');
		$('#productName').focus();
		return false;
	}

	const productClassification = $('#productClassification').val();
	if (!productClassification) {
		alert('상품 분류를 선택하세요.');
		$('#productClassification').focus();
		return false;
	}

	// 대표 이미지 파일 선택 여부 확인
	if ($('#mainImage')[0].files.length === 0 && ! $('#mode').val()) { // 상품 수정일 경우 검사 X
		alert('대표 이미지를 등록해주세요.');
		$('label[for="mainImage"]').focus();
		return false;
	}

	// 상품 설명 길이 검사 (1300자 제한)
	const productDesc = $('#productDesc').val().trim();
	if (!productDesc) {
		alert('상품 설명을 입력하세요.');
		$('#productDesc').focus();
		return false;
	}
	if (productDesc.length > 1300) {
		alert('상품 설명은 1,300자 이하로 입력해주세요.');
		$('#productDesc').focus();
		return false;
	}

	// 2. 가격 및 재고 정보 검사
	const unitPrice = $('#unitPrice').val();
	if (unitPrice === '' || unitPrice < 0) {
		alert('단위당 가격을 올바르게 입력하세요.');
		$('#unitPrice').focus();
		return false;
	}

	const discountRate = $('#discountRate').val();
	if (discountRate === '' || discountRate < 0 || discountRate > 100) {
		alert('할인율은 0에서 100 사이의 숫자로 입력하세요.');
		$('#discountRate').focus();
		return false;
	}

	const unit = $('#unit').val().trim();
	if (!unit) {
		alert('판매 단위를 입력하세요.');
		$('#unit').focus();
		return false;
	}

	const deliveryFee = $('#deliveryFee').val();
	if (deliveryFee === '' || deliveryFee < 0) {
		alert('배송비를 올바르게 입력하세요.');
		$('#deliveryFee').focus();
		return false;
	}
    
	const varietyNum = $('#varietyNum').val();
	if (!varietyNum) {
		alert('상품 카테고리를 선택하세요.');
		$('#varietyCategory').focus();
		return false;
	}
    
	if (productClassification === '100') { // 일반 상품
		const stockQuantity = $('#stockQuantity').val();
		if (stockQuantity === '' || stockQuantity < 0) {
			alert('초기 재고 수량을 올바르게 입력하세요.');
			$('#stockQuantity').focus();
			return false;
		}
	} else if (productClassification === '200') { // 구출 상품
		const farmNum = $('#farmNum').val();
		if (farmNum === '' || farmNum <= 0) {
			alert('농장 번호를 올바르게 입력하세요.');
			$('#farmNum').focus();
			return false;
		}

		const endDate = $('#endDate').val();
		if (!endDate) {
			alert('판매 종료일을 선택하세요.');
			$('#endDate').focus();
			return false;
		}
		
		// 납품 내역이 있을 경우, 하나 이상 선택했는지 확인
		const $supplyCheckboxes = $('#supply-checkbox-list input[type="checkbox"]');
		if ($supplyCheckboxes.length > 0 && $supplyCheckboxes.filter(':checked').length === 0) {
			alert('납품 내역을 하나 이상 선택해주세요.');
			$('#supply-checkbox-list').focus();
			return false;
		}
	}

	// 모든 유효성 검사 통과
	return true;
};

// 파일 선택 시 파일명 업데이트 및 미리보기 생성
$('main').on('change', '#mainImage, #subImages', function(e) {
    const input = e.target;
    
    if (input.id === 'mainImage') {
        // 대표 이미지 처리
        const fileNameSpan = $('.main-file-name');
        const previewContainer = $('#main-image-preview');
        
        previewContainer.empty(); // 기존 미리보기 삭제
        
        if (input.files && input.files[0]) {
            const file = input.files[0];
            fileNameSpan.text(file.name);
            
            const reader = new FileReader();
            reader.onload = function(event) {
                const img = $('<img>').attr('src', event.target.result).addClass('image-preview-box');
                previewContainer.append(img);
            };
            reader.readAsDataURL(file);
        } else {
            fileNameSpan.text('선택된 파일 없음');
        }

    } else if (input.id === 'subImages') {
        // 추가 이미지 처리
        const fileNameSpan = $('.sub-file-name');
        const previewContainer = $('#additional-images-preview');
        
        previewContainer.empty(); // 기존 미리보기 모두 삭제
        
        if (input.files && input.files.length > 0) {
            // 파일 개수 제한 (최대 5개)
            const files = Array.from(input.files).slice(0, 5);
            
            if (input.files.length > 5) {
                alert('추가 이미지는 최대 5개까지 등록할 수 있습니다.');
            }

            fileNameSpan.text(`${files.length}개의 파일 선택됨`);
            
            files.forEach(file => {
                const reader = new FileReader();
                reader.onload = function(event) {
                    const imgHtml = `
                            <img src="${event.target.result}" class="image-preview-box pe-1">
                        
                    `;
                    previewContainer.append(imgHtml);
                };
                reader.readAsDataURL(file);
            });
        } else {
            fileNameSpan.text('선택된 파일 없음');
        }
    }
});