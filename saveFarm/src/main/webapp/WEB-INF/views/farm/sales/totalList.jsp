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
(function () {
  const ctx = '${pageContext.request.contextPath}';

  const API_BASE = ctx + '/farm/sales/data'; // /farm/sales/* 의 * 자리에 'data'를 사용

  // DOM
  const $select = document.getElementById('categoryNum');
  const $input  = document.getElementById('varietyNameSearch');
  const $btn    = document.getElementById('btnVarietyNameSearch');
  const $list   = document.getElementById('likeVarietyName');

  // 차트 인스턴스
  const vChart = echarts.init(document.getElementById('varietyNameChart'));

  // 라인 차트 옵션
  function makeLineOption(title, months, seriesName, data) {
    return {
      title: { text: title, left: 'center' },
      tooltip: { trigger: 'axis' },
      grid: { left: 40, right: 20, top: 60, bottom: 40 },
      xAxis: { type: 'category', boundaryGap: false, data: months },
      yAxis: { type: 'value', name: '중량(g)' },
      toolbox: { feature: { saveAsImage: {}, dataZoom: {} } },
      dataZoom: [{ type: 'inside' }, { type: 'slider' }],
      series: [{
        name: seriesName,
        type: 'line',
        smooth: true,
        areaStyle: {},
        data
      }],
      legend: { data: [seriesName], top: 28 }
    };
  }

  // 월별 데이터 조회 (서버는 아래 형식 중 하나로 응답한다고 가정)
  // { months: [...], legend: [...], series: [{name, data:[...]}] }
  async function fetchMonthlyByVariety({ varietyNum = null, varietyName = null, rangeMonths = 36 }) {
    const params = new URLSearchParams();
    params.set('rangeMonths', rangeMonths); // 서버가 무시해도 무해
    if (varietyNum) params.set('varietyNum', varietyNum);
    if (!varietyNum && varietyName) params.set('varietyName', varietyName);

    const url = `${API_BASE}/api/monthly-weight?` + params.toString();
    const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
    if (!res.ok) throw new Error('데이터 조회 실패');
    return res.json();
  }

  // 렌더링 헬퍼
  function renderSuggestions(items) {
    $list.innerHTML = '';
    if (!items || items.length === 0) {
      $list.classList.remove('d-none');
      $list.innerHTML = `<div class="list-group-item small text-muted">검색 결과가 없습니다.</div>`;
      return;
    }
    const frag = document.createDocumentFragment();
    items.forEach(v => {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'list-group-item list-group-item-action';
      btn.dataset.num = v.varietyNum;
      btn.dataset.name = v.varietyName;
      btn.textContent = `${v.varietyName} (#${v.varietyNum})`;
      frag.appendChild(btn);
    });
    $list.appendChild(frag);
    $list.classList.remove('d-none');
  }

  // 품목명 검색 API (부분일치)
  async function searchVarieties(q) {
    // 서버에 /farm/variety/search?q=...&limit=20 형태로 구현되어 있다고 가정 (이전 코드와 동일)
    const url = `${ctx}/farm/variety/search?q=${encodeURIComponent(q || '')}&limit=20`;
    const res = await fetch(url, { headers: { 'Accept': 'application/json' } });
    if (!res.ok) throw new Error('검색 실패');
    return res.json(); // [{varietyNum, varietyName}, ...]
  }

  // 선택된 품목으로 차트 갱신
  async function updateChartBySelection({ varietyNum, varietyName }) {
    try {
      const data = await fetchMonthlyByVariety({ varietyNum, varietyName, rangeMonths: 36 });
      // 서버가 여러 series를 반환하면 일치하는 것만 뽑고, 아니면 첫 번째 사용
      let seriesName = varietyName;
      let seriesData = [];
      if (Array.isArray(data.series) && data.series.length > 0) {
        let picked = null;
        if (varietyName) {
          picked = data.series.find(s => s.name === varietyName);
        }
        if (!picked) picked = data.series[0];
        seriesName = picked.name || seriesName || '선택 품목';
        seriesData = picked.data || [];
      }
      vChart.setOption(makeLineOption(`${seriesName} 월별 판매량`, data.months || [], seriesName, seriesData));
      vChart.resize();
    } catch (e) {
      console.error(e);
      // 에러 시 간단 안내
      vChart.clear();
      vChart.setOption({ title: { text: '데이터를 불러오지 못했습니다.', left: 'center' }});
    }
  }

  // 1) 셀렉트 변경 → 해당 품목 차트
  $select.addEventListener('change', () => {
    const num = $select.value ? String($select.value) : null;
    const name = $select.options[$select.selectedIndex]?.text || '';
    if (num) {
      $input.value = name; // 검색창에 표시 동기화
      updateChartBySelection({ varietyNum: num, varietyName: name });
      // 검색 제안 닫기
      $list.classList.add('d-none');
      $list.innerHTML = '';
    }
  });

  // 2) 검색 버튼 클릭 → 제안 리스트 표시
  $btn.addEventListener('click', async () => {
    try {
      const q = $input.value.trim();
      const items = await searchVarieties(q);
      renderSuggestions(items);
    } catch (e) { console.error(e); }
  });

  // Enter키로도 검색
  $input.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') $btn.click();
  });

  // 3) 제안 리스트에서 선택 → 셀렉트 동기화 + 차트 로드
  $list.addEventListener('click', (e) => {
    const item = e.target.closest('.list-group-item-action');
    if (!item) return;
    const num  = String(item.dataset.num || '');
    const name = item.dataset.name || '';

    // 셀렉트에 해당 옵션이 없으면 추가
    let opt = Array.from($select.options).find(o => o.value === num);
    if (!opt) {
      opt = new Option(name, num);
      $select.add(opt);
    }
    $select.value = num;
    $input.value = name;
    $list.classList.add('d-none');
    $list.innerHTML = '';

    updateChartBySelection({ varietyNum: num, varietyName: name });
  });

  // 4) 바깥 클릭 시 제안 닫기
  document.addEventListener('click', (e) => {
    if (!$list.contains(e.target) && e.target !== $input && e.target !== $btn) {
      $list.classList.add('d-none');
    }
  });

  // 5) 초기 진입 시, 셀렉트의 현재 선택으로 한 번 로드
  window.addEventListener('load', () => {
    const num = $select.value ? String($select.value) : null;
    const name = $select.options[$select.selectedIndex]?.text || '';
    if (num) {
      $input.value = name;
      updateChartBySelection({ varietyNum: num, varietyName: name });
    }
  });

  // 리사이즈 대응
  window.addEventListener('resize', () => vChart.resize());
})();
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