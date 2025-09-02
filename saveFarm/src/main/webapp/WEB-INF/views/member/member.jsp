<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/account.css" type="text/css">
</head>
<style>
	.profile-img-container {
		width: 100px;
		height: 100px;
	}
	.img-avatar {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	.btn-purple {
		background-color: #5f0080;
		color: #fff;
		border: 1px solid #5f0080;
	}
	.btn-purple:hover {
		background-color: #490062;
		color: #fff;
		border-color: #490062;
	}
	
	.card {
		border: none;
	}
	
	.row {
		width: 100%;
	}
	
	form {
		display: block;
		width: 100% !important;		
	}
	
	.form-control::placeholder {
	  color: #6c757d !important;   
	  font-size: 0.9rem; 
	}
</style>

<body class="">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<main class="container my-5">
		<div class="row justify-content-center">
			<div class="mt-5 col-lg-8 col-xl-7">
				
				<div class="text-center mt-5 mb-1">
					<h2 class="fw-bold">
						<c:choose>
							<c:when test="${mode=='update'}">회원 정보 수정</c:when>
							<c:otherwise>회원가입</c:otherwise>
						</c:choose>
					</h2>
				</div>
				<div class="card">
					<div class="card-body p-4 p-md-5 border-end-0">
						<div class="text-end mb-2">
						    <span class="form-text me-2"><span class="text-danger">*</span> 필수입력사항</span>
						</div>
						<form name="memberForm" method="post" enctype="multipart/form-data">

							<%-- 프로필 사진 영역 --%>
							<div class="row pt-4 mb-3 pb-4 border-top">
								<label class="col-sm-3 col-form-label">프로필 사진</label>
								<div class="col-sm-9">
									<div class="d-flex align-items-center gap-3">
										<div class="profile-img-container">
											<img src="${pageContext.request.contextPath}/dist/images/user.png"
												class="img-avatar">
										</div>
										<div>
											<label for="selectFile" class="btn btn-outline-secondary btn-sm me-2">
												<i class="bi bi-upload"></i> 사진 업로드
												<input type="file" name="selectFile" id="selectFile" class="d-none" accept="image/png, image/jpeg">
											</label>
											<button type="button" class="btn btn-outline-danger btn-sm btn-photo-init">
												<i class="bi bi-arrow-counterclockwise"></i> 초기화
											</button>
											<div class="form-text mt-2">JPG, PNG, GIF 파일(최대 800KB)</div>
										</div>
									</div>
								</div>
							</div>

							<%-- 아이디 --%>
							<div class="row mb-3">
								<label for="loginId" class="col-sm-3 col-form-label">아이디<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<div class="input-group">
										<input type="text" class="form-control" id="loginId" name="loginId" value="${dto.loginId}" placeholder="아이디를 입력해주세요" ${mode=="update" ? "readonly":""} autofocus>
										<c:if test="${mode=='account'}">
											<button type="button" class="mt-2 mb-1 btn btn-outline-secondary" onclick="userIdCheck();">중복검사</button>
										</c:if>
									</div>
									<c:if test="${mode=='account'}">
										<div id="loginIdHelp" class="form-text">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</div>
									</c:if>
								</div>
							</div>
							
							<%-- 패스워드 --%>
							<div class="row mb-3">
								<label for="password" class="col-sm-3 col-form-label">비밀번호<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력해주세요" autocomplete="off">
									<div class="form-text mt-2">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자를 포함해야 합니다.</div>
								</div>
							</div>
							<div class="row mb-3">
								<label for="password2" class="col-sm-3 col-form-label">비밀번호 확인<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호를 한번 더 입력해주세요" autocomplete="off">
								</div>
							</div>
							
							<%-- 이름 --%>
							<div class="row mb-3">
								<label for="fullName" class="col-sm-3 col-form-label">이름<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="fullName" name="name" value="${dto.name}" placeholder="이름을 입력해주세요" ${mode=="update" ? "readonly":""}>
								</div>
							</div>

							<%-- 이메일 --%>
							<div class="row mb-3">
								<label for="email" class="col-sm-3 col-form-label">이메일<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="email" class="form-control" id="email" name="email" value="${dto.email}" placeholder="예: saveFarm@save.com">
								</div>
							</div>
							
							<%-- 전화번호 --%>
							<div class="row mb-3">
								<label for="tel" class="col-sm-3 col-form-label">휴대폰<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="tel" name="tel" value="${dto.tel}" placeholder="숫자만 입력해주세요">
								</div>
							</div>

							<%-- 생년월일 --%>
							<div class="row mb-3 ">
								<label for="birth" class="col-sm-3 col-form-label">생년월일<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<input type="date" class="form-control" id="birth" name="birth" value="${dto.birth}" ${mode=="update" ? "readonly":""}>
								</div>
							</div>
							
							<%-- 주소 --%>
							<div class="row mb-3">
								<label class="col-sm-3 col-form-label">주소<span class="text-danger">*</span></label>
								<div class="col-sm-9">
									<div class="input-group mb-2">
										<input type="text" class="form-control" name="zip" id="zip" value="${dto.zip}" placeholder="우편번호" readonly>
										<button type="button" class="mt-2 mb-1 btn btn-outline-secondary" id="btn-zip" onclick="daumPostcode();">주소검색</button>
									</div>
									<input type="text" class="form-control mb-2" name="addr1" id="addr1" value="${dto.addr1}" placeholder="기본주소" readonly>
									<input type="text" class="form-control" name="addr2" id="addr2" value="${dto.addr2}" placeholder="상세주소">
								</div>
							</div>


							<%-- 약관 동의 --%>
							<div class="row pt-4 mb-4 pb-4 border-top">
								<div class="col-sm-9 offset-sm-3">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="receive_email" id="receive_email" value="1" ${empty dto || dto.receive_email == 1 ? "checked":""}>
										<label class="form-check-label" for="receive_email">이벤트 및 프로모션 메일 수신에 동의합니다. (선택)</label>
									</div>
								</div>
							</div>

							<c:if test="${mode=='account'}">
								<div class="row mb-4">
									<div class="col-sm-9 offset-sm-3">
										<div class="form-check">
											<input class="form-check-input" type="checkbox" name="agree" id="agree" checked onchange="form.sendButton.disabled = !checked">
											<label class="form-check-label" for="agree">
												<a href="#">이용약관</a>에 동의합니다. (필수)
											</label>
										</div>
									</div>
								</div>
							</c:if>

							<%-- 하단 버튼 --%>
							<div class="d-grid gap-2 col-6 mx-auto">
								<button type="button" name="sendButton" class="btn btnGreen btn-lg" onclick="memberOk();">
									${mode=="update"?"정보수정":"가입하기"}
								</button>
								<button type="button" class="btn btn-link text-muted" onclick="location.href='${pageContext.request.contextPath}/';">
									${mode=="update"?"수정취소":"가입취소"}
								</button>
							</div>
							
							<input type="hidden" name="loginIdValid" id="loginIdValid" value="false">
							<c:if test="${mode == 'update'}">
								<input type="hidden" name="profile_photo" value="${dto.profile_photo}">
							</c:if>

						</form>
					</div>
				</div>
			</div>
		</div>
	</main>

<script type="text/javascript">
window.addEventListener('DOMContentLoaded', ev => {
	let img = '${dto.profile_photo}';

	const avatarEL = document.querySelector('.img-avatar');
	const inputEL = document.querySelector('form[name=memberForm] input[name=selectFile]');
	const btnEL = document.querySelector('form[name=memberForm] .btn-photo-init');
	
	let avatar;
	if( img ) {
		avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
		avatarEL.src = avatar;
	}
	
	const maxSize = 800 * 1024;
	inputEL.addEventListener('change', ev => {
		let file = ev.target.files[0];
		if(! file) {
			if( img ) {
				avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			} else {
				avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			}
			avatarEL.src = avatar;
			
			return;
		}
		
		if(file.size > maxSize || ! file.type.match('image.*')) {
			inputEL.focus();
			return;
		}
		
		var reader = new FileReader();
		reader.onload = function(e) {
			avatarEL.src = e.target.result;
		}
		reader.readAsDataURL(file);			
	});
	
	btnEL.addEventListener('click', ev => {
		if( img ) {
			if(! confirm('등록된 이미지를 삭제하시겠습니까 ? ')) {
				return false;
			}
			
			avatar = '${pageContext.request.contextPath}/uploads/member/' + img;
			
			// 등록 이미지 삭제
			let url = '${pageContext.request.contextPath}/member/deleteProfile';
			$.post(url, {profile_photo: img}, function(data){
				let state = data.state;

				if(state === 'true') {
					img = '';
					avatar = '${pageContext.request.contextPath}/dist/images/user.png';
					
					$('form input[name=profile_photo]').val('');
				}
				
				inputEL.value = '';
				avatarEL.src = avatar;
			}, 'json');
		} else {
			avatar = '${pageContext.request.contextPath}/dist/images/user.png';
			inputEL.value = '';
			avatarEL.src = avatar;
		}
	});
});

function isValidDateString(dateString) {
	try {
		const date = new Date(dateString);
		const [year, month, day] = dateString.split("-").map(Number);
		
		return date instanceof Date && !isNaN(date) && date.getDate() === day;
	} catch(e) {
		return false;
	}
}

function memberOk() {
	const f = document.memberForm;
	let str, p;
	let mode = '${mode}'; // JSP에서 mode 값을 받아옴

	// --- 아이디 검증 ---
	if (mode === 'account') {
		p = /^[a-z][a-z0-9_]{4,9}$/i;
		str = f.loginId.value;
		if (!p.test(str)) {
			alert('아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.');
			f.loginId.focus();
			return;
		}

		// 아이디 중복 검사 여부 확인
		if (f.loginIdValid.value === 'false') {
			alert('아이디 중복 검사를 실행해 주세요.');
			f.loginId.focus();
			return;
		}
	}

	// --- 비밀번호 검증 ---
	// 수정 모드일 때, 비밀번호를 입력하지 않으면 유효성 검사를 건너뛰도록 처리
	if (mode === 'update' && !f.password.value && !f.password2.value) {
		// 비밀번호, 비밀번호 확인 둘 다 비어있으면 통과
	} else {
		p = /^(?=.*[a-z])(?=.*[0-9!@#$%^&*+=,.-]).{5,10}$/i;
		str = f.password.value;
		if (!p.test(str)) {
			alert('패스워드는 5~10자이며 하나 이상의 영문, 숫자/특수문자를 포함해야 합니다.');
			f.password.focus();
			return;
		}

		if (str !== f.password2.value) {
			alert('패스워드가 일치하지 않습니다.');
			f.password2.focus();
			return;
		}
	}

	// --- 이름 검증 ---
	p = /^[가-힣]{2,5}$/;
	str = f.name.value;
	if (!p.test(str)) {
		alert('이름은 2~5자의 한글만 입력 가능합니다.');
		f.name.focus();
		return;
	}
	
	// --- 이메일 검증 ---
	p = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	str = f.email.value;
	if (!str || !p.test(str)) {
		alert('올바른 이메일 형식을 입력하세요.');
		f.email.focus();
		return;
	}
	
	// --- 휴대폰 번호 검증 ---
	// 하이픈(-)을 포함하거나 숫자만 있는 경우 모두 검증하도록 수정
	p = /^010-?\d{4}-?\d{4}$/;
	str = f.tel.value;
	if (!p.test(str)) {
		alert('휴대폰 번호 형식이 올바르지 않습니다 (예: 01012345678 또는 010-1234-5678).');
		f.tel.focus();
		return;
	}
	
	// --- 생년월일 검증 ---
	// isValidDateString 함수 대신 값이 비어있는지만 확인 (HTML5 type="date"가 형식은 보장)
	str = f.birth.value;
	if (!str) {
		alert('생년월일을 입력하세요.');
		f.birth.focus();
		return;
	}

	// --- 주소 검증 ---
	if (!f.zip.value || !f.addr1.value) {
		alert('주소를 검색하여 입력하세요.');
		f.zip.focus();
		return;
	}
	if (!f.addr2.value) {
		alert('상세주소를 입력하세요.');
		f.addr2.focus();
		return;
	}
	
	// --- 약관 동의 (가입 모드에서만) ---
	if (mode === 'account' && !f.agree.checked) {
		alert('이용약관에 동의하셔야 합니다.');
		f.agree.focus();
		return;
	}

	f.action = '${pageContext.request.contextPath}/member/' + mode;
	f.submit();
}

// 아이디 중복 검사
function userIdCheck() {
	// 1. 입력 값 가져오기 및 형식 검사
	const loginId = $('#loginId').val();
	if (!/^[a-z][a-z0-9_]{4,9}$/i.test(loginId)) {
		const str = '아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.';
		$('#loginId').focus();
		// HTML의 #loginIdHelp 요소에 메시지를 표시하도록 수정
		$('#loginIdHelp').html(str).css('color', 'red');
		return;
	}

	// 2. 서버에 AJAX 요청 보내기
	const url = '${pageContext.request.contextPath}/member/userIdCheck';
	
	$.ajax({
		type: 'POST',
		url: url,
		data: { loginId: loginId }, 
		dataType: 'json',
		success: function(data) {
			const passed = data.passed;
			let message = '';
			
			if (passed === "true") {
				// 사용 가능한 아이디
				message = `<span style="color:blue; font-weight: bold;">\${loginId}</span> 아이디는 사용 가능합니다.`;
				$('#loginIdHelp').html(message);
				$('#loginIdValid').val('true');
			} else {
				// 이미 사용 중인 아이디
				message = `<span style="color:red; font-weight: bold;">\${loginId}</span> 아이디는 사용할 수 없습니다.`;
				$('#loginIdHelp').html(message);
				$('#loginId').val('');
				$('#loginIdValid').val('false');
				$('#loginId').focus();
			}
		},
		error: function(jqXHR) {
			// AJAX 요청 실패 시 콘솔에 에러 기록
			console.log(jqXHR.responseText);
			alert('아이디 중복 검사 중 오류가 발생했습니다.');
		}
	});

}

/*
window.addEventListener('DOMContentLoaded', () => {
	const dateELS = document.querySelectorAll('form input[type=date]');
	dateELS.forEach( inputEL => inputEL.addEventListener('keydown', e => e.preventDefault()) );
});
*/
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
                document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr2').focus();
            }
        }).open();
    }
</script>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

</body>
</html>