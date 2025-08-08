<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<nav class="vertical-nav nav-expand-lg">
	<div class="mobile-menu-closed">
		<i class="menu-closed-icon bi bi-x"></i>
	</div>
	
	<ul class="nav-menu">
		<li>
			<a class="menu-link" href="<c:url value='/admin' />" title="홈">
				<i class="menu-icon bi bi-h-square"></i>
				<span class="menu-label">홈</span>
			</a>
		</li>
		<li>
			<a class="menu-link" href="<c:url value='/admin' />" title="회원관리">
				<i class="menu-icon bi bi-person-square"></i>
				<span class="menu-label">회원관리</span>
			</a>
		</li>
		<li class="has-sub-menu" aria-expanded="false">
			<label class="menu-link" title="강좌관리">
				<i class="menu-icon bi bi-book-half"></i>
				<span class="menu-label">강좌관리</span>
			</label>
			<ul>
				<li><a class="sub-menu-link" href="#">카테고리</a></li>
				<li><a class="sub-menu-link" href="#">강좌</a></li>
				<li><a class="sub-menu-link" href="#">강사</a></li>
			</ul>
		</li>
		<li class="has-sub-menu" aria-expanded="false">
			<label class="menu-link" title="고객센터">
				<i class="menu-icon bi bi-question-square"></i>
				<span class="menu-label">고객센터</span>
			</label>
			<ul>
				<li><a class="sub-menu-link" href="<c:url value='/admin' />">자주하는 질문</a></li>
				<li><a class="sub-menu-link" href="<c:url value='/admin' />">공지사항</a></li>
				<li><a class="sub-menu-link" href="<c:url value='/admin' />">1:1문의</a></li>
				<li><a class="sub-menu-link" href="<c:url value='/admin' />">이벤트</a></li>
				<li><a class="sub-menu-link" href="<c:url value='/admin' />">신고</a></li>
			</ul>
		</li>
		<li>
			<a class="menu-link" href="<c:url value='/admin' />" title="블로그">
				<i class="menu-icon bi bi-chat-square-text"></i>
				<span class="menu-label">블로그</span>
			</a>
		</li>
		<li class="has-sub-menu" aria-expanded="false">
			<label class="menu-link" title="서비스">
				<i class="menu-icon bi bi-wallet"></i>
				<span class="menu-label">서비스</span>
			</label>
			<ul>
				<li><a class="sub-menu-link" href="#">맛집정보관리</a></li>
				<li><a class="sub-menu-link" href="#">레시피관리</a></li>
				<li><a class="sub-menu-link" href="#">관광정보관리</a></li>
			</ul>
		</li>
		<li>
			<a href="#" class="menu-link" title="GroupWare">
				<i class="menu-icon bi bi-c-square"></i>
				<span class="menu-label">GroupWare</span>
			</a>
		</li>
		<li>
			<a href="<c:url value='/' />" class="menu-link" title="Logout">
				<i class="menu-icon bi bi-unlock"></i>
				<span class="menu-label">Logout</span>
			</a>
		</li>
	</ul>
	
	<div class="nav-menu-footer" aria-expanded="true">
		<div class="collapsed-menu">
			<i class="collapse-menu-icon bi bi-arrow-bar-left"></i>
			<span class="menu-label">Collapsed Menu</span>
		</div>
	</div>
</nav>
