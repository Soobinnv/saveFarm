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
								<div class="col-md-12 wrap-farmerId mb-3">
									<label for="farmerId" class="form-label font-roboto">아이디</label>
									<div class="row g-3">
										<div class="col-md-6">
											<input class="form-control" type="text" id="farmerId" name="farmerId" value="${dto.farmerId}"
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
											<label for="farmerPwd" class="form-label font-roboto">비밀번호</label>
											<input class="form-control" type="password" id="farmerPwd" name="farmerPwd" autocomplete="off" >
											<c:if test="${mode=='account'}">
												<small class="form-text text-muted" style="font-size: 0.75rem">비밀번호는 5~10자이며 하나 이상의 숫자나 특수문자를 포함 합니다.</small>
											</c:if>											
										</div>
										<div class="col-md-6">
											<label for="farmerPwd2" class="form-label font-roboto">비밀번호확인</label>
											<input class="form-control" type="password" id="farmerPwd2" name="farmerPwd2" autocomplete="off">
											<small class="form-text text-muted" style="font-size: 0.75rem">비밀번호를 한번 더 입력해주세요.</small>
										</div>
									</div>
								</div>	
								</fieldset>
								
								<fieldset class="my-4" style="padding-bottom: 30px; border-bottom: 2px dotted #6c757d;">
									<legend class="fw-bold">농가 정보</legend>
									<div class="row g-3">
										<div class="col-md-12 wrap-businessNumber">
											<label for="businessNumber" class="form-label font-roboto">사업자등록번호</label>
											<div class="row g-3">
												<div class="col-md-6">
													<input class="form-control" type="text" id="businessNumber" name="businessNumber" value="${dto.businessNumber}" placeholder=" -없이 입력해주세요."
														${mode=="update" ? "readonly ":""} autofocus>	
													<small class="form-control-plaintext help-block"></small>								
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
											<input class="form-control" type="text" id="farmName" name="farmName" value="${dto.farmName}"
										       placeholder="최대 30글자 가능합니다. (띄어쓰기도 글자수에 포함됩니다.)"
										       ${mode eq 'update' ? ( (not empty sessionScope.member and sessionScope.member.userLevel >= 99) ? '' : 'readonly' ) : ''}>
										</div>
										
										<div class="col-md-6">
											<label for="farmManager" class="form-label font-roboto">총책임자</label>
											<input class="form-control" type="text" id="farmManager" name="farmManager" value="${dto.farmManager}"
												${mode=="update" ? "readonly ":""}>
										</div>
										
										<div class="col-md-6">
											<label for="farmTel" class="form-label font-roboto">대표번호</label>
											<input class="form-control" type="text" id="farmTel" name="farmTel" value="${dto.farmTel}">
										</div>
										
										<div class="col-md-6">
											<label for="btn-zip" class="form-label font-roboto">우편번호</label>
											<div class="row g-3">
												<div class="col-8">
													<input class="form-control" type="text" name="farmZip" id="farmZip" value="${dto.farmZip}" readonly tabindex="-1">
												</div>
												<div class="col-4">
													<button type="button" class="btn-default" id="btn-zip" onclick="daumPostcode();">우편번호검사</button>
												</div>
											</div>
										</div>
										
										<div class="col-md-6">
											<label for="farmAddress1" class="form-label font-roboto">기본주소</label>
											<input class="form-control" type="text" name="farmAddress1" id="farmAddress1" value="${dto.farmAddress1}" readonly tabindex="-1">
										</div>
										<div class="col-md-6">
											<label for="farmAddress2" class="form-label font-roboto">상세주소</label>
											<input class="form-control" type="text" name="farmAddress2" id="farmAddress2" value="${dto.farmAddress2}">
										</div>
										
										<div class="col-md-12">
											<label for="farmAccount" class="form-label font-roboto">계좌번호</label>
											<input class="form-control" type="text" id="farmAccount" name="farmAccount" value="${dto.farmAccount}">										
										</div>
										<!--
										<div class="col-md-6">
											<label for="farmRegDate" class="form-label font-roboto">농가등록일</label>
											<input class="form-control" type="date" id="farmRegDate" name="farmRegDate" value="${dto.farmRegDate}"
												${mode=="update" ? "readonly ":""}>
										</div>
										  -->
									</div>
								</fieldset>
								
								<fieldset class="my-4">
									<legend class="fw-bold">개인 정보</legend>
									 <div class="row g-3">
										<div class="col-md-6">
											<label for="farmerName" class="form-label font-roboto">이름</label>
											<input class="form-control" type="text" id="farmerName" name="farmerName" value="${dto.farmerName}"
												${mode=="update" ? "readonly ":""}>
										</div>
				
										<div class="col-md-6">
											<label for="farmerTel" class="form-label font-roboto">전화번호</label>
											<input class="form-control" type="text" id="farmerTel" name="farmerTel" value="${dto.farmerTel}">
										</div>
									</div>
								</fieldset>
								
								<c:if test="${mode=='account'}">
									<div class="col-md-12">
										<label for="agree" class="form-label font-roboto">약관 동의</label>
										<div class="form-check">
											<input class="form-check-input" type="checkbox" name="agree" id="agree"
       											onchange="this.form.sendButton.disabled = !this.checked">
											<label for="agree" class="form-check-label">
												<a href="#" class="text-primary border-link-right">이용약관</a>에 동의합니다.
											</label>
										</div>
									</div>
								</c:if>
								
								<div class="col-md-12 text-center">
									<button type="button" name="sendButton" class="btn-accent btn-lg" onclick="memberOk();"> ${mode=="update"?"정보수정":"회원가입"} <i class="bi bi-check2"></i></button>
									<button type="button" class="btn-default btn-lg" onclick="location.href='${pageContext.request.contextPath}/farm';"> ${mode=="update"?"수정취소":"가입취소"} <i class="bi bi-x"></i></button>
									<c:if test="${mode eq 'update'}">
									  	<button type="button" class="btn-default btn-lg" onclick="deleteId();" style="background-color: red">
									   		탈퇴하기 <i class="bi bi-person-x-fill"></i>
									  	</button>
									</c:if>
									<input type="hidden" name="farmerIdValid" id="farmerIdValid" value="false">
									<input type="hidden" name="businessNumberValid" id="businessNumberValid" value="false">
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

