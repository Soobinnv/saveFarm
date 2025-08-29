<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/board.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>포토 앨범</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
			<div class="row justify-content-center">
				<div class="col-md-10 board-section my-4 p-5">

					<div class="pb-2">
						<span class="small-title">${mode=='update' ? '게시글 수정' : '게시글 등록'}</span>
					</div>
				
					<form name="postForm" action="" method="post" enctype="multipart/form-data">
						<table class="table write-form">
							<tr>
								<td class="col-md-2 bg-light">제 목</td>
								<td>
									<input type="text" name="subject" class="form-control" maxlength="100" placeholder="Subject" value="${dto.subject}">
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이 름</td>
								<td>
									<div class="row">
										<div class="col-md-6">
											<input type="text" name="name" class="form-control" readonly tabindex="-1" value="${sessionScope.member.name}">
										</div>
									</div>
								</td>
							</tr>
						
							<tr>
								<td class="col-md-2 bg-light">내 용</td>
								<td>
									<textarea name="content" class="form-control" placeholder="Content">${dto.content}</textarea>
								</td>
							</tr>

							<tr>
								<td class="col-md-2 bg-light">이미지</td>
								<td>
									<div class="preview-session">
										<label for="selectFile" class="me-2" tabindex="0" title="사진 업로드">
											<img class="image-upload-btn" src="${pageContext.request.contextPath}/dist/images/add_photo.png">
											<input type="file" name="selectFile" id="selectFile" hidden="" multiple accept="image/png, image/jpeg">
										</label>
										<div class="image-upload-list">
											<!-- 클래스 -> image-item:새로추가된이미지, image-uploaded:수정에서 등록된이미지 -->
											<!-- 수정일때 등록된 이미지 -->
											<c:forEach var="vo" items="${listFile}">
												<img class="image-uploaded" src="${pageContext.request.contextPath}/uploads/album/${vo.imageFilename}"
													data-fileNum="${vo.fileNum}" data-fileSize="${vo.fileSize}">
											</c:forEach>
										</div>
									</div>
								</td>
							</tr>
						</table>
						
						<div class="text-center">
							<button type="button" class="btn-accent btn-md" onclick="sendOk();">${mode=='update'?'수정완료':'등록완료'}</button>
							<button type="reset" class="btn-default btn-md">다시입력</button>
							<button type="button" class="btn-default btn-md" onclick="location.href='${pageContext.request.contextPath}/album/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							<c:if test="${mode=='update'}">
								<input type="hidden" name="num" value="${dto.num}">
								<input type="hidden" name="page" value="${page}">
							</c:if>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
</main>

<script type="text/javascript">
// 수정인 경우 이미지 파일 삭제
window.addEventListener('DOMContentLoaded', evt => {
	const fileUploadList = document.querySelectorAll('form .image-upload-list .image-uploaded');
	
	for(let el of fileUploadList) {
		el.addEventListener('click', () => {
			let listEl = document.querySelectorAll('form .image-upload-list .image-uploaded');
			if(listEl.length <= 1) {
				alert('등록된 이미지가 2개 이상인 경우만 삭제 가능합니다.');
				return false;
			}
			
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
				
			let url = '${pageContext.request.contextPath}/album/deleteFile';
			// let fileNum = el.getAttribute('data-fileNum');
			let fileNum = el.dataset.filenum;
			// let filesize = el.dataset.filesize;

			$.ajaxSetup({ beforeSend: function(e) { e.setRequestHeader('AJAX', true); } });
			$.post(url, {fileNum:fileNum}, function(data){
				el.remove();
			}, 'json').fail(function(xhr){
				console.log(xhr.responseText);
			});
			
		});
	}
});

// 이미지 추가
window.addEventListener('DOMContentLoaded', evt => {
	var sel_files = [];
	
	const imageListEL = document.querySelector('form .image-upload-list');
	const inputEL = document.querySelector('form input[name=selectFile]');
	
	// sel_files[] 에 저장된 file 객체를 <input type="file">로 전송하기
	const transfer = () => {
		let dt = new DataTransfer();
		for(let f of sel_files) {
			dt.items.add(f);
		}
		inputEL.files = dt.files;
	}

	inputEL.addEventListener('change', ev => {
		if(! ev.target.files || ! ev.target.files.length) {
			transfer();
			return;
		}
		
		for(let file of ev.target.files) {
			if(! file.type.match('image.*')) {
				continue;
			}

			sel_files.push(file);
        	
			let node = document.createElement('img');
			node.classList.add('image-item');
			node.setAttribute('data-filename', file.name);

			const reader = new FileReader();
			reader.onload = e => {
				node.setAttribute('src', e.target.result);
			};
			reader.readAsDataURL(file);
        	
			imageListEL.appendChild(node);
		}
		
		transfer();		
	});
	
	imageListEL.addEventListener('click', (e)=> {
		if(e.target.matches('.image-item')) {
			if(! confirm('선택한 파일을 삭제 하시겠습니까 ?')) {
				return false;
			}
			
			let filename = e.target.getAttribute('data-filename');
			
			for(let i = 0; i < sel_files.length; i++) {
				if(filename === sel_files[i].name){
					sel_files.splice(i, 1);
					break;
				}
			}
		
			transfer();
			
			e.target.remove();
		}
	});	
});

function sendOk() {
	const f = document.postForm;
	let str;
	
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

	const fileListEL = document.querySelector('form .image-upload-list');
	const imageELS = fileListEL.querySelectorAll('.image-item, .image-uploaded');
	if(imageELS.length === 0) {
		alert('이미지 파일을 추가 하세요. ');
		f.selectFile.focus();
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/album/${mode}';
	f.submit();
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>