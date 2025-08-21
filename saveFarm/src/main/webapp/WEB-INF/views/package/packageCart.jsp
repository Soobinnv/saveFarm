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

/* 그린 버튼 */
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


.picked-chip.pulse{ animation:pulse-bg .4s ease-out; }
@keyframes pulse-bg{ from{ box-shadow:0 0 0 0 rgba(3,154,99,.35);} to{ box-shadow:0 0 0 12px rgba(3,154,99,0);} }

.subcart-item .remove-btn {
  border: none;
  background: transparent;
  font-size: 20px;
  color: #666;
  margin-left: 8px;
  cursor: pointer;
  line-height: 1;
  padding: 0;
  transition: color 0.2s ease;
}
.subcart-item .remove-btn:hover {
  color: #d32f2f; /* hover 시 레드 톤 */
}
.step-pill{
  border:1px solid #e5efe9; background:#fff; padding:.5rem .875rem;
  border-radius:999px; font-weight:600; font-size:.95rem; color:#666;
}
.step-pill.active{ background:#039a63; color:#fff; border-color:#039a63; }

.pay-select .pay-trigger{
  display:flex; justify-content:space-between; align-items:center;
  border:1px solid #e5e7eb; background:#fff; padding:.75rem 1rem; border-radius:12px;
}
.pay-select .pay-menu{
  margin-top:.5rem; background:#fff; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden;
}
.pay-select .pay-option{
  display:block; width:100%; text-align:left; padding:.75rem 1rem; background:#fff; border:0;
}
.pay-select .pay-option:hover{ background:#f7f7f7; }


</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
	
<!-- Subscription Cart -->
<div class="container my-5">
	<div class="step-nav d-flex justify-content-center gap-3 mb-4">
	  <button type="button" class="step-pill active" data-step="1">Step1 상품고르기</button>
	  <button type="button" class="step-pill" data-step="2">Step2 결제정보입력</button>
	  <button type="button" class="step-pill" data-step="3">Step3 정기배송지 입력</button>
	</div>
	
	<div class="step-panel d-none step1" data-step="1">
	  <div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5 cart-area">
	    <h5 class="text-center mb-4 fw-bold">정기결제 바구니</h5>
	
	    <!-- 아이템 1 : 패키지 -->
		 <div class="packageArea">
	    	<div class="subcart-item d-flex align-items-center gap-3 rounded-4 p-3 mb-3">
				<img src="${pageContext.request.contextPath}/dist/images/veggie-box-${mode == 'homePackage' ? '1' : '2' }.png" alt="세이브 패키지"
				class="rounded-3 object-fit-cover" style="width:110px;height:75px;">
				<div class="flex-grow-1">
					<div class="fw-semibold">${mode == 'homePackage' ? '집밥 세이브 패키지' : '셀러드 세이브 패키지' }</div>
					<small class="text-muted">${mode == 'homePackage' ? '18,000 원' : '20,000 원' }</small>
				</div>
			</div>
	
			<!-- 패키지 추가 CTA -->
			<a href="#" onclick="addPackage('${mode}');" class="btn btnGreen w-100 rounded-pill py-2 mb-3">${mode == 'homePackage' ? '샐러드 세이브 패키지도 담기' : '집밥 세이브 패키지도 담기' }</a>
		</div>
	 	<!-- 추가 상품 영역 -->
	   	<div id="extraItems" class="mt-3"></div>
	
	    
	    <button class="btn addline w-100 rounded-pill py-2 mb-3">
	      <span class="me-1">＋</span> 정기결제 상품 추가
	    </button>
	
	    
	    <div class="d-flex justify-content-end align-items-center mt-2">
	      <div class="fs-6"><span class="text-muted me-2">총합계 :</span><strong class="totalPrice"></strong></div>
	    </div>
	  </div>
	
	 
	  <a href="#" class="btn btnGreen btn-lg d-block mx-auto rounded-pill py-3 mt-4"
   		style="max-width:680px; width:100%;" data-goto="2">
  		결제정보 입력하기
	</a>
	</div>
</div>


<!-- 추가상품 선택 모달 -->
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
        
        <template id="tplExtraItem">
		  <div class="subcart-item d-flex align-items-center gap-3 rounded-4 p-3 mb-3 extra-item" data-price="0">
		    <img class="thumb rounded-3 object-fit-cover" src="" alt="" style="width:110px;height:75px;">
		    <div class="flex-grow-1">
		      <div class="fw-semibold name"></div>
		      <small class="text-muted price"></small>
		    </div>
		    <div class="qtybox d-flex align-items-center gap-2">
			  <button class="btn qty-btn btn-minus" type="button" >−</button>
			  <p class="quantity m-0" data-stock="10" data-quantity="1">1</p>
			  <button class="btn qty-btn btn-plus" type="button" >＋</button>
			</div>
      		<button type="button" class="remove-btn" aria-label="삭제">×</button>
		  </div>
		</template>
		
  		
        <div class="text-center py-4 d-none" data-role="loading">
          <div class="spinner-border" role="status" aria-hidden="true"></div>
          <div class="mt-2">불러오는 중…</div>
        </div>
      </div>
      <div class="modal-footer">
		  <div id="pickedBar" class="picked-bar" aria-live="polite">
		    <span class="picked-empty text-muted">선택한 상품이 여기에 표시됩니다.</span>
		  </div>
      
        <button type="button" class="btn addline" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btnGreen" id="confirmProducts" onclick="">담기 완료</button>
      </div>
    </div>
  </div>
  </div>

<div class="step-panel d-none" data-step="2">
	<div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5">
    <h6 class="text-center mb-4 fw-bold">결제 정보</h6>

    <!-- 결제일 선택 -->
    <div class="mb-4">
      <label class="form-label fw-semibold">정기 결제 시작날짜</label>
      <input type="date" class="form-control" name="billingDate" />
      <div class="form-text">매월 위 날짜에 자동결제됩니다.</div>
    </div>

    <!-- 결제수단 -->
    <div class="mb-4">
      <label class="form-label fw-semibold">결제 수단</label>

      <div class="pay-select" data-role="paySelect">
        <button class="pay-trigger w-100" type="button" aria-expanded="false">
          <span class="selected-text">결제수단을 선택하세요</span>
          <span class="caret">▾</span>
        </button>

        <div class="pay-menu shadow-sm rounded-3 d-none">
          <button type="button" class="pay-option" data-value="CARD">카드 결제</button>
          <button type="button" class="pay-option" data-value="EASY">간편 결제</button>
          <button type="button" class="pay-option" data-value="ACCOUNT">계좌 결제</button>
        </div>
      </div>
    </div>

    
  </div>
	<a href="#" class="btn btnGreen btn-lg d-block mx-auto rounded-pill py-3 mt-4"
	style="max-width:680px; width:100%;" data-goto="3">
		배송지 입력하기
	</a>

  </div>
<form name="payForm">
  <div class="step-panel d-none" data-step="3">
  <div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5">
    <h6 class="text-center mb-4 fw-bold">정기 배송지 입력</h6>

    <div class="row g-3">
      <div class="col-md-6">
        <label class="form-label">수령인</label>
        <input type="text" class="form-control" name="receiverName"/>
      </div>
      <div class="col-md-6">
        <label class="form-label">연락처</label>
        <input type="text" class="form-control" name="receiverPhone" placeholder="010-0000-0000"/>
      </div>
      <div class="col-12">
        <label class="form-label">주소</label>
        <input type="text" class="form-control mb-2" name="addr1" placeholder="도로명 주소"/>
        <input type="text" class="form-control" name="addr2" placeholder="상세 주소"/>
      </div>
    </div>

    <div class="d-flex justify-content-end mt-4">
      <div class="fs-6"><span class="text-muted me-2">총합계 :</span><strong class="totalPrice"></strong></div>
    </div>
  </div>
 
  <input type="hidden" name="payDate" id="payDate">
  <input type="hidden" name="payMethod" id="payMethod">
  <input type="hidden" name="totalPay" id="totalPay">
  <input type="hidden" name="homePackageNum" id="homePackageNum">
  <input type="hidden" name="packagePrice" id="packagePrice">
  <input type="hidden" name="saladPackageNum" id="saladPackageNum">
  <input type="hidden" name="receiver" id="receiver">
  <input type="hidden" name="tel" id="tel">
  <input type="hidden" name="zip" id="zip">
  <input type="hidden" name="addr" id="addr">
  <input type="hidden" name="productNums" id="productNums">
  <input type="hidden" name="itemPrices" id="itemPrices">
  <input type="hidden" name="counts" id="counts">
  
  
  <button type="button" class="btn btnGreen btn-lg d-block mx-auto rounded-pill py-3 mt-4"
        style="max-width:680px; width:100%;" onclick="sendOk();">
  정기구독 결제
</button>
</div>
</form>
<script type="text/javascript">
(function () {
    var cp = '<c:url value="/"/>';        
    cp = cp.replace(/\/$/, '');           
    window.contextPath = cp;
  })();

    // 가격 숫자만 분리 
  function priceSeparation(){
    let won =  $('.step1 .totalPrice').text();
    let num = parseInt(won.replace(/[^0-9]/g, ''), 10);
    return num;
  }
   

  // 가격+원
  function priceUpdate(won){
    $('.totalPrice').text(won+'원');
  }

  
  // 로딩시 Package가격으로 total 설정
  $(function(){
     var price = ${price};
    priceUpdate(price);
    document.getElementById('packagePrice').value = ${price};
    $('#homePackageNum').val(0);      
    $('#saladPackageNum').val(0);

    if ('${mode}' === 'homePackage') {
      $('#homePackageNum').val(1);   
    } else {
      $('#saladPackageNum').val(7);  
    }
  });


  // 패키지 추가 버튼
  function addPackage(mode){
	let out = `
		<div class="subcart-item d-flex align-items-center gap-3 rounded-4 p-3 mb-3">
			<img src="${pageContext.request.contextPath}/dist/images/veggie-box-${mode == 'homePackage' ? '2' : '1' }.png" alt="세이브 패키지"
				class="rounded-3 object-fit-cover" style="width:110px;height:75px;">
			<div class="flex-grow-1">
				<div class="fw-semibold">${mode == 'homePackage' ? '셀러드 세이브 패키지': '집밥 세이브 패키지' }</div>
				<small class="text-muted">${mode == 'homePackage' ? '20,000 원' : '18,000 원' }</small>
			</div>
			<button type="button" class="remove-btn" aria-label="삭제">×</button>
		</div>
	`;
	const packageArea = $('.packageArea');
	packageArea.children('a.btn.btnGreen').hide();
  let won = priceSeparation();
  

  // 총가격 부분 업데이트
  if(mode == 'homePackage'){
    won += 20000; 
    document.getElementById('saladPackageNum').value = 7;
  }else{
    won += 18000;
    document.getElementById('homePackageNum').value = 1;
  }
  priceUpdate(won);
  document.getElementById('packagePrice').value = won;
  
  packageArea.append(out);
}
  
  $(document).on('click', '.remove-btn', function(){
	  let $item = $(this).closest('.subcart-item');
	  let packagePrice = document.getElementById('packagePrice').value;
    let won = priceSeparation(); 

	  if ($item.closest('.packageArea').length) {
	    // 패키지 추가 버튼 재 활성화
	    const packageArea = $('.packageArea');
	 	  packageArea.children('a.btn.btnGreen').show();
      document.getElementById('packagePrice').value =  ${mode == 'homePackage'} ? packagePrice - 20000 : packagePrice - 18000;
      ${mode == 'homePackage'} ? document.getElementById('saladPackageNum').value = 0 : document.getElementById('homePackageNum').value = 0; 
 
      won -= ${mode == 'homePackage'} ? 20000 : 18000;

	  }else{
      let priceText = $item.find('.text-muted').text();
      let unitPrice = parseInt($item.data('price'), 10);
      let quantity = parseInt($item.find('.quantity').text() || "1", 10);
      
      won -=  unitPrice * quantity;
    }

	   
	    
	   priceUpdate(won);


	  $item.remove();
	   
	 });
   
  $(document).on('click', '.qty-btn', function() {
	  let $item = $(this).closest('.subcart-item');
	  let unitPrice = parseInt($item.data('price'), 10);
	  let qty = parseInt($item.find('.quantity').text(),10);
	  let won = priceSeparation();
	  let $quantity = $(this).closest('div').find('.quantity');
	  let quantity = Number($quantity.text());
	  let stock = $quantity.data('stock');
	  
	  if ($(this).hasClass('btn-plus')) {
	    if(quantity < stock) {
			$quantity.text(quantity + 1);
			
			// 구매 개수 변경	
			$quantity.attr('data-quantity', quantity + 1);	
		    won += unitPrice;
		}
	  } else if (qty > 1) {
		  if(quantity > 1) {
			$quantity.text(quantity - 1);
				
				// 구매 개수 변경
			$quantity.attr('data-quantity', quantity - 1);					
		  	won -= unitPrice;
		}
	  }
	  priceUpdate(won);
});

(function(){
  let current = 1;

  function showStep(n){
    current = n;
    document.querySelectorAll('.step-panel').forEach(p=>{
      p.classList.toggle('d-none', p.dataset.step != n);
    });
    document.querySelectorAll('.step-pill').forEach(p=>{
      p.classList.toggle('active', p.dataset.step == n);
    });
  }

  // 초기 1단계
  showStep(1);

  // 상단 스텝 pill 클릭도 유지
  document.querySelectorAll('.step-pill').forEach(btn=>{
    btn.addEventListener('click', ()=> showStep(+btn.dataset.step));
  });


  document.addEventListener('click', function(e){
    const go = e.target.closest('[data-goto]');
    if(!go) return;
    e.preventDefault();
    const step = parseInt(go.dataset.goto, 10);
    if(step>=1 && step<=3) showStep(step);
  });
//드롭다운 열기/닫기
  $(document).on('click', '[data-role="paySelect"] .pay-trigger', function (e) {
    e.preventDefault();
    const $wrap = $(this).closest('[data-role="paySelect"]');
    const $menu = $wrap.find('.pay-menu');
    const isOpen = $(this).attr('aria-expanded') === 'true';

    $(this).attr('aria-expanded', String(!isOpen));
    $menu.toggleClass('d-none', isOpen === true);
  });

  // 옵션 선택
  $(document).on('click','[data-role="paySelect"] .pay-option', function(){
  const $wrap = $(this).closest('[data-role="paySelect"]');
  const text  = $(this).text().trim();          
  const value = $(this).data('value');         

  $wrap.find('.selected-text').text(text);
  $('#payMethod').val(value);                   
  let payMethod = $('#payMethod').val();
  $wrap.find('.pay-menu').addClass('d-none');
  $wrap.find('.pay-trigger').attr('aria-expanded','false');
  
  console.log('payMethod = '+payMethod);
  
});

  // 바깥 클릭 시 닫기
  $(document).on('click', function (e) {
    if ($(e.target).closest('[data-role="paySelect"]').length) return;
    $('[data-role="paySelect"] .pay-menu').addClass('d-none');
    $('[data-role="paySelect"] .pay-trigger').attr('aria-expanded', 'false');
  });
  
})();

function loadSelectProducts(url, params = '') {
	url = contextPath + url;
	
	const fn = function(data){
		// 상품
		const productHtml = renderProductListHtml(data);
		$('#productLayout').html(productHtml);
	}
	
	ajaxRequest(url, 'get', params, 'json', fn);
}

//최종 제출
function sendOk(){
  const f = document.payForm;

  
  const payDate   = document.querySelector('input[name="billingDate"]')?.value || '';
  const payMethod = document.getElementById('payMethod').value || '';
  document.getElementById('payDate').value   = payDate;
  document.getElementById('payMethod').value = payMethod;
  
 
  /* 2) 총 결제금액(숫자만) */
  const totalTxt = document.querySelector('.step1 .totalPrice')?.textContent || '0';
  const totalPay = parseInt(totalTxt.replace(/[^\d]/g,''),10) || 0;
  document.getElementById('totalPay').value = totalPay;
 

  /* 4) 추가상품 리스트 */
  const productNums = [];
  const itemPrices  = [];
  const counts      = [];

  document.querySelectorAll('#extraItems .extra-item').forEach(item=>{
    const pn   = item.getAttribute('data-id') || '';
    const qty  = parseInt(item.querySelector('.quantity')?.textContent||'1',10) || 1;
    const up   = (parseInt(item.getAttribute('data-price')||'0',10)) * qty ; 

    if(pn){
      productNums.push(pn);
      itemPrices.push(up);
      counts.push(qty);
    }
  });

  document.getElementById('productNums').value = productNums;
  document.getElementById('itemPrices').value  = itemPrices;
  document.getElementById('counts').value      = counts;

  /*배송지 */
  const receiver = document.querySelector('input[name="receiverName"]')?.value.trim() || '';
  const tel      = document.querySelector('input[name="receiverPhone"]')?.value.trim() || '';
  const addr1    = document.querySelector('input[name="addr1"]')?.value.trim() || '';
  const addr2    = document.querySelector('input[name="addr2"]')?.value.trim() || '';
  document.getElementById('receiver').value = receiver;
  document.getElementById('tel').value      = tel;
  document.getElementById('addr').value     = addr1;
  document.getElementById('zip').value      = addr2;

  
  /* 6) 제출 */
  f.action = '${pageContext.request.contextPath}/package/payForm';
  f.method = 'post';
  f.submit();
}

</script>





<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/productList.js"></script>
<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js/packageCartModal.js"></script>



</body>
</html>