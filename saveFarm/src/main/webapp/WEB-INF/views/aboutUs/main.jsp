<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>saveFarm</title>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Save Farm - 못난이 농산물의 가치를 바꾸다</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/dist/css/aboutUs.css"
		type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    <div class="hero-section">
        <div class="hero-overlay">
            <div class="container">
                <h1>지속가능한 농업을 지지함으로써<br>우리의 땅과 미래를 더 건강하게 만듭니다.</h1>
                <p>못난이 농산물에 새로운 가치를 부여하는 것, 분명한 변화의 시작입니다.</p>
            </div>
        </div>
    </div>

    <main>
        <section class="problem-section">
            <div class="container">
                <div class="section-title">
                    <h2>지구 온난화를 가속화시키는<br>농산물 폐기 문제</h2>
                </div>
                <div class="content-wrapper">
                    <div class="image-box">
                        <img src="https://images.unsplash.com/photo-1518977676601-b53f82aba655?q=80&w=2070&auto=format&fit=crop" alt="밭에 있는 신선한 감자들">
                    </div>
                    <div class="text-box">
                        <h3>완벽한 외형이 아니라는 이유로 버려지는 농산물, 이제는 바뀌어야 합니다.</h3>
                        <p>소비자의 선택을 받기 위해, 그리고 대형 유통 체인 속 편의를 위해 균일하고 깨끗한 농산물만이 '정상품'으로 분류됩니다. 조금 작거나, 크거나, 개성있게 생겼다는 이유로 맛과 영양이 똑같은 수많은 농산물이 판로를 찾지 못하고 버려집니다.</p>
                        <p>이렇게 버려지는 농산물은 전 세계 생산량의 1/3에 달하며, 이는 온실가스를 배출해 환경을 오염시키고, 생산에 투입된 물과 에너지, 농부의 노력을 헛되게 만드는 사회적, 환경적 손실입니다.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="solution-section">
            <div class="container">
                <div class="section-title">
                    <h2>생산부터 유통까지 환경을 생각합니다</h2>
                </div>
                <div class="card-container">
                    <div class="card">
                        <div class="card-icon">1</div>
                        <h3>판로를 잃은 농산물 구출</h3>
                        <p>개성 있는 외형으로 판로를 잃은 농산물, 잉여 농산물을 산지에서 직접 수매해 합리적인 가격으로 제공하고 농가의 시름을 덜어줍니다.</p>
                    </div>
                    <div class="card">
                        <div class="card-icon">2</div>
                        <h3>친환경 생산의 확대</h3>
                        <p>자연 생태계와 함께 지속가능한 땅을 늘려나갑니다. 저희가 직접 모든 농가를 방문하여 생산 환경을 확인하고, 친환경 농산물을 우선으로 선택합니다.</p>
                    </div>
                    <div class="card">
                        <div class="card-icon">3</div>
                        <h3>플라스틱 없는 포장</h3>
                        <p>농산물의 신선도를 지키는 최소한의 포장을 추구합니다. 종이백과 펄프 용기, 생분해 비닐을 사용하여 플라스틱 사용을 지양합니다.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="cta-section">
            <div class="container">
                <div class="content-wrapper">
                    <div class="text-box">
                        <h2>불필요한 낭비를 막고,<br>농산물의 가치 기준을 바꿉니다.</h2>
                        <p>농산물의 품질은 외형이 아닌 신선함, 맛 그리고 건강한 생산 과정에 있다는 믿음으로, 못난이 농산물을 합리적인 가격으로 정산하여 농가와 소비자 모두가 지속가능한 생산과 소비를 할 수 있도록 돕겠습니다.</p>
                        <a href="${pageContext.request.contextPath}/products" class="cta-button">함께 변화 만들러 가기</a>
                    </div>
                    <div class="image-box">
						 <img src="${pageContext.request.contextPath}/dist/images/product/aboutUsPotato.png" alt="독특한 모양 감자">
					</div>
                </div>
            </div>
        </section>
    </main>

	<footer class="section" style="padding-top: 24px !important;">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<jsp:include page="/WEB-INF/views/layout/footerResources.jsp" />

</body>
</html>