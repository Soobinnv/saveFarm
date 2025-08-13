<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
  
<header id="header" class="header d-flex align-items-center position-relative">
	<div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
	
		<%-- <a href="<c:url value='/' />" class="logo d-flex align-items-center"> --%>
		<a href="${pageContext.request.contextPath}/farm/home" class="logo d-flex align-items-center">
		  <!-- Uncomment the line below if you also wish to use an image logo -->
		  <img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/logo.png" alt="AgriCulture">
		  <!-- <h1 class="sitename">AgriCulture</h1>  -->
		</a>
		
		<nav id="navmenu" class="navmenu">
		  <ul>
		    <li><a href="${pageContext.request.contextPath}/farm" class="active">홈</a></li>
		    <li><a href="${pageContext.request.contextPath}/farm/guide">이용 가이드</a></li>
		    <li><a href="${pageContext.request.contextPath}/farm/register">상품등록</a></li>
		    <li><a href="#">농장관리</a></li>
		    <li class="dropdown"><a href="#"><span>고객지원</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
		      <ul>
		        <li><a href="#">공지사항</a></li>
		        <li><a href="#">문의</a></li>
		        <li><a href="#">자주묻는 질문</a></li>
		      </ul>
		    </li>
			<li><a href="${pageContext.request.contextPath}/farm/login">농장열기</a></li>
		  </ul>
		  <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
	  </nav>
	
	</div>
</header>

