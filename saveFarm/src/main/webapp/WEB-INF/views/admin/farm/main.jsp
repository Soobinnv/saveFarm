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
					<h2 class="mb-2 page-title text-center">농가 관리	</h2>
	
					<div class="row my-4">
						<div class="col-md-12" id="nav-tabContent"></div>
						
						<form name="farmSearchForm">
							<input type="hidden" name="schType" value="farmerId">
							<input type="hidden" name="kwd" value="">
						</form>				
					</div>	
				</div>
			</div>				
		</div>
	</main>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.6.0/echarts.min.js"></script>

<script type="text/javascript">
$(function(){
	listFarm(1);
});

function listFarm(page) {
	let url = '${pageContext.request.contextPath}/admin/farm/farmList';	
	let params = $('form[name=farmSearchForm]').serialize();
	params += '&page=' + page;
	const fn = function(data) {
		$('#nav-tabContent').html(data);
	};
	
	ajaxRequest(url, 'get', params, 'text', fn);
}

function resetList() {
	// 초기화
	const $tab = $('button[role="tab"].active');
	let role = $tab.attr('data-tab');
	
	const f = document.farmSearchForm;
	
	f.schType.value = 'loginId';
	f.kwd.value = '';
	
	listFarm(1);
}

function searchList() {
	// 검색
	const f = document.farmSearchForm;
	f.schType.value = $('#searchType').val();
	
	if(f.schType.value !== 'status'){
		f.kwd.value = $('#keyword').val();
	} else {
		f.kwd.value = getNumericStatusValue($('#keyword').val());
	}
	
	listFarm(1);
}

function getNumericStatusValue(statusText) {
    statusText = statusText.trim();
    switch (statusText) {
        case '신청대기': return 0;
        case '서류체크': return 1;
        case '서류탈락': return 2;
        case '승인': return 3;
        case '숨김': return 4;
        default: return ''; 
    }
}

function statusText(value) {
    switch(value) {
        case 0: return '신청대기';
        case 1: return '서류체크';
        case 2: return '서류탈락';
        case 3: return '승인';
        case 4: return '숨김';
        default: return '';
    }
}

function details(farmNum, page) {
	// 모달이 제대로 작동죄지 않는 현상을 위해 body로 옮긴 모달이 존재하는 경우 제거
	$('#farmStatusDetailesDialogModal').remove();
	$('#farmUpdateDialogModal').remove();
	
	// 회원 상세 보기
	let url = '${pageContext.request.contextPath}/admin/farm/details';
	let params = 'farmNum=' + farmNum + '&page=' + page;
	
	const fn = function(data){
		$('#nav-tabContent').html(data);
	};

	ajaxRequest(url, 'get', params, 'text', fn);
}

function statusDetailesFarm() {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#farmStatusDetailesDialogModal').appendTo('body');
	$('#farmStatusDetailesDialogModal').modal('show');	
}

function updateFarm() {
	// data-aos 에 의해 부모에 transform css로 인하여 모달이 제대로 작동되지 않는 현상 해결
	$('#farmUpdateDialogModal').appendTo('body');
	$('#farmUpdateDialogModal').modal('show');
}

function updateFarmOk(page) {
	// 회원 정보 변경(권한, 이름, 생년월일)
	const f = document.farmUpdateForm;
	console.log(f.farmName.value);
	if( ! f.farmName.value ) {
		alert('대표명을 입력 하세요.');
		f.farmName.focus();
		return;
	}
	if( ! f.farmerName.value ) {
		alert('이름을 입력 하세요.');
		f.farmerName.focus();
		return;
	}
	if( ! f.farmAccount.value ) {
		alert('계좌번호를 입력 하세요.');
		f.farmAccount.focus();
		return;
	}
	
	if( ! confirm('회원 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/farm/updateFarm';
	let params = $('#farmUpdateForm').serialize();
	console.log(params);
	const fn = function(data){
		listFarm(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#farmUpdateDialogModal').modal('hide');
}

function deletefarm(FarmNum) {
	// 회원 삭제
	if(! confirm('삭제하시겠습니까 ? ')){
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/farm/deleteFarm';	
	let params = 'FarmNum=' + FarmNum;
	
	const fn = function(data) {
        listFarm(1);
    };
	
	ajaxRequest(url, 'post', params, 'text', fn);
	
}

function updateStatusOk(page) {
	// 회원 상태 변경
	const f = document.farmStatusDetailesForm;
	
	if( ! f.status.value ) {
		alert('상태 코드를 선택하세요.');
		f.status.focus();
		return;
	}
	
	if( ! confirm('상태 정보를 수정하시겠습니까 ? ')) {
		return;
	}
	
	let url = '${pageContext.request.contextPath}/admin/farm/updateFarmStatus';
	let params = $('#farmStatusDetailesForm').serialize();
	const fn = function(data){
		listFarm(page);
	};
	ajaxRequest(url, 'post', params, 'json', fn);
	
	$('#farmStatusDetailesDialogModal').modal('hide');
}

function farmAnalysis() {
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

	let url = '${pageContext.request.contextPath}/admin/farm/farmAgeSection';
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