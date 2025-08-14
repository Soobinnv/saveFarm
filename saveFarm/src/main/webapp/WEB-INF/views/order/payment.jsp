<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>saveFarm - 주문 결제</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/payment.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<div class="order-section">
		<div class="section-title"  data-aos="fade-up">
			<h2>주문 / 결제</h2>
		</div>
		
		<div class="payment-container" data-aos="fade-up" data-aos-delay="100">
			<form name="paymentForm" method="post">
				<div class="section">
					<h2>주문 상품</h2>
				    <table>
				        <thead>
				            <tr>
				            	<th width="120">&nbsp;</th>
				                <th>상품정보</th>
				                <th width="65">수량</th>
				                <th width="150">할인금액</th>
				                <th width="150">상품금액</th>
				                <th width="150">총금액</th>
				            </tr>
				        </thead>
				        <tbody>
				        	<!--<c:forEach var="dto" items="${listProduct}" varStatus="status">-->
					            <tr>
					            	<td>
					            		<img class="border rounded md-img" src="${pageContext.request.contextPath}/uploads/product/${dto.thumbnail}">
					            	</td>
					                <td>배지 (사이즈: S / 색상: 검정)</td>
					                <td>2</td>
					                <td>10,000원</td>
					                <td><del>100,000원</del><br><span class="price">90,000원</span></td>
					                <td class="price">180,000원</td>
					            </tr>
							<!--</c:forEach>-->
				        </tbody>
				    </table>
				</div>
				
				<h2>배송지 정보</h2>
				<div class="section">
				    <p><strong>수령인:</strong> 홍길동</p>
				    <p><strong>주소:</strong> 경기 성남시 분당구 판교역로 166 (백현동, 카카오 판교 아지트) 101호</p>
				    <p><strong>연락처:</strong> 010-1111-1111</p>
				    <input type="text" placeholder="요청사항을 입력하세요" style="width:100%; padding:8px; margin-top:10px;">
				</div>
				
				<h2>결제 정보</h2>
				<div class="section">
				    <div class="payment-container">
				        <div class="payment-box">
				            <strong>총 상품 금액</strong>
				            <span class="price">275,000원</span><br>
				            <small>상품 합계</small>
				        </div>
				        <div class="payment-operator">+</div>
				        <div class="payment-box">
				            <strong>배송비</strong>
				            <span>0원</span><br>
				            <small>무료 배송</small>
				        </div>
				        <div class="payment-operator">-</div>
				        <div class="payment-box">
				            <strong>할인 금액</strong>
				            <span>-15,000원</span><br>
				            <small>쿠폰 적용</small>
				        </div>
				        <div class="payment-operator">=</div>
				        <div class="payment-box" style="background-color:#e8f5e9;">
				            <strong>총 결제 금액</strong>
				            <span class="price">260,000원</span><br>
				            <small>적립 예정 3,000P</small>
				        </div>
				    </div>
				</div>		
				
				<div style="text-align: center; margin-top: 20px;">
				    <button class="btn">결제하기</button>
				    <button class="btn cancel">결제취소</button>
				</div>
			</form>
		</div>
	</div>
</main>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
	
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>
