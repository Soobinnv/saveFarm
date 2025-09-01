<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>세이브팜 - 나의 음식일기</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">

main {
    padding-top: 100px; /* 헤더의 높이(예시 100px)에 맞춰 조정 */
}
</style>

</head>
<body class="bg-light">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main >
	<div class="row justify-content-center ">
		<div class="col-6">
		<div class="page-title">
			<div class="wrap">
				<h1>나의 음식일기</h1>
			</div>
		</div>
	    
	    <section class="wrap">
	    	<div class="board-card">
				<div class="wrap photo-section ">
					<div class="row justify-content-center">
						<div class="col-md-10 my-1 p-2">
		
							<div class="row mb-4">
								<div class="col-md-4">
									<button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/homebob/list';" title="새로고침">새로고침</button>
								</div>
								<div class="col-md-4 text-start">
									<form name="searchForm" class="form-group-search">
										<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어를 입력하세요">
										<button type="button" onclick="searchList();"><i class="bi bi-search"></i></button>
										<input type="hidden" name="schType" value="all">
									</form>
								</div>
								<div class="col-md-4 text-end">
									<button type="button" class="btn btn-outline-success" onclick="location.href='${pageContext.request.contextPath}/homebob/write';">일기올리기</button>
								</div>
							</div>
						
							<div class="row gy-4 mb-3">
								<c:forEach var="dto" items="${list}" varStatus="status">
								    <div class="col-lg-4 col-md-6">
								        <div class="photo-content h-100">
								             <a href="${articleUrl}&num=${dto.num}">
								                <img src="${pageContext.request.contextPath}/uploads/homebob/${dto.imageFilename}" class="img-fluid border rounded w-100" style="height: 235px;" alt="">
								            </a>
								            <div class="photo-info mt-3 text-center">
								                <p><label>${dto.subject}</label></p>
								            </div>
								        </div>
								    </div>
								</c:forEach>
							</div>
							
							<div id="loading" class="text-center my-3" style="display: none;">
							    <div class="spinner-border text-success" role="status">
							        <span class="visually-hidden">Loading...</span>
							    </div>
							</div>
		
						</div>
					</div>
				</div>
			</div>
		</section>
		</div>
	</div>	
</main>

<script type="text/javascript">
// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
window.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	// form 요소는 FormData를 이용하여 URLSearchParams 으로 변환
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/homebob/list';
	location.href = url + '?' + params;
}

//전역 변수 설정
let currentPage = 1; // 현재 페이지 번호
const totalPage = parseInt("${totalPage}"); // 총 페이지 수 (JSP에서 받아옴)
let isLoading = false; // 로딩 중 상태 플래그

// 스크롤 이벤트 리스너
window.addEventListener('scroll', () => {
    // 문서의 끝까지 스크롤했는지 확인
    const { scrollTop, scrollHeight, clientHeight } = document.documentElement;

    // 현재 로딩 중이 아니고, 총 페이지를 넘지 않았으며, 스크롤이 거의 끝에 도달했을 때
    if (!isLoading && currentPage < totalPage && scrollTop + clientHeight >= scrollHeight - 100) {
        loadMoreContent();
    }
});

function loadMoreContent() {
    isLoading = true;
    currentPage++;

    // 로딩 스피너 보이기
    document.getElementById('loading').style.display = 'block';

    const f = document.searchForm;
    const formData = new FormData(f);
    formData.append('page', currentPage); // 다음 페이지 번호 추가

    const params = new URLSearchParams(formData).toString();
    const url = '${pageContext.request.contextPath}/homebob/list?' + params;

    fetch(url, {
        method: 'GET'
    })
    .then(response => response.text())
    .then(html => {
        // 서버에서 HTML 조각을 받아와서 기존 목록에 추가
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        const newItems = doc.querySelector('.row.gy-4.mb-3');
        
        if (newItems && newItems.innerHTML.trim() !== "") {
            document.querySelector('.row.gy-4.mb-3').innerHTML += newItems.innerHTML;
        }

        isLoading = false;
        // 로딩 스피너 숨기기
        document.getElementById('loading').style.display = 'none';

    })
    .catch(error => {
        console.error('Error fetching data:', error);
        isLoading = false;
        document.getElementById('loading').style.display = 'none';
    });
}

</script>

<script src="${pageContext.request.contextPath}/dist/vendor/glightbox/js/glightbox.min.js"></script>
<script type="text/javascript">
// Initiate glightbox
const glightbox = GLightbox({
  selector: '.glightbox'
});
</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>