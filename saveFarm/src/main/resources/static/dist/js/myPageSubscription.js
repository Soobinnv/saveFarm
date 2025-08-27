function renderMySubInfoHtml(data) {
  function toArray(v) {
    if (Object.prototype.toString.call(v) === '[object Array]') return v;
    if (v === null || v === undefined || v === '') return [];
    if (typeof v === 'string') {
      var arr = v.split(',');
      var out = [];
      for (var i = 0; i < arr.length; i++) {
        var s = (arr[i] || '').replace(/^\s+|\s+$/g, '');
        if (s) out.push(s);
      }
      return out;
    }
    return [];
  }
  function n(x, d) {
    if (d === undefined) d = 0;
    var num = Number(x == null ? d : x);
    return isNaN(num) ? d : num;
  }
  function fmt(x) { return n(x, 0).toLocaleString(); }

  var dto  = data && data.dto  ? data.dto  : null; // 상단 카드용
  var list = (data && data.list && Object.prototype.toString.call(data.list) === '[object Array]') ? data.list : []; 

  // 상단: 미이용
  if (!dto || dto.isExtend === 2 || dto.isExtend == null) {
    return '' +
      '<section class="mp-sub-wrap" data-state="empty">' +
      '  <div class="mp-sub-panel mp-sub-panel--empty">' +
      '    <h3 class="mp-sub-title">정기배송 정보</h3>' +
      '    <p class="mp-sub-empty-desc">현재 정기구독 서비스를 사용하고 있지 않아요</p>' +
      '    <button type="button" class="mp-sub-cta" id="btnGoBenefits">정기구독 서비스 혜택 확인하러 가기</button>' +
      '  </div>' +
      '</section>';
  }

  // 상단 이용중
  var hasHome  = dto.homePackageNum  != null && n(dto.homePackageNum)  > 0;
  var hasSalad = dto.saladPackageNum != null && n(dto.saladPackageNum) > 0;
  var packageLabelTop = (hasHome ? '집밥 패키지' : '') + (hasHome && hasSalad ? ' + ' : '') + (hasSalad ? '샐러드 패키지' : '');
  if (!packageLabelTop) packageLabelTop = '-';

  var packagePriceTop = fmt(dto.packagePrice);
  var subMonthLabel   = dto.subMonth ? ( dto.subMonth + '개월차') : '월 -개월차';
  var payMethod       = dto.payMethod || '-';
  var monthlyTotalTop = fmt(dto.totalPay);

  // 상단 - 추가구매 렌더링
  var productNums_top = toArray(dto.productNums);
  var counts_top      = toArray(dto.counts);
  for (var i1=0;i1<counts_top.length;i1++) counts_top[i1] = n(counts_top[i1],1);
  var itemPrices_top  = toArray(dto.itemPrices);
  for (var i2=0;i2<itemPrices_top.length;i2++) itemPrices_top[i2] = n(itemPrices_top[i2],0);
  var names_top       = toArray(dto.productNames);
  var imgs_top        = toArray(dto.mainImageFileNames);
  var reviewExists	  = dto.reviewExists;

  var unit_top = [];
  for (var i3=0;i3<productNums_top.length;i3++) {
    var price = itemPrices_top[i3] || 0;
    var qty   = counts_top[i3] || 1;
    unit_top[i3] = (qty > 0 && price % qty === 0) ? (price/qty) : price;
  }

  var addonsTopHtml = '';
  if (!productNums_top.length) {
    addonsTopHtml = '<li class="mp-sub-empty">추가구매 품목이 없어요.</li>';
  } else {
    for (var i4=0;i4<productNums_top.length;i4++) {
      var p    = productNums_top[i4];
      var name = names_top[i4] || ('상품번호 ' + p);
      var img  = imgs_top[i4]  || ((window.contextPath || '') + '/dist/images/noimage.png');
      var qty  = counts_top[i4] || 1;
      var up   = unit_top[i4]   || 0;
      var line = up * qty;
      addonsTopHtml += ''
        + '<li class="mp-sub-addon">'
        +   '<img class="mp-sub-addon__thumb" src='+contextPath+'"/uploads/product/' + img + '" alt="' + name + '">'
        +   '<div class="mp-sub-addon__info">'
        +     '<div class="mp-sub-addon__name">' + name + '</div>'
        +     '<div class="mp-sub-addon__meta">'
        +       '수량 <strong>' + qty + '</strong> · 단가 <strong>' + fmt(up) + '</strong>원 · 금액 <strong>' + fmt(line) + '</strong>원'
        +     '</div>'
        +   '</div>'
        + '</li>';
    }
  }
  
  
  function updatesubInfo(subNum){
	location.href = contextPath+'/package/updateSubItem?subNum='+subNum;
  };
  
  function quitInfo(){
  		const f	= document.changesubInfo;
		f.action = contextPath+'/package/quitSubscribe';
		f.method = 'post';
		f.submit();
   };

  var infoHtml = ''
    + '<section class="mp-sub-wrap" data-state="active">'
    + '  <div class="mp-sub-panel">'
    + '    <h3 class="mp-sub-title">정기배송 정보</h3>'
    + '    <div class="mp-sub-block">'
    + '      <div class="mp-sub-block__title">구독중인 패키지</div>'
    + '      <div class="mp-sub-card">'
    + '        <div class="mp-sub-card__body">'
    + '          <div class="mp-sub-card__name">' + packageLabelTop + '</div>'
    + '          <div class="mp-sub-card__meta">' + subMonthLabel + ' · 결제수단: ' + payMethod + '</div>'
    + '          <div class="mp-sub-card__price">' + packagePriceTop + '원</div>'
    + '        </div>'
    + '      </div>'
    + '    </div>'
    + '    <div class="mp-sub-block">'
    + '      <div class="mp-sub-block__title">추가구매 상품</div>'
    + '      <ul class="mp-sub-addons">' + addonsTopHtml + '</ul>'
    + '    </div>'
    + '    <div class="mp-sub-bottom">'
    + '      <div class="mp-sub-total">월 결제 : <strong>' + monthlyTotalTop + '</strong>원</div>'
    + '      <div class="mp-sub-actions">'
	+ '  <a class="mp-sub-btn mp-sub-btn--primary" '
	+ '     href="' + contextPath + '/package/updateSubItem?subNum=' + dto.subNum + '">'
	+ '     정기구독 품목변경</a>'
	+ '  <form method="post" action="' + contextPath + '/package/quitSubscribe" name="changesubInfo">'
	+ '    <input type="hidden" name="subNum" value="' + dto.subNum + '">'
	+ '    <button type="submit" class="mp-sub-btn mp-sub-btn--danger">정기구독 그만두기</button>'
	+ '  </form>'
	+ '      </div>'
    + '    </div>'
    + '  </div>'
    + '</section>';

  // 하단: 정기배송 내역
  var historyBody = '';
  if (!list.length) {
    historyBody = '<div class="text-muted">내역이 없습니다.</div>';
  } else {
    for (var j = 0; j < list.length; j++) {
      var row = list[j];

      var rHasHome  = row.homePackageNum  != null && n(row.homePackageNum)  > 0;
      var rHasSalad = row.saladPackageNum != null && n(row.saladPackageNum) > 0;
      var pkgLabel  = (rHasHome ? '집밥 패키지' : '') + (rHasHome && rHasSalad ? ' + ' : '') + (rHasSalad ? '샐러드 패키지' : '');
      if (!pkgLabel) pkgLabel = '-';

      var total   = fmt(row.totalPay);
      var subNum  = row.subNum || '-';
      var payDate = row.payDate || '-';

      var pns   = toArray(row.productNums);
      var cnts  = toArray(row.counts);
      for (var k=0;k<cnts.length;k++) cnts[k] = n(cnts[k],1);
      var ips   = toArray(row.itemPrices);
      for (var k2=0;k2<ips.length;k2++) ips[k2] = n(ips[k2],0);
      var names = toArray(row.productNames);
      var imgs  = toArray(row.mainImageFileNames);

      var unit  = [];
      for (var k3=0;k3<pns.length;k3++) {
        var price2 = ips[k3] || 0, qty2 = cnts[k3] || 1;
        unit[k3] = (qty2 > 0 && price2 % qty2 === 0) ? (price2/qty2) : price2;
      }

      var addons;
      if (pns.length) {
        var out = '<div class="mb-2"><strong>추가구매 품목</strong></div><ul class="mp-sub-addons">';
        for (var m=0;m<pns.length;m++) {
          var pp   = pns[m];
          var nm   = (names && names[m]) ? names[m] : ('상품번호 ' + pp);
          var im   = (imgs  && imgs[m])  ? imgs[m]  : (contextPath + '/dist/images/noimage.png');
          var qv   = cnts[m] || 1;
          var upv  = unit[m] || 0;
          var line = upv * qv;
		  var btnText;
		  var rExists = Number(row.reviewExists || 0);
		  var subNumHidden = '<input type="hidden" name="subNum" value="'+row.subNum+'">';
		  var subMonthHidden = '<input type="hidden" name="subMonth" value="'+dto.subMonth+'">';
		  
		  if (rExists === 0) {
		    // 리뷰 없음 → 작성
		    btnText =
		      '<form method="get" action="' + contextPath + '/package/reviewWriteForm">' +
		        subNumHidden +
		        subMonthHidden +
		        '<input type="hidden" name="mode" value="write">' +
		        '<button type="submit" class="mp-sub-btn mp-sub-btn--ghost">리뷰작성하기</button>' +
		      '</form>';
		  } else {
		    // 리뷰 있음 → 수정
		    btnText =
		      '<form method="post" action="' + contextPath + '/package/reviewUpdateForm">' +
		        subMonthHidden +
		        subNumHidden +
		        '<input type="hidden" name="mode" value="update">' +
		        '<button type="submit" class="mp-sub-btn mp-sub-btn--ghost">리뷰수정하기</button>' +
		      '</form>';
		  }

          out += ''
            + '<li class="mp-sub-addon">'
            +   '<img class="mp-sub-addon__thumb" src='+contextPath+'"/uploads/product/' + im + '" alt="' + nm + '">'
            +   '<div class="mp-sub-addon__info">'
            +     '<div class="mp-sub-addon__name">' + nm + '</div>'
            +     '<div class="mp-sub-addon__meta">'
            +       '수량 <strong>' + qv + '</strong>'
            +       ' · 단가 <strong>' + fmt(upv) + '</strong>원'
            +       ' · 금액 <strong>' + fmt(line) + '</strong>원'
            +     '</div>'
            +   '</div>'
            + '</li>';
        }
        out += '</ul>';
        addons = out;
      } else {
        addons = '<div class="text-muted small">추가구매 품목이 없습니다.</div>';
      }

      historyBody += ''
        + '<div class="rounded-4 p-3 mb-3" style="background:#f8fbf9;border:1px solid #e5efe9;">'
        +   '<div class="mb-2"><strong>정기배송 번호</strong> : ' + subNum + '</div>'
        +   '<div class="mb-2"><strong>결제일</strong> : ' + payDate + '</div>'
        +   '<div class="mb-2"><strong>패키지명</strong> : ' + pkgLabel + '</div>'
        +   '<div class="mb-2"><strong>월 결제금액</strong> : ' + total + '원</div>'
        +   addons
        +   '<div class="d-flex justify-content-end mt-2">'
		+ 		btnText
        +   '</div>'
        + '</div>';
    }
  }

  var historyHtml = ''
    + '<section class="container my-5">'
    + '  <div class="subcart mx-auto shadow-sm rounded-4 p-4 p-md-5">'
    + '    <h6 class="fw-bold mb-3">정기배송 내역</h6>'
    +       historyBody
    + '  </div>'
    + '</section>';

  // 상단 + 하단 반환
  return infoHtml + historyHtml;
}