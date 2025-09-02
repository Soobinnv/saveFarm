<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
			
		</div>		                   
		<ul class="nav nav-tabs mt-1" id="myTab" role="tablist">
		    <li class="nav-item" role="presentation">
				<button class="nav-link ${empty categoryNum ? 'active' : ''}" 
				        id="tab-all" data-bs-toggle="tab" data-bs-target="#tab-pane" type="button" 
				        role="tab" aria-controls="all" aria-selected="true" 
				        onclick="loadCategory('');">전체</button>
			</li>
		
		    <c:forEach var="dto" items="${listFAQ}" varStatus="status">
				<li class="nav-item" role="presentation">
				    <button class="nav-link ${dto.categoryNum == numCategoryNum ? 'active' : ''} bg-white" 
				           id="tab-${status.count}" data-bs-toggle="tab" data-bs-target="#tab-pane" 
				           type="button" role="tab" aria-controls="${dto.categoryNum}" 
				           aria-selected="false" data-category-num="${dto.categoryNum}" 
				           onclick="loadCategory('${dto.categoryNum}');">${dto.categoryName}</button>
				</li>
			</c:forEach>
		</ul>
		<div class="row">
			<div class="col-md-12">
				<div class="accordion w-100" id="faqAccordion">
					<table class="table datatables" id="dataTable-1">
						<thead>
							<tr>
								<th class="col-1">번호</th>
								<th class="col-2">분류</th>
								<th class="col-5">제목</th>
								<th class="col-1">작성자</th>
								<th class="col-2">작성일</th>
							</tr>
						</thead>
						<tbody> 
							<c:forEach var="dto" items="${list}" varStatus="status">
                                <tr data-bs-toggle="collapse" data-bs-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}" class="border-bottom-green">
                                    <td>${dataCount - ( page - 1 ) * size - status.index }</td>
                                    <td>${dto.categoryName}</td>
                                    <td>
                                        ${dto.subject}
                                    </td>
                                    <td>${dto.name}</td>
                                    <td>${dto.regDate}</td>
                                </tr>
                                
                                <tr id="collapse${status.index}" class="collapse">
                                    <td class="p-3">내용</td>
                                    
                                    <td colspan="4" class="p-3">
                                        ${dto.content}
                                    </td>
                                </tr>
                            </c:forEach> 
						</tbody>
					</table>
					<div class="row">
						<div class="d-flex justify-content-center">
							${empty paging ? '등록된 데이터가 없습니다.' : paging}
						</div>
					</div>	
				</div>		
			</div>
		</div>
		<div class="row justify-content-center">
            <div class="col-md-auto "> 
                <div class="d-flex justify-content-center align-items-center mb-3"> 
                    <button type="button" class="btn btn-outline-success me-2 mr-1 col-auto" onclick="resetSearch();">초기화</button>
                    <select class="form-control me-2 col" name="schType" id="searchType"> 
                        <option value="all" ${schType == 'all' ? 'selected' : ''}>검색</option>
                    </select>
                    <input type="text" class="form-control me-2 mr-1 col" name="kwd" id="keyword" value="${kwd}" placeholder="Search"> 
                    <button type="button" class="btn btn-outline-success col-auto" onclick="searchList();">검색</button>
                </div>
            </div>
        </div>
	</div>				
</div>
