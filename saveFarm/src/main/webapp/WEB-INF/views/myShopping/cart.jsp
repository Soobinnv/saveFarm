<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>saveFarm - 내 장바구니</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/cart.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="content">
  <div class="container-cart">
	<form name="cartForm" method="post">
	    <h1>내 장바구니</h1>
	    <table>
	        <thead>
	        	<tr>
	        		<th>
	                	<button type="button" class="checkout-btn cart-deleteCheck" onclick="deleteCartSelect()();">선택삭제</button>
	        		</th>
	        	</tr>
	            <tr>
	            	<th width="130"><input type="checkbox" class="cart-selectAll" id="selectAll" name="selectAll"></th>
	                <th colspan="2">상품</th>
	                <th width="180">가격</th>
	                <th width="180">수량</th>
	                <th width="180">합계</th>
	                <th width="70"></th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach var="dto" items="${list}">
		            <tr valign="middle">
		            	<td><input type="checkbox" class="itemCheckbox" name="nums" value="${dto.productNum}"
		            		data-stockQuantity="${dto.stockQuantity}" ${dto.stockQuantity == 0 ? "disabled":""}></td>
		                <td width="55">
		                    <img class="border rounded" width="50" height="50" src="${pageContext.request.contextPath}/uploads/product/${dto.mainImageFilename}">
		                </td>
		                <td>
		                	<p class="product-title p-1 mb-0 left">${dto.productName}</p>
		                    <p class="product-qty p-1 mb-0 left"> ${dto.unit} </p>
		                    <input type="hidden" name="productNums" value="${dto.productNum}">
		                </td>
		                <td>
		                	<c:choose>
			                	<c:when test="${dto.unitPrice != dto.salePrice}"> 
			                		<!-- 할인된 경우 -->
				                	<del><fmt:formatNumber value="${dto.unitPrice}" /></del>원
							        <br>
							        <span style="color:red; font-weight:bold;">
							            <fmt:formatNumber value="${dto.salePrice}" />원
							        </span>
							        <input type="hidden" name="prices" value="${dto.unitPrice}">
							        <input type="hidden" name="salePrices" value="${dto.salePrice}">
						        </c:when>
						        <c:otherwise>
						        	<!-- 할인 안된 경우 -->
						        	<span style="font-weight:bold;"><fmt:formatNumber value="${dto.salePrice}"/>원</span>
			                		<input type="hidden" name="prices" value="${dto.unitPrice}">
			                		<input type="hidden" name="salePrices" value="${dto.salePrice}">
						        </c:otherwise>
					        </c:choose>
		                </td>
		                <td>
		                	<div class="input-group">
			                    <button type="button" class="qty-btn btn-minus"><i class="bi bi-dash" style="font-size: 1.3rem;"></i></button> 
			                    <input type="text" name="buyQtys" value="${dto.qty}" readonly style="width: 50px; text-align: center;">
			                    <button type="button" class="qty-btn btn-plus"><i class="bi bi-plus" style="font-size: 1.3rem;"></i></button>
		                	</div>
		                </td>
		                <td>
		                	<label class="productMoneys"><fmt:formatNumber value="${dto.productMoney}"/></label><label>원</label>
		                	<input type="hidden" data-productMoney="${dto.productMoney}" name="productMoneys" value="${dto.productMoney}">
						</td>
						<td>
							<button type="button" class="cart-delete" onclick="deleteCartItem('${dto.productNum}')"><i class="bi bi-x" style="font-size: 1.5rem;"></i></button>
						</td>		                
		            </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	    
	    <c:choose>
	    	<c:when test="${list.size() == 0}">
	    		<div class="mt-3 p-3 text-center">
	    			장바구니가 비었습니다.
	    		</div>
	    	</c:when>
	    	<c:otherwise>
	    		<div class="summary">
	    			<input type="hidden" name="mode" value="cart">
	        		<div><p class="total-money" name="totalMoney">총합계: ${dto.totalMoney}</p></div>
	        		<button type="button" class="checkout-btn" style="width: 200px;" onclick="sendOk();">선택상품 결제하기</button>
	    		</div>
	    	</c:otherwise>
	    </c:choose>
	  </form>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
	
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/cart.js"></script>
 
</body>
</html>
