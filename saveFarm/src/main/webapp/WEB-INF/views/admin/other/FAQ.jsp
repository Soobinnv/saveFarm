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
              <h2 class="mb-2 page-title">자주하는 질문</h2>
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
								<button class="nav-link ${classify==100?'active':''}" id="tab-1" data-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="1" aria-selected="${classify==0?'true':'false'}">전체</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==200?'active':''}" id="tab-2" data-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="2" aria-selected="${classify==1?'true':'false'}">회원가입 관련</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==300?'active':''}" id="tab-3" data-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="3" aria-selected="${classify==2?'true':'false'}">제품 구매,취소,반품 관련</button>
							</li>
							<li class="nav-item" role="presentation">
								<button class="nav-link ${classify==400?'active':''}" id="tab-4" data-toggle="tab" data-bs-target="#tab-pane" type="button" role="tab" aria-controls="4" aria-selected="${classify==3?'true':'false'}">정기구독 관련</button>
							</li>
						</ul>
                    
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>번호</th>      <!-- 글 번호 -->
							<th>제목</th>      <!-- 글 제목 -->
							<th>작성자</th>     <!-- 글 작성자 -->
							<th>작성일</th>     <!-- 글 작성일 -->
							<th>구분</th>      <!-- 회원 농가 -->
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <td>1</td>
                            <td>
                            	<a href="" class="text-secondary">회원가입이 안되는경우</a>
                            </td>
                            <td>관리자</td>
                            <td>2025-08-10</td>
                            <td>
                            	회원/농가
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
							<div class="col-sm-12 col-md-2 d-flex justify-content-end align-items-center">
								<button type="button" class="btn mb-2 mr-1 btn-outline-primary">등록</button>
								<button type="button" class="btn mb-2 btn-outline-primary">삭제</button>
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