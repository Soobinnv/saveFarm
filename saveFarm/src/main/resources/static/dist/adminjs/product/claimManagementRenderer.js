/**
 * 환불 리스트 HTML 문자열 생성
 * @param {object} item - 환불 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
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
	      <h2 class="mb-2 page-title mr-2">환불 / 취소 관리</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="refund-card">
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
					      <button class="nav-link ${params.status === '' || typeof params.status === 'undefined' ? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 0 ? 'active' : ''}" id="tab-status-pending" type="button" role="tab">접수</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 1 ? 'active' : ''}" id="tab-status-processing" type="button" role="tab">처리중</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 2 ? 'active' : ''}" id="tab-status-completed" type="button" role="tab">처리완료</button>
					  </li>
					  <li class="nav-item" role="presentation">
					  	  <button class="nav-link ${params.status === 3 ? 'active' : ''}" id="tab-status-rejected" type="button" role="tab">기각</button>
					  </li>
				  </ul>
	              <table data-type="refund" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>환불번호</th>
	                    <th>신청자 E-mail</th>
						<th>환불금액</th>
						<th>환불수단</th>
	                    <th>신청일</th>
	                    <th>처리일</th>
	                    <th>상태</th>
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
 * 환불 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 환불 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderRefundRows = function(list) {
    if (!list || list.length === 0) {
        return `<tr><td colspan="7" class="text-center">표시할 환불 / 취소 내역이 없습니다.</td></tr>`;
    }

    return list.map(item => {
        // 'status' 값에 따라 상태 텍스트 결정
        let statusText = '접수';
        if (item.status === 1) {
            statusText = '처리중';
        } else if (item.status === 2) {
            statusText = '완료';
        } else if (item.status === 3) {
            statusText = '기각';
        }
		
        return `
          <tr data-num="${item.refundNum}">
            <td>${item.refundNum}</td>
            <td>${item.email}</td>
            <td>${(item.refundAmount || 0).toLocaleString()}원</td>
            <td>${item.refundMethod || '-'}</td>
            <td>${item.reqDate || '-'}</td>
            <td>${item.refundDate || '-'}</td>
            <td>${statusText}</td>
          </tr>
        `;
    }).join(''); 
};


/**
 * 반품 리스트 HTML 문자열 생성
 * @param {object} item - 반품 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
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
	      <h2 class="mb-2 page-title mr-2">반품 및 교환 관리</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="return-card">
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
					      <button class="nav-link ${params.status === '' || typeof params.status === 'undefined' ? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 0 ? 'active' : ''}" id="tab-status-pending" type="button" role="tab">접수</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 1 ? 'active' : ''}" id="tab-status-processing" type="button" role="tab">처리중</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 2 ? 'active' : ''}" id="tab-status-completed" type="button" role="tab">처리완료</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 3 ? 'active' : ''}" id="tab-status-rejected" type="button" role="tab">기각</button>
					  </li>
				  </ul>
	              <table data-type="return" class="table datatables" id="contentTable">
	                <thead>
	                  <tr>
	                    <th>반품번호</th>
	                    <th>신청자 E-mail</th>
						<th>반품사유</th>
						<th>수량</th>
						<th>신청일</th>
						<th>반품일</th>
	                    <th>상태</th>
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
 * 반품 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 반품 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderReturnRows = function(list) {
    if (!list || list.length === 0) {
        return `<tr><td colspan="7" class="text-center">표시할 반품 및 교환 내역이 없습니다.</td></tr>`;
    }

    return list.map(item => {
        // 'status' 값에 따라 상태 텍스트 결정
		let statusText = '접수';
		if (item.status === 1) {
		    statusText = '처리중';
		} else if (item.status === 2) {
		    statusText = '완료';
		} else if (item.status === 3) {
		    statusText = '기각';
		}
		
        return `
          <tr data-num="${item.returnNum}">
            <td>${item.returnNum}</td>
            <td>${item.email}</td>
            <td>${item.reason || '-'}</td>
            <td>${item.quantity}개</td>
            <td>${item.reqDate || '-'}</td>
            <td>${item.returnDate || '-'}</td>
            <td>${statusText}</td>
          </tr>
        `;
    }).join(''); 
};


/**
 * 전체 클레임 리스트 HTML 문자열 생성
 * @param {object} item - 클레임 데이터 객체 (서버 응답)
 * @param {object} params - 요청 파라미터
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderAllClaimListHTML = function(item, params) {
	const schType = item.schType || "all";
	const kwd = item.kwd || "";
	
	// tbody에 렌더링할 HTML 생성
    const tbodyHTML = renderAllClaimRows(item.list);
	
	const html = `
	<div class="container-fluid">
	  <div class="row justify-content-center">
	    <div class="col-12">
	      <h2 class="mb-2 page-title mr-2">클레임 통합 내역</h2>
	      <div class="row my-4">
	        <div class="col-md-12">
	          <div class="card shadow">
	            <div class="card-body" id="claim-card">
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
					      <button class="nav-link ${params.status === '' || typeof params.status === 'undefined' ? 'active' : ''}" id="tab-status-all" type="button" role="tab">전체</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 0 ? 'active' : ''}" id="tab-status-pending" type="button" role="tab">접수</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 1 ? 'active' : ''}" id="tab-status-processing" type="button" role="tab">처리중</button>
					  </li>
					  <li class="nav-item" role="presentation">
					      <button class="nav-link ${params.status === 2 ? 'active' : ''}" id="tab-status-completed" type="button" role="tab">처리완료</button>
					  </li>
					  <li class="nav-item" role="presentation">
					       <button class="nav-link ${params.status === 3 ? 'active' : ''}" id="tab-status-rejected" type="button" role="tab">기각</button>
					  </li>
				  </ul>
	              <table data-type="claim" class="table datatables" id="claimContentTable">
	                <thead>
	                  <tr>
	                    <th>구분</th>
	                    <th>신청번호</th>
						<th>신청자 E-mail</th>
	                    <th>상세내용1</th>
	                    <th>상세내용2</th>
						<th>신청일</th>
						<th>처리일</th>
	                    <th>상태</th>
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
 * 전체 클레임 목록 테이블 - tbody HTML 생성
 * @param {Array<object>} list - 클레임 데이터 리스트
 * @returns {string} tbody에 렌더링될 HTML 문자열
 */
