<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle2.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/productStyle.css"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css"> 	
body{
	font-family: Gowun Dodum, sans-serif;
	margin-top: 200px;
	
}
/* 카드 컨테이너 */
.subcart{
  max-width: 680px;
  background: #ffffff;
  border: 2px solid #e9f3ee;
}

/* 아이템 박스 */
.subcart-item{
  background: #f8fbf9;
  border: 1px solid #e5efe9;
}

/* 수량 박스 */
.qtybox{
  display:flex; align-items:center; gap:.25rem;
  background:#fff; border:1px solid #e1e1e1; border-radius:999px; padding:4px 8px;
}
.qty-btn{
  line-height:1; padding:.25rem .5rem; border:none; color:#039a63; background:transparent;
}
.qty-btn:hover{ background:#eaf6f1; }
.qty-input{
  width:46px; text-align:center; border:none; outline:none; font-weight:600; background:transparent;
}

/* +상품 추가 라인 버튼 */
.addline{
  background:#ffffff; border:2px solid #e6e6e6; color:#444;
}
.addline:hover{ background:#f7f7f7; }

/* 기존 그린 버튼 계열 */
.btnGreen{ background:#039a63; color:#fff; border:none; }
.btnGreen:hover{ background:#028453; }

.picked-bar{
  display:flex; flex-wrap:nowrap; gap:.5rem; align-items:center;
  padding:.5rem .75rem; border:1px solid #e5e7eb; border-radius:12px; background:#fff;
  min-height:48px; overflow-x:auto; overflow-y:hidden;
  -webkit-overflow-scrolling: touch; scroll-snap-type:x proximity;
}
.picked-bar::-webkit-scrollbar{ height:8px; }
.picked-bar::-webkit-scrollbar-thumb{ background:#cfd8dc; border-radius:999px; }

.picked-chip{
  display:inline-flex; align-items:center; gap:.5rem;
  padding:.35rem .6rem; border:1px solid #ffe3c2; background:#fff7ed;
  border-radius:999px; white-space:nowrap; box-shadow:0 1px 0 rgba(0,0,0,.02);
  scroll-snap-align:end;
}
.picked-chip img{ width:22px; height:22px; object-fit:cover; border-radius:6px; }
.picked-chip .name{ max-width:220px; overflow:hidden; text-overflow:ellipsis; }
.picked-chip .remove{ border:none; background:transparent; line-height:1; padding:0 .25rem; opacity:.6; }
.picked-chip .remove:hover{ opacity:1; }

/* 중복일 때 반짝 하이라이트 */
.picked-chip.pulse{ animation:pulse-bg .4s ease-out; }
@keyframes pulse-bg{ from{ box-shadow:0 0 0 0 rgba(3,154,99,.35);} to{ box-shadow:0 0 0 12px rgba(3,154,99,0);} }

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<!-- Subscription Cart -->
<div class="container my-5">
  <div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5">
    <h5 class="text-center mb-4 fw-bold">정기결제 바구니</h5>

    <!-- 아이템 1 : 패키지 -->
    <div class="subcart-item d-flex align-items-center gap-3 rounded-4 p-3 mb-3">
      <img src="${pageContext.request.contextPath}/dist/images/veggie-box-1.png" alt="집밥 세이브 패키지"
           class="rounded-3 object-fit-cover" style="width:110px;height:75px;">
      <div class="flex-grow-1">
        <div class="fw-semibold">집밥 세이브 패키지</div>
        <small class="text-muted">18,000 원</small>
      </div>
      <div class="qtybox">
        <button class="btn qty-btn" type="button">−</button>
        <input class="qty-input" type="number" value="1" min="1">
        <button class="btn qty-btn" type="button">＋</button>
      </div>
    </div>

    <!-- 패키지 추가 CTA -->
    <a href="#" class="btn btnGreen w-100 rounded-pill py-2 mb-3">샐러드 세이브 패키지도 담기</a>

    <!-- 아이템 2 : 단품 -->
    
	    <div class="subcart-item d-flex align-items-center gap-3 rounded-4 p-3 mb-3">
	      <!-- 상품 이미지 영역 -->
	      <img src="${pageContext.request.contextPath}/dist/images/mushroom.png" alt="브라운양송이버섯"
	           class="rounded-3 object-fit-cover" style="width:110px;height:75px;">
	      <div class="flex-grow-1">
	      	<!-- 이름영역 -->
	        <div class="fw-semibold">무농약 개성만점 브라운양송이버섯 150g</div>
	        <small class="text-muted">1,800 원</small>
	      </div>
	      <div class="qtybox">
	        <button class="btn qty-btn" type="button">−</button>
	        <input class="qty-input" type="number" value="1" min="1">
	        <button class="btn qty-btn" type="button">＋</button>
	      </div>
	    </div>

    
    <button class="btn addline w-100 rounded-pill py-2 mb-3">
      <span class="me-1">＋</span> 정기결제 상품 추가
    </button>

    
    <div class="d-flex justify-content-end align-items-center mt-2">
      <div class="fs-6"><span class="text-muted me-2">총합계 :</span><strong>19,800원</strong></div>
    </div>
  </div>

 
  <a href="#" class="btn btnGreen btn-lg d-block mx-auto rounded-pill py-3 mt-4" style="max-width:680px; width:100%;">
  	정기 구독 상품 결제하러 가기
 	</a>
</div>


<!-- 상품 선택 모달 -->
<div class="modal fade" id="productSelectModal" tabindex="-1" aria-labelledby="productSelectTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-xl"> <!-- 필요에 따라 lg/xl -->
    <div class="modal-content rounded-4">
      <div class="modal-header">
        <h5 class="modal-title" id="productSelectTitle">정기구독 상품 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <!-- 검색 바 -->
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="상품명 검색"
                 data-role="searchInput">
          <button class="btn btn-outline-secondary" type="button"
                  data-role="searchIcon">검색</button>
        </div>

        <div class="row g-3" id="productLayout"></div>

        <!-- 스켈레톤/로딩 -->
        <div class="text-center py-4 d-none" data-role="loading">
          <div class="spinner-border" role="status" aria-hidden="true"></div>
          <div class="mt-2">불러오는 중…</div>
        </div>
      </div>
      <div class="modal-footer">
		  <div id="pickedBar" class="picked-bar" aria-live="polite">
		    <span class="picked-empty text-muted">선택한 상품이 여기에 표시됩니다.</span>
		  </div>
      
        <button class="btn addline" data-bs-dismiss="modal">닫기</button>
        <button class="btn btnGreen" type="button" id="confirmProducts">담기 완료</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
(function () {
    var cp = '<c:url value="/"/>';        
    cp = cp.replace(/\/$/, '');           
    window.contextPath = cp;
  })();
</script>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/productList.js"></script>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/packageCartModal.js"></script>



</body>
</html>