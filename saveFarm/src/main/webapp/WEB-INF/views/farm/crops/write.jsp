<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

   <section id="comment-form" class="comment-form section">
	<div class="container">
	    <form id="insertForm" name="insertForm" method="post" action="${pageContext.request.contextPath}/farm/myFarm/list" enctype="application/x-www-form-urlencoded">
	      <h4>${mode=='update'?'재고관리 수정':'재고관리 작성'}</h4>
	      <p>가지고 계신 농산물을 편리하게 보기 위해 기록하는 페이지입니다.* </p>
	      <table class="table write-form">
				<tr>
					<td class="col-md-2 bg-light center align-middle">농산물 종류</td>
					<td colspan="2">
				    	<div class="row g-2">
					        <div class="col-md-4">
					          	<select id="supplySelect" name="varietyNum" class="form-select" onchange="toggleComent(this)">
									<c:if test="${mode=='write'}">
										<option value="">-- 선택하세요 --</option>
									</c:if>
									<option value="0" <c:if test="${mode=='update' && dto.varietyNum == 0}">selected</c:if>>기타</option>
									<c:forEach var="v" items="${varieties}">
										<option value="${v.varietyNum}" <c:if test="${mode=='update' && dto.varietyNum == v.varietyNum}">selected</c:if>>
											${v.varietyName}
										</option>
									</c:forEach>
								</select>
					        </div>
					        <div class="col-md-8">
					          <!-- collapse 적용: 기타일 때만 show -->
					          <div id="otherBox" class="collapse <c:if test='${mode=="update" && dto.varietyNum == 0}'>show</c:if>">
						          <input type="text" id="supplyOther" name="coment" class="form-control"
										maxlength="100" placeholder="종류에 없으면 ‘기타’ 선택 후 입력"
										value="<c:if test='${mode=="update"}'>${dto.coment}</c:if>"
										<c:if test='${mode=="write"}'>disabled</c:if>
										<c:if test='${mode=="update" && dto.varietyNum != 0}'>disabled</c:if> />
					          </div>
					      	</div>
				    	</div>
				    </td>
				</tr>

				<tr>
					<td class="col-md-2 bg-light align-middle">총 납품량</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
				          <input type="text" name="supplyQuantity" class="form-control" maxlength="100" placeholder="총 납품할 농산물의 양을 적어주세요." value="${dto.supplyQuantity}">
				        </div>
				        <div class="col-md-5 align-items-center align-middle">
				         	<h6>무게의 단위는 g* 입니다.</h6>
				        </div>
				      </div>
				    </td>
				</tr>
			
				<tr>
					<td class="col-md-2 bg-light align-middle">판매단위</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
				          <input type="text" name="unitQuantity" class="form-control" maxlength="100" placeholder="납품단위별 양을 입력해주세요." value="${dto.unitQuantity}">
				        </div>
				        <div class="col-md-5 align-items-center">
				         	<h6>단위 무게의 단위는 g* 입니다.</h6>
				        </div>
				      </div>
				    </td>
				</tr>
				
				<tr>
					<td class="col-md-2 bg-light align-middle">단위당 금액</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
				          <input type="text" name="unitPrice" class="form-control" maxlength="100" placeholder="단위별 금액을 입력해주세요." value="${dto.unitPrice}">
				        </div>
				        <div class="col-md-5 align-items-center">
				         	<h6>금액의 단위는 1원* 입니다.</h6>
				        </div>
				      </div>
				    </td>
				</tr>
				
				<tr>
					<td class="col-md-2 bg-light align-middle">수확날짜</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
				        	<input type="date" name="harvestDate" class="form-control" value="${not empty dto.harvestDate ? fn:substring(dto.harvestDate, 0, 10) : ''}">
				        </div>
				      </div>
				    </td>
				</tr>
				
				<tr>
					<td class="col-md-2 bg-light align-middle">긴급구출상품신청</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
				          	<input type="hidden" name="rescuedApply" value="0" />
				        </div>
				      </div>
				    </td>
				</tr>
			</table>
	
			
			<div class="sf-actions">
				<c:if test="${mode=='update' && dto.state == 1}">
					<button type="button" class="sf-btn sf-btn-danger" onclick="deleteOk();">삭제하기</button>
				</c:if>
				
				<button type="button" class="sf-btn btn-primary" onclick="sendOk();">
					${mode=='update'?'수정완료':'신청완료'}
				</button>
				
				<c:if test="${mode=='write'}">
					<button type="button" class="sf-btn sf-btn-outline" onclick="location.href='${pageContext.request.contextPath}/farm/register/main'">
				  		신청취소
					</button>
				</c:if>
				
				<c:if test="${mode=='update'}">
			       	<button type="button" class="btn btn-primary" style="background-color: white; color: black; border: 1px solid #116530;"
       					onclick="location.href='${pageContext.request.contextPath}/farm/register/detail?supplyNum=${dto.supplyNum}&back=${back}'">
 						수정취소
					</button>
					<input type="hidden" name="supplyNum" value="${dto.supplyNum}">
					<input type="hidden" name="farmNum" value="${dto.farmNum}">
					<input type="hidden" name="productNum" value="${dto.productNum}">
					<input type="hidden" name="state" value="${dto.state}">
					<input type="hidden" name="page" value="${page}">
					<input type="hidden" name="page"    value="${empty page ? 1 : page}">
					<input type="hidden" name="schType" value="${empty schType ? 'all' : schType}">
					<input type="hidden" name="kwd"     value="${empty kwd ? '' : kwd}">
					
					<input type="hidden" name="rescuedApply" value="0" />
				</c:if>
			</div>
	    </form>
	</div>
</section><!-- /Comment Form Section -->
