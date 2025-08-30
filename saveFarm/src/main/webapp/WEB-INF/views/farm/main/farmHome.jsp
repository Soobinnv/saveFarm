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

<jsp:include page="/WEB-INF/views/farm/layout/farmMainResources.jsp"/>
<!-- ======= Site Wrap =======-->
<div class="site-wrap">
	<!-- ======= Main =======-->
	<main>
<!-- ======= Hero =======-->
	<section class="hero__v6 section" id="home">
	  <div class="container">
	    <div class="row">
	      <div class="col-lg-6 mb-4 mb-lg-0">
	        <div class="row">
	          <div class="col-lg-11"><span class="hero-subtitle text-uppercase" data-aos="fade-up" data-aos-delay="0">농민을 위한 실용적인 판매 솔루션</span>
	            <h1 class="hero-title mb-3" data-aos="fade-up" data-aos-delay="100">못난이 농산물도,<br>제값 받는 길이 있습니다</h1>
	            <p class="hero-description mb-4 mb-lg-5" data-aos="fade-up" data-aos-delay="200">농가 전용 판매 플랫폼에서, 재고는 줄이고 소득은 올리세요. 소규모 농가부터 대형 농장까지, 누구나 쉽게 시작할 수 있습니다.</p>
	            <div class="cta d-flex gap-2 mb-4 mb-lg-5" data-aos="fade-up" data-aos-delay="300">
		            <c:choose>
		            	<c:when test="${empty sessionScope.farm}">
			            	<a class="btn btn-primary" href="${pageContext.request.contextPath}/farm/member/login"> 농장 열기 </a>
		            	</c:when>
		            	<c:when test="${not empty sessionScope.farm}">
			            	<a class="btn btn-primary" href="${pageContext.request.contextPath}/farm/crops/list"> 농장재고 관리 </a>
		            	</c:when>
		            </c:choose>
		            <a class="btn btn-white-outline" href="${pageContext.request.contextPath}/farm/guide">이용 가이드 
		                <svg class="lucide lucide-arrow-up-right" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewbox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                  <path d="M7 7h10v10"></path>
		                  <path d="M7 17 17 7"></path>
		                </svg>
	                </a>
                </div>
	            <div class="logos mb-4" data-aos="fade-up" data-aos-delay="400"><span class="logos-title text-uppercase mb-4 d-block">전국 농가가 함께하는 믿을 수 있는 플랫폼</span>
	              <div class="logos-images d-flex gap-4 align-items-center"></div>
	            </div>
	          </div>
	        </div>
	      </div>
	      <div class="col-lg-6">
	        <div class="hero-img"><img class="img-card img-fluid" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/mainTitle2.png" alt="Image card" data-aos="fade-down" data-aos-delay="600"><img class="img-main img-fluid rounded-4" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/mainTitle1.jpg" alt="Hero Image" data-aos="fade-in" data-aos-delay="500"></div>
	      </div>
	    </div>
	  </div>
	  <!-- End Hero-->
	</section>
	<!-- End Hero-->
	
	<!-- ======= About =======-->
	<section class="about__v4 section" id="about">
	  <div class="container">
	    <div class="row">
	      <div class="col-md-6 order-md-2">
	        <div class="row justify-content-end">
	          <div class="col-md-11 mb-4 mb-md-0"><span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">정성과 땀이 들어간 농산물, 제대로 팔겠습니다</span>
	            <h2 class="mb-4" data-aos="fade-up" data-aos-delay="100">농민과 소비자 사이,<br> 우리가 직접 책임집니다</h2>
	            <div data-aos="fade-up" data-aos-delay="200">
	              <p>우리는 <strong>못난이 농산물</strong>도 가치를 인정받는 세상을 꿈꿉니다.<br> 우리는 버려지기 쉬운 못난이 농산물을 정가로 직접 매입하여, 소포장 단위로 소비자에게 판매하는 유통 플랫폼입니다. 농가의 판로 걱정을 덜고, 소비자에게는 믿을 수 있는 먹거리를 제공합니다.</p>
	              <p>농산물의 가치를 재발견하고 합리적인 유통 과정을 만들어 나가는 것이 우리의 목표입니다. 누구나, 어디서든 쉽게 건강한 먹거리를 만날 수 있도록 돕겠습니다.</p>
	            </div>
	            <h4 class="small fw-bold mt-4 mb-3" data-aos="fade-up" data-aos-delay="300">핵심 가치와 비전</h4>
	            <ul class="d-flex flex-row flex-wrap list-unstyled gap-3 features" data-aos="fade-up" data-aos-delay="400">
	              <li class="d-flex align-items-center gap-2"><span class="icon rounded-circle text-center"><i class="bi bi-check"></i></span><span class="text">유통의 정직함</span></li>
	              <li class="d-flex align-items-center gap-2"><span class="icon rounded-circle text-center"><i class="bi bi-check"></i></span><span class="text">농산물의 가치 회복</span></li>
	              <li class="d-flex align-items-center gap-2"><span class="icon rounded-circle text-center"><i class="bi bi-check"></i></span><span class="text">고른 기회 제공 </span></li>
	              <li class="d-flex align-items-center gap-2"><span class="icon rounded-circle text-center"><i class="bi bi-check"></i></span><span class="text">건강한 먹거리</span></li>
	              <li class="d-flex align-items-center gap-2"><span class="icon rounded-circle text-center"><i class="bi bi-check"></i></span><span class="text">지속가능한 농업</span></li>
	            </ul>
	          </div>
	        </div>
	      </div>
	      <div class="col-md-6"> 
	        <div class="img-wrap position-relative"><img class="img-fluid rounded-4" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/mainTitle4.png" alt="FreeBootstrap.net image placeholder" data-aos="fade-up" data-aos-delay="0">
	          <div class="mission-statement p-4 rounded-4 d-flex gap-4" data-aos="fade-up" data-aos-delay="100">
	            <div class="mission-icon text-center rounded-circle"><i class="bi bi-lightbulb fs-4"></i></div>
	            <div>
	              <h3 class="text-uppercase fw-bold">우리의 약속</h3>
	              <p class="fs-5 mb-0">우리는 못난이 농산물의 가치를 알아보고,<br>누구나 건강한 먹거리를 누릴 수 있는 세상을 만듭니다.</p>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End About-->
	
	<!-- ======= Features =======-->
	<section class="section features__v2" id="features">
	  <div class="container">
	    <div class="row">
	      <div class="col-12">
	        <div class="d-lg-flex p-5 rounded-4 content" data-aos="fade-in" data-aos-delay="0" style="background: #F5FFF4">
	          <div class="row">
	            <div class="col-lg-5 mb-5 mb-lg-0" data-aos="fade-up" data-aos-delay="0">
	              <div class="row"> 
	                <div class="col-lg-11">
	                  <div class="h-100 flex-column justify-content-between d-flex">
	                    <div>
	                      <h2 class="mb-4">우리가 직접 팔기에, <br> 믿고 선택할 수 있습니다</h2>
	                      <p class="mb-5">못난이 농산물도 정당한 가치를 받아야 한다고 믿습니다.<br> 우리는 농가로부터 직접 매입한 농산물을 <br>  믿을 수 있는 단위로 판매하여 <br>  농민과 소비자 모두에게 이로운 유통 생태계를 만들어갑니다.</p>
	                    </div>
	                    <div class="align-self-start"><a class="glightbox btn btn-play d-inline-flex align-items-center gap-2" href="https://youtu.be/LQcxDmSYVRc?feature=shared" data-gallery="video"><i class="bi bi-play-fill"></i> 못난이 농산물이 오는 길</a></div>
	                  </div>
	                </div>
	              </div>
	            </div>
	            <div class="col-lg-7">
	              <div class="row justify-content-end">
	                <div class="col-lg-11">
	                  <div class="row">
	                    <div class="col-sm-6" data-aos="fade-up" data-aos-delay="0">
	                      <div class="icon text-center mb-4"><i class="bi bi-cart-check fs-4"></i></div>
	                      <h3 class="fs-6 fw-bold mb-3">쉽고 믿을 수 있는 구매</h3>
	                      <p>복잡한 절차 없이, 누구나 간편하게 신선한 농산물을 구매할 수 있어요.</p>
	                    </div>
	                    <div class="col-sm-6" data-aos="fade-up" data-aos-delay="100">
	                      <div class="icon text-center mb-4"><i class="bi bi-cash-coin fs-4"></i></div>
	                      <h3 class="fs-6 fw-bold mb-3">직접 매입, 정직한 가격</h3>
	                      <p>유통 마진 없이, 농가에서 직접 매입해 가격은 정직하게.</p>
	                    </div>
	                    <div class="col-sm-6" data-aos="fade-up" data-aos-delay="200">
	                      <div class="icon text-center mb-4"><i class="bi bi-box-seam fs-4"></i></div>
	                      <h3 class="fs-6 fw-bold mb-3">소포장 단위 배송</h3>
	                      <p>소비자가 원하는 만큼, 합리적인 양으로 알차게 보내드려요.</p>
	                    </div>
	                    <div class="col-sm-6" data-aos="fade-up" data-aos-delay="300">
	                      <div class="icon text-center mb-4"><i class="bi bi-recycle fs-4"></i></div>
	                      <h3 class="fs-6 fw-bold mb-3">버려지던 농산물의 가치 회복</h3>
	                      <p>못난이 농산물도 소중한 자원. 환경과 지속가능성을 생각합니다.</p>
	                    </div>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End Features-->
	
	<!-- ======= Pricing =======-->
	<section class="section pricing__v2" id="pricing">
	  <div class="container">
	    <div class="row mb-5">
	      <div class="col-md-5 mx-auto text-center"><span class="subtitle mb-3" data-aos="fade-up" data-aos-delay="0">입점 안내</span>
	        <h2 class="mb-3" data-aos="fade-up" data-aos-delay="100">농산물 유통, 혼자 하지 마세요!<br> 지금 시작해보세요</h2>
	        <p data-aos="fade-up" data-aos-delay="200">못난이 농산물도 정당한 가치를 받아야 합니다.<br>복잡한 절차 없이, 수확한 농산물을 우리에게 보내기만 하면<br>정직한 가격으로 소비자에게 전달해드립니다.</p>
	      </div>
	    </div>
	    <div class="row">
	      <!-- 왼쪽 카드: 참여 방식 -->
	      <div class="col-md-4 mb-4 mb-md-0 " data-aos="fade-up" data-aos-delay="300" style="border:2px solid #116530 !important; border-radius: 12px; background-color: #F3FBF7;">
	        <div class="p-5 rounded-4 price-table h-100 participate">
	          <h3><i class="bi bi-shop me-2"></i> 농가회원 참여 방식</h3>
	          <p>그램 단위 공동 판매로, 누구나 손쉽게 입점할 수 있어요.</p>
	          <ul class="list-unstyled d-flex flex-column gap-3">
	            <li class="d-flex gap-2 align-items-start mb-0">
	              <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-bag-check"></i></span>
	              <span>상품을 함께 묶어 공동 판매</span>
	            </li>
	            <li class="d-flex gap-2 align-items-start mb-0">
	              <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-truck"></i></span>
	              <span>배송은 농가가 직접 진행</span>
	            </li>
	            <li class="d-flex gap-2 align-items-start mb-0">
	              <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-pencil-square"></i></span>
	              <span>간편 신청으로 바로 시작 가능</span>
	            </li>
	          </ul>
			<c:choose>
				<c:when test="${empty sessionScope.farm}">
					<div class="mt-4"><a class="btn" href="${pageContext.request.contextPath}/farm/login">입점 신청하기</a></div>
				</c:when>
				<c:when test="${not empty sessionScope.farm}">
					<div class="mt-4"><a class="btn" href="${pageContext.request.contextPath}/farm/sales/totalList">납품 등록하기</a></div>
				</c:when>
			</c:choose>
	        </div>
	      </div>
	
	      <!-- 오른쪽 카드: 긴급구조 시스템 -->
	      <div class="col-md-8" data-aos="fade-up" data-aos-delay="400">
	        <div class="p-5 rounded-4 price-table popular h-100">
	          <div class="row">
	            <div class="col-md-6">
	              <h3 class="mb-3"><i class="bi bi-exclamation-triangle me-2"></i> 긴급구조 상품 지원</h3>
	              <p>못난이 농산물이 과잉 생산된 경우, 적극적으로 판매를 도와드립니다.</p>
	              <ul class="list-unstyled d-flex flex-column gap-3">
	                <li class="d-flex gap-2 align-items-start mb-0">
	                  <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-stars"></i></span>
	                  <span>카테고리 분류로 소비자 관심 유도</span>
	                </li>
	                <li class="d-flex gap-2 align-items-start mb-0">
	                  <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-distribute-horizontal"></i></span>
	                  <span>플랫폼 내 균형 잡힌 상품 배열</span>
	                </li>
	                <li class="d-flex gap-2 align-items-start mb-0">
	                  <span class="icon rounded-circle position-relative mt-1"><i class="bi bi-recycle"></i></span>
	                  <span>폐기 부담 완화 및 농가 손실 최소화</span>
	                </li>
	              </ul>
	              <div class="mt-4">
              		<c:choose>
						<c:when test="${empty sessionScope.farm}">
			              	<a class="btn btn-white hover-outline" href="${pageContext.request.contextPath}/farm/login">긴급 구조 신청하기</a>
						</c:when>
						<c:when test="${not empty sessionScope.farm}">
			              	<a class="btn btn-white hover-outline" href="${pageContext.request.contextPath}/farm/sales/totalList">긴급 구조 신청하기</a>
						</c:when>
					</c:choose>
              	</div>
	            </div>
	            <div class="col-md-6 pricing-features d-none d-md-block">
	              <img src="${pageContext.request.contextPath}/dist/farm/farmMain/images/mainTitle3.png" alt="긴급 구조 상품예시" class="img-fluid rounded-4 shadow-sm">
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End Pricing-->
	
	<!-- ======= How it works =======-->
	<section class="section howitworks__v1" id="how-it-works">
	  <div class="container">
	    <div class="row mb-5">
	      <div class="col-md-6 text-center mx-auto">
	        <span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">이용 흐름 안내</span>
	        <h2 data-aos="fade-up" data-aos-delay="100">진행 방식 안내</h2>
	        <p data-aos="fade-up" data-aos-delay="200">
	          농가 상품이 어떻게 소비자에게 전달되는지 간단한 과정을 통해 알려드립니다.
	        </p>
	      </div>
	    </div>

	    <div class="row g-md-5 justify-content-center text-center">
	      <!-- Step 1 -->
	      <div class="col-md-6 col-lg-2">
	        <div class="step-card text-center h-100 d-flex flex-column justify-content-start position-relative" data-aos="fade-up" data-aos-delay="0">
	          <div data-aos="fade-right" data-aos-delay="500">
	            <img class="arch-line" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/svg/arch-line.svg" alt="Flow Line">
	          </div>
	          <span class="step-number rounded-circle text-center fw-bold mb-5 mx-auto">1</span>
	          <div>
	            <h3 class="fs-5 mb-4"><i class="bi bi-pencil-square me-2"></i>상품 등록 신청</h3>
	            <p>판매를 원하는 상품에 대해 간단한 정보와 함께 신청서를 제출해 주세요.</p>
	          </div>
	        </div>
	      </div>
	
	      <!-- Step 2 -->
	      <div class="col-md-6 col-lg-2" data-aos="fade-up" data-aos-delay="600">
	        <div class="step-card reverse text-center h-100 d-flex flex-column justify-content-start position-relative">
	          <div data-aos="fade-right" data-aos-delay="1100">
	            <img class="arch-line reverse" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/svg/arch-line-reverse.svg" alt="Flow Line">
	          </div>
	          <span class="step-number rounded-circle text-center fw-bold mb-5 mx-auto">2</span>
	          <h3 class="fs-5 mb-4"><i class="bi bi-check2-circle me-2"></i>승인 심사</h3>
	          <p>접수된 정보를 기반으로 승인 여부를 빠르게 검토해드립니다.</p>
	        </div>
	      </div>
	
	      <!-- Step 3 -->
	      <div class="col-md-6 col-lg-2" data-aos="fade-up" data-aos-delay="1200">
	        <div class="step-card text-center h-100 d-flex flex-column justify-content-start position-relative">
	          <div data-aos="fade-right" data-aos-delay="1700">
	            <img class="arch-line" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/svg/arch-line.svg" alt="Flow Line">
	          </div>
	          <span class="step-number rounded-circle text-center fw-bold mb-5 mx-auto">3</span>
	          <h3 class="fs-5 mb-4"><i class="bi bi-box-seam me-2"></i>상품 수거 및 입고</h3>
	          <p>승인된 상품은 지정된 물류 허브로 안전하게 입고됩니다.</p>
	        </div>
	      </div>
	
	      <!-- Step 4 -->
	      <div class="col-md-6 col-lg-2" data-aos="fade-up" data-aos-delay="1800">
	        <div class="step-card text-center h-100 d-flex flex-column justify-content-start position-relative">
	          <div data-aos="fade-right" data-aos-delay="2300">
	            <img class="arch-line reverse" src="${pageContext.request.contextPath}/dist/farm/farmMain/images/svg/arch-line-reverse.svg" alt="Flow Line">
	          </div>
	          	<span class="step-number rounded-circle text-center fw-bold mb-5 mx-auto">4</span>
	            <h3 class="fs-5 mb-4"><i class="bi bi-shop-window me-2"></i>플랫폼 판매 시작</h3>
	            <p>입고된 상품은 온라인 플랫폼을 통해 소비자에게 노출됩니다.</p>
	          </div>
	        </div>
	
		 	<!-- Step 5 -->
	   		<div class="col-md-6 col-lg-2" data-aos="fade-up" data-aos-delay="2400">
	  			<div class="step-card text-center h-100 d-flex flex-column justify-content-start position-relative">
	   				<div data-aos="fade-right" data-aos-delay="2900"></div>
						<span class="step-number rounded-circle text-center fw-bold mb-5 mx-auto">5</span>
						<h3 class="fs-5 mb-4"><i class="bi bi-truck me-2"></i>소비자에게 배송</h3>
						<p>주문된 상품은 포장 후 소비자에게 안전하게 배송됩니다.</p>
					</div>
				</div>
			</div>
	      </div>
		</section>	
		<!-- End How it works-->
	
	<!-- ======= Stats =======-->
	<section class="stats__v3 section">
	  <div class="container">
	    <div class="row">
	      <div class="col-12">
	        <div class="d-flex flex-wrap content rounded-4" data-aos="fade-up" data-aos-delay="0">
	          <div class="rounded-borders">
	            <div class="rounded-border-1"></div>
	            <div class="rounded-border-2"></div>
	            <div class="rounded-border-3"></div>
	          </div>
	          <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0 text-center" data-aos="fade-up" data-aos-delay="100">
	            <div class="stat-item">
	              <h3 class="fs-1 fw-bold"><span class="purecounter" data-purecounter-start="0" data-purecounter-end="${farmCount}" data-purecounter-duration="2"  data-purecounter-separator="true"></span><span>명</span></h3>
	              <p class="mb-0">누적 회원 수</p>
	            </div>
	          </div>
	          <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0 text-center" data-aos="fade-up" data-aos-delay="200">
	            <div class="stat-item">
					<h3 class="fs-1 fw-bold"><span class="purecounter" data-purecounter-start="0" data-purecounter-end="${totalWeightG}" data-purecounter-duration="2" data-purecounter-separator="true"></span><span>g</span></h3>
					<p class="mb-0"> 누적 판매 중량<br>
					  ( <span class="purecounter" data-purecounter-start="0"  data-purecounter-end="${totalWeightG / 1000.0}" data-purecounter-duration="2" data-purecounter-decimals="2" data-purecounter-separator="true"></span><span>kg</span> )
					</p>
	            </div>
	          </div>
	          <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0 text-center" data-aos="fade-up" data-aos-delay="300">
	            <div class="stat-item">
	              <h3 class="fs-1 fw-bold"><span class="purecounter" data-purecounter-start="0" data-purecounter-end="${totalAmount}" data-purecounter-duration="2"  data-purecounter-separator="true"></span><span>원</span></h3>
	              <p class="mb-0">누적 판매 금액<br>
					  ( <span class="purecounter" data-purecounter-start="0"  data-purecounter-end="${totalAmount / 10000.0}" data-purecounter-duration="2" data-purecounter-decimals="1" data-purecounter-separator="true"></span><span>만원</span> )
					</p>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End Stats-->
	
	<!-- ======= Services =======-->
