<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
		<div class="card shadow">
			<div class="card-body">
				<div class="row m-0">
					<div class="dataTables_info d-flex align-items-center" role="status" aria-live="polite">
						${dataCount}개(${page}/${totalPage}페이지)
					</div>
				</div>
				<!-- table -->
				<table class="table datatables" id="dataTable-1">
					<thead>
						<tr>
							<th>번호</th><!-- 회원생성시 번호 총합 -->
							<th>아이디</th><!-- 회원생성시 입력한 아이디 -->
							<th>구분</th><!-- 일반회원, 농가회원, 관리자 -->
							<th>농가명</th><!-- 회원생성시 입력한 이름 -->
							<th>대표명</th><!-- 회원생성시 입력한 이름 -->
							<th style="width: 200px;">전화번호</th><!-- 회원생성시 입력한 전화번호 -->
							<th style="width: 550px;">농가주소</th><!-- 회원생성시 입력한 이메일 -->
							<th>상태</th><!-- 신고시 확인 후 제한 활성 선택 -->
							<th>상세정보</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dataCount - (page-1) * size - status.index}</td>
								<td>${dto.farmerId}</td>
								<td>${empty dto.farmerId ? '' : '농가'}</td>
								<td>${dto.farmName}</td>
								<td>${dto.farmManager}</td>
								<td>${dto.farmTel}</td>
								<td>${dto.farmAddress1}</td>
								<td>
									<c:choose>
		                                <c:when test="${dto.status == 0}">신청대기</c:when>
		                                <c:when test="${dto.status == 1}">서류체크</c:when>
		                                <c:when test="${dto.status == 2}">서류탈락</c:when>
		                                <c:when test="${dto.status == 3}">승인</c:when>
		                                <c:when test="${dto.status == 4}">숨김</c:when>
		                                <c:otherwise>알 수 없음</c:otherwise>
		                            </c:choose>
								</td>
								<td>
									<button class="btn btn-sm dropdown-toggle more-horizontal" type="button" onclick="details('${dto.farmNum}','${page}');"></button>
                           		</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="row">
					<div class="col-sm-12 col-md-3"></div>
					<div class="col-sm-12 col-md-6">
						<div class="row justify-content-center">
							<c:out value="${empty paging ? '등록된 데이터가 없습니다.' : paging}" escapeXml="false" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
					<div class="col-sm-12 col-md-6 d-flex justify-content-center ">
						<c:if test="${! empty paging}">
							<div class="dataTables_paginate paging_simple_numbers"
								id="dataTable-1_paginate">
								<ul class="pagination">
									<li class="paginate_button page-item mr-2">
										<button type="button"
											class="fe fe-rotate-ccw btn mb-2 btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/admin/farm/'"></button>
									</li>
									<li class="paginate_button page-item previous disabled"
										id="dataTable-1_previous">
										<select class="form-control" id="searchType" name="schType">
											<option value="farmerId" 	${schType=="farmerId" ? "selected":""}>아이디</option>
											<option value="farmName" 		${schType=="farmName" ? "selected":""}>대표명</option>
											<option value="farmTel" 		${schType=="farmTel" ? "selected":""}>전화번호</option>
											<option value="status"		${schType=="status" ? "selected":""}>상태</option>
										</select>
									</li>
									<li class="paginate_button page-item active mr-2">
										<input type="text" class="form-control " id="keyword" name="kwd" 
										value="${schType=='status' ? 
                                                (kwd=='0' ? '신청대기' :
                                                kwd=='1' ? '서류체크' :
                                                kwd=='2' ? '서류탈락' :
                                                kwd=='3' ? '승인' :
                                                kwd=='4' ? '숨김' : kwd) : kwd}" placeholder="Search">
									</li>
									<li class="paginate_button page-item ">
										<button type="button" class="btn mb-2 btn-outline-primary" onclick="searchList()">검색</button>
									</li>
								</ul>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div> <!--  -->
