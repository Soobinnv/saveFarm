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
              <h2 class="mb-2 page-title">1:1 문의</h2> <!-- 제목 -->
              <div class="row my-4">
                <!-- Small table -->
                <div class="col-md-12">
                  <div class="card shadow">
                    <div class="card-body">
                      <!-- table -->
	                     <div class="row p-2">
							<div class="col-md-12 ps-0 pb-1">
								<span class="sm-title fw-bold">문의사항</span>
							</div>
							
							<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
								제 목
							</div>
							<div class="col-md-10  border-top border-bottom p-2">
								${dto.subject}
							</div>
	
	
							<div class="col-md-2 text-center bg-light border-bottom p-2">
								카테고리
							</div>
							<div class="col-md-4 border-bottom p-2">
								카테고리리
							</div>
							<div class="col-md-2 text-center bg-light border-bottom p-2">
								이 름
							</div>
							<div class="col-md-4 border-bottom p-2">
								<c:choose>
									<c:when test="${itemId == 100}">	
										${dto.name}(${empty dto.loginId ? '비회원' : dto.loginId})
									</c:when>	
									<c:when test="${itemId == 200}">	
										${dto.farmName}(${empty dto.farmerId ? '비회원' : dto.farmerId})
									</c:when>	
								</c:choose>
							</div>
	
							<div class="col-md-2 text-center bg-light border-bottom p-2">
								문의일자
							</div>
							<div class="col-md-4 border-bottom p-2">
								${dto.regDate}
							</div>
							<div class="col-md-2 text-center bg-light border-bottom p-2">
								처리결과
							</div>
							<div class="col-md-4 border-bottom p-2">
								<c:choose>
							    <c:when test="${dto.processResult == 0}">답변대기</c:when>
							    <c:when test="${dto.processResult == 1}">답변중</c:when>
							    <c:when test="${dto.processResult == 2}">답변완료</c:when>
							    <c:otherwise>알 수 없음</c:otherwise>
							  </c:choose>
							</div>
	
							<div class="col-md-12 border-bottom mh-px-150">
								<div class="row h-100">
									<div class="col-md-2 text-center bg-light p-2 h-100 d-none d-md-block">
										내 용
									</div>
									<div class="col-md-10 p-2 h-100">
										${dto.content}
									</div>
								</div>
							</div>
	
							<c:if test="${not empty dto.answer}">
								<div class="col-md-12 ps-0 pt-3 pb-1">
									<span class="sm-title fw-bold">답변내용</span>
								</div>
	
								<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
									담당자
								</div>
								<div class="col-md-4 border-top border-bottom p-2">
									${dto.answerName}(${dto.loginAnswer})
								</div>
								<div class="col-md-2 text-center bg-light border-top border-bottom p-2">
									답변일자
								</div>
								<div class="col-md-4 border-top border-bottom p-2">
									${dto.answerDate}
								</div>
								
								<div class="col-md-12 border-bottom mh-px-150">
									<div class="row h-100">
										<div class="col-md-2 text-center bg-light p-2 h-100 d-none d-md-block">
											답 변
										</div>
										<div class="col-md-10 p-2 h-100">
											${dto.answer}
										</div>
									</div>
								</div>
							</c:if>
	
							<div class="col-md-6 p-2 ps-0">
								<div class="left-panel">
					    			<button type="button" class="btn mb-2 btn-outline-secondary" onclick="deleteOk('question');">문의삭제</button>
						    		
									<c:if test="${empty dto.answer}">
										<button type="button" class="btn mb-2 btn-outline-secondary" onclick="answerOk();">답변등록</button>
									</c:if>
									<c:if test="${not empty dto.answer && sessionScope.member.memberId==dto.answerId}">
										<button type="button" class="btn mb-2 btn-outline-secondary" onclick="answerOk();">답변수정</button>
									</c:if>
									<c:if test="${not empty dto.answer && (sessionScope.member.memberId==dto.answerId || sessionScope.member.userLevel == 99)}">
										<button type="button" class="btn mb-2 btn-outline-secondary" onclick="deleteOk('answer');">답변삭제</button>
									</c:if>
									
								</div>
							</div>
							<div class="col-md-6 p-2 pe-0 text-right">
								<c:if test="${empty prevDto}">
									<button type="button" class="btn mb-2 btn-outline-secondary" disabled>이전글</button>
								</c:if>
								<c:if test="${not empty prevDto}">
									<button type="button" class="btn mb-2 btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/inquiry/article/${itemId}?${query}&inquiryNum=${prevDto.inquiryNum}';">이전글</button>
								</c:if>
								<c:if test="${empty nextDto}">
									<button type="button" class="btn mb-2 btn-outline-secondary" disabled>다음글</button>
								</c:if>
								<c:if test="${not empty nextDto}">
									<button type="button" class="btn mb-2 btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/inquiry/article/${itemId}?${query}&inquiryNum=${nextDto.inquiryNum}';">다음글</button>
								</c:if>
								
								<button type="button" class="btn mb-2 btn-outline-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/inquiry/inquiryList/${itemId}?${query}';">리스트</button>
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

<div class="modal fade" id="myDialogModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="myDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myDialogModalLabel">${empty dto.answer ? "답변 등록" : "답변 수정"}</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-2">
				<form name="answerForm" method="post">
					<div class="row">
						<div class="col-md-12 py-3"><span class="sm-title">답변 내용</span></div>
						<div class="col-md-12 mh-px-70">
							<textarea class="form-control" name="answer">${dto.answer}</textarea>
						</div>
						<div class="col-md-12 text-end py-3">
							<input type="hidden" name="inquiryNum" value="${dto.inquiryNum}">	
							<input type="hidden" name="page" value="${page}">
								   		
						    <button type="button" class="btn mb-2 btn-outline-secondary btnAnswerSend">${empty dto.answer ? "등록완료" : "수정완료"}</button>
						    <button type="button" class="btn mb-2 btn-outline-secondary btnAnswerCancel">${empty dto.answer ? "답변취소" : "수정취소"}</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function deleteOk(mode) {
	let s = mode === 'question' ? '질문' : '답변';
	
	if(confirm(s + '을 삭제 하시 겠습니까 ? ')) {
		let params = 'inquiryNum=${dto.inquiryNum}&${query}&mode=' + mode;
		let url = '${pageContext.request.contextPath}/admin/inquiry/delete/${itemId}?' + params;
		location.href = url;
	}
}

function answerOk() {
	const modal = new bootstrap.Modal('#myDialogModal');
	modal.show();
}
  
window.addEventListener('DOMContentLoaded', ev => {
    const myModalEl = document.getElementById('myDialogModal');
	myModalEl.addEventListener('shown.bs.modal', function () {
		const f = document.answerForm;
		f.answer.focus();
	});
    
	const btnSendEL = document.querySelector('.btnAnswerSend');
	const btnCancelEL = document.querySelector('.btnAnswerCancel');

	btnSendEL.addEventListener('click', e => {
		const f = document.answerForm;
		if(! f.answer.value.trim()) {
			f.answer.focus();
			return false;
		}
		
		f.action = '${pageContext.request.contextPath}/admin/inquiry/answer/${itemId}';
		f.submit();
	});

	btnCancelEL.addEventListener('click', function(e) {
		const f = document.answerForm;
		f.answer.value = `${dto.answer}`;
		
	    const modal = bootstrap.Modal.getInstance(myModalEl);
	    modal.hide();
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