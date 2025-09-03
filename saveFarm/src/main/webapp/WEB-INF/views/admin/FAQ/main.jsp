<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }

#sidebar {
  position: fixed;
  top: 0;
  left: 0;
  width: 240px;
  height: 100vh;
  background-color: #343a40;
  transition: transform 0.3s ease-in-out;
  z-index: 1030;
}

/* 숨겨졌을 때 */
.sidebar-collapsed #sidebar {
  transform: translateX(-100%);
}

#leftSidebar {
    width: 250px;
    transition: width 0.3s ease;
  }

  #leftSidebar.collapsed {
    width: 0 !important;
    overflow: hidden;
  }
.nav-link {
}  
</style>


<title>세이브팜</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper"> 
<header>
	<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>
	<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
<main role="main" class="main-content">
	<div class="container-fluid">
		<div class="row justify-content-center">
			<div class="col-12">
				<h2 class="mb-2 page-title text-center">자주하는 질문</h2>
	
				<div class="row my-4">
					<div class="col-md-12" id="nav-tabContent"> </div>
						
					<form name="faqSearchForm">
						<input type="hidden" name="schTypeFAQ" value="">
						<input type="hidden" name="schType" value="all">
						<input type="hidden" name="kwd" value="">
						<input type="hidden" name="categoryNum" value="">
						<input type="hidden" name="faqNum" value="">
					</form>
				</div>
			</div>
		</div>				
	</div>	
</main>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
	listFaq(1);
});

// FAQ 목록을 불러오는 메인 함수
// 카테고리, 검색, 페이지 이동 등 모든 목록 요청을 처리합니다.
function listFaq(page) {
	let url = '${pageContext.request.contextPath}/admin/FAQ/FAQ';	
	let params = $('form[name=faqSearchForm]').serialize(); 
	params += '&page=' + page;

	const fn = function(data) {
		// FAQ.jsp의 전체 컨텐츠를 새로운 데이터로 대체
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

// 2. FAQ 타입 (회원/농가) 선택 시 호출되는 함수
function changeFaqType() {
    const f = document.faqSearchForm;
    f.kwd.value = '';
    f.schType.value = 'all';
    f.categoryNum.value = '';
    f.schTypeFAQ.value = $('#schTypeFAQSelect').val();
    
    listFaq(1); // 이 함수가 최종 목록을 다시 불러옵니다.
}

/* 
function changeFaqType() {
    const f = document.faqSearchForm;
    const schTypeFAQ = document.getElementsByName('schTypeFAQ');
    f.kwd.value = '';
    f.schType.value = 'all';
    f.categoryNum.value = '';
    f.schTypeFAQ.value = schTypeFAQ[0].value;
    
    listFaq(1); // 이 함수가 최종 목록을 다시 불러옵니다.
}
 */
// 네비바 카테고리 탭 클릭 시 호출되는 함수
function loadCategory(categoryNum) {
    const f = document.faqSearchForm;
    f.kwd.value = '';
    f.schType.value = 'all';
    f.categoryNum.value = categoryNum;
    
    listFaq(1);
}
// 검색 버튼 클릭 시 호출되는 함수
function searchList() {
    const f = document.faqSearchForm;
    const searchType = $('#searchType').val();
    const keyword = $('#keyword').val();
    
    f.schType.value = searchType;
    f.kwd.value = keyword;

    listFaq(1);
}

// 검색 초기화
function resetSearch() {
    const f = document.faqSearchForm;
    f.schType.value = 'all';
    f.kwd.value = '';
    f.categoryNum.value = '';
    
    listFaq(1);
}

// 페이지네이션 클릭 이벤트 처리
// 동적으로 로드된 HTML에도 이벤트를 적용하기 위해 on() 메서드를 사용합니다.
$(document).on('click', '.pagination a', function(e) {
    e.preventDefault();
    const page = $(this).attr('data-page');
    if (page) {
        listFaq(page);
    }
});

function updateFAQ(faqNumValue, page) {
	const f = document.faqSearchForm;
	var faqNum = $(faqNumValue).closest('td').find('input[name=faqNum]');
	f.faqNum.value = faqNum.val();
	
	let url = '${pageContext.request.contextPath}/admin/FAQ/update';
	let params = $(f).serialize(); 
	params += '&page=' + page;
	
	location.href = url + '?' + params;
}


function deleteFAQ(faqNum) {
	if(! confirm('삭제하시겠습니까 ? ')){
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/FAQ/delete';	
	let params = 'faqNum=' + faqNum;
	
	const fn = function(data) {
        listFaq(1);
    };
	
	ajaxRequest(url, 'post', params, 'text', fn);
}

function updateStatusOk(page) {
	const f = document.memberStatusDetailesForm;
	
	if( ! f.statusCode.value ) {
		alert('상태 코드를 선택하세요.');
		f.statusCode.focus();
		return;
	}
	if( ! f.memo.value.trim() ) {
		alert('상태 메모를 입력하세요.');
		f.memo.focus();
		return;
	}
	
	if( ! confirm('상태 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/member/updateMemberStatus';
	let params = $('#memberStatusDetailesForm').serialize();
	const fn = function(data){
		listMember(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#memberStatusDetailesDialogModal').modal('hide');
}

function memberAnalysis() {
	let out;
	out = `
		<div class="row gy-4 mt-2">
			<div class="col-md-4">
				<h6 class="text-center">연령대별 회원수</h6>
				<div id="barchart-container" style="height: 370px;"></div>
			</div>
		</div>
	`;
	
	$('#nav-tabContent').empty();
	$('#nav-tabContent').html(out);

	let url = '${pageContext.request.contextPath}/admin/member/memberAgeSection';
	$.getJSON(url, function(data){
		let titles = [];
		let values = [];
		
		for(let item of data.list) {
			titles.push(item.SECTION);
			values.push(item.COUNT);
		}
		
		const chartDom = document.querySelector('#barchart-container');
		let myChart = echarts.init(chartDom);
		let option;
		
		option = {
			tooltip: {
				trigger: 'item'
			},
			xAxis: {
				type: 'category',
				data: titles
			},
			yAxis: {
				type: 'value'
			},
			series: [
				{
					data: values,
					type: 'bar'
				}
			]
		};
				
		option && myChart.setOption(option);
	});
}
</script>

<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>
</body>
</html>