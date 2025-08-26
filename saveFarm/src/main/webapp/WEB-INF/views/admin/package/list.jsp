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


<style>
  /* 토글 시 사이드바 너비 변경 */
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

/* 숨겨졌을 때 */
.sidebar-collapsed #sidebar {
  transform: translateX(-100%);
}

#leftSidebar {
    width: 250px;
    transition: width 0.3s ease;
  }

  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }
  
</style>

<title>세이브팜</title>
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
              <h2 class="mb-2 page-title">구독패키지목록</h2>
              <div class="row my-4">
                <!-- Small table -->
                <div class="col-md-9">
                  <div class="card shadow">
                    <div class="card-body">
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th style="width: 100px;">번호</th> <!-- 회원생성시 번호 -->
                            <th style="width: 500px;">패키지명</th> <!-- 회원생성시 입력한 아이디 -->
							<th style="width: 200px;">가격</th> <!-- 일반회원, 농가회원, 관리자 -->
							<th>설명</th> <!-- 일반회원, 농가회원, 관리자 -->
                            <th style="width: 100px;">선택</th> 
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="dto" items="${list}" varStatus="status">
								<tr>
									<td>${dataCount - status.index}</td>
		                            <td>
		                            	<a href="#collapse${status.index}" data-toggle="collapse" data-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
											${dto.packageName}
										</a>
		                            </td>
		                            <td>${dto.price}</td>
		                            <td>${dto.content}</td>
		                            <td><button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                                <span class="text-muted sr-only">선택</span>
	                              </button>
	                              <div class="dropdown-menu dropdown-menu-right">
	                                <a class="dropdown-item" onclick="updateModal(${dto.packageNum});">상세정보</a>
	                                <a class="dropdown-item" href="#">구독좋아요알림설정까지</a>
	                              </div>
	                            </td>
								</tr>
								
								<tr id="collapse${status.index}" class="collapse">
								    <td></td> 
								    
								    <td colspan="3"> <strong>구성품:</strong>
								        <c:choose>
								            <c:when test="${not empty dto.productList}">
								                <c:forEach var="product" items="${dto.productList}" varStatus="productStatus">
								                    <a>${product.productName}</a>
								                    <c:if test="${!productStatus.last}">, </c:if>
								                </c:forEach>
								            </c:when>
								            <c:otherwise>
								                구성품 없음
								            </c:otherwise>
								        </c:choose>
								    </td>
								</tr>
							</c:forEach> 
                        </tbody>
                      </table>
	                      <div class="row">
							<div class="col-sm-12 col-md-3"></div>
							<div class="col-sm-12 col-md-6">
								<div class="row justify-content-center">
	                      	<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
					  	 	</div>
	                     </div>
							</div>
						</div>
						<div class="row">
						    <div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
						    <div class="col-sm-12 col-md-6 d-flex justify-content-center ">
						        <form name="searchForm" class="dataTables_paginate paging_simple_numbers" id="packageSearchForm">
						            <ul class="pagination">
						                <li class="paginate_button page-item mr-2">
						                    <button type="button" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary" onclick="resetList();"></button>
						                </li>
						                <li class="paginate_button page-item previous disabled">
						                    <select name="schType" id="searchType" class="form-control">
						                        <option value="packageName" ${schType=="packageName" ? "selected":""}>패키지명</option>
						                        <option value="content" ${schType=="content" ? "selected":""}>설명</option>
						                    </select>
						                </li>
						                <li class="paginate_button page-item active mr-2">
						                    <input type="text" name="kwd" id="keyword" class="form-control" placeholder="Search">
						                </li>
						                <li class="paginate_button page-item ">
						                    <button type="submit" class="btn mb-2 btn-outline-primary" onclick="searchList();">검색</button>
						                </li>
						            </ul>
						        </form>
						    </div>
						</div>
                    </div>
                  </div>
                </div> <!-- simple table -->
              </div> <!-- end section -->
            </div> <!-- .col-12 -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
      </main>
      
