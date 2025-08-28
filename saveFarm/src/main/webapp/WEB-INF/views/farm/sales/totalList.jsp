<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SaveFarm</title>
<jsp:include page="/WEB-INF/views/farm/layout/farmHeaderResources.jsp"/>

<style type="text/css">

</style>
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main">
	<div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.webp);">
		<div class="container position-relative">
			<h1>판매인기 차트</h1>
			<p>많이 판매되는 납품에 대한 정보를 그래프로 보실 수 있습니다.</p>
			<nav class="breadcrumbs">
			<ol>
				<li><a href="${pageContext.request.contextPath}/farm">돌아가기</a></li>
				<li class="current">판매 차트</li>
			</ol>
			</nav>
		</div>
	</div>
	    
	<section class="section">
		<div class="container my-4">
			<div class="card shadow border-0 mb-5">
				<div class="card-header bg-white border-0 pb-2 pt-5 px-4">
					<div class="d-flex">
						<div class="border-start border-3 border-success ps-3">
							<h2 class="h5 fw-semibold text-success mb-1">판매 TOP 10 차트</h2>
							<p class="text-muted small mb-0">
								이번 달 기준 판매량이 많은 상위 10개 품목을 확인할 수 있습니다.
							</p>
						</div>
					</div>
				</div>
				<div class="card-body pt-3">
					<div id="top10Chart" class="w-100" style="height:380px;"></div>
				</div>
			</div> 
	    	
			<div class="container my-4">
				<div class="card shadow border-0 mb-5">
					<div class="card-header bg-white border-0 pb-2 pt-5 px-4">
						<div class="d-flex justify-content-between align-items-center flex-wrap">
							<div class="border-start border-3 border-success ps-3 me-3">
								<h2 class="h5 fw-semibold text-success mb-1">선택한 품목의 월별 판매량</h2>
								<p class="text-muted small mb-0">3년(36개월) 기준 월간 판매량 추세를 확인하세요.</p>
							</div>
						
							<div class="d-flex align-items-center gap-2 flex-nowrap">
								<label for="categoryNum" class="form-label mb-0 me-2 text-nowrap" style="white-space:nowrap;">품목명</label>
								<select id="categoryNum" name="categoryNum" class="form-select form-select-sm" style="width: 220px;">
									<c:forEach var="v" items="${varietyList}">
										<option value="${v.varietyNum}" ${v.varietyNum == varietyNum ? 'selected' : ''}>${v.varietyName}</option>
									</c:forEach>
								</select>
								<input id="varietyNameSearch" type="search" class="form-control" placeholder="품목명 검색" style="width: 500px;">
								<button id="btnVarietyNameSearch" class="btn btn-outline-success" type="button" style="width: 150px;">검색</button>
							</div>
						</div>
						<div id="likeVarietyName" class="list-group mt-2 d-none" style="max-width: 600px; max-height: 260px; overflow: auto;"></div>			
			
						<div class="card-body pt-3">
							<div id="varietyNameChart" class="w-100" style="height:380px;"></div>
						</div>
					</div>
				</div>
			</div>  			
		</div>
	</section>  
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script src="https://fastly.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
<script type="text/javascript">

</script>

<script type="text/javascript">
// 1) 서버 데이터 -> JS 배열 (단위 g)
var rows = [
  <c:forEach var="row" items="${monthlyVarietyList}" varStatus="st">
    { product: '${row.varietyName}', qty: ${(row.totalWeightG!=null)?row.totalWeightG:0} }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// (선택) 품목 마스터(10칸 채울 때 활용)
var allVarieties = [
  <c:forEach var="v" items="${varietyList}" varStatus="st">
    '${v.varietyName}'<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// 2) Y축 품목 라벨 10개 확보: 데이터 우선 -> 마스터 -> 더미
var labels = [];
var picked = {};
rows.forEach(function(r){
  var nm = r.product || '품목';
  if (!picked[nm]) { labels.push(nm); picked[nm] = true; }
});
for (var i=0; i<allVarieties.length && labels.length<10; i++){
  var nm2 = allVarieties[i];
  if (nm2 && !picked[nm2]) { labels.push(nm2); picked[nm2] = true; }
}
while (labels.length < 10) labels.push('품목 ' + (labels.length+1));

// 3) 값 매핑(없으면 0 g)
var qtyByName = {};
rows.forEach(function(r){ qtyByName[r.product] = Number(r.qty) || 0; });
var amounts = labels.map(function(nm){ return qtyByName[nm] || 0; });

// 4) 색상용 score (10~100 스케일)
var minVal = amounts.length ? Math.min.apply(null, amounts) : 0;
var maxVal = amounts.length ? Math.max.apply(null, amounts) : 0;
function toScore(v){
  if (maxVal === minVal) return 10;
  return 10 + ((v - minVal) / (maxVal - minVal)) * 90;
}

// 5) dataset 구성 (요청한 디자인 구조)
var source = [['score','amount','product']];
for (var j=0; j<labels.length; j++){
  var amt = amounts[j];
  source.push([ toScore(amt), amt, labels[j] ]);
}

// 6) x축 고정 설정: 0 ~ 10000, 간격 1000 (총 10칸, 눈금 11개)
var step = 1000;       // ★ 간격(500으로 바꾸면 max도 아래에서 자동 5000)
var maxAxis = step * 10; // ★ 끝값(1000->10000, 500->5000)

// 7) 차트
var chart = echarts.init(document.getElementById('top10Chart'));
var option = {
  dataset: { source: source },
  grid: { containLabel: true },

  xAxis: {
    type: 'value',
    name: '판매량(g)',
    min: 0,
    max: maxAxis,        // 0 ~ 10000
    interval: step,      // 1000 단위로 눈금/격자 생성
    axisTick:  { show: true },
    splitLine: { show: true, lineStyle: { color: '#e0e0e0' } }, // 격자선 보이게
    axisLabel: {
      formatter: function(v){ return Number(v).toLocaleString(); }
    }
  },

  yAxis: { type: 'category', data: labels, inverse: true },

  visualMap: {
    orient: 'horizontal',
    left: 'center',
    min: 10,
    max: 100,
    text: ['High Score','Low Score'],
    dimension: 0, // 'score'
    inRange: { color: ['#65B581','#FFCE34','#FD665F'] },
    calculable: true
  },

  series: [{
    type: 'bar',
    encode: { x: 'amount', y: 'product' },
    label: {
      show: true,
      position: 'right',
      formatter: function(p){
        return Number(p.value[1] || 0).toLocaleString() + ' g';
      }
    }
    // barMinHeight: 1 // 0에도 아주 얇은 막대를 보이고 싶으면 주석 해제
  }]
};

chart.setOption(option);
window.addEventListener('resize', function(){ chart.resize(); });
</script>

</body>
</html>