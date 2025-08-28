/**
 * myPageMemberInfo.js
 * 회원정보 수정 관련 스크립트
 */

/**
 * 회원정보 수정 폼 HTML 문자열 생성
 * @param {object} data - 서버로부터 받은 회원 정보 데이터
 * @param {object} data.dto - 실제 회원 정보 객체
 * @returns {string} 브라우저에 렌더링될 완성된 HTML 문자열
 */
const renderMemberUpdateFormHtml = function(data) {
    const dto = data.dto;
    if (!dto) {
        return `<p style="text-align:center; color:#aaa; margin-top: 20px;">회원 정보를 불러오는 데 실패했습니다.</p>`;
    }

    // 메일 수신 여부 체크
    const isEmailChecked = (dto.receive_email === 1 || dto.receive_email === '1') ? 'checked' : '';

    let html = `
        <section class="member-update-section">
            <div class="section-title">
                <h3><i class="fa-solid fa-user-pen"></i> 회원정보 수정</h3>
            </div>
            <div class="form-container">
                <form id="memberUpdateForm" name="memberUpdateForm" method="POST">
                    
                    <div class="form-row">
                        <div class="form-group half">
                            <label for="login_id">아이디</label>
                            <input type="text" id="login_id" name="login_id" class="form-control" value="${dto.login_id || ''}" readonly>
                            <small class="help-block">아이디는 변경할 수 없습니다.</small>
                        </div>
                        <div class="form-group half">
                            <label for="name">이름</label>
                            <input type="text" id="name" name="name" class="form-control" value="${dto.name || ''}" readonly>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group half">
                            <label for="password">새 패스워드</label>
                            <input type="password" id="password" name="password" class="form-control" autocomplete="new-password" placeholder="변경할 경우에만 입력하세요">
                            <small class="help-block">5~10자, 영문, 숫자/특수문자 포함</small>
                        </div>
                        <div class="form-group half">
                            <label for="password2">새 패스워드 확인</label>
                            <input type="password" id="password2" name="password2" class="form-control" autocomplete="new-password" placeholder="패스워드를 한번 더 입력하세요">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group half">
                            <label for="birth">생년월일</label>
                            <input type="date" id="birth" name="birth" class="form-control" value="${dto.birth || ''}" readonly>
                        </div>
                        <div class="form-group half">
                            <label for="tel">전화번호</label>
                            <input type="text" id="tel" name="tel" class="form-control" value="${dto.tel || ''}">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group half">
                            <label for="email">이메일</label>
                            <input type="email" id="email" name="email" class="form-control" value="${dto.email || ''}">
                        </div>
                        <div class="form-group half">
                            <label>메일 수신</label>
                            <div class="form-check-group">
                                <input class="form-check-input" type="checkbox" name="receive_email" id="receive_email" value="1" ${isEmailChecked}>
                                <label class="form-check-label" for="receive_email">광고 및 이벤트 정보 수신에 동의합니다.</label>
                            </div>
                        </div>
                    </div>

                    <h5 class="sub-title">주소 정보</h5>
                    <div class="form-row">
                        <div class="form-group zip-group">
                            <label for="zip">우편번호</label>
                            <input type="text" name="zip" id="zip" class="form-control" value="${dto.zip || ''}" readonly>
                            <button type="button" class="btn-default" id="btn-zip">우편번호검색</button>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="addr1">기본주소</label>
                            <input type="text" name="addr1" id="addr1" class="form-control" value="${dto.addr1 || ''}" readonly>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="addr2">상세주소</label>
                            <input type="text" name="addr2" id="addr2" class="form-control" value="${dto.addr2 || ''}">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-primary">정보수정</button>
                        <button type="button" class="btn-secondary" onclick="loadContent('/api/myPage/paymentList', renderMyPageMainHtml);">수정취소</button>
                    </div>
                </form>
            </div>
        </section>
        
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    `;

    return html;
};

// ## 이벤트 핸들러 등록 ##

// 1. 회원정보 수정 폼 제출 이벤트
$('#content').on('submit', '#memberUpdateForm', function(e) {
    e.preventDefault(); // 기본 제출 동작 방지

    const form = this;
    const password = form.password.value;
    const password2 = form.password2.value;
    const tel = form.tel.value;
    const email = form.email.value;

    // --- 유효성 검사 ---
    // 패스워드: 입력된 경우에만 검사
    if (password) {
        if (!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(password)) {
            alert('패스워드는 5~10자이며 하나 이상의 숫자나 특수문자를 포함해야 합니다.');
            form.password.focus();
            return;
        }
        if (password !== password2) {
            alert('패스워드가 일치하지 않습니다.');
            form.password2.focus();
            return;
        }
    }

    // 전화번호
    if (!/^(010)-?\d{4}-?\d{4}$/.test(tel)) {
        alert('전화번호 형식을 확인하세요. (예: 010-1234-5678)');
        form.tel.focus();
        return;
    }
    
    // 이메일
    if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
        alert('이메일 형식을 확인하세요.');
        form.email.focus();
        return;
    }

    if (!confirm('회원 정보를 수정하시겠습니까?')) {
        return;
    }

    // --- AJAX 요청 ---
    const url = contextPath + '/api/myPage/updateMember';
    const params = $(form).serialize(); // 폼 데이터 직렬화

    const fn = function(data) {
        if(data.state === 'true') {
            alert('회원 정보가 성공적으로 수정되었습니다.');
            // 정보 수정 후 마이페이지 메인으로 다시 로드
            loadContent('/api/myPage/paymentList', renderMyPageMainHtml);
        } else {
            alert(data.message || '정보 수정에 실패했습니다.');
        }
    };

    ajaxRequest(url, 'post', params, 'json', fn);
});

// 2. 우편번호 검색 버튼 클릭 이벤트
$('#content').on('click', '#btn-zip', function() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('zip').value = data.zonecode; // 5자리 새우편번호
            document.getElementById('addr1').value = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            document.getElementById('addr2').focus();
        }
    }).open();
});