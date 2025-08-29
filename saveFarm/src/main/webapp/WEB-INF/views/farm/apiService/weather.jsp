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
.weather-card {
    text-align: center;
    padding: 15px 10px;
    margin-bottom: 20px;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    transition: transform 0.2s ease-in-out;
    background-color: #fcfcfc;
}
.weather-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}
.weather-card img {
    width: 60px;
    height: 60px;
    margin-bottom: 10px;
}
.weather-time {
    font-weight: bold;
    font-size: 1.1em;
    color: #343a40;
    margin-bottom: 5px;
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
			<h1>날씨 정보</h1>
			<div class="page-title-underline-accent"></div>
		</div>
	</div>
    
	<!-- Page Content -->    
	<div class="section">
		<div class="container" data-aos="fade-up" data-aos-delay="100">
		
			<div class="row justify-content-center g-3">
				<div class="col-md-10">
					<div class="row">
						<div class="col"><h5>현재 위치</h5></div>
						<div class="col text-end  current-time"></div>
					</div>
				</div>
				<div class="col-md-10 bg-white box-shadow mt-2 mb-5 p-5">
					<div class="row">
						<div class="col fs-6 current-address"></div>
						<div class="col text-end current-location"></div>
					</div>
				</div>
				
				<div class="col-md-10">
					<div class="row">
						<div class="col"><h5>날씨</h5></div>
						<div class="col text-end weather-baseDate"></div>
					</div>
				</div>
				<div class="col-md-10 bg-white box-shadow mt-2 mb-5 p-5">
					<div class="current-weather text-center mb-3"></div>
					
					<div class="row forecast-weather"></div>
				</div>
			</div>

		</div>
	</div>
</main>

<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js2/currentDate.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js2/location.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/dist/js2/weather.js"></script>

<script type="text/javascript">
$(function(){
	// 현재 시간
	currentDateTime();
	
	// 현재 위치 정보 : 래터튜드(latitude, 위도), 란저튜드(longitude, 경도)
	getCurrentLocation().then(location => {
		if (location) {
			const { latitude, longitude } = location;
			
			// 현재위치 위도, 경도
			document.querySelector('.current-location').innerHTML  =`위도: \${latitude}, 경도: \${longitude}`;
			
			// 주소
			loactionAddress(latitude, longitude);
			
			let options = {latitude:latitude, longitude: longitude};
			options.serviceKey = '공공API_서비스키';
			
			// 현재 날씨(날씨 예측 첫번째 데이터로 처리)
			// ncstWeather(options);
			
			// 날씨 예측
			fcstWeather(options);
		} else {
			console.log("위치 정보를 얻을 수 없습니다.");
		}
	}).catch(error => {
		console.error("위치 정보 처리 중 오류 발생:", error);
	});
});

// 현재 시간
function currentDateTime() {
	const el = document.querySelector('.current-time');
	el.textContent = formatDate(new Date());
	
	startClock((currentTime) => {
		el.textContent = currentTime;
	});
}

// 위치 기반 주소
function loactionAddress(lat, lon) {
	getAddressFromCoordinates(lat, lon).then(addr => {
		if (addr) {
			const { province, city, borough, suburb, road } = addr;
			
			let result = province ? province + ' ' : '';
			result += city ? city + ' ' : '';
			result += borough ? borough + ' ' : '';
			result += suburb ? suburb + ' ' : '';
			result += road;
			
			document.querySelector('.current-address').textContent = result;
		} else {
			console.log("주소 정보를 얻을 수 없습니다.");
		}
	}).catch(error => {
		console.error("주소 정보 처리 중 오류 발생:", error);
	});
}

// 현재 날씨
function ncstWeather(options) {
	getUltraSrtNcstWeather(options).then(result => {
		if (result) {
			document.querySelector('.current-weather').innerHTML =`
				<div class="fs-1">
					<span>\${result.ptyIcon}</span><span>\${result.temperature}°C</span>
				</div>
				<div class="p-2">
					<span>\${result.ptyDescription}</span> |
					습도 <span class="fw-semibold">\${result.humidity}%</span> |
					<span>\${result.windText}</span> <span class="fw-semibold">\${result.windSpeed}m/s</span>
					\${result.precipitation1h !== '0' ? '| 1시간 강수량 <span class="fw-semibold">' +  result.precipitation1h + 'mm</span>': ''}
				</div>
			`;
		} else {
			console.log("날씨 정보를 얻을 수 없습니다.");
		}
	}).catch(error => {
		console.error("날씨 정보 처리 중 오류 발생:", error);
	});
}

// 날씨 예측
function fcstWeather(options) {
	getUltraSrtFcstWeather(options).then(result => {
		if (result) {
			document.querySelector('.weather-baseDate').innerHTML  =`\${result.dateTime} 기준`;
			
			let item = result.weathers[0];
			document.querySelector('.current-weather').innerHTML =`
				<div class="fs-1">
					<span>\${item.ptyCode === '0' ? item.skyIcon : item.ptyIcon}</span><span>\${item.temperature}°C</span>
				</div>
				<div class="p-2">
					<span>\${item.ptyCode === '0' ? item.skyState : item.ptyDescription}</span> |
					습도 <span class="fw-semibold">\${item.humidity}%</span> |
					<span>\${item.windText}</span> <span class="fw-semibold">\${item.windSpeed}m/s</span>
					\${item.ptyCode !== '0' ? '| 1시간 강수량 <span class="fw-semibold">' +  item.precipitation1h + '</span>': ''}
				</div>
			`;
			
			let htmlContent  = '';
			for(let item of result.weathers) {
				htmlContent += `
					<div class="col-6 col-md-4 col-lg-2">
						<div class="weather-card">
							<div class="weather-time">\${item.fcstTime.substring(0, 2)}시</div>
							<div class="weather-icon">\${item.ptyCode === '0' ? item.skyIcon : item.ptyIcon}</div>
							<div class="weather-temp">\${item.temperature}°C</div>
							<div class="weather-description">\${item.ptyCode === '0' ? item.skyState : item.precipitation1h}</div>
						</div>
					</div>
                `;				
			}
			
			document.querySelector('.forecast-weather').innerHTML = htmlContent;
			
		} else {
			console.log("날씨 정보를 얻을 수 없습니다.");
		}
	}).catch(error => {
		console.error("날씨 정보 처리 중 오류 발생:", error);
	});
}

</script>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>