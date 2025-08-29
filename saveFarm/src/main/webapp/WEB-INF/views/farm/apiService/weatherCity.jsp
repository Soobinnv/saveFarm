<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">
.weather-icon {
    width: 50px;
    height: 50px;
}

.weather-card {
    min-height: 215px;
    /* border: 1px solid #0d6efd; */
    border: 1px solid #e0e0e0;
    border-radius: 15px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.weather-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.weather-city {
    /* background-color: #0d6efd;
    color: white; */
    background-color: #f8f9fa;
    
    border-radius: 15px 15px 0 0;
    padding: 0.5rem;
    font-weight: 600;
}
.text-precip {
    color: #198754;
}
.current-time {
    font-size: 1.1rem;
    font-weight: 500;
    color: #333;
}
</style>
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
	<!-- Page Title -->
	<div class="page-title">
		<div class="container align-items-center" data-aos="fade-up">
			<h1>지역별 날씨 정보</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
		
			<div class="row justify-content-center">
				<div class="col-md-10 text-end py-2">
					<span class="current-time"></span>
				</div>
								
				<div class="col-md-10 bg-white box-shadow mt-1 mb-4 p-5">
					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4 weather-box"></div>
				</div>
			</div>
			
		</div>
	</div>
</main>

<script type="text/javascript">
$(function(){
	let url = '${pageContext.request.contextPath}/apiService/weatherXML';
	
	const fn = function(data) {
		cityWeather(data);
	};
	
	ajaxRequest(url, 'get', null, 'xml', fn);
});

function cityWeather(data) {
	let iconUrl = '${pageContext.request.contextPath}/dist/wicon/';

	let year = $(data).find('weather').attr('year');
	let month = $(data).find('weather').attr('month');
	let day = $(data).find('weather').attr('day');
	let hour = $(data).find('weather').attr('hour');
	
	const citys = ['서울', '인천', '수원', '춘천', '강릉', '청주', '대전', '대구', '포항', '부산', '창원', '전주', '광주', '목포', '제주', '울릉도'];
	const items = [];
	
	$(data).find('local').each(function(){
		let item = $(this);
		if(citys.includes(item.text())) {
			let city = item.text();
			let icon = item.attr('icon') + '.png';
			let desc = item.attr('desc') || ''; // 날씨
			let ta = item.attr('ta') || ''; // 현재 기온
			let rn_hr1 = item.attr('rn_hr1') || ''; // 시간당 강수량
			
			let obj = {city:city, icon:icon, desc:desc, ta:ta, rn_hr1:rn_hr1};
			items.push(obj);
		}
	});
	
	let out = `\${year}년 \${month}월 \${day}일 \${hour}시 발표`
	document.querySelector('.current-time').textContent = out;

 	out = '';
	for(let item of items) {
		out += `
			<div class="col">
				<div class="weather-card text-center p-3">
					<div class="weather-city">\${item.city}</div>
					<img src="\${iconUrl + item.icon}" class="weather-icon mt-2">
					<p class="mt-2 mb-1 fw-bold">\${item.desc}</p>
					<p class="mb-1">기온: \${item.ta}°C</p>
					<p class="mb-0 text-precip">\${item.rn_hr1 ? '강수량: ' + item.rn_hr1 + 'mm' : ''}</p>
				</div>
			</div>
		`;
	}
	
	$('.weather-box').html(out);
}

</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>