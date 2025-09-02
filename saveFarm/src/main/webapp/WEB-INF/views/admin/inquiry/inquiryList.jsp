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
              <h2 class="mb-2 page-title">${title}</h2> <!-- 제목 -->
              <div class="row my-4">
                <!-- Small table -->
                <div class="col-md-12">
                  <div class="card shadow">
                    <div class="card-body">
                     <div class="row m-0">
              			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">${dataCount}개 (${page}/${totalPage}페이지)</div>
             		  </div>                    
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>번호</th>    <!-- 문의 고유 번호 -->
                            <th>문의번호</th>    <!-- 문의 고유 번호 -->
							<th>문의명</th>       <!-- 문의 제목 -->
							<th>작성자</th>     <!-- 문의 작성자 -->
							<th>문의일자</th>   <!-- 문의 작성 날짜 -->
							<th>답변자</th>     <!-- 답변 작성자 -->
							<th>답변일자</th>   <!-- 답변 작성 날짜 -->
							<th>처리결과</th>   <!-- 문의 처리 상태 -->
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach var="dto" items="${list}" varStatus="status">
                          <tr>
                            <td>${dataCount - (page - 1) * size - status.index}</td>
                            <td>${dto.inquiryNum}</td>
                            <td>
                            	<a class="text-secondary" href="${articleUrl}&inquiryNum=${dto.inquiryNum}">${dto.subject}</a>
                            </td>
                            <td>
                            	<c:choose>
                            		<c:when test="${itemId == 100}">
                            			${dto.name}
                            		</c:when>
                            		<c:when test="${itemId == 200}">
                            			${dto.farmName}
                            		</c:when>
                            	</c:choose>
                            </td>
                            <td>${dto.regDate}</td>
                            <td>
							  <c:choose>
							    <c:when test="${dto.answerId == 0}"></c:when>
							    <c:otherwise>${dto.answerName}</c:otherwise>
							  </c:choose>
							</td>
                            <td>${dto.answerDate}</td>
                            <td>
							  <c:choose>
							    <c:when test="${dto.processResult == 0}">답변대기</c:when>
							    <c:when test="${dto.processResult == 1}">답변중</c:when>
							    <c:when test="${dto.processResult == 2}">답변완료</c:when>
							    <c:otherwise>알 수 없음</c:otherwise>
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
									${empty paging ? '등록된 데이터가 없습니다.' : paging}
								</div>
							</div>
						</div>
	                     <div class="row">
							<div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
							<div class="col-sm-12 col-md-6 d-flex justify-content-center ">
								<c:if test="${! empty paging}">
									<div class="d-flex justify-content-center align-items-center">
									    <form class="d-flex align-items-center" action="${pageContext.request.contextPath}/admin/inquiry/inquiryList/${itemId}">
									        <button type="reset" class="fe fe-rotate-ccw btn btn-outline-primary mr-2"></button>
									        
									        <select class="form-control" id="searchType" name="schType">
									            <option value="inquiryNum" ${schType=="inquiryNum" ? "selected":""}>문의번호</option>
									            <option value="subject" ${schType=="subject" ? "selected":""}>문의명</option>
									            <option value="regDate" ${schType=="regDate" ? "selected":""}>문의일자</option>
									        </select>
									        <input type="text" class="form-control mr-2" id="keyword" name="kwd" value="${kwd}" placeholder="Search">
									       
									        <button type="submit" class="btn btn-outline-primary" style="white-space: nowrap;">검색</button>
									    </form>
									</div>
								</c:if>
								<form action="" name="memberSearchForm">
									<input type="hidden" name="schType" value="loginId">
									<input type="hidden" name="kwd" value="">
									<input type="hidden" name="enabled" value="">
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
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<script type="text/javascript">

function listInquiry(page) {
	let url = '${pageContext.request.contextPath}/admin/inquiry/inquiryList/${itemId}';	
	let params = $('form[name=memberSearchForm]').serialize();
	params += '&page=' + page;
	
	const fn = function(data) {
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function resetList() {
	// 초기화
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');

	const f = document.memberSearchForm;
	
	f.schType.value = 'loginId';
	f.kwd.value = '';
	f.enabled.value = '';
	
	listInquiry(1);
}

function searchList() {
	// 검색
	const f = document.memberSearchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listInquiry(1);
}

</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>