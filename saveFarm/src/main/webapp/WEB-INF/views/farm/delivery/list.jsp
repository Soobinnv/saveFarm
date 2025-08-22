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
    <div class="page-title dark-background"  data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/deliveryTitle1.webp);">
      <div class="container position-relative">
        <h1>배송관리</h1>
        <p>납품관련 배송정보를 관리할 수 있는 곳입니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
            <li class="current">배송관리</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section" style="margin-top: 50px;">
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
						<label for="state" class="form-label mb-0">배송상태</label>
						<select id="state" name="state" class="form-select" style="max-width: 180px;">
							<option value="2" ${state==2?'selected':''}>배송대기</option>
							<option value="4" ${state==4?'selected':''}>배송시작</option>
							<option value="5" ${state==5?'selected':''}>배송완료</option>
						</select>
					</div>
				</div>
			</div>  
	    	<form name="searchForm" method="get" action="${pageContext.request.contextPath}/farm/delivery/list" class="mb-3">
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
							<c:if test="${state==2 || state==4}">
								<th class="text-center">${state==2?'배송시작 신청':'배송대기 전환'}</th>								
							</c:if>
						</tr>
					 </thead>
				  	<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="align-middle" data-href="${pageContext.request.contextPath}/farm/register/detail?supplyNum=${dto.supplyNum}&back=delivery">
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
								
								<c:if test="${state==2 || state==4}">
									<td class="text-center no-rowlink">
										<input type="checkbox" class="row-check" value="${dto.supplyNum}">
										<!-- 
											<small class="text-muted"> ${state==2 ? '→ 배송시작' : '→ 배송대기'}</small>
										 -->
									</td>
								</c:if>
							</tr>
						</c:forEach>
				  	</tbody>
				</table>
				<div class="page-navigation d-flex justify-content-center my-3">
					${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
				</div>
	    	</form>
	    	
	    	<div class="row mt-3">
				<div class="col-md-2">
					<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/delivery/list';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
				</div>
				<div class="col-md-8 text-center">
					<select name="schType">
						<option value="varietyName" ${schType=="varietyName"?"selected":""}>제품명</option>
						<option value="rescuedApply" ${schType=="rescuedApply"?"selected":""}>긴급구출여부</option>
						<option value="coment" ${schType=="coment"?"selected":""}>'기타'로 작성한 제품명</option>
					</select>
					<input type="text" name="kwd" value="${kwd}">
					<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
				</div>
				<c:if test="${state==2 || state==4}">			
					<div class="col-md-2">
						<button type="button" class="btn-default" onclick="changeOk()" title="일괄배송변경">일괄변경</button>
					</div>
				</c:if>
			</div>
		</div>
	</section><!-- /Comment Form Section -->

	<form id="batchForm" method="post" action="${pageContext.request.contextPath}/farm/delivery/list" style="display:none">
		<input type="hidden" name="targetState" value="">
		<c:if test="${not empty _csrf}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</c:if>
	</form>
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
  // 엔터 검색
  const kwdEl = document.querySelector('input[name="kwd"]');
  if (kwdEl) {
    kwdEl.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') { e.preventDefault(); searchList(); }
    });
  }

  // 행 클릭 이동(체크박스/상태변경 셀 제외)
  document.querySelectorAll('tr[data-href]').forEach(tr => {
    tr.style.cursor = 'pointer';
    tr.addEventListener('click', (e) => {
      // 인터랙티브 요소나 .no-rowlink 영역 클릭이면 이동 금지
      if (e.target.closest('input, button, a, select, textarea, label, .no-rowlink')) return;

      const href = tr.getAttribute('data-href');
      if (href) location.href = href;
    });
  });

  // (선택) .no-rowlink 셀에서 버블링 자체 차단
  document.querySelectorAll('td.no-rowlink').forEach(td => {
    td.addEventListener('click', e => e.stopPropagation());
  });
});

