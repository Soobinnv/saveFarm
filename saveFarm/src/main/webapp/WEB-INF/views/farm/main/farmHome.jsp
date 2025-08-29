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
	              <h3 class="fs-1 fw-bold"><span class="purecounter" data-purecounter-start="0" data-purecounter-end="10" data-purecounter-duration="2"></span><span>명</span></h3>
	              <p class="mb-0">누적 회원 수</p>
	            </div>
	          </div>
	          <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0 text-center" data-aos="fade-up" data-aos-delay="200">
	            <div class="stat-item">
	              <h3 class="fs-1 fw-bold"> <span class="purecounter" data-purecounter-start="0" data-purecounter-end="200" data-purecounter-duration="2"></span><span>g</span></h3>
	              <p class="mb-0">누적 판매 중량</p>
	            </div>
	          </div>
	          <div class="col-12 col-sm-6 col-md-4 mb-4 mb-md-0 text-center" data-aos="fade-up" data-aos-delay="300">
	            <div class="stat-item">
	              <h3 class="fs-1 fw-bold"><span class="purecounter" data-purecounter-start="0" data-purecounter-end="20" data-purecounter-duration="2"></span><span>원</span></h3>
	              <p class="mb-0">누적 판매 금액</p>
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
	      <div class="col-md-8 mx-auto text-center"><span class="subtitle text-uppercase mb-3" data-aos="fade-up" data-aos-delay="0">SaveFarm이 제공하는 서비스</span>
	        <h2 class="mb-3" data-aos="fade-up" data-aos-delay="100">농산물 수매부터 소비자 배송까지, <br>유통의 모든 과정을 함께합니다.</h2>
	      </div>
	    </div>
	    <div class="row g-4">
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="0">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="M50.327 4H25.168a6.007 6.007 0 0 0-6 6v5.11h-8.375a3.154 3.154 0 0 0-3.12 3.18v5.47a1 1 0 0 0 .724.961 3.204 3.204 0 0 1 0 6.097 1 1 0 0 0-.724.962v5.49a3.154 3.154 0 0 0 3.12 3.18H34.5c-2.147 8.057 9.408 12.135 12.77 4.441a1 1 0 0 0-1.841-.779 4.778 4.778 0 1 1-4.403-6.636c1.039-.159 2.453 1.082 3.063-.225.449-1.37-1.383-1.598-2.336-1.734V31.8a1 1 0 0 0-.72-.96 3.21 3.21 0 0 1 0-6.11 1 1 0 0 0 .72-.96v-5.48a3.154 3.154 0 0 0-3.12-3.18H21.168V10a4.004 4.004 0 0 1 4-4h3.21l1.24 3.066a3.982 3.982 0 0 0 3.708 2.503h8.826a3.984 3.984 0 0 0 3.71-2.503L47.1 6h3.228a4.004 4.004 0 0 1 4 4v1.6a1 1 0 0 0 2 0V10a6.007 6.007 0 0 0-6-6ZM38.633 17.11a1.153 1.153 0 0 1 1.12 1.18v4.792a5.234 5.234 0 0 0 0 9.405V35.6a6.789 6.789 0 0 0-4.333 2.85H10.793a1.153 1.153 0 0 1-1.12-1.18v-4.8a5.232 5.232 0 0 0 0-9.401V18.29a1.153 1.153 0 0 1 1.12-1.18Zm5.375-8.793a1.994 1.994 0 0 1-1.856 1.252h-8.826a1.991 1.991 0 0 1-1.854-1.252l-.934-2.312H44.94Z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M55.327 14.6a1 1 0 0 0-1 1V54a4.004 4.004 0 0 1-4 4H25.168a4.004 4.004 0 0 1-4-4V43.45a1 1 0 0 0-2 0V54a6.007 6.007 0 0 0 6 6h25.16a6.007 6.007 0 0 0 6-6V15.6a1 1 0 0 0-1-1Z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M41.185 54.52a1 1 0 0 0 0-2h-6.891a1 1 0 0 0 0 2ZM24.713 28.383a.853.853 0 1 1-.835 1.028.998.998 0 0 0-1.184-.775c-1.765.61-.18 2.94 1.017 3.265-.271 1.919 2.27 1.926 2-.003a2.852 2.852 0 0 0-.998-5.515.851.851 0 1 1 .821-1.084 1 1 0 0 0 1.926-.54 2.857 2.857 0 0 0-1.749-1.893v-.518a1 1 0 0 0-2 0v.521a2.852 2.852 0 0 0 1.002 5.514Z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M24.713 36.43a9.092 9.092 0 0 0 9.082-9.082c-.499-12.047-17.666-12.045-18.163 0a9.092 9.092 0 0 0 9.08 9.082Zm0-16.163a7.09 7.09 0 0 1 7.082 7.081c-.371 9.388-13.793 9.387-14.163 0a7.09 7.09 0 0 1 7.08-7.081ZM46.413 37.53l-4.757 4.757-1.68-1.68a1 1 0 0 0-1.413 1.415l2.386 2.386a1 1 0 0 0 1.414 0l5.464-5.464a1 1 0 0 0-1.414-1.414Z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">정가 매입 유통</h3>
	            <p class="mb-4">수확한 농산물을 정가로 매입해 SaveFarm이 직접 소비자에게 배송까지 책임집니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
	        </div>
	      </div>
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="m57.936 58.647-4.47-11.871a9.542 9.542 0 0 0-5.914-5.693l-7.659-2.609-1.944-2.116v-2.62a13.043 13.043 0 0 0 4.739-5.175 14.256 14.256 0 0 0 3.237.14 2.909 2.909 0 0 0 2.905-2.906v-5.382a2.895 2.895 0 0 0-1.495-2.523 13.84 13.84 0 0 0-2.807-7.777 1 1 0 0 0-1.597 1.205 11.879 11.879 0 0 1 2.386 6.19c-.012-.01-2.017.036-1.987-.023-4.064-11.113-18.668-11.126-22.702.024h-1.875c.73-9.938 13.556-14.987 21.539-8.81a1 1 0 0 0 1.196-1.605c-9.394-7.24-24.311-1.02-24.754 10.758a2.895 2.895 0 0 0-1.566 2.561v5.382a2.909 2.909 0 0 0 2.905 2.906c.4-.042 2.932.115 3.213-.122a12.843 12.843 0 0 0 4.542 5.038v2.757l-1.825 2.184-7.553 2.521a9.547 9.547 0 0 0-5.917 5.695l-4.47 11.871a1.008 1.008 0 0 0 .935 1.352H49.97a1 1 0 0 0 0-2H36.123l-2.985-7.876 2.014-2.491 2.009 1.746a1.007 1.007 0 0 0 1.643-.594l1.322-8.118 6.785 2.312a7.549 7.549 0 0 1 4.682 4.504L55.555 58H53.97a1 1 0 0 0 0 2H57a1.007 1.007 0 0 0 .936-1.353zm-13.77-39.136h1.759a.906.906 0 0 1 .905.904v5.382a.906.906 0 0 1-.905.906h-1.759zm-24.334 7.192h-1.759a.906.906 0 0 1-.905-.906v-5.382a.906.906 0 0 1 .905-.904h1.76s.038 5.959 0 7.192zm12.146-15.6a10.16 10.16 0 0 1 9.15 6.288L38.85 18.43a4.677 4.677 0 0 1-4.986-.747 6.633 6.633 0 0 0-7.78-.736l-3.91 2.325c1.2-4.704 5.135-8.169 9.803-8.169zM21.832 23.168V21.8l5.273-3.133a4.632 4.632 0 0 1 5.433.51 6.72 6.72 0 0 0 7.15 1.07l2.098-.957a12.113 12.113 0 0 1 .38 2.98c-.464 14.245-18.826 15.065-20.334.9zM35.95 34.706v1.718l-3.968 5.464-4.153-5.473v-1.78a11.242 11.242 0 0 0 8.12.071zm-9.164 3.643 3.852 5.075-3.771 3.28-1.206-7.008zM8.444 58l3.96-10.516a7.551 7.551 0 0 1 4.681-4.505l6.724-2.245 1.387 8.06a1.007 1.007 0 0 0 1.641.585l2.01-1.746 2.013 2.491L27.875 58zm25.54 0h-3.97L32 52.763zm-1.985-9.65-1.642-2.03 1.642-1.428 1.642 1.427zm5.12-1.658-3.772-3.28 3.693-5.085 1.224 1.332z" fill="currentColor" opacity="1" data-original="currentColor"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">긴급 구조 판매</h3>
	            <p class="mb-4">재고 적체된 상품은 ‘긴급구조’로 분류하여 빠르게 소비자에게 연결해드립니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
	        </div>
	      </div>
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="M35.719 21.413a1 1 0 0 0-1.586 1.218 15.554 15.554 0 0 1 1.806 3.012h-6.1a19.93 19.93 0 0 0-3.417-8.42 15.637 15.637 0 0 1 5.012 2.652 1 1 0 0 0 1.245-1.565 17.676 17.676 0 1 0-11.002 31.51c14.511.067 22.936-16.94 14.042-28.407zm.966 6.23a15.507 15.507 0 0 1 .001 8.994h-6.533a35.942 35.942 0 0 0-.001-8.995zM29.84 38.635h6.102a15.688 15.688 0 0 1-9.534 8.447 19.91 19.91 0 0 0 3.432-8.447zm-1.402-6.491a34.461 34.461 0 0 1-.292 4.492h-12.94a34.731 34.731 0 0 1 .001-8.995h12.938a34.461 34.461 0 0 1 .293 4.503zm-6.812-15.67c2.533-.006 5.021 3.488 6.193 9.168H15.535c1.138-5.63 3.672-9.12 6.092-9.168zm-4.683.734a19.903 19.903 0 0 0-3.429 8.434H7.417a15.707 15.707 0 0 1 9.527-8.434zM6 32.149a15.682 15.682 0 0 1 .671-4.507h6.53a35.936 35.936 0 0 0 0 8.995H6.67A15.558 15.558 0 0 1 6 32.15zm1.413 6.487h6.1a19.912 19.912 0 0 0 3.43 8.446 15.69 15.69 0 0 1-9.53-8.446zm8.118 0h12.29c-2.589 12.171-9.703 12.166-12.29 0zM16.844 8.31H38.91a8.42 8.42 0 0 1 8.4 8.106l-2.018-2.018a1 1 0 0 0-1.414 1.414l3.74 3.74a1 1 0 0 0 1.414 0l3.74-3.74a1 1 0 0 0-1.413-1.414l-2.048 2.047A10.421 10.421 0 0 0 38.911 6.31H16.844a1 1 0 0 0 0 2zM50.105 44.448a1 1 0 0 0-1.413 0l-3.74 3.74a1 1 0 1 0 1.413 1.414l2.018-2.018a8.419 8.419 0 0 1-8.4 8.107H17.916a1 1 0 0 0 0 2h22.067a10.42 10.42 0 0 0 10.401-10.136l2.048 2.047a1 1 0 0 0 1.413-1.414zM58.589 27.13a1 1 0 0 0-1.694 1.062 7.174 7.174 0 1 1-2.549-2.453 1 1 0 1 0 .992-1.736 9.2 9.2 0 1 0-4.545 17.195c7.082.128 11.668-8.14 7.796-14.068z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M49.754 34.379a1.001 1.001 0 0 0-1.238-.682c-1.769.767.123 2.972 1.275 3.302a1 1 0 1 0 2-.024 3.075 3.075 0 0 0-1-5.975 1.078 1.078 0 1 1 1.053-1.306 1 1 0 0 0 1.187.77c1.894-.7-.034-3.134-1.24-3.463a1 1 0 1 0-2 .024 3.075 3.075 0 0 0 1 5.975 1.079 1.079 0 1 1-1.037 1.379z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">정기 소식지 발송</h3>
	            <p class="mb-4">이메일 구독 농가에만 유통일정, 출하 통계, 지원정보를 제공합니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
	        </div>
	      </div>
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="400">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="M59 47.487h-1.81v-27.61a5.223 5.223 0 0 0-5-5.409h-3.71a1 1 0 0 0 0 2h3.71a3.228 3.228 0 0 1 3 3.41v27.609H26.03a1.013 1.013 0 0 0-.996 1.02 34.358 34.358 0 0 0 1.49 3.57 2 2 0 0 0 1.828 1.188h7.296a2 2 0 0 0 1.828-1.188l1.149-2.589L58 49.487v2.74a2.823 2.823 0 0 1-2.82 2.82H8.82A2.823 2.823 0 0 1 6 52.227v-2.74h16.03a1 1 0 0 0 0-2H8.81v-27.61a3.228 3.228 0 0 1 3-3.41h6.89c-3.535 9.154 3.658 19.594 13.63 19.48 11.076.08 18.127-12.336 12.587-21.706a14.54 14.54 0 0 0-25.162-.073 1.646 1.646 0 0 1-.163.299H11.81a5.223 5.223 0 0 0-5 5.41v27.61H5a1 1 0 0 0-1 1v3.74a4.825 4.825 0 0 0 4.82 4.82h46.36a4.825 4.825 0 0 0 4.82-4.82v-3.74a1 1 0 0 0-1-1zm-23.352 3.778h-7.296l-.788-1.775h8.872zm-4.332-17.37a12.517 12.517 0 0 1-9.29-5.372l2.072-1.196a10.137 10.137 0 0 0 7.218 4.188zm2 .001v-2.38a10.12 10.12 0 0 0 7.224-4.178l2.073 1.197a12.5 12.5 0 0 1-9.297 5.361zm11.521-12.471A12.435 12.435 0 0 1 43.61 26.8l-2.064-1.192a10.127 10.127 0 0 0 .008-8.344l2.064-1.192a12.412 12.412 0 0 1 1.22 5.353zM33.33 8.967a12.503 12.503 0 0 1 9.295 5.37l-2.073 1.196a10.124 10.124 0 0 0-7.222-4.187zm7.129 12.458a8.144 8.144 0 0 1-8.13 8.14c-10.794-.446-10.804-15.824 0-16.27a8.138 8.138 0 0 1 8.13 8.13zM31.329 8.966v2.38a10.138 10.138 0 0 0-7.226 4.177l-2.073-1.196a12.518 12.518 0 0 1 9.3-5.36zm-10.295 7.095 2.064 1.192a10.022 10.022 0 0 0-.003 8.343l-2.064 1.192a12.473 12.473 0 0 1 .003-10.727z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M32.322 22.446a1.276 1.276 0 1 1-1.225 1.632 1 1 0 0 0-1.921.556 3.29 3.29 0 0 0 2.146 2.202v.352a1 1 0 0 0 2 0v-.363a3.272 3.272 0 0 0-1-6.38A1.276 1.276 0 1 1 33.57 18.9a1 1 0 0 0 1.956-.418 3.287 3.287 0 0 0-2.204-2.423c.082-.687-.226-1.374-1-1.385-.78.016-1.08.697-1 1.392a3.272 3.272 0 0 0 1 6.38z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">납품 이력 조회</h3>
	            <p class="mb-4">과거에 납품한 품목, 수량, 단가, 일자 등을 표로 확인할 수 있습니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
	        </div>
	      </div>
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="500">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="M38.972 31.507a7.01 7.01 0 0 0-4.32-12.487H23.604a3.001 3.001 0 0 0-2.998 2.998v19.988a3.001 3.001 0 0 0 2.998 2.998h12.8c7.723-.104 9.639-10.635 2.568-13.497zm-16.367-9.49a1 1 0 0 1 1-.999h11.047a4.997 4.997 0 1 1 0 9.994H22.605zm13.798 20.988H23.604a1 1 0 0 1-.999-1v-8.994h13.798a4.997 4.997 0 0 1 0 9.994z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M51.798 12.238a27.71 27.71 0 0 0-3.132-2.708 1 1 0 0 0-1.186 1.609 25.317 25.317 0 0 1 2.162 1.82l-2.117 2.117A22.896 22.896 0 0 0 33.002 9.05V6.057a25.425 25.425 0 0 1 11.2 3.02 1 1 0 0 0 .946-1.761C26.702-2.634 3.907 11.036 4.02 32.012c-.31 15.036 12.945 28.294 27.983 27.983 24.827-.03 37.332-30.174 19.795-47.757zm-.734 2.126a25.768 25.768 0 0 1 6.899 16.648h-3A22.896 22.896 0 0 0 48.94 16.49zm-38.123 0 2.118 2.117A22.815 22.815 0 0 0 9.05 31.012H6.043a25.768 25.768 0 0 1 6.898-16.648zM6.043 33.01h2.999a22.896 22.896 0 0 0 6.025 14.524L12.94 49.66A25.768 25.768 0 0 1 6.043 33.01zm24.96 24.96a25.768 25.768 0 0 1-16.648-6.898l2.125-2.125a22.896 22.896 0 0 0 14.523 6.025zm-19.988-25.96a20.892 20.892 0 0 1 11.64-18.784 1 1 0 0 0-.892-1.788 23.283 23.283 0 0 0-5.294 3.626l-2.114-2.114a25.768 25.768 0 0 1 16.648-6.9v3.01a22.7 22.7 0 0 0-5.356.865 1 1 0 0 0 .558 1.918c13.1-3.976 26.996 6.454 26.785 20.168-1.15 27.836-40.823 27.84-41.975 0zm21.987 25.96v-2.998a22.896 22.896 0 0 0 14.523-6.025l2.125 2.125a25.768 25.768 0 0 1-16.648 6.899zm18.062-8.311-2.125-2.125a22.896 22.896 0 0 0 6.024-14.524h3a25.768 25.768 0 0 1-6.9 16.649z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">누적 납품 금액 확인</h3>
	            <p class="mb-4">승인된 납품 건의 총 수량과 금액을 한눈에 확인할 수 있습니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
	        </div>
	      </div>
	      <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="600">
	        <div class="service-card p-4 rounded-4 h-100 d-flex flex-column justify-content-between gap-5">
	          <div><span class="icon mb-4">
	              <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" x="0" y="0" viewbox="0 0 64 64" style="enable-background:new 0 0 512 512" xml:space="preserve">
	                <g>
	                  <path d="M49.5 4H24.34a6.007 6.007 0 0 0-6 6v5.29a1 1 0 0 0 2 0V10a4.005 4.005 0 0 1 4-4h3.218l1.237 3.066a3.984 3.984 0 0 0 3.71 2.503h8.826a3.984 3.984 0 0 0 3.71-2.503L46.277 6H49.5a4.004 4.004 0 0 1 4 4v44a4.004 4.004 0 0 1-4 4H24.34a4.005 4.005 0 0 1-4-4V39.42h11.8a6.774 6.774 0 0 0 12.998 2.159 1 1 0 0 0-1.842-.78 4.778 4.778 0 1 1-2.638-6.3 1 1 0 0 0 1.298-.56c.446-1.634-1.965-1.701-3.062-1.776a6.785 6.785 0 0 0-6.6 5.257H13.502a3.003 3.003 0 0 1-3-3v-7.932h27.4v2.672a1 1 0 0 0 2 0v-5.87a5.006 5.006 0 0 0-5-5H13.5a5.006 5.006 0 0 0-5 5c.007 1.424-.005 9.521 0 11.13a5.006 5.006 0 0 0 5 5h4.84V54a6.007 6.007 0 0 0 6 6H49.5a6.007 6.007 0 0 0 6-6V10a6.007 6.007 0 0 0-6-6zm-6.314 4.317a1.994 1.994 0 0 1-1.855 1.252h-8.827a1.992 1.992 0 0 1-1.854-1.252l-.934-2.312H44.12zM10.501 23.29a3.003 3.003 0 0 1 3-3h21.4a3.003 3.003 0 0 1 3 3v1.198H10.5z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                  <path d="M33.472 52.52a1 1 0 0 0 0 2h6.89a1 1 0 0 0 0-2zM37.844 37.294a1 1 0 0 0-1.414 1.415l2.387 2.387a1 1 0 0 0 1.414 0l5.464-5.465a1 1 0 0 0-1.414-1.414l-4.757 4.757zM13.29 33.143a1 1 0 0 0 0 2h2.45a1 1 0 0 0 0-2z" fill="currentColor" opacity="1" data-original="#000000"></path>
	                </g>
	              </svg></span>
	            <h3 class="fs-5 mb-3">월별 납품 현황 보기</h3>
	            <p class="mb-4">월별로 납품한 품목, 수량, 금액을 표로 확인할 수 있어 출하 기록 관리에 도움이 됩니다.</p>
	          </div><a class="special-link d-inline-flex gap-2 align-items-center text-decoration-none" href="#"><span class="icons"><i class="icon-1 bi bi-arrow-right-short"></i><i class="icon-2 bi bi-arrow-right-short"> </i></span><span>더보기</span></a>
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
	                <input class="form-control" id="subject" type="text" name="subject" placeholder="작성해주시면 관려된 정보를 드리도록 노력하겠습니다.">
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

</body>
</html>