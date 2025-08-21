<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div class="row">
	<div class="col-md-12 my-4">
		<div class="card shadow">
			<div class="card-body">
			<table class="table table" >
				<tbody>
					<tr>
						<td class="bg-light col-sm-2">농 가</td>
						<td class="col-sm-4">${dto.farmName}</td>
						<td class="bg-light col-sm-2">사업자등록번호</td>
						<td class="col-sm-4">${dto.businessNumber}</td>
					</tr>
					
					<tr>
						<td class="bg-light col-sm-2">대표명</td>
						<td class="col-sm-4">${dto.farmManager}</td>
						<td class="bg-light col-sm-2">대표전화</td>
						<td class="col-sm-4">${dto.farmTel}</td>
					</tr>
					<tr>
						<td class="bg-light col-sm-2">이름</td>
						<td class="col-sm-4">${dto.farmerName}</td>
						<td class="bg-light col-sm-2">전화번호</td>
						<td class="col-sm-4">${dto.farmerTel}</td>
					</tr>
					
					
					<tr>
						<td class="bg-light col-sm-2">회원구분</td>
						<td class="col-sm-4">${empty dto.farmerId ? '' : '농가'}</td>
						<td class="bg-light col-sm-2">로그인 아이디</td>
						<td class="col-sm-4">${dto.farmerId}</td>
					</tr>	
				
					<tr>
						<td class="bg-light col-sm-2">등록일자</td>
						<td class="col-sm-4">${dto.farmRegDate}</td>
						<td class="bg-light col-sm-2">계정상태</td>
						<td class="col-sm-4">
							<c:choose>
                                <c:when test="${dto.status == 0}">신청대기</c:when>
                                <c:when test="${dto.status == 1}">서류체크</c:when>
                                <c:when test="${dto.status == 2}">서류탈락</c:when>
                                <c:when test="${dto.status == 3}">승인</c:when>
                                <c:when test="${dto.status == 4}">숨김</c:when>
                                <c:otherwise>알 수 없음</c:otherwise>
                            </c:choose>
						</td>
					</tr>
					
					<tr>
						<td class="bg-light col-sm-2">계좌번호</td>
						<td colspan="3">
							${dto.farmAccount}
						</td>
					</tr>
					<tr>
						<td class="bg-light col-sm-2">주 소</td>
						<td colspan="3">
							${dto.farmAddress1}&nbsp;${dto.farmAddress2}
						</td>
					</tr>
				</tbody>		
			</table>
			</div>
		</div>
	</div>
</div>			
<table class="table table-borderless">
	<tr> 
		<td class="text-end">
			<div class="d-flex justify-content-end gap-2">
				<button type="button" class="btn mb-2 btn-secondary mr-1" onclick="statusDetailesFarm();">계정상태</button>
				<button type="button" class="btn mb-2 btn-secondary mr-1" onclick="updateFarm();">수정</button>
				<button type="button" class="btn mb-2 btn-secondary mr-1" onclick="deleteFarm('${dto.farmNum}');">삭제</button>
				<button type="button" class="btn mb-2 btn-secondary" onclick="listFarm('${page}');">리스트</button>
			</div>	
		</td>
	</tr>
</table>
      
<div class="page-navigation">
	${dataCount == 0 ? "등록된 자료가 없습니다." : paging}
</div>
 
<div class="modal fade" data-backdrop="static" id="farmUpdateDialogModal" tabindex="-1" aria-labelledby="farmUpdateDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="farmUpdateDialogModalLabel">회원정보수정</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			
				<form name="farmUpdateForm" id="farmUpdateForm" method="post">
					<table class="table write-form mb-1">
						<tr>
							<td width="110" class="bg-light">아이디</td>
							<td><p class="form-control-plaintext">${dto.farmerId}</p></td>
						</tr>
						<tr>
							<td class="bg-light">대표명</td>
							<td>
								<input type="text" name="farmName" class="form-control" value="${dto.farmName}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">이름</td>
							<td>
								<input type="text" name="farmerName" class="form-control" value="${dto.farmerName}" style="width: 95%;">
							</td>
						</tr>
						<tr>
							<td class="bg-light">계좌번호</td>
							<td>
								<input type="text" name="farmAccount" class="form-control" value="${dto.farmAccount}" style="width: 95%;">
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="farmNum" value="${dto.farmNum}">
						<input type="hidden" name="farmerId" value="${dto.farmerId}">
						
						<button type="button" class="btn mb-2 btn-secondary" onclick="updateFarmOk('${page}');">수정완료</button>
					</div>
				</form>
			
			</div>
		</div>
	</div>
</div>

<!-- 상태 대화상자 -->
<div class="modal fade" data-backdrop="static" id="farmStatusDetailesDialogModal" tabindex="-1" aria-labelledby="farmStatusDetailesDialogModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="max-width: 650px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="farmStatusDetailesModalLabel">농가상태정보</h5>
				<button type="button" class="btn fe fe-x" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<h3 class="form-control-plaintext fs-6 fw-semibold pt-1"><i class="bi bi-chevron-double-right"></i> 상태 변경</h3>
				<form name="farmStatusDetailesForm" id="farmStatusDetailesForm" method="post">
					<table class="table table-bordered mb-1">
						<tr>
							<td width="110" class="bg-light align-middle">이름(아이디)</td>
							<td>
								<p class="form-control-plaintext">${dto.farmName}(${dto.farmerId})</p>
							</td>
						</tr>
						<tr>
							<td class="bg-light align-middle">계정상태</td>
							<td>
								<div class="col p-0">
		                            <select class="form-control select1" name="status" id="status">
		                              	<option value="">:: 상태코드 ::</option>
											<c:if test="dto.status &lt; 3">
												<option value="0">신청대기</option>
												<option value="1">서류체크</option>
												<option value="2">서류탈락</option>
											</c:if>		
										<option value="3">승인</option>
										<option value="4">숨김</option>
		                            </select>
		                        </div>
							</td>
						</tr>
					</table>
					<div class="d-flex justify-content-end">
						<input type="hidden" name="farmNum" value="${dto.farmNum}">
						<input type="hidden" name="page" value="${page}">
						<input type="hidden" name="registerId" value="${sessionScope.member.memberId != null ? sessionScope.member.memberId : '1' }">
						
						<button type="button" class="btn mb-2 btn-secondary" onclick="updateStatusOk('${page}');">상태변경</button>
					</div>
				</form>

			</div>
		</div>
	</div>
</div>