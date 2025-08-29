<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<section id="comment-form" class="comment-form section">
	<div class="container">
	    <form name="registerForm" method="post" action="${pageContext.request.contextPath}/farm/register/${mode}" enctype="application/x-www-form-urlencoded">
	     	<h4>등록된 농산물 관리</h4>
	      	<p>재고등록한 농산물 내용을 확인하고, 납품으로 전환할 수 있습니다.* <br/>전환한 농산물 재고는 재고등록 리스트에서 수정하실 수 있습니다.*</p>
	      <table class="table write-form">
				<tr>
					<td class="col-md-3 bg-light center align-middle">농산물 종류</td>
					<td colspan="2">
				    	<div class="row g-2">
					        <div class="col-md-2">
					        	${varietyName}
								<input type="hidden" name="varietyNum"   value="${dto.varietyNum}"/>
								<input type="hidden" name="varietyName"  value="${varietyName}"/>
					        </div>
					        <div class="col-md-10">
					        	<c:if test="${not empty dto.coment}">
									${dto.coment}
								</c:if>
								<input type="hidden" name="coment" value="${dto.coment}"/>
					      	</div>
				    	</div>
				    </td>
				</tr>
				<tr>
					<td class="col-md-2 bg-light align-middle">총 재고량</td>
					<td colspan="2">
				      <div class="row g-2 align-items-center">
				        <div class="col-md-7">
							${dto.supplyQuantity}
							<input type="hidden" name="supplyQuantity" value="${dto.supplyQuantity}">
				        </div>
				        <div class="col-md-5 align-items-center align-middle">
				         	<h6>단위 무게의 단위는 g* 입니다.</h6>
				        </div>
				      </div>
				    </td>
				</tr>
				
				<tr>
					<td class="col-md-2 bg-light align-middle">수확날짜</td>
					<td colspan="2">
				     	<div class="row g-2 align-items-center">
				        	<div class="col-md-7">
								<input type="hidden" name="harvestDate" value="${dto.harvestDate != null ? dto.harvestDate.substring(0,10) : ''}">
					        	<c:choose>
									<c:when test="${not empty dto.harvestDate}">
										${dto.harvestDate.substring(0,10)}
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
				      		</div>
				    	</div>
				    </td>
				</tr>
				
			</table>

			<div class="text-center">
	      		<button type="button" class="sf-btn sf-btn-danger" onclick="deleteOk();">삭제하기</button>		      	
				<button type="button" class="sf-btn btn-primary" style="width:110px;"
				        data-bs-toggle="modal"
				        data-bs-target="#registerModal"
				        data-modal-src="${pageContext.request.contextPath}/farm/crops/update?supplyNum=${dto.supplyNum}">
				  수정하기
				</button>
	      		<button type="button" class="sf-btn btn-primary" style=" background-color: white; color: black; border: 1px solid #116530;" onclick="changeToSupply()">납품으로 전환</button>		      	
			
				<input type="hidden" name="supplyNum" value="${dto.supplyNum}">
				<input type="hidden" name="farmNum" value="${dto.farmNum}">
				<input type="hidden" name="productNum" value="${dto.productNum}">
				<input type="hidden" name="state" value="${dto.state}">
				<input type="hidden" name="page" value="${page}">
				<input type="hidden" name="back" value="${back}">
				
				<input type="hidden" name="unitQuantity" value="0">
				<input type="hidden" name="unitPrice" value="0">
				<input type="hidden" name="rescuedApply" value="0" />
	    	</div>
	    </form>
	</div>
</section><!-- /Comment Form Section -->
    