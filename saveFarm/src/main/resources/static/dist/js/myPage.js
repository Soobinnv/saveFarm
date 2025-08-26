const contextPath = $('body').data('context-path');

// 처음 페이지 로딩 시
$(function() {
	// 마이페이지 메인 불러오기
	loadContent('/api/myPage/paymentList', renderMyPageMainHtml);
});

/**
 * 지정된 URL로 AJAX 요청, 응답 데이터로 HTML 렌더링
 * @param {string} url - URL (contextPath 제외)
 * @param {Function} renderFn - AJAX 응답 데이터를 인자로 받아 HTML 문자열을 반환하는 callback 함수
 */
function loadContent(url, renderFn, params) {
	// 요청 경로 생성
	url = contextPath + url;
	params ? params : '';
	// 렌더링할 HTML 요소 선택자
	let selector = '#content';
	
	const fn = function(data) {
		const html = renderFn(data);
		
		$(selector).html(html);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

// 이벤트 핸들러 등록
$(function() {
	// 장보기
	$('#content').on('click', '.btn-product-list', function() {
		location.href='${contextPath}/products';
	});
	
	// 장바구니
	$('#content').on('click', '.btn-cart', function() {
		sendOk('cart', this);
	});
	
	// 바로 구매
	$('#content').on('click', '.btn-buy', function() {
		sendOk('buy', this);
	});
	
	// 리뷰 등록 / 수정
	$('#content').on('click', '.btn-review-save', function() {
		const orderDetailNum = $(this).data('orderDetailNum');
		const mode = $(this).data('mode');

		manageReview(orderDetailNum, mode);
	});
	
	// 리뷰 등록 / 수정 form
	$('#content').on('click', '.btn-review', function() {
		renderReviewForm();
	});
	
	// 반품 신청 form
	$('#content').on('click', '.btn-return', function() {
		renderReturnForm();
	});
	
	// 반품 신청
	$('#content').on('click', '.btn-return-insert', function() {
		const $form = $(this).closest('#returnForm');
		const orderDetailNum = $(this).data('orderDetailNum');
		
		let url = contextPath + '/api/myPage/return/' + orderDetailNum;
		let params = new FormData($form[0]);
		
		const fn = function(data) {
			loadContent('/api/myPage', renderMyPageMainHtml);
		}
		
		ajaxRequest(url, 'post', params, false, fn, true);
	});
	
	// 환불 신청 form
	$('#content').on('click', '.btn-refund', function() {		
		renderRefundForm();
	});
	
	// 환불 신청
	$('#content').on('click', '.btn-refund-insert', function() {
		const $form = $(this).closest('#refundForm');
		const orderDetailNum = $(this).data('orderDetailNum');
		
		let url = contextPath + '/api/myPage/refund/' + orderDetailNum;
		let params = new FormData($form[0]);

		const fn = function(data) {
			loadContent('/api/myPage', renderMyPageMainHtml);
		}

		ajaxRequest(url, 'post', params, false, fn, true);
	});
	
	// 리뷰 수정 form
	$('#content').on('click', '.btn-review-edit', function() {
		const $reviewItem = $(this).closest('.review-item');
		const reviewImageList = $reviewItem.data('reviewImageList');
		
		if(reviewImageList !== undefined && reviewImageList !== null) {
			reviewImageList = JSON.parse(reviewImageList);
		}
		
		const orderDetailObject = {
			orderDetailNum: $reviewItem.data('orderDetailNum'),
			mainImageFilename: $reviewItem.data('mainImageFilename'),
			productName: $reviewItem.data('productName'),
			orderDate: $reviewItem.data('orderDate'),
			productNum: $reviewItem.data('productNum'),
		}
		
		const reviewObject = {
			reviewTitle: $reviewItem.data('reviewtitle'),
			star: $reviewItem.data('star'),
			review: $reviewItem.data('review')
		};
		
		renderReviewForm(orderDetailObject, reviewObject);
	});
	
	// 리뷰 삭제
	$('#content').on('click', '.btn-review-delete', function() {
		const orderDetailNum = $(this).data('orderDetailNum');
				
		if(! confirm("리뷰를 삭제하시겠습니까?")) {
			return false;
		}
		
		manageReview(orderDetailNum, "delete");
	});
});

// 사이드바 클릭 이벤트 등록
document.addEventListener("DOMContentLoaded", function () {
    const sidebarLinks = document.querySelectorAll(".sidebar li a");

    // 클릭 이벤트 등록
    sidebarLinks.forEach(link => {
        link.addEventListener("click", function() {
            // 모든 링크에서 clicked 제거
            sidebarLinks.forEach(l => l.classList.remove("clicked"));
            // 클릭한 링크에 clicked 추가
            this.classList.add("clicked");
        });
    });

    // 기본 선택 메뉴: 주문/배송 조회
    const defaultLink = document.querySelector(".sidebar li a[onclick*='/api/myPage/paymentList']");
    if (defaultLink) {
        defaultLink.classList.add("clicked");
        // 기본 콘텐츠 로드
        const onclickAttr = defaultLink.getAttribute("onclick");
        // onclick 문자열에서 URL 추출 후 실행
        const urlMatch = onclickAttr.match(/loadContent\(['"](.+?)'/);
        if (urlMatch && urlMatch[1]) {
            loadContent(urlMatch[1], renderMyPageMainHtml);
        }
    }
});

// 주문 상세 정보
$(document).on('click', '.order-details', function() {
    let orderNum = $(this).attr('data-orderNum');
    let orderDetailNum = $(this).attr('data-orderDetailNum');

	// 파라미터를 객체 형태로 전달하는 것이 더 깔끔하고 안전합니다.
	let params = { orderNum: orderNum, orderDetailNum: orderDetailNum };
	let url = contextPath + '/api/myPage/detailView';
	
    // 성공 콜백 함수
    const fn = function(data) {
       // 1. 위에서 만든 render 함수로 예쁜 HTML을 생성합니다.
       const detailHtml = renderOrderDetailHtml(data);
       
       // 2. 생성된 HTML을 모달의 내용 부분에 삽입합니다.
       $('.order-detail-view').html(detailHtml);
       
       // 3. 내용이 준비된 후, 모달 창을 띄웁니다.
	   $('#orderDetailViewDialogModal').modal('show');
    };
	
	// dataType을 'json'으로 변경하여 서버로부터 받은 데이터를 JS 객체로 자동 변환합니다.
	ajaxRequest(url, 'get', params, 'json', fn);
});

/**
 * 마이 페이지 - 메인 HTML 문자열 생성
 * @param {object} data - 내가 주문한 상품 데이터
 * @param {Array<object>} data.list - 내가 주문한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyPageMainHtml = function(data) {
  // 버튼 생성 헬퍼 함수 (이전과 동일)
  const generateActionButtons = (item) => {
    let buttons = [];
    if (item.orderState === 1) {
      buttons.push(`<button type="button" class="btn-ghost btn-cancel-order" data-orderdetailnum="${item.orderDetailNum}">결제취소</button>`);
    } else if (item.orderState >= 2 && item.orderState <= 4) {
      buttons.push(`<button type="button" class="btn-ghost btn-track-shipment" data-orderdetailnum="${item.orderDetailNum}">배송조회</button>`);
      buttons.push(`<button type="button" class="btn-ghost btn-confirm-purchase" data-orderdetailnum="${item.orderDetailNum}">구매확정</button>`);
    } else if (item.orderState === 5) {
      if (item.reviewWrite === 0 && (item.detailState === 1 || item.detailState === 2)) {
         buttons.push(`<button type="button" class="btn-ghost btn-review-write" data-orderdetailnum="${item.orderDetailNum}">리뷰쓰기</button>`);
      } else if (item.detailState === 0) {
        buttons.push(`<button type="button" class="btn-ghost btn-review-write" data-orderdetailnum="${item.orderDetailNum}">리뷰쓰기</button>`);
        buttons.push(`<button type="button" class="btn-ghost btn-return-request" data-orderdetailnum="${item.orderDetailNum}">반품요청</button>`);
        buttons.push(`<button type="button" class="btn-ghost btn-confirm-purchase" data-orderdetailnum="${item.orderDetailNum}">구매확정</button>`);
      }
    } else if (item.detailState === 1 || item.detailState === 2) {
      if (item.reviewWrite === 0) {
        buttons.push(`<button type="button" class="btn-ghost btn-review-write" data-orderdetailnum="${item.orderDetailNum}">리뷰쓰기</button>`);
      }
    }
    buttons.push(`<button type="button" class="btn-ghost" onclick="location.href='${contextPath}/products/${item.productNum}'">재구매</button>`);
    return buttons.join('');
  };

  let html = `
    <div class="welcome-box">
        </div>

    <section class="order-section">
      <div class="orderList-title">
        <div><i class="fas fa-clipboard-list"></i>주문내역</div>
      </div>
      <div class="order-content" id="orderList">
  `;

  if (!data.list || data.list.length === 0) {
    html += `<p style="text-align:center; color:#aaa; margin-top: 20px;">주문 내역이 없습니다.</p>`;
  } else {
    const groupedOrders = data.list.reduce((acc, item) => {
      if (!acc[item.orderNum]) {
        acc[item.orderNum] = [];
      }
      acc[item.orderNum].push(item);
      return acc;
    }, {});

    // --- 주문 목록 루프 시작 ---
    html += Object.values(groupedOrders).map(orderGroup => {
      const firstItem = orderGroup[0];

      let orderHtml = `
        <div class="order-day-header mt-3">
          <div>주문번호 : ${firstItem.orderNum}</div>
        </div>
      `;

      orderHtml += orderGroup.map(item => {
        const orderDate = item.orderDate.substring(0, 10);
        return `
          <div class="order-card">
            <div class="order-topline">
              <div class="text-black-50 fw-semibold">${item.orderStateInfo ?? "주문상태"}</div>
              <div class="order-menu">
                <a href="javascript:void(0)" class="order-details"
                   data-ordernum="${item.orderNum}" data-orderdetailnum="${item.orderDetailNum}">주문 상세</a>
                <a href="${contextPath}/products/${item.productNum}">상품 보기</a>
              </div>
            </div>

            <div class="d-flex gap-3">
              <img src="${contextPath}/uploads/product/${item.mainImageFilename}" alt="상품 이미지" class="order-img">
              <div class="flex-grow-1">
                <div class="order-meta">${orderDate} 구매</div>
                <div class="order-name">${item.productName}</div>
                <div class="order-meta">
                  <span class="order-label">수량</span>
                  ${item.qty}개
                </div>
                <div class="order-price">${Number(item.productMoney).toLocaleString()}원</div>
              </div>
            </div>

            <div class="mt-3">
              <div class="order-actions">
                ${generateActionButtons(item)}
              </div>
            </div>
          </div>
        `;
      }).join('');

      return orderHtml;
    }).join('');
    // --- 주문 목록 루프 끝 ---
  }

  // 섹션과 컨텐츠 div를 닫아줍니다.
  html += `
      </div>
    </section>
  `;
  
  // [수정] 모달창은 모든 루프가 끝난 후, 여기에 한 번만 생성합니다.
  html += `
    <div class="modal fade" id="orderDetailViewDialogModal" tabindex="-1" aria-labelledby="orderDetailViewDialogModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailViewDialogModalLabel">주문상세정보</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body order-detail-view"></div>
            </div>
        </div>
    </div>
  `;

  return html;
};
/**
 * 마이 페이지 - 주문 상세정보 HTML 문자열 생성
 * @param {object} data - 주문 상세정보 데이터
 * @param {object} data.dto - 주문 상품 상세 정보
 * @param {object} data.orderDelivery - 배송 정보
 * @param {Array<object>} data.listBuy - 함께 구매한 상품 목록
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderOrderDetailHtml = function(data) {
    const { dto, orderDelivery, listBuy } = data;

    // 숫자를 세 자리마다 콤마로 변환하는 헬퍼 함수
    const formatNumber = (num) => num ? num.toLocaleString('ko-KR') : '0';

    // 날짜/시간에서 날짜만 추출하는 함수
    const formatDate = (datetime) => datetime ? datetime.substring(0, 10) : '정보 없음';

    // 할인금액 계산 (총 상품금액 + 배송비 - 최종 결제금액)
    const discountAmount = (dto.totalMoney + dto.deliveryCharge) - dto.payment;

    let html = `
        <h6 class="section-title">구매 상품</h6>
        <table class="table table-bordered mb-3">
            <tr>
                <td class="table-light-green" style="width:100px;">상품명</td>
                <td colspan="5">${dto.productName}</td>
            </tr>
            <tr>
                <td class="table-light-green">주문상태</td>
                <td>${dto.detailStateInfo}</td>
                <td class="table-light-green" style="width:100px;">구매총금액</td>
                <td>${formatNumber(dto.productMoney)}원</td>
            </tr>
        </table>
    `;

    // 함께 구매한 상품이 2개 이상일 때만 표시
    if (listBuy && listBuy.length > 1) {
        html += `<h6 class="section-title">함께 구매한 상품</h6>
                 <table class="table table-bordered mb-3">`;
        listBuy.forEach(vo => {
            if (dto.orderDetailNum !== vo.orderDetailNum) {
                html += `
                    <tr>
                        <td>
                            ${vo.productName}
                            &nbsp; | &nbsp;수량 : ${vo.qty}
                            &nbsp; | &nbsp;금액 : ${formatNumber(vo.productMoney)}원
                        </td>
                    </tr>
                `;
            }
        });
        html += `</table>`;
    }

    html += `
        <h6 class="section-title">결제 정보</h6>
        <div class="payment-summary">
            <strong>${formatNumber(dto.payment)}원</strong> 결제 완료
            <div class="text-muted small mt-1">
                (총 상품금액 ${formatNumber(dto.totalMoney)}원
                + 배송비 ${formatNumber(dto.deliveryCharge)}원
                ${discountAmount > 0 ? `- 할인 ${formatNumber(discountAmount)}원` : ''})
                <br>
                ${dto.cardName || dto.payMethod} | 승인일: ${formatDate(dto.applyDate)}
            </div>
        </div>
    `;

    html += `
        <h6 class="section-title mt-3">배송 정보</h6>
        <table class="table table-bordered mb-1">
            <tr>
                <td class="table-light-green" style="width:100px;">받는사람</td>
                <td style="width:160px;">${orderDelivery.recipientName}</td>
                <td class="table-light-green" style="width:100px;">연락처</td>
                <td>${orderDelivery.tel}</td>
            </tr>
            <tr>
                <td class="table-light-green">주소</td>
                <td colspan="3">${orderDelivery.addr1} ${orderDelivery.addr2}</td>
            </tr>
            <tr>
                <td class="table-light-green">배송 메모</td>
                <td colspan="3">${orderDelivery.requestMemo || '요청사항 없음'}</td>
            </tr>
        </table>
    `;

    html += `<script>
        $('#orderDetailViewDialogModal').on('shown.bs.modal', function () {
            $(this).find('.modal-header').addClass('modal-header-custom');
        });
    </script>`;

    return html;
};


/**
 * 마이 페이지 - 내 활동 - 찜
 * @param {object} data - 내가 찜한 상품 데이터
 * @param {Array<object>} data.list - 내가 찜한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyWishListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">찜한 상품</h3>
				<p class="mt-2 text-muted">관심 있는 상품을 저장하고 관리하세요.</p>
			</div>			
			<div class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-4 p-3 bg-light rounded">
			    <div class="d-flex align-items-center">
			        <div class="form-check">
			            <input class="form-check-input" type="checkbox" value="" id="selectAll">
			            <label class="form-check-label fw-medium" for="selectAll">전체선택</label>
			        </div>
			        <span class="text-muted mx-3">|</span>
			        <button id="deleteSelected" class="btn btn-link text-decoration-none text-danger p-0 fw-medium">선택삭제</button>
			    </div>
			    <div class="mt-3 mt-sm-0 text-body-secondary">
			        총 <strong class="text-primary fw-bold">${data.list.length}</strong>개의 상품
			    </div>
			</div>
			<div id="wishlist-container">
	
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">찜한 상품이 없습니다.</p>
		    </div>
			<div class="text-center mt-3 p-5">
				<button class="btn btn-success btn-lg btn-product-list" type="button">장보러가기</button>	
			</div>
		`;
		return html;
	}
	
	html += data.list.map(item => `
        <div class="card product-card mb-4 shadow-sm position-relative">
            <div class="card-body p-4">
                <div class="row align-items-center">
                    <div class="col-12 col-sm-auto d-flex align-items-center mb-3 mb-sm-0">
                        <input class="form-check-input me-4" type="checkbox" style="width: 1.25rem; height: 1.25rem;">
                        <img src="${contextPath}/uploads/product/${item.mainImageFilename}" alt="상품 이미지" class="rounded" style="width: 8rem; height: 8rem; object-fit: cover;">
                    </div>

                    <div class="col-12 col-sm text-center text-sm-start">
                        <p class="small text-muted mb-1">${item.wishDate}</p>
                        <h3 class="h5 fw-semibold text-dark mb-2">
                            <a href="${contextPath}/products/${item.productNum}" class="text-decoration-none text-dark">${item.productName}&nbsp;${item.unit}</a>
                        </h3>
                        <div class="d-flex align-items-center justify-content-center justify-content-sm-start mb-1">
							${item.discountRate != 0 
								? `<span class="fs-5 fw-bold text-danger me-2">${item.discountRate}%</span>
								   <span class="text-muted text-decoration-line-through">${item.unitPrice}원</span>
								   <span class="ms-1 fw-bold text-dark">${item.discountedPrice}원</span>`
								: `<span class="final-price fs-5">${item.unitPrice}원</span>`
							}
                        </div>
                        <p class="small text-muted">배송비: ${item.deliveryFee}원</p>
                    </div>

                    <div class="col-12 col-md-auto mt-3 mt-md-0">
                        <div class="d-grid gap-2 d-sm-block">
						<form name="buyForm">
							<input type="hidden" name="productNums" id="product-productNum" value="${item.productNum}"> 
							<input type="hidden" name="buyQtys" id="qty" value="1"> 
							<input type="hidden" name="units" id="unit" value="${item.unit}">
								<button class="btn btn-success btn-lg btn-cart" type="button">장바구니 담기</button>
								<button class="btn btn-success btn-lg btn-buy" type="button">바로 구매</button>
							</form>
                        </div>
                    </div>
                </div>
            </div>
            <button type="button" class="btn-close position-absolute top-0 end-0 p-3" aria-label="Close"></button>
        </div>
	`).join('');
	html += `</div></div>`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 나의 리뷰
 * @param {object} data - 내가 리뷰한 상품 데이터
 * @param {Array<object>} data.list - 내가 리뷰한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyReviewListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">나의 리뷰</h3>
				<p class="text-muted">내가 작성한 상품 리뷰를 확인하고 관리할 수 있습니다.</p>
				<div class="mt-3 d-flex justify-content-center">
					<button data-order-detail-num="1" class="btn btn-success btn-lg btn-review" type="button">리뷰 작성</button>
					<button data-order-detail-num="1" class="btn btn-success btn-lg btn-return" type="button">반품 신청</button>
					<button data-order-detail-num="1" class="btn btn-success btn-lg btn-refund" type="button">환불 신청</button>
				</div>			
			</div>
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 작성한 리뷰가 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => {
		const formattedDate = new Date(item.reviewDate).toLocaleDateString();
		const reviewText = item.review.replace(/\n/g, '<br>');
		
		return `
		<div class="card mb-4 shadow-sm review-item"
			data-orderDetailNum = "${item.orderDetailNum}"
			data-productNum = "${item.productNum}"
			data-mainImageFilename = "${item.mainImageFilename}"
			data-productName = "${item.productName}"
			data-reviewDate = "${formattedDate}"
			data-unit = "${item.unit}"
			data-reviewTitle = "${item.reviewTitle}"
			data-star = "${item.star}"
			data-review = "${reviewText}"
			data-reviewImageList = "${JSON.stringify(item.reviewImageList || [])}"
			data-helpfulCount = "${item.helpfulCount}"
			>
	        <div class="card-body p-4">
	            <div class="d-flex justify-content-between align-items-start mb-3">
	                <div class="d-flex align-items-center">
	                    <img src="${contextPath}/uploads/product/${item.mainImageFilename}" 
	                         class="rounded me-3" 
	                         style="width: 60px; height: 60px; object-fit: cover;"
	                         onerror="this.onerror=null;this.src='/uploads/product/apple.jpg';">
	                    <div>
	                        <small class="text-muted">작성일: ${formattedDate}</small>
	                        <p class="card-title mb-0">${item.productName}&nbsp;${item.unit}</p>
	                    </div>
	                </div>
	                <div class="dropdown">
	                    <button type="button" data-bs-toggle="dropdown" aria-expanded="false">
	                        <iconify-icon icon="basil:menu-outline" class="align-middle"></iconify-icon>
	                    </button>
	                    <ul class="dropdown-menu dropdown-menu-end">
	                        <li><a class="dropdown-item review-dropdown-item btn-review-edit" href="javascript:void(0)">
	                            <iconify-icon icon="mdi:pencil-outline" class="me-2"></iconify-icon>수정하기
	                        </a></li>
	                        <li><a data-order-detail-num=${item.orderDetailNum} class="dropdown-item review-dropdown-item text-danger btn-review-delete" href="javascript:void(0)">
	                            <iconify-icon icon="mdi:trash-can-outline" class="me-2"></iconify-icon>삭제하기
	                        </a></li>
	                    </ul>
	                </div>
	            </div>	
				<div class="mb-3">
					<h5 class="card-title mb-0 fw-semibold">${item.reviewTitle}</h5>
				</div>
	            <div class="mb-3 d-flex align-items-center">
	                <div class="me-2">
	                    ${[...Array(5)].map((_, i) => `
	                        <iconify-icon icon="${i < item.star ? 'mdi:star' : 'mdi:star-outline'}" class="text-warning"></iconify-icon>
	                    `).join('')}
	                </div>
	                <span class="fw-bold text-warning align-middle">${item.star}.0</span>
	            </div>
	
	            <p class="card-text text-secondary mb-3">${reviewText}</p>
	
	            ${item.reviewImageList && item.reviewImageList.length > 0 ? `
	            <div class="review-images d-flex overflow-auto mb-3 pb-2">
	                ${item.reviewImageList.map(imgUrl => `
	                    <img src="${imgUrl}" class="rounded me-2" alt="리뷰 이미지" 
							style="width: 90px; height: 90px; object-fit: cover; cursor: pointer;
							onerror="this.onerror=null;this.src='/uploads/product/apple.jpg'";>
	                `).join('')}
	            </div>
	            ` : ''}
	
	            <div class="d-flex justify-content-end align-items-center text-muted">
	                <iconify-icon icon="stash:thumb-up" class="me-1"></iconify-icon>
	                <span>도움돼요 ${item.helpfulCount}</span>
	            </div>
	        </div>
	    </div>
	`}).join('');
	
	html += `
		<div class="myPagePaginate">
			${data.paging}
		</div>`
	
	return html;
}

/**
 * 마이 페이지 - 리뷰 작성/수정 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderReviewForm = function(orderDetailObject = null, reviewObject = null) {	
	// sample data
	orderDetailObject = {
		orderDetailNum:2,
		// 상품 메인 이미지
		mainImageFilename: contextPath + "/uploads/product/apple.jpg",
		productName:"햇살농장 유기농 사과 1박스(5kg)",
		orderDate:"2025-08-16",
		productNum:1
	}
	
	let mode = reviewObject === null ? "insert" : "update";
	
	const html = `
	<div class="container-lg p-4 p-sm-5">
		<div class="mb-5">
			<h3 class="display-6 fw-bold text-dark">리뷰 작성</h3>
		</div>

		<h4 class="display-8 text-dark">이 상품 어떠셨나요?</h4>
		<div class="reivew-form-product-info d-flex align-items-center mb-4">
			<img src="${orderDetailObject.mainImageFilename}" class="reivew-form-product-image me-3">
			<div>
				<p class="reivew-form-product-name mb-1">${orderDetailObject.productName}</p>
				<p class="reivew-form-order-date text-muted">주문일자: ${orderDetailObject.orderDate}</p>
			</div>
		</div>
		<form name="reviewForm" id="reviewForm" enctype="multipart/form-data">
		  <div class="mb-3">
		    <label for="starRating" class="form-label">별점</label>
		    <div class="star-rating" id="starRating">
		      <input type="radio" id="5-stars" name="star" value="5" required />
		      <label for="5-stars" class="star">&#9733;</label>
		      <input type="radio" id="4-stars" name="star" value="4" required />
		      <label for="4-stars" class="star">&#9733;</label>
		      <input type="radio" id="3-stars" name="star" value="3" required />
		      <label for="3-stars" class="star">&#9733;</label>
		      <input type="radio" id="2-stars" name="star" value="2" required />
		      <label for="2-stars" class="star">&#9733;</label>
		      <input type="radio" id="1-star" name="star" value="1" required />
		      <label for="1-star" class="star">&#9733;</label>
		    </div>
		  </div>
		  <div class="mb-3">
		    <label for="review" class="form-label">리뷰 제목</label>
		    <input value="${mode === "update" ? `${reviewObject.reviewTitle}` : ''}" class="form-control" id="reviewTitle" name="reviewTitle" placeholder="리뷰의 제목을 작성해주세요." maxlength="1000" required>
			</input>
		  </div>
		  <div class="mb-3">
		    <label for="review" class="form-label">리뷰 내용</label>
		    <textarea class="form-control" id="review" name="review" rows="5" placeholder="솔직한 리뷰를 남겨주세요." maxlength="4000" required>${mode === "update" ? `${reviewObject.review}` : ""}</textarea>
		  </div>
		  <div class="mb-3">
			<label for="reviewImages" class="form-label">사진 첨부 (선택)</label>
          	<input class="form-control" type="file" id="reviewImages" name="reviewImages" name="selectFile" multiple accept="image/*">
          </div>
		  <input type="hidden" name="productNum" value="${orderDetailObject.productNum}">
		  <div class="mt-4 d-grid">
		    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" data-mode="${mode}" type="button" class="btn btn-success btn-lg btn-review-save">리뷰 ${mode === "update" ? "수정" : "등록"}</button>
		  </div>
		</form>
	</div>
	`
	$('#content').html(html);
	
	// 별점 활성화
	if (mode === "update") {
		const star = reviewObject.star;
		$(`#starRating input[value="${star}"]`).prop('checked', true);
	}
}

/**
 * 마이 페이지 - 반품 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderReturnForm = function(orderDetailObject = null) {	
	// sample data
	orderDetailObject = {
		orderDetailNum:4,
		// 상품 메인 이미지
		mainImageFilename: contextPath + "/uploads/product/apple.jpg",
		productName:"햇살농장 유기농 사과 1박스(5kg)",
		orderDate:"2025-08-16",
		productNum:1
	}
	
	const html = `
	<div class="container mt-5">
	    <div class="card">
	        <div class="card-header">
	            <h3 class="mb-0">반품 신청 📦</h3>
	        </div>
	        <div class="card-body">
	            <div class="row mb-4 align-items-center">
	                <div class="col-md-2">
	                    <img src="${orderDetailObject.mainImageFilename}" class="img-fluid rounded" alt="상품 이미지">
	                </div>
	                <div class="col-md-10">
	                    <h5 class="card-title">${orderDetailObject.productName}</h5>
	                    <p class="card-text text-muted">주문일자: ${orderDetailObject.orderDate}</p>
	                </div>
	            </div>

	            <form id="returnForm">
	                <div class="mb-3">
	                    <label for="returnReason" class="form-label fw-bold">반품 사유</label>
	                    <textarea class="form-control" id="reason" name="reason" rows="4" placeholder="상세한 반품 사유를 입력해주세요." required></textarea>
	                </div>
	                
	                <div class="mb-3">
	                    <label for="quantity" class="form-label fw-bold">반품 수량</label>
	                    <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
	                </div>
	                
	                <div class="mb-4">
	                    <label for="returnPhotos" class="form-label fw-bold">사진 첨부</label>
	                    <input class="form-control" type="file" id="returnPhotos" name="returnPhotos" multiple>
	                    <div class="form-text">상품의 상태를 확인할 수 있는 사진을 첨부해주세요.</div>
	                </div>
	                
	                <div class="d-grid gap-2">
	                    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" type="button" class="btn-return-insert btn btn-success btn-lg">반품 신청하기</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	`;
	
	$('#content').html(html);
	
}

/**
 * 마이 페이지 - 환불 form 렌더링
 * @param {object} orderDetailObject - 주문 상세 정보 객체
 * @returns {void} #content에 HTML 렌더링
 */
const renderRefundForm = function(orderDetailObject = null) {	
	// sample data
	orderDetailObject = {
		orderDetailNum:3,
		// 상품 메인 이미지
		mainImageFilename: contextPath + "/uploads/product/apple.jpg",
		productName:"햇살농장 유기농 사과 1박스(5kg)",
		orderDate:"2025-08-16",
		productNum:1
	}
	
	const html = `
	<div class="container mt-5">
	    <div class="card">
	        <div class="card-header">
	            <h3 class="mb-0">환불 신청 💳</h3>
	        </div>
	        <div class="card-body">
	            <div class="row mb-4 align-items-center">
	                <div class="col-md-2">
	                    <img src="${orderDetailObject.mainImageFilename}" class="img-fluid rounded" alt="상품 이미지">
	                </div>
	                <div class="col-md-10">
	                    <h5 class="card-title">${orderDetailObject.productName}</h5>
	                    <p class="card-text text-muted">주문일자: ${orderDetailObject.orderDate}</p>
	                </div>
	            </div>

	            <form id="refundForm">
	                <div class="mb-3">
	                    <label for="refundMethod" class="form-label fw-bold">환불 수단</label>
	                    <select class="form-select" id="refundMethod" name="refundMethod" required>
	                        <option selected disabled value="">환불받을 결제수단을 선택하세요.</option>
	                        <option value="credit_card">카드 환불</option>
	                        <option value="bank_transfer">계좌 이체</option>
	                    </select>
	                </div>

	                <div id="bankInfo" class="border p-3 rounded mb-4" style="display: none;">
	                    <h6 class="mb-3">환불 계좌 정보 입력</h6>
	                    <div class="mb-3">
	                        <label for="bankName" class="form-label">은행명</label>
	                        <input type="text" class="form-control" id="bankName" name="bankName" placeholder="예: 국민은행">
	                    </div>
	                    <div class="mb-3">
	                        <label for="accountNumber" class="form-label">계좌번호</label>
	                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" placeholder="'-' 없이 숫자만 입력">
	                    </div>
	                    <div>
	                        <label for="accountHolder" class="form-label">예금주명</label>
	                        <input type="text" class="form-control" id="accountHolder" name="accountHolder">
	                    </div>
	                </div>
	                
	                <div class="d-grid gap-2">
	                    <button data-order-detail-num="${orderDetailObject.orderDetailNum}" type="button" class="btn-refund-insert btn btn-success btn-lg text-white">환불 신청하기</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
	
	`;
	
	$('#content').html(html);
}

/**
 * 상품 리뷰 CUD
 * @param {string} orderDetailNum - 주문 상세 번호
 */
function manageReview(orderDetailNum, mode) {
	let url = contextPath + '/api/myPage/reviews/' + orderDetailNum;
	// const params = new FormData($('#reviewForm')[0]); 
	// const method = mode === "insert" ? "POST" : "PUT";
	let params = null;
	
	switch (mode) {
		case 'insert':
			method = 'POST';
			params = new FormData($('#reviewForm')[0]);
			break;
		case 'update':
			method = 'PUT';
			params = new FormData($('#reviewForm')[0]);
			break;
		case 'delete':
			method = 'DELETE';
			break;
		default:
			console.error('manageReview - mode: ', mode);
			return; 
	}
	
	const fn = function(data) {
		// 나의 리뷰 불러오기
		loadContent('/api/myPage/reviews', renderMyReviewListHtml);
	}
	
	ajaxRequest(url, method, params, false, fn, true);
}

/**
 * 상품 리뷰 삭제
 * @param {string} orderDetailNum - 주문 상세 번호
 */
function deleteReview(orderDetailNum, mode) {
	let url = contextPath + '/api/myPage/reviews/' + orderDetailNum;
	
	const fn = function(data) {
		// 나의 리뷰 불러오기
		loadContent('/api/myPage/reviews', renderMyReviewListHtml);
	}
	
	ajaxRequest(url, "DELETE", params, false, fn, false);
}


/**
 * 마이 페이지 - 내 활동 - 1:1 문의
 * @param {object} data - 나의 문의 데이터
 * @param {Array<object>} data.list - 내가 문의한 inquiry 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyInquiryListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">1:1 문의</h3>
				<p class="text-muted">내가 문의한 내용을 확인하고, 관리자의 답변을 확인할 수 있습니다.</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 문의한 내용이 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => `

		
	`).join('');
	html += `</div>`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 나의 상품 문의
 * @param {object} data - 내가 문의한 상품 데이터
 * @param {Array<object>} data.list - 내가 문의한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyQnaListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">나의 상품 문의</h3>
				<p class="text-muted">내가 문의한 상품을 확인하고, 관리자의 답변을 확인할 수 있습니다.</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 문의한 상품이 없습니다.</p>
		    </div>
		`;
		return html;
	} else {
			html += `
				<h4>상품 문의</h4>
				<div class="qna-list-wrapper mt-3">
					<div class="qna-list-header">
						<span class="qna-status">상태</span> <span
							class="qna-title text-center">제목</span> 
						<span class="qna-author">작성자</span>
							<span class="qna-date">등록일</span>
					</div>
				<div class="accordion accordion-flush" id="qna-list-body">
			`;
			
			
			html += data.list.map(item => {
				const isAnswered = item.answer && item.answer.trim() !== '';
				const statusClass = isAnswered ? 'answered' : '';
				const statusText = isAnswered ? '답변완료' : '답변대기';
				const collapseId = `qna-answer-${item.qnaNum}`;

				let itemHtml = `
					<div class="accordion-item">
						<h2 class="accordion-header">
							<button 
				                class="accordion-button ${isAnswered ? '' : 'collapsed'} ${!isAnswered ? 'disabled' : ''}" 
					                type="button" 
									${isAnswered ? `data-bs-toggle="collapse" data-bs-target="#${collapseId}"` : 'aria-disabled="true"'}>
								<span class="qna-status ${statusClass}">${statusText}</span>
								<span class="qna-title">${item.secret == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 17c1.1 0 2-.9 2-2s-.9-2-2-2s-2 .9-2 2s.9 2 2 2m6-9h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2m-6 9c-2.21 0-4-1.79-4-4s1.79-4 4-4s4 1.79 4 4s-1.79 4-4 4M9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2z"></path></svg> ' : ''}${item.title}</span>
								<span class="qna-author">${item.name}</span>
								<span class="qna-date">${item.qnaDate}</span>
							</button>
						</h2>`;

				if (isAnswered) {
					itemHtml += `
						<div id="${collapseId}" class="accordion-collapse collapse" data-bs-parent="#qna-list-body">
							<div class="accordion-body">
								<div class="qna-question-wrapper">
									<strong class="qna-prefix q-prefix">Q.</strong>
									<div class="qna-content">${item.question}</div>
								</div>
								<div class="qna-answer-wrapper">
									<strong class="qna-prefix a-prefix">A.</strong>
									<div class="qna-content">${item.answer}</div>
								</div>
							</div>
						</div>
					`;
				}

				itemHtml += `</div>`;
				return itemHtml;
					
			}).join('');
		}	
	
	html += `</div></div></div>
		<div class="myPagePaginate">
			${data.paging}
		</div>
	`;
	
	return html;
}

/**
 * 마이 페이지 - 내 활동 - 상품 문의 페이징 처리
 * @param {number} page - 현재 페이지
 */
function qnaListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/myPage/qnas', renderMyQnaListHtml, parameter)
}

/**
 * 마이 페이지 - 내 활동 - 내 리뷰 페이징 처리
 * @param {number} page - 현재 페이지
 */
function reviewListPage(page) {
	let parameter = {pageNo:page};
	loadContent('/api/myPage/reviews', renderMyReviewListHtml, parameter)
}

/**
 * 마이 페이지 - 내 활동 - FAQ
 * @param {object} data - FAQ 데이터
 * @param {Array<object>} data.list - FAQ 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderFaqListHtml = function(data) {	
	let html = `
		<div class="container-lg p-5 p-sm-5">
			<div class="mb-5">
				<h3 class="display-6 fw-bold text-dark">FAQ</h3>
				<p class="text-muted">자주 묻는 질문</p>
			</div>			
	`; 
	
	if(! data.list || data.list.length === 0) {
		html += `
			<div class="text-center mt-3 p-5 border rounded">
		        <iconify-icon icon="mdi:comment-off-outline" class="fs-1 text-muted"></iconify-icon>
		        <p class="mt-3 mb-0 text-muted">아직 등록된 FAQ가 없습니다.</p>
		    </div>
		`;
		return html;
	}
	
	html += data.list.map(item => `

		
	`).join('');
	html += `</div>`;
	
	return html;
}

/**
 * 
 * 
 */


 
function renderMySubInfoHtml(data) {
  function toArray(v) {
    if (Object.prototype.toString.call(v) === '[object Array]') return v;
    if (v === null || v === undefined || v === '') return [];
    if (typeof v === 'string') {
      var arr = v.split(',');
      var out = [];
      for (var i = 0; i < arr.length; i++) {
        var s = (arr[i] || '').replace(/^\s+|\s+$/g, '');
        if (s) out.push(s);
      }
      return out;
    }
    return [];
  }
  function n(x, d) {
    if (d === undefined) d = 0;
    var num = Number(x == null ? d : x);
    return isNaN(num) ? d : num;
  }
  function fmt(x) { return n(x, 0).toLocaleString(); }

  var dto  = data && data.dto  ? data.dto  : null; // 상단 카드용
  var list = (data && data.list && Object.prototype.toString.call(data.list) === '[object Array]') ? data.list : []; 

  // 상단: 미이용
  if (!dto || dto.isExtend === 2 || dto.isExtend == null) {
    return '' +
      '<section class="mp-sub-wrap" data-state="empty">' +
      '  <div class="mp-sub-panel mp-sub-panel--empty">' +
      '    <h3 class="mp-sub-title">정기배송 정보</h3>' +
      '    <p class="mp-sub-empty-desc">현재 정기구독 서비스를 사용하고 있지 않아요</p>' +
      '    <button type="button" class="mp-sub-cta" id="btnGoBenefits">정기구독 서비스 혜택 확인하러 가기</button>' +
      '  </div>' +
      '</section>';
  }

  // 상단 이용중
  var hasHome  = dto.homePackageNum  != null && n(dto.homePackageNum)  > 0;
  var hasSalad = dto.saladPackageNum != null && n(dto.saladPackageNum) > 0;
  var packageLabelTop = (hasHome ? '집밥 패키지' : '') + (hasHome && hasSalad ? ' + ' : '') + (hasSalad ? '샐러드 패키지' : '');
  if (!packageLabelTop) packageLabelTop = '-';

  var packagePriceTop = fmt(dto.packagePrice);
  var subMonthLabel   = dto.subMonth ? ( dto.subMonth + '개월차') : '월 -개월차';
  var payMethod       = dto.payMethod || '-';
  var monthlyTotalTop = fmt(dto.totalPay);

  // 상단 - 추가구매 렌더링
  var productNums_top = toArray(dto.productNums);
  var counts_top      = toArray(dto.counts);
  for (var i1=0;i1<counts_top.length;i1++) counts_top[i1] = n(counts_top[i1],1);
  var itemPrices_top  = toArray(dto.itemPrices);
  for (var i2=0;i2<itemPrices_top.length;i2++) itemPrices_top[i2] = n(itemPrices_top[i2],0);
  var names_top       = toArray(dto.productNames);
  var imgs_top        = toArray(dto.mainImageFileNames);
  var reviewExists	  = dto.reviewExists;

  var unit_top = [];
  for (var i3=0;i3<productNums_top.length;i3++) {
    var price = itemPrices_top[i3] || 0;
    var qty   = counts_top[i3] || 1;
    unit_top[i3] = (qty > 0 && price % qty === 0) ? (price/qty) : price;
  }

  var addonsTopHtml = '';
  if (!productNums_top.length) {
    addonsTopHtml = '<li class="mp-sub-empty">추가구매 품목이 없어요.</li>';
  } else {
    for (var i4=0;i4<productNums_top.length;i4++) {
      var p    = productNums_top[i4];
      var name = names_top[i4] || ('상품번호 ' + p);
      var img  = imgs_top[i4]  || ((window.contextPath || '') + '/dist/images/noimage.png');
      var qty  = counts_top[i4] || 1;
      var up   = unit_top[i4]   || 0;
      var line = up * qty;
      addonsTopHtml += ''
        + '<li class="mp-sub-addon">'
        +   '<img class="mp-sub-addon__thumb" src='+contextPath+'"/uploads/product/' + img + '" alt="' + name + '">'
        +   '<div class="mp-sub-addon__info">'
        +     '<div class="mp-sub-addon__name">' + name + '</div>'
        +     '<div class="mp-sub-addon__meta">'
        +       '수량 <strong>' + qty + '</strong> · 단가 <strong>' + fmt(up) + '</strong>원 · 금액 <strong>' + fmt(line) + '</strong>원'
        +     '</div>'
        +   '</div>'
        + '</li>';
    }
  }

  var infoHtml = ''
    + '<section class="mp-sub-wrap" data-state="active">'
    + '  <div class="mp-sub-panel">'
    + '    <h3 class="mp-sub-title">정기배송 정보</h3>'
    + '    <div class="mp-sub-block">'
    + '      <div class="mp-sub-block__title">구독중인 패키지</div>'
    + '      <div class="mp-sub-card">'
    + '        <div class="mp-sub-card__body">'
    + '          <div class="mp-sub-card__name">' + packageLabelTop + '</div>'
    + '          <div class="mp-sub-card__meta">' + subMonthLabel + ' · 결제수단: ' + payMethod + '</div>'
    + '          <div class="mp-sub-card__price">' + packagePriceTop + '원</div>'
    + '        </div>'
    + '      </div>'
    + '    </div>'
    + '    <div class="mp-sub-block">'
    + '      <div class="mp-sub-block__title">추가구매 상품</div>'
    + '      <ul class="mp-sub-addons">' + addonsTopHtml + '</ul>'
    + '    </div>'
    + '    <div class="mp-sub-bottom">'
    + '      <div class="mp-sub-total">월 결제 : <strong>' + monthlyTotalTop + '</strong>원</div>'
    + '      <div class="mp-sub-actions">'
    + '        <button type="button" class="mp-sub-btn mp-sub-btn--primary" id="btnChange">정기구독 품목변경</button>'
    + '        <button type="button" class="mp-sub-btn mp-sub-btn--danger" id="btnStop">정기구독 그만두기</button>'
    + '      </div>'
    + '    </div>'
    + '  </div>'
    + '</section>';

  // 하단: 정기배송 내역
  var historyBody = '';
  if (!list.length) {
    historyBody = '<div class="text-muted">내역이 없습니다.</div>';
  } else {
    for (var j = 0; j < list.length; j++) {
      var row = list[j];

      var rHasHome  = row.homePackageNum  != null && n(row.homePackageNum)  > 0;
      var rHasSalad = row.saladPackageNum != null && n(row.saladPackageNum) > 0;
      var pkgLabel  = (rHasHome ? '집밥 패키지' : '') + (rHasHome && rHasSalad ? ' + ' : '') + (rHasSalad ? '샐러드 패키지' : '');
      if (!pkgLabel) pkgLabel = '-';

      var total   = fmt(row.totalPay);
      var subNum  = row.subNum || '-';
      var payDate = row.payDate || '-';

      var pns   = toArray(row.productNums);
      var cnts  = toArray(row.counts);
      for (var k=0;k<cnts.length;k++) cnts[k] = n(cnts[k],1);
      var ips   = toArray(row.itemPrices);
      for (var k2=0;k2<ips.length;k2++) ips[k2] = n(ips[k2],0);
      var names = toArray(row.productNames);
      var imgs  = toArray(row.mainImageFileNames);

      var unit  = [];
      for (var k3=0;k3<pns.length;k3++) {
        var price2 = ips[k3] || 0, qty2 = cnts[k3] || 1;
        unit[k3] = (qty2 > 0 && price2 % qty2 === 0) ? (price2/qty2) : price2;
      }

      var CP = (window.contextPath || '');
      var addons;
      if (pns.length) {
        var out = '<div class="mb-2"><strong>추가구매 품목</strong></div><ul class="mp-sub-addons">';
        for (var m=0;m<pns.length;m++) {
          var pp   = pns[m];
          var nm   = (names && names[m]) ? names[m] : ('상품번호 ' + pp);
          var im   = (imgs  && imgs[m])  ? imgs[m]  : (CP + '/dist/images/noimage.png');
          var qv   = cnts[m] || 1;
          var upv  = unit[m] || 0;
          var line = upv * qv;
		  var btnText;
		  var subNumHidden = '<input type="hidden" name="subNum" value="'+row.subNum+'">';
		  var subMonthHidden = '<input type="hidden" name="subMonth" value="'+dto.subMonth+'">';
		  
		  if(reviewExists == 0){
			btnText = '<form method="get" action="'+CP+'/package/reviewWriteForm">'
					+ 	subNumHidden
					+	subMonthHidden
					+	'<input type="hidden" name="mode" value="write">'
					+	'<button type="submit" class="mp-sub-btn mp-sub-btn--ghost">리뷰작성하기</button>'
					+'</form>'
		  }else{
			btnText = '<form method="get" action="'+CP+'/package/reviewUpdateForm">'
					+	subMonthHidden
					+	subNumHidden
					+ 	'<input type="hidden" name="mode" value="update">'
					+	'<button type="submit" class="mp-sub-btn mp-sub-btn--ghost">리뷰수정하기</button>'
					+'</form>'
		  }
		  
		  

          out += ''
            + '<li class="mp-sub-addon">'
            +   '<img class="mp-sub-addon__thumb" src='+contextPath+'"/uploads/product/' + im + '" alt="' + nm + '">'
            +   '<div class="mp-sub-addon__info">'
            +     '<div class="mp-sub-addon__name">' + nm + '</div>'
            +     '<div class="mp-sub-addon__meta">'
            +       '수량 <strong>' + qv + '</strong>'
            +       ' · 단가 <strong>' + fmt(upv) + '</strong>원'
            +       ' · 금액 <strong>' + fmt(line) + '</strong>원'
            +     '</div>'
            +   '</div>'
            + '</li>';
        }
        out += '</ul>';
        addons = out;
      } else {
        addons = '<div class="text-muted small">추가구매 품목이 없습니다.</div>';
      }

      historyBody += ''
        + '<div class="rounded-4 p-3 mb-3" style="background:#f8fbf9;border:1px solid #e5efe9;">'
        +   '<div class="mb-2"><strong>정기배송 번호</strong> : ' + subNum + '</div>'
        +   '<div class="mb-2"><strong>결제일</strong> : ' + payDate + '</div>'
        +   '<div class="mb-2"><strong>패키지명</strong> : ' + pkgLabel + '</div>'
        +   '<div class="mb-2"><strong>월 결제금액</strong> : ' + total + '원</div>'
        +   addons
        +   '<div class="d-flex justify-content-end mt-2">'
		+ 		btnText
        +   '</div>'
        + '</div>';
    }
  }

  var historyHtml = ''
    + '<section class="container my-5">'
    + '  <div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5">'
    + '    <h6 class="fw-bold mb-3">정기배송 내역</h6>'
    +       historyBody
    + '  </div>'
    + '</section>';

  // 상단 + 하단 반환
  return infoHtml + historyHtml;
}