<div class="modal fade" data-backdrop="static" id="UpdateDialogModal" tabindex="-1" aria-labelledby="UpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="UpdateDialogModalLabel">패키지품목 변경</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			
				<form name="UpdateForm" id="UpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td width="110" class="bg-light">번호</td>
							<td width="110" class="bg-light">제품명</td>
							<td width="110" class="bg-light">제품단위</td>
							<td width="110" class="bg-light">가격</td>
							<td width="110" class="bg-light">선택</td>
							<td><p class="form-control-plaintext">${dto.loginId}</p></td>
						</tr>
						<tr>
							<td class="bg-light"></td>
							<td >이름</td>
							<td >이름</td>
							<td >이름</td>
							<td >
								<button type="button" class="btn mb-2 btn-secondary" onclick="updateModalDetails();">수정</button>
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="memberId" value="${dto.memberId}">
						<input type="hidden" name="userLevel" value="${dto.userLevel}">
						<input type="hidden" name="loginId" value="${dto.loginId}">
						<input type="hidden" name="enabled" value="${dto.enabled}">
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>      
<div class="modal fade" data-backdrop="static" id="UpdateDialogModalDetails" tabindex="-1" aria-labelledby="UpdateDialogModalLabelDetails" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="UpdateDialogModalLabelDetails">패키지품목 변경</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				
				<form name="UpdateFormDetails" id="UpdateFormDetails" method="post">
					<div class="dataTables_paginate paging_simple_numbers"
								id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item previous disabled"
										id="dataTable-1_previous">
										<select class="form-control" id="searchType" name="schType">
											<option value="productName" 	${schType=="productName" ? "selected":""}>제품명</option>
											<option value="unit" 		${schType=="unit" ? "selected":""}>판매단위</option>
											<option value="unitPrice" 		${schType=="unitPrice" ? "selected":""}>가격</option>
										</select>
									</li>
									<li class="paginate_button page-item active mr-2">
										<input type="text" class="form-control " id="keyword" name="kwd" value="${kwd}" placeholder="Search">
									</li>
									<li class="paginate_button page-item ">
										<button type="button" class="btn mb-2 btn-outline-primary" onclick="searchList()">검색</button>
									</li>
								</ul>
							</div>
					
					
					<table class="table write-form mb-1">
						<tr>
							<td width="110" class="bg-light">번호</td>
							<td width="110" class="bg-light">제품명</td>
							<td width="110" class="bg-light">제품단위</td>
							<td width="110" class="bg-light">가격</td>
							<td width="110" class="bg-light">선택</td>
							<td><p class="form-control-plaintext">${dto.loginId}</p></td>
						</tr>
						<tr>
							<td class="bg-light"></td>
							<td >이름</td>
							<td >이름</td>
							<td >이름</td>
							<td >
								<button type="button" class="btn mb-2 btn-secondary" onclick="updateOk();">선택</button>
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="memberId" value="${dto.memberId}">
						<input type="hidden" name="userLevel" value="${dto.userLevel}">
						<input type="hidden" name="loginId" value="${dto.loginId}">
						<input type="hidden" name="enabled" value="${dto.enabled}">
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>      
      
<script type="text/javascript">
$(function(){
	
});

function resetList() {
    const f = document.searchForm; // 패키지 검색 폼의 name 속성 사용

    f.schType.value = 'packageName'; 
    f.kwd.value = '';
    
    location.href = '${pageContext.request.contextPath}/admin/package/list';
    
}

function searchList() {
	// 검색
	const f = document.searchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	var schType = f.schType.value; 
	var kwd = f.kwd.value;
	
	var params = 'schType=' + schType + '&kwd=' + kwd;
	location.href = '${pageContext.request.contextPath}/admin/package/list?' + params;
}

function updateModal(packageNum) {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#UpdateDialogModal').appendTo('body');
	$('#UpdateDialogModal').modal('show');
	
	let url = '${pageContext.request.contextPath}/admin/package/package';
	let params = $('#UpdateFormDetails').serialize();
	const fn = function(data){
		
		$('#UpdateDialogModalDetails').modal('hide');
	};
	ajaxRequest(url, 'post', params, 'json', fn);
}

function updateModalDetails() {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#UpdateDialogModalDetails').appendTo('body');
	$('#UpdateDialogModalDetails').modal('show');
}

function updateOk(page) {
	// 회원 상태 변경
	const f = document.UpdateFormDetails;
	
	if( ! f.statusCode.value ) {
		alert('상태 코드를 선택하세요.');
		f.statusCode.focus();
		return;
	}
	if( ! f.memo.value.trim() ) {
		alert('상태 메모를 입력하세요.');
		f.memo.focus();
		return;
	}
	
	if( ! confirm('상태 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/member/updateOk';
	let params = $('#UpdateFormDetails').serialize();
	const fn = function(data){
		
		$('#UpdateDialogModalDetails').modal('hide');
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	
}

</script>      
      
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>