document.addEventListener('DOMContentLoaded', function () {
	const modals = document.querySelectorAll('.popupbox');
	const closeBtns = document.querySelectorAll('.popupbox-close');
	
	// 오버레이 클릭으로 닫기
	for(let modal of modals) {
		modal.addEventListener('click', function (e) {
			if (e.target === modal) {
				modal.classList.add('hidden');
			}
		});
	}
	
	// X 버튼 모달 창 Close
	for(let closeBtn of closeBtns) {
		closeBtn.addEventListener('click', function () {
			const modal = closeBtn.closest('.popupbox');
			modal.classList.add('hidden');
		});
	}

	// ESC 키로 닫기
	document.addEventListener('keydown', function (event) {
		if (event.key === 'Escape' || event.key === 'Esc') {
			modals.forEach(modal => {
				// 숨겨져 있지 않은 모달만 대상으로 함
				if (!modal.classList.contains('hidden')) {
					modal.classList.add('hidden');
				}
			});
		}
	});
	
});

function modalOpen(selector){
	const modal = document.querySelector(selector);
	
	modal.classList.remove('hidden');
}

function modalClose(selector){
	const modal = document.querySelector(selector);
	if (! modal.classList.contains('hidden')) {
		modal.classList.add('hidden');
	}
}

