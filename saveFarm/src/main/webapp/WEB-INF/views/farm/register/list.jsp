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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.webp);">
      <div class="container position-relative">
        <h1>납품 신청리스트</h1>
        <p>남품신청한 목록을 확인하고 수정합니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm/register/main">돌아가기</a></li>
            <li class="current">리스트</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->  
    
	<section id="comment-form" class="comment-form section">
		<div class="container">
			<div class="row g-2 align-items-end mb-3">
				<div class="col-md-7">
					<span class="small text-muted">
						총 <strong>${dataCount}</strong>건
						<c:if test="${total_page > 0}"> _ <strong>${page}</strong> / ${total_page} 페이지</c:if>
					</span>
				</div>
					
				<div class="col-md-5">
					<div class="d-flex justify-content-end align-items-center gap-2">
						<label for="state" class="form-label mb-0">진행상태</label>
						<select id="state" name="state" class="form-select" style="max-width: 180px;">
							<option value="1" ${state==1?'selected':''}>신청</option>
							<option value="2" ${state==2?'selected':''}>승인</option>
							<option value="3" ${state==3?'selected':''}>기각</option>
							<option value="4" ${state==4?'selected':''}>배송시작</option>
							<option value="5" ${state==5?'selected':''}>배송완료</option>
						</select>
					</div>
				</div>
			</div>  
	    	<form name="searchForm" method="get" action="${pageContext.request.contextPath}/farm/register/list" class="mb-3">
	    		<input type="hidden" name="state" value="${state}" />
	      		<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제품명</th>
							<th class="text-center">납품총량</th>
							<th class="text-center">판매단위</th>
							<th class="text-center">단위금액</th>
							<th class="text-center">수확날짜</th>
							<th class="text-center">긴급구출</th>
							<th class="text-center">코멘트</th>
						</tr>
					 </thead>
				  	<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="align-middle" data-href="${pageContext.request.contextPath}/farm/register/detail?supplyNum=${dto.supplyNum}&back=register">
								<!-- 번호 -->
        						<td class="text-center">
									${dataCount - (page-1) * size - status.index}
								</td>
								
								<!-- 제품명: 없으면 번호 표기 -->
								<td class="text-center">
									<c:choose>
										<c:when test="${not empty dto.varietyName}">
											${dto.varietyName}
										</c:when>
										<c:otherwise>
											${dto.varietyNum}
										</c:otherwise>
									</c:choose>
								</td>
							
								<td class="text-center">${dto.supplyQuantity}</td>
								<td class="text-center">${dto.unitQuantity}</td>
								<td class="text-center">
									${dto.unitPrice}₩
								</td>
							
								<td class="text-center">
									<c:choose>
										<c:when test="${not empty dto.harvestDate}">
											${dto.harvestDate.substring(0,10)}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								
								<!-- 긴급구출신청여부: 0/1 -->
								<td class="text-center">
									 <c:choose>
										<c:when test="${dto.rescuedApply == 1}">신청</c:when>
										<c:otherwise>미신청</c:otherwise>
									</c:choose>
								</td>
								
								<td class="text-nowrap text-center">					
									<c:choose>
										<c:when test="${not empty dto.coment}">
											${dto.coment}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								
							</tr>
						</c:forEach>
				  	</tbody>
				</table>
				<div class="page-navigation d-flex justify-content-center my-3">
					${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
				</div>
	    	</form>
	    	
	    	<div class="row mt-3">
				<div class="col-md-3">
					<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/register/list';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
				</div>
				<div class="col-md-6 text-center">
					<select name="schType">
						<option value="varietyName" ${schType=="varietyName"?"selected":""}>제품명</option>
						<option value="rescuedApply" ${schType=="rescuedApply"?"selected":""}>긴급구출여부</option>
						<option value="coment" ${schType=="coment"?"selected":""}>'기타'로 작성한 제품명</option>
					</select>
					<input type="text" name="kwd" value="${kwd}">
					<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
				</div>
			</div>
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
// 폼과 폼 밖 검색값을 합쳐 쿼리스트링 생성 + rescuedApply 매핑
function buildSearchParams() {
  const f = document.forms['searchForm'];                      // 폼( hidden state 포함 )
  const sel = document.querySelector('select[name="schType"]'); // 폼 밖 검색 타입
  const kwdEl = document.querySelector('input[name="kwd"]');     // 폼 밖 키워드
  const stateSel = document.getElementById('state');             // 상단 진행상태 드롭다운

  // 폼 안 값들(state 등) 먼저 수집
  const params = new URLSearchParams(new FormData(f));
  if (sel)   params.set('schType', sel.value || 'varietyName');
  
 // rescuedApply 검색어를 "신청/미신청" → 1/0 으로 매핑
  let kwd = (kwdEl?.value ?? '').trim();
  if (sel && sel.value === 'rescuedApply') {
    const norm = kwd.toLowerCase();
    if (['신청','1','y','yes','true','t'].includes(norm)) kwd = '1';
    else if (['미신청','0','n','no','false','f'].includes(norm)) kwd = '0';
    else if (kwd !== '') {
      alert("긴급구출여부는 '신청' 또는 '미신청'으로 입력해주세요.");
      kwdEl && kwdEl.focus();
      throw new Error('invalid rescuedApply kwd'); // 중단
    }
  }
  params.set('kwd', kwd);

  // 진행상태는 항상 최신 드롭다운 값으로 강제 반영
  if (stateSel) params.set('state', stateSel.value);

  return { f, params, kwdEl, stateSel, sel };
}

// 검색 실행(버튼/엔터)
function searchList() {
  const { f, params, kwdEl } = buildSearchParams();

  try {                                         
    const { f, params } = buildSearchParams();
    params.delete('page'); // 새 검색은 1페이지부터
    location.href = f.action + '?' + params.toString();
  } catch(e) {
    // 위에서 invalid 처리 시 여기로 옴. 추가 처리 불필요.   
  }
}

// 진행상태 변경 시에도 현재 검색조건 유지하여 재조회
(function () {
  const stateSel = document.getElementById('state');
  if (!stateSel) return;

  try { stateSel.value = '${state}'; } catch (e) {}

  stateSel.addEventListener('change', function () {
    try {                                        
      const { f, params } = buildSearchParams();
      params.delete('page'); // 상태 바꾸면 1페이지부터
      location.href = f.action + '?' + params.toString();
    } catch(e) {}
  });
})();

// 엔터키로도 검색 / 행 클릭 이동
document.addEventListener('DOMContentLoaded', function () {
  const kwdEl = document.querySelector('input[name="kwd"]');
  if (kwdEl) {
    kwdEl.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        searchList();
      }
    });
  }

  // 테이블 행 클릭 이동(data-href)
  document.querySelectorAll('tr[data-href]').forEach(tr => {
    tr.style.cursor = 'pointer';
    tr.addEventListener('click', () => {
      const href = tr.getAttribute('data-href');
      if (href) location.href = href;
    });
  });
});
</script>

</body>
</html>