// 폼과 폼 밖 검색값을 합쳐 쿼리스트링 생성 (+ rescuedApply 매핑 포함)
function buildSearchParams() {
  const f = document.forms['searchForm'];                       // 폼( hidden state 포함 )
  const sel = document.querySelector('select[name="schType"]');  // 폼 밖 검색 타입
  const kwdEl = document.querySelector('input[name="kwd"]');      // 폼 밖 키워드
  const stateSel = document.getElementById('state');              // 상단 진행상태 드롭다운

  // 폼 안 값들(state 등) 먼저 수집
  const params = new URLSearchParams(new FormData(f));

  // 검색 타입 반영
  if (sel) params.set('schType', sel.value || 'varietyName');

  // rescuedApply 검색어를 "신청/미신청" → 1/0 으로 매핑
  let kwd = (kwdEl?.value ?? '').trim();
  if (sel && sel.value === 'rescuedApply') {
    const norm = kwd.toLowerCase();
    if (['신청','1','y','yes','true','t'].includes(norm)) kwd = '1';
    else if (['미신청','0','n','no','false','f'].includes(norm)) kwd = '0';
    else if (kwd !== '') {
      alert("긴급구출여부는 '신청' 또는 '미신청'으로 입력해주세요.");
      kwdEl && kwdEl.focus();
      throw new Error('invalid rescuedApply kwd'); // 잘못된 값이면 중단
    }
  }
  params.set('kwd', kwd);

  // 진행상태는 항상 최신 드롭다운 값으로 강제 반영
  if (stateSel) params.set('state', stateSel.value);

  return { f, params, kwdEl, stateSel };
}

// 검색 실행(버튼/엔터)
function searchList() {
  try {
    const { f, params } = buildSearchParams();

    // 새 검색은 보통 1페이지부터
    params.delete('page');

    location.href = f.action + '?' + params.toString();
  } catch (e) {
    // 위에서 invalid 처리 시 여기로 옴 (아무 것도 하지 않음)
  }
}

// 진행상태 변경 시에도 현재 검색조건 유지하여 재조회
(function () {
  const { stateSel } = buildSearchParams();
  if (!stateSel) return;

  // 서버 값으로 초기 동기화(있으면)
  try { stateSel.value = '${state}'; } catch (e) {}

  stateSel.addEventListener('change', function () {
    const { f, params } = buildSearchParams();

    // 상태 바꾸면 1페이지부터 (유지 원하면 삭제)
    params.delete('page');

    location.href = f.action + '?' + params.toString();
  });
})();

function changeOk() {
  // 1) 선택된 체크박스 수집
  const checked = Array.from(document.querySelectorAll('.row-check:checked'));
  if (checked.length === 0) { alert('변경할 항목을 하나 이상 선택하세요.'); return; }

  // 2) 현재 화면의 상태(state 드롭다운)를 보고 목표 상태 결정
  //    state==2 화면이면 4로, state==4 화면이면 2로 바꿔줌
  const viewState = document.getElementById('state')?.value;
  const targetState = (viewState === '2') ? 4 : 2;

  const msg = checked.length + '건을 ' + (targetState === 4 ? '배송시작' : '배송대기') + ' 상태로 변경할까요?';
  if (!confirm(msg)) return;

  // 3) 숨은 폼에 값 채우기
  const form = document.getElementById('batchForm');

  // 이전에 남아있을 수 있는 히든들 제거
  form.querySelectorAll('input[name="supplyNums"]').forEach(n => n.remove());
  form.querySelectorAll('.__keep').forEach(n => n.remove());

  // targetState 설정
  form.querySelector('input[name="targetState"]').value = targetState;

  // 선택 supplyNum 들 부착
  checked.forEach(ch => {
    const hid = document.createElement('input');
    hid.type = 'hidden';
    hid.name = 'supplyNums';   // 컨트롤러에서 List<Long>로 받음
    hid.value = ch.value;      // = supplyNum
    form.appendChild(hid);
  });

  // 현재 필터/페이지 상태를 함께 전송(리다이렉트 시 원래 화면 유지)
  // buildSearchParams()가 이미 페이지에 있으니 재사용
  const { params } = buildSearchParams();
  ['page','schType','kwd','state'].forEach(k => {
    const v = params.get(k);
    if (v != null) {
      const hid = document.createElement('input');
      hid.type = 'hidden';
      hid.name = k;
      hid.value = v;
      hid.className = '__keep';
      form.appendChild(hid);
    }
  });

  // 4) 전송
  form.submit();
}
</script>
</body>
</html>