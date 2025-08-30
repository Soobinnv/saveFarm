<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/login.css" type="text/css">
<style>
    body {
        background-color: #fff;
    }
    main {
        min-height: calc(100vh - 160px); /* 헤더, 푸터 높이를 제외한 최소 높이 */
    }
    .form-control-lg {
        padding: 0.8rem 1rem;
        font-size: 1rem;
    }

    /* 로그인 버튼 */
    .btn-login {
        background-color: #039a63;
        color: #fff;
        border: 1px solid #5f0080;
    }
    .btn-login:hover {
        background-color: #03c27c;
        color: #fff;
    }

    /* 회원가입 버튼 */
    .btn-signup {
        background-color: #fff;
        color: #039a63;
        border: 1px solid #039a63;
    }
    .btn-signup:hover {
        color: #212121;
        border: 1px solid #039a63;
    }

    /* 네이버 버튼 */
    .btn-naver {
        background-color: #03c75a;
        color: #fff;
        border-color: #03c75a;
    }
    .btn-naver:hover {
        background-color: #02b350;
        color: #fff;
    }
	.btn-naver > svg {
		margin-bottom: 2px;
		margin-right: 5px;
	}


    /* 카카오 버튼 */
    .btn-kakao {
        background-color: #fee500;
        color: #000;
        border-color: #fee500;
    }
    .btn-kakao:hover {
        background-color: #f2da00;
        color: #000;
    }
    .btn-kakao > i {
		font-size: 18px;
		vertical-align: text-top;
		margin-right: 5px;
    }
    
    .loginMessage {
        min-height: 1.5em; /* 메시지 표시를 위한 최소 공간 확보 */
    }
	
	form {
		padding-top: 20px;
		padding-bottom: 0px;
	}
	
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
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main class="d-flex align-items-center py-5 mt-5">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-5 mt-5">
				
				<h2 class="text-center fw-bold mb-4">로그인</h2>

				<form name="loginForm" action="" method="post">
					<div class="mb-3">
						<%-- 스크립트와 연동을 위해 name을 "loginId"로 수정 --%>
						<input type="text" name="loginId" class="form-control form-control-lg" placeholder="아이디를 입력해주세요">
					</div>
					<div class="mb-3">
						<%-- 스크립트와 연동을 위해 name을 "password"로 수정 --%>
						<input type="password" name="password" class="form-control form-control-lg" autocomplete="off" placeholder="비밀번호를 입력해주세요">
					</div>
                    <div class="d-flex justify-content-between my-3">
						<div>
						<input class="form-check-input" type="checkbox" id="rememberMe">
						                        <label class="form-check-label" for="rememberMe">
						                            아이디 저장
						                        </label>
												</div>
						<div>
						<a href="#" class="text-decoration-none text-muted small">아이디 찾기</a>
						<span class="text-muted mx-2">|</span>
						<a href="#" class="text-decoration-none text-muted small">비밀번호 찾기</a>
												</div>
					</div>
                    <%-- 아이디 저장 체크박스 추가 --%>
                    <div class="form-check text-start my-3">
                        
                    </div>

                    <div class="d-grid gap-2 my-4 mb-3">
						<button type="button" class="btn btn-lg btn-login" onclick="sendLogin();">로그인</button>
						<a href="${pageContext.request.contextPath}/member/account" class="btn btn-lg btn-signup mb-4">회원가입</a>
					</div>
	                <div class="text-center my-4">
						<span class="text-muted">간편 로그인</span>
					</div>
					<div class="d-grid gap-2">
						<button type="button" class="btn btn-lg btn-naver mt-3">
							<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-naver-logo" viewBox="0 0 16 16">
								<path d="M4.253 5.034h2.29l2.106 3.454V5.034h2.34v6.57H8.694L6.588 8.132v3.472H4.253z"/>
							</svg>
							네이버로 계속하기
						</button>
						<button type="button" class="btn btn-lg btn-kakao">
							<i class="bi bi-chat-fill"></i> 카카오로 계속하기
						</button>
					</div>
				</form>
				
				<div class="d-grid text-center">
                    <p class="loginMessage text-danger">${message}</p>
				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 페이지 로드 시 저장된 아이디가 있으면 불러오는 기능 추가
window.addEventListener('DOMContentLoaded', () => {
	const savedId = localStorage.getItem("savedLoginId");
	
	if (savedId) {
		document.loginForm.loginId.value = savedId;
		document.getElementById("rememberMe").checked = true;
	}
});

function sendLogin() {
    const f = document.loginForm;
    const saveId = document.getElementById("rememberMe").checked;
    
    if( !f.loginId.value.trim() ) {
		alert('아이디를 입력하세요.');
        f.loginId.focus();
        return;
    }

    if( !f.password.value.trim() ) {
		alert('패스워드를 입력하세요.');
        f.password.focus();
        return;
    }

	if (saveId) {
		// 체크 시 Local Storage에 아이디 저장
		localStorage.setItem("savedLoginId", f.loginId.value.trim());
	} else {
		// 체크 해제 시 Local Storage에서 아이디 삭제
		localStorage.removeItem("savedLoginId");
	}	    
    
    f.action = '${pageContext.request.contextPath}/member/login';
    f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>