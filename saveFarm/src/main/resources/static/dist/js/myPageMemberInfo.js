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



/**
 * 배송지 목록을 화면에 렌더링하는 함수 (디자인 개선 버전)
 * @param {object} data - 서버로부터 받은 배송지 목록 데이터
 * @returns {string} 브라우저에 렌더링될 HTML 문자열
 */
const renderDestinationHtml = function(data) {
    let html = `
        <section class="destination-section">
            <div class="section-title">
                <h3><i class="fa-solid fa-map-location-dot"></i> 배송지 관리</h3>
                <button type="button" class="btn-primary" id="btn-add-destination">새 배송지 추가</button>
            </div>
    `;

    if (!data || !data.list || data.list.length === 0) {
        html += `<div class="no-data-card"><p>등록된 배송지가 없습니다. 새 배송지를 추가해보세요.</p></div>`;
    } else {
        html += `<div class="destination-list">`;
        data.list.forEach(dest => {
            const isDefault = dest.defaultDest === 1 ? '<span class="badge bg-primary">기본 배송지</span>' : '';
            // data-destination 속성에 JSON 문자열을 그대로 담아 수정 시 활용
            const destDataString = JSON.stringify(dest).replace(/'/g, "&apos;");

            html += `
                <div class="destination-card">
                    <div class="card-header">
                        <strong>${dest.addressName}</strong>
                        ${isDefault}
                    </div>
                    <div class="card-body">
                        <p><span class="label">받는 분:</span> ${dest.recipientName}</p>
                        <p><span class="label">연락처:</span> ${dest.tel}</p>
                        <p><span class="label">주소:</span> (${dest.zip}) ${dest.addr1} ${dest.addr2}</p>
                    </div>
                    <div class="card-footer">
                        <button type="button" class="btn-secondary btn-edit-destination" data-destination='${destDataString}'>수정</button>
                        <button type="button" class="btn-danger btn-delete-destination" data-num="${dest.destinationNum}">삭제</button>
                    </div>
                </div>
            `;
        });
        html += `</div>`;
    }
    
    html += `</section>`;
    // 배송지 추가/수정을 위한 모달(팝업) HTML을 추가합니다.
    html += renderDestinationFormModal(); 
    return html;
};

// 배송지 추가/수정 폼(모달) HTML을 생성하는 함수
const renderDestinationFormModal = function() {
    return `
        <div class="modal fade" id="destinationModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="destinationModalLabel">배송지 정보</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="destinationForm" name="destinationForm">
                            <input type="hidden" name="destinationNum" id="destinationNum">
                            
                            <div class="mb-3">
                                <label for="addressName" class="form-label">배송지명</label>
                                <input type="text" class="form-control" id="addressName" name="addressName" placeholder="예: 집, 회사">
                            </div>
                            <div class="mb-3">
                                <label for="recipientName" class="form-label">받는 분</label>
                                <input type="text" class="form-control" id="recipientName" name="recipientName">
                            </div>

							<div class="mb-3">
							  <label for="phone" class="form-label">연락처</label>
							  <div class="d-flex gap-2">
							      <input type="text" class="form-control phone-input" id="tel1" name="tel1" maxlength="3">
							      <span class="input-group-text">-</span>
							      <input type="text" class="form-control phone-input" id="tel2" name="tel2" maxlength="4">
							      <span class="input-group-text">-</span>
							      <input type="text" class="form-control phone-input" id="tel3" name="tel3" maxlength="4">
							  </div>
							</div>

                            <label class="form-label">주소</label>
                            <div class="input-group mb-2">
                                <input type="text" class="form-control" name="zip" id="zip" readonly>
                                <button type="button" class="btn btn-outline-secondary" id="btn-zip-dest">우편번호 찾기</button>
                            </div>
                            <input type="text" class="form-control mb-2" name="addr1" id="addr1" readonly placeholder="기본주소">
                            <input type="text" class="form-control" name="addr2" id="addr2" placeholder="상세주소">
                            
                            <div class="form-check mt-3">
                                <input class="form-check-input" type="checkbox" value="1" id="defaultDest" name="defaultDest">
                                <label class="form-check-label" for="defaultDest">기본 배송지로 설정</label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="btn-save-destination">저장</button>
                    </div>
                </div>
            </div>
        </div>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    `;
};

// 배송지 관리 페이지를 로드하는 함수
function loadDestinations() {
    $.ajax({
        url: `${contextPath}/api/myPage/destinations`,
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            $('#content').html(renderDestinationHtml(data));
        },
        error: function(jqXHR) {
            const msg = jqXHR.responseJSON ? jqXHR.responseJSON.message : "페이지 로딩 실패";
            $('#content').html(`<div class="no-data-card"><p>${msg}</p></div>`);
        }
    });
}

