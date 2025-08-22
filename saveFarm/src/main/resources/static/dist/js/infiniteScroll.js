// 무한 스크롤 //

const listNode = document.querySelector('.content-list');
const sentinelNode = document.querySelector('.sentinel');

function updateInfiniteScroll(data) {
	
	let dataCount = Number(data.dataCount) || 0;
	let pageNo = Number(data.pageNo) || 0;
	let total_page = Number(data.total_page) || 0;
	
	listNode.setAttribute('data-pageNo', pageNo);
	listNode.setAttribute('data-totalPage', total_page);
	
	sentinelNode.style.display = 'none';
	
	if(dataCount === 0) {
		return;
	}
	
	if(pageNo < total_page) {
		sentinelNode.setAttribute('data-loading', 'false');
		sentinelNode.style.display = 'block';
		
		io.observe(sentinelNode); // 관찰할 대상(요소) 등록
	}	
}

// 무한 스크롤
const ioCallback = (entries, io) => {
	entries.forEach((entry) => {
		if (entry.isIntersecting) { // 관찰 대상의 교차(겹치는)상태(Boolean) : 화면에 보이면
    	
			// 현재 페이지가 로딩중이면 빠져 나감
			let loading = sentinelNode.getAttribute('data-loading');
			if(loading !== 'false') {
				return;
			}
    	
			io.unobserve(entry.target); // 기존 관찰하던 요소는 더 이상 관찰하지 않음
    
			let pageNo = Number(listNode.getAttribute('data-pageNo')) || 0;
			let total_page = Number(listNode.getAttribute('data-totalPage')) || 0;
		
			if(pageNo === 0 || pageNo < total_page) {
				pageNo++;
				loadProducts("/api/products/normal", {pageNo:pageNo});
			}
		}
	});
};

const io = new IntersectionObserver(ioCallback); // 관찰자 초기화