<script type="text/javascript">
/*
document.addEventListener('DOMContentLoaded', () => {
  const agree = document.getElementById('agree');
  if (agree && document.memberForm?.sendButton) {
    document.memberForm.sendButton.disabled = !agree.checked;
}
*/

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

function memberOk() {
  const f = document.memberForm;
  let str, p;

  // 아이디
  p = /^[a-z][a-z0-9_]{4,9}$/i;
  str = f.farmerId.value;
  if (!p.test(str)) {
    alert('아이디를 다시 입력 하세요.');
    f.farmerId.focus();
    return;
  }

  const mode = '${mode}';
  if (mode === 'account' && f.farmerIdValid.value === 'false') {
    const msg = '아이디 중복 검사가 실행되지 않았습니다.';
    document.querySelector('.wrap-farmerId .help-block')?.insertAdjacentHTML('afterbegin', msg);
    f.farmerId.focus();
    return;
  }

  // 비밀번호
  p = /^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i;
  str = f.farmerPwd.value;
  if (!p.test(str)) {
    alert('비밀번호를 다시 입력 하세요.');
    f.farmerPwd.focus();
    return;
  }
  if (str !== f.farmerPwd2.value) {
    alert('비밀번호가 일치하지 않습니다.');
    f.farmerPwd2.focus();
    return;
  }

  // 사업자번호 (숫자만 10자리)
  let digits = f.businessNumber.value.replace(/\D/g, '');
  if (digits.length !== 10) {
    alert('사업자등록번호는 숫자 10자리여야 합니다. (예: 1234567890 또는 123-45-67890)');
    f.businessNumber.focus();
    return;
  }
  // 화면 표시는 하이픈, 전송은 digits로 할지 정책에 맞춰 조정
  f.businessNumber.value = digits.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');

  if (mode === 'account' && f.businessNumberValid.value === 'false') {
    const msg = '사업자등록번호 중복 검사가 실행되지 않았습니다.';
    document.querySelector('.wrap-businessNumber .help-block')?.insertAdjacentHTML('afterbegin', msg);
    f.businessNumber.focus();
    return;
  }

  // 농장이름
  p = /^(?=.{1,30}$)(?!.* {2,})[가-힣A-Za-z()\-.\/&](?:[가-힣A-Za-z()\-.\/& ]*[가-힣A-Za-z()\-.\/&])?$/;
  str = f.farmName.value;
  if (!p.test(str)) {
    alert('농장이름을 다시 입력하세요.');
    f.farmName.focus();
    return;
  }

  // 총책임자
  p = /^[가-힣]{2,16}$/;
  str = f.farmManager.value;
  if (!p.test(str)) {
    alert('총책임자명을 다시 입력하세요.');
    f.farmManager.focus();
    return;
  }

  // 농장대표번호
  const farmTelFormatted = isValidTelString(f.farmTel.value);
  if (!farmTelFormatted) {
    alert('농장대표번호를 정확히 입력하세요. 예) 010-1234-5678, 02-734-1114, 033-734-1114');
    f.farmTel.focus();
    return;
  }
  f.farmTel.value = farmTelFormatted;

  // 농장 계좌번호 (숫자 10~14)
  let acc = f.farmAccount.value.trim().replace(/[^0-9]/g, '');
  if (!/^[0-9]{10,14}$/.test(acc)) {
    alert('계좌번호는 숫자만 10~14자리로 입력하세요.');
    f.farmAccount.focus();
    return;
  }
  f.farmAccount.value = acc;

  // 계정주 이름
  p = /^[가-힣]{2,16}$/;
  str = f.farmerName.value;
  if (!p.test(str)) {
    alert('계정주 이름은 한글만 2~16자로 입력하세요.');
    f.farmerName.focus();
    return;
  }

  // 계정주 전화번호
  const ownerTelFormatted = isValidTelString(f.farmerTel.value);
  if (!ownerTelFormatted) {
    alert('전화번호를 정확히 입력하세요. 예) 010-1234-5678, 02-734-1114, 033-734-1114');
    f.farmerTel.focus();
    return;
  }
  f.farmerTel.value = ownerTelFormatted;

  //약관 동의(회원가입 모드에서만)
  if (mode === 'account') {
    if (!f.agree || !f.agree.checked) {
      alert('약관에 동의해야 가입할 수 있습니다.');
      document.getElementById('agree')?.focus();
      return;
    }
  }

  
  f.action = '${pageContext.request.contextPath}/farm/member/${mode}';
  f.submit();
}

