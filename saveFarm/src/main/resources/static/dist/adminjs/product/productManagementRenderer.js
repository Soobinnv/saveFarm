// HTML 생성 로직 //

/**
 * 상품 리스트 HTML 문자열 생성
 * @param {object} item - 상품 데이터 객체 (서버 응답)
 * @param {Array<object>} item.list - 상품 리스트
 * @param {number} item.dataCount - 총 상품 수
 * @param {number} item.size - 페이지 당 상품 수
 * @param {number} item.page - 현재 페이지 번호
 * @param {number} item.total_page - 총 페이지 수
 * @param {string} [item.schType="all"] - 검색 타입
 * @param {string} [item.kwd=""] - 검색 키워드
 * @param {number} [item.classify=100] - 상품 분류
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderProductListHTML = function(item) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	const classify = item.classify || 0;

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
	            <div class="card-body">
	              <div class="row m-0">
					  <div id="dataTables" class="dataTables_info d-flex align-items-center" role="status" aria-live="polite"
					  	data-dataCount="${item.dataCount}"
					  	data-size="${item.size}"
					  	data-page="${item.page}"
					  	data-totalPage="${item.total_page}"
					  	data-schType="${schType}"
					  	data-kwd="${kwd}"
                        data-classify="${classify}"
					  	>
					  	총 ${item.dataCount}개 (${item.page}/${item.total_page}페이지)
					  </div>
	     		  </div>
	              <ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify == 0 ? 'active' : ''}" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="300" aria-selected="${classify == 0}">전체상품</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify == 100 ? 'active' : ''}" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="100" aria-selected="${classify == 100}">일반상품</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link ${classify == 200 ? 'active' : ''}" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="200" aria-selected="${classify == 200}">구출상품</button>
						</li>
					</ul>
	              <table class="table datatables" id="dataTable-1">
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
                        <button type="button" class="btn mb-2 mr-1 btn-outline-primary" onclick="location.href='/product/register'">상품등록</button>
                        <button type="button" class="btn mb-2 btn-outline-primary" id="delete-product-btn">상품삭제</button>
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
                <a class="dropdown-item" href="/product/stock?productNum=${item.productNum}">재고</a>
                <a class="dropdown-item" href="/product/edit?productNum=${item.productNum}">상품정보변경</a>
              </div>
            </td>
          </tr>
        `;
    }).join(''); 
};

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
const renderFarmProductListHTML = function(item) {
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
	            <div class="card-body">
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
	              <table class="table datatables" id="dataTable-1">
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
                <a class="dropdown-item" href="#">승인</a>
                <a class="dropdown-item" href="#">반려</a>
              </div>
            </td>
          </tr>
        `;
    }).join('');
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
const renderProductQnaListHTML = function(item) {
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
	            <div class="card-body">
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
	              <table class="table datatables" id="dataTable-1">
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
	    // 'answerdate'의 존재 여부로 답변 상태를 결정
	    const statusText = item.answerdate ? '답변완료' : '답변대기';

	    const answerer = item.answerName || ''; // 답변자가 없으면 빈칸
	    const answerDate = item.answerdate || ''; // 답변일자가 없으면 빈칸

	    return `
	      <tr data-qna-num="${item.qnaNum}">
	        <td>${item.qnaNum}</td>
	        <td>${item.productNum}</td>
	        <td>${item.productName}</td> <!-- 쿼리에 productName 추가 필요 -->
	        <td>
	            <a href="/qna/detail?qnaNum=${item.qnaNum}" class="text-secondary">${item.title}</a>
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
const renderProductReviewListHTML = function(item) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";

	// tbody에 렌더링할 HTML (개별 행 생성 함수 호출)
    const tbodyHTML = renderProductReviewRows(item.list);

	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title">상품 리뷰</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body">
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
	              <table class="table datatables" id="dataTable-1">
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
	    // reviewBlock 값에 따라 상태 텍스트 결정 (0: 보임, 1: 숨김)
	    const statusText = item.reviewBlock === 0 ? '보임' : '숨김';

	    // 리뷰 내용이 길 경우를 대비해 일부만 보여주도록 처리 (예: 20자)
	    const shortContent = item.review.length > 20
	        ? item.review.substring(0, 20) + '...'
	        : item.review;

	    return `
	      <tr data-review-num="${item.orderDetailNum}">
	        <td>${item.orderDetailNum}</td>
	        <td>${item.productNum}</td>
	        <td>${item.productName}</td>
	        <td>
	            <a href="/review/detail?reviewNum=${item.orderDetailNum}" class="text-secondary">${shortContent}</a>
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
	            <a class="dropdown-item" href="#">리뷰 상태변경</a>
	            <a class="dropdown-item" href="#">리뷰 삭제</a>
	          </div>
	        </td>
	      </tr>
	    `;
	}).join('');
};
