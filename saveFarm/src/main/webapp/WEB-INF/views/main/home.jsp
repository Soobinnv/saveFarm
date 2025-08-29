<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>saveFarm</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<style type="text/css">
/* =========================
   saveFarm Main – Full CSS
   ========================= */

/* ===== Palette ===== */
:root {
	--ink: #0f172a;
	--muted: #637081;
	--line: #e6edf4;
	--bg: #f6f9fb;
	--card: #ffffff;
	--green: #15b86d;
	--green-deep: #0f8d53;
	--orange: #ff7a45;
	--orange-deep: #f25c22;
}

/* Layout */
body {
	background: var(--bg) !important;
	color: var(--ink) !important;
}

.section {
	padding: 48px 0 !important;
}

.wrap {
	max-width: 1100px !important;
	margin: 0 auto !important;
	padding: 0 16px !important;
}

/* ===== HERO (Carousel) ===== */
#header-carousel {
	position: relative !important;
}

#header-carousel .carousel-item img {
	height: 520px !important;
	object-fit: cover !important;
}

#header-carousel .carousel-caption {
	left: 0 !important;
	right: 0 !important;
	bottom: 0 !important;
	top: 0 !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	background: linear-gradient(180deg, rgba(0, 0, 0, .25),
		rgba(0, 0, 0, .35)) !important;
	padding: 0 16px !important;
	height: 450px;
}

.hero-title {
	color: #fff !important;
	font-weight: 800 !important;
	letter-spacing: -.02em !important;
	text-shadow: 0 4px 24px rgba(0, 0, 0, .35) !important;
}

.hero-sub {
	color: #e6fff3 !important;
	margin-top: 10px !important;
	font-size: 18px !important;
}

/* spacing fix under hero */
.mt-hero-gap {
	margin-top: 12px !important;
}

/* ===== Section Title ===== */
.impact-wrap {
	max-width: 1060px !important;
	margin: 0 auto !important;
	padding: 0 16px 18px !important;
}

.section-title {
	text-align: center !important;
	margin: 28px 0 20px !important;
	margin-top: 100px !important;
}

.section-title small {
	color: var(--orange) !important;
	font-weight: 800 !important;
	letter-spacing: .08em !important;
}

.section-title h2 {
	margin: 8px 0 0 !important;
	font-weight: 800 !important;
	letter-spacing: -.02em !important;
}

.section-underline {
	width: 56px !important;
	height: 4px !important;
	border-radius: 999px !important;
	background: linear-gradient(90deg, var(--orange), var(--orange-deep))
		!important;
	margin: 10px auto 0 !important;
}

/* ===== Impact Cards Grid ===== */
.impact-grid {
	display: grid !important;
	grid-template-columns: 1fr !important;
	gap: 14px !important;
	margin-top: 100px;
}

@media ( min-width :860px) {
	.impact-grid {
		grid-template-columns: repeat(2, 1fr) !important;
	}
}

/* 카드 공통 */
.card-box {
	background-color: var(--card) !important; /* shorthand background 금지 */
	border: 1px solid var(--line) !important;
	border-radius: 16px !important;
	box-shadow: 0 10px 24px rgba(13, 30, 49, .08) !important;
	overflow: hidden !important;
	transition: transform .12s ease, box-shadow .12s ease !important;
}

.card-box:hover {
	transform: translateY(-2px) !important;
	box-shadow: 0 16px 30px rgba(13, 30, 49, .12) !important;
}

.card-body {
	padding: 18px 20px !important;
}

.card-eyebrow {
	color: var(--green-deep) !important;
	font-weight: 800 !important;
	font-size: 12px !important;
	letter-spacing: .08em !important;
}

.card-title {
	margin: 6px 0 10px !important;
	font-weight: 800 !important;
	font-size: 20px !important;
	letter-spacing: -.01em !important;
}

.card-desc {
	color: var(--muted) !important;
	line-height: 1.7 !important;
}

.card-wide {
	grid-column: 1/-1 !important;
}

/* 사진 카드 */
.card-photo {
	position: relative !important;
	min-height: 240px !important;
	display: flex !important;
	align-items: flex-end !important;
	background-position: center !important;
	background-size: cover !important;
	background-repeat: no-repeat !important;
	background-color: transparent !important;
}

.card-photo::after {
	content: "" !important;
	position: absolute !important;
	inset: 0 !important;
	background: linear-gradient(180deg, rgba(0, 0, 0, 0) 30%,
		rgba(0, 0, 0, .55) 100%) !important;
	z-index: 0 !important;
}

.card-photo .bg-fill {
	position: absolute !important;
	inset: 0 !important;
	width: 100% !important;
	height: 100% !important;
	object-fit: cover !important;
	z-index: -1 !important;
}

