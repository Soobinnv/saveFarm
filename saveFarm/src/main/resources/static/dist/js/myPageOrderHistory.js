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

// 주문 상세 정보(클릭 시)
$(document).on('click', '.order-details', function() {
    let orderNum = $(this).attr('data-orderNum');
    let orderDetailNum = $(this).attr('data-orderDetailNum');

	let params = { 
	        orderNum: orderNum, 
	        orderDetailNum: orderDetailNum,
	        _: new Date().getTime() // 캐시 방지를 위한 파라미터
	    };
	let url = contextPath + '/api/myPage/detailView';
	
    // 성공 콜백 함수
    const fn = function(data) {
       const detailHtml = renderOrderDetailHtml(data);
       
       $('.order-detail-view').html(detailHtml);
       
	   $('#orderDetailViewDialogModal').modal('show');
    };
	
	// dataType을 'json'으로 변경하여 서버로부터 받은 데이터를 JS 객체로 자동 변환
	ajaxRequest(url, 'get', params, 'json', fn);
});

// 배송조회 이벤트 핸들러 등록
$(function() {
    $('#content').on('click', '.btn-track-shipment', function() {
        const $card = $(this).closest('.order-card');

        const orderNum = $card.data('ordernum');
        const orderDetailNum = $card.data('orderdetailnum');
        const orderStateInfo = $card.data('orderstateinfo');

        const url = contextPath + '/api/myPage/shipmentInfo';
        const params = {  orderNum: orderNum, orderDetailNum: orderDetailNum };

        const fn = function(data) {
            const trackingHtml = renderShipmentTrackingHtml(data, orderStateInfo);

            $('.shipment-tracking-view').html(trackingHtml);

            $('#shipmentTrackingModal').modal('show');
        };

        ajaxRequest(url, 'get', params, 'json', fn);
    });
});

// 구매확정 이벤트 핸들러 등록
$(function() {
	$('#content').on('click', '.btn-confirm-purchase', function() {
		let orderDetailNum = $(this).attr('data-orderDetailNum');
				
		if(!confirm('구매확정을 진행하시겠습니까?')) {
			return false;
		}

		const url = contextPath + '/api/myPage/confirmation';
		const params = { orderDetailNum: orderDetailNum };

		const fn = function(data) {
			alert('구매확정이 완료되었습니다.');
			location.reload(); 
		};

		ajaxRequest(url, "post", params, 'json', fn);
	});
});


/**
 * 마이 페이지 - 메인 HTML 문자열 생성
 * @param {object} data - 내가 주문한 상품 데이터
 * @param {Array<object>} data.list - 내가 주문한 상품 객체 배열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMyPageMainHtml = function(data) {
  // 버튼 생성 헬퍼 함수
  const generateActionButtons = (item) => {
    let buttons = [];
    if (item.orderState === 1 && item.detailState === 0) {
		
      buttons.push(`<button type="button" class="btn-ghost btn-cancel-order" data-orderdetailnum="${item.orderDetailNum}">결제취소</button>`);
	  
    } else if (item.orderState >= 2 && item.orderState <= 4) {
      buttons.push(`<button type="button" class="btn-ghost btn-track-shipment" data-orderdetailnum="${item.orderDetailNum}">배송조회</button>`);
      if(item.detailState === 0) {
	  	buttons.push(`<button type="button" class="btn-ghost btn-confirm-purchase" data-orderdetailnum="${item.orderDetailNum}">구매확정</button>`);
      }
	} else if (item.orderState === 5) {
		
      if (item.reviewWrite === 0) {
         buttons.push(`<button type="button" class="btn-ghost btn-review-write" data-orderdetailnum="${item.orderDetailNum}">리뷰쓰기</button>`);
      }
	  
	  if (item.detailState === 0) {
        buttons.push(`<button type="button" class="btn-ghost btn-confirm-purchase" data-orderdetailnum="${item.orderDetailNum}">구매확정</button>`);
      
		  if (item.detailState !== 12) {
		    buttons.push(`<button type="button" class="btn-ghost btn-return-request" data-orderdetailnum="${item.orderDetailNum}">반품요청</button>`);
		  }	
		  
		  if (item.detailState !== 20) {
		    buttons.push(`<button type="button" class="btn-ghost btn-cancel-order" data-orderdetailnum="${item.orderDetailNum}">환불요청</button>`);
		  }	
	
	  }
      
	} 
    buttons.push(`<button type="button" class="btn-ghost" onclick="location.href='${contextPath}/products/${item.productNum}?classifyCode=${item.productClassification}'">재구매</button>`);
    return buttons.join('');
  };

  let html = `
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
          <div class="order-card"
		  	data-orderDetailNum = "${item.orderDetailNum}"
		  	data-mainImageFilename = "${item.mainImageFilename}"
		  	data-productName = "${item.productName}"
		  	data-orderDate = "${orderDate}"
		  	data-productNum = "${item.productNum}"
			data-orderStateInfo = "${item.orderStateInfo}"
			data-qty = "${item.qty}"
		  	>
            <div class="order-topline">
              <div class="text-black-50 fw-semibold">${item.orderStateInfo ?? "주문상태"}</div>
              <div class="order-menu">
                <a href="javascript:void(0)" class="order-details"
                   data-ordernum="${item.orderNum}" data-orderdetailnum="${item.orderDetailNum}">주문 상세</a>
                <a href="${contextPath}/products/${item.productNum}?classifyCode=${item.productClassification}">상품 보기</a>
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
  }

  html += `
      </div>
    </section>
  `;
  
  if (data.paging) {
      html += `
        <div class="myPagePaginate">
            ${data.paging}
        </div>
      `;
    }
  
  html += `
    <div class="modal fade" id="orderDetailViewDialogModal" tabindex="-1" aria-labelledby="orderDetailViewDialogModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header modal-header-custom">
                    <h5 class="modal-title" id="orderDetailViewDialogModalLabel">주문상세정보</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body order-detail-view"></div>
            </div>
        </div>
    </div>
  `;
  
  html += `
    <div class="modal fade" id="shipmentTrackingModal" tabindex="-1" aria-labelledby="shipmentTrackingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header modal-header-custom">
                    <h5 class="modal-title" id="shipmentTrackingModalLabel">배송조회</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
				<div class="modal-body shipment-tracking-view"></div>
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

    return html;
};

/**
 * 마이 페이지 - 배송조회 정보 HTML 문자열 생성
 * @param {object} data - 배송조회 API 응답 데이터
 * @param {string} orderStateInfo - 주문 상태 정보 문자열
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderShipmentTrackingHtml = function(data, orderStateInfo) {
    const deliveryCompany = data.dto ? data.dto.deliveryCompanyName : '정보 없음';
    const invoiceNumber = data.dto ? data.dto.invoiceNumber : '정보 없음';

    let html = `
        <h6 class="section-title">배송 정보</h6>
        <table class="table table-bordered mb-1">
            <tr>
                <td class="table-light-green" style="width:100px;">배송상태</td>
                <td>${orderStateInfo || '정보 없음'}</td>
            </tr>
            <tr>
                <td class="table-light-green">배송업체</td>
                <td>${deliveryCompany}</td>
            </tr>
            <tr>
                <td class="table-light-green">송장번호</td>
                <td>${invoiceNumber}</td>
            </tr>
        </table>
    `;

    return html;
};

/**
 * 마이 페이지 - 주문 내역 페이징 처리
 * @param {number} page - 현재 페이지
 */
function paymentListPage(page) {
    let parameter = { pageNo: page };
    loadContent('/api/myPage/paymentList', renderMyPageMainHtml, parameter);
}
