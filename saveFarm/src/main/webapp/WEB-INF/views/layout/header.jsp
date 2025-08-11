<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- Navbar Start -->
<div class="container-fluid fixed-top px-0 wow fadeIn"
	data-wow-delay="0.1s">
	<div class="top-bar row gx-0 align-items-center d-none d-lg-flex">
		<div class="col-lg-6 px-5 text-start">
			<small><i class="fa fa-map-marker-alt me-2"></i>TEST</small>
		</div>
	</div>

	<nav
		class="navbar navbar-expand-lg navbar-light py-lg-0 px-lg-5 wow fadeIn d-flex justify-content-between headerNavbar"
		data-wow-delay="0.1s">
		<a href="${pageContext.request.contextPath}/" class="fw-bold navbar-brand ms-4 ms-lg-0 logo">
			Foody
		</a>
		<button type="button" class="navbar-toggler custom-toggler me-4"
			data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="navbar-toggler-icon">
				<iconify-icon icon="carbon:collapse-categories" class="fs-4"></iconify-icon>
			</span>
		</button>
		<div class="collapse justify-content-center flex-grow-1 navbar-collapse" id="navbarCollapse">
			<div class="navbar-nav p-4 p-lg-0 d-flex gap-5">
				<a href="about.html" class="nav-item nav-link headerNavText">About Us</a> 
				<a href="${pageContext.request.contextPath}/product/list" class="nav-item nav-link headerNavText">장보기</a>
				<a href="${pageContext.request.contextPath}/package/main" class="nav-item nav-link active headerNavText">패키지</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle headerNavText"
						data-bs-toggle="dropdown headerNavText">Pages</a>
					<div class="dropdown-menu m-0">
						<a href="blog.html" class="dropdown-item">Blog Grid</a> <a
							href="feature.html" class="dropdown-item">Our Features</a> <a
							href="testimonial.html" class="dropdown-item">Testimonial</a> <a
							href="404.html" class="dropdown-item">404 Page</a>
					</div>
				</div>
				<a href="contact.html" class="nav-item nav-link headerNavText">Contact Us</a>
			</div>
		</div>
		<div class="d-none d-lg-flex align-items-end">
			<ul class="d-flex justify-content-end list-unstyled m-0">
				<li>
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<a href="javascript:dialogLogin();" class="mx-3"> <iconify-icon
									icon="healthicons:person" class="fs-4 loginPerson"></iconify-icon>
						</a>						
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/member/logout" class="mx-3"> <iconify-icon
									icon="majesticons:door-exit" class="fs-4 loginPerson"></iconify-icon>
						</a>
						<a href="${pageContext.request.contextPath}/myPage" class="mx-3"> <iconify-icon
									icon="ion:home" class="fs-4 loginPerson"></iconify-icon>
						</a>
					</c:otherwise>
				</c:choose>
				</li>
				<li><a href="index.html" class="mx-3"> 
				<iconify-icon icon="mdi:heart" class="fs-4"></iconify-icon>
				</a></li>
				
				<li class="ms-3"> 
					<a href="${pageContext.request.contextPath}/myShopping/cart">
						<iconify-icon icon="mdi:cart" class="fs-4 position-relative"></iconify-icon>
						<span class="position-absolute translate-middle badge rounded-circle pt-2 cartPlus">
							03 </span>  
					</a>
				</li>
			</ul>

		</div>
	</nav>
</div>


<div class="modal fade" id="loginModal" tabindex="-1"
	data-bs-backdrop="static" data-bs-keyboard="false"
	aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="loginViewerModalLabel">로그인</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="p-3">
					<form name="modalLoginForm" action="" method="post" class="row g-3">
						<div class="mt-0">
							<p class="form-control-plaintext">로그인</p>
						</div>
						<div class="mt-0">
							<input type="text" name="loginId" class="form-control"
								placeholder="아이디">
						</div>
						<div>
							<input type="password" name="password" class="form-control"
								autocomplete="off" placeholder="비밀번호">
						</div>
						<div>
							<div class="form-check">
								<input class="form-check-input rememberMe" type="checkbox"
									id="rememberMeModal"> <label class="form-check-label"
									for="rememberMeModal"> 아이디 저장</label>
							</div>
						</div>
						<div>
							<button type="button" class="btn btnOrange w-100"
								onclick="sendModalLogin();">로그인</button>
						</div>
						<div class="d-flex justify-content-between">
							<button type="button" class="btn-light flex-fill me-2"
								title="Kakao">
								KakaoTalk Login&nbsp;&nbsp;<i class="bi bi-chat-fill kakao-icon"></i>
							</button>
						</div>
						<div>
							<p class="form-control-plaintext text-center">
								<a href="${pageContext.request.contextPath}/member/pwdFind"
									class="text-orange text-decoration-none me-2">비밀번호 찾기
									</a>
									|&nbsp;&nbsp;
									<a href="${pageContext.request.contextPath}/member/account"
								class="text-orange text-decoration-none">회원가입</a>
							</p>
							
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
</div>

<!-- Login Modal -->
<script type="text/javascript">
	function dialogLogin() {
		$('form[name=modalLoginForm] input[name=loginId]').val('');
		$('form[name=modalLoginForm] input[name=password]').val('');

		$('#loginModal').modal('show');

		$('form[name=modalLoginForm] input[name=login_id]').focus();
	}

	function sendModalLogin() {
		const f = document.modalLoginForm;

		if (!f.loginId.value.trim()) {
			f.loginId.focus();
			return;
		}

		if (!f.password.value.trim()) {
			f.password.focus();
			return;
		}

		f.action = '${pageContext.request.contextPath}/member/login';
		f.submit();
	}
</script>