.card-photo .caption {
	position: relative !important;
	padding: 18px !important;
	color: #fff !important;
}

/* 배경 */
.rescue-band {
  position: relative;
  text-align: center;
  padding: 80px 20px;
  overflow: hidden;
  height: 800px;
  margin-top: 150px;
}
.rescue-bg {
  position: absolute;
  inset: 0;
  background: url('/dist/images/bg-farm.jpg') no-repeat center/cover;
  filter: blur(4px) brightness(0.7);
  z-index: 0;
}
.rescue-content {
  position: relative;
  z-index: 1;
  color: #fff;
}

/* 텍스트 */
.rescue-title {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 10px;
}
.rescue-subtitle {
  font-size: 1rem;
  opacity: 0.9;
  margin-bottom: 40px;
}

/* 그리드 */
.rescue-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  max-width: 1100px;
  height: 450px;
  margin: 0 auto 0px;
}
.rescue-card {
  transform: scale(0.7);              /* 70% 사이즈 */
  transform-origin: top center;       /* 위쪽 기준 축소 */
  background: transparent;            /* 배경 투명 */
  border: none;                       /* 테두리 제거 */
  box-shadow: none;                   /* 그림자 제거 */
  color: #fff;                        /* 기본 텍스트 흰색 */
  text-align: center;
  position: relative;
  margin-top: 100px;
}

/* 이미지 */
.rescue-card .thumb img {
  width: 100%;
  height: 220px;
  object-fit: cover;
  display: block;
  border-radius: 12px;
}

/* 상품명 텍스트 */
.rescue-card .name {
  margin: 20px 0;          /* 위아래 여백 20px */
  font-size: 1.1rem;
  font-weight: 600;
  color: #fff;             /* 흰색 */
}

/* CTA 버튼 */
.btnGreen {
  background-color: #15b86d;   /* 기존 프로젝트에서 쓰던 초록색 */
  color: #fff;
  border-radius: 8px;
  padding: 14px 28px;
  font-size: 1.2rem;
  font-weight: 600;
  transition: background .2s;
  display: inline-block;
}
.btnGreen:hover {
  background-color: #0f8d53;
}


/* ===== Regular Delivery Banner ===== */
.regular-banner {
	position: relative !important;
	min-height: 440px !important;
	border-radius: 16px !important;
	overflow: hidden !important;
	border: 1px solid var(--line) !important;
	background-size: cover !important;
	background-position: right center !important;
	background-repeat: no-repeat !important;
	margin: 36px auto 6px !important;
	margin-top: 150px !important;
}
/* 왼쪽 가독성 오버레이 */
.regular-banner::before {
	content: "" !important;
	position: absolute !important;
	inset: 0 45% 0 0 !important;
	background: linear-gradient(90deg, rgba(255, 255, 255, .96),
		rgba(255, 255, 255, .8) 70%, rgba(255, 255, 255, 0)) !important;
}

.regular-inner {
	position: relative !important;
	max-width: 1060px !important;
	margin: 0 auto !important;
	padding: 34px 22px !important;
}

.regular-copy {
	width: min(520px, 100%) !important;
}

.reg-eyebrow {
	color: var(--orange) !important;
	font-weight: 800 !important;
	letter-spacing: .06em !important;
	margin-bottom: 8px !important;
}

.reg-title {
	margin: 0 0 14px !important;
	font-weight: 900 !important;
	font-size: 34px !important;
	letter-spacing: -.02em !important;
	color: var(--ink) !important;
	line-height: 1.28 !important;
}

/* 말풍선형 리스트 */
.pills {
	display: flex !important;
	flex-direction: column !important;
	gap: 12px !important;
}

.pill {
	display: flex !important;
	align-items: center !important;
	gap: 12px !important;
	background: #ffffff !important;
	border: 1px solid #eef2f6 !important;
	border-radius: 12px !important;
	padding: 14px 16px !important;
	box-shadow: 0 6px 18px rgba(13, 30, 49, .06) !important;
}

.pill .emj {
	width: 34px !important;
	height: 34px !important;
	border-radius: 999px !important;
	display: flex !important;
	align-items: center !important;
	justify-content: center !important;
	font-size: 18px !important;
	background: #f2fff8 !important;
	color: #0f8d53 !important;
	border: 1px solid #dff4e8 !important;
}

.pill .txt {
	color: #334155 !important;
	font-size: 14px !important;
	line-height: 1.55 !important;
}

.regular-cta {
	margin-top: 16px !important;
}

