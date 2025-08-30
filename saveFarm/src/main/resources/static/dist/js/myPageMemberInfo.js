/**
 * 회원정보 수정 폼 HTML 문자열 생성 (최종 수정 버전)
 * @param {object} data - 서버로부터 받은 회원 정보 데이터
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMemberUpdateFormHtml = function(data) {
    const dto = data.dto;
    if (!dto) {
        return `<p style="text-align:center; color:#aaa; margin-top: 20px;">회원 정보를 불러오는 데 실패했습니다.</p>`;
    }

    const profileImageUrl = dto.profilePhoto 
        ? `${contextPath}/uploads/member/profile/${dto.profilePhoto}` 
        : `${contextPath}/dist/images/user.png`;

    const isEmailChecked = (dto.receiveEmail === 1 || dto.receiveEmail === '1') ? 'checked' : '';

    return `
        <section class="member-update-section">
            <div class="section-title">
                <h3><i class="fa-solid fa-user-pen"></i> 회원정보 수정</h3>
            </div>
            <div class="form-container">
                <form id="memberUpdateForm" name="memberUpdateForm" method="POST" enctype="multipart/form-data">
                    
                    <!-- 프로필 사진 -->
                    <div class="d-flex align-items-center gap-3 pb-3 border-bottom photo-upload-section">
                        <img src="${profileImageUrl}" class="img-avatar profile-small d-block rounded" style="width:80px; height:80px; object-fit:cover;">
                        <div class="ms-3">
                            <label for="selectFile" class="btn-accent me-2 mb-2" tabindex="0" title="사진 업로드">
                                <span>사진 업로드</span>
                                <input type="file" name="selectFile" id="selectFile" hidden accept="image/png, image/jpeg">
                            </label>
                            <button type="button" class="btn-photo-init btn-default mb-2" title="초기화">
                                <span>초기화</span>
                            </button>
                            <div class="small text-muted mt-1">800KB 이하 JPG, PNG 파일</div>
                        </div>
                    </div>
                    <input type="hidden" name="profilePhoto" value="${dto.profilePhoto || ''}">
                    <input type="hidden" name="deletePhoto" id="deletePhotoFlag" value="0">

                    <div class="row g-3 pt-4">
                        <div class="col-md-6">
                            <label for="loginId">아이디</label>
                            <input type="text" id="loginId" name="loginId" class="form-control" value="${dto.loginId || ''}" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="name">이름</label>
                            <input type="text" id="name" name="name" class="form-control" value="${dto.name || ''}" readonly>
                        </div>
                    </div>

                    <!-- 비밀번호 (필수 입력) -->
                    <div class="row g-3 pt-2">
                        <div class="col-md-6">
                            <label for="password">패스워드</label>
                            <input type="password" id="password" name="password" class="form-control" autocomplete="new-password" required>
                        </div>
                        <div class="col-md-6">
                            <label for="password2">패스워드 확인</label>
                            <input type="password" id="password2" name="password2" class="form-control" autocomplete="new-password" required>
                        </div>
                    </div>
                    
                    <div class="row g-3 pt-2">
                        <div class="col-md-6">
                            <label for="tel">전화번호</label>
                            <input type="text" id="tel" name="tel" class="form-control" value="${dto.tel || ''}">
                        </div>
                        <div class="col-md-6">
                            <label for="email">이메일</label>
                            <input type="email" id="email" name="email" class="form-control" value="${dto.email || ''}">
                        </div>
                    </div>

                    <div class="row g-3 pt-2">
                        <div class="col-md-6">
                            <label for="birth">생년월일</label>
                            <input type="date" id="birth" name="birth" class="form-control" value="${dto.birth || ''}" readonly>
                        </div>
                        <div class="col-md-6 d-flex align-items-center">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="receiveEmail" id="receiveEmail" value="1" ${isEmailChecked}>
                                <label class="form-check-label ms-1" for="receiveEmail">메일 수신 동의</label>
                            </div>
                        </div>
                    </div>

                    <h5 class="sub-title mt-4">주소 정보</h5>
                    
					<div class="row g-3 pt-2">
					    <div class="col-md-8">
					        <input type="text" name="zip" id="zip" class="form-control" value="${dto.zip || ''}" readonly>
					    </div>
					    <div class="col-md-2">
					        <button type="button" class="btn btn-default w-100" id="btn-zip">우편번호 검색</button>
					    </div>
					</div>

                    <!-- 기본주소 -->
                    <div class="row g-3 pt-2">
                        <div class="col-md-12">
                            <label for="addr1">기본주소</label>
                            <input type="text" name="addr1" id="addr1" class="form-control" value="${dto.addr1 || ''}" readonly>
                        </div>
                    </div>

                    <!-- 상세주소 -->
                    <div class="row g-3 pt-2">
                        <div class="col-md-12">
                            <label for="addr2">상세주소</label>
                            <input type="text" name="addr2" id="addr2" class="form-control" value="${dto.addr2 || ''}">
                        </div>
                    </div>

                    <div class="form-actions mt-4">
                        <button type="submit" class="btn-primary">정보수정</button>
                        <button type="button" class="btn-secondary" onclick="loadContent('/api/myPage/paymentList', renderMyPageMainHtml);">수정취소</button>
                    </div>
                </form>
            </div>
        </section>
        
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    `;
};


/**
 * 콘텐츠 로드
 */
function loadMemberUpdatePage() {
    $.ajax({
        url: '/api/myPage/memberInfo',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            $('#content').html(renderMemberUpdateFormHtml(data));
        },
        error: function(jqXHR) {
            console.error('Error loading member update page:', jqXHR);
            const msg = jqXHR.responseJSON ? jqXHR.responseJSON.message : "페이지 로딩 실패";
            $('#content').html(`<p style="text-align:center;">${msg}</p>`);
        }
    });
}


/**
 * 이벤트 핸들러 (jQuery 이벤트 위임)
 */

// 프로필 사진 선택 → 미리보기
$('#content').on('change', 'input[name=selectFile]', function(e) {
    const file = e.target.files[0];
    const avatarEL = $('#content .img-avatar');
    const deleteFlagEL = $('#deletePhotoFlag');

    if (!file) return;
    const reader = new FileReader();
    reader.onload = function(event) {
        avatarEL.attr('src', event.target.result);
        deleteFlagEL.val('0');
    };
    reader.readAsDataURL(file);
});

// 초기화 버튼
$('#content').on('click', '.btn-photo-init', function() {
    const avatarEL = $('#content .img-avatar');
    const inputEL = $('#content input[name=selectFile]');
    const deleteFlagEL = $('#deletePhotoFlag');
    inputEL.val('');
    avatarEL.attr('src', `${contextPath}/dist/images/user.png`);
    deleteFlagEL.val('1');
});

// 우편번호 검색
$('#content').on('click', '#btn-zip', function() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('zip').value = data.zonecode;
            document.getElementById('addr1').value = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            document.getElementById('addr2').focus();
        }
    }).open();
});

// 폼 제출
$('#content').on('submit', '#memberUpdateForm', function(e) {
    e.preventDefault();

    let formData = new FormData(this);
	
	if(!confirm('회원 정보를 수정하시겠습니까?')) {
	    return;
	}

    $.ajax({
        url: '/api/myPage/memberInfo',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(res) {
            alert('회원정보가 수정되었습니다.');
            loadContent('/api/myPage/memberInfo', renderMemberUpdateFormHtml);
        },
        error: function(err) {
            alert('회원정보 수정에 실패했습니다.');
        }
    });
});
