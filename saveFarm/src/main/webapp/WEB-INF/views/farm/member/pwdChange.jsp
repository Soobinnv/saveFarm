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
        	<span class="title">개인정보 변경</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li class="current"> 정보변경 > 비밀번호 변경 </li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-5" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
					
				<form name="pwdForm" action="" method="post" class="row g-3 mb-2">
					<h3 class="text-center pt-3">비밀번호 변경</h3>
                       <div class="col-12">
						<p class="form-control-plaintext text-center">
                           	변경하실 비밀번호를 입력해주세요
						</p>
                       </div>
                       	                    
                       <div class="col-12">
						<input type="password" name="password" class="form-control form-control-lg" autocomplete="off" placeholder="새비밀번호">
                       </div>
                       <div class="col-12">
						<input type="password" name="password2" class="form-control form-control-lg" autocomplete="off" placeholder="비밀번호 확인">
                       </div>
                       <div class="col-12 text-center">
						<button type="button" class="btn-accent btn-lg w-100" onclick="sendOk();">확인 <i class="bi bi-check2"></i></button>
                       </div>
                   </form>
                   
                <div>
					<p class="form-control-plaintext text-center text-danger">${message}</p>
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
function sendOk() {
	const f = document.pwdForm;
	let str, p;
	
	// 영문+숫자, 영문+특수 - 5~10개
	p =/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
	str = f.password.value;
	if( ! p.test(str) ) { 
		alert('비밀번호를 다시 입력 하세요. ');
		f.password.focus();
		return;
	}
	str2 = f.password2.value; 
	if( ! p.test(str2)) { 
		alert('비밀번호를 다시 입력 하세요. ');
		f.password2.focus();
		return;
	}

	if( str !== str2 ) {
        alert('비밀번호가 일치하지 않습니다. ');
        f.password.focus();
        return;
	}
	
	f.action = '${pageContext.request.contextPath}/farm/member/pwdChange';
    f.submit();
}
</script>
</body>
</html>