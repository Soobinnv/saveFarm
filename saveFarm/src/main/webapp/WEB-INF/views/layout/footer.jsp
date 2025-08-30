<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- Footer Start -->
<style>
    /* 전체 푸터 컨테이너 */
    .footer.savefarm-footer {
        background-color: #039a63 !important; /* 메인 색상 변경 */
        color: #e0f2f1 !important; /* 기본 텍스트 색상 (가독성 좋게 조정) */
        font-size: 14px !important;
    }

    /* 로고 텍스트 */
    .footer.savefarm-footer .logo {
        color: #ffffff !important;
        font-weight: 800 !important;
        font-family: 'Poppins', sans-serif !important;
    }

    /* 푸터 내 링크 스타일 */
    .footer.savefarm-footer a {
        color: #ffffff !important; /* 기본 링크는 흰색으로 강조 */
        text-decoration: none !important;
        transition: color 0.3s !important;
    }

    /* 링크 호버(hover) 시 */
    .footer.savefarm-footer a:hover {
        color: #c8e6c9 !important; /* 연한 녹색으로 변경 */
    }
    
    /* 각 섹션 제목 */
    .footer.savefarm-footer h5 {
    	font-weight: 600 !important;
    	color: #ffffff !important;
    	margin-bottom: 20px !important;
    }
    
    /* 회사 정보 및 서브 텍스트 */
    .footer.savefarm-footer .company-info p,
    .footer.savefarm-footer .cs-info-sub {
    	margin-bottom: 5px !important;
    	font-size: 13px !important;
    	color: #b2dfdb !important; /* 메인 색상과 어울리는 밝은 톤으로 조정 */
    }
    
    /* 고객센터 전화번호 */
    .footer.savefarm-footer .cs-info {
        font-size: 18px !important;
        font-weight: bold !important;
        color: #ffffff !important;
    }

    /* 하단 저작권 섹션 */
    .copyright.savefarm-copyright {
        background-color: #027a4e !important; /* 메인 색상보다 어두운 녹색 */
        color: #b2dfdb !important;
        padding-top: 20px !important;
        padding-bottom: 20px !important;
        border-top: 1px solid #028a58 !important; /* 구분선 색상 조정 */
    }
	
	footer.section {
		padding-bottom: 0px !important;
	}
</style>

<div class="container-fluid footer savefarm-footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-4 col-md-6">
                <h1 class="fw-bold mb-4 logo">saveFarm</h1>
                <p>농가의 정성이 담긴 신선한 농산물을 식탁까지 안전하게 전달합니다. 지속 가능한 농업을 응원합니다.</p>
                <div class="company-info mt-4">
                    <p>상호명: (주)세이브팜 | 대표: 김사과</p>
                    <p>사업자등록번호: 123-45-67890</p>
                    <p>통신판매업신고: 제2025-서울강남-1234호</p>
                    <p>주소: 서울특별시 강남구 테헤란로 123, 45층</p>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <h5>고객센터</h5>
                <p class="cs-info">1588-0000</p>
                <p class="cs-info-sub">평일 09:00 ~ 18:00 (점심 12:00 ~ 13:00)</p>
                <p class="cs-info-sub">주말 및 공휴일 휴무</p>
                <div class="mt-3">
                    <a class="btn btn-link px-0" href="#">1:1 문의</a><br>
                    <a class="btn btn-link px-0" href="#">자주묻는질문</a>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <h5>바로가기</h5>
                <a class="btn btn-link" href="#">saveFarm 소개</a>
                <a class="btn btn-link" href="#">이용약관</a>
                <a class="btn btn-link" href="#"><strong>개인정보처리방침</strong></a>
                <a class="btn btn-link" href="#">공지사항</a>
                <a class="btn btn-link" href="${pageContext.request.contextPath}/farm">농가 페이지</a>
            </div>
        </div>
    </div>
    
</div>
    <div class="container-fluid copyright savefarm-copyright">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    &copy; saveFarm, All Right Reserved.
                </div>
            </div>
        </div>
    </div>
    <!-- Footer End -->
    <!-- Back to Top -->
    <a href="#" class="goToTopBtn btn btn-lg btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>

<!-- Preloader -->
<div id="preloader"></div>
<div id="loadingLayout"></div>