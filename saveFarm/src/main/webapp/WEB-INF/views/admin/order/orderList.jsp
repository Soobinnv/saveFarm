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
                            <th>주문번호</th> <!-- 주문시 주문번호 -->
                            <th>주문구분</th> <!-- 결제대기 완료 취소-->
							<th>주문자</th> <!-- 주문한 가입자명 -->
							<th>주문일자</th> <!-- 주문한 날짜 -->
                            <th>결제금액</th> <!-- 결제 총금액 -->
                            <th>주문수량</th> <!-- 주문시 주문한 수량 -->
                            <th>취소요청</th> <!-- 취소요청시 0,1 변경할지도? -->
                            <th>교환요청</th> <!-- 교환요청 '' -->
                            <th>취소완료</th> <!-- 취소완료 '' -->
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>
                            	<a href="" class="text-secondary">202508051000000008</a>
                            </td>
                            <td>결제대기${dto.orderState}</td>
                            <td>김자바${dto.name}</td>
                            <td>2025-08-15 10:10${dto.orderDate}</td>
                            <td>91000${dto.totalMoney}</td>
                            <td>10</td>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                          </tr>
                        </tbody>
                      </table>
						<div class="row justify-content-center">
							${paging}
						</div>
						 
						<form action="${pageContext.request.contextPath}/admin/order/orderList/${itemId}" method="get">
							<div class="row align-items-start">
							    <div class="col-sm-12 col-md-3"></div>
							
							    <div class="col-sm-12 col-md-6 d-flex justify-content-center flex-column text-center"> 
							        <!-- 검색 폼 -->
									<div class="d-flex justify-content-center align-items-center mb-3"> 
									    <button type="reset" class="fe fe-rotate-ccw btn  btn-outline-primary me-2 mr-1"></button>
									    <select class="form-control me-2 col-2" name="schType"> 
									        <option value="orderNum" ${schType == 'orderNum' ? 'selected' : ''}>주문번호</option>
											<option value="orderState" ${schType == 'orderState' ? 'selected' : ''}>주문구분</option>
											<option value="reg_date" ${schType == 'reg_date' ? 'selected' : ''}>주문자</option>
											<option value="subject" ${schType == 'subject' ? 'selected' : ''}>주문일자</option>
										</select>
										<input type="text" class="form-control me-2 mr-1 col-3" name="kwd" id="search1" value="${kwd}" placeholder="Search"> 
								        <button type="submit" class="btn  btn-outline-primary">검색</button>
								    </div>
								</div>
							
							</div>
						</form>
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