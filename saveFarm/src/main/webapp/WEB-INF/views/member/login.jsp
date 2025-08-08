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
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/login.css" type="text/css">
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<main>
        <div>
           <div class="panel shadow1">
                <form class="loginForm">
                    <h1 class="animated fadeInUp animate1" id="title-login">Welcome Back !</h1>
                    <fieldset id="login-fieldset" class="mt-5">
                        <input class="login animated fadeInUp animate2" name="loginId" type="text"  required   placeholder="아이디" value="" >
                        <input class="login animated fadeInUp animate3" name="password" type="password" required placeholder="비밀번호" value="">
                    </fieldset>
					<label class="login animated fadeInUp animate3 mt-4" for="rememberMe">아이디 저장</label>
					<input class="login animated fadeInUp animate3" type="checkbox" id="rememberMe">					
                    <input type="button" onclick="sendLogin();" class="login_form button animated fadeInUp animate4" value="로그인">
                    <p><a id="lost-password-link" href="${pageContext.request.contextPath}/member/pwdFind" class="animated fadeIn animate5">비밀번호를 잊으셨나요 ?</a></p>
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