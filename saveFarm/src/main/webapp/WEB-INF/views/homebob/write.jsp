<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세이브팜</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
<style type="text/css">
main {
    padding-top: 100px; /* 헤더의 높이(예시 100px)에 맞춰 조정 */
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="wrap align-items-center">
			<h1>나의 집밥일기 ${mode=='update'?'수정':'등록'}</h1>
		</div>
	</div>
    
	<!-- Page Content -->    
	<section class="wrap">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<form name="postForm" action="" method="post" enctype="multipart/form-data">
					<div class="row gy-4">
						<div class="col-lg-4">
							<div class="file-upload-session">
								<h3><i class="bi bi-file-image"></i>이미지</h3>
								<p class="text-upload">이미지를 사각형에 Drag &amp; Drop 하거나 사각형을 클릭하세요.</p>
								<div class="image-upload-panel">
									<div class="drag-area">
										<input type="file" name="selectFile" accept="image/*" hidden="" multiple tabindex="-1">
										<div>
											<p class="text-drag-drop">
												<i class="bi bi-file-arrow-up"></i>
												Drag &amp; Drop files here
												<span class="text-body-tertiary">or</span>
												<span class="text-primary">browse from device</span>
											</p>
											<p class="text-drag-drop">
												<span class="text-danger file-size">0.00</span><span class="text-body-tertiary">MB</span>
												<span class="text-body-tertiary">/</span>
												<span>5</span><span class="text-body-tertiary">MB</span>
											</p>										
										</div>
									</div>
									<div class="file-upload-list" data-totalSize="0">
										<!-- 클래스명 -> image-item:새로추가된이미지, image-uploaded:수정에서 등록된이미지 -->
										<!-- 수정일때 등록된 이미지 -->
										<c:forEach var="vo" items="${listFile}">
											<div class="image-uploaded" data-fileNum="${vo.fileNum}" data-fileSize="${vo.fileSize}"
												style="background-image: url(${pageContext.request.contextPath}/uploads/homebob/${vo.imageFilename})"></div>
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
						
						<div class="col-lg-8">
						    <div class="form-pannel p-4 border rounded shadow-sm"> 
						    	<div class="row gy-3">
						            <div class="col-md-12">
						                <label for="subjectInput" class="form-label visually-hidden">제목</label> 
						                <input type="text" id="subjectInput" class="form-control" name="subject" placeholder="제목을 입력하세요." maxlength="100" value="${dto.subject}">
						            </div>
							            <div class="col-md-12"> <label for="nameInput" class="form-label visually-hidden">작성자</label> 
							            <input type="text" id="nameInput" name="name" class="form-control bg-light" readonly tabindex="-1" value="${sessionScope.member.name}">
						            </div>
						            <div class="col-md-12">
						                <label for="contentInput" class="form-label visually-hidden">내용</label> 
						                <textarea id="contentInput" class="form-control" name="content" placeholder="내용을 입력하세요." rows="10">${dto.content}</textarea> 
						            </div>
						        </div>
						    </div>
						
						    <div class="text-center py-4 d-grid gap-2 d-md-block"> 
							    <button type="button" class="btn btn-outline-success" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button> 
							    <button type="reset" class="btn btn-outline-success">다시입력</button> 
							    <button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/homebob/list';">${mode=='update'?'수정취소':'등록취소'}</button> 
						    	<c:if test="${mode=='update'}">
						            <input type="hidden" name="num" value="${dto.num}">
						            <input type="hidden" name="page" value="${page}">
						        </c:if>
						    </div>
						</div>
					</div>
				</form>
			</div>	
		</div>
	</section>
</main>

<script src="${pageContext.request.contextPath}/dist/js/file-upload.js"></script>
<script type="text/javascript">
// 수정인 경우 이미지 파일 삭제
window.addEventListener('DOMContentLoaded', evt => {
    // '.image-uploaded' 클래스를 가진 기존 등록 이미지에만 이벤트 리스너를 추가
    const existingImages = document.querySelectorAll('form .file-upload-list .image-uploaded');

    for (let el of existingImages) {
        el.addEventListener('click', () => {
            const allImages = document.querySelectorAll('form .file-upload-list .image-item, form .file-upload-list .image-uploaded');
            
            // 모든 이미지(기존 + 새로 업로드)의 총 개수가 1개 이하일 때는 삭제 불가
            if (allImages.length <= 1) {
                alert('이미지는 최소 한 장 이상 등록되어야 합니다.');
                return false;
            }
             
            if (!confirm('선택한 파일을 삭제 하시겠습니까?')) {
                return false;
            }
            
            let url = '${pageContext.request.contextPath}/homebob/deleteFile';
            let fileNum = el.dataset.filenum;
            
            // CSRF 토큰 처리를 위한 AJAX 설정 (선택 사항)
            $.ajaxSetup({
                beforeSend: function(e) { e.setRequestHeader('AJAX', true); }
            });
            
            $.post(url, {fileNum: fileNum}, function(data) {
                // 서버에서 삭제 성공 시 해당 이미지 요소를 DOM에서 제거
                el.remove();
            }, 'json').fail(function(xhr) {
                console.log(xhr.responseText);
                alert('파일 삭제 중 오류가 발생했습니다.');
            });
        });
    }
});

function sendOk() {
	const f = document.postForm;
	let str;

	const fileListEL = document.querySelector('form .image-upload-panel .file-upload-list');
	const imageELS = fileListEL.querySelectorAll('.image-item, .image-uploaded');
	if(imageELS.length === 0) {
		alert('이미지 파일을 추가 하세요. ');
		f.selectFile.focus();
		return;
	}
	
	str = f.subject.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.subject.focus();
		return;
	}

	str = f.content.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.content.focus();
		return;
	}
	f.action = '${pageContext.request.contextPath}/homebob/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>