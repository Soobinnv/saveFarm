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
:root { --accent-color:#116530; }

/* 모달 안 버튼 래퍼 */
#registerModal .sf-actions, #detailModal .sf-actions{
  display:flex; justify-content:flex-end; gap:12px; flex-wrap:wrap; margin-top:12px;
}

/* 모달 안 버튼 공통 */
#registerModal .sf-btn, #detailModal .sf-btn{
  padding:10px 20px; border-radius:4px; font-weight:600; line-height:1.2;
  border:1px solid transparent;
  transition:background-color .18s ease, color .18s ease,
             border-color .18s ease, box-shadow .18s ease, transform .02s ease-in;
}

/* 삭제(오렌지) */
#registerModal .sf-btn-danger, #detailModal .sf-btn-danger{
  background:#d24a14 !important; color:#fff !important;
}
#registerModal .sf-btn-danger:hover, #detailModal .sf-btn-danger:hover{
  background:#b43f11 !important; color:#fff !important;
}
#registerModal .sf-btn-danger:focus, #detailModal .sf-btn-danger:focus{
  outline:none; box-shadow:0 0 0 .2rem rgba(210,74,20,.25);
}
#registerModal .sf-btn-danger:active, #detailModal .sf-btn-danger:active{
  transform:translateY(1px);
}

/* 아웃라인 초록 */
#registerModal .sf-btn-outline, #detailModal .sf-btn-outline{
  background:#fff; color:var(--accent-color); border:1px solid var(--accent-color);
}
#registerModal .sf-btn-outline:hover, #detailModal .sf-btn-outline:hover,
#registerModal .sf-btn-outline:focus, #detailModal .sf-btn-outline:focus,
#registerModal .sf-btn-outline:active:hover, #detailModal .sf-btn-outline:active:hover{
  background:#7acb89 !important; border-color:#58b368 !important; color:#fff !important;
}
#registerModal .sf-btn-outline:focus, #detailModal .sf-btn-outline:focus{
  outline:none; box-shadow:0 0 0 .2rem rgba(17,101,48,.18);
}
#registerModal .sf-btn-outline:active, #detailModal .sf-btn-outline:active{
  transform:translateY(1px);
}