<section class="section services__v3" id="services">
  <div class="container">
    <div class="row mb-5">
      <div class="col-md-8 mx-auto text-center">
        <span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">SaveFarm이 제공하는 서비스</span>
        <h2 class="mb-3" data-aos="fade-up" data-aos-delay="100">
          농가 운영에 꼭 필요한 기능을, <br>등록부터 통계까지 한곳에서 도와드립니다.
        </h2>
      </div>
    </div>

    <div class="row g-4">
      <!-- 1. 재고 등록 · 납품 전환 (긴급구조 지원) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="0">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- 박스 + 화살표 + 사이렌(부스팅) -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M10 24l22-10 22 10-22 10-22-10z" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
                <path d="M54 24v16l-22 10-22-10V24" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
                <path d="M36 30l8 6-8 6" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                <rect x="44" y="12" width="10" height="8" rx="2" stroke="currentColor" stroke-width="3"/>
                <path d="M49 8v4M45 10l-3 2M56 12l3 2" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">재고 등록 · 납품 전환 (긴급구조 지원)</h3>
            <p class="mb-4">보유 재고를 등록·관리하시고 납품으로 바로 전환하실 수 있습니다. 긴급 출고가 필요하실 땐 ‘긴급구조’로 제출하여 별도 노출·포인트 부스팅을 통해 빠른 판매를 유도합니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/register/main">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>재고/납품</span>
          </a>
        </div>
      </div>

      <!-- 2. 내 납품 이력 & 수익 요약 (총 수입/순수익/품목별 수익·판매량) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="100">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- 리스트 + 파이/요약 -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M12 18h28M12 30h28M12 42h20" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
                <circle cx="44" cy="38" r="10" stroke="currentColor" stroke-width="3"/>
                <path d="M44 28a10 10 0 0 1 10 10H44V28z" fill="currentColor"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">내 납품 이력 & 수익 요약</h3>
            <p class="mb-4">납품 이력을 기반으로 지금까지의 총 수입금과 총 순수익을 확인하시고, 품목별 수익금·판매량 합계도 함께 조회하실 수 있습니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/sales/myFarmList">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>더보기</span>
          </a>
        </div>
      </div>

      <!-- 3. 판매량 분석 (TOP10 + 3년 월별 추이) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- 막대 + 꺾은선 -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M10 50h44" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
                <rect x="14" y="34" width="6" height="16" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <rect x="26" y="28" width="6" height="22" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <rect x="38" y="22" width="6" height="28" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <path d="M14 30l12-6 12 4 12-10" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">판매량 분석</h3>
            <p class="mb-4">판매량 전용 페이지에서 지표별 TOP10과 품목별 최근 3년 월별 추이를 한 화면에서 비교·분석하실 수 있습니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/sales/totalList">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>더보기</span>
          </a>
        </div>
      </div>

      <!-- 4. 수익금 분석 (TOP10 + 3년 월별 추이) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- ₩ + 차트 라인 -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M10 50h44" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
                <path d="M18 38l8-8 8 6 12-14" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M46 14h6M46 20h6M49 11v12" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">수익금 분석</h3>
            <p class="mb-4">수익금 전용 페이지에서 TOP10과 품목별 3년 월별 추이를 함께 제공하여 수익 구조를 명확히 파악하실 수 있습니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/sales/incomeList">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>더보기</span>
          </a>
        </div>
      </div>

      <!-- 5. 리뷰 별점 분석 (TOP10 + 3년 월별 추이) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="400">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- 별 + 막대 -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M10 50h44" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
                <rect x="14" y="36" width="6" height="14" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <rect x="26" y="30" width="6" height="20" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <rect x="38" y="24" width="6" height="26" rx="1.5" stroke="currentColor" stroke-width="3"/>
                <path d="M50 8l2.2 4.5 5 .7-3.6 3.5.9 5-4.5-2.4-4.5 2.4.9-5-3.6-3.5 5-.7L50 8z" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">리뷰 별점 분석</h3>
            <p class="mb-4">별점 전용 페이지에서 상위 TOP10과 품목별 3년 월별 추이를 함께 보시고 품질 지표를 관리하실 수 있습니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/sales/starList">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>더보기</span>
          </a>
        </div>
      </div>

      <!-- 6. 고객센터 (1:1 문의/FAQ/공지) -->
      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="500">
        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
          <div>
            <span class="icon mb-4">
              <!-- 메가폰 + 말풍선 -->
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" fill="none">
                <path d="M12 30l28-10v24L12 34v-4z" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
                <path d="M40 20l8-4v32l-8-4" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
                <rect x="16" y="36" width="8" height="10" rx="2" stroke="currentColor" stroke-width="3"/>
                <path d="M48 26h10v12h-7l-3 4v-16z" stroke="currentColor" stroke-width="3" stroke-linejoin="round"/>
              </svg>
            </span>
            <h3 class="fs-5 mb-3">고객센터</h3>
            <p class="mb-4">관리자 1:1 문의, 자주 묻는 질문, 공지사항을 통해 신속하고 정확하게 안내해드립니다.</p>
          </div>
          <a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="${pageContext.request.contextPath}/farm/notice/list">
            <span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"></i></span><span>더보기</span>
          </a>
        </div>
      </div>
    </div>
  </div>
