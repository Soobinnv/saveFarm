// input submit 방지
document.addEventListener('keydown', function(event) {
  if (event.keyCode === 13) {
    event.preventDefault();
  };
});

function addToCart(productNum, btnEL) {
	
}

function addToWish(productNum, btnEL) {
	
}

$(function() {
	// 검색창 엔터
	$('.searchInput').on('keydown', function(event) {
		if (event.keyCode === 13) {
			
		};
	});
});