// =================================================================
// 이벤트 핸들러 (jQuery 이벤트 위임 방식)
// =================================================================

// '새 배송지 추가' 버튼 클릭
$('#content').on('click', '#btn-add-destination', function() {
    $('#destinationForm')[0].reset(); // 폼 초기화
    $('#destinationNum').val(''); // 수정용 ID 필드 비우기
    $('#destinationModalLabel').text('새 배송지 추가');
    new bootstrap.Modal('#destinationModal').show();
});

// '수정' 버튼 클릭
$('#content').on('click', '.btn-edit-destination', function() {
    const destData = $(this).data('destination');
    
    // 폼에 데이터 채우기
    $('#destinationForm')[0].reset();
    $('#destinationNum').val(destData.destinationNum);
    $('#addressName').val(destData.addressName);
    $('#recipientName').val(destData.recipientName);
    $('#zip').val(destData.zip);
    $('#addr1').val(destData.addr1);
    $('#addr2').val(destData.addr2);
    $('#defaultDest').prop('checked', destData.defaultDest === 1);
    
    // 전화번호 분리
    const telParts = destData.tel.split('-');
    if(telParts.length === 3) {
        $('#tel1').val(telParts[0]);
        $('#tel2').val(telParts[1]);
        $('#tel3').val(telParts[2]);
    }

    $('#destinationModalLabel').text('배송지 수정');
    new bootstrap.Modal('#destinationModal').show();
});

// '삭제' 버튼 클릭
$('#content').on('click', '.btn-delete-destination', function() {
    const destinationNum = $(this).data('num');
    if(confirm('이 배송지를 삭제하시겠습니까?')) {
        $.ajax({
            url: `${contextPath}/api/myPage/destinations/${destinationNum}`,
            type: 'DELETE',
            success: function(response) {
                alert(response.message || '삭제되었습니다.');
                loadDestinations(); // 목록 새로고침
            },
            error: function(jqXHR) {
                const msg = jqXHR.responseJSON ? jqXHR.responseJSON.message : "삭제에 실패했습니다.";
                alert(msg);
            }
        });
    }
});

// 모달의 '저장' 버튼 클릭
$('#content').on('click', '#btn-save-destination', function() {
    const form = $('#destinationForm')[0];
    const destinationNum = $('#destinationNum').val();
    
    // form.t2l.value -> form.tel2.value 로 오타 수정
    const tel1 = form.tel1.value.trim();
    const tel2 = form.tel2.value.trim(); // <--- 오타 수정된 부분
    const tel3 = form.tel3.value.trim();

    if(!form.addressName.value.trim() || !form.recipientName.value.trim()) {
        alert('배송지명과 받는 분 이름을 입력해주세요.');
        return;
    }
    if (!tel1 || !tel2 || !tel3) {
        alert('연락처를 모두 입력해주세요.');
        return;
    }
    if(!form.zip.value || !form.addr1.value) {
        alert('우편번호 검색을 통해 주소를 입력해주세요.');
        return;
    }

    const tel = `${tel1}-${tel2}-${tel3}`;

    const data = {
        addressName: form.addressName.value.trim(),
        recipientName: form.recipientName.value.trim(),
        tel: tel,
        zip: form.zip.value,
        addr1: form.addr1.value,
        addr2: form.addr2.value.trim(),
        defaultDest: form.defaultDest.checked ? 1 : 0
    };

    const isUpdate = !!destinationNum;
    const url = isUpdate ? `${contextPath}/api/myPage/destinations/${destinationNum}` : `${contextPath}/api/myPage/destinations`;
    const method = isUpdate ? 'PUT' : 'POST';

    $.ajax({
        url: url,
        type: method,
        contentType: 'application/json',
        data: JSON.stringify(data),
        success: function(response) {
            alert(response.message || '저장되었습니다.');
            bootstrap.Modal.getInstance('#destinationModal').hide();
            loadDestinations(); // 목록 새로고침
        },
        error: function(jqXHR) {
            const msg = jqXHR.responseJSON ? jqXHR.responseJSON.message : "저장에 실패했습니다.";
            alert(msg);
        }
    });
});

// 우편번호 찾기 버튼 클릭
$('#content').on('click', '#btn-zip-dest', function() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('zip').value = data.zonecode;
            document.getElementById('addr1').value = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            document.getElementById('addr2').focus();
        }
    }).open();
});