</section>

	
	<!-- Services-->
	
	<!-- ======= FAQ =======-->
	<section class="section faq__v2" id="faq">
       <div class="container">
          <div class="row mb-4">
            <div class="col-md-6 col-lg-7 mx-auto text-center"><span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">자주 묻는 질문</span>
	        <h2 class="h2 fw-bold mb-3" data-aos="fade-up" data-aos-delay="0">농가 여러분이 자주 궁금해하는 질문들입니다</h2>
	        <p data-aos="fade-up" data-aos-delay="100"> SaveFarm을 이용하시며 자주 접하게 되는 궁금증을 모았습니다. 아래 내용을 통해 빠르게 확인해보세요!</p>
	      </div>
	    </div>
	    <div class="row">
	      <div class="col-md-8 mx-auto" data-aos="fade-up" data-aos-delay="200">
	        <div class="faq-content">
	          <div class="accordion custom-accordion" id="accordionPanelsStayOpenExample">
	            <div class="accordion-item">
	              <h2 class="accordion-header">
	                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne"> 어떤 방식으로 진행되나요?? </button>
	              </h2>
	              <div class="accordion-collapse collapse show" id="panelsStayOpen-collapseOne">
	                <div class="accordion-body">농가에서 납품 요청을 하시면, 관리자 측에서 일정기준에 따라 수량, 금액의 적절성을 확인하고 매입 여부를 결정합니다. 매입이 확정되면 물류로 수거되어 SaveFarm 플랫폼에서 판매가 진행됩니다.</div>
	              </div>
	            </div>
	            <div class="accordion-item">
	              <h2 class="accordion-header">
	                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo"> 긴급 구조 상품은 어떤 경우에 해당되나요? </button>
	              </h2>
	              <div class="accordion-collapse collapse" id="panelsStayOpen-collapseTwo">
	                <div class="accordion-body"> 농가측에서 갑작스럽게 생산이 많이된 농산물 중 판매가 어려워 '긴급 구조 상품'으로 납품 의뢰한 상품을 말합니다. 이러한 납품은 버려지는 농산물을 줄이기 위한 조치입니다.</div>
	              </div>
	            </div>
	            <div class="accordion-item">
	              <h2 class="accordion-header">
	                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree"> 납품 요청은 어떻게 하나요? </button>
	              </h2>
	              <div class="accordion-collapse collapse" id="panelsStayOpen-collapseThree">
	                <div class="accordion-body">상단의 '상품등록' 탭을 이용하여 신청 페이지로 이동하고 품목, 수량, 의뢰납품금액 등을 입력하여 관리자에게 의뢰하실 수 있습니다. 금액 입금일은 관리자 승인 후 개별 안내드립니다.</div>
	              </div>
	            </div>
	            <div class="accordion-item">
	              <h2 class="accordion-header">
	                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour"> 지금까지 납품한 내역은 어디서 확인하나요? </button>
	              </h2>
	              <div class="accordion-collapse collapse" id="panelsStayOpen-collapseFour">
	                <div class="accordion-body">상단의 '상품등록' 탭을 이용하여 신청 페이지로 이동하여 지금까지 납품하신 상품, 수량, 의뢰금액 등을 확인할 수 있습니다.</div>
	              </div>
	            </div>
	            <div class="accordion-item">
	              <h2 class="accordion-header">
	                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFive" aria-expanded="false" aria-controls="panelsStayOpen-collapseFive"> 정기 소식지는 어떤 내용을 담고 있나요? </button>
	              </h2>
	              <div class="accordion-collapse collapse" id="panelsStayOpen-collapseFive">
	                <div class="accordion-body">정기 소식지는 SaveFarm을 통해 유통 중인 상품 정보, 긴급 구조 상품 공지, 시즌별 특이사항 등을 담고 있습니다. 소식지 수신을 신청하신 농가에 한하여 이메일로 월 1회 발송되며, 납품 및 유통 계획에 도움이 될 수 있도록 구성됩니다.</div>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End FAQ-->
	
	<!-- ======= Contact =======-->
	<section class="section contact__v2" id="contact">
	  <div class="container">
	    <div class="row mb-5">
	      <div class="col-md-6 col-lg-7 mx-auto text-center"><span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">구독</span>
	        <h2 class="h2 fw-bold mb-3" data-aos="fade-up" data-aos-delay="0">소식지 정기구독하기</h2>
	        <p data-aos="fade-up" data-aos-delay="100">정기구독을 통해 최신 입점 정보, 유통 일정, 농가 전용 이벤트 소식을 받아보세요.</p>
	      </div>
	    </div>
	    <div class="row">
	      <div class="col-md-6">
	        <div class="d-flex gap-5 flex-column">
	          <div class="d-flex align-items-start gap-3" data-aos="fade-up" data-aos-delay="0">
	            <div class="icon d-block"><i class="bi bi-telephone"></i></div><span> <span class="d-block">전화번호</span><strong>0507-1371-8548</strong></span>
	          </div>
	          <div class="d-flex align-items-start gap-3" data-aos="fade-up" data-aos-delay="100">
	            <div class="icon d-block"><i class="bi bi-send"></i></div><span> <span class="d-block">이메일</span><strong>SaveFarm@gmail.com</strong></span>
	          </div>
	          <div class="d-flex align-items-start gap-3" data-aos="fade-up" data-aos-delay="200">
	            <div class="icon d-block"><i class="bi bi-geo-alt"></i></div><span> <span class="d-block">주 소</span>
	              <address class="fw-bold">서울 마포구 월드컵북로 21 풍성빌딩 2층</address></span>
	          </div>
	        </div>
	      </div>
	      <div class="col-md-6">
	        <div class="form-wrapper" data-aos="fade-up" data-aos-delay="300">
	          <form id="contactForm">
	            <div class="row gap-3 mb-3">
	              <div class="col-md-12">
	                <label class="mb-2" for="name">성 명</label>
	                <input class="form-control" id="name" type="text" name="name" required="">
	              </div>
	              <div class="col-md-12">
	                <label class="mb-2" for="email">이메일</label>
	                <input class="form-control" id="email" type="email" name="email" required="">
	              </div>
	            </div>
	            <div class="row gap-3 mb-3">
	              <div class="col-md-12">
	                <label class="mb-2" for="subject">입점하고 싶은 농산물 분류</label>
	                <input class="form-control" id="subject" type="text" name="subject" required="" placeholder="작성해주시면 관려된 정보를 드리도록 노력하겠습니다." >
	              </div>
	            </div>
	            <div class="row gap-3 gap-md-0 mb-3">
	              <div class="col-md-12">
	                <label class="mb-2" for="message">내 용</label>
	                <textarea class="form-control" id="message" name="message" rows="5" required="" placeholder="추가로 전해듣고 싶은 내용이 있다면 여기에 작성해주세요!"></textarea>
	              </div>
	            </div>
	            <button class="btn btn-primary fw-semibold" type="submit">신청하기</button>
	          </form>
	          <div class="mt-3 d-none alert alert-success" id="successMessage">Message sent successfully!</div>
	          <div class="mt-3 d-none alert alert-danger" id="errorMessage">Message sending failed. Please try again later.</div>
	        </div>
	      </div>
	    </div>
	  </div>
	</section>
	<!-- End Contact-->
	</main>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">

