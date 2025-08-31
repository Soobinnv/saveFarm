// HTML 생성 로직 //

/**
 * 상품 리스트 HTML 문자열 생성
 * @param {object} item - 상품 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
 * @param {object} params.classifyCode - 상품 분류 코드
 * @param {Array<object>} item.list - 상품 리스트
 * @param {number} item.dataCount - 총 상품 수
 * @param {number} item.size - 페이지 당 상품 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	
	// tbody에 렌더링할 HTML
    const tbodyHTML = renderProductRows(item.list);
	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">상품 리스트</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="product-card">
	              <div class="row m-0">
					  <div id="dataTables" class="dataTables_info d-flex align-items-center" role="status" aria-live="polite"
					  	data-dataCount="${item.dataCount}"
					  	data-size="${item.size}"
					  	data-page="${item.page}"
					  	data-totalPage="${item.total_page}"
					  	data-schType="${schType}"
					  	data-kwd="${kwd}"
					  	>
					  	총 ${item.dataCount}개 (${item.page}/${item.total_page}페이지)
					  </div>
	     		  </div>
	              <ul class="nav nav-tabs" id="myTab" role="tablist">
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.classifyCode === '' || typeof params.classifyCode === 'undefined' 
								? 'active' : ''}" id="tab-product-all" type="button" role="tab">전체상품</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.classifyCode === 100 ? 'active' : ''}" id="tab-product-normal" type="button" role="tab">일반상품</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.classifyCode === 200 ? 'active' : ''}" id="tab-product-rescued" type="button" role="tab">구출상품</button>
					  </li>
				  </ul>
	              <table data-type="product" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>상품번호</th>
	                    <th>상품명</th>
						<th>가격</th>
						<th>재고</th>
	                    <th>상품분류</th>
	                    <th>종료일</th>
	                    <th>변경</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  ${tbodyHTML}
	                </tbody>
	              </table>
                  <div class="row">
                    <div class="col-sm-12 col-md-12 page-navigation">
                    </div>
                  </div>
                  <div class="row d-flex justify-content-end"">
                    <div class="col-sm-12 col-md-2 d-flex justify-content-end">
                        <button type="button" class="btn mb-2 mr-1 btn-outline-primary" id="btn-product-insert">상품등록</button>
                    </div>
				  </div
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	`;
	return html;
}

/**
 * 상품 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 상품 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderProductRows = function(list) {
    if (!list || list.length === 0) {
        return `<tr><td colspan="7" class="text-center">표시할 상품이 없습니다.</td></tr>`;
    }

    return list.map(item => {
        let classificationText = '';
        switch (item.productClassification) {
            case 100: classificationText = '일반상품'; break;
            case 200: classificationText = '구출상품'; break;
            case 300: classificationText = '세이프팜특가'; break;
            default: classificationText = '미분류';
        }

		let endDate = item.endDate;
		
		if(item.endDate === null) {
			endDate = '-';
		}
		
        return `
          <tr data-product-num="${item.productNum}">
            <td>${item.productNum}</td>
            <td>${item.productName}</td>
            <td>${item.unitPrice}원</td>
            <td>${item.stockQuantity}</td>
            <td>${classificationText}</td>
            <td>${endDate}</td>
            <td>
              <button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="text-muted sr-only">Action</span>
              </button>
              <div class="dropdown-menu dropdown-menu-right">
                <a 
				data-num="${item.productNum}" 
				data-name="${item.productName}" 
				data-unit="${item.unit}" 
				data-stock="${item.stockQuantity}"  
				data-variety="${item.varietyNum}"  
					class="dropdown-item stock-insert-btn" 
					href="javascript:void(0);"
					>재고등록</a>
                <a 
				data-num="${item.productNum}" 
				data-name="${item.productName}" 
				data-unit="${item.unit}" 
				data-stock="${item.stockQuantity}"  
					class="dropdown-item stock-edit-btn" 
					href="javascript:void(0);"
					>재고수정</a>
                <a data-num="${item.productNum}" class="dropdown-item product-edit-btn" href="javascript:void(0);">상품정보변경</a>
                <a data-num="${item.productNum}" class="dropdown-item product-delete-btn" href="javascript:void(0);">상품 삭제</a>
              </div>
            </td>
          </tr>
        `;
    }).join(''); 
};

/**
 * 상품 상세 정보 HTML 문자열 생성
 * @param {object} data - 상품 정보 데이터
 * @param {object} data.productInfo - 상품 정보 객체
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderProductDetailHTML = function(data) {
	const product = data.productInfo;
	const classifyName = product.productClassification === 100 ? '일반 상품' : '구출 상품';
	const classifyBadge = product.productClassification === 100 
		? `<span class="badge badge-pill badge-primary">${classifyName}</span>`
		: `<span class="badge badge-pill badge-success">${classifyName}</span>`;

	const price = (product.unitPrice || 0).toLocaleString();
	const stock = (product.stockQuantity || 0).toLocaleString();
	const unit = product.unit || '';

	const html = `
	<table>
		<tr class="product-detail-row" style="background-color: #f8f9fa;">
			<td colspan="7">
				<div id="product-card" class="row m-3 p-3 align-items-center card-body">
					<div class="col-md-3 text-center">
						<img src="${webContextPath}/uploads/product/${product.mainImageFilename}" 
							 onerror="this.onerror=null;this.src='https://placehold.co/200x200/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border" style="max-height: 200px;" alt="${product.productName} 이미지">
					</div>
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h4 class="mb-0">${product.productName}</h4>
							${classifyBadge}
						</div>
						<p class="text-muted">${product.productDesc || '상세 설명이 없습니다.'}</p>
						<hr class="my-3">
						<div class="row">
							<div class="col-md-6">
								<p class="mb-2"><strong>가격:</strong> ${price}원</p>
								<p class="mb-0"><strong>재고:</strong> ${stock}</p>
								<p class="mb-0"><strong>단위:</strong> ${unit}</p>
							</div>
							<div class="col-md-6">
								<p class="mb-2"><strong>농장:</strong> ${product.farmName || '정보 없음'}</p>
								<p class="mb-0"><strong>판매 종료일:</strong> ${product.endDate || '미정'}</p>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-12 d-flex justify-content-end">
								<div>
									<button 
										data-num="${product.productNum}" 
										data-name="${product.productName}" 
										data-unit="${product.unit}" 
										data-stock="${product.stockQuantity}" 
										type="button" class="btn btn-sm btn-outline-secondary stock-insert-btn">재고등록</button>
									<button 
										data-num="${product.productNum}" 
										data-name="${product.productName}" 
										data-unit="${product.unit}" 
										data-stock="${product.stockQuantity}"
										type="button" class="btn btn-sm btn-outline-secondary stock-edit-btn">재고수정</button>
									<button data-num="${product.productNum}" type="button" class="btn btn-sm btn-outline-secondary ms-2">수정하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	`;
	return html;
}

/**
 * 재고 수정 HTML 문자열 생성
 * @param {object} data - 상품 정보 데이터
 * @param {object} data.productInfo - 상품 정보 객체
 * @returns {string} 재고 관리 HTML 문자열
 */