</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main register-actions">
    <div class="page-title dark-background"  data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/cropsTitle2.webp);">
		<div class="container position-relative">
		<h1>농산물 관리</h1>
		<p>내 창고에 있는 농산물 재고를 등록하고 기록할 수 있는 곳입니다.</p>
		<nav class="breadcrumbs">
			<ol>
				<li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
				<li class="current">농산물</li>
			</ol>
		</nav>
		</div>
    </div>
    
    <section id="comment-form" class="comment-form section" style="margin-top: 50px;">
		<div class="container">
			<div class="row g-2 align-items-end mb-3">
				<div class="col-md-7">
					<span class="small text-muted">
						총 <strong>${dataCount}</strong>건
						<c:if test="${total_page > 0}"> _ <strong>${page}</strong> / ${total_page} 페이지</c:if>
					</span>
				</div>
			</div>  
			
	    	<form name="searchForm" method="get" action="${pageContext.request.contextPath}/farm/crops/list" class="mb-3">
	      		<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제품명</th>
							<th class="text-center">설명</th>
							<th class="text-center">재고량</th>
							<th class="text-center">수확날짜</th>
						</tr>
					 </thead>
				  	<tbody>
						<c:forEach var="dto" items="${list}" varStatus="status">
							<tr class="align-middle" data-detail-src="${pageContext.request.contextPath}/farm/crops/detail?supplyNum=${dto.supplyNum}&modal=1">
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
							
								<td class="text-nowrap text-center">					
									<c:choose>
										<c:when test="${not empty dto.coment}">
											${dto.coment}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
								
								<td class="text-center">${dto.supplyQuantity}</td>
							
								<td class="text-center">
									<c:choose>
										<c:when test="${not empty dto.harvestDate}">
											${dto.harvestDate.substring(0,10)}
										</c:when>
										<c:otherwise>-</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
				  	</tbody>
				</table>
				<div class="page-navigation d-flex justify-content-center my-3 py-5">
					${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
				</div>
	    	
		    	<div class="row mt-3">
					<div class="col-md-2">
						<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/crops/list';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
					</div>
					<div class="col-md-8 d-flex justify-content-center">
						<div class="d-flex gap-2" style="max-width: 420px;">
							<select name="schType" class="form-select form-select-sm">
								<option value="varietyName" ${schType=="varietyName"?"selected":""}>제품명</option>
								<option value="coment" ${schType=="coment"?"selected":""}>'기타'로 작성한 제품명</option>
							</select>
						
							<input type="text" name="kwd" value="${kwd}" class="form-control form-control-sm" placeholder="검색어 입력">
							<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
						</div>
					</div>
					<div class="col-md-2 right">
						<button type="button" class="btn-primary" data-bs-toggle="modal" data-bs-target="#registerModal" data-modal-src="${pageContext.request.contextPath}/farm/crops/write?modal=1">
							등록하기
						</button>
					</div>
				</div>
			</form>
		</div>
	</section><!-- /Comment Form Section -->

	<form id="batchForm" method="post" action="${pageContext.request.contextPath}/farm/crops/list" style="display:none">
		<input type="hidden" name="targetState" value="">
		<c:if test="${not empty _csrf}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</c:if>
	</form>    
</main>

<div class="modal fade" id="registerModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">농산물 관리</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>

      <div class="modal-body p-0">
        <div id="registerModalBody" class="p-3">
          <div class="text-center py-5">불러오는 중…</div>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn-default" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="detailModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">농산물 상세</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body p-0">
        <div id="detailModalBody" class="p-3">
          <div class="text-center py-5">불러오는 중…</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn-default" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
(() => {
  const $  = (sel, root = document) => root.querySelector(sel);
  const contextPath = '${pageContext.request.contextPath}';

  // 오늘 이후 날짜 선택 방지
  function applyTodayMaxDate(inputEl) {
    if (!inputEl) return;
    const t = new Date();
    const today = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    inputEl.setAttribute('max', today);
  }

  // '기타' 선택 시 설명 입력란 열고/닫기 (모달/페이지 어디서든 동작)
  function toggleComent(selectEl) {
    const formRoot = selectEl.closest('form') || document;
    const box   = $('#otherBox', formRoot);
    const input = $('#supplyOther', formRoot);
    if (!box || !input) return;

    if (selectEl.value === '0') {
      box.classList.add('show');
      input.disabled = false;
      input.required = true;
      setTimeout(() => input.focus({ preventScroll: true }), 100);
    } else {
      box.classList.remove('show');
      input.required = false;
      input.disabled = true;
      input.value = '';
    }
  }

  // 작성/수정 제출
  function sendOk() {
    // 1) write 모달 안
    const modalBody = document.getElementById('registerModalBody');
    let f = modalBody?.querySelector('form#insertForm, form[name="insertForm"]');
    // 2) 없으면 현재 페이지 폼
    if (!f) f = document.getElementById('insertForm') || document.forms['insertForm'];

    if (!f) { alert('제출할 폼을 찾을 수 없습니다.'); return false; }

    // 품종 선택
    if (!f.varietyNum?.value) {
      alert('농산물 종류를 선택하세요.');
      f.varietyNum?.focus();
      return false;
    }
    // 기타 선택 시 설명 필수
    if (f.varietyNum.value === '0') {
      const c = (f.coment?.value || '').trim();
      if (!c) {
        alert('기타를 선택하셨습니다. 내용을 입력하세요.');
        f.coment?.focus();
        return false;
      }
    }

    // 숫자 검증(해당 input이 있을 때만 검사)
    const labels = { supplyQuantity: "총 납품량" };
    const numericKeys = ['supplyQuantity'].filter(k => f[k]);
    const numRe = /^[0-9]+(\.[0-9]+)?$/;
    for (const k of numericKeys) {
      const v = (f[k].value || '').trim();
      if (!v) { alert(labels[k] + '를 입력해주세요'); f[k].focus(); return false; }
      if (!numRe.test(v)) { alert(labels[k] + '는 숫자만 입력 가능합니다'); f[k].focus(); return false; }
    }

    // 수확일
    const d = (f.harvestDate?.value || '').trim();
    if (!d) { alert('수확일을 입력하세요.'); f.harvestDate?.focus(); return false; }
    const tmp = document.createElement('input'); tmp.type = 'date'; applyTodayMaxDate(tmp);
    if (d > tmp.getAttribute('max')) { alert('미래 날짜는 입력할 수 없습니다.'); f.harvestDate?.focus(); return false; }

    f.submit();
  }

  // ===== 삭제 관련 유틸 =====
  function setHidden(form, name, value) {
    let el = form.querySelector(`input[name="${name}"]`);
    if (!el) { el = document.createElement('input'); el.type='hidden'; el.name=name; form.appendChild(el); }
    el.value = value ?? '';
    return el;
  }

  function findContextFormForDelete() {
    // 상세 모달 > 수정 모달 > 페이지 폼 > 상세 페이지 폼 순으로 탐색
    const candidates = [
      $('#detailModalBody form[name="registerForm"]'),
      $('#registerModalBody form#insertForm'),
      document.getElementById('insertForm'),
      document.forms['registerForm']
    ].filter(Boolean);

    for (const f of candidates) {
      const sup = f.querySelector('input[name="supplyNum"]');
      if (sup && sup.value) return f;
    }
    return null;
  }

  // 삭제 실행: #batchForm 재활용 (CSRF 포함)
  function deleteOk() {
    const srcForm = findContextFormForDelete();
    if (!srcForm) { alert('삭제할 대상을 찾지 못했습니다.'); return; }

    const supplyNum = srcForm.querySelector('input[name="supplyNum"]')?.value;
    if (!supplyNum) { alert('대상 번호가 없습니다.'); return; }

    if (!confirm('정말 삭제하시겠습니까?\n삭제 후 복구할 수 없습니다.')) return;

    const batch = document.getElementById('batchForm');
    if (!batch) { alert('삭제용 폼이 없습니다(batchForm).'); return; }

    batch.action = contextPath + '/farm/crops/delete';
    setHidden(batch, 'supplyNum', supplyNum);

    // 목록 복귀 파라미터 유지
    const page   = srcForm.querySelector('input[name="page"]')?.value || '${empty page ? 1 : page}';
    const schType= srcForm.querySelector('input[name="schType"]')?.value || '${empty schType ? "all" : schType}';
    const kwd    = srcForm.querySelector('input[name="kwd"]')?.value || '${empty kwd ? "" : kwd}';

    setHidden(batch, 'page', page);
    setHidden(batch, 'schType', schType);
    setHidden(batch, 'kwd', kwd);

    batch.submit();
  }

  // 🔹 등록 모달: show 시 fetch 로드 + 주입 후 바인딩
  function initRegisterModalLoader() {
    const modalEl = document.getElementById('registerModal');
    const bodyBox = document.getElementById('registerModalBody');
    if (!modalEl || !bodyBox) return;

    modalEl.addEventListener('show.bs.modal', async (ev) => {
      const trigger = ev.relatedTarget;
      const url = trigger?.getAttribute('data-modal-src');
      if (!url) {
        bodyBox.innerHTML = '<div class="text-danger p-4">로드 URL이 없습니다(data-modal-src).</div>';
        return;
      }

      bodyBox.innerHTML = '<div class="text-center py-5">불러오는 중…</div>';

      try {
        const res = await fetch(url, { credentials: 'same-origin' });
        if (!res.ok) throw new Error('서버 통신 오류: ' + res.status);
        const html = await res.text();
        bodyBox.innerHTML = html;

        // (1) 날짜 max
        bodyBox.querySelectorAll('input[type="date"]').forEach(applyTodayMaxDate);

        // (2) 기타 토글
        const sel = bodyBox.querySelector('#supplySelect');
        if (sel) {
          sel.addEventListener('change', () => toggleComent(sel));
          toggleComent(sel); // 초기 상태 반영
        }

        // (3) Enter → sendOk
        bodyBox.querySelectorAll('input').forEach(inp => {
          inp.addEventListener('keydown', e => {
            if (e.key === 'Enter') { e.preventDefault(); sendOk(); }
          });
        });

        // (4) partial 내부 data-submit 버튼 처리
        bodyBox.addEventListener('click', (e) => {
          const btn = e.target.closest('[data-submit], .js-modal-submit');
          if (btn) { e.preventDefault(); sendOk(); }
        });

      } catch (e) {
        console.error(e);
        bodyBox.innerHTML = '<div class="text-danger p-4">폼을 불러오지 못했습니다. 잠시 후 다시 시도해주세요.</div>';
      }
    });

    // 닫힐 때 초기화 화면으로 복구
    modalEl.addEventListener('hidden.bs.modal', () => {
      bodyBox.innerHTML = '<div class="text-center py-5">불러오는 중…</div>';
    });
  }

  // 초기화
  document.addEventListener('DOMContentLoaded', () => {
    initRegisterModalLoader();
  });

  // 전역 노출( partial 내 onclick="..." 호환 )
  window.sendOk       = sendOk;
  window.toggleComent = toggleComent;
  window.deleteOk     = deleteOk;
})();

// ====== 상세 보기 모달 로더(테이블 행 클릭) ======
document.addEventListener('DOMContentLoaded', function () {
  const detailModalEl   = document.getElementById('detailModal');
  const detailModalBody = document.getElementById('detailModalBody');
  const bsModal = detailModalEl ? new bootstrap.Modal(detailModalEl) : null;

  document.addEventListener('click', async function (e) {
    const tr = e.target.closest('tr[data-detail-src]');
    if (!tr) return;
    if (!bsModal || !detailModalBody) return;

    // 인터랙티브 요소 클릭시 패스
    if (e.target.closest('input,button,a,select,textarea,label,.no-rowlink')) return;

    const url = tr.getAttribute('data-detail-src');
    if (!url) return;

    detailModalBody.innerHTML = '<div class="text-center py-5">불러오는 중…</div>';
    bsModal.show();

    try {
      const res = await fetch(url, { credentials: 'same-origin' });
      if (!res.ok) throw new Error('상세 로드 실패: ' + res.status);
      const html = await res.text();
      detailModalBody.innerHTML = html;
    } catch (err) {
      console.error(err);
      detailModalBody.innerHTML = '<div class="text-danger p-4">상세를 불러오지 못했습니다.</div>';
    }
  });

  // 모달 닫힐 때 초기화
  detailModalEl?.addEventListener('hidden.bs.modal', function () {
    detailModalBody.innerHTML = '<div class="text-center py-5">불러오는 중…</div>';
  });
});
window.changeToSupply = function () {
    try {
      // 1) 모달 안에서 supplyNum 읽기
      const detailBody = document.getElementById('detailModalBody');
      const formInModal =
        detailBody?.querySelector('form[name="registerForm"], form#registerForm, form');
      const supplyNum = formInModal?.querySelector('input[name="supplyNum"]')?.value;

      if (!supplyNum) { alert('대상 번호(supplyNum)를 찾을 수 없습니다.'); return; }
      if (!confirm('이 재고를 납품으로 전환하시겠습니까?')) return;

      // 2) 숨겨진 배치 폼(#batchForm) 준비 — CSRF는 그대로 두고 나머지 동적 필드만 새로 채움
      const f = document.getElementById('batchForm');
      if (!f) { alert('배치 전송 폼(#batchForm)을 찾을 수 없습니다.'); return; }

      // 이전 잔여 입력 제거(여러 번 눌렀을 때 중복 방지)
      f.querySelectorAll('input[name="supplyNums"],input[name="page"],input[name="schType"],input[name="kwd"],input[name="state"],input[name="rescuedApply"],input[name="productNum"],input[name="varietyNum"],input[name="harvestDate"]').forEach(el => el.remove());

      // 3) 목표 상태값 설정(납품=1)
      const targetStateInput = f.querySelector('input[name="targetState"]');
      if (!targetStateInput) { alert('targetState 필드를 찾을 수 없습니다.'); return; }
      targetStateInput.value = '1';

      // 4) 변경 대상(supplyNums) 추가 — 서버는 List<Long>로 받음
      const addHidden = (name, value) => {
        if (value == null || value === '') return;
        const i = document.createElement('input');
        i.type = 'hidden'; i.name = name; i.value = value; f.appendChild(i);
      };
      addHidden('supplyNums', supplyNum);

      // 5) 현재 화면 필터/페이지 유지값 채우기
      const params = new URLSearchParams(location.search);
      const searchForm = document.forms['searchForm'];

      addHidden('page', params.get('page') || document.querySelector('input[name="page"]')?.value || '1');
      addHidden('schType', (searchForm?.schType?.value) || params.get('schType') || 'all');
      addHidden('kwd', (searchForm?.kwd?.value?.trim()) || params.get('kwd') || '');
      addHidden('state', params.get('state') ?? '0'); // 목록에서 보고 있던 상태 필터 유지
      ['rescuedApply','productNum','varietyNum','harvestDate'].forEach(k => addHidden(k, params.get(k)));

      // 6) 전송
      f.submit();
    } catch (e) {
      console.error(e);
      alert('전환 중 오류가 발생했습니다.');
    }
  };
</script>



</body>
</html>