// 이메일 다 못해서 일단 내용 입력 완료하면 다 보내진 것처럼 하기로 함
(function () {
  const form = document.getElementById("contactForm");
  const btn  = form.querySelector('button[type="submit"]');
  const success = document.getElementById("successMessage");
  const error   = document.getElementById("errorMessage");

  // 헬퍼: 메시지 토글
  function showAlert(el, show) {
    el.classList.toggle("d-none", !show);
  }

  // 헬퍼: 첫 번째 유효성 위반 필드 찾기
  function getFirstInvalidField(form) {
    // required + 빈 값, 또는 HTML5 패턴/타입(이메일) 불일치
    const fields = form.querySelectorAll("input, textarea");
    for (const f of fields) {
      const isRequiredEmpty = f.hasAttribute("required") && !f.value.trim();
      const isInvalidByBrowser = f.value && f.checkValidity && !f.checkValidity();
      if (isRequiredEmpty || isInvalidByBrowser) return f;
    }
    return null;
  }

  // 기본: 부트스트랩 스타일 보조 (was-validated 사용)
  function setFieldState(field, ok) {
    field.classList.toggle("is-invalid", !ok);
    field.classList.toggle("is-valid", ok);
  }

  // 입력 중 즉시 검증(선택)
  form.addEventListener("input", (e) => {
    const t = e.target;
    if (!(t instanceof HTMLInputElement || t instanceof HTMLTextAreaElement)) return;
    const ok = (!t.hasAttribute("required") || t.value.trim().length > 0) && t.checkValidity();
    setFieldState(t, ok);
  });

  form.addEventListener("submit", function (e) {
    e.preventDefault();
    showAlert(success, false);
    showAlert(error, false);

    // 전체 필드 검증
    const firstInvalid = getFirstInvalidField(form);
    if (firstInvalid) {
      form.classList.add("was-validated"); // 부트스트랩 기본 검증 스타일
      setFieldState(firstInvalid, false);
      // 포커스 + 살짝 스크롤
      firstInvalid.focus({ preventScroll: false });
      firstInvalid.scrollIntoView({ behavior: "smooth", block: "center" });
      return; // 미입력/오류 있으면 종료
    }

    // 데모 모드: 전송 없이 성공 처리
    btn.disabled = true;
    setTimeout(() => {
      alert("신청이 완료되었습니다!");   // "성공" 배너 표시
      form.reset();               // 폼 리셋
      form.classList.remove("was-validated");
      // 유효/무효 클래스 초기화
      form.querySelectorAll(".is-valid, .is-invalid").forEach(el=>{
        el.classList.remove("is-valid","is-invalid");
      });
      btn.disabled = false;
    }, 150); // 약간의 지연으로 버튼 더블클릭 방지 느낌
  });
})();
</script>
</body>
</html>