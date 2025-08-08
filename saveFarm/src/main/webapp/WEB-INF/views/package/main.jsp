<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<style type="text/css">

body{
	font-family: Gowun Dodum, sans-serif; 
}

.veggie-banner {
    background-color: #ffe7dd;
    max-width: 800px;
    color: #5c3c2d;
    margin-top: 200px;
}

.text-orange {
    color: #e17738;
}

.btnGreen {
    background-color: #039a63;
    color: #fff;
    transition: 0.3s;
    border: none;
}

.btnGreen:hover {
    background-color: #028453;
}

.btn-orange {
    background-color: #ffab91;
    color: #fff;
    border: none;
}

.btn-orange:hover {
    background-color: #ff7043;
}

.btn-sky {
    background-color: #90caf9;
    color: #fff;
    border: none;
}

.btn-sky:hover {
    background-color: #42a5f5;
}

.card-header {
    text-align: center;
    margin-bottom: 1rem;
}

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>
<!-- 정기배송 소개 배너 -->
<div class="veggie-banner text-center py-5 px-3 rounded-4 mx-auto mb-5">
    <h2 class="fw-bold mb-2">“장보기 귀찮을 땐? <br>신선한 채소가 집으로 와요!”</h2>
    <p class="fs-5">오늘도 당신을 대신해 못난이 채소가 달려갑니다.</p>
    <p class="fw-bold text-orange">매번 바뀌는 구성! 절약은 덤!</p>
</div>

<!-- 구독자 후기 섹션 -->
<div class="container mb-5 pt-5">
    <h4 class="text-center mb-4">못난이 채소를 구해준 용사님들의 후기</h4>

    <div class="row g-4 justify-content-center">
        <!-- 후기 카드 반복 -->
        <div class="col-md-3">
            <div class="card h-100 border-0 shadow-sm">
                <img src="/dist/images/후기이미지1.png" class="card-img-top rounded-top" alt="후기 이미지">
                <div class="card-body">
                    <small class="text-muted">2024.07.01 | by 채소구출러</small>
                    <p class="card-text mt-2">아이가 너무 잘 먹어서 정기구독 끊었어요! 구성도 좋고 신선해요.</p>
                </div>
            </div>
        </div>
        <!-- 추가 카드 복붙 -->
    </div>

    <div class="text-center mt-4">
        <a href="#" class="btn btnGreen rounded-pill px-4 py-2 fw-bold">구독 후기 구경하기</a>
    </div>
</div>

<!-- 🥬 구성별 패키지 소개 섹션 -->
<div class="container my-5 pt-5">
    <h4 class="text-center fw-bold mb-5">매번 바뀌는 구성으로 즐기는 패키지!</h4>

    <div class="row g-4 justify-content-center">
        <!-- 집밥박스 카드 -->
        <div class="col-md-5">
            <div class="card veggie-card shadow-sm border-0 h-100 text-center p-4" style="background-color: #fff3e0;">
                
                <!-- 카드 상단 텍스트 -->
                <div class="card-header bg-transparent border-0">
                    <h5 class="fw-bold mb-1">집밥패키지</h5>
                    <small class="text-muted">다양한 제철 채소로 집밥을 가볍게 요리!</small>
                </div>

                <img src="/dist/images/veggie-box-1.png" class="card-img-top rounded-3 mx-auto my-3" style="max-width: 280px;" alt="집밥박스">

                <div class="card-body">
                    <p class="card-text">집에서 요리도 즐기고 농부에게 직접 수확 받은 못난이 채소를 가볍게 조리해보세요. 건강과 맛이 함께 와요!</p>
                    <a href="#" class="btn btn-orange rounded-pill px-4 fw-bold mt-3">식탁 세이버 패키지 구매하러 가기 ❗❗</a>
                </div>
            </div>
        </div>

        <!-- 샐러드박스 카드 -->
        <div class="col-md-5">
            <div class="card veggie-card shadow-sm border-0 h-100 text-center p-4" style="background-color: #f3f0ff;">
                
                <!-- 카드 상단 텍스트 -->
                <div class="card-header bg-transparent border-0">
                    <h5 class="fw-bold mb-1">샐러드패키지</h5>
                    <small class="text-muted">날로 즐기는 신선 채소로 간편하게 샐러드!</small>
                </div>

                <img src="/dist/images/veggie-box-2.png" class="card-img-top rounded-3 mx-auto my-3" style="max-width: 280px;" alt="샐러드박스">

                <div class="card-body">
                    <p class="card-text">직접 조리하기에는 시간이 어려우셨다면, 바로 씻고 먹을 수 있는 채소로 식이섬유도 챙기고 간편하게 한끼 해결하세요!</p>
                    <a href="#" class="btn btn-sky rounded-pill px-4 fw-bold mt-3">샐러드 세이버 패키지 구매하러 가기 ❗❗</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>


</body>
</html>