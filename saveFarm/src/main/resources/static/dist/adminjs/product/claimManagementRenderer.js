/**
 * 환불 리스트 HTML 문자열 생성
 * @param {object} item - 환불 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
 * @param {Array<object>} item.list - 환불 리스트
 * @param {number} item.dataCount - 총 환불내역 수
 * @param {number} item.size - 페이지 당 상품 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderRefundListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	
	// tbody에 렌더링할 HTML
    const tbodyHTML = renderRefundRows(item.list);
	
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
 * 환불 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 환불 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderRefundRows = function(list) {
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
 * 반품 리스트 HTML 문자열 생성
 * @param {object} item - 반품 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
 * @param {Array<object>} item.list - 반품 리스트
 * @param {number} item.dataCount - 총 반품내역 수
 * @param {number} item.size - 페이지 당 상품 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderReturnListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	
	// tbody에 렌더링할 HTML
    const tbodyHTML = renderReturnRows(item.list);
	
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
 * 반품 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 반품 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderReturnRows = function(list) {
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
 * 전체 클레임 리스트 HTML 문자열 생성
 * @param {object} item - 클레임 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
 * @param {Array<object>} item.list - 클레임 리스트
 * @param {number} item.dataCount - 총 클레임 내역 수
 * @param {number} item.size - 페이지 당 상품 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderAllClaimListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	
	// tbody에 렌더링할 HTML
    const tbodyHTML = renderAllClaimRows(item.list);
	
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
 * 전체 클레임 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 클레임 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderAllClaimRows = function(list) {
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
