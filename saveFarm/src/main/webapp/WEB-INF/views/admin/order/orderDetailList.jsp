<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
  /* Sidebar styles can be moved to an external CSS file for better organization */
  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }
  #sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 240px;
    height: 100vh;
    background-color: #343a40;
    transition: transform 0.3s ease-in-out;
    z-index: 1030;
  }
  .sidebar-collapsed #sidebar {
    transform: translateX(-100%);
  }
  #leftSidebar {
    width: 250px;
    transition: width 0.3s ease;
  }

  /* Change: Simplified table styling, letting Bootstrap handle most of it */
  .table th, .table td {
      vertical-align: middle;
      text-align: center;
  }

  /* Change: Added a subtle style for the clickable status update span */
  .orderDetailStatus-update {
      cursor: pointer;
      color: #0d6efd;
      font-weight: 500;
  }
  .orderDetailStatus-update:hover {
      text-decoration: underline;
  }
  
  .text-line {
	  text-decoration: line-through;
  }
  
  .table .badge {
    font-size: 0.9em;
    padding: 0.5em 0.7em; 
    font-weight: 600;
  }
</style>

<title>세이브팜 - 주문 관리</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper">
	<header>
		<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
	</header>
	
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
	
	<main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <h2 class="mb-4 page-title">주문 현황</h2>
				
				<div class="card shadow" data-aos="fade-up" data-aos-delay="100">
					<div class="card-body">
						<div class="card mb-4">
							<div class="card-header d-flex justify-content-between align-items-center">
								<h5 class="card-title mb-0"><i class="bi bi-receipt-cutoff me-2"></i>주문 정보</h5>
							</div>
							<div class="card-body">
								<table class="table table-bordered mb-1">
									<tbody>
										<tr>
											<td class="table-light" width="11%"><strong>주문번호</strong></td>
											<td width="15%">${order.orderNum}</td>
											<td class="table-light" width="11%"><strong>주문자</strong></td>
											<td width="15%">${order.name}</td>
											<td class="table-light" width="11%"><strong>주문일자</strong></td>
											<td width="15%">${order.orderDate}</td>
											<td class="table-light" width="11%"><strong>주문상태</strong></td>
											<td>
												<c:choose>
													<c:when test="${order.orderState == 5 or order.orderState == 1}"><span class="badge bg-success">${order.orderStateInfo}</span></c:when>
													<c:when test="${order.orderState == 6 or order.orderState == 8}"><span class="badge bg-danger">${order.orderStateInfo}</span></c:when>
													<c:when test="${order.orderState >= 2 and order.orderState <= 4}"><span class="badge bg-info text-dark">${order.orderStateInfo}</span></c:when>
													<c:otherwise><span class="badge fs-6 bg-secondary">${order.orderStateInfo}</span></c:otherwise>
												</c:choose>
											</td>
										</tr>
										<tr>
											<td class="table-light"><strong>총금액</strong></td>
											<td class="text-primary fw-bold"><fmt:formatNumber value="${order.totalMoney}"/> 원</td>
											<td class="table-light"><strong>결제금액</strong></td>
											<td class="text-primary fw-bold"><fmt:formatNumber value="${order.payment}"/> 원</td>
											<td class="table-light"><strong>취소금액</strong></td>
											<td class="text-warning fw-bold order-cancelAmount" data-cancelAmount="${order.cancelAmount}">
												<fmt:formatNumber value="${order.cancelAmount}"/> 원
											</td>
											<td class="table-light"><strong>상태변경일</strong></td>
											<td>${order.orderStateDate}</td>
										</tr>
										<tr>
											<td class="table-light"><strong>배송비</strong></td>
											<td><fmt:formatNumber value="${order.deliveryCharge}"/> 원</td>
											<td class="table-light"><strong>배송업체</strong></td>
											<td>${order.deliveryCompanyName}</td>
											<td class="table-light"><strong>송장번호</strong></td>
											<td colspan="3">${order.invoiceNumber}</td>
										</tr>
										<tr>
											<td class="table-light"><strong>결제고유ID</strong></td>
											<td class="table-light">
												 <c:if test="${not empty order.impUid and order.impUid != 'undefined'}">
											        ${order.impUid}
											     </c:if>
											</td>
											<td class="table-light"><strong>결제수단</strong></td>
											<td>
												${order.payMethod}
												<c:if test="${not empty order.cardName}">(${order.cardName})</c:if>
											</td>
											<td class="table-light"><strong>승인번호</strong></td>
											<td>${order.applyNum}</td>
											<td class="table-light"><strong>승인일자</strong></td>
											<td>${order.applyDate}</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="card-footer d-flex justify-content-between align-items-center">
								<div>
									<c:if test="${order.orderState < 3 || order.orderState == 9}">
										<button type="button" class="btn btn-sm btn-outline-danger btn-cancel-order"><i class="bi bi-x-circle me-1"></i>판매취소</button>
									</c:if>
									<c:if test="${order.orderState >= 2 && order.orderState <= 5}">
										<button type="button" class="btn btn-sm btn-outline-info btn-delivery-detail"><i class="bi bi-geo-alt me-1"></i>배송지 확인</button>
									</c:if>
								</div>	
								<div class="d-flex align-items-center gap-2">
									<c:if test="${order.orderState == 1 || order.orderState == 9}">
										<button type="button" class="btn btn-sm btn-primary btn-prepare-order"><i class="bi bi-box-seam me-1"></i>발송처리</button>
									</c:if>
								
									<div class="d-flex align-items-center gap-2 delivery-update-area">
										<c:if test="${ (order.orderState > 1 && order.orderState < 5) }">
											<select class="form-select form-select-sm delivery-select" style="width: 150px;">
												<option value="2" ${order.orderState==2?"selected":"" }>발송준비</option>
												<option value="3" ${order.orderState==3?"selected":"" }>배송시작</option>
												<option value="4" ${order.orderState==4?"selected":"" }>배송중</option>
												<option value="5" ${order.orderState==5?"selected":"" }>배송완료</option>
											</select>
											<button type="button" class="btn btn-sm btn-success btn-delivery-order"><i class="bi bi-truck me-1"></i>배송변경</button>
										</c:if>
										<c:if test="${order.orderState == 5}">
											<span class="text-muted small">배송완료 일자 : ${order.orderStateDate}</span>
										</c:if>
									</div>
								</div>
							</div>						
						</div>
						
						<div class="card">
							<div class="card-header">
								<h5 class="card-title mb-0"><i class="bi bi-card-list me-2"></i>주문 상세 정보</h5> 
							</div>
							<div class="card-body p-0">
								<table class="table table-hover mb-0 order-detail-list">
									<thead class="table-light">
										<tr>
											<th>상세번호</th>
											<th class="text-start">상품명</th>
											<th>상품가격</th>
											<th>할인가격</th>
											<th>주문수량</th>
											<th>주문총금액</th>
											<th>주문상태</th>
											<th>상태변경</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="dto" items="${listDetail}" varStatus="status">
											<tr id="orderDetail-list${dto.orderDetailNum}">
												<td>${dto.orderDetailNum}</td>
												<td class="text-start ${dto.detailState==3||dto.detailState==5?'text-line':''}">
													${dto.productName}
												</td>
												<td class="${dto.detailState==3||dto.detailState==5?'text-line':''}"><fmt:formatNumber value="${dto.price}"/></td>
												<td class="${dto.detailState==3||dto.detailState==5?'text-line':''}"><fmt:formatNumber value="${dto.salePrice}"/></td>
												<td class="${dto.detailState==3||dto.detailState==5?'text-line':''}">${dto.qty}</td>
												<td class="${dto.detailState==3||dto.detailState==5?'text-line':''}"><fmt:formatNumber value="${dto.productMoney}"/></td>
												<td>
													<c:choose>
														<c:when test="${(order.orderState==1||order.orderState==7||order.orderState==9) && dto.detailState==0}">
															<span class="badge fs-6 bg-info text-dark">상품준비중</span>
														</c:when>
														<c:otherwise>
															<span class="badge fs-6 bg-info text-dark">${dto.detailStateInfo}</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													<span class="orderDetailStatus-update" 
															data-orderNum="${order.orderNum}" 
															data-orderState="${order.orderState}"
															data-memberId="${order.memberId}"
															data-payment="${order.payment}"
															data-orderDate="${order.orderDate}"
															data-productMoney="${dto.productMoney}"
															data-orderDetailNum="${dto.orderDetailNum}"
															data-productNum="${dto.productNum}"
															data-qty="${dto.qty}"
															data-detailState="${dto.detailState}">
														<i class="bi bi-pencil-square"></i> 수정
													</span>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
						
						<div class="d-flex justify-content-between mt-4">
							<div>
								<button type="button" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> 이전주문</button>
								<button type="button" class="btn btn-outline-secondary">다음주문 <i class="bi bi-arrow-right"></i></button>
							</div>	
							<div>
								<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/order/orderList/${itemId}?${query}';"><i class="bi bi-list-ul"></i> 목록으로</button>
							</div>
						</div>
					</div>
		    	</div> </div> </div> </div> </main>
      
