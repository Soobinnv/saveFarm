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
  

.nav-tabs .nav-link {
  background-color: transparent; 
  color: inherit;  
  border: none;           
}  

#dataTable-1 th, 
#dataTable-1 td {
  text-align: center;
}

#dataTable-1 th:nth-child(3),
#dataTable-1 td:nth-child(3) {
  width: 400px;  /* 원하는 너비로 조절 */
  white-space: nowrap; /* 줄바꿈 방지 (필요하면) */
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
              <h2 class="mb-2 page-title">주문 현황</h2>
              <div class="row my-4">
                <!-- Small table -->
                <div class="col-md-12">
                  <div class="card shadow">
                    <div class="card-body">
                     <div class="row m-0">
              			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
             		  </div>                    
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>주문번호</th> <!-- 주문시 생성된 번호 -->
                            <th>주문자</th> <!-- 주문시 주문한 아이디 -->
							<th>상품명</th> <!-- 주문시 선택한 상품명 -->
							<th>옵션</th> <!-- 주문시 선택한 옵션 -->
                            <th>주문수량</th> <!-- 주문수량 -->
                            <th>주문총금액</th> <!-- 주문 총 금액-->
                            <th>주문상태</th> <!-- 구매확정 대기 완료 취소, 교환 요청 완료 불가, 반품 요청 완료 불가, 자동구매확정 -->
                            <th>주문일자</th> <!-- 주문요청한 날짜 -->
                          </tr>
                        </thead>
<!--                         <tbody> -->
                          
                           <tr>
                             <td>
                             	<a href="" class="text-secondary">202508051000000001</a>
                             </td> <!-- 주문번호 -->
                             <td>김자바</td> <!-- 구매자명 -->
                             <td>김밥</td> <!-- 상품명 -->
                             <td></td> <!-- 공백 or 옵션내용 -->
                             <td>10</td> <!-- 주문수량 -->
                             <td>50000</td> <!-- 주문총가격 -->
                             <td>구매확정대기</td> <!-- 주문상태 -->
                             <td>2025-08-08</td> <!-- 주문일짜 -->
                           </tr>
                          
                          
                        </tbody>
                      </table>
	                      <div class="row justify-content-center">
	                      	<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
					  			<ul class="pagination">
					  				<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="0" tabindex="0" class="page-link fe fe-chevron-left"></a>
					  	  			</li>
					  				<li class="paginate_button page-item active">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="1" tabindex="0" class="page-link">1</a>
					  				</li>
					  				<li class="paginate_button page-item ">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="2" tabindex="0" class="page-link">2</a>
					  				</li>
					  				<li class="paginate_button page-item ">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="3" tabindex="0" class="page-link">3</a>
					  				</li>
					  				<li class="paginate_button page-item ">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="4" tabindex="0" class="page-link">4</a>
					  				</li>
					  				<li class="paginate_button page-item next" id="dataTable-1_next">
					  					<a href="#" aria-controls="dataTable-1" data-dt-idx="5" tabindex="0" class="page-link fe fe-chevron-right"></a>
					  				</li>
					  			</ul>
					  	 	</div>
	                     </div>
	                     <div class="row">
							<div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
							<div class="col-sm-12 col-md-6 d-flex justify-content-center ">
								<div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate">
									<ul class="pagination">
										<li class="paginate_button page-item mr-2">
											<button type="reset" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary"></button>
										</li>
										<li class="paginate_button page-item previous disabled" id="dataTable-1_previous">
											<select class="form-control">
												<option>주문번호</option>
												<option>주문자</option>
												<option>주문일자</option>
											</select>
										</li>
										<li class="paginate_button page-item active mr-2">
											<input type="text" class="form-control " id="search1" value="" placeholder="Search">
										</li>
										<li class="paginate_button page-item ">
											<button type="button" class="btn mb-2 btn-outline-primary">검색</button>
										</li>
										
									</ul>
								</div>
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
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>