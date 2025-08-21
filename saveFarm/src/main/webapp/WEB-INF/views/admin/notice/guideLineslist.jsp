<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">


<style>
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
  

.nav-tabs .nav-link {
  background-color: transparent; 
  color: inherit;  
  border: none;           
}  

#dataTable-1 th, 
#dataTable-1 td {
  text-align: center;
}

#dataTable-1 th:nth-child(3),
#dataTable-1 td:nth-child(3) {
  width: 400px;  /* 원하는 너비로 조절 */
  white-space: nowrap; /* 줄바꿈 방지 (필요하면) */
}
  
</style>

<title>세이브팜</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
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
            <div class="col-12">
              <h2 class="mb-2 page-title">농가 가이드라인</h2>
              <div class="row my-4">
                <!-- Small table -->
                  
                    <div class="col-md-12" id="nav-tabContent"></div>
	                  
					<form name="articleForm" action="${pageContext.request.contextPath}/admin/notice/article/${itemId}">
						<input type="hidden" name="noticeNum">
						<input type="hidden" name="schType" value="all">
						<input type="hidden" name="kwd" value="">
						<input type="hidden" name="page" value="${page}">
					</form>
				                  
              </div> <!-- end section -->
            </div> <!-- .col-12 -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
      </main>
      
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<script type="text/javascript">      
$(document).ready(function() {
    loadGuideContent(2);
});

function loadGuideContent(classifyValue) {
    const url = '${pageContext.request.contextPath}/admin/notice/guide/' + classifyValue;
    
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'html', // 서버가 HTML 조각을 반환할 것으로 기대
        success: function(data) {
            $('#nav-tabContent').html(data);

            $('#nav-tabContent .nav-tabs .nav-link').on('click', function(e) {
            	e.preventDefault();

                // 1. 모든 탭에서 'active' 클래스를 제거
                $('#nav-tabContent .nav-tabs .nav-link').removeClass('active');
                
                // 2. 클릭된 탭에만 'active' 클래스를 추가
                $(this).addClass('active');
                
                const newClassifyValue = $(this).val();
                loadGuideContent(newClassifyValue);
            });
        }
    });
}

//검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/admin/notice/guide/${itemId}';
	location.href = url + '?' + params;
}

function goArticle(noticeNum, itemId) {
    const f = document.articleForm;
    f.noticeNum.value = noticeNum;
    f.action = '${pageContext.request.contextPath}/admin/notice/article/' + itemId; // itemId도 URL에 포함
    f.submit();
}
</script>      
      
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>