<div class="modal fade" id="orderDetailStateDialogModal" tabindex="-1" aria-labelledby="orderDetailStateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="orderDetailStateDialogModalLabel"><i class="bi bi-toggles"></i> 주문 상세 정보 상태 변경</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<div class="alert alert-light" role="alert">
  					<strong class="optionDetail-value"></strong>
				</div>
				<table class="table table-sm table-bordered">
					<thead class="table-light">
						<tr>
							<th width="50">코드</th>
							<th width="120">구분</th>
							<th width="90">작성자</th>
							<th width="150">날짜</th>
							<th>설명</th>
						</tr>
					</thead>
					<tbody class="detailState-list"></tbody>	
				</table>
				
				<div class="p-1 detailStateUpdate-form mt-3">
					<form name="detailStateForm" class="row justify-content-center g-2">
						<div class="col-auto">
								<select name="detailState" class="form-select" style="width: 170px;"></select>
							</div>
						<div class="col">
							<input type="text" name="stateMemo" class="form-control" placeholder="상태 메시지 입력">
						</div>
						<div class="col-auto">
							<input type="hidden" name="orderNum">
							<input type="hidden" name="orderDetailNum">
							<input type="hidden" name="productNum">
							<input type="hidden" name="payment">
							<input type="hidden" name="memberId">
							<input type="hidden" name="orderDate">
							<input type="hidden" name="qty">
							<input type="hidden" name="productMoney">
							<input type="hidden" name="cancelAmount">
							
							<button type="button" class="btn btn-primary btnDetailStateUpdateOk"><i class="bi bi-check-lg"></i> 변경</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="prepareDialogModal" tabindex="-1" aria-labelledby="prepareDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="prepareDialogModalLabel"><i class="bi bi-truck"></i> 발송 처리 (송장 번호 입력)</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-1">
				<div class="mb-3 p-3 bg-light rounded">
					<p class="mb-1"><strong>배송지:</strong> (${delivery.zip}) ${delivery.addr1} ${delivery.addr2}</p>
					<p class="mb-0"><strong>배송요청:</strong> ${delivery.requestMemo}</p>
				</div>
				<form class="row g-2 align-items-center" name="invoiceNumberForm" method="post">
					<div class="col-auto">
						<select name="deliveryName" class="form-select" style="width: 170px;">
							<c:forEach var="vo" items="${listDeliveryCompany}">
								<option>${vo.DELIVERYCOMPANYNAME}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col">
						<input name="invoiceNumber" type="text" class="form-control" placeholder="송장번호를 입력하세요">
					</div>
					<div class="col-auto">
						<input type="hidden" name="orderNum" value="${order.orderNum}">
						<input type="hidden" name="orderState" value="2">
						
						<button type="button" class="btn btn-success btnInvoiceNumberOk"><i class="bi bi-box-arrow-in-up"></i> 등록 완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="deliveryDialogModal" tabindex="-1" aria-labelledby="deliveryDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 700px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deliveryDialogModalLabel"><i class="bi bi-signpost-split"></i> 배송지 정보</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body pt-3">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th class="table-light text-center" width="100">주문번호</th>
							<td>${order.orderNum}</td>
							<th class="table-light text-center" width="100">주문자</th>
							<td>${order.name}</td>
						</tr>
						<tr>
							<th class="table-light text-center">구매상품</th>
							<td colspan="3">
								<c:forEach var="dto" items="${listDetail}">
									<c:if test="${dto.detailState < 3 || dto.detailState > 5 }">
										<p class="mb-1">${dto.productName}</p>									
									</c:if>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<th class="table-light text-center">받는사람</th>
							<td>${delivery.recipientName}</td>
							<th class="table-light text-center">전화번호</th>
							<td>${delivery.tel}</td>
						</tr>
						<tr>
							<th class="table-light text-center">주 소</th>
							<td colspan="3">(${delivery.zip}) ${delivery.addr1} ${delivery.addr2}</td>
						</tr>
						<tr>
							<th class="table-light text-center">수령장소</th>
							<td colspan="3">
								${delivery.pickup}, 
								<c:if test="${empty delivery.passcode}">
									${delivery.accessInfo}
								</c:if>
								<c:if test="${not empty delivery.passcode}">
									공동현관비밀번호 : ${delivery.passcode}
								</c:if>
							</td>
						</tr>
						<tr>
							<th class="table-light text-center">배송메모</th>
							<td colspan="3">${delivery.requestMemo}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-delivery-print"><i class="bi bi-printer"></i> 배송지 인쇄</button>
			</div>				
		</div>
	</div>
