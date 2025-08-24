<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>구독 리뷰</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<style>
  :root{ --ink:#1f2937; --muted:#6b7280; --border:#e6efe9; --primary:#18a05b; }
  *{ box-sizing:border-box }
  body{ margin:0; padding:40px 16px; background:#f6faf8; color:var(--ink); font-family:"Pretendard","Noto Sans KR",sans-serif }
  .wrap{ max-width:1100px; margin:0 auto }
  .heading{ text-align:center; margin:10px 0 28px; }
  .heading .pill{ display:inline-block; padding:12px 24px; border-radius:999px; background:#ffd6cc; color:#7a4b44; font-weight:700; }

  .grid{ display:grid; grid-template-columns:repeat(3, minmax(0,1fr)); gap:22px; min-height:160px }
  @media (max-width:900px){ .grid{ grid-template-columns:repeat(2, minmax(0,1fr)); } }
  @media (max-width:560px){ .grid{ grid-template-columns:1fr; } }

  .card{ background:#fff; border:2px solid var(--border); border-radius:14px; overflow:hidden; box-shadow:0 6px 16px rgba(17,24,39,.05); display:flex; flex-direction:column }
  .thumb{ width:100%; aspect-ratio:4/3; object-fit:cover; display:block }
  .meta{ padding:12px 14px 4px; color:var(--muted); font-size:13px }
  .title{ padding:0 14px; font-weight:800; font-size:16px; line-height:1.4; margin:6px 0 6px; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical }
  .excerpt{ padding:0 14px 12px; color:var(--muted); font-size:13px; line-height:1.5; overflow:hidden; display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical }
  .foot{ padding:12px 14px 14px; display:flex; justify-content:space-between; align-items:center; border-top:1px solid var(--border) }
  .stars{ font-size:14px; letter-spacing:1px }
  .stars .on{ color:#f4b400 }
  .btn-view{ font-size:13px; padding:8px 12px; border-radius:10px; border:1px solid var(--border); background:#fff; cursor:pointer; text-decoration:none; color:inherit }
  .btn-view:hover{ border-color:#d7e7de }

  .actions{ display:flex; justify-content:center; margin-top:26px }
  .btn-write{ background:var(--primary); color:#fff; border:none; border-radius:999px; padding:12px 18px; font-weight:800; cursor:pointer; text-decoration:none }

  .paging{ margin:28px 0 6px; display:flex; gap:6px; justify-content:center; align-items:center; flex-wrap:wrap }
  .paging a, .paging span{
    min-width:36px; height:36px; display:inline-flex; justify-content:center; align-items:center;
    padding:0 10px; border-radius:10px; border:1px solid var(--border); background:#fff; color:var(--ink); text-decoration:none; font-size:14px;
  }
  .paging .active{ background:var(--primary); color:#fff; border-color:var(--primary) }
  .paging .disabled{ opacity:.5; pointer-events:none }
  .empty{ text-align:center; color:var(--muted); padding:40px 0 }
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<c:set var="CP" value="${pageContext.request.contextPath}" />

<div class="wrap">
  <div class="heading">
    <div class="pill">우리 농가를 구하는 구독자님들의 소중한 후기</div>
  </div>

  <!-- AJAX로 채울 영역 -->
  <div id="grid" class="grid"></div>
  <div id="paging" class="paging"></div>

  <div class="actions">
    <a class="btn-write" href="${CP}/sub/review/write">후기 작성</a>
  </div>
</div>

<script>
  var LIST_URL     = '/package/list';            
  var WRITE_URL    = '/package/reviewWriteForm';  
  var DETAIL_URL   = function(subNum){ return '#'; }; 

  // 정적 리소스
  var PLACEHOLDER  = '/resources/img/no-image.png';
  var UPLOAD_DIR   = '/uploads/PackageReview/'; 

  // 간단 이스케이프
  function esc(s){
    return String(s==null?'':s)
      .replace(/&/g,'&amp;').replace(/</g,'&lt;')
      .replace(/>/g,'&gt;').replace(/"/g,'&quot;')
      .replace(/'/g,'&#39;');
  }

  function renderList(data){
    var grid = document.getElementById('grid');
    var list = Array.isArray(data.list) ? data.list : [];
    var html = '';

    if(list.length === 0){
      html = '<div class="empty" style="grid-column:1/-1">아직 등록된 후기가 없습니다.</div>';
    } else {
      for(var i=0;i<list.length;i++){
        var it = list[i];
        var imgSrc = it.imageFilename ? (UPLOAD_DIR + it.imageFilename) : PLACEHOLDER;

        // 별점
        var s = Number(it.star) || 0, stars = '';
        for(var k=0;k<5;k++){ stars += '<span class="' + (k < s ? 'on' : '') + '">★</span>'; }

        html += ''
          + '<div class="card">'
          +   '<img class="thumb" src="' + imgSrc + '" alt="' + esc(it.subject) + '">'
          +   '<div class="meta">' + esc(it.regDate||'') + (it.subNum ? ' · 구독번호 ' + esc(it.subNum) : '') + '</div>'
          +   '<div class="title">' + esc(it.subject) + '</div>'
          +   '<div class="excerpt">' + esc(it.content) + '</div>'
          +   '<div class="foot">'
          +     '<div class="stars">' + stars + '</div>'
          +     '<a class="btn-view" href="' + DETAIL_URL(it.subNum) + '">자세히</a>'
          +   '</div>'
          + '</div>';
      }
    }
    grid.innerHTML = html;

    // 페이징
    var pagingEl = document.getElementById('paging');
    if(data.paging){
      pagingEl.innerHTML = data.paging; // 서버에서 만든 HTML 그대로 사용 (listReview 호출)
    }else{
      var page  = data.pageNo || 1;
      var total = data.total_page || 1;
      var prev  = Math.max(1, page-1);
      var next  = Math.min(total, page+1);

      var phtml = '';
      phtml += '<a class="' + (page===1?'disabled':'') + '" href="javascript:listReview(' + prev + ')">이전</a>';
      var start = Math.max(1, page-2), end = Math.min(total, start+4);
      for(var p=start; p<=end; p++){
        if(p===page) phtml += '<span class="active">' + p + '</span>';
        else         phtml += '<a href="javascript:listReview(' + p + ')">' + p + '</a>';
      }
      phtml += '<a class="' + (page===total?'disabled':'') + '" href="javascript:listReview(' + next + ')">다음</a>';
      pagingEl.innerHTML = phtml;
    }


    var writeBtn = document.querySelector('.btn-write');
    if(writeBtn){ writeBtn.setAttribute('href', WRITE_URL); }
  }

  async function fetchList(pageNo){
    var res = await fetch(LIST_URL + '?pageNo=' + encodeURIComponent(pageNo||1), {
      headers: { 'Accept': 'application/json' }
    });
    if(!res.ok) throw new Error('네트워크 오류');
    return await res.json();
  }

  async function listReview(pageNo){
    try{
      var data = await fetchList(pageNo||1);
      renderList(data);
      window.scrollTo({top:0, behavior:'smooth'});
    }catch(e){
      console.error(e);
      alert('리뷰 목록을 불러오지 못했습니다.');
    }
  }
  window.listReview = listReview;
  document.addEventListener('DOMContentLoaded', function(){ listReview(1); });
</script>



<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
</body>
</html>
