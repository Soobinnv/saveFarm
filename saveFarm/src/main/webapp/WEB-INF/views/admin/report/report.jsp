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
				<h2 class="mb-2 page-title">신고 리스트</h2>
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
											<th>번호</th> <!-- 회원생성시 번호 -->
											<th>아이디</th> <!-- 회원생성시 입력한 아이디 -->
											<th>구분</th> <!-- 일반회원, 농가회원, 관리자 -->
											<th>이름</th> <!-- 회원생성시 입력한 이름 -->
											<th>생년월일</th> <!-- 회원생성시 입력한 생녀월일 -->
											<th>전화번호</th> <!-- 회원생성시 입력한 전화번호 -->
											<th>가입일자</th> <!-- 회원생성시 가입일자 -->
											<th>주소</th> <!-- 회원생성시 입력한 주소 -->
											<th>상태</th> <!-- 신고시 확인 후 제한 활성 선택 -->
											<th>이메일</th> <!-- 회원생성시 입력한 이메일 -->
											<th>신고횟수</th> <!-- 회원생성시 입력한 이메일 -->
											<th>선택</th> 
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>kim123</td>
											<td>일반회원</td>
											<td>김주소</td>
											<td>2000-10-10</td>
											<td>010-1111-1111</td>
											<td>2025-08-07</td>
											<td>서울특별시 어쩌구 행동 ...</td>
											<td>활성</td>
											<td>kim123@naver.com</td>
											<td>99</td>
											<td>
												<button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
													<span class="text-muted sr-only">선택</span>
												</button>
												<div class="dropdown-menu dropdown-menu-right">
													<a class="dropdown-item" href="#">신고사유</a>
													<a class="dropdown-item" href="#">활성화여부</a>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="row justify-content-center">
									1${paging}
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-3"></div>
									<div class="col-sm-12 col-md-6 d-flex justify-content-center flex-column text-center"> 
										<div class="d-flex justify-content-center align-items-center mb-3"> 
											<button type="button" class="fe fe-rotate-ccw btn btn-outline-primary me-2 mr-1" onclick="resetSearch();"></button>
												<select class="form-control me-2 col-2" name="schType" id="searchType"> 
													<option value="all" ${schType == 'all' ? 'selected' : ''}>제목 + 내용</option>
													<option value="subject" ${schType == 'subject' ? 'selected' : ''}>제목</option>
													<option value="name" ${schType == 'name' ? 'selected' : ''}>작성자</option>
												</select>
											<input type="text" class="form-control me-2 mr-1 col-3" name="kwd" id="keyword" value="${kwd}" placeholder="Search"> 
											<button type="button" class="btn btn-outline-primary" onclick="searchList();">검색</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div> <!-- simple table -->
			</div> <!-- end section -->
		</div> <!-- .col-12 -->
	</div> <!-- .row -->
</main>
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>