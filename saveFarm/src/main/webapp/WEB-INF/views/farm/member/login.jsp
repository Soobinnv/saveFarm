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
							<input type="text" name="farmerId" class="form-control" placeholder="아이디">
						</div>
						<div class="col-12">
							<label class="mb-1">비밀번호</label>
							<input type="password" name="farmerPwd" class="form-control" autocomplete="off" 
								placeholder="비밀번호">
						</div>
						<div class="col-12">
							<div class="form-check">
							  <input class="form-check-input" type="checkbox" id="rememberMeLogin" name="rememberMe">
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
	  const f = document.loginForm;

	  if (!f.farmerId.value.trim()) { f.farmerId.focus(); return; }
	  if (!f.farmerPwd.value.trim()) { f.farmerPwd.focus(); return; }

	  // 폼 스코프로 안전하게 접근 (ID 중복 영향 없음)
	  const saveId = f.rememberMe.checked;

	  if (saveId) {
	    localStorage.setItem('savedLoginId', f.farmerId.value.trim());
	  } else {
	    localStorage.removeItem('savedLoginId');
	  }

	  f.action = '${pageContext.request.contextPath}/farm/member/login';
	  f.submit();
	}

	// (선택) 페이지 로드 시 저장된 아이디 복원 + 체크 상태 반영
	document.addEventListener('DOMContentLoaded', () => {
	  const f = document.loginForm;
	  const saved = localStorage.getItem('savedLoginId');
	  if (saved) {
	    f.farmerId.value = saved;
	    f.rememberMe.checked = true;
	  }
	});

</script>
</body>
</html>