const renderStockEditHTML = function(productInfo) {

	const html = `
	<div class="stock-management-ui card shadow-sm mt-3 mb-3 border-light">
		<div class="card-header bg-light d-flex justify-content-between align-items-center">
			<h5 class="mb-0 fw-bold">
			    <i class="fas fa-box me-2"></i>재고 관리: <span class="text-primary">${productInfo.productName}</span>
			</h5>
		</div>
		<div id="product-card" class="card-body p-4">
			<div class="row mb-4">
				<div class="col-md-8 d-flex justify-content-between">
					<div>
						<p class="fs-5">
							<strong>단위: ${productInfo.unit}</strong> 
						</p>
						<p id="data-stock" data-stock="${productInfo.stock}" class="fs-5">
							<strong>현재 재고: ${productInfo.stock}</strong> 
						</p>
					</div>
				</div>
			</div>
			<div class="row g-3 align-items-end">
				<div class="col-sm-4">
					<label for="stock-change-type" class="form-label"><strong>조정 유형</strong></label>
					<select class="form-select" id="stock-change-type">
						<option value="in" selected>입고 (+)</option>
						<option value="out">출고 (-)</option>
					</select>
				</div>
				<div class="col-sm-4">
					<label for="stock-quantity-input" class="form-label"><strong>조정 수량</strong></label>
					<input type="number" class="form-control" id="stock-quantity-input" placeholder="수량을 입력하세요" min="0">
				</div>
				<div class="col-sm-4">
					 <label for="stock-after-quantity" class="form-label"><strong>조정 후 재고</strong></label>
					 <input type="text" class="form-control" id="stock-after-quantity" readonly disabled value="${productInfo.stock}">
				</div>
			</div>
		</div>
		<div class="card-footer text-end bg-light">
			<button data-num="${productInfo.productNum}" type="button" class="btn btn-primary ms-2" id="save-stock-btn">
				<i class="fas fa-save me-1"></i> 저장하기
			</button>
			<button type="button" class="btn btn-secondary">취소</button>
		</div>
	</div>
	`;
	return html;
}

/**
 * 재고 등록 HTML 문자열 생성
 * @param {object} productInfo - 상품 정보 객체
 * @param {Array<object>} initialSupplyList - 화면에 처음으로 보여줄 납품 목록 배열
 * @returns {string} 재고 관리 전체 UI HTML 문자열
 */
