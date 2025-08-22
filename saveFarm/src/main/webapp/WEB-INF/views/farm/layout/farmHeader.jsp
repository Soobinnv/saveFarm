<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
  
<header id="header" class="header d-flex align-items-center position-relative">
	<div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
	
		<%-- <a href="<c:url value='/' />" class="logo d-flex align-items-center"> --%>
		<a href="${pageContext.request.contextPath}/farm" class="logo d-flex align-items-center">
		  <!-- Uncomment the line below if you also wish to use an image logo -->
		  <img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/logo.png" alt="AgriCulture">
		  <!-- <h1 class="sitename">AgriCulture</h1>  -->
		</a>
		
		<nav id="navmenu" class="navmenu">
		  <ul>
			  <li><a href="${pageContext.request.contextPath}/farm" class="active">홈</a></li>
			  <li><a href="${pageContext.request.contextPath}/farm/guide">이용 가이드</a></li>
			  <c:if test="${empty sessionScope.farm}">
			  	<li><a href="#">사용 예시</a></li>
			  </c:if>
			  <c:if test="${not empty sessionScope.farm}">
			  	<li><a href="${pageContext.request.contextPath}/farm/register/main">납품관리</a></li>
			    <li class="dropdown">
				    <a href="#"><span>판매 성과 분석</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
				    <ul>
				      <li><a href="#">판매흐름</a></li>
				      <li><a href="#">매출</a></li>
				      <li><a href="#">인기순위</a></li>
				    </ul>
			  </c:if>
			  <li class="dropdown">
			    <a href="#"><span>고객센터</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
			    <ul>
			      <li><a href="#">공지사항</a></li>
			      <li><a href="#">문의</a></li>
			      <li><a href="#">자주묻는 질문</a></li>
			    </ul>
			  </li>
			
			  <!-- 로그인/마이팜 -->
			  <li>
			    <c:choose>
			      <c:when test="${empty sessionScope.farm}">
			        <a href="${pageContext.request.contextPath}/farm/member/login">농장열기</a>
			      </c:when>
			      <c:when test="${not empty sessionScope.farm}">
			      	<li class="dropdown">
						    <a href="#"><span>마이페이지</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
					    <ul>
					      	<li><a href="${pageContext.request.contextPath}/farm/member/update">정보수정</a></li>
					      	<li><a href="${pageContext.request.contextPath}/farm/delivery/list">배송 관리</a></li>
					      	<li><a href="${pageContext.request.contextPath}/farm">농산물 관리</a></li>
					      	<li><a href="${pageContext.request.contextPath}/farm/member/logout"> 로그아웃</a></li>
				    	</ul>
				  	</li>
			      </c:when>
			    </c:choose>
			  </li>
			</ul>
		  <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
	  </nav>
	
	</div>
</header>

