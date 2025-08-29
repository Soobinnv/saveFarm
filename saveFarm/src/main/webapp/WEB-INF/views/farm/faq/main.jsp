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
:root{
  --sf-primary:#116530;  /* 활성 배경/보더 */
  --sf-soft:#E9F5EC;     /* 비활성 배경 */
  --sf-text:#2b2b2b;
}

/* 버튼 공통 */
.page-navigation .page-pill{
  display:inline-flex; align-items:center; justify-content:center;
  min-width:44px; height:44px; padding:0 14px;
  border-radius:.375rem; border:1.5px solid var(--sf-primary);
  background:var(--sf-soft); color:var(--sf-text);
  text-decoration:none; box-shadow:none;
}

/* 활성(현재 페이지) */
.page-navigation .page-pill.active{
  background:var(--sf-primary) !important;
  border-color:var(--sf-primary) !important;
  color:#fff !important;
}

/* 호버(비활성만) */
.page-navigation .page-pill:not(.active):hover{
  background:var(--sf-primary) !important;
  border-color:var(--sf-primary) !important;
  color:#fff !important;
}

/* 가로 간격 */
.page-navigation{ display:flex; justify-content:center; margin:1rem 0; }
.page-navigation .page-pill{ margin:0 6px; }

/* 모든 탭: 글자색만 초록 + 굵게. 모양은 원본 유지 */
#myTab.nav-tabs .nav-link {
  color: #116530 !important;
  font-weight: 700;
  background-color: transparent !important;  /* 기본 */
  border: 1px solid transparent;            /* 기본 */
  border-radius: .375rem .375rem 0 0 !important; /* 기본 탭 모양으로 되돌림 */
}

/* 호버 시 색만 살짝 진하게 */
#myTab.nav-tabs .nav-link:hover {
  color: #0f5a2a !important;
}

/* 활성 탭: 원본 모양(흰 배경 + 탭 보더) 유지하면서 초록 포커스만 */
#myTab.nav-tabs .nav-link.active,
#myTab.nav-tabs .nav-link.active:hover {
  color: #116530 !important;
  background-color: #fff !important;          /* 기본 활성 배경 */
  border-color: #116530 #116530 #fff !important; /* 위/양옆은 초록, 아래는 흰색(탭 내용과 연결) */
}

</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/faqTitle.webp);">
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
							            aria-selected="true" data-categoryNum="${dto.categoryNum}"
							            >
							      ${dto.categoryName}
							    </button>
							  </li>
							</c:forEach>
						</ul>
						
						<div class="tab-pane fade show active px-2 py-2" id="nav-content" role="tabpanel" aria-labelledby="nav-tab-content">
							<jsp:include page="/WEB-INF/views/farm/faq/list.jsp"/>
							
							<div class="page-navigation d-flex justify-content-center my-4">
							  	${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
							</div>
							
							<c:choose>
								<c:when test="${dataCount > 0}">
									<div class="pagination-info text-center text-muted my-2">
										페이지 <strong>${page}</strong> / <strong>${totalPage}</strong>
										<span class="ms-2">(총 ${dataCount}건)</span>
									</div>
								</c:when>
								<c:otherwise>
									<div class="pagination-info text-center text-muted my-2">
										등록된 게시글이 없습니다.
									</div>
								</c:otherwise>
							</c:choose>
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
/* ============================
AJAX 헬퍼 메서드
공통적으로 AJAX 요청을 보낼 때 사용
============================ */
window.ajaxRequest = function (url, method, params, dataType, onSuccess) {
return $.ajax({
 url: url,
 type: (method || 'GET').toUpperCase(),
 data: params || {},
 dataType: dataType || 'text',
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

/* ============================
문서 로딩 시 실행되는 초기화 함수
- 첫 페이지 로딩
- 탭 버튼 클릭 시 다시 1페이지부터 로드
============================ */
$(function(){
listPage(1);
skinPagingLite(); 

$('button[role="tab"]').on('click', function(){
 listPage(1);
});
});

/* ============================
글 리스트 + 페이징 처리 함수
- page 번호 받아와서 서버에 요청
- 응답 HTML 중 #nav-content 영역만 교체
- 페이징 버튼은 skinPagingLite()로 재적용
============================ */
function listPage(page) {
const $tab = $('button[role="tab"].active');
let categoryNum = $tab.attr('data-categoryNum') || '';
if (categoryNum === '0') categoryNum = '';

let kwd = $('#searchValue').val();

let url = '${pageContext.request.contextPath}/farm/FAQ/list';

let params = 'page=' + page;
if (categoryNum) params += '&categoryNum=' + encodeURIComponent(categoryNum);
if (kwd)        params += '&kwd=' + encodeURIComponent(kwd);

const fn = function(html){
 const $resp = $('<div>').html(html);
 const $frag = $resp.find('#nav-content').html();
 if ($frag) {
   $('#nav-content').html($frag);
 } else {
   $('#nav-content').html(html);
 }
 skinPagingLite(); // 페이징 다시 스킨 적용
};

ajaxRequest(url, "get", params, "text", fn);
}

/* ============================
검색 실행 함수
- 검색어 입력 후 엔터 또는 버튼 클릭 시 호출
============================ */
function searchList() {
const f = document.searchForm;
let kwd = f.kwd.value.trim();
$('#searchValue').val(kwd);
listPage(1);
}

/* ============================
검색어 초기화 후 FAQ 리스트 새로고침
============================ */
function reloadFaq() {
const f = document.searchForm;
f.kwd.value = '';
$('#searchValue').val('');
listPage(1);
}

/* ============================
페이징에서 숫자 클릭 시 호출
============================ */
function listFaq(p) { 
listPage(p);
}

/* ============================
페이징 스킨 적용 함수
- 원본 페이징 마크업에서 숫자만 추출
- 숫자만 pill 버튼으로 다시 그려줌
- 현재 페이지(active)는 강조 색상 적용
============================ */
function skinPagingLite(){
const $nav = $('.page-navigation'); 
if(!$nav.length) return;

// 숫자만 골라내서 새롭게 버튼 구성
const items = [];
$nav.find('a, span, b, button').each(function(){
 const txt = ($(this).text() || '').replace(/\s|\u00A0/g,'');
 if(!/^\d+$/.test(txt)) return; // 숫자 아니면 제외
 const isActive = $(this).is('b, .active, [aria-current], .current, .on');
 if (isActive) {
 	$a.addClass('active').attr('aria-current', 'page');
 }
 items.push({num: Number(txt), active: isActive});
});
if(!items.length) return;

// 새 마크업 생성
const $wrap = $('<div class="pagination-clean"></div>');
items.forEach(({num, active})=>{
 const $a = $('<a/>',{
   href: '#', text: num, class: 'page-pill' + (active ? ' active' : '')
 }).on('click', function(e){ e.preventDefault(); listFaq(num); });
 $wrap.append($a);
});

$nav.empty().append($wrap); 
}

</script>

</body>
</html>