const renderStockUpdateFromSupplyHTML = function(productInfo, initialSupplyList) {
	const hasSupplies = initialSupplyList && initialSupplyList.length > 0;

	const html = `
	<div class="stock-update-ui card shadow-sm mt-3 mb-3 border-light">
		<div class="card-header bg-light d-flex justify-content-between align-items-center">
			<h5 class="mb-0 fw-bold">
				<i class="fas fa-truck-loading me-2"></i>상품명: <span class="text-primary">${productInfo.productName}</span>
			</h5>
		</div>
		<div id="product-card" class="card-body p-4">
			<div class="row mb-3">
				<div class="col-md-6">
					<p id="current-stock" data-stock="${productInfo.currentStock}" class="fs-5">
						<strong>현재 재고: ${productInfo.currentStock}</strong>
					</p>
				</div>
			</div>

			<div class="row mb-4">
				<div class="col-12">
					<label class="form-label"><strong>납품 내역 선택 (다중 선택 가능)</strong></label>
					<div id="supply-checkbox-list" class="border rounded p-3" style="max-height: 180px; overflow-y: auto;">
						${hasSupplies 
							? createSupplyboxesHTML(initialSupplyList) 
							: '<p class="text-muted mb-0">처리할 납품 내역이 없습니다.</p>'
						}
					</div>
				</div>
			</div>

			<div class="row g-3 align-items-end">
				<div class="col-md-6">
					<label for="quantity-to-add" class="form-label"><strong>추가될 수량 총합</strong></label>
					<input type="text" class="form-control pe-2 ps-2" id="quantity-to-add" readonly disabled placeholder="자동 계산">
				</div>
				<div class="col-md-6">
					 <label for="stock-after-quantity" class="form-label"><strong>조정 후 재고</strong></label>
					 <input type="text" class="form-control" id="stock-after-quantity" readonly disabled value="${productInfo.currentStock}">
				</div>
			</div>
		</div>
		<div class="card-footer text-end bg-light">
			<button data-num="${productInfo.productNum}" type="button" class="btn btn-primary ms-2" id="save-stock-btn" ${!hasSupplies ? 'disabled' : ''}>
				<i class="fas fa-save me-1"></i> 저장하기
			</button>
			<button type="button" class="btn btn-secondary">취소</button>
		</div>
	</div>
	`;
	return html;
};

/**
 * 납품 내역 목록 HTML 문자열 생성
 * @param {Array<object>} supplyList - 납품 목록 배열
 * @returns {string} 체크박스 HTML 문자열
 */
const createSupplyboxesHTML = function(supplyList, page='') {
	if (!supplyList || supplyList.length === 0) {
		return '';
	}

	// 구출 상품 등록 시 한 가지 납품 내역만 선택 가능 - radio 버튼 사용
	if (page === 'INSERTRESCUEDPRODUCT') {
		return supplyList.map(supply => `
			<div class="form-check">
				<input 
					class="form-check-input supply-radio supply-input" 
					type="radio"
					name="supplySelection"
					value="${supply.supplyNum}" 
					id="supply-${supply.supplyNum}" 
					data-num="${supply.supplyNum}"
					data-quantity="${supply.supplyQuantity}"
					data-variety-num="${supply.varietyNum}"
					data-variety-name="${supply.varietyName}">
				<label class="" for="supply-${supply.supplyNum}">
					농가명: [${supply.farmName}] / 품종명: ${supply.varietyName} / 납품 수량: ${supply.supplyQuantity} / 납품일: ${supply.harvestDate}
				</label>
			</div>
		`).join('');
	}
		
	return supplyList.map(supply => `
		<div class="form-check checkbox-container">
			<input 
				class="form-check-input supply-checkbox supply-input" 
				type="checkbox"  
				value="${supply.supplyNum}" 
				id="supply-${supply.supplyNum}" 
				data-num="${supply.supplyNum}"
				data-quantity="${supply.supplyQuantity}"
				data-variety-num="${supply.varietyNum}"
				data-variety-name="${supply.varietyName}">
			<label class="form-check-label" for="supply-${supply.supplyNum}">농가명: [${supply.farmName}] / 품종명: ${supply.varietyName} / 납품 수량: ${supply.supplyQuantity} / 납품일: ${supply.harvestDate}
			</label>
		</div>
	`).join('');
};


/**
 * 신규 상품 등록 폼 HTML 문자열 생성 (조건부 필드 적용)
 * @returns {string} 상품 등록 폼 HTML 문자열
 */
