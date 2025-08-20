/** 
 * 상품 문의 컨테이너 설정 함수 
 * 렌더링 및 스크롤 초기화 
 * @param {object} data - 상품 문의 데이터 
 */ 
function setupQnaVirtualScroll(data) { 
    const selector = '#productInfoLayout'; 
    let html = ''; 

    if (!data.list || data.list.length === 0) { 
        html = ` 
            <h4>상품 문의</h4> 
            <div class="text-center mt-3 p-5 border rounded"> 
                <p class="mt-3 mb-0 text-muted">등록된 문의가 없습니다.</p> 
            </div> 
        `; 
        $(selector).html(html); 
        return; 
    } 
    
	// 기본 HTML 구성 
    html = ` 
        <h4>상품 문의</h4> 
        <div class="qna-list-wrapper mt-3"> 
            <div class="qna-list-header"> 
                <span class="qna-status">상태</span> 
                <span class="qna-title text-center">제목</span> 
                <span class="qna-author">작성자</span> 
                <span class="qna-date">등록일</span> 
            </div> 
            <div id="qna-virtual-container" style="height: 496px; overflow-y: auto;"> 
                <table class="w-100" style="border-collapse: collapse;"> 
                    <thead id="qna-virtual-thead"></thead> 
                    <tbody id="qna-list-body"></tbody> 
                    <tfoot id="qna-virtual-tfoot"></tfoot> 
                </table> 
            </div> 
        </div> 
        <div class="text-center mt-3 p-5"> 
            <button class="btn btn-success btn-lg" type="button" data-bs-toggle="modal" data-bs-target="#qnaFormModal">상품 문의</button> 
        </div>
		<div class="modal fade" id="qnaFormModal" tabindex="-1" aria-labelledby="qnaFormModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h2 class="modal-title fs-5" id="qnaFormModalLabel">상품 문의하기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form id="productQnaForm">
		          <div class="mb-3">
		            <label for="qna-title-input" class="form-label"><strong>제목</strong></label>
		            <input type="text" name="title" class="form-control" id="qna-title-input" placeholder="제목을 입력하세요." required>
		          </div>
		          <div class="mb-3">
		            <label for="qna-question-textarea" class="form-label"><strong>문의 내용</strong></label>
		            <textarea class="form-control" name="question" id="qna-question-textarea" rows="6" placeholder="문의하실 내용을 자세하게 입력해주세요." required></textarea>
		          </div>
		          <div class="mb-3">
		            <input type="checkbox" name="secret" id="qna-secret-check">
		            <label class="form-check-label" for="qna-secret-check">비공개 문의</label>
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" form="productQnaForm" class="btn btn-success btn-product-qna">문의 등록</button>
		      </div>
		    </div>
		  </div>
		</div>
    `; 

    $(selector).html(html); 

    // 가상 스크롤 초기화 함수를 호출
    initVirtualScroll(data.list); 
} 

