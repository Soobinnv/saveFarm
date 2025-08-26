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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/guideTitle.webp);">
      <div class="container position-relative">
        <h1>자주묻는 질문</h1>
        <p>저희 서비스를 이용하시면서 많이 필요로 하시는 질문을 정리했습니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
            <li class="current">FAQ</li>
          </ol>
        </nav>
      </div>
    </div>			
			
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
		
			<div class="row justify-content-center">
				<div class="col-md-12 mb-2">
					<div class="row">
						<div class="col-md-3">&nbsp;</div>
						<div class="col-md-6">
							<form name="searchForm" class="form-group-search">
								<input type="text" name="kwd" value="" class="form-control" placeholder="검색어를 입력하세요">
								<input type="hidden" id="searchValue" value="">
								<button type="button" onclick="searchList();"><i class="bi bi-search"></i></button>
							</form>
						</div>
					</div>
				</div>
				
					<div class="col-md-10 box-shadow mb-4 p-5 mx-auto">
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="tab-0" data-bs-toggle="tab" data-bs-target="#nav-content" type="button" role="tab" aria-selected="true" data-categoryNum="0">모두</button>
							</li>
							<c:forEach var="dto" items="${listFAQ}" varStatus="status">
							  <li class="nav-item" role="presentation">
							    <button class="nav-link" id="tab-${status.count}" data-bs-toggle="tab"
							            data-bs-target="#nav-content" type="button" role="tab"
							            aria-selected="true" data-categoryNum="${dto.categoryNum}">
							      ${dto.categoryName}
							    </button>
							  </li>
							</c:forEach>
						</ul>
						
						<div class="tab-pane fade show active px-2 py-2" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
							<jsp:include page="/WEB-INF/views/farm/faq/list.jsp"/>
						</div>
	
					</div>
			</div>
			
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
/* 전역 AJAX 헬퍼 */
window.ajaxRequest = function (url, method, params, dataType, onSuccess) {
  return $.ajax({
    url: url,
    type: (method || 'GET').toUpperCase(),
    data: params || {},
    dataType: dataType || 'text',  // 너희 코드가 text를 기대하니 기본값 text
    // Spring Security CSRF 쓰면 메타 태그에서 자동 주입
    beforeSend: function (xhr) {
      var token  = $('meta[name="_csrf"]').attr('content');
      var header = $('meta[name="_csrf_header"]').attr('content');
      if (token && header) xhr.setRequestHeader(header, token);
    },
    success: function (resp) { if (typeof onSuccess === 'function') onSuccess(resp); },
    error: function (xhr) {
      console.error('AJAX error:', xhr.status, xhr.responseText);
      alert('잠시 후 다시 시도해 주세요.');
    }
  });
};

$(function(){
	  // 최초 1페이지 로딩
	  listPage(1);

	  // 탭 클릭 시 1페이지부터
	  $('button[role="tab"]').on('click', function(){
	    listPage(1);
	  });
	})

//글리스트 및 페이징 처리
function listPage(page) {
	const $tab = $('button[role="tab"].active');
	let categoryNum = $tab.attr('data-categoryNum') || '';
	// "모두"가 0이면 필터 미적용으로 보낼 거면 0 -> '' 처리
	if (categoryNum === '0') categoryNum = '';
	
	let kwd = $('#searchValue').val();
	
	let url = '${pageContext.request.contextPath}/farm/FAQ/list';
	
	let params = 'page=' + page;
	if (categoryNum) params += '&categoryNum=' + encodeURIComponent(categoryNum);
	if (kwd)        params += '&kwd=' + encodeURIComponent(kwd);
	
	const fn = function(html){
	  // 전체 페이지가 오므로, 그 중 #nav-content만 뽑아서 교체
	  const $resp = $('<div>').html(html);
	  const $frag = $resp.find('#nav-content').html(); // 내부만 추출
	  if ($frag) {
	    $('#nav-content').html($frag);
	  } else {
	    // 방어: 혹시 못 찾으면 전체로라도 교체
	    $('#nav-content').html(html);
	  }
	};
	
	ajaxRequest(url, "get", params, "text", fn);
}

// 검색
window.addEventListener('DOMContentLoaded', () => {
  const inputEL = document.querySelector('form[name=searchForm] input[name=kwd]'); 
  inputEL.addEventListener('keydown', function (evt) {
    if(evt.key === 'Enter') {
      evt.preventDefault();
      searchList();
    }
  });
});

function searchList() {
  const f = document.searchForm;
  let kwd = f.kwd.value.trim();
  $('#searchValue').val(kwd);
  listPage(1);
}

// 새로고침
function reloadFaq() {
  const f = document.searchForm;
  f.kwd.value = '';
  $('#searchValue').val('');
  listPage(1);
}

function listFaq(p) { // 페이징에서 부르는 이름
  listPage(p);
}

</script>

</body>
</html>