const renderProductFormHTML = function(categoryList, supplyList) {
	const hasSupplies = supplyList && supplyList.length > 0;
	
	const categoryItemsHTML = categoryList.map(dto => `
		<li data-category-no="${dto.varietyNum}">${dto.varietyName}
		</li>
	`).join('');
	
	const html = `
	<div class="product-registration-ui card shadow-sm mt-3 mb-3 border-light">
		<div class="card-header bg-light d-flex justify-content-between align-items-center">
			<h5 class="mb-0 fw-bold">
				<i class="fas fa-plus-circle me-2"></i>신규 상품 등록
			</h5>
		</div>
		<form id="product-form" enctype="multipart/form-data">
			<div class="card-body p-4">
				<h5 class="mb-3 fw-bold text-primary">상품 정보</h5>
				<div class="row g-3 mb-4">
						<div class="col-md-6">
							<label for="productName" class="form-label"><strong>상품명</strong></label>
							<input type="text" class="form-control" id="productName" name="productName" placeholder="상품명을 입력하세요" required>
						</div>
						<div class="col-md-6">
							<label for="productClassification" class="form-label"><strong>상품 분류</strong></label>
							<select class="form-select custom-select" id="productClassification" name="productClassification" required>
							    <option value="" selected disabled>카테고리 선택</option>
							    <option value="100">일반</option>
							    <option value="200">구출 상품</option>
							</select>
						</div>
		                <div id="farm-info-section" class="d-none">
							<div class="col-md-12 mt-4">
								<label for="farmNum" class="form-label"><strong>농장 번호</strong></label>
								<input type="number" value="0" class="form-control" id="farmNum" name="farmNum" placeholder="농장 고유 번호를 입력하세요">
							</div>
							<div class="col-md-12 mt-4 mb-4">
								<label for="endDate" class="form-label"><strong>판매 종료일</strong></label>
								<input type="date" class="form-control" id="endDate" name="endDate">
							</div>
							<div class="col-12">
								<label class="form-label"><strong>납품 내역 선택</strong></label>
								<div id="supply-checkbox-list" class="border rounded p-3" style="max-height: 180px; overflow-y: auto;">
									${hasSupplies 
										? createSupplyboxesHTML(supplyList, 'INSERTRESCUEDPRODUCT') 
										: '<p class="text-muted mb-0">처리할 납품 내역이 없습니다.</p>'
									}
								</div>
							</div>
						</div>
						<div class="col-12 mt-4">
						    <strong>대표 이미지</strong>
						    <label for="mainImage" class="form-label custom-file-upload mt-3">
						        <span class="file-upload-button">파일 선택</span>
						        <span class="file-name">선택된 파일 없음</span>
						    </label>
						    <input class="form-control" type="file" id="mainImage" name="mainImage" accept="image/*" style="display: none;">
					    </div>
					<div class="col-12 mt-4">
						<label for="productDesc" class="form-label"><strong>상품 설명</strong></label>
						<textarea class="form-control" id="productDesc" name="productDesc" rows="5" placeholder="상품에 대한 상세 설명을 입력하세요" required></textarea>
					</div>
				</div>
				<hr class="my-4">
				<h5 class="mb-3 fw-bold text-primary">가격 및 재고 정보</h5>
				<div class="row g-3">
					<div class="col-md-4">
						<label for="unitPrice" class="form-label"><strong>단위당 가격 (원)</strong></label>
						<input type="number" class="form-control" id="unitPrice" name="unitPrice" placeholder="숫자만 입력" min="0" required>
					</div>
					<div class="col-md-4">
						<label for="discountRate" class="form-label"><strong>할인율 (%)</strong></label>
						<input type="number" class="form-control" id="discountRate" name="discountRate" placeholder="0 ~ 100" min="0" max="100" value="0" required>
					</div>
					<div class="col-md-4">
						<label for="unit" class="form-label"><strong>판매 단위: kg</strong></label>
						<input type="text" class="form-control" id="unit" name="unit" placeholder="kg" required>
					</div>
					<div class="col-md-6">
						<label for="stockQuantity" class="form-label"><strong>초기 재고 수량</strong></label>
						<input type="number" class="form-control" id="stockQuantity" name="stockQuantity" placeholder="초기 재고" min="0" value="0" disabled required>
					</div>
					<div class="col-md-6">
						<label for="deliveryFee" class="form-label"><strong>배송비 (원)</strong></label>
						<input type="number" class="form-control" id="deliveryFee" name="deliveryFee" placeholder="기본 배송비" min="0" value="3000" required>
					</div>
				</div>
				<div class="row g-3 mt-4">
					<div class="form-group col-md-12">
						<label for="varietyCategory"><strong>상품 카테고리</strong></label>
						<div class="category-select-wrapper">
							<input name="varietyIdx" type="text" id="varietyCategory" class="category-search-input" placeholder="품종을 검색 또는 선택 (필수)">
							<input type="hidden" id="varietyNum" name="varietyNum">
							<div class="category-list" id="varietyCategoryList">
								<ul>
									${categoryItemsHTML}
								</ul>
							</div>
						</div>
					</div>							
				</div>
			</div>
			<div class="card-footer text-end bg-light">
				<button data-method="post" type="button" class="btn btn-primary ms-2" id="save-product-btn">
					<i class="fas fa-save me-1"></i> 저장하기
				</button>
				<button type="button" class="btn btn-secondary">취소</button>
			</div>
		</form>
	</div>
	`;
	return html;
}

/**
 * 상품 수정 폼 HTML 문자열 생성
 * @param {object} data - 상품 정보 데이터
 * @param {object} data.productInfo - 상품 정보 객체
 * @returns {string} 수정용 tr HTML 문자열
 */
const renderProductEditHTML = function(data) {
	const product = data.productInfo;

	const price = product.unitPrice || 0;
	const stock = product.stockQuantity || 0;
	const unit = product.unit || '';
	const productName = product.productName || '';
	const productDesc = product.productDesc || '';
	const farmName = product.farmName || '';
	const endDate = product.endDate || '';

	const isNormalProduct = product.productClassification === 100;

	const html = `
	<table>
		<tr class="product-edit-row" style="background-color: #f8f9fa;" data-product-num="${product.productNum}">
			<td colspan="7">
				<div class="row m-3 p-3 align-items-center">
					<div class="col-md-3 text-center">
						<img src="${webContextPath}/uploads/product/${product.mainImageFilename}" 
							 onerror="this.onerror=null;this.src='https://placehold.co/200x200/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border mb-3" style="max-height: 200px;" alt="${productName} 이미지">
						<input type="file" class="form-control form-control-sm" id="productImageFile">
					</div>
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<input type="text" class="form-control" id="productName" value="${productName}" placeholder="상품명">
							<select class="form-select form-select-sm ms-3" id="productClassification" style="width: 120px;">
								<option value="100" ${isNormalProduct ? 'selected' : ''}>일반 상품</option>
								<option value="200" ${!isNormalProduct ? 'selected' : ''}>구출 상품</option>
							</select>
						</div>
						<textarea class="form-control" id="productDesc" rows="3" placeholder="상세 설명">${productDesc}</textarea>
						<hr class="my-3">
						<div class="row">
							<div class="col-md-6">
								<div class="input-group mb-2">
									<span class="input-group-text" style="width: 80px;">가격</span>
									<input type="number" class="form-control" id="unitPrice" value="${price}">
									<span class="input-group-text">원</span>
								</div>
								<div class="input-group">
									<span class="input-group-text" style="width: 80px;">단위</span>
									<input type="text" class="form-control" id="unit" value="${unit}" placeholder="예: 1박스, 1kg">
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group mb-2">
									<span class="input-group-text" style="width: 80px;">농장</span>
									<input type="text" class="form-control" id="farmName" value="${farmName}">
								</div>
								<div class="input-group">
									<span class="input-group-text" style="width: 80px;">판매 종료</span>
									<input type="date" class="form-control" id="endDate" value="${endDate}">
								</div>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-12 d-flex justify-content-end">
								<div>
									<button data-method="put" data-num="${product.productNum}" type="button" class="btn btn-sm btn-primary product-save-btn">저장</button>
									<button type="button" class="btn btn-sm btn-outline-secondary ms-2 product-cancel-btn">취소</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	`;
	return html;
}