const renderAllClaimRows = function(list) {
	const maxLength = 20; // 컬럼 최대 글자 수
	
    if (!list || list.length === 0) {
        return `<tr><td colspan="8" class="text-center">표시할 클레임 내역이 없습니다.</td></tr>`;
    }

    return list.map(item => {
        const typeBadge = item.listType === 'return'
            ? `<span>반품 및 교환</span>`
            : `<span>환불 / 취소</span>`;
			
		let statusText = '접수';
			if (item.status === 1) {
			    statusText = '처리중';
			} else if (item.status === 2) {
			    statusText = '완료';
			} else if (item.status === 3) {
			    statusText = '기각';
			}

        // detail1: 반품사유 또는 환불금액
		const detail1Text = item.listType === 'refund'
			? `${parseInt(item.detail1, 10).toLocaleString()}원`
			: truncateText(item.detail1, maxLength);

        // detail2: 반품수량 또는 환불수단
        const detail2Text = item.listType === 'return'
            ? `${item.detail2}개`
            : truncateText(item.detail2, maxLength);
			
        return `
          <tr data-num="${item.num}" data-type="${item.listType}">
            <td>${typeBadge}</td>
            <td>${item.num}</td>
            <td>${item.email}</td>
            <td>${detail1Text}</td>
            <td>${detail2Text}</td>
            <td>${item.reqDate || '-'}</td>
            <td>${item.processDate || '-'}</td>
            <td>${statusText}</td>
          </tr>
        `;
    }).join(''); 
};

