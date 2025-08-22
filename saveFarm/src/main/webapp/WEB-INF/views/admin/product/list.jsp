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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admincss/adminProductManagement.css" type="text/css">
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
              <h2 class="mb-2 page-title mr-2">상품 리스트</h2>
              <div class="row my-4">
                <!-- Small table -->
                <div class="col-md-12">
                  <div class="card shadow">
                    
                    <div class="card-body">
                      <div class="row m-0">
              			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">20개 (1/2페이지)</div>
             		  </div>		
                      <ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==100?'active':''}" id="tab-1" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="1" aria-selected="${classify==0?'true':'false'}">일반상품</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==200?'active':''}" id="tab-2" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="2" aria-selected="${classify==1?'true':'false'}">구출상품</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==300?'active':''}" id="tab-3" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="3" aria-selected="${classify==2?'true':'false'}">세이프팜특가</button>
							</li>
						</ul>
                    	
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>상품번호</th> <!-- 회원생성시 번호 -->
                            <th>상풍명</th> <!-- 회원생성시 입력한 아이디 -->
							<th>가격</th> <!-- 일반회원, 농가회원, 관리자 -->
							<th>재고</th> <!-- 회원생성시 입력한 이름 -->
                            <th>진열</th> <!-- 회원생성시 입력한 생녀월일 -->
                            <th>수정일</th> <!-- 회원생성시 입력한 전화번호 -->
                            <th>변경</th> <!-- 회원생성시 입력한 전화번호 -->
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>2</td>
                            <td>김밥</td>
                            <td>5000</td>
                            <td>0</td>
                            <td>일반상품</td>
                            <td>2025-08-07</td>
                            <td><button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="text-muted sr-only">Action</span>
                              </button>
                              <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item" href="#">재고</a>
                                <a class="dropdown-item" href="#">상품정보변경</a>
                              </div>
                            </td>
                          </tr>
                        </tbody>
                      </table>
	                      <div class="row">
							<div class="col-sm-12 col-md-5"></div>
							<div class="col-sm-12 col-md-5">
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
							<div class="col-sm-12 col-md-2 d-flex justify-content-end">
								<button type="button" class="btn mb-2 mr-1 btn-outline-primary">상품등록</button>
								<button type="button" class="btn mb-2 btn-outline-primary">상품삭제</button>
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