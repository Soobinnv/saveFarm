<div class="modal fade" data-backdrop="static" id="memberUpdateDialogModal" tabindex="-1" aria-labelledby="memberUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memberUpdateDialogModalLabel">회원정보수정</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			
				<form name="memberUpdateForm" id="memberUpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td width="110" class="bg-light">아이디</td>
							<td><p class="form-control-plaintext">${dto.loginId}</p></td>
						</tr>
						<tr>
							<td class="bg-light">이름</td>
							<td>
								<input type="text" name="name" class="form-control" value="${dto.name}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">생년월일</td>
							<td>
								<input type="date" name="birth" class="form-control" value="${dto.birth}" style="width: 95%;">
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="memberId" value="${dto.memberId}">
						<input type="hidden" name="userLevel" value="${dto.userLevel}">
						<input type="hidden" name="loginId" value="${dto.loginId}">
						<input type="hidden" name="enabled" value="${dto.enabled}">
						
						<button type="button" class="btn mb-2 btn-secondary" onclick="updateMemberOk('${page}');">수정완료</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>

<!-- 상태 대화상자 -->
<div class="modal fade" data-backdrop="static" id="memberStatusDetailesDialogModal" tabindex="-1" aria-labelledby="memberStatusDetailesDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 650px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memberStatusDetailesModalLabel">회원상태정보</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h3 class="form-control-plaintext fs-6 fw-semibold pt-1"><i class="bi bi-chevron-double-right"></i> 상태 변경</h3>
				<form name="memberStatusDetailesForm" id="memberStatusDetailesForm" method="post">
					<table class="table table-bordered mb-1">
						<tr>
							<td width="110" class="bg-light align-middle">이름(아이디)</td>
							<td>
								<p class="form-control-plaintext">${dto.name}(${dto.loginId})</p>
							</td>
						</tr>
						<tr>
							<td class="bg-light align-middle">계정상태</td>
							<td>
								<div class="col p-0">
		                            <select class="form-control select1" name="statusCode" id="validationSelect1" onchange="selectStatusChange()">
		                              <option value="">:: 상태코드 ::</option>
											<c:if test="${dto.enabled==0}">
												<option value="0">잠금 해제</option>
											</c:if>
											<option value="2">불법적인 방법으로 로그인</option>
											<option value="3">불건전 게시물 등록</option>
											<option value="4">다른 유저 비방</option>
											<option value="5">타계정 도용</option>
											<option value="6">약관 위반</option>
											<option value="7">1년이상 로그인하지 않음</option>
											<option value="8">기타</option>
		                            </select>
		                        </div>

							</td>
						</tr>
						<tr>
							<td class="bg-light align-middle">메 모</td>
							<td>
								<input type="text" name="memo" id="memo" class="form-control">
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="memberId" value="${dto.memberId}">
						<input type="hidden" name="registerId" value="${sessionScope.member.memberId != null ? sessionScope.member.memberId : '1' }">
						
						<button type="button" class="btn mb-2 btn-secondary" onclick="updateStatusOk('${page}');">상태변경</button>
					</div>
				</form>
			
				<h3 class="form-control-plaintext fs-6 fw-semibold pt-3"><i class="bi bi-chevron-double-right"></i> 상태 리스트</h3>			
				<table class="table board-list">
					<thead class="table-light">
						<tr>
							<th>내용</th>
							<th width="120">담당자</th>
							<th width="180">등록일</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="vo" items="${listStatus}">
							<tr>
								<td class="left">${vo.memo}</td>
								<td>${vo.registerName}(${vo.registerId})</td>
								<td>${vo.regDate}</td>
							</tr>
						</c:forEach>
				  
						<c:if test="${listStatus.size()==0}">
							<tr>
								<td colspan="3" style="border: none;">등록된 정보가 없습니다.</td>
							</tr>  
						</c:if>
					</tbody>
				</table>  

			</div>
		</div>
	</div>
</div>