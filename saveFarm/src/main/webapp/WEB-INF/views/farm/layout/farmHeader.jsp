<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
  
<header id="header" class="header d-flex align-items-center position-relative">
	<div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">
		<%-- <a href="<c:url value='/' />" class="logo d-flex align-items-center"> --%>
		<a href="${pageContext.request.contextPath}/farm" class="logo d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/logo.png" alt="AgriCulture">
		</a>
		
		<nav id="navmenu" class="navmenu">		
			<c:choose>
				<c:when test="${empty sessionScope.farm}">
					<ul>
						<li><a href="${pageContext.request.contextPath}/farm" class="active">홈</a></li>
						<li><a href="${pageContext.request.contextPath}/farm/guide">이용 가이드</a></li>
						<li class="dropdown">
							<a href="${pageContext.request.contextPath}/farm/notice/list"><span>고객센터</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/notice/list">공지사항</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/FAQ/list">자주묻는 질문</a></li>
							</ul>
						</li>
						<li><a href="${pageContext.request.contextPath}/farm/member/login">농장열기</a></li>
					</ul>
				</c:when>
				<c:when test="${not empty sessionScope.farm}">
					<ul>
						<li><a href="${pageContext.request.contextPath}/farm" class="active">홈</a></li>
						<li><a href="${pageContext.request.contextPath}/farm/guide">이용 가이드</a></li>
						<li><a href="${pageContext.request.contextPath}/farm/register/main">납품관리</a></li>
						<li class="dropdown">
							<a href="${pageContext.request.contextPath}/farm/sales/totalList"><span>판매성과 분석</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/sales/totalList">판매순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/incomeList">수입순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/starList">인기순위</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/sales/myFarmList">내 농장관리</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="${pageContext.request.contextPath}/farm/notice/list"><span>고객센터</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/notice/list">공지사항</a></li>
								<c:if test="${not empty sessionScope.farm}">			      
								<li><a href="${pageContext.request.contextPath}/farm/inquiry/list">문의</a></li>
								</c:if>
								<li><a href="${pageContext.request.contextPath}/farm/FAQ/list">자주묻는 질문</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="${pageContext.request.contextPath}/farm/crops/list"><span>마이페이지</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
							<ul>
								<li><a href="${pageContext.request.contextPath}/farm/member/update">정보수정</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/delivery/list">배송 관리</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/crops/list">농산물 관리</a></li>
								<li><a href="${pageContext.request.contextPath}/farm/member/logout"> 로그아웃</a></li>
							</ul>
						</li>
					</ul>
				</c:when>
			</c:choose>		  
			<i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
		</nav>
	</div>
</header>
