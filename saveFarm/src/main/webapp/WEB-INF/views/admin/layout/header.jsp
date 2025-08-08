<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<div class="header-top container-fluid d-flex align-items-center fixed-top">
	<div class="container-fluid position-relative d-flex align-items-center">
		<a href="<c:url value='/admin' />" class="header-left d-flex align-items-center me-auto">
			<span class="header-title">관리자 페이지</span>
		</a>
		
		<div class="header-center d-flex align-items-center">
			<div class="header-center-item">
				<i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
			</div>
		</div>
		
		<div class="header-right d-flex align-items-center">
			<div class="header-account-links">
				<a href="#" title="알림"><i class="bi bi-bell"></i></a>
				<a href="<c:url value='/' />" title="나가기"><i class="bi bi-box-arrow-right"></i></a>
			</div>
		
			<div class="header-avatar">
				<img src="${pageContext.request.contextPath}/dist/images/avatar.png" class="avatar-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				<ul class="dropdown-menu">
					<li><a href="#" class="dropdown-item">메일</a></li>
					<li><a href="#" class="dropdown-item">일정관리</a></li>
					<li><a href="#" class="dropdown-item">환경설정</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a href="#" class="dropdown-item">정보수정</a></li>
				</ul>
			</div>
		</div>
	</div>
</div>