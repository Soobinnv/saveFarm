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
  <div class="container">
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
	            	<th width="110"><input type="checkbox" class="cart-selectAll" id="selectAll" name="selectAll"></th>
	                <th colspan="2">상품</th>
	                <th width="150">가격</th>
	                <th width="150">수량</th>
	                <th width="150">합계</th>
	                <th width="70">삭제</th>
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
		                    <!-- 
		                    <div>
		                        <strong>${dto.productName}</strong><br>
		                        상품번호: #214323543545352<br>
		                        개수: 1개 (개당 500g)
		                    </div>
		                     -->
		                </td>
		                <td>
		                	<label><fmt:formatNumber value="${dto.unitPrice}"/></label><label>원</label>
		                	<input type="hidden" name="prices" value="${dto.unitPrice}">
		                </td>
		                <td>
		                    <button class="qty-btn">-</button> ${dto.qty} <button class="qty-btn">+</button>
		                </td>
		                <td>
		                	<label><fmt:formatNumber value="${dto.productMoney}"/></label><label>원</label>
		                	<input type="hidden" name="productMoneys" value="${dto.productMoney}">
						</td>
						<td>
							<button type="button" class="cart-delete" onclick="deleteCartItem('${dto.productNum}')"><i class="bi bi-x"></i></button>
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
	        		<div><strong>총합계: ${dto.totalMoney}</strong></div>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/quantityChanger.js"></script>
 

<script type="text/javascript">
document.getElementById("selectAll").addEventListener("change", function () {
    const checkboxes = document.querySelectorAll(".itemCheckbox");
    checkboxes.forEach(cb => cb.checked = this.checked);
});

document.querySelectorAll(".itemCheckbox").forEach(cb => {
    cb.addEventListener("change", function () {
        const allChecked = document.querySelectorAll(".itemCheckbox:checked").length === document.querySelectorAll(".itemCheckbox").length;
        document.getElementById("selectAll").checked = allChecked;
    });
});
</script>

</body>
</html>