/* ===== Responsive ===== */
@media ( max-width :980px) {
	#header-carousel .carousel-item img {
		height: 420px !important;
	}
	.carousel-caption{
		height: 420px !important;
	}
	.regular-banner {
		min-height: 380px !important;
		background-position: 60% center !important;
	}
	.regular-banner::before {
		inset: 0 30% 0 0 !important;
	}
}

@media ( max-width :860px) {
	.impact-grid {
		grid-template-columns: 1fr !important;
	}
}

@media ( max-width :680px) {
	#header-carousel .carousel-item img {
		height: 320px !important;
	}
	.carousel-caption{
		height: 320px !important;
	}
	
	.rescue-grid {
		grid-template-columns: repeat(2, 1fr) !important;
	}
	.regular-banner {
		min-height: 340px !important;
	}
	.regular-banner::before {
		inset: 0 0 45% 0 !important; /* 모바일은 아래쪽으로 오버레이 */
		background: linear-gradient(180deg, rgba(255, 255, 255, .96),
			rgba(255, 255, 255, .85) 70%, rgba(255, 255, 255, 0)) !important;
	}
	.regular-copy {
		width: 100% !important;
	}
	.reg-title {
		font-size: 26px !important;
	}
	
	.menu .tab-content img {
    	transition: .5s;
	}

	.menu .tab-content img:hover {
    	opacity: .7;
	}
	
	/* === Hover 효과 (이미지 살짝 확대/투명도) === */
.tab-content .position-relative img {
  transition: transform .4s ease, opacity .4s ease;
}
.tab-content .position-relative:hover img {
  transform: scale(1.03);
  opacity: 0.9;
}

