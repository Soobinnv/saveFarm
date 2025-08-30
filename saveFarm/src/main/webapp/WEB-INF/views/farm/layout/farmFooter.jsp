<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<footer id="footer" class="footer dark-background">
	<div class="footer-top">
		<div class="container">
			<div class="row gy-4">
				<div class="${empty sessionScope.farm ? 'col-lg-3 col-md-3' : 'col-lg-2 col-md-2'} footer-about">
					<a href="index.html" class="logo d-flex align-items-center">
						<span class="sitename">SaveFarm</span>
					</a>
				    <div class="footer-contact pt-3">
				        <p>월드컵북로 21 풍성빌딩</p>
				        <p>서울특별시, S.L. 04001</p>
				        <p class="mt-3"><strong>대표번호 :</strong> <span>0507-1371-8548</span></p>
				        <p><strong>이메일 :</strong> <span>SaveFarm@gmail.com</span></p>
				    </div>
				</div>
				
				<c:choose>
					<c:when test="${empty sessionScope.farm}">
						<div class="col-lg-3 col-md-3 footer-links">
							<h4>공통</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
						        <li><a href="${pageContext.request.contextPath}/farm/guide">이용가이드</a></li>
							</ul>
						</div>
						
						<div class="col-lg-3 col-md-3 footer-links">
							<h4>고객센터</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/notice/list">공지사항</a></li>		      
								<li><a href="${pageContext.request.contextPath}/farm/FAQ/list">자주묻는 질문</a></li>
							</ul>
						</div>
						
						<div class="col-lg-3 col-md-3 footer-links">
							<h4>농장</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/member/login">농장열기</a></li>
							</ul>
						</div>
					</c:when>
					<c:when test="${not empty sessionScope.farm}">
						<div class="col-lg-2 col-md-2 footer-links">
							<h4>공통</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
						        <li><a href="${pageContext.request.contextPath}/farm/guide">이용가이드</a></li>
						        <li><a href="#">사용 예시</a></li>
					        </ul>
						</div>
						
						<div class="col-lg-2 col-md-2 footer-links">
							<h4>납품관리</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/sales/totalList">납품신청</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/incomeList">신청목록</a></li>
							</ul>
						</div>
						          
						<div class="col-lg-2 col-md-2 footer-links">
							<h4>판매성과 분석</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/sales/totalList">판매순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/incomeList">수입순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/starList">인기순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/myFarmList">내 농장관리</a></li>
							</ul>
						</div>
						
						<div class="col-lg-2 col-md-2 footer-links">
							<h4>고객센터</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/notice/list">공지사항</a></li>		      
								<li><a href="${pageContext.request.contextPath}/farm/inquiry/list">문의</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/FAQ/list">자주묻는 질문</a></li>
							</ul>
						</div>
						
						<div class="col-lg-2 col-md-2 footer-links">
							<h4>마이페이지</h4>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/member/update">정보수정</a></li>
						      	<li><a href="${pageContext.request.contextPath}/farm/delivery/list">배송 관리</a></li>
						      	<li><a href="${pageContext.request.contextPath}/farm/crops/list">농산물 관리</a></li>
						      	<li><a href="${pageContext.request.contextPath}/farm/member/logout"> 로그아웃</a></li>
							</ul>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>
	</div>
	
	<div class="copyright text-center">
		<div class="container d-flex flex-column flex-lg-row justify-content-center justify-content-lg-between align-items-center">
			<div class="d-flex flex-column align-items-center align-items-lg-start">
				<div>
			    	© Copyright <strong><span>SaveFarm</span></strong>. 농가와 소비자가 함께 웃는 유통의 시작
			  	</div>
			  	<div class="credits">
					이 사이트는 <a href="${pageContext.request.contextPath}/farm/home" class="footer_a">농가 전용 서비스</a>입니다. 정직한 농산물이 정당한 가치를 받을 수 있도록 함께합니다.
			  	</div>
			</div>
			
			<div class="social-links order-first order-lg-last mb-3 mb-lg-0">
				<a href="#" target="_blank"><i class="bi bi-twitter-x"></i></a>
				<a href="#" target="_blank"><i class="bi bi-facebook"></i></a>
				<a href="#" target="_blank"><i class="bi bi-instagram"></i></a>
				<a href="#" target="_blank"><i class="bi bi-linkedin"></i></a>
			</div>
			
		</div>
	</div>
</footer>

<!-- Scroll Top -->
<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Preloader -->
<div id="preloader"></div>

  
