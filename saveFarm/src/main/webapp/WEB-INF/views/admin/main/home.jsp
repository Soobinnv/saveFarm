<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-more.js"></script>
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
				<!-- 1번쨰 -->
				<div class="row">
					<div class="col-md-12 col-lg-6 mb-1">
						<div class="card shadow">
							<div class="card-header">
								<strong class="card-title">반품</strong>
								<a class="float-right small text-dark" href="${pageContext.request.contextPath}/admin/order/cencelList/210"><strong>매뉴로 가기</strong></a>
							</div>
							<div class="card-body my-n2">
								<table class="table table-striped table-hover table-borderless">
									<thead>
										<tr>
											<th>주문상세번호</th>
											<th>반품번호</th>
											<th>신청일</th>
											<th>반품 신청금액</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="dto" items="${returnList}">
											<tr>
												<td>${dto.orderDetailNum}</td>
												<td>${dto.returnNum}</td>
												<td>${dto.reqDate}</td>
												<td>
													<fmt:formatNumber value="${empty dto.salePrice ? dto.price * dto.quantity : dto.salePrice * dto.quantity}" type="number" />
												</td>
												<c:choose>
													<c:when test="${dto.status == 0}">
														<td>신청</td>
													</c:when>
													<c:when test="${dto.status == 1}">
														<td>처리중</td>
													</c:when>
												</c:choose>
											</tr>
										</c:forEach>
										<c:forEach var="i" begin="1" end="${5 - fn:length(returnList)}">
											<tr>
												<td colspan="5">&nbsp;</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				
					<div class="col-md-12 col-lg-6 mb-1">
						<div class="card shadow">
							<div class="card-header">
								<strong class="card-title">환불</strong>
								<a class="float-right small text-dark" href="${pageContext.request.contextPath}/admin/order/cencelList/200"><strong>매뉴로 가기</strong></a>
							</div>
							<div class="card-body my-n2">
								<table class="table table-striped table-hover table-borderless">
									<thead>
										<tr>
											<th>주문상세번호</th>
											<th>환불번호</th>
											<th>환불일자</th>
											<th>환불금액</th>
											<th>상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="dto" items="${refundList}">
											<tr>
												<th>${dto.orderDetailNum}</th>
												<td>${dto.refundNum}</td>
												<td>${dto.refundDate}</td>
												<td><fmt:formatNumber value="${dto.refundAmount}" type="number" /></td>
												<c:choose>
													<c:when test="${dto.status == 0}">
														<td>신청</td>
													</c:when>
													<c:when test="${dto.status == 1}">
														<td>처리중</td>
													</c:when>
												</c:choose>
											</tr>
										</c:forEach>
									</tbody>
									<c:forEach var="i" begin="1" end="${5 - fn:length(refundList)}">
										<tr>
											<td colspan="5">&nbsp;</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 2번쨰 -->
				<div class="row">
					
					<div class="col-md-12 col-lg-6 mb-1">
						<div class="card shadow">
					    	<div id="chart-container"></div>
					    </div>
					</div>    
					<div class="col-md-12 col-lg-6 mb-1">
						<div class="card shadow">
					    	<div id="chart-container2"></div>
					    </div>
					</div>    
				</div>
			</div>    
		</div>
	</div>
</main>
<footer>
	<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<script type="text/javascript">
let packageChart;
let chart2;

$(function(){
    packageChart = Highcharts.chart('chart-container', {
        accessibility: { enabled: false },
        title: { text: '스마트팜 올해의 정기배송 매출' },
        colors: [
            '#4caefe','#3fbdf3','#35c3e8','#2bc9dc','#20cfe1','#16d4e6',
            '#0dd9db','#03dfd0','#00e4c5','#00e9ba','#00eeaf','#23e274'
        ],
        xAxis: { categories: [] },
        yAxis: {
            title: { text: '단위: 원' },
            labels: {
                formatter: function() {
                    return Highcharts.numberFormat(this.value, 0, undefined, ',') + '원';
                }
            }
        },
        series: [{
            type: 'column',
            name: '매출',
            borderRadius: 5,
            colorByPoint: true,
            data: [],
            showInLegend: false
        }]
    });

    chart2 = Highcharts.chart('chart-container2', {
        accessibility: { enabled: false },
        title: { text: '스마트팜 올해의 매출' },
        colors: [
            '#4caefe','#3fbdf3','#35c3e8','#2bc9dc','#20cfe1','#16d4e6',
            '#0dd9db','#03dfd0','#00e4c5','#00e9ba','#00eeaf','#23e274'
        ],
        xAxis: { categories: [] },
        yAxis: {
            title: { text: '단위: 원' },
            labels: {
                formatter: function() {
                    return Highcharts.numberFormat(this.value, 0, undefined, ',') + '원';
                }
            }
        },
        series: [{
            type: 'column',
            name: '매출',
            borderRadius: 5,
            colorByPoint: true,
            data: [],
            showInLegend: false
        }]
    });

    // 2. 데이터 로드
    loadChart();
    loadChart2();
});

function loadChart() {
    const chartUrl = '${pageContext.request.contextPath}/admin/packageChart';
    ajaxRequest(chartUrl, 'get', {}, 'json', function(data) {
        packageChart.update({
            xAxis: { categories: data.categories },
            series: [{ data: data.data }]
        });
    });
}

function loadChart2() {
    const chartUrl = '${pageContext.request.contextPath}/admin/chart';
    console.log(chartUrl);
    ajaxRequest(chartUrl, 'get', {}, 'json', function(data) {
        chart2.update({
            xAxis: { categories: data.categories },
            series: [{ data: data.data }]
        });
    });
}

</script>

<jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
<jsp:include page="/WEB-INF/views/admin/product/productManagementResources.jsp"/>
</div>
</body>
</html>