/**
 * 환불 상세 정보 관리 HTML 문자열 생성
 * @param {object} data - 환불 데이터
 * @param {object} data.info - 환불 데이터 객체
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderRefundHTML = function(data) {
	if (!data || !data.info) {
		return '<div class="alert alert-danger">환불 정보를 불러오는데 실패했습니다.</div>';
	}

	const info = data.info;

	let refundAmountText = '환불예상금액';
	
	let statusText = '';
	switch (info.status) {
		case 0:
			statusText = '환불 요청';
			break;
		case 1:
			statusText = '처리중';
			break;
		case 2:
			statusText = '환불완료';
			refundAmountText = '환불금액(완료)';
			break;
		default:
			statusText = '기각';
	}

	let orderStateText = '';

	switch (info.orderState) {
	    case 0:
	        orderStateText = '입금대기';
	        break;
	    case 1:
	        orderStateText = '결제완료';
	        break;
	    case 2:
	        orderStateText = '발송처리';
	        break;
	    case 3:
	        orderStateText = '배송시작';
	        break;
	    case 4:
	        orderStateText = '배송중';
	        break;
	    case 5:
	        orderStateText = '배송완료';
	        break;
	    case 6:
	        orderStateText = '전체판매취소완료(관리자)';
	        break;
	    case 7:
	        orderStateText = '부분판매취소완료(관리자)';
	        break;
	    case 8:
	        orderStateText = '주문자전체주문취소완료(배송전)';
	        break;
	    case 9:
	        orderStateText = '주문자부분주문취소완료(배송전)';
	        break;
	    case 10:
	        orderStateText = '주문자전체반품취소완료(배송후)';
	        break;
	    case 11:
	        orderStateText = '주문자부분반품취소완료(배송후)';
	        break;
	    default:
	        orderStateText = '알 수 없음';
	        break;
	}
	
	// 환불 처리 이전일 경우
	if(info.refundAmount === 0) {
		
		// 할인이 없는 경우
		if(info.salePrice === 0) {
			info.salePrice = info.price;			
		}
		
		info.refundAmount = info.salePrice * info.quantity;		
		
	}
	
	const refundDate = info.refundDate ? info.refundDate : '처리 전';

	let actionButtons = '';
	if (info.status === 0) {
	    actionButtons = `
	        <button type="button" class="btn btn-primary" onclick="updateRefundStatus(${info.refundNum}, 1, ${info.orderQuantity});">환불 승인</button>&nbsp;&nbsp;
	        <button type="button" class="btn btn-danger" onclick="updateRefundStatus(${info.refundNum}, 3, ${info.orderQuantity});">기각</button>
	    `;
	} else if (info.status === 1) {
	    actionButtons = `
	        <button type="button" class="btn btn-primary" onclick="updateRefundStatus(${info.refundNum}, 2, ${info.orderQuantity});">환불 처리 완료</button>
	    `;
	} else if (info.status === 2 || info.status === 3) {
		actionButtons = `
			<button type="button" class="btn btn-danger" onclick="deleteRefund(${info.refundNum});">내역 삭제</button>
		`;
	}

	const html = `
		<div class="card shadow-sm">
			<div class="card-header bg-light">
				<h5 class="card-title mb-0">환불 상세 정보</h5>
			</div>
			<div class="card-body p-4">
				<table class="table table-bordered align-middle">
					<colgroup>
						<col style="width: 20%; background-color: #f8f9fa;">
						<col style="width: 30%;">
						<col style="width: 20%; background-color: #f8f9fa;">
						<col style="width: 30%;">
					</colgroup>
					<tbody>
						<tr>
							<th class="text-center">환불 번호</th>
							<td>${info.refundNum}</td>
							<th class="text-center">처리 상태</th>
							<td><span>${statusText}</span></td>
						</tr>
						<tr>
							<th class="text-center">주문 번호</th>
							<td>${info.orderNum}</td>
							<th class="text-center">주문 상태</th>
							<td>${orderStateText}</td>
						</tr>
						<tr>
							<th class="text-center">상품 이름</th>
							<td>${info.productName}</td>
							<th class="text-center">상품 번호</th>
							<td>${info.productNum}</td>
						</tr>
						<tr>
							<th class="text-center">요청 회원</th>
							<td>회원번호: ${info.memberId} (${info.email})</td>
							<th class="text-center">주문 상세 번호</th>
							<td>${info.orderDetailNum}</td>
						</tr>
						<tr>
							<th class="text-center">요청일</th>
							<td>${info.reqDate}</td>
							<th class="text-center">처리 완료일</th>
							<td>${refundDate}</td>
						</tr>
						<tr>
							<th class="text-center">${refundAmountText}</th>
							<td class="fw-bold">${info.refundAmount}원</td>
							<th class="text-center">환불 수단</th>
							<td>${info.refundMethod}</td>
						</tr>
						<tr>
							<th class="text-center">예금주명</th>
							<td class="fw-bold">${info.accountHolder || '-'}</td>
							<th class="text-center">은행명 / 계좌번호</th>
							<td>${info.bankName || ''}&nbsp;${info.accountNumber || '-'}</td>
						</tr>
						<tr>
							<th class="text-center">개당 판매 금액</th>
							<td>${info.salePrice}원</td>
							<th class="text-center">환불 수량</th>
							<td class="fw-bold">${info.quantity}</td>
						</tr>
					</tbody>
				</table>
			</div>
			${actionButtons ? `
			<div class="card-footer text-end py-3">
				<div class="d-flex justify-content-end gap-2">
					${actionButtons}
				</div>
			</div>
			` : ''}
		</div>
	`;

	return html;
}

/**
 * 반품 상세 정보 관리 HTML 문자열 생성
 * @param {object} data - 반품 데이터
 * @param {object} data.info - 반품 데이터 객체
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderReturnHTML = function(data) {
	if (!data || !data.info) {
		return '<div class="alert alert-danger">반품 정보를 불러오는데 실패했습니다.</div>';
	}

	const info = data.info;

	let statusText = '';
	switch (info.status) {
		case 0:
			statusText = '반품 요청';
			break;
		case 1:
			statusText = '수거중';
			break;
		case 2:
			statusText = '반품 완료';
			break;
		default: 
			statusText = '반품 기각';
			break;
	}

	let orderStateText = '';
	switch (info.orderState) {
	    case 0:
	        orderStateText = '입금대기';
	        break;
	    case 1:
	        orderStateText = '결제완료';
	        break;
	    case 2:
	        orderStateText = '발송처리';
	        break;
	    case 3:
	        orderStateText = '배송시작';
	        break;
	    case 4:
	        orderStateText = '배송중';
	        break;
	    case 5:
	        orderStateText = '배송완료';
	        break;
	    case 6:
	        orderStateText = '전체판매취소완료(관리자)';
	        break;
	    case 7:
	        orderStateText = '부분판매취소완료(관리자)';
	        break;
	    case 8:
	        orderStateText = '주문자전체주문취소완료(배송전)';
	        break;
	    case 9:
	        orderStateText = '주문자부분주문취소완료(배송전)';
	        break;
	    case 10:
	        orderStateText = '주문자전체반품취소완료(배송후)';
	        break;
	    case 11:
	        orderStateText = '주문자부분반품취소완료(배송후)';
	        break;
	    default:
	        orderStateText = '알 수 없음';
	        break;
	}
	
	const returnDate = info.returnDate ? info.returnDate : '처리 전';

	let actionButtons = '';
	if (info.status === 0) {
	    actionButtons = `
	        <button type="button" class="btn btn-primary" onclick="updateReturnStatus(${info.returnNum}, 1);">반품 승인</button>&nbsp;&nbsp;
	        <button type="button" class="btn btn-danger" onclick="updateReturnStatus(${info.returnNum}, 3);">기각</button>
	    `;
	} else if (info.status === 1) {
	    actionButtons = `
	        <button type="button" class="btn btn-primary" onclick="updateReturnStatus(${info.returnNum}, 2, ${info.orderQuantity});">반품 처리 완료</button>
	    `;
	} else if (info.status === 2 || info.status === 3) {
		actionButtons = `
			<button type="button" class="btn btn-danger" onclick="deleteReturn(${info.returnNum});">내역 삭제</button>
		`;
	}

	const html = `
		<div class="card shadow-sm mt-4">
			<div class="card-header bg-light">
				<h5 class="card-title mb-0">반품 상세 정보</h5>
			</div>
			<div class="card-body p-4">
				<table class="table table-bordered align-middle">
					<colgroup>
						<col style="width: 20%; background-color: #f8f9fa;">
						<col style="width: 30%;">
						<col style="width: 20%; background-color: #f8f9fa;">
						<col style="width: 30%;">
					</colgroup>
					<tbody>
						<tr>
							<th class="text-center">반품 번호</th>
							<td>${info.returnNum}</td>
							<th class="text-center">처리 상태</th>
							<td><span>${statusText}</span></td>
						</tr>
						<tr>
							<th class="text-center">주문 번호</th>
							<td>${info.orderNum}</td>
							<th class="text-center">주문 상태</th>
							<td>${orderStateText}</td>
						</tr>
						<tr>
							<th class="text-center">상품 이름</th>
							<td>${info.productName}</td>
							<th class="text-center">상품 번호</th>
							<td>${info.productNum}</td>
						</tr>
						<tr>
							<th class="text-center">요청 회원</th>
							<td>${info.memberId} (${info.email})</td>
							<th class="text-center">주문 상세 번호</th>
							<td>${info.orderDetailNum}</td>
						</tr>
						<tr>
							<th class="text-center">요청일</th>
							<td>${info.reqDate}</td>
							<th class="text-center">처리 완료일</th>
							<td>${returnDate}</td>
						</tr>
						<tr>
							<th class="text-center">반품 수량</th>
							<td>${info.quantity}개</td>
							<th class="text-center">반품 사유</th>
							<td>${info.reason}</td>
						</tr>
					</tbody>
				</table>
			</div>
			${actionButtons ? `
			<div class="card-footer text-end py-3">
				<div class="d-flex justify-content-end gap-2">
					${actionButtons}
				</div>
			</div>
			` : ''}
		</div>
	`;
	
	return html;
}

