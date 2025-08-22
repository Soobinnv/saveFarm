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
				<h2 class="mb-2 page-title">자주하는 질문</h2>
	
				<div class="row my-4">
					<div class="col-md-12" id="nav-tabContent"> </div>
						
					<form name="faqSearchForm">
						<input type="hidden" name="schType" value="all">
						<input type="hidden" name="kwd" value="">
						<input type="hidden" name="categoryNum" value="categoryNum">
					</form>
				</div>
			</div>
		</div>				
	</div>	
</main>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
	listCategory(1);
});

function listCategory(page) {
	let url = '${pageContext.request.contextPath}/admin/FAQ/FAQ';	
	let params = $('form[name=faqSearchForm]').serialize();
	params += '&page=' + page;
	
	let schTypeFAQ = $('#schTypeFAQSelect').val();
    params += '&schTypeFAQ=' + schTypeFAQ;
    console.log(schTypeFAQ);
	
	const fn = function(data) {
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function resetList() {
	// 초기화
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');

	const f = document.faqSearchForm;
	
	f.schType.value = 'all';
	f.kwd.value = '';
	f.enabled.value = '';
	
	listCategory(1);
}

function searchList() {
	// 검색
	const f = document.faqSearchForm;
	
	f.schType.value = $('#searchType').val();
	f.kwd.value = $('#keyword').val();
	
	listCategory(1);
}

function details(memberId, page) {
	// 모달이 제대로 작동죄지 않는 현상을 위해 body로 옮긴 모달이 존재하는 경우 제거
	$('#memberStatusDetailesDialogModal').remove();
	$('#memberUpdateDialogModal').remove();
	
	// 회원 상세 보기
	let url = '${pageContext.request.contextPath}/admin/member/details';
	let params = 'memberId=' + memberId + '&page=' + page;
	
	const fn = function(data){
		$('#nav-tabContent').html(data);
	};

	ajaxRequest(url, 'get', params, 'text', fn);
}

function statusDetailesMember() {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#memberStatusDetailesDialogModal').appendTo('body');
	$('#memberStatusDetailesDialogModal').modal('show');	
}

function selectStatusChange() {
	const f = document.memberStatusDetailesForm;

	let code = f.statusCode.value;
	console.log(code);
	let memo = f.statusCode.options[f.statusCode.selectedIndex].text;
	
	f.memo.value = '';	
	if(! code) {
		return;
	}

	if(code!=='0' && code!=='8') {
		f.memo.value = memo;
	}
	
	f.memo.focus();
}


function updateMember() {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#memberUpdateDialogModal').appendTo('body');
	$('#memberUpdateDialogModal').modal('show');
}

function updateMemberOk(page) {
	// 회원 정보 변경(권한, 이름, 생년월일)
	const f = document.memberUpdateForm;

	if( ! f.name.value ) {
		alert('이름을 입력 하세요.');
		f.name.focus();
		return;
	}
	
	if( ! confirm('회원 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/member/updateMember';
	let params = $('#memberUpdateForm').serialize();
	console.log(params);
	const fn = function(data){
		listMember(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#memberUpdateDialogModal').modal('hide');
}

function deleteMember(memberId) {
	// 회원 삭제
	if(! confirm('삭제하시겠습니까 ? ')){
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/member/deleteMember';	
	let params = 'memberId=' + memberId;
	
	const fn = function(data) {
        listMember(1);
    };
	
	ajaxRequest(url, 'post', params, 'text', fn);
	
}

function updateStatusOk(page) {
	// 회원 상태 변경
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
	// 연령별 어낼러시스(분석) - echarts bar
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