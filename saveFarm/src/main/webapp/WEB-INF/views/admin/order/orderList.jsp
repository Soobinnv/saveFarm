<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>세이브팜 - ${title}</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<style>
  /* 테이블의 th와 td를 중앙 정렬하고 세로 정렬을 중앙으로 맞춥니다. */
  #dataTable-1 th,
  #dataTable-1 td {
    text-align: center;
    vertical-align: middle;
  }
</style>
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
              <h2 class="mb-2 page-title">${title}</h2>
              <div class="row my-4">
                <div class="col-md-12">
                  <div class="card shadow">
                    <div class="card-body">
                     <div class="row m-0">
              			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">
              				${dataCount}개 (${page}/${total_page} 페이지)
              			</div>
             		  </div>
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>주문번호</th>
                            <th>주문구분</th>
							<th>주문자</th>
							<th>주문일자</th>
                            <th>결제금액</th>
                            <th>주문수량</th>
                            <th>취소요청</th>
                            <th>교환요청</th>
                            <th>취소완료</th>
                          </tr>
                        </thead>
                        <tbody>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr class="hover-cursor" 
											onclick="location.href='${pageContext.request.contextPath}/admin/order/orderList/${itemId}/${dto.orderNum}?${query}';">
										<td>${dto.orderNum}</td>
										<td>${dto.orderStateInfo}</td>
										<td>${dto.name}</td>
										<td>${dto.orderDate}</td>
										<td><fmt:formatNumber value="${dto.payment}"/></td>
										<td>${itemId==110 ? dto.totalQty : dto.totalQty}</td>
										<td>${dto.cancelRequestCount}</td>
										<td>${dto.exchangeRequestCount}</td>
										<td>${dto.detailCancelCount}</td>
									</tr>
								</c:forEach>
							</tbody>
                      </table>
                      
					  <div class="pagination page-navigation">
						   ${dataCount==0 ? "등록된 주문정보가 없습니다." : paging}
					  </div>

						<div class="row mt-3">
							<div class="col-md-3">
								<button type="button" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/admin/order/orderList/${itemId}';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
							</div>
							<div class="col-md-6 text-center">
								<form name="searchForm" class="form-search" action="${pageContext.request.contextPath}/admin/order/orderManage/${itemId}" method="get">
									<select class="form-control" name="schType">
										<option value="orderNum" ${schType=="orderNum"?"selected":""}>주문번호</option>
										<c:if test="${itemId==110}">
											<option value="invoiceNumber" ${schType=="invoiceNumber"?"selected":""}>송장번호</option>
										</c:if>
										<option value="name" ${schType=="name"?"selected":""}>주문자</option>
										<option value="orderDate" ${schType=="orderDate"?"selected":""}>주문일자</option>
									</select>
									<input type="text" class="form-control" name="kwd" value="${kwd}">
									<button type="button" class="btn mb-2 btn-outline-primary" onclick="searchList()">검색</button>
								</form>
							</div>
							<div class="col-md-3 text-end">
								&nbsp;
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>

<script type="text/javascript">
//검색
window.addEventListener('load', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	f.kwd.value = f.kwd.value.trim();
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/order/orderList/${itemId}';
	location.href = url + '?' + params;
}
</script>


</body>
</html>