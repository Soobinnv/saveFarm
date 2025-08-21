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
							<th>이름</th><!-- 회원생성시 입력한 이름 -->
							<th>생년월일</th><!-- 회원생성시 입력한 생년월일 -->
							<th style="width: 200px;">전화번호</th><!-- 회원생성시 입력한 전화번호 -->
							<th style="width: 250px;">이메일</th><!-- 회원생성시 입력한 이메일 -->
							<th>상태</th><!-- 신고시 확인 후 제한 활성 선택 -->
							<th>상세정보</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr>
								<td>${dataCount - (page-1) * size - status.index}</td>
								<td>${empty dto.loginId ? dto.snsId : dto.loginId}</td>
								<td>${empty dto.loginId ? 'SNS 회원' : (empty dto.snsId ? '일반 회원' : '일반, SNS 회원')}</td>
								<td>${dto.name}</td>
								<td>${dto.birth}</td>
								<td>${dto.tel}</td>
								<td>${dto.email}</td>
								<td>${dto.enabled==1 ? "활성":"잠금"}</td>
								<td>
									<button class="btn btn-sm dropdown-toggle more-horizontal" type="button" onclick="details('${dto.memberId}','${page}');"></button>
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
											class="fe fe-rotate-ccw btn mb-2 btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/admin/member/'"></button>
									</li>
									<li class="paginate_button page-item previous disabled"
										id="dataTable-1_previous">
										<select class="form-control" id="searchType" name="schType">
											<option value="loginId" 	${schType=="loginId" ? "selected":""}>아이디</option>
											<option value="name" 		${schType=="name" ? "selected":""}>이름</option>
											<option value="tel" 		${schType=="tel" ? "selected":""}>전화번호</option>
											<option value="birth"		${schType=="birth" ? "selected":""}>생년월일</option>
											<option value="email" 		${schType=="email" ? "selected":""}>이메일</option>
										</select>
									</li>
									<li class="paginate_button page-item active mr-2">
										<input type="text" class="form-control " id="keyword" name="kwd" value="${kwd}" placeholder="Search">
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
