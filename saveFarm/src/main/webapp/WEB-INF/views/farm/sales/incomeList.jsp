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
	<div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/incomeListTitle.webp);">
		<div class="container position-relative">
			<h1>높은수익 차트</h1>
			<p>가장 많은 수익금을 가져다준 납품에 대한 정보를 그래프로 보실 수 있습니다.</p>
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
	    	
			<div class="container-fluid my-4">
				<div class="card shadow border-0 mb-5">
					<div class="card-header bg-white border-0 pb-2 pt-5 px-4">
						<div class="d-flex justify-content-between align-items-center flex-wrap">
							<div class="border-start border-3 border-success ps-3 me-3">
								<h2 class="h5 fw-semibold text-success mb-1">선택한 품목의 월별 판매량</h2>
								<p class="text-muted small mb-0">3년(36개월) 기준 월간 판매량 추세를 확인하세요.</p>
							</div>
						
							<form id="varietyForm" class="d-flex align-items-center gap-2 flex-nowrap" method="get" action="${pageContext.request.contextPath}/farm/sales/incomeList">
								<label for="categoryNum" class="form-label mb-0 me-2 text-nowrap" style="white-space:nowrap;">품목명</label>
								<select id="categoryNum" name="categoryNum" class="form-select form-select-sm" style="width: 220px;">
									<c:forEach var="v" items="${varietyList}">
										<option value="${v.varietyNum}" ${v.varietyNum == varietyNum ? 'selected' : ''}>${v.varietyName}</option>
									</c:forEach>
								</select>
								<input id="varietyNameSearch" type="search" class="form-control" placeholder="품목명 검색" style="width: 500px;">
								<button id="btnVarietyNameSearch" class="btn btn-outline-success" type="button" style="width: 150px;">검색</button>
								<input type="hidden" name="varietyName" id="hfVarietyName">
							</form>
						</div>
						<div id="likeVarietyName" class="list-group mt-2 d-none" style="width: 360px; max-height: 260px; overflow: auto;"></div>		
			
						<div class="card-body pt-3" style="width:100%; max-width:1200px; margin:0 auto;">
							<div id="varietyNameChart" style="width:100%; height:500px;"></div>
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
// 1) 서버 데이터 -> JS 배열 (단위: 원)
var rows = [
  <c:forEach var="row" items="${monthlyVarietyList}" varStatus="st">
    { product: '${row.varietyName}', amt: ${(row.totalAmount!=null)?row.totalAmount:0} }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// (선택) 품목 마스터(10칸 채울 때 활용)
var allVarieties = [
  <c:forEach var="v" items="${varietyList}" varStatus="st">
    '${v.varietyName}'<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// 2) Y축 품목 라벨 10개 확보
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

// 3) 값 매핑(없으면 0 원)
var amtByName = {};
rows.forEach(function(r){ amtByName[r.product] = Number(r.amt) || 0; });
var amounts = labels.map(function(nm){ return amtByName[nm] || 0; });

// 4) 색상용 score (10~100 스케일)
var minVal = amounts.length ? Math.min.apply(null, amounts) : 0;
var maxVal = amounts.length ? Math.max.apply(null, amounts) : 0;
function toScore(v){
  if (maxVal === minVal) return 10;
  return 10 + ((v - minVal) / (maxVal - minVal)) * 90;
}

// 5) dataset 구성
var source = [['score','amount','product']];
for (var j=0; j<labels.length; j++){
  var amt = amounts[j];
  source.push([ toScore(amt), amt, labels[j] ]);
}

// 6) x축 유동 설정(금액: 10% 여유, 천 단위 라벨)
var dataMax = amounts.length ? Math.max.apply(null, amounts) : 0;
var floorMax = 100000;     // 금액은 기본 상한을 조금 키움(필요시 조정 가능)
var headroom = 1.1;
var niceMax = Math.max(floorMax, Math.ceil((dataMax * headroom) / 10000) * 10000);
var niceInterval = Math.max(10000, Math.round(niceMax / 10));

// 7) 차트
var chart = echarts.init(document.getElementById('top10Chart'));
var option = {
  dataset: { source: source },
  grid: { containLabel: true },

  xAxis: {
    type: 'value',
    name: '판매금액(원)',
    min: 0,
    max: niceMax,
    interval: niceInterval,
    axisTick:  { show: true },
    splitLine: { show: true, lineStyle: { color: '#e0e0e0' } },
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
    dimension: 0,
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
        return Number(p.value[1] || 0).toLocaleString() + ' 원';
      }
    }
  }]
};

chart.setOption(option);
window.addEventListener('resize', function(){ chart.resize(); });
</script>

