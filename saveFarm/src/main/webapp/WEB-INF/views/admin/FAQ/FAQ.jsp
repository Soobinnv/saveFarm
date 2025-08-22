<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div class="card shadow">
	<div class="card-body" >
		<div class="row m-0">
			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">
				${dataCount}개 (${page}/${totalPage}페이지)
			</div>
			<select class="form-control me-2 col-1" name="schTypeFAQ" id="schTypeFAQSelect"> <!-- onchange="listCategory(1);" --> 
				<option value="memberFAQ" ${schTypeFAQ == 'memberFAQ' ? 'selected' : ''}>회원</option>
				<option value="FarmFAQ" ${schTypeFAQ == 'farmFAQ' ? 'selected' : ''}>농가</option>
			</select>
		</div>		                   
			<ul class="nav nav-tabs" id="myTab" role="tablist">
			    <li class="nav-item" role="presentation">
					<button class="nav-link ${! empty schTypeFAQ ? 'active' : ''}" id="tab-all" data-toggle="tab" href="#tab-pane" type="button" role="tab" aria-controls="all" aria-selected="true">전체</button>
				</li>
			
			    <c:forEach var="dto" items="${listFAQ}" varStatus="status">
			        <c:if test="${dto.classify == 1 or dto.classify == 2}"> 
			        	<li class="nav-item" role="presentation">
			                <button class="nav-link " id="tab-${status.count}" data-toggle="tab" href="#tab-pane" type="button" role="tab" aria-controls="${dto.categoryNum}" aria-selected="false" data-catagoryNum="${dto.categoryNum}">${dto.categoryName}</button>
			            </li>
			        </c:if>
				</c:forEach>
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
                          <%-- <c:forEach var="dto" items="${asdad }" varStatus="status"></c:forEach> --%>
	                          <tr>
	                            <td><%-- ${dataCount - ( page - 1 ) * size - status.index } --%></td>
	                            <td>
	                            	<a href="" class="text-secondary">회원가입이 안되는경우${dto.subject}</a>
	                            </td>
	                            <td>${dto.name}</td>
	                            <td>${dto.regDate}</td>
	                            <td>
	                            	${dto.classify}
	                            </td>
	                          </tr>
	                          
                        </tbody>
                      </table>
	                      <div class="row justify-content-center">
							${paging}
						</div>
						 
			<form action="${pageContext.request.contextPath}/admin/other/FAQ" method="get">
				<div class="row">
				    <div class="col-sm-12 col-md-3"></div>
				
				    <div class="col-sm-12 col-md-6 d-flex justify-content-center flex-column text-center"> 
				        <!-- 검색 폼 -->
						<div class="d-flex justify-content-center align-items-center mb-3"> 
						    <button type="reset" class="fe fe-rotate-ccw btn  btn-outline-primary me-2 mr-1"></button>
						    <select class="form-control me-2 col-2" name="schType"> 
						        <option value="all" ${schType == 'all' ? 'selected' : ''}>제목 + 내용</option>
								<option value="subject" ${schType == 'subject' ? 'selected' : ''}>제목</option>
								<option value="name" ${schType == 'name' ? 'selected' : ''}>작성자</option>
							</select>
							<input type="text" class="form-control me-2 mr-1 col-3" name="kwd" id="search1" value="${kwd}" placeholder="Search"> 
							<button type="submit" class="btn  btn-outline-primary">검색</button>
						</div>
					</div>
					<div class="col-sm-12 col-md-3 d-flex justify-content-end align-items-start">
						<button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write/${itemId}';">FAQ 카테고리 관리</button>
						<button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write/${itemId}';">질문 등록</button>
					</div>
				</div>
			</form>
	</div>				
</div>