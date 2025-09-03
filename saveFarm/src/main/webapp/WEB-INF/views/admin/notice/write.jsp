<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>스마트팜</title>
<link rel="icon" href="data:;base64,iVB9R0go=">



<style>
  /* 필요한 스타일 추가 */
  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }

  #sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 240px;
    height: 100vh;
    background-color: #343a40;
    transition: transform 0.3s ease-in-out;
    z-index: 1030;
  }

  /* 숨겨졌을 때 */
  .sidebar-collapsed #sidebar {
    transform: translateX(-100%);
  }

  #leftSidebar {
    width: 250px;
    transition: width 0.3s ease;
  }

  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }
  
  /* Quill 에디터의 최소 높이 설정 (선택 사항) */
  #editor-container {
      height: 300px; /* 에디터 내용 영역의 높이 */
  }
</style>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper">
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

    <main role="main" class="main-content">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-9">
                    <h2 class="mb-2 page-title">${mode == 'update' ? (itemId >= 100 ? '공지사항 수정' : '가이드라인 수정') : (itemId >= 100 ? '공지사항 등록' : '가이드라인 등록')}</h2>
                    <div class="row my-4">
                        <div class="col-md-12">
                            <div class="card shadow">
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin/notice/${mode == 'update' ? 'update' : 'write'}/${itemId}" method="post" enctype="multipart/form-data">
                                        <!-- 분류 선택 (itemId에 따라 회원/농가 등) -->
                                        <div class="form-group row mb-3">
                                            <label for="classify" class="col-sm-2 col-form-label">분류</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="classify" name="classify">
                                                	<c:choose>
                                                	<c:when test="${itemId == 100 }">
                                                    <option value="0" ${itemId == 100 ? 'selected' : ''}>회원</option>
                                                    </c:when>
                                                    <c:when test="${itemId == 200 }">
                                                    <option value="1" ${itemId == 200 ? 'selected' : ''}>농가</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                    <option value="3" ${itemId == 300 ? 'selected' : ''}>가입서류 가이드라인</option>
                                                    <option value="4">유통 가이드라인</option>
                                                    <option value="5">상품등록 가이드라인</option>
                                                    </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- 제목 입력 -->
                                        <div class="form-group row mb-3">
                                            <label for="subject" class="col-sm-2 col-form-label">제목</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="subject" name="subject" value="${dto.subject}" required>
                                            </div>
                                        </div>

                                        <!-- 내용 에디터: Quill 에디터를 삽입할 div -->
                                        <div class="form-group row mb-3">
                                            <label for="editor-container" class="col-sm-2 col-form-label">내용</label>
                                            <div class="col-sm-10">
                                                <div id="editor-container">${dto.content}</div>
                                                <input type="hidden" id="content" name="content">
                                            </div>
                                        </div>

                                        <!-- 파일 첨부 -->
                                        <div class="form-group row mb-3">
                                            <label for="selectFile" class="col-sm-2 col-form-label">첨부 파일</label>
                                            <div class="col-sm-10">
                                                <input type="file" class="form-control-file" id="selectFile" name="selectFile" multiple>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${mode=='update' && not empty listFile}"> <%-- 파일이 존재할 때만 표시 --%>
                                            <div class="form-group row mb-3"> <%-- 폼 그룹으로 감싸서 정렬 --%>
                                                <label class="col-sm-2 col-form-label">첨부된 파일</label>
                                                <div class="col-sm-10">
                                                    <p class="form-control-plaintext">
                                                        <c:forEach var="vo" items="${listFile}" varStatus="status">
															<span>
																<label class="delete-file" data-fileNum="${vo.fileNum}"><i class="fe fe-trash"></i></label> 
																${vo.originalFilename}&nbsp;|
															</span>
														</c:forEach>
														&nbsp;
                                                    </p>
                                                </div>
                                            </div>
                                        </c:if>
                                        
                                        <!-- 고정 공지 여부 -->
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-2 col-form-label">고정 공지</label>
	                                            <c:choose>
	                                            	<c:when test="${dto.notice == 1}">
			                                            <div class="col-sm-10">
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="notice" id="noticeRadio1" value="1" checked>
			                                                    <label  for="noticeRadio1">고정</label>
			                                                </div>
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="notice" id="noticeRadio2" value="0">
			                                                    <label  for="noticeRadio2">일반</label>
			                                                </div>
			                                            </div>
		                                            </c:when>
		                                            <c:otherwise>
		                                            	<div class="col-sm-10">
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="notice" id="noticeRadio1" value="1" >
			                                                    <label  for="noticeRadio1">고정</label>
			                                                </div>
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="notice" id="noticeRadio2" value="0" checked>
			                                                    <label  for="noticeRadio2">일반</label>
			                                                </div>
			                                            </div>
		                                            </c:otherwise>
	                                            </c:choose>
                                        </div>

                                        <!-- 표시 여부 -->
                                        <div class="form-group row mb-3">
                                            <label class="col-sm-2 col-form-label">표시 여부</label>
		                                        <c:choose>
		                                            <c:when test="${dto.showNotice == 0}">
			                                            <div class="col-sm-10">
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="showNotice" id="showNoticeRadio1" value="1" >
			                                                    <label for="showNoticeRadio1">표시</label>
			                                                </div>
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="showNotice" id="showNoticeRadio2" value="0" checked>
			                                                    <label for="showNoticeRadio2">숨김</label>
			                                                </div>
			                                            </div>
		                                            </c:when>
		                                            <c:otherwise>
		                                            	<div class="col-sm-10">
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="showNotice" id="showNoticeRadio1" value="1" checked>
			                                                    <label for="showNoticeRadio1">표시</label>
			                                                </div>
			                                                <div class="form-check form-check-inline">
			                                                    <input class="form-check-input" type="radio" name="showNotice" id="showNoticeRadio2" value="0">
			                                                    <label for="showNoticeRadio2">숨김</label>
			                                                </div>
			                                            </div>
		                                            </c:otherwise>
		                                       </c:choose>     
                                        </div>


                                        <!-- 버튼 -->
                                        <div class="form-group row">
                                            <div class="col-sm-10 offset-sm-2">
                                                <button type="submit" class="btn btn-primary">${mode == 'update' ? '수정완료' : '등록완료'}</button>
                                                <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/notice/${itemId < 100 ? 'guideLineslist' : 'noticeList'}/${itemId}';">${mode == 'update' ? '수정취소' : '등록취소' }</button>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${mode == 'update'}">
	                                        <input type="hidden" name="noticeNum" value="${dto.noticeNum}">
	                                        <input type="hidden" name="page" value="${page}">
										</c:if>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
    </footer>

