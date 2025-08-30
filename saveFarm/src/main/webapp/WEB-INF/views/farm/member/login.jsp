<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm</title>


<jsp:include page="/WEB-INF/views/farm/layout/farmHeaderResources.jsp"/>

<style type="text/css">
/* 체크 표시가 안 보일 때 보정 */
#comment-form .form-check-input {
  appearance: auto !important;
  -webkit-appearance: auto !important;
  accent-color: var(--bs-primary); /* 브라우저가 지원하면 색상도 지정 */
}

#comment-form .form-check-input {
  appearance: auto !important;
  -webkit-appearance: auto !important;
  accent-color: #28a745; /* 원하는 색상 코드 (여기서는 부트스트랩 기본 success 그린) */
}

</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>


<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/memberTitle1.webp);">
      <div class="container position-relative">
        <h1>
        	<span class="title">로그인</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">돌아가기</a></li>
            <li class="current">로그인 페이지</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-5" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					<h3 class="text-center pt-3"><i class="bi bi-lock"></i> 회원 로그인</h3>
					<form name="loginForm" action="" method="post" class="row g-3 mb-2">
						<div class="col-12">
							<label class="mb-1">아이디</label>
							<input type="text" name="farmerId" class="form-control" placeholder="아이디" autocomplete="username">
						</div>
						<div class="col-12">
							<label class="mb-1">비밀번호</label>
							<input type="password" name="farmerPwd" class="form-control" placeholder="비밀번호" autocomplete="current-password">
						</div>
						<div class="col-12">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="rememberMeLogin" name="rememberMe" value="Y">
								<label class="form-check-label ms-2" for="rememberMeLogin">아이디 저장</label>
							</div>
						</div>
						<div class="col-12 text-center">
							<button type="button" class="btn btn-primary fw-semibold w-100" onclick="sendLogin();">&nbsp;로그인&nbsp;<i class="bi bi-check2"></i></button>
						</div>
					</form>
		                  
					<div>
						<p class="form-control-plaintext text-center text-danger">${message}</p>
					</div>
		
					<div class="mt-3">
						<p class="text-center">
							<a href="${pageContext.request.contextPath}/farm/member/idFind" class="me-2 border-link-right">아이디 찾기</a>
							<a href="${pageContext.request.contextPath}/farm/member/pwdFind" class="me-2 border-link-right">패스워드 찾기</a>
							<a href="${pageContext.request.contextPath}/farm/member/account" class="border-link-right">회원가입</a>
						</p>
					</div>
			    </div>
		    </div>
		    
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>


<script type="text/javascript">
function sendLogin() {
  const f        = document.forms['loginForm'];
  const idInput  = f.querySelector('input[name="farmerId"]');
  const pwdInput = f.querySelector('input[name="farmerPwd"]');
  const remember = f.querySelector('input[name="rememberMe"]');

  // 값 비어있는지만 확인
  if (!idInput.value.trim())  { idInput.focus(); return; }
  if (!pwdInput.value.trim()) { pwdInput.focus(); return; }

  // 아이디만 저장/삭제
  if (remember?.checked) {
    localStorage.setItem('savedLoginId', idInput.value.trim());
  } else {
    localStorage.removeItem('savedLoginId');
  }

  f.action = '${pageContext.request.contextPath}/farm/member/login';
  f.submit();
}

document.addEventListener('DOMContentLoaded', () => {
  const f        = document.forms['loginForm'];
  const idInput  = f.querySelector('input[name="farmerId"]');
  const pwdInput = f.querySelector('input[name="farmerPwd"]');
  const remember = f.querySelector('input[name="rememberMe"]');

  // 저장된 아이디 복원
  const saved = localStorage.getItem('savedLoginId');
  if (saved) {
    idInput.value = saved;
    if (remember) remember.checked = true;
  }

  <%-- 
	  [브라우저 자동완성 힌트 속성 안내]
	  - autocomplete="username"        : 로그인 아이디/이메일 칸
	  - autocomplete="current-password": 현재 비밀번호 칸
	  - autocomplete="new-password"    : 새 비밀번호 칸
	  - autocomplete="one-time-code"   : OTP/인증코드 칸
	  => 브라우저 자동완성/비번저장 UX용, 서버 세션/DTO와 무관
  --%>
  // 브라우저 자동완성 힌트
  idInput.setAttribute('autocomplete', 'username');
  pwdInput.setAttribute('autocomplete', 'current-password');
});


</script>
</body>
</html>