function userIdCheck() {
  const $farmerId = $('#farmerId');
  const farmerId = $farmerId.val();

  if (!/^[a-z][a-z0-9_]{4,9}$/i.test(farmerId)) {
    const str = ' 아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.';
    $('.wrap-farmerId').find('.help-block').html(str);
    $farmerId.focus();
    return;
  }

  $.ajax({
    type: 'POST',
    url: '${pageContext.request.contextPath}/farm/member/userIdCheck',
    data: { farmerId },
    dataType: 'json',
    success: function (data) {
      if (data.passed === 'true') {
        const str = '<span style="color:blue; font-weight:bold;">' + farmerId + '</span> 아이디는 사용가능합니다.';
        $('.wrap-farmerId').find('.help-block').html(str);
        $('#farmerIdValid').val('true');
      } else {
        const str = '<span style="color:red; font-weight:bold;">' + farmerId + '</span> 아이디는 사용할 수 없습니다.';
        $('.wrap-farmerId').find('.help-block').html(str);
        $('#farmerIdValid').val('false');
        $farmerId.focus();
      }
    }
  });
}

function businessNumberCheck() {
  const $bn = $('#businessNumber');
  const raw = $bn.val();
  const digits = (raw || '').replace(/\D/g, '');

  // 숫자 10자리만 허용
  if (digits.length !== 10) {
    const str = '사업자등록번호는 숫자 10자리로 입력하세요. (예: 1234567890 또는 123-45-67890)';
    $('.wrap-businessNumber').find('.help-block').html(str);
    $bn.focus();
    return;
  }

  $.ajax({
    type: 'POST',
    url: '${pageContext.request.contextPath}/farm/member/userBusinessNumberCheck',
    data: { businessNumber: digits },
    dataType: 'json',
    success: function (data) {
      const shown = digits.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
      if (data.passed === 'true') {
        const str = '<span style="color:blue; font-weight:bold;">' + shown + '</span> 번호는 사용가능합니다.';
        $('.wrap-businessNumber').find('.help-block').html(str);
        $('#businessNumberValid').val('true');
      } else {
        const str = '<span style="color:red; font-weight:bold;">' + shown + '</span> 번호는 사용할 수 없습니다.';
        $('.wrap-businessNumber').find('.help-block').html(str);
        $('#businessNumberValid').val('false');
        $bn.focus();
      }
    }
  });
}

function deleteId() {
	  if (confirm('정말 탈퇴하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
	    location.href = '${pageContext.request.contextPath}/farm/member/pwd?dropout=1';
	  }
	}
</script>


<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
   function daumPostcode() {
       new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var fullAddr = ''; // 최종 주소 변수
               var extraAddr = ''; // 조합형 주소 변수

               // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   fullAddr = data.roadAddress;

               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   fullAddr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
               if(data.userSelectedType === 'R'){
                   //법정동명이 있을 경우 추가한다.
                   if(data.bname !== ''){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있을 경우 추가한다.
                   if(data.buildingName !== ''){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                   fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               document.getElementById('farmZip').value = data.zonecode; //5자리 새우편번호 사용
               document.getElementById('farmAddress1').value = fullAddr;

               // 커서를 상세주소 필드로 이동한다.
               document.getElementById('farmAddress2').focus();
           }
       }).open();
   }
</script>
</body>
</html>