<script type="text/javascript">
$(document).ready(function() {
    // 파일 입력 필드 초기화 (페이지 로드 시)
    // 이것은 사용자가 페이지를 새로고침하거나 뒤로가기로 돌아왔을 때,
    // 이전에 선택된 파일이 남아있지 않도록 보장합니다.
    $('#selectFile').val('');

    var quill = new Quill('#editor-container', {
        theme: 'snow',
        modules: {
            toolbar: { // toolbar 객체를 정의하고 그 안에 handlers를 추가
                container: [
                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                    ['bold', 'italic', 'underline', 'strike'],
                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                    [{ 'script': 'sub'}, { 'script': 'super' }],
                    [{ 'indent': '-1'}, { 'indent': '+1' }],
                    [{ 'direction': 'rtl' }],
                    [{ 'color': [] }, { 'background': [] }],
                    [{ 'font': [] }],
                    [{ 'align': [] }],
                    ['link', 'image', 'video'], // 이미지 아이콘 포함
                    ['clean']
                ],
                handlers: {
                    // Quill의 기본 이미지 핸들러를 오버라이드
                    'image': function() {
                        selectLocalImage(); // 커스텀 이미지 선택 및 업로드 함수 호출
                    }
                }
            }
        }
    });

    // 이미지 업로드를 위한 커스텀 함수
    function selectLocalImage() {
        const input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('accept', 'image/*'); // 이미지 파일만 선택 가능
        input.click(); // 파일 선택 대화 상자 열기

        input.onchange = function () {
            const file = input.files[0];
            if (!file) { // 파일이 선택되지 않았으면 중단
                return;
            }

            // 현재 커서 위치를 저장 (이미지 삽입 후 커서를 제어하기 위함)
            const range = quill.getSelection();

            // FormData를 사용하여 파일 전송
            const formData = new FormData();
            formData.append('uploadFile', file); // 서버에서 받을 파라미터 이름: uploadFile

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/admin/notice/uploadImage', // 서버의 이미지 업로드 엔드포인트
                data: formData,
                processData: false, // FormData를 사용할 때는 필수
                contentType: false, // FormData를 사용할 때는 필수
                success: function(data) {
                    if (data.status === 'success') {
                        // 서버로부터 받은 이미지 URL을 에디터에 삽입
                        quill.insertEmbed(range.index, 'image', data.imageUrl);
                        quill.setSelection(range.index + 1); // 이미지 삽입 후 커서 이동
                    } else {
                        alert('이미지 업로드 실패: ' + data.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert('이미지 업로드 중 오류 발생.');
                    console.error("Error uploading image:", error, xhr.responseText);
                }
            });
        };
    }

    var isSubmitting = false; 

    $('form').on('submit', function(event) {
        console.log("Form submit event triggered. isSubmitting:", isSubmitting);

        if (isSubmitting) {
            event.preventDefault(); // 이미 제출 중이라면 기본 제출 동작 중지
            return;
        }

        isSubmitting = true;
        const submitButton = $(this).find('button[type="submit"]');
        submitButton.prop('disabled', true).text('처리 중...'); 
        
        var htmlContent = quill.root.innerHTML;
        $('#content').val(htmlContent);

    });

    <c:if test="${mode=='update'}">
        $('.delete-file').click(function(){
            if(! confirm('선택한 파일을 삭제 하시겠습니까 ? ')) {
                return false;
            }
            
            let $span = $(this).closest('span');
            let fileNum = $(this).attr('data-fileNum');
            let url = '${pageContext.request.contextPath}/admin/notice/deleteFile';
            
            $.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
            $.post(url, {fileNum:fileNum}, function(data){
                $span.remove();
            }, 'json').fail(function(xhr){
                console.log(xhr.responseText);
            });
        });

        $('.file-name-clickable').click(function(){
            $(this).siblings('.delete-file').trigger('click');
        });
    </c:if>
});
</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>
