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
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

    <!-- Carousel Start -->
    <div class="container-fluid mt-5 p-0 mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div id="header-carousel" class="carousel slide" data-bs-ride="carousel" style="font-family: Gowun Dodum, sans-serif;">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="w-100" src="${pageContext.request.contextPath}/dist/images/farm1.jpeg" alt="Image">
                    <div class="carousel-caption">
                        <div class="container">
                            <div class="row justify-content-start">
                                <div class="col-lg-7">
                                    <h1 class="display-2 mb-5 animated slideInDown" >농가와 지속가능한 식탁을 만듭니다.</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <img class="w-100" src="${pageContext.request.contextPath}/dist/images/farm2.jpg" alt="Image">
                    <div class="carousel-caption">
                        <div class="container">
                            <div class="row justify-content-start">
                                <div class="col-lg-7">
                                    <h1 class="display-2 mb-5 animated slideInDown">농가의 짐에서 소비자의 보물로</h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#header-carousel"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
    <!-- Carousel End -->


    <!-- About Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                    <div class="about-img position-relative overflow-hidden p-5 pe-0">
                        <img class="img-fluid w-100" src="${pageContext.request.contextPath}/dist/images/about.jpg">
                    </div>
                </div>
                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                    <h1 class="display-5 mb-4">saveFarm의 원칙들</h1>
                    <p class="mb-4">saveFarm 만의 원칙들은 소비자와 농가의 이익을 중점으로 짜여있습니다 </p>
                    <p><i class="fa fa-check text-orange me-3"></i>현장방문을 통한 농산물 생산과정 검증</p>
                    <p><i class="fa fa-check text-orange me-3"></i>하자 상품 전액 환불 보상</p>
                    <p><i class="fa fa-check text-orange me-3"></i>대량생산된 못난이 채소를 기존가보다 더 낮은 가격으로 제공</p>
                     <p><i class="fa fa-check text-orange me-3"></i>농가와 직접 입찰을 진행한 상품만 판매</p>
                     <p><i class="fa fa-check text-orange me-3"></i>허브에서 상품을 입고하여 상품을 확인하고 고객에게 제공</p>
                </div>
            </div>
        </div>
    </div>
    <!-- About End -->
			
	<!-- Rescue Section Start -->
<div class="rescue-section text-center py-5">
    <div class="container">

        <!-- 이미지 + 설명 -->
        <div class="row justify-content-center align-items-center mb-4" style="font-family: Gamja Flower, sans-serif;">
            <div class="col-md-4">
                <p>콕 찍은 듯한 오이와 같은 밭에서 자랐어요!</p>
                <img src="${pageContext.request.contextPath}/dist/images/ugly-cucumber.png" class="rescue-img" alt="오이">
            </div>
            <div class="col-md-4">
                <p>딱 숨어서 어렵게 꺼낸 자색당근이에요!</p>
                <img src="${pageContext.request.contextPath}/dist/images/ugly-carrot.png" class="rescue-img" alt="당근">
            </div>
        </div>

        <!-- 버튼 -->
        <a href="#" class="btn btnOrange rounded-pill px-4 py-2 mb-5">채소 구출하기</a>


    </div>
</div>
<!-- Rescue Section End -->

<div class="regular-delivery-section text-center py-5">
    <div class="container">
        <!-- 정기배송 장점 카드 -->
        <div class="row justify-content-center g-4">
            <div class="col-sm-4">
                <div class="rescue-card">
                    정기배송 장점
                </div>
            </div>
            <div class="col-sm-4">
                <div class="rescue-card">
                    정기배송 장점
                </div>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <a href="#" class="btn btnGreen rounded-pill px-4 py-2 mt-5">정기배송 더 알아보기</a>
    </div>
</div>
	
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

</body>
</html>