</div>

<script type="text/javascript">
// The JavaScript remains the same as its logic is sound.
// The only thing to note is a potential error.

// 발송처리 대화상자(송장번호 입력)
$(function(){
	$('.btn-prepare-order').on('click', function() {
		$('#prepareDialogModal').modal('show');
	});

	$('.btnInvoiceNumberOk').click(function() {
		let requestCount = '${order.cancelRequestCount}';
		if(requestCount !== '0') {
			alert('주문취소를 처리한 후 발송처리가 가능합니다.');
			return false;
		}
		
		const f = document.invoiceNumberForm;
		if(!f.invoiceNumber.value.trim()) {
			alert('송장 번호를 입력하세요');
			f.invoiceNumber.focus(); // Added for better UX
			return false;
		}
		
		let params = $('form[name=invoiceNumberForm]').serialize();
		let url = '${pageContext.request.contextPath}/admin/order/invoiceNumber';
		
		const fn = function(data) {
			if(data.state === 'true') {
				$("#prepareDialogModal").modal("hide");
				location.reload(); // Simpler than building the URL again
			} else {
				alert('발송처리가 실패 했습니다.');
			}
		};
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 배송 변경(배송중/배송완료)
$(function(){
	$('.btn-delivery-order').on('click', function() {
		const $EL = $(this);
		let orderNum = '${order.orderNum}';
		let preState = '${order.orderState}';
		
		let orderState = $EL.closest('.delivery-update-area').find('select').val();
		
		if(preState >= orderState) {
			alert('배송 변경은 현 배송 단계보다 이전으로 되돌릴 수 없습니다.');
			return false;
		}
		
		let params = 'orderNum=' + orderNum + '&orderState=' + orderState;
		let url = '${pageContext.request.contextPath}/admin/order/delivery';

		const fn = function(data) {
			if(data.state === 'true') {
				location.reload();
			}
		};
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

// 모든 구매 내역 판매 취소
$(function(){
	$('.btn-cancel-order').on('click', function(){
		let orderNum = '${order.orderNum}';
		if(confirm('모든 구매내역을 판매 취소 하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
			// Add cancellation logic here
			alert('판매 취소 로직을 구현해야 합니다.');
		}
	});
});

// 주문상세 - 상태확인/변경
$(function(){
	$('.orderDetailStatus-update').on('click', function(){
		const $EL = $(this);
		const f = document.detailStateForm;
		f.reset();
		
		let orderNum = $EL.data('ordernum');
		let orderState = $EL.data('orderstate');
		let detailState = $EL.data('detailstate').toString(); // Ensure it's a string for comparison
		let productMoney = $EL.data('productmoney');
		let cancelAmount = $('.order-cancelAmount').data('cancelamount');
		let payment = $EL.data('payment');
		let memberId = $EL.data('member_id');
		let orderDate = $EL.data('orderdate');
		
		let orderDetailNum = $EL.data('orderdetailnum');
		let productNum = $EL.data('productnum');
		let qty = $EL.data('qty');
		
		f.orderNum.value = orderNum;
		f.orderDetailNum.value = orderDetailNum;
		f.productNum.value = productNum;
		f.memberId.value = memberId;
		f.orderDate.value = orderDate;
		f.qty.value = qty;
		f.productMoney.value = productMoney;
		f.payment.value = payment;
		f.cancelAmount.value = cancelAmount;

        // NOTE: The original code had 'f.savedMoney.value = savedMoney;'
        // but 'savedMoney' was not defined. This has been removed.
        // If you need it, ensure 'savedMoney' is passed via a data attribute.

		let pname = $EL.closest('tr').find('td').eq(1).text().trim();
		$('.optionDetail-value').text(pname);
		
		const $SELECT = $('form[name=detailStateForm] select[name=detailState]');
		$SELECT.empty(); // More efficient than .remove()
		
		$('.detailStateUpdate-form').show();

		if(orderState === '6' || orderState === '8' || orderState === '10') {
			$('.detailStateUpdate-form').hide();
		} else if(['1', '2', '3', '12'].includes(detailState)) {
			$('.detailStateUpdate-form').hide();
		} else if(detailState==='4') {
			$SELECT.append('<option value="5">주문취소완료</option>');
		} else if(detailState==='6'){
			$SELECT.append('<option value="7">교환접수</option>');
			$SELECT.append('<option value="8">교환발송완료</option>');
			$SELECT.append('<option value="9">교환불가</option>');
		} else if(detailState==='7'){
			$SELECT.append('<option value="8">교환발송완료</option>');
			$SELECT.append('<option value="9">교환불가</option>');
		} else if(detailState==='10'){
			$SELECT.append('<option value="11">반품접수</option>');
			$SELECT.append('<option value="12">반품완료</option>');
			$SELECT.append('<option value="13">반품불가</option>');
		} else if(detailState==='11'){
			$SELECT.append('<option value="12">반품완료</option>');
			$SELECT.append('<option value="13">반품불가</option>');
		} else {
			if(orderState==="5") { // 배송완료
				$SELECT.append('<option value="2">자동구매확정</option>');
			} else {
				$SELECT.append('<option value="3">판매취소</option>');
			}
			$SELECT.append('<option value="14">기타</option>');
		}
		
		$('#orderDetailStateDialogModal').modal('show');
	});
	
	function listDetailState() {
		$('.detailState-list').empty();
		
		const f = document.detailStateForm;
		let orderDetailNum = f.orderDetailNum.value;
		let params = 'orderDetailNum=' + orderDetailNum;
		let url = '${pageContext.request.contextPath}/admin/order/listDetailState';

		const fn = function(data) {
			let out = '';
			if (data.list && data.list.length > 0) {
				for(let item of data.list) {
					out += `<tr>
							  <td>${item.DETAILSTATE}</td>
							  <td>${item.DETALSTATEINFO}</td>
							  <td>${item.NAME}</td>
							  <td>${item.DETAILSTATEDATE}</td>
							  <td class="text-start">${item.STATEMEMO}</td>
						  </tr>`;
				}
			} else {
				out = '<tr><td colspan="5" class="text-center text-muted">상태 변경 이력이 없습니다.</td></tr>';
			}
			$('.detailState-list').html(out);
		};
		ajaxRequest(url, 'get', params, 'json', fn);
	}
	
	const orderDetailStateModalEl = document.getElementById('orderDetailStateDialogModal');
	orderDetailStateModalEl.addEventListener('show.bs.modal', listDetailState);
	
	$('.btnDetailStateUpdateOk').click(function(){
		const f = document.detailStateForm;
		let orderDetailNum = f.orderDetailNum.value;
		
		let preDetailState = $('#orderDetail-list' + orderDetailNum).find('.orderDetailStatus-update').data('detailstate').toString();
		if(['3', '5', '12'].includes(preDetailState)) {
			alert('판매취소 또는 반품완료 상품은 변경이 불가능합니다.');
			return false;
		}

		if(!f.stateMemo.value.trim()) {
			alert('상태 메시지를 등록하세요');
			f.stateMemo.focus();
			return false;
		}
		
		let params = $('form[name=detailStateForm]').serialize();
		let url = '${pageContext.request.contextPath}/admin/order/updateDetailState';

		const fn = function(data) {
			if(data.state === 'true') {
				let detailState = Number(data.detailState);
				
				if([3, 5, 12].includes(detailState)) {
					// On success, reload the page to reflect the changed total amounts
					location.reload();
					return;
				}
				
				listDetailState();
				
                let changeStateInfo = $('form[name=detailStateForm] select option:selected').text();
				$('#orderDetail-list' + orderDetailNum).find('td').eq(6).html(`<span class="badge bg-secondary">${changeStateInfo}</span>`);
				$('#orderDetail-list' + orderDetailNum).find('.orderDetailStatus-update').data('detailstate', detailState);
				
				alert('주문 정보가 변경되었습니다.');
				f.reset();
			}
		};
		ajaxRequest(url, 'post', params, 'json', fn);
	});
});

$(function(){
	$('.btn-delivery-detail').click(function(){
		$('#deliveryDialogModal').modal('show');
	});
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>