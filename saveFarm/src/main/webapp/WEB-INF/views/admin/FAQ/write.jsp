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
                    <h2 class="mb-2 page-title">${mode == 'update' ? '자주하는질문 수정' : '자주하는질문 등록'}</h2>
                    <div class="row my-4">
                        <div class="col-md-12">
                            <div class="card shadow">
                                <div class="card-body">
                                    <form name="faqForm" method="post" enctype="multipart/form-data">
                                        <!-- 분류 선택 (itemId에 따라 회원/농가 등) -->
                                        <div class="form-group row mb-3">
										    <label for="classify" class="col-sm-2 col-form-label">분류</label>
										    <div class="col-sm-10">
										        <select class="form-control me-2 col-2" name="schTypeFAQ" id="writeSelect" onchange="changeFaqWriteType(this);">
										            <option value="memberFAQ" ${schTypeFAQ == 'memberFAQ' ? 'selected' : ''}> 회원</option>
										            <option value="farmFAQ" ${schTypeFAQ == 'farmFAQ' ? 'selected' : ''}>농가</option>
										        </select>
										        <input type="hidden" name="classify" value="1">
										    </div>
										</div>
										<div class="form-group row mb-3">
										    <label for="classify" class="col-sm-2 col-form-label">카테고리</label>
										    <div class="col-sm-10">
										        <select class="form-control" id="category" name="categoryNum"></select>
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
                                                <div id="editor-container" > ${dto.content} </div>
                                                <input type="hidden" id="content" name="content"> 
                                            </div>
                                        </div>
                                        
                                        <!-- 버튼 -->
                                        <div class="form-group row">
                                            <div class="col-sm-10 offset-sm-2">
                                                <button type="button" class="btn btn-primary" onclick="faqSubmit();">${mode == 'update' ? '수정완료' : '등록완료'}</button>
                                                <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/FAQ/';">${mode == 'update' ? '수정취소' : '등록취소' }</button>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${mode == 'update'}">
	                                        <input type="hidden" name="faqNum" value="${dto.faqNum}">
	                                        <input type="hidden" name="page" value="${page}">
	                                        <input type="hidden" name="schType" value="${schType}">
	                                        <input type="hidden" name="kwd" value="${kwd}">
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
var quill;

$(function(){
// 	changeFaqWriteType('memberFAQ');
	changeFaqWriteType(document.getElementById('writeSelect'));
});

function changeFaqWriteType(selectElement) {
	const f = document.faqForm;
	let classifyValue = 1;
	
	if(selectElement.value == 'farmFAQ') {
		classifyValue = 2;
	}
	f.classify.value = classifyValue;

	const schTypeFAQ = selectElement.value;
    const url = '${pageContext.request.contextPath}/admin/FAQ/categoryList';
    const params = { schTypeFAQ: schTypeFAQ };

    $.ajax({
        type: "GET",
        url: url,
        data: params,
        dataType: "json", 
        success: function(response) {
            const categorySelect = $('#category');
            categorySelect.empty(); // 기존 옵션 삭제
            
            $.each(response, function(index, dto) {
                categorySelect.append(
                    $('<option></option>').val(dto.categoryNum).text(dto.categoryName)
                );
            });
        }
    });
}

function faqSubmit() {
    const f = document.faqForm;
    
    const quill = new Quill('#editor-container', { readOnly: true }); 
    const htmlContent = quill.root.innerHTML.trim();
    if (htmlContent === '' || htmlContent === '<p><br></p>' || htmlContent === '<p></p>') {
        alert("내용을 입력하세요.");
        return;
    }
    document.getElementById('content').value = htmlContent;

    f.action="${pageContext.request.contextPath}/admin/FAQ/${mode == 'update' ? 'update' : 'write'}";
    f.method = "post";
    f.submit();
}


$(document).ready(function() {
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
                    'image': function() {
                        selectLocalImage();
                    }
                }
            }
        }
	});

    $('form').on('submit', function(event) {
    	var htmlContent = quill.root.innerHTML.trim(); // trim() 추가
        
        // 내용이 비어있는지 확인
        if (htmlContent === '' || htmlContent === '<p><br></p>' || htmlContent === '<p></p>') {
            alert("내용을 입력하세요.");
            event.preventDefault(); // 폼 제출 중단
            return false;
        }

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
