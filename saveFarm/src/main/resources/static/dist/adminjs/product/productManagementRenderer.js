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
                        <button type="button" class="btn mb-2 btn-outline-primary" id="btn-product-delete">상품삭제</button>
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
                <a class="dropdown-item" href="javascript:void(0);">재고</a>
                <a class="dropdown-item" href="javascript:void(0);">상품정보변경</a>
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

	// 가격과 재고가 null 또는 undefined일 경우 0으로 처리, 숫자 형식 변환
	const price = (product.unitPrice || 0).toLocaleString();
	const stock = (product.stockQuantity || 0).toLocaleString();
	const unit = product.unit || '';

	const html = `
	<table>
		<tr class="product-detail-row" style="background-color: #f8f9fa;">
			<td colspan="7">
				<div class="row m-3 p-3 align-items-center">
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
								<button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='/products/edit/${product.productNum}'">수정하기</button>
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
 * 농가상품 신청 리스트 HTML 문자열 생성
 * @param {object} item - 농가상품 데이터 객체
 * @param {Array<object>} item.list - 농가상품 신청 리스트
 * @param {number} item.dataCount - 총 신청 수
 * @param {number} item.size - 페이지 당 항목 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderFarmProductListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";

	// tbody에 렌더링할 HTML (개별 행 생성 함수 호출)
    const tbodyHTML = renderFarmProductRows(item.list);

	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">농가상품 신청</h2>
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
				  			? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체상품</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 1 ? 'active' : ''}" id="tab-status-unapproved" type="button" role="tab">숭인대기</button>
				    </li>
				    <li class="nav-item" role="presentation">
				        <button class="nav-link ${params.state === 2 ? 'active' : ''}" id="tab-status-approved" type="button" role="tab">승인</button>
				    </li>
				  </ul>
	              <table data-type="supply" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>상품번호</th>
	                    <th>상품명</th>
						<th>가격</th>
	                    <th>농가명</th>
	                    <th>농가아이디</th>
	                    <th>신청일</th>
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
 * 농가상품 신청 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 농가상품 신청 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderFarmProductRows = function(list) {
    if (!list || list.length === 0) {
        return `<tr><td colspan="7" class="text-center">신청된 농가상품이 없습니다.</td></tr>`;
    }

    return list.map(item => {
        return `
          <tr data-product-num="${item.productNum}">
            <td>${item.productNum}</td>
            <td>${item.productName}</td>
            <td>${item.unitPrice}원</td>
            <td>${item.farmName}</td>
            <td>${item.farmId}</td>
            <td>${item.applyDate}</td>
            <td>
              <button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="text-muted sr-only">Action</span>
              </button>
              <div class="dropdown-menu dropdown-menu-right">
                <a class="dropdown-item" href="javascript:void(0);">승인</a>
                <a class="dropdown-item" href="javascript:void(0);">반려</a>
              </div>
            </td>
          </tr>
        `;
    }).join('');
};

/**
 * 농가상품 신청 상세 정보 HTML 문자열 생성
 * @returns {string} 상세 보기용 tr HTML 문자열
 */
const renderFarmProductDetailHTML = function(item) {
	let statusBadge;
	switch (item.status) {
		case '승인완료':
			statusBadge = `<span class="badge badge-pill badge-success">${item.status}</span>`;
			break;
		case '반려':
			statusBadge = `<span class="badge badge-pill badge-danger">${item.status}</span>`;
			break;
		default: 
			statusBadge = `<span class="badge badge-pill badge-warning">${item.status || '승인대기'}</span>`;
			break;
	}

	const html = `
	<table>
		<tr class="farm-product-detail-row" style="background-color: #f8f9fa;">
			<td colspan="7">
				<div class="row m-3 p-3 align-items-center">
					<div class="col-md-3 text-center">
						<img src="${item.productImg || 'https://placehold.co/200x200/EFEFEF/31343C?text=No+Image'}" 
							 onerror="this.onerror=null;this.src='https://placehold.co/200x200/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border" style="max-height: 200px;" alt="${item.productName} 이미지">
					</div>
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h4 class="mb-0">${item.productName}</h4>
							${statusBadge}
						</div>
						<p class="text-muted">${item.productDesc || '상세 설명이 없습니다.'}</p>
						<hr class="my-3">
						<div class="row">
							<div class="col-md-6">
								<p class="mb-2"><strong>농가명:</strong> ${item.farmName}</p>
								<p class="mb-0"><strong>농가 ID:</strong> ${item.farmUserId}</p>
							</div>
							<div class="col-md-6">
								<p class="mb-2"><strong>제시 가격:</strong> ${item.price.toLocaleString()}원</p>
								<p class="mb-0"><strong>신청일:</strong> ${item.applyDate}</p>
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-12 d-flex justify-content-end">
								<button type="button" class="btn btn-sm btn-success mr-1" data-no="${item.productNo}" id="btn-approve">승인</button>
								<button type="button" class="btn btn-sm btn-danger" data-no="${item.productNo}" id="btn-reject">반려</button>
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
	const statusBadge = isAnswered
		? `<span class="badge rounded-pill bg-success">${status}</span>`
		: `<span class="badge rounded-pill text-dark bg-warning">${status}</span>`;

	const answerSectionHTML = isAnswered
		? `
		<h6>답변</h6>
		<div class="p-3 border bg-white rounded" style="min-height: 150px; white-space: pre-wrap;">${item.answer || ''}</div>
		<div class="text-end mt-2">
			<small class="text-muted">답변자: ${item.answerName || ''} | ${item.answerDate || ''}</small>
		</div>
		<div class="text-end mt-3">
			<button type="button" class="btn btn-outline-primary btn-sm btn-edit-answer" data-no="${item.qnaNum}">답변 수정</button>
		</div>
		`
		: `
		<h6>답변 등록</h6>
		<textarea id="answer-content-${item.qnaNum}" class="form-control" rows="5" placeholder="답변을 입력하세요..."></textarea>
		<div class="text-end mt-3">
			<button type="button" class="btn btn-primary btn-sm btn-submit-answer" data-no="${item.qnaNum}">답변 등록</button>
		</div>
		`;

	const html = `
	<table>
		<tr class="qna-detail-row">
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
									<div class="col-md-6">
										${answerSectionHTML}
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
				        <button class="nav-link ${params.reviewBlock === 0 ? 'active' : ''}" id="tab-status-visible" type="button" role="tab">보임</button>
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
	        <td>${statusText}</td>
	        <td>
	          <button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	            <span class="text-muted sr-only">선택</span>
	          </button>
	          <div class="dropdown-menu dropdown-menu-right">
	            <a class="dropdown-item" href="content">리뷰 상태변경</a>
	            <a class="dropdown-item" href="content">리뷰 삭제</a>
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
		<button type="button" class="btn btn-sm ${item.isBest ? 'btn-secondary' : 'btn-outline-primary'} mr-1 btn-toggle-best" data-no="${item.orderDetailNum}">
			${item.isBest ? '베스트 리뷰 해제' : '베스트 리뷰 등록'}
		</button>
		<button type="button" class="btn btn-sm ${status === '숨김' ? 'btn-outline-info' : 'btn-outline-secondary'} btn-toggle-hide" data-no="${item.orderDetailNum}">
			${status === '숨김' ? '리뷰 게시' : '리뷰 숨기기'}
		</button>
	`;

	const html = `
	<table>
		<tr class="review-detail-row" style="background-color: #f8f9fa;">
			<td colspan="9">
				<div class="row m-3 p-3 align-items-start">
					<!-- 1. 상품 이미지 영역 -->
					<div class="col-md-3 text-center">
						<img src="${webContextPath}/uploads/product/${item.mainImageFilename || 'https://placehold.co/250x250/EFEFEF/31343C?text=No+Photo'}" 
							 onerror="this.onerror=null;this.src='https://placehold.co/250x250/EFEFEF/31343C?text=Image+Error';"
							 class="img-fluid rounded border" style="max-height: 250px;" alt="${item.productName} 리뷰 이미지">
					</div>
					<!-- 2. 리뷰 상세 정보 영역 -->
					<div class="col-md-9">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h5 class="mb-0">${item.productName}</h5>
							${statusBadge}
						</div>
						<div class="mb-3">
							${starRatingHTML}
						</div>
						<div class="p-3 border bg-light rounded mb-3" style="min-height: 100px; white-space: pre-wrap;">
							${item.review}
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
 * 별점(rating) 숫자를 받아 별 모양 아이콘으로 변환하는 내부 함수
 * @param {number} rating - 1~5 사이의 별점
 * @returns {string} 별점 아이콘 SVG와 점수가 포함된 HTML 문자열
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
