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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/memberTitle2.webp);">
      <div class="container position-relative">
        <h1>
        	<span class="title">${mode=="update"?"정보수정":"회원가입"}</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li class="current"> ${mode=="update"?"농가와의 연결을 더 정확하게":"농가와 함께하는 새로운 시작"} </li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    
		    <div class="row justify-content-center my-2" data-aos="fade-up" data-aos-delay="200">
				<div class="col-md-10">
					
					<form name="memberForm" method="post" enctype="multipart/form-data">
						<div class="row g-3 pt-4">
							<fieldset class="group my-4" style="padding-bottom: 30px; border-bottom: 2px dotted #6c757d;">
								<legend class="fw-bold">계정 정보</legend>
								<div class="col-md-12 wrap-loginId">
									<label for="login_id" class="form-label font-roboto">아이디</label>
									<div class="row g-3">
										<div class="col-md-6">
											<input class="form-control" type="text" id="login_id" name="login_id" value="${dto.farmerId}"
												${mode=="update" ? "readonly ":""} autofocus>									
										</div>
										<div class="col-md-6">
											<c:if test="${mode=='account'}">
												<button type="button" class="btn-default" onclick="userIdCheck();">아이디중복검사</button>
											</c:if>
										</div>
									</div>
									<c:if test="${mode=='account'}">
										<small class="form-control-plaintext help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</small>
									</c:if>
								</div>
		
								<div class="col-md-12">
									<div class="row g-3">
										<div class="col-md-6">
											<label for="password" class="form-label font-roboto">비밀번호</label>
											<input class="form-control" type="password" id="password" name="password" autocomplete="off" >
											<small class="form-text text-muted" style="font-size: 0.75rem">비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자를 포함 합니다.</small>
										</div>
										<div class="col-md-6">
											<label for="password2" class="form-label font-roboto">비밀번호확인</label>
											<input class="form-control" type="password" id="password2" name="password2" autocomplete="off">
											<small class="form-text text-muted" style="font-size: 0.75rem">비밀번호를 한번 더 입력해주세요.</small>
										</div>
									</div>
								</div>	
								</fieldset>
								
								<fieldset class="my-4" style="padding-bottom: 30px; border-bottom: 2px dotted #6c757d;">
									<legend class="fw-bold">농가 정보</legend>
									<div class="row g-3">
										<div class="col-md-12">
											<label for="businessNumber" class="form-label font-roboto">사업자등록번호</label>
											<div class="row g-3">
												<div class="col-md-6">
													<input class="form-control" type="text" id="businessNumber" name="businessNumber" value="${dto.businessNumber}" placeholder=" -없이 입력해주세요."
														${mode=="update" ? "readonly ":""} autofocus>									
												</div>
												<div class="col-md-6">
													<c:if test="${mode=='account'}">
															<button type="button" class="btn-default" onclick="businessNumberCheck();">사업자등록번호 중복검사</button>
													</c:if>
												</div>
											</div>
										</div>
										
										<div class="col-md-6">
											<label for="farmName" class="form-label font-roboto">농가명</label>
											<input class="form-control" type="text" id="farmName" name="farmName" value="${dto.farmName}" placeholder="최대 30글자 가능합니다. (띄어쓰기도 글자수에 포함됩니다.)" 
												${mode=="update" ? "readonly ":""}>
										</div>
										
										<div class="col-md-6">
											<label for="farmManager" class="form-label font-roboto">총책임자</label>
											<input class="form-control" type="text" id="farmManager" name="name" value="${dto.farmManager}"
												${mode=="update" ? "readonly ":""}>
										</div>
										
										<div class="col-md-6">
											<label for="farmTel" class="form-label font-roboto">대표번호</label>
											<input class="form-control" type="text" id="tel" name="farmTel" value="${dto.farmTel}">
										</div>
										
										<div class="col-md-6">
											<label for="btn-zip" class="form-label font-roboto">우편번호</label>
											<div class="row g-3">
												<div class="col-8">
													<input class="form-control" type="text" name="zip" id="zip" value="${dto.farmZip}" readonly tabindex="-1">
												</div>
												<div class="col-4">
													<button type="button" class="btn-default" id="btn-zip" onclick="daumPostcode();">우편번호검사</button>
												</div>
											</div>
										</div>
										
										<div class="col-md-6">
											<label class="form-label font-roboto">기본주소</label>
											<input class="form-control" type="text" name="addr1" id="addr1" value="${dto.farmAddress1}" readonly tabindex="-1">
										</div>
										<div class="col-md-6">
											<label for="addr2" class="form-label font-roboto">상세주소</label>
											<input class="form-control" type="text" name="addr2" id="addr2" value="${dto.farmAddress2}">
										</div>
										
										<div class="col-md-6">
											<label for="farmRegDate" class="form-label font-roboto">농가등록일</label>
											<input class="form-control" type="date" id="birth" name="farmRegDate" value="${dto.farmRegDate}"
												${mode=="update" ? "readonly ":""}>
										</div>
									</div>
								</fieldset>
								
								<fieldset class="my-4">
									<legend class="fw-bold">개인 정보</legend>
									 <div class="row g-3">
										<div class="col-md-6">
											<label for="farmerName" class="form-label font-roboto">이름</label>
											<input class="form-control" type="text" id="fullName" name="farmerName" value="${dto.farmerName}"
												${mode=="update" ? "readonly ":""}>
										</div>
				
										<div class="col-md-6">
											<label for="farmerTel" class="form-label font-roboto">전화번호</label>
											<input class="form-control" type="text" id="tel" name="farmerTel" value="${dto.farmerTel}">
										</div>
									</div>
								</fieldset>
								
								<c:if test="${mode=='account'}">
									<div class="col-md-12">
										<label for="agree" class="form-label font-roboto">약관 동의</label>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" name="agree" id="agree"
													checked
													onchange="form.sendButton.disabled = !checked">
											<label for="agree" class="form-check-label">
												<a href="#" class="text-primary border-link-right">이용약관</a>에 동의합니다.
											</label>
										</div>
									</div>
								</c:if>
								
								<div class="col-md-12 text-center">
									<button type="button" name="sendButton" class="btn-accent btn-lg" onclick="memberOk();"> ${mode=="update"?"정보수정":"회원가입"} <i class="bi bi-check2"></i></button>
									<button type="button" class="btn-default btn-lg" onclick="location.href='${pageContext.request.contextPath}/farm';"> ${mode=="update"?"수정취소":"가입취소"} <i class="bi bi-x"></i></button>
									<input type="hidden" name="loginIdValid" id="loginIdValid" value="false">
									<c:if test="${mode == 'update'}">
										<input type="hidden" name="profile_photo" value="${dto.profile_photo}">
									</c:if>
								</div>
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

<script src="${pageContext.request.contextPath}/dist/farm/js/supplyForm.js"></script>
</body>
</html>