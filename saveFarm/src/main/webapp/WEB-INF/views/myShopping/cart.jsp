<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MY PAGE</title>
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


	    <h1>내 장바구니</h1>
	    <table>
	        <thead>
	        	<tr>
	                <th><button class="checkout-btn">선택 삭제</button></th>
	        	</tr>
	            <tr>
	            	<th><input type="checkbox" id="selectAll"></th>
	                <th>상품</th>
	                <th>가격</th>
	                <th>수량</th>
	                <th>합계</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	            	<td><input type="checkbox" class="itemCheckbox"></td>
	                <td>
	                    <img src="${pageContext.request.contextPath}/dist/images/product/product1.png" alt="당근">
	                    <div>
	                        <strong>당근</strong><br>
	                        상품번호: #214323543545352<br>
	                        개수: 1개 (개당 500g)
	                    </div>
	                </td>
	                <td>12,000원</td>
	                <td>
	                    <button class="qty-btn">-</button> 1 <button class="qty-btn">+</button>
	                </td>
	                <td>12,000원</td>
	            </tr>
	            <tr>
	            	<td><input type="checkbox" class="itemCheckbox"></td>
	                <td>
	                    <img src="${pageContext.request.contextPath}/dist/images/product/product2.png" alt="고구마">
	                    <div>
	                        <strong>고구마</strong><br>
	                        상품번호: #21432353246333<br>
	                        개수: 3개 (개당 500g)
	                    </div>
	                </td>
	                <td>8,000원</td>
	                <td>
	                    <button class="qty-btn">-</button> 3 <button class="qty-btn">+</button>
	                </td>
	                <td>24,000원</td>
	            </tr>
	        </tbody>
	    </table>
	
	    <div class="summary">
	        <div><strong>총합계: 1954.97 €</strong></div>
	        <button class="checkout-btn">선택상품 결제하기</button>
	    </div>
 
</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
	
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
 

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
