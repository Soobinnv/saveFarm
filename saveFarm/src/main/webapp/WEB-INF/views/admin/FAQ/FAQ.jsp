<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- categoryNum이 비어있지 않다면 Long 타입으로 변환하여 numCategoryNum 변수에 저장 --%>
<c:set var="numCategoryNum" value="${null}" />
<c:if test="${not empty categoryNum}">
    <c:set var="numCategoryNum" value="${Long.valueOf(categoryNum)}" />
</c:if>

<div class="card shadow">
	<div class="card-body" >
		<div class="row m-0">
			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">
				${dataCount}개 (${page}/${totalPage}페이지)
			</div>
			<select class="form-control me-2 col-1" name="schTypeFAQ" id="schTypeFAQSelect" onchange="changeFaqType();">
			    <option value="memberFAQ" ${schTypeFAQ == 'memberFAQ' ? 'selected' : ''}>회원</option>
			    <option value="farmFAQ" ${schTypeFAQ == 'farmFAQ' ? 'selected' : ''}>농가</option>
			</select>
		</div>		                   
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		    <li class="nav-item" role="presentation">
				<button class="nav-link ${empty categoryNum ? 'active' : ''}" 
				        id="tab-all" data-toggle="tab" href="#tab-pane" type="button" 
				        role="tab" aria-controls="all" aria-selected="true" 
				        onclick="loadCategory('');">전체</button>
			</li>
		
		    <c:forEach var="dto" items="${listFAQ}" varStatus="status">
				<li class="nav-item" role="presentation">
				    <button class="nav-link ${dto.categoryNum == numCategoryNum ? 'active' : ''}" 
				           id="tab-${status.count}" data-toggle="tab" href="#tab-pane" 
				           type="button" role="tab" aria-controls="${dto.categoryNum}" 
				           aria-selected="false" data-category-num="${dto.categoryNum}" 
				           onclick="loadCategory('${dto.categoryNum}');">${dto.categoryName}</button>
				</li>
			</c:forEach>
		</ul>	
		<div id="faqListContent">
			<table class="table datatables" id="dataTable-1">
				<thead>
					<tr>
						<th>번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>구분</th> 
					</tr>
				</thead>
			<tbody>
				<c:forEach var="dto" items="${list}" varStatus="status">
					<tr>
						<td>${dataCount - ( page - 1 ) * size - status.index }</td>
						<td>${dto.categoryName}</td>
						<td>
							<a href="${pageContext.request.contextPath}/admin/FAQ/article?faqNum=${dto.faqNum}" class="text-secondary">${dto.subject}</a>
						</td>
						<td>${dto.name}</td>
						<td>${dto.regDate}</td>
						<td>
							<c:choose>
								<c:when test="${dto.classify == 1}">회원</c:when>
								<c:when test="${dto.classify == 2}">농가</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach> 
			</tbody>
			</table>
			 <div class="row justify-content-center">
				${paging}
			</div>
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
			<div class="col-sm-12 col-md-3 d-flex justify-content-end align-items-start">
				<button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/FAQ/FAQManage';">FAQ 카테고리 관리</button>
				<button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/FAQ/write';">질문 등록</button>
			</div>
		</div>
	</div>				
</div>