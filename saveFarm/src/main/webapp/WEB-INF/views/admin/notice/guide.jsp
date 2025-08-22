<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<div class="card shadow">
                    <div class="card-body">
                     <div class="row m-0">
              			<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">${dataCount}개 (${page}/${totalPage}페이지)</div>
             		  </div>                    
                      <ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="tab-2" data-toggle="tab" href="#tab-pane" type="button" role="tab" aria-controls="2" aria-selected="false" value='2'>전체</button>
						</li>
						<c:forEach var="dto" items="${guide}">
							<li class="nav-item" role="presentation">
								<button class="nav-link" id="tab-${dto.classify}" data-toggle="tab" href="#tab-pane" type="button" role="tab" aria-controls="${dto.classify}" aria-selected="false" value="${dto.classify}">${dto.categoryName}</button>
							</li>
						</c:forEach>
					  </ul>
                    
                      <!-- table -->
                      <table class="table datatables" id="dataTable-1">
                        <thead>
                          <tr>
                            <th>번호</th>       <!-- 글 번호 -->
							<th>제목</th>       <!-- 글 제목 -->
							<th>작성자</th>     <!-- 글 작성자 -->
							<th>작성일</th>     <!-- 글 작성일 -->
							<th>첨부</th>       <!-- 첨부파일 -->
							<th>표시</th>       <!-- 첨부파일 -->
                          </tr>
                        </thead>
                        <tbody id="guidelist">
	                      	<c:forEach var="dto" items="${list}" varStatus="status" >    
			                          <tr>
			                            <td>${dataCount - (page - 1) * size - status.index}</td>
			                            <td>
			                            	<a href="javascript:void(0);" onclick="goArticle(${dto.noticeNum}, ${itemId})" class="text-secondary">${dto.subject}</a>
			                            </td>
			                            <td>${dto.updateName}</td>
			                            <td>
			                         	   <fmt:formatDate value="${dto.updateDate}" pattern="yyyy-MM-dd HH:mm"/>
			                            </td>
			                            <td>
											<c:if test="${dto.fileCount != 0}">
				                            	<a href="${pageContext.request.contextPath}/admin/notice/zipdownload/${dto.noticeNum}" class="text-reset"><i class="fe fe-download" style="font-size:18px;"></i></a>
											</c:if>
			                           </td>
			                           <td>${dto.showNotice == 1 ? '표시' : '숨김'}</td>
			                          </tr>
	                         </c:forEach>
                        </tbody>
                      </table>
	                      <div class="row justify-content-center">
								 	${paging}
			                    </div>
			                     
		                     	<form action="${pageContext.request.contextPath}/admin/notice/noticeList/${itemId}" method="get">
								    <div class="row align-items-start">
								        <div class="col-sm-12 col-md-3"></div>
								
								        <div class="col-sm-12 col-md-6 d-flex justify-content-center flex-column text-center"> 
								
								            <!-- 검색 폼 -->
								            <div class="d-flex justify-content-center align-items-center mb-3"> 
								                <button type="reset" class="fe fe-rotate-ccw btn  btn-outline-primary me-2 mr-1"></button>
								                <select class="form-control me-2 col-2" name="schType"> 
								                    <option value="all" ${schType == 'all' ? 'selected' : ''}>제목+내용</option>
								                    <option value="loginId" ${schType == 'loginId' ? 'selected' : ''}>글쓴이</option>
								                    <option value="reg_date" ${schType == 'reg_date' ? 'selected' : ''}>작성일</option>
								                    <option value="subject" ${schType == 'subject' ? 'selected' : ''}>제목</option>
								                    <option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
								                </select>
								                <input type="text" class="form-control me-2 mr-1 col-3" name="kwd" id="search1" value="${kwd}" placeholder="Search"> 
								                <button type="submit" class="btn  btn-outline-primary">검색</button>
								            </div>
								        </div>
										
								        <!-- 오른쪽 버튼 영역 -->
								        <div class="col-sm-12 col-md-3 d-flex justify-content-end align-items-start">
								            <button type="button" class="btn btn-outline-primary mb-2 mr-1" onclick="location.href='${pageContext.request.contextPath}/admin/notice/write/${itemId}';">가이드라인 등록</button>
								        </div>
								    </div>
								</form>
                    </div>
                  </div>
