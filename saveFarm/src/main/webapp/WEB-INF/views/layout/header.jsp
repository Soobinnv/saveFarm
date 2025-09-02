<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<style>
	/* 체크박스 기본 스타일 */
	.form-check-input {
	    width: 1em !important;
	    height: 1em !important;
	    margin-top: 0.25em !important;
	    vertical-align: top !important;
	    background-color: #fff !important;
	    border: 1px solid #dee2e6 !important;
	    appearance: none !important;  
	    border-radius: 0.25em !important;
	}

	/* 체크박스 선택(:checked) 시 스타일 */
	.form-check-input:checked {
	    background-color: #02b350 !important; 
	    border-color: #02b350 !important;
	}

	.form-check-input:checked[type=checkbox] {
	    /* 체크 표시 SVG 아이콘 */
	    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20'%3e%3cpath fill='none' stroke='%23fff' stroke-linecap='round' stroke-linejoin='round' stroke-width='3' d='m6 10 3 3 6-6'/%3e%3c/svg%3e") !important;
	}

	/* 체크박스와 라벨 사이 간격 */
	.form-check-label {
	    margin-left: 0.5em !important;
	}
</style>
<!-- Navbar Start -->
<div class="container-fluid fixed-top px-0 wow fadeIn mainHeader"
	data-wow-delay="0.1s">
	<nav
		class="navbar navbar-expand-lg navbar-light py-lg-0 px-lg-5 wow fadeIn d-flex justify-content-between headerNavbar"
		data-wow-delay="0.1s">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/" class="fw-bold navbar-brand ms-4 ms-lg-0 logo">
				<img src="${pageContext.request.contextPath}/dist/images/logo.png">
			</a>
		</div>
		<button type="button" class="navbar-toggler custom-toggler me-4"
			data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
			<span class="navbar-toggler-icon">
				<iconify-icon icon="carbon:collapse-categories" class="fs-4"></iconify-icon>
			</span>
		</button>
		<div class="collapse justify-content-center flex-grow-1 navbar-collapse" id="navbarCollapse">
			<div class="navbar-nav p-4 p-lg-0 d-flex gap-5">
				<a href="${pageContext.request.contextPath}/aboutUs" class="nav-item nav-link headerNavText">숨겨진 이야기</a> 
				<a href="${pageContext.request.contextPath}/products" class="nav-item nav-link headerNavText">장보기</a>
				<a href="${pageContext.request.contextPath}/package/main" class="nav-item nav-link active headerNavText">패키지</a>
				<div class="nav-item dropdown">
					<a href="#" class="nav-link dropdown-toggle headerNavText"
						data-bs-toggle="dropdown headerNavText">고객센터</a>
					<div class="dropdown-menu m-0">
						<a href="${pageContext.request.contextPath}/notice/list" class="dropdown-item">공지사항</a> <a
							href="${pageContext.request.contextPath}/inquiry/write" class="dropdown-item">문의하기</a> <a
							href="${pageContext.request.contextPath}/faq/list" class="dropdown-item">FAQ</a>
					</div>
				</div>
				<a href="${pageContext.request.contextPath}/homebob/list" class="nav-item nav-link headerNavText">집밥일기</a>
				<a href="javascript:dialogLogin();" class="nav-item nav-link headerNavText loginHeader">Log In</a>
			</div>
		</div>
		<div class="d-none d-lg-flex align-items-end">
			<ul class="d-flex justify-content-end list-unstyled m-0">
				<c:choose>
					<c:when test="${empty sessionScope.member}">
						<li>
							<a href="javascript:dialogLogin();" class="mx-3"> <iconify-icon
										icon="healthicons:person" class="fs-4 loginPerson" width="35" height="35"></iconify-icon>
							</a>
						</li>	
						<li>
							<a href="${pageContext.request.contextPath}/myPage/paymentList?accessType=wishList" class="mx-3"> 
								<iconify-icon icon="mdi:heart" class="fs-4" width="35" height="35"></iconify-icon>
							</a>
						</li>
						<li class="ms-3"> 
							<a href="${pageContext.request.contextPath}/myShopping/cart">
								<iconify-icon icon="mdi:cart" class="fs-4 position-relative" width="35" height="35"></iconify-icon>
								<c:if test="${not empty sessionScope.member && sessionScope.member.cartSize != 0}">
									<span class="position-absolute translate-middle badge rounded-circle pt-2 cartPlus">
									${sessionScope.member.cartSize}</span>  						
								</c:if>
							</a>
						</li>											
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/member/logout" class="mx-3"> <iconify-icon
										icon="majesticons:door-exit" class="fs-4 loginPerson" width="35" height="35"></iconify-icon>
							</a>
						</li>
						<c:choose>
							<c:when test="${sessionScope.member.userLevel == 99}">
								<li>
									<a href="${pageContext.request.contextPath}/admin" class="mx-3"> <iconify-icon
												icon="uil:setting" class="fs-4 loginPerson" width="35" height="35"></iconify-icon>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li>
									<a href="${pageContext.request.contextPath}/myPage/paymentList?accessType=myPage" class="mx-3"> <iconify-icon
												icon="ion:home" class="fs-4 loginPerson" width="35" height="35"></iconify-icon>
									</a>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/myPage/paymentList?accessType=wishList" class="mx-3"> 
										<iconify-icon icon="mdi:heart" class="fs-4" width="35" height="35"></iconify-icon>
									</a>
								</li>
								<li class="ms-3"> 
									<a href="${pageContext.request.contextPath}/myShopping/cart">
										<iconify-icon width="35" height="35" icon="mdi:cart" class="fs-4 position-relative"></iconify-icon>
										<c:if test="${not empty sessionScope.member && sessionScope.member.cartSize != 0}">
											<span class="position-absolute translate-middle badge rounded-circle pt-2 cartPlus">
											${sessionScope.member.cartSize}</span>  						
										</c:if>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				
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
							<input id="modalLoginIdInput" type="text" name="loginId" class="form-control"
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
							<button type="button" class="btn-light flex-fill me-2" onclick="kakaoLogin();"
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

		const savedId = localStorage.getItem("savedLoginId");
		
		if (savedId) {
			$('#modalLoginIdInput').val(savedId);
			document.getElementById("rememberMeModal").checked = true;
		}
		
		$('#loginModal').modal('show');

		$('form[name=modalLoginForm] input[name=loginId]').focus();
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
	
	function kakaoLogin() {
	    const REST_API_KEY = '';
	    const REDIRECT_URI = 'http://localhost:9090/oauth/kakao/callback';
	    
	    const KAKAO_AUTH_URL = `https://kauth.kakao.com/oauth/authorize?client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}&response_type=code`;

	    window.open(KAKAO_AUTH_URL, "kakaoLogin", "width=500, height=600");
	}
</script>