function initVirtualScroll(qnaList) { 
    const $scrollContainer = document.getElementById('qna-virtual-container'); 
    const $tbody = document.getElementById('qna-list-body'); 
    const $thead = document.getElementById('qna-virtual-thead'); // 상단 여백 역할 
    const $tfoot = document.getElementById('qna-virtual-tfoot'); // 하단 여백 역할 

    const viewportHeight = 496; // 스크롤 컨테이너의 높이 
    const rowHeight = 62;      // 각 아이템(행)의 고정 높이 
     
    const dataSize = qnaList.length; // 전체 데이터 개수 
    const nodePadding = 5; // 화면 위/아래로 미리 렌더링할 아이템 개수 
    const nodeCount = Math.ceil(viewportHeight / rowHeight); // 화면에 보이는 아이템 개수 
    const visibleNodeCount = nodeCount + nodePadding * 2; // 실제로 렌더링할 총 아이템 개수 
    
	console.log("nodeCount: "+nodeCount)
	console.log("visibleNodeCount: "+visibleNodeCount)
	
    // 단일 아이템 HTML 생성
    function createQnaItemHtml(item) {  
        const isAnswered = item.answer && item.answer.trim() !== ''; 
        const statusClass = isAnswered ? 'answered' : ''; 
        const statusText = isAnswered ? '답변완료' : '답변대기'; 
        const titleHtml = (item.secret == 1  
            ? '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="currentColor" d="M12 17c1.1 0 2-.9 2-2s-.9-2-2-2s-2 .9-2 2s.9 2 2 2m6-9h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2m-6 9c-2.21 0-4-1.79-4-4s1.79-4 4-4s4 1.79 4 4s-1.79 4-4 4M9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2z"></path></svg> '  
            : '')  
            + item.title; 

        return ` 
            <div class="accordion-item"> 
                <h2 class="accordion-header"> 
                    <button  
                        class="accordion-button collapsed"  
                        type="button" 
                        data-bs-toggle="collapse"  
                        data-bs-target="#qna-answer-${item.qnaNum}"> 
                        <span class="qna-status ${statusClass}">${statusText}</span> 
                        <span class="qna-title">${titleHtml}</span> 
                        <span class="qna-author">${item.name}</span> 
                        <span class="qna-date">${item.qnaDate}</span> 
                    </button> 
                </h2> 
                <div id="qna-answer-${item.qnaNum}" class="accordion-collapse collapse"> 
                    <div class="accordion-body"> 
                        ${item.answer || '아직 등록된 답변이 없습니다.'} 
                    </div> 
                </div> 
            </div> 
        `; 
    } 

    /**  
	 * 현재 스크롤 위치를 기반으로 렌더링할 아이템의 시작/끝 인덱스 계산
     * @param {number} scrollTop - 컨테이너의 현재 scrollTop 값 
     * @returns {number[]} [시작 인덱스, 끝 인덱스] 
     */ 
    function calculateOffsets(scrollTop) {  
        // 현재 스크롤 위치에서 가장 위에 있어야 할 아이템의 인덱스를 계산 
        const scrollIndex = Math.floor(scrollTop / rowHeight); 
         
        // 화면 버퍼(padding)를 고려하여 렌더링할 첫 아이템의 인덱스 계산 
        const startIndex = Math.max(0, scrollIndex - nodePadding); 

        // 렌더링할 마지막 아이템의 인덱스 계산 (전체 데이터 크기를 넘지 않도록) 
        const endIndex = Math.min(dataSize - 1, startIndex + visibleNodeCount); 
         
        return [startIndex, endIndex]; 
    } 

    /** 
	 * 계산된 인덱스 범위를 기반으로 렌더링
     * @param {number[]} range - [시작 인덱스, 끝 인덱스] 
     */ 
    function render([startIndex, endIndex]) { 
        // 보이지 않는 영역의 높이를 thead와 tfoot으로 설정하여 스크롤바 유지 
        const topPadding = startIndex * rowHeight; 
        const bottomPadding = (dataSize - 1 - endIndex) * rowHeight; 
         
        $thead.style.height = `${topPadding}px`; 
        $tfoot.style.height = `${bottomPadding}px`; 

        // 현재 화면에 보여줄 아이템들의 HTML 생성
        let visibleItemsHtml = ''; 
        for (let i = startIndex; i <= endIndex; i++) { 
            const item = qnaList[i]; 
            if (item) { 
                visibleItemsHtml += ` 
                    <tr style="height: ${rowHeight}px; data-qna-num=${item.qnaNum}"> 
                        <td style="padding: 0; border: none; vertical-align: top;"> 
                            ${createQnaItemHtml(item)} 
                        </td> 
                    </tr> 
                `; 
            } 
        } 
         
        $tbody.innerHTML = visibleItemsHtml; 
    } 

    // --- 이벤트 리스너 등록 --- 
    render(calculateOffsets(0)); // 초기 렌더링 
    $scrollContainer.addEventListener('scroll', (e) => { 
        render(calculateOffsets(e.target.scrollTop)); 
    }); 
}