<script type="text/javascript">
/* ====== 서버 모델 -> JS 변수 ====== */
// months: ["YYYY-MM", ...]
var MONTHS = [
  <c:forEach var="m" items="${months}" varStatus="st">
    '${m}'<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// seriesRows: [{monthKey:'YYYY-MM', totalAmount:12345}, ...]  ←★★ 금액 사용
var SERIES_ROWS = [
  <c:forEach var="r" items="${seriesRows}" varStatus="st">
    { monthKey: '${r.monthKey}', totalAmount: ${(r.totalAmount!=null)?r.totalAmount:0} }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

// 드롭다운/검색용 품목 목록 (그대로)
var VARIETY_LIST = [
  <c:forEach var="v" items="${varietyList}" varStatus="st">
    { varietyNum: '${v.varietyNum}', varietyName: '${v.varietyName}' }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

/* ====== 공통 DOM/함수 (그대로) ====== */
const ctx = '${pageContext.request.contextPath}';
const $select = document.getElementById('categoryNum');
const $input  = document.getElementById('varietyNameSearch');
const $btn    = document.getElementById('btnVarietyNameSearch');
const $list   = document.getElementById('likeVarietyName');

function goWith(params) {
  const q = new URLSearchParams(params).toString();
  location.href = ctx + '/farm/sales/totalList' + (q ? ('?' + q) : '');
}
if ($select) {
  $select.addEventListener('change', function(){
    if (this.value) goWith({ varietyNum: this.value });
  });
}
function renderSuggest(items){
  if (!items || items.length === 0) {
    $list.classList.remove('d-none');
    $list.innerHTML = '<div class="list-group-item small text-muted">결과가 없습니다</div>';
    return;
  }
  $list.classList.remove('d-none');
  $list.innerHTML = items.map(v => (
    '<button type="button" class="list-group-item list-group-item-action" '+
    'data-num="'+ v.varietyNum +'" data-name="'+ v.varietyName.replace(/"/g,'&quot;') +'">'+
    v.varietyName +'</button>'
  )).join('');
}
function runSearch(){
  const q = ($input?.value || '').trim().toLowerCase();
  if (!q) { $list.classList.add('d-none'); $list.innerHTML=''; return; }
  const matched = VARIETY_LIST.filter(v => v.varietyName.toLowerCase().includes(q));
  renderSuggest(matched.slice(0, 20));
}
if ($btn && $input && $list) {
  $btn.addEventListener('click', runSearch);
  $input.addEventListener('keydown', (e)=>{ if(e.key==='Enter'){ runSearch(); }});
  $list.addEventListener('click', (e)=>{
    const item = e.target.closest('.list-group-item-action');
    if (!item) return;
    const num = item.getAttribute('data-num');
    goWith({ varietyNum: num });
  });
}

/* ====== 아래 차트: 데이터만 금액으로 교체 ====== */
var valueByMonth = {};
for (var i=0;i<SERIES_ROWS.length;i++){
  valueByMonth[SERIES_ROWS[i].monthKey] = Number(SERIES_ROWS[i].totalAmount || 0); // ←★★ 금액
}
var seriesData = MONTHS.map(function(m, idx){
  return [idx, valueByMonth[m] || 0]; // [x(index), y=원]
});

var myChart = echarts.init(document.getElementById('varietyNameChart'));

// 기존 상수/브레이크 스타일 유지
var GRID_TOP = 120;
var GRID_BOTTOM = 80;
var GRID_LEFT = 60;
var GRID_RIGHT = 60;
var Y_DATA_ROUND_PRECISION = 0;
var _breakAreaStyle = {
  expandOnClick: false,
  zigzagZ: 200,
  zigzagAmplitude: 0,
  itemStyle: { borderColor: '#777', opacity: 0 }
};

var option = {
  title: {
    text: '월별 판매금액 (선택 품목)',
    subtext: '드래그-브러시로 구간 확대 / Reset 버튼으로 원상회복',
    left: 'center',
    top: 20,
    textStyle: { fontSize: 20 },
    subtextStyle: { color: '#175ce5', fontSize: 15, fontWeight: 'bold' },
    itemGap: 6
  },
  grid: { top: GRID_TOP, bottom: GRID_BOTTOM, left: GRID_LEFT, right: GRID_RIGHT },
  tooltip: {
    trigger: 'axis',
    valueFormatter: (v)=> (Number(v||0).toLocaleString() + ' 원'),
    axisPointer: { type: 'line' }
  },
  legend: {},
  xAxis: [{
    type: 'value',
    min: 0,
    max: Math.max(0, MONTHS.length - 1),
    interval: 1,
    axisLabel: {
      hideOverlap: false,
      lineHeight: 16,
      padding: [2, 0, 0, 0],
      formatter: function (v) {
        if (Math.abs(v - Math.round(v)) > 1e-6) return '';
        var i = Math.round(v);
        if (i < 0 || i >= MONTHS.length) return '';
        var s  = MONTHS[i];     // "YYYY-MM"
        var yy = s.slice(0, 4);
        var mm = s.slice(5, 7);
        return (mm === '01') ? (yy + '\n' + mm) : mm;
      }
    },
    axisTick: { show: true, alignWithLabel: true },
    splitLine: { show: false },
    breakArea: _breakAreaStyle
  }],
  yAxis: [{
    type: 'value',
    axisTick: { show: true },
    axisLabel: {
      formatter: function(v){ return Number(v||0).toLocaleString() + ' 원'; } // ←★★ 금액
    },
    breakArea: _breakAreaStyle
  }],
  series: [{
    type: 'line',
    name: '총금액(원)',     // ←★★ 시리즈 라벨
    symbol: 'circle',
    showSymbol: false,
    symbolSize: 5,
    data: seriesData,
    lineStyle: { width: 2 },
    areaStyle: { opacity: 0.08 }
  }]
};

myChart.setOption(option);
window.addEventListener('resize', function(){ myChart.resize(); });

/* 브러시/브레이크 인터랙션 (그대로) */
function initAxisBreakInteraction() {
  var _brushingEl = null;
  myChart.on('click', function (params) {
    if (params.name === 'clearAxisBreakBtn') {
      var option = { xAxis: { breaks: [] }, yAxis: { breaks: [] } };
      addClearButtonUpdateOption(option, false);
      myChart.setOption(option);
    }
  });
  function addClearButtonUpdateOption(option, show) {
    option.graphic = [{
      type: 'group',
      left: '80%',
      top:  GRID_TOP - 10,
      z: 10,
      children: [
        { type: 'rect', name: 'clearAxisBreakBtn', ignore: !show, shape: { r: 6, width: 80, height: 30 }, style: { fill: '#eee', stroke: '#999', lineWidth: 1 } },
        { type: 'text', ignore: !show, left: 10, top: 7, style: { text: 'Reset', fontSize: 14, fontWeight: 'bold', fill: '#333' } }
      ]
    }];
  }
  myChart.getZr().on('mousedown', function (params) {
    _brushingEl = new echarts.graphic.Rect({ shape: { x: params.offsetX, y: params.offsetY }, style: { stroke: 'none', fill: '#ccc' }, ignore: true });
    myChart.getZr().add(_brushingEl);
  });
  myChart.getZr().on('mousemove', function (params) {
    if (!_brushingEl) return;
    var initX = _brushingEl.shape.x;
    var initY = _brushingEl.shape.y;
    var currPoint = [params.offsetX, params.offsetY];
    _brushingEl.setShape('width',  currPoint[0] - initX);
    _brushingEl.setShape('height', currPoint[1] - initY);
    _brushingEl.ignore = false;
  });
  document.addEventListener('mouseup', function (params) {
    if (!_brushingEl) return;
    var initX = _brushingEl.shape.x;
    var initY = _brushingEl.shape.y;
    var currPoint = [params.offsetX, params.offsetY];
    var xPixelSpan = Math.abs(currPoint[0] - initX);
    var yPixelSpan = Math.abs(currPoint[1] - initY);
    if (xPixelSpan > 2 && yPixelSpan > 2) updateAxisBreak(myChart, [initX, initY], currPoint, xPixelSpan, yPixelSpan);
    myChart.getZr().remove(_brushingEl);
    _brushingEl = null;
  });
  function updateAxisBreak(myChart, initXY, currPoint, xPixelSpan, yPixelSpan) {
    var dataXY0 = myChart.convertFromPixel({ gridIndex: 0 }, initXY);
    var dataXY1 = myChart.convertFromPixel({ gridIndex: 0 }, currPoint);
    function makeDataRange(v0, v1) {
      var dataRange = [roundXYValue(v0), roundXYValue(v1)];
      if (dataRange[0] > dataRange[1]) dataRange.reverse();
      return dataRange;
    }
    var xDataRange = makeDataRange(dataXY0[0], dataXY1[0]);
    var yDataRange = makeDataRange(dataXY0[1], dataXY1[1]);
    var xySpan = getXYAxisPixelSpan(myChart);
    var xGapPercentStr = (xPixelSpan / xySpan[0]) * 100 + '%';
    var yGapPercentStr = (yPixelSpan / xySpan[1]) * 100 + '%';
    function makeOption(xGapPercentStr, yGapPercentStr) {
      return {
        xAxis: { breaks: [{ start: xDataRange[0], end: xDataRange[1], gap: xGapPercentStr }] },
        yAxis: { breaks: [{ start: yDataRange[0], end: yDataRange[1], gap: yGapPercentStr }] }
      };
    }
    myChart.setOption(makeOption(xGapPercentStr, yGapPercentStr));
    setTimeout(function(){
      var option = makeOption('80%', '80%');
      addClearButtonUpdateOption(option, true);
      myChart.setOption(option);
    }, 0);
  }
  function getXYAxisPixelSpan(myChart) {
    return [
      myChart.getWidth()  - GRID_LEFT - GRID_RIGHT,
      myChart.getHeight() - GRID_BOTTOM - GRID_TOP
    ];
  }
}
function roundXYValue(val) { return +(+val).toFixed(Y_DATA_ROUND_PRECISION); }
setTimeout(initAxisBreakInteraction, 0);
</script>

</body>
</html>