// ================== 모달 오픈/정리 ==================
(function () {
  loadSelectProducts("/api/products/normal");

  var modalEl = document.getElementById('productSelectModal');
  var trigger = document.querySelector('.subcart .addline');

  if (!modalEl || !trigger || typeof bootstrap === 'undefined') return;

  var modal = new bootstrap.Modal(modalEl, {
    backdrop: true,
    keyboard: true
  });
  let instance = null; 

  // 모달 표시
  trigger.addEventListener('click', function (e) {
    e.preventDefault();
    modal.show();
  });
  
  // 모달 닫힐 때 정리
  modalEl.addEventListener('hidden.bs.modal', function () {
    if (instance && typeof instance.destroy === 'function') instance.destroy();
    instance = null;
    // 닫힐 때도 칩바 초기화:
    // if (typeof window.clearPickedBar === 'function') window.clearPickedBar();
  });
})();



(function () {
  // 추가상품 컨테이너/템플릿
  var wrap = document.getElementById('extraItems');    
  var tpl  = document.getElementById('tplExtraItem');   

  // hidden 값 가져오기
  function getValue(card, name) {
    var el = card.querySelector('input[name="' + name + '"]');
    return el ? el.value : '';
  }

  function readHidden(btnEl) {
    var card = (btnEl && (btnEl.closest('.card-product') || btnEl.closest('.card'))) || document;

    var name  = getValue(card, 'productName');
    var unit  = getValue(card, 'unit');
    var price = getValue(card, 'unitPrice');
    var stock = getValue(card, 'stockQuantity');
    var thumb = getValue(card, 'thumbnail');
	
	/*
    if (!name) {
      var nameEl = card.querySelector('.card-product__title a, .card-product__title, .fw-semibold');
      name = (nameEl && nameEl.textContent || '').trim();
    }
	*/

    var ctx    = window.contextPath || '';
    var domImg = card.querySelector('.card-product__img img, img.card-img, img');
    var imgSrc = thumb ? (ctx + '/uploads/product/' + thumb)
      : (domImg ? domImg.getAttribute('src') : (ctx + '/dist/images/product/product1.png'));

    return { name: name, unit: unit, price: price, stock: stock, imgSrc: imgSrc };
  }

  
  function findRendered(id) {
    return wrap && wrap.querySelector('.subcart-item[data-id="' + id + '"]');
  }

  
  function fmtKR(n) {
    return Number(n || 0).toLocaleString('ko-KR') + ' 원';
  }

  $(document).on('click', '.btn-cart', function() {
   const btnEl = this;
   const productNum = this.closest('.card-product').getAttribute('data-product-num');

   var bar = document.getElementById('pickedBar');
    if (!bar) return;

    var id = String(productNum);
	
	// 선택 중복시 처리
    var exists = bar.querySelector('.picked-chip[data-id="' + id + '"]');
    if (exists) {
      exists.classList.remove('pulse'); void exists.offsetWidth; exists.classList.add('pulse');
      try { exists.scrollIntoView({ inline: 'end', block: 'nearest', behavior: 'smooth' }); } catch (e) {}
      return;
    }

    var info = readHidden(btnEl);

    // placeholder 제거
    var empty = bar.querySelector('.picked-empty');
    if (empty) empty.remove();

    // 칩 생성 + data
    var chip = document.createElement('div');
    chip.className = 'picked-chip';
    chip.setAttribute('data-id', id);
    chip.setAttribute('data-name', (info.name || '').replace(/</g, '&lt;').replace(/>/g, '&gt;'));
	
    if (info.unit)  chip.setAttribute('data-unit', info.unit);
    if (info.price) chip.setAttribute('data-price', info.price);
    if (info.stock) chip.setAttribute('data-stock', info.stock);
    if (info.imgSrc) chip.setAttribute('data-img', info.imgSrc);

    var html = '';
    if (info.imgSrc) html += '<img src="' + info.imgSrc + '" alt="">';
    html += '<span class="name">' + chip.getAttribute('data-name') + (info.unit ? ' ' + info.unit : '') + '</span>';
    html += '<button class="remove" aria-label="삭제">&times;</button>';
    chip.innerHTML = html;
	

    // 삭제 버튼
    chip.querySelector('.remove').addEventListener('click', function () {
      chip.remove();
      if (!bar.querySelector('.picked-chip')) {
        var span = document.createElement('span');
        span.className = 'picked-empty text-muted';
        span.textContent = '선택한 상품이 여기에 표시됩니다.';
        bar.appendChild(span);
      }
    });

    bar.appendChild(chip);
    bar.scrollLeft = bar.scrollWidth;

  });

  // 모달푸터에 담겨있던 칩바 추가상품에 이동
  function renderExtrasFromChips() {
    if (!wrap || !tpl) return;
    var bar = document.getElementById('pickedBar');
    if (!bar) return;

    var chips = bar.querySelectorAll('.picked-chip[data-id]');
    let chipPrice = 0 ;
    let won = priceSeparation();
    chips.forEach(function (chip) {
      var id = chip.getAttribute('data-id');
      if (findRendered(id)) return; // 이미 있으면 스킵

      var node = tpl.content.firstElementChild.cloneNode(true);

      var img   = node.querySelector('.thumb');
      var name  = node.querySelector('.name');
      var price = node.querySelector('.price');
      

      var nm   = chip.getAttribute('data-name') || '';
      var unit = chip.getAttribute('data-unit') || '';
      var prc  = chip.getAttribute('data-price') || '0';
      var src  = chip.getAttribute('data-img') || '';

      if (src) img.setAttribute('src', src);
      img.setAttribute('alt', nm);
      name.textContent  = nm + (unit ? ' ' + unit : '');
      price.textContent = fmtKR(prc);
	  
	  chipPrice = parseInt(prc.replace(/[^0-9]/g, ''), 10);
	  node.setAttribute('data-price', chipPrice);
	  node.setAttribute('data-id', id);
	  
	  
      wrap.appendChild(node);
   	 won += chipPrice;
    });

    priceUpdate(won);

  }

  

	// 칩바 초기화
  window.clearPickedBar = function () {
    var bar = document.getElementById('pickedBar');
    if (!bar) return;

    // 모든 칩 제거
    var nodes = bar.querySelectorAll('.picked-chip');
    for (var i = 0; i < nodes.length; i++) nodes[i].remove();

    // 플레이스홀더 복원
    if (!bar.querySelector('.picked-empty')) {
      var span = document.createElement('span');
      span.className = 'picked-empty text-muted';
      span.textContent = '선택한 상품이 여기에 표시됩니다.';
      bar.appendChild(span);
    }

    bar.scrollLeft = 0;
  };
 

  // 담기완료
  var confirmBtn = document.getElementById('confirmProducts');
  if (confirmBtn) {
    confirmBtn.addEventListener('click', function () {
      renderExtrasFromChips();
      window.clearPickedBar(); //  초기화
      var modalEl = document.getElementById('productSelectModal');
      var inst = modalEl && bootstrap.Modal.getInstance(modalEl);
      if (inst) inst.hide();

    });
  }
})();