/**
 * 납품 리스트 HTML 문자열 생성
 * @param {object} item - 페이지 데이터 객체
 * @param {Array<object>} item.list - 농가상품 신청 리스트
 * @param {number} item.dataCount - 총 신청 수
 * @param {number} item.size - 페이지 당 항목 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @param {object} params - 탭 상태 구분을 위한 파라미터 객체
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderFarmProductListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";

    // tbody에 들어갈 HTML 생성
    const tbodyHTML = renderFarmProductRows(item.list);

	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">납품 관리</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="supply-card">
	              <div class="row m-0">
					<div id="dataTables" class="dataTables_info d-flex align-items-center" role="status" aria-live="polite"
						data-dataCount="${item.dataCount}"
						data-size="${item.size}"
						data-page="${item.page}"
						data-totalPage="${item.total_page}"
						data-schType="${schType}"
						data-kwd="${kwd}"
						>
						총 ${item.dataCount}개 (${item.page}/${item.total_page}페이지)
					</div>
	     		  </div>
				  <ul class="nav nav-tabs" id="myTab" role="tablist">
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === '' || typeof params.state === 'undefined' 
				  			? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체납품</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 1 ? 'active' : ''}" id="tab-status-unapproved" type="button" role="tab">승인대기</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 2 ? 'active' : ''}" id="tab-status-approved" type="button" role="tab">납품준비중</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 4 ? 'active' : ''}" id="tab-status-shipping" type="button" role="tab">납품중</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 5 ? 'active' : ''}" id="tab-status-delivered" type="button" role="tab">납품완료</button>
				    </li>
				  </ul>
	              <table data-type="supply" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>납품번호</th>
	                    <th>품종명</th>
						<th>제시가격</th>
	                    <th>농가이름</th>
	                    <th>수확일</th>
	                    <th>상태</th>
	                    <th>변경</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  ${tbodyHTML}
	                </tbody>
	              </table>
                  <div class="row">
                    <div class="col-sm-12 col-md-12 page-navigation">
                    </div>
                  </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	`;
	return html;
}

/**
 * 납품 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 농가상품 신청 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderFarmProductRows = function(list) {
    if (!list || list.length === 0) {
        return `<tr><td colspan="7" class="text-center">납품 내역이 없습니다.</td></tr>`;
    }

	return list.map(item => {
		
		let status = '';
		switch(item.state) {
			case 1: status = '승인대기'; break;
			case 2: status = '납품준비중'; break;
			case 3: status = '기각'; break;
			case 4: status = '납품중'; break;
			case 5: status = '납품완료'; break;
			case 6: status = '재고등록'; break;
		}
		
		// 옵션 버튼
		let dropdownButton = '';
		if(item.state === 1 || item.state === 4) {
			const supplyOptionHTML = renderSupplyOptionHTML(item);
			
			dropdownButton = `
				<button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    	<span class="text-muted sr-only">Action</span>
			    </button>
				<div class="dropdown-menu dropdown-menu-right">
				   ${supplyOptionHTML}
				</div>
			`;
		}		
		
        return `
          <tr data-supply-num="${item.supplyNum}">
            <td>${item.supplyNum}</td>
            <td>${item.varietyName}</td>
            <td>${item.unitPrice}원</td>
            <td>${item.farmName}</td>
            <td>${item.harvestDate}</td>
            <td class="status-block">${status}</td>
            <td>
			  ${dropdownButton}
            </td>
          </tr>
        `;
    }).join('');
};

/**
 * 납품 상세 정보 HTML 문자열 생성
 * @param {object} data - 납품 및 농가 정보 데이터
 * @param {object} data.supplyInfo - 납품 및 농가 정보 객체
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderFarmProductDetailHTML = function(data) {
	const item = data.supplyInfo;
	let statusBadge;
	let statusText;

	switch (item.state) {
		case 2: // 승인
			statusBadge = `<span class="badge rounded-pill bg-success">승인완료</span>`;
			break;
		case 3: // 기각(반려)
			statusBadge = `<span class="badge rounded-pill bg-danger">반려</span>`;
			break;
		case 4: // 납품중
			statusBadge = `<span class="badge rounded-pill bg-info text-dark">납품 처리중</span>`;
			break;
		case 5: // 납품 완료
			statusBadge = `<span class="badge rounded-pill bg-secondary">납품완료</span>`;
			break;
		default: // 승인대기 (1)
			statusBadge = `<span class="badge rounded-pill bg-warning text-dark">승인대기</span>`;
			break;
	}

		let actionButtonsHTML = '';
		switch(item.state) {
			case 1: // 승인대기 상태
				actionButtonsHTML = `
					<button type="button" data-target-state="2" data-num="${item.supplyNum}" class="btn btn-primary btn-sm supply-update-state">승인</button>&nbsp;
					<button type="button" data-target-state="3" data-num="${item.supplyNum}" class="btn btn-secondary btn-sm supply-update-state">기각</button>
				`;
				break;
			case 4: // 납품중 상태
				actionButtonsHTML = `
					<button type="button" data-target-state="5" data-num="${item.supplyNum}" class="btn btn-primary btn-sm supply-update-state">납품 완료 처리</button>
				`;
				break;
		}
		
		const html = `
		<tr class="farm-product-detail-row" style="background-color: #f8f9fa;">
			<td colspan="7">
				<div class="row m-3 p-3 align-items-center">
					<div class="col-md-3 text-center">
						<img src="https://placehold.co/200x200/EFEFEF/31343C?text=No+Image" 
							 onerror="this.onerror=null;this.src='https://placehold.co/200x200/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border" style="max-height: 200px;" alt="${item.varietyName} 이미지">
					</div>
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h4 class="mb-0">${item.varietyName}</h4>
							${statusBadge}
						</div>
						<p class="text-muted">${item.coment || '상세 설명이 없습니다.'}</p>
						<hr class="my-3">
						<div class="row">
							<div class="col-md-6">
								<p class="mb-2"><strong>농가명:</strong> ${item.farmName || '정보 없음'}</p>
								<p class="mb-0"><strong>농가 ID:</strong> ${item.farmerId || '정보 없음'}</p>
							</div>
							<div class="col-md-6">
								<p class="mb-2"><strong>단위 가격:</strong> ${(item.unitPrice || 0).toLocaleString()}원</p>
								<p class="mb-0"><strong>수확일:</strong> ${item.harvestDate || '미정'}</p>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-12 d-flex justify-content-end gap-2">
								${actionButtonsHTML}
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
		`;
		return html;
}

/**
 * 납품 관리 옵션 버튼 HTML 생성
 * @param {object} item - 납품 데이터 객체
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderSupplyOptionHTML = function(item) {
	let html = '';
	
	switch(item.state) {
		case 1:
			html = `
			<a data-target-state="2" data-num="${item.supplyNum}" class="dropdown-item supply-update-state" href="javascript:void(0);">승인</a>
			<a data-target-state="3" data-num="${item.supplyNum}" class="dropdown-item supply-update-state" href="javascript:void(0);">기각</a>
			` ;
			break;
		case 4:
			html = `
			<a data-target-state="5" data-num="${item.supplyNum}" class="dropdown-item supply-update-state" href="javascript:void(0);">납품 완료</a>
			` ;
			break;
	}

	return html;
};

/**
 * 상품 문의 리스트 HTML 문자열 생성
 * @param {object} item - 상품 문의 데이터 객체
 * @param {Array<object>} item.list - 상품 문의 리스트
 * @param {number} item.dataCount - 총 문의 수
 * @param {number} item.size - 페이지 당 항목 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductQnaListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";

    const tbodyHTML = renderProductQnaRows(item.list);

	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title">상품 문의</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="qna-card">
	              <div class="row m-0">
					<div id="dataTables" class="dataTables_info d-flex align-items-center" role="status" aria-live="polite"
						data-dataCount="${item.dataCount}"
						data-size="${item.size}"
						data-page="${item.page}"
						data-totalPage="${item.total_page}"
						data-schType="${schType}"
						data-kwd="${kwd}"
						>
						총 ${item.dataCount}개 (${item.page}/${item.total_page}페이지)
					</div>
	     		  </div>
				  <ul class="nav nav-tabs" id="myTab" role="tablist">
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.isAnswerd === '' || typeof params.isAnswerd === 'undefined' 
				  			? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체문의</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.isAnswerd === 0 ? 'active' : ''}" id="tab-status-unanswered" type="button" role="tab">답변대기</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.isAnswerd === 1 ? 'active' : ''}" id="tab-status-answered" type="button" role="tab">답변완료</button>
				    </li>
				  </ul>
	              <table data-type="productQna" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>문의번호</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>문의명</th>
						<th>작성자</th>
						<th>문의일자</th>
						<th>답변자</th>
						<th>답변일자</th>
						<th>처리결과</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  ${tbodyHTML}
	                </tbody>
	              </table>
                  <div class="row">
                    <div class="col-sm-12 col-md-12 page-navigation">
                    </div>
                  </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	`;
	return html;
}

/**
 * 상품 문의 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 상품 문의 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderProductQnaRows = function(list) {
	if (!list || list.length === 0) {
	    return `<tr><td colspan="9" class="text-center">표시할 문의가 없습니다.</td></tr>`;
	}

	return list.map(item => {
	    const statusText = item.answerDate ? '답변완료' : '답변대기';

	    const answerer = item.answerName || ''; 
	    const answerDate = item.answerDate || ''; 

	    return `
	      <tr data-qna-num="${item.qnaNum}">
	        <td>${item.qnaNum}</td>
	        <td>${item.productNum}</td>
	        <td>${item.productName}</td>
	        <td>
	            <a href="javascript:void(0);" class="text-secondary">${item.title}</a>
	        </td>
	        <td>${item.name}</td>
	        <td>${item.qnaDate}</td>
	        <td>${answerer}</td>
	        <td>${answerDate}</td>
	        <td>${statusText}</td>
	      </tr>
	    `;
	}).join('');
};

/**
 * 상품 문의 상세 정보 HTML 문자열 생성
 * @param {object} data - 서버에서 받은 상품 문의 상세 데이터
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderProductQnaDetailHTML = function(data) {
	const item = data.productQnaInfo;

	const isAnswered = !!item.answerDate;
	
	// 답변 여부
	const status = isAnswered ? '답변완료' : '답변대기';
	const method = isAnswered ? 'put' : 'post';
	
	const statusBadge = isAnswered
		? `<span class="badge rounded-pill bg-success">${status}</span>`
		: `<span class="badge rounded-pill text-dark bg-warning">${status}</span>`;
		
	const answerButtonHTML = isAnswered
		? `
		<div class="d-flex mt-3">
			<button type="button" style="margin-right: 7px;" class="btn btn-outline-primary btn-sm btn-edit-answer" data-num="${item.qnaNum}">답변 수정</button>
			<button type="button" class="btn btn-outline-primary btn-sm btn-delete-answer" data-num="${item.qnaNum}">답변 삭제</button>
		</div>
		`
		: `
		<div class="d-flex mt-3">
			<button type="button" style="margin-right: 7px;" class="btn btn-primary btn-sm btn-submit-answer" data-num="${item.qnaNum}">답변 등록</button>
			<button type="button" class="btn btn-outline-primary btn-sm btn-delete-answer" data-num="${item.qnaNum}">답변 삭제</button>
		</div>
		`;

	const answerSectionHTML = isAnswered
		? `
		<h6 class="mt-3">답변</h6>
		<div id="answerBlock" class="p-3 border bg-white rounded" style="white-space: pre-wrap;">${item.answer || ''}</div>
		<div class="text-end mt-2">
			<small class="text-muted">답변자: ${item.answerName || ''} | ${item.answerDate || ''}</small>
		</div>
		`
		: `
		<h6 class="mt-3">답변 등록</h6>
		<textarea id="answer-content" class="form-control" rows="5" placeholder="답변을 입력하세요..." style="resize:none;"></textarea>
		`;

	const html = `
	<table>
		<tr data-method="${method}" class="qna-detail-row">
			<td colspan="9" class="p-3">
				<div class="row justify-content-center">
					<div style="width: 95vw;" class="col-12 col-lg-10 col-xl-9">
						<div class="card" style="height: 80vh;">
							<div class="card-header d-flex justify-content-between align-items-center">
								<div>
									<h5 class="card-title mb-1">Q. ${item.title}</h5>
									<small class="text-muted">
										관련상품: ${item.productName} (상품번호: ${item.productNum})
									</small>
								</div>
								${statusBadge}
							</div>
							<div class="card-body">
								<div class="row g-4">
									<div class="col-md-6">
										<h6>문의 내용</h6>
										<div class="p-3 border bg-light rounded" style="min-height: 150px; white-space: pre-wrap;">${item.question}</div>
										<div class="text-end mt-2">
											<small class="text-muted">작성자: ${item.name} | ${item.qnaDate}</small>
										</div>
									</div>
									<div id="answerLayout" class="col-md-6">
										${answerSectionHTML}
										${answerButtonHTML}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	`;
	return html;
}

/**
 * 상품 리뷰 리스트 HTML 문자열 생성
 * @param {object} item - 상품 리뷰 데이터 객체
 * @param {Array<object>} item.list - 상품 리뷰 리스트
 * @param {number} item.dataCount - 총 리뷰 수
 * @param {number} item.size - 페이지 당 항목 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductReviewListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";

    const tbodyHTML = renderProductReviewRows(item.list);

	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title">상품 리뷰</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="review-card">
	              <div class="row m-0">
					<div id="dataTables" class="dataTables_info d-flex align-items-center" role="status" aria-live="polite"
						data-dataCount="${item.dataCount}"
						data-size="${item.size}"
						data-page="${item.page}"
						data-totalPage="${item.total_page}"
						data-schType="${schType}"
						data-kwd="${kwd}"
						>
						총 ${item.dataCount}개 (${item.page}/${item.total_page}페이지)
					</div>
	     		  </div>
				  <ul class="nav nav-tabs" id="myTab" role="tablist">
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.reviewBlock === '' || typeof params.reviewBlock === 'undefined' 
				  			? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체리뷰</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.reviewBlock === 0 ? 'active' : ''}" id="tab-status-visible" type="button" role="tab">게시</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.reviewBlock === 1 ? 'active' : ''}" id="tab-status-hidden" type="button" role="tab">숨김</button>
				    </li>
				  </ul>
	              <table data-type="productReview" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>번호</th>
						<th>상품번호</th>
						<th>상품명</th>
						<th>리뷰내용</th>
						<th>작성자</th>
						<th>작성일자</th>
						<th>별점</th>
						<th>상태</th>
						<th>선택</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  ${tbodyHTML}
	                </tbody>
	              </table>
                  <div class="row">
                    <div class="col-sm-12 col-md-12 page-navigation">
                    </div>
                  </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
	`;
	return html;
}

/**
 * 상품 리뷰 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 상품 리뷰 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderProductReviewRows = function(list) {
	if (!list || list.length === 0) {
	    return `<tr><td colspan="9" class="text-center">표시할 리뷰가 없습니다.</td></tr>`;
	}

	return list.map(item => {
	    const statusText = item.reviewBlock === 0 ? '보임' : '숨김';

	    const content = item.review.length > 20
	        ? item.review.substring(0, 20) + '...'
	        : item.review;

	    return `
	      <tr data-review-num="${item.orderDetailNum}">
	        <td>${item.orderDetailNum}</td>
	        <td>${item.productNum}</td>
	        <td>${item.productName}</td>
	        <td>
	            <a href="javascript:void(0);" class="text-secondary">${content}</a>
	        </td>
	        <td>${item.reviewerName}</td>
	        <td>${item.reviewDate}</td>
	        <td>${'★'.repeat(item.star)}${'☆'.repeat(5 - item.star)}</td>
	        <td class="status-block">${statusText}</td>
	        <td>
	          <button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	            <span class="text-muted sr-only">선택</span>
	          </button>
	          <div class="dropdown-menu dropdown-menu-right">
	            <a data-num="${item.orderDetailNum}" data-status="${statusText}" class="dropdown-item review-update-block" href="javascript:void(0);">리뷰 상태변경</a>
	            <a data-num="${item.orderDetailNum}" class="dropdown-item review-delete" href="javascript:void(0);">리뷰 삭제</a>
	          </div>
	        </td>
	      </tr>
	    `;
	}).join('');
};

/**
 * 상품 리뷰 상세 정보 HTML 문자열 생성 
 * @param {object} data - 서버에서 받은 상품 리뷰 상세 데이터
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderProductReviewDetailHTML = function(data) {
	const item = data.productReviewInfo;
	
	// 숨김 처리 여부
	const status = item.reviewBlock === 1 ? '숨김' : '게시중';

	const statusBadge = status === '숨김'
		? `<span class="badge badge-pill badge-secondary">${status}</span>`
		: `<span class="badge badge-pill badge-info">${status}</span>`;

	const starRatingHTML = createStarRating(item.star);

	
	
	const adminButtonsHTML = `
		<button data-num="${item.orderDetailNum}" type="button" class="btn btn-sm ${item.isBest ? 'btn-secondary' : 'btn-outline-primary'} mr-1 btn-toggle-best" 
			data-num="${item.orderDetailNum}">
			${item.isBest ? '베스트 리뷰 해제' : '베스트 리뷰 등록'}
		</button>
		<button data-num="${item.orderDetailNum}" type="button" class="btn btn-sm ${status === '숨김' ? 'btn-outline-info' : 'btn-outline-secondary'} btn-toggle-hide btn-review-block-update" 
			data-block="${item.reviewBlock}"
			data-num="${item.orderDetailNum}">
			${status === '숨김' ? '리뷰 게시' : '리뷰 숨기기'}
		</button>
	`;

	const html = `
	<table>
		<tr class="review-detail-row" style="background-color: #f8f9fa;">
			<td colspan="9">
				<div class="row m-3 p-3 align-items-start">
					<div class="col-md-3 text-center">
						<img src="${webContextPath}/uploads/product/${item.mainImageFilename || 'https://placehold.co/250x250/EFEFEF/31343C?text=No+Photo'}" 
							 onerror="this.onerror=null;this.src='https://placehold.co/250x250/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border" style="max-height: 250px;" alt="${item.productName} 리뷰 이미지">
					</div>
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h5 class="mb-0">${item.productName}</h5>
							${statusBadge}
						</div>
						<div class="mb-3">
							${starRatingHTML}
						</div>
						<div class="p-3 border bg-light rounded mb-3" style="min-height: 100px; white-space: pre-wrap;">${item.review}
						</div>
						<div class="d-flex justify-content-between align-items-center">
							<small class="text-muted">작성자: ${item.reviewerName} | 작성일: ${item.reviewDate}</small>
							<div class="admin-actions">
								${adminButtonsHTML}
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	`;
	return html;
}

/**
 * 별점(rating) 숫자를 받아 별 모양 아이콘으로 변환
 * @param {number} rating - 1~5 사이의 별점
 * @returns {string} 별점 아이콘, 점수가 포함된 HTML 문자열
 */
const createStarRating = (rating) => {
	let stars = '';
	const fullStar = `<svg fill="#ffc107" width="20" height="20" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/></svg>`;
	const emptyStar = `<svg fill="#e0e0e0" width="20" height="20" viewBox="0 0 24 24"><path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.828 1.48 8.279-7.416-3.967-7.417 3.967 1.481-8.279-6.064-5.828 8.332-1.151z"/></svg>`;
	for (let i = 1; i <= 5; i++) {
		stars += i <= rating ? fullStar : emptyStar;
	}
	return `<div class="d-flex align-items-center">${stars}<span class="ml-2 font-weight-bold text-warning" style="font-size: 1.1rem;">${rating.toFixed(1)}</span></div>`;
};