/* === WOW 없이 간단한 fadeIn 대체(선택) === */
/* WOW.js + animate.css를 쓰고 있다면 이 부분은 제외하세요 */
.fadeIn {
  animation: fadeIn .6s ease both;
}
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to   { opacity: 1; transform: translateY(0); }
}
	
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<!-- ===== HERO ===== -->
	<div class="container-fluid p-0 wow fadeIn" data-wow-delay="0.1s"
		style="font-family: 'Gowun Dodum', sans-serif;">
		<div id="header-carousel" class="carousel slide"
			data-bs-ride="carousel" style="margin-top: 78px;">
			<div class="carousel-inner" style="height: 450px;">
				<div class="carousel-item active">
					<img class="w-100"
						src="${pageContext.request.contextPath}/dist/images/main_2.jpg"
						alt="hero">
					<div class="carousel-caption">
						<div class="text-center">
							<h1 class="display-5 hero-title">지속 가능한 식탁을 만듭니다</h1>
							<div class="hero-sub">남겨지는 농산물 없이, 더 공정하고 투명하게.</div>
						</div>
					</div>
				</div>
				<div class="carousel-item">
					<img class="w-100"
						src="${pageContext.request.contextPath}/dist/images/main_3.jpeg"
						alt="hero">
					<div class="carousel-caption">
						<div class="text-center">
							<h1 class="display-5 hero-title">농가의 수고가 소비자의 기쁨이 되도록</h1>
							<div class="hero-sub">현장 검증, 정직한 가격, 친환경 포장으로 연결합니다.</div>
						</div>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#header-carousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#header-carousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>

	<!-- ===== IMPACT SECTION ===== -->
	<div class="impact-wrap mt-hero-gap">
		<div class="section-title">
			<small>생산부터 유통까지 환경을 생각합니다</small>
			<h2>saveFarm의 약속</h2>
			<div class="section-underline"></div>
		</div>

		<div class="impact-grid">
			<!-- 1. Wide intro card -->
			<div class="card-box card-wide">
				<div class="card-body">
					<div class="card-eyebrow">RESCUE & FAIR</div>
					<div class="card-title">팔릴 듯 말던 농산물, 끝까지 책임집니다</div>
					<div class="card-desc">모양이 조금 달라도 맛은 같습니다. 규격에서 벗어나 버려질 위기였던
						농산물을 정당한 가격으로 매입해 상품으로 되살립니다. 생산자에겐 새로운 판로를, 소비자에겐 합리적인 선택을 제안합니다.
					</div>
				</div>
			</div>

			<!-- 2. Text card -->
			<div class="card-box">
				<div class="card-body">
					<div class="card-eyebrow">FIELD VERIFIED</div>
					<div class="card-title">현장 방문으로 생산 과정을 검증합니다</div>
					<div class="card-desc">단순 서류 심사에 그치지 않습니다. 재배 환경, 수확·선별·보관
						단계까지 직접 확인하여 투명한 과정을 보증합니다. 믿고 먹을 수 있는 식탁을 만드는 첫 단추입니다.</div>
				</div>
			</div>

			<!-- 3. Photo card -->
			<c:url var="imgSoil" value="/dist/images/main_1.png" />
			<div class="card-box card-photo">
				<img src="${imgSoil}" alt="" class="bg-fill">
				<div class="caption">
					<div class="card-eyebrow" style="color: #b9ffe1 !important;">SOIL
						TO TABLE</div>
					<div class="card-title"
						style="color: #fff !important; margin: 0 !important;">흙 내음이
						남아있는 신선함을 전합니다</div>
				</div>
			</div>

			<!-- 4. Text card -->
			<div class="card-box">
				<div class="card-body">
					<div class="card-eyebrow">LOW-WASTE PACKAGING</div>
					<div class="card-title">플라스틱 대신, 환경을 덜어내는 포장</div>
					<div class="card-desc">필요 없는 포장을 줄이고, 종이·바이오 기반 자재 비중을 높였습니다.
						재활용이 쉬운 단일 재질을 우선 활용하고, 과대 포장을 하지 않습니다.</div>
				</div>
			</div>

			<!-- 5. Text card -->
			<div class="card-box">
				<div class="card-body">
					<div class="card-eyebrow">PRICE THAT MAKES SENSE</div>
					<div class="card-title">정직한 가격, 모두가 납득하는 거래</div>
					<div class="card-desc">생산비·물류비를 투명하게 반영합니다. 소셜 임팩트를 가격에 더해
						‘착한 프리미엄’이 아닌 ‘합리적인 기본값’을 제시합니다.</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ===== 구출 상품 띠 ===== -->
	<div class="wrap" style="margin-top: 100px;">
		<section class="rescue-band">
			<!-- 흐린 배경 -->
			<div class="rescue-bg"></div>

			<div class="rescue-content">
				<h2 class="rescue-title">
					우리의 미션<br>지속 가능한 식탁
				</h2>
				<p class="rescue-subtitle">
					생산부터 유통까지 친환경을 선택합니다.<br>소비자의 건강한 식탁과 미래를 위한 환경이 지속가능하게 합니다.
				</p>

				<div class="rescue-grid">
					<article class="rescue-card" onclick="location.href='/products/7?classifyCode=100'">
						<div class="thumb">
							<img
								src="${pageContext.request.contextPath}/uploads/product/cucumber.jpg"
								alt="샘플1">
						</div>
						<div class="name">싱싱한 다다기 오이</div>
					</article>
					<article class="rescue-card" onclick="location.href='/products/1?classifyCode=100'">
						<div class="thumb">
							<img
								src="${pageContext.request.contextPath}/uploads/product/apple.jpg"
								alt="샘플2">
						</div>
						<div class="name">햇살 유기농 사과</div>
					</article>
					<article class="rescue-card" onclick="location.href='/products/9?classifyCode=100'">
						<div class="thumb">
							<img
								src="${pageContext.request.contextPath}/uploads/product/garlic.jpg"
								alt="샘플3">
						</div>
						<div class="name">의성 육쪽 마늘</div>
					</article>
					<article class="rescue-card" onclick="location.href='/products/8?classifyCode=100'">
						<div class="thumb">
							<img
								src="${pageContext.request.contextPath}/uploads/product/lettuce.jpg"
								alt="샘플4">
						</div>
						<div class="name">친환경 유기농 상추</div>
					</article>
				</div>

				<div class="rescue-cta">
					<a href="${pageContext.request.contextPath}/products"
						class="btnGreen btn-lg">채소 구출하기</a>
				</div>
			</div>
		</section>
	</div>



	<c:url var="regularBg" value="/dist/images/main_4.png" />

	<section class="regular-banner"
		style="background-image:url('${regularBg}');"  >
		<div class="regular-inner">
			<div class="regular-copy">
				<div class="reg-eyebrow">바쁜 일상에서도 꾸준한 채소 루틴</div>
				<h2 class="reg-title">
					모양은 달라도 신선함은 그대로<br /> 정기배송으로 편하게 채워요
				</h2>

				<div class="pills">
					<div class="pill">
						<div class="emj">🥬</div>
						<div class="txt">채소 섭취를 늘리고 균형 잡힌 식사를 하고 싶어요</div>
					</div>
					<div class="pill">
						<div class="emj">🥕</div>
						<div class="txt">장보면 늘 비슷한 채소만 담게 돼요</div>
					</div>
					<div class="pill">
						<div class="emj">📦</div>
						<div class="txt">제철 채소를 알맞은 양으로 정기적으로 받고 싶어요</div>
					</div>
				</div>

				<div class="regular-cta">
					<a href="${pageContext.request.contextPath}/package/main"
						class="btnGreen">정기배송 더 알아보기</a>
				</div>
			</div>
		</div>
	</section>



	<footer class="section" style="padding-top: 24px !important;">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />
</body>
</html>
