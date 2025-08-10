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

<div class="container">
    <h1>내 장바구니</h1>

    <table>
        <thead>
            <tr>
                <th>상품</th>
                <th>가격</th>
                <th>수량</th>
                <th>합계</th>
            </tr>
        </thead>
        <tbody>
            <tr>
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

    <div class="shipping">
        <h3>배송 방법 선택:</h3>
        <label>
            <input type="radio" name="shipping" checked> 매장 픽업 (20분 이내) - 무료
        </label>
        <label>
            <input type="radio" name="shipping"> 집으로 배송 (2~4일 이내) - 9.90 €
            <br><small>주소: 서울특별시 강남구 테헤란로 123</small>
        </label>
    </div>

    <div class="summary">
        <div>소계: 1954.97 €</div>
        <div>배송비: 무료</div>
        <div><strong>총합계: 1954.97 €</strong></div>
        <button class="checkout-btn">결제하기</button>
    </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>
