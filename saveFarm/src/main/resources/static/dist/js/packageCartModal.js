(function(){
	
	  const modalEl = document.getElementById('productSelectModal');
	  const trigger  = document.querySelector('.subcart .addline'); 

	  if (!modalEl || !trigger || typeof bootstrap === 'undefined') return;

	  const modal = new bootstrap.Modal(modalEl, {
	    backdrop: true,
	    keyboard: true
	  });

	 
	  trigger.addEventListener('click', function(e){
	    e.preventDefault();
	    modal.show();
	  });

	  
	  let instance = null;
	  modalEl.addEventListener('shown.bs.modal', function () {
	    if (typeof initModalProductList === 'function') {
	      instance = initModalProductList(modalEl); // 이전에 안내한 모달 스코프 초기화 함수
	    }
	  });

	 
	  modalEl.addEventListener('hidden.bs.modal', function () {
	    if (instance && typeof instance.destroy === 'function') instance.destroy();
	    instance = null;
	  });
	})();
window.addToCart = function(productNum, btnEl){
    const bar = document.getElementById('pickedBar');
    if (!bar) return;

    // 이미 존재하면 추가하지 않고 하이라이트만
    
    var exists = bar.querySelector('.picked-chip[data-id="' + productNum + '"]');
    if (exists){
      exists.classList.remove('pulse');
      void exists.offsetWidth; 
      exists.classList.add('pulse');
      exists.scrollIntoView({ inline: 'end', block: 'nearest', behavior: 'smooth' });
      return;
    }

	
    const card = btnEl?.closest('.card-product') || btnEl?.closest('.card') || document;
    const nameEl = card.querySelector('.card-product__title a, .card-product__title');
    const imgEl  = card.querySelector('.card-product__img img.card-img, .card-product__img img, img.card-img');

    const name = (nameEl?.textContent || '').trim();
    const img  = imgEl?.getAttribute('src') || '';

    bar.querySelector('.picked-empty')?.remove();

    const chip = document.createElement('div');
    chip.className = 'picked-chip';
    chip.dataset.id = String(productNum);
    chip.innerHTML = `
      ${img ? `<img src="${img}" alt="">` : ''}
      <span class="name">${name}</span>
      <button type="button" class="remove" aria-label="삭제">&times;</button>
    `;

    // 삭제 버튼
    chip.querySelector('.remove').addEventListener('click', ()=>{
      chip.remove();
      if (!bar.querySelector('.picked-chip')){
        const span = document.createElement('span');
        span.className = 'picked-empty text-muted';
        span.textContent = '선택한 상품이 여기에 표시됩니다.';
        bar.appendChild(span);
      }
    });

    bar.appendChild(chip);
    bar.scrollLeft = bar.scrollWidth;
  };

