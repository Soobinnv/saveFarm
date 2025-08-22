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
            <li class="current"> 로그인 > 아이디찾기 </li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-5" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-5">
	                    
                    <form name="idForm" action="" method="post" class="row g-3 mb-2">
						<h3 class="text-center pt-3">아이디 찾기</h3>
						<div class="col-12">
							<p class="form-control-plaintext text-center">
								회원 정보를 입력 하세요.
							</p>
                        </div>
                        	 
                        <div class="col-12">
							<input type="text" name="businessNumber" class="form-control form-control-lg" placeholder="사업자등록번호">
						</div>                   
						<div class="col-12">
							<input type="text" name="farmerName" class="form-control form-control-lg" placeholder="계정주 이름">
						</div>
						<div class="col-12">
							<input type="text" name="farmerTel" class="form-control form-control-lg" placeholder="계정주 전화번호">
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
function isValidTelString(value) {
  const d = String(value || '').replace(/\D/g, '');
  if (d.length < 9 || d.length > 11) return null;

  if (d.startsWith('02')) {
    if (d.length === 9)  return d.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
    if (d.length === 10) return d.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
    return null;
  }
  if (d.startsWith('010')) {
    if (d.length === 11) return d.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
    return null;
  }
  if (d.length === 10) return d.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
  if (d.length === 11) return d.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
  return null;
}

function sendOk() {
  const f = document.idForm;
  let p, str;

  // 1) 사업자등록번호: 공백 제거 → 숫자만 → 3-2-5로 포맷
  str = f.businessNumber.value.trim();
  let str2 = str.replace(/\D/g, '');
  if (str2.length !== 10) {
    alert('사업자등록번호는 10자리 또는 123-45-67890 형식으로 입력해주세요.');
    f.businessNumber.focus();
    return;
  }
  f.businessNumber.value = str2.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');

  // 2) 이름: 공백 제거 → 한글 2~16자
  str = f.farmerName.value.trim();
  if (! str) {
    alert('(계정)이름을 입력하세요.');
    f.farmerName.focus();
    return;
  }
  p = /^[가-힣]{2,16}$/;
  if (! p.test(str)) {
    alert('(계정)이름은 한글 2~16자로 입력하세요.');
    f.farmerName.focus();
    return;
  }
  f.farmerName.value = str; // 정리된 값 되돌려 세팅

  // 3) 전화번호: 하이픈 유무 무관 → 정규화
  str = isValidTelString(f.farmerTel.value);
  if (! str) {
    alert('(계정)전화번호를 입력하세요. 예) 010-1234-5678, 02-734-1114, 033-734-1114');
    f.farmerTel.focus();
    return;
  }
  f.farmerTel.value = str;

  // 4) 전송
  f.action = '${pageContext.request.contextPath}/farm/member/idFind';
  f.submit();
}
</script>
</body>
</html>