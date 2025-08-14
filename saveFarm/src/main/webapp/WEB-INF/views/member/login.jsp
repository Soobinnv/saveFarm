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
<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<main class="mt-5">
<div class="container">
    <div class="form-box animated fadeInUp">
        <div class="form-title">
            <h2>로그인</h2>
        </div>
        
        <form name="loginForm" method="post">
            <div class="form-group">
                <label for="loginId">아이디</label>
                <input type="text" name="loginId" id="loginId" class="form-control" placeholder="아이디를 입력하세요">
            </div>

            <div class="form-group">
                <label for="password">패스워드</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="패스워드를 입력하세요">
            </div>

            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="rememberMe">
                <label class="form-check-label" for="rememberMe">아이디 저장</label>
            </div>
            
            <button type="button" class="btn btn-primary btn-block" onclick="sendLogin();">로그인</button>
            
            <div class="etc-links">
                <a href="#">아이디/비밀번호 찾기</a> | <a href="#">회원가입</a>
            </div>
        </form>
    </div>
</div>
</main>

<script type="text/javascript">
function sendLogin() {
    const f = document.loginForm;
    const saveId = document.getElementById("rememberMe").checked;
    
    if( ! f.loginId.value.trim() ) {
        f.loginId.focus();
        return;
    }

    if( ! f.password.value.trim() ) {
        f.password.focus();
        return;
    }

	if (saveId) {
		localStorage.setItem("savedLoginId", f.loginId.value.trim());
	} else {
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