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

<main class="main">
    <!-- Page Title -->
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/guideTitle.webp);">
      <div class="container position-relative">
        <h1>납품 신청 및 유통과정</h1>
        <p>가입부터 소비자 배송까지, 간편하고 믿을 수 있는 유통 과정을 안내합니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm/guide">홈</a></li>
            <li class="current">과정</li>
          </ol>
        </nav>
      </div>
    </div><!-- End Page Title -->

    <!-- About 3 Section -->
    <section id="about-3" class="about-3 section">

      <div class="container">
        <div class="row gy-4 justify-content-between align-items-center">
          <div class="col-lg-6 order-lg-2 position-relative" data-aos="zoom-out">
            <img src="${pageContext.request.contextPath}/dist/farm/header_footer/img/guideTitle3.png" alt="Image" class="img-fluid">
            <a href="https://www.youtube.com/watch?v=Y7f98aduVJ8" class="glightbox pulsating-play-btn">
              <span class="play"><i class="bi bi-play-fill"></i></span>
            </a>
          </div>
          <div class="col-lg-5 order-lg-1" data-aos="fade-up" data-aos-delay="100">
            <h2 class="content-title mb-4">농가에서 소비자까지,<br> 믿을 수 있는 유통의 모든 과정</h2>
            <p class="mb-4">
             SaveFarm은 농가의 수확물이 소비자에게 안전하게 전달되기까지의 모든 과정을 체계적으로 지원합니다.  
			<br> 복잡한 절차 없이, 입점 신청부터 배송 완료까지 간편하게 함께하세요.
            </p>
            <ul class="list-unstyled list-check">
              <li>유통 채널 확보 걱정 없이 판매 가능</li>
              <li>못난이 농산물도 가치 있게 판매</li>
              <li>입점부터 배송까지 원스톱 지원</li>
            </ul>

            <p><a href="#" class="btn-cta">지금 바로 시작하기</a></p>
          </div>
        </div>
      </div>
    </section><!-- /About 3 Section -->

  
    <!-- Services Section -->
    <section id="services" class="services section">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2>함께하는 과정</h2>
        <p>다음과 같은 과정을 통해 밭에서 소비자에게로 농산물이 이동할 것입니다.</p>
      </div><!-- End Section Title -->
      <div class="content">
        <div class="container">
          <div class="row g-0">
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">01</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 509.435 509.435" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                   <g transform="scale(14.151)"
					   stroke="currentColor"
					   fill="none"
					   stroke-width="1.3"     
					   stroke-linecap="round"
					   stroke-linejoin="round">
					  <!-- 바깥 클립보드 외곽선 -->
					  <path d="M29.29,5H27V7h2V32H7V7H9V5H7A1.75,1.75,0,0,0,5,6.69V32.31A1.7,1.7,0,0,0,6.71,34H29.29A1.7,1.7,0,0,0,31,32.31V6.69A1.7,1.7,0,0,0,29.29,5Z"/>
					  <!-- 상단 클립(집게) -->
					  <path d="M26,7.33A2.34,2.34,0,0,0,23.67,5H21.87a4,4,0,0,0-7.75,0H12.33A2.34,2.34,0,0,0,10,7.33V11H26Z"/>
					  <!-- 텍스트 라인들: 얇은 선 -->
					  <line x1="11" y1="15" x2="25" y2="15"/>
					  <line x1="11" y1="19" x2="25" y2="19"/>
					  <line x1="11" y1="23" x2="25" y2="23"/>
					  <line x1="11" y1="27" x2="25" y2="27"/>
					</g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">입점 신청</h3>
                  <p>
                   	농가 전용 페이지에서 입력하 간단한 정보를바탕으로 관리자의 검토 후 입점 승인이 진행됩니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">02</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 514.314 514.314" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                    <g>
                    	<path transform="scale(16.0729375)"
						      d="M11,13H5c-1.1,0-2-0.9-2-2V5c0-1.1,0.9-2,2-2h6c1.1,0,2,0.9,2,2v6C13,12.1,12.1,13,11,13z"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M11,29H5c-1.1,0-2-0.9-2-2v-6c0-1.1,0.9-2,2-2h6c1.1,0,2,0.9,2,2v6C13,28.1,12.1,29,11,29z"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M17 5 L29 5"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M17 9 L24 9"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M17 21 L29 21"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M17 25 L24 25"
						      fill="none" stroke="currentColor" stroke-width="3"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
						<path transform="scale(16.0729375)"
						      d="M6 7 L8 9 L11 6"
						      fill="none" stroke="currentColor" stroke-width="4"
						      vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round"/>
                    </g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">상품 등록 및 심사</h3>
                  <p>
                    물류센터의 재고 상황과 이전 본 농가에서 받은 상품의 평가기록을 기준으로 승인여부를 결정합니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">03</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 512.805 512.805" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                    <g stroke="currentColor"
					   fill="currentColor"
					   stroke-width="2"
					   stroke-linecap="round"
					   stroke-linejoin="round"
					   vector-effect="non-scaling-stroke">
						<g>
							<g>
								<path d="M157.332,316.32c-19.08,0-34.602,15.522-34.602,34.602c0,19.08,15.522,34.602,34.602,34.602
									c19.08,0,34.602-15.522,34.602-34.602C191.934,331.842,176.412,316.32,157.332,316.32z M157.332,364.625
									c-7.557,0-13.704-6.148-13.704-13.704c0-7.556,6.147-13.704,13.704-13.704s13.704,6.147,13.704,13.704
									S164.889,364.625,157.332,364.625z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M401.36,316.32c-19.08,0-34.601,15.522-34.601,34.602c0,19.08,15.522,34.602,34.602,34.602s34.601-15.522,34.601-34.602
									C435.962,331.842,420.44,316.32,401.36,316.32z M401.361,364.625c-7.557,0-13.704-6.148-13.704-13.704
									c0-7.556,6.147-13.704,13.704-13.704s13.704,6.147,13.704,13.704S408.918,364.625,401.361,364.625z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M444.045,140.534h-97.139v-20.341c0-18.446-15.006-33.451-33.451-33.451H33.451C15.006,86.741,0,101.747,0,120.192
									v230.911c0,5.771,4.678,10.449,10.449,10.449h38.616l19.61,0.084l37.329-0.084c5.762-0.013,10.426-4.687,10.426-10.449
									c0-22.553,18.349-40.902,40.903-40.902c22.553,0,40.903,18.349,40.903,40.902c0,5.771,4.678,10.449,10.449,10.449h141.325
									c5.771,0,10.449-4.678,10.449-10.449c0-22.553,18.349-40.902,40.903-40.902s40.903,18.349,40.903,40.902
									c0,5.76,4.659,10.432,10.419,10.449l29.061,0.084l19.853-0.084c5.753-0.024,10.405-4.696,10.405-10.449V208.488
									C512,171.018,481.515,140.534,444.045,140.534z M326.008,340.654H218.249c-4.979-29.118-30.4-51.352-60.917-51.352
									c-30.525,0-55.951,22.243-60.921,51.373l-27.715,0.063l-19.587-0.085H20.898V161.052H251.16c5.771,0,10.449-4.678,10.449-10.449
									c0-5.771-4.678-10.449-10.449-10.449H20.898v-19.962c0-6.922,5.632-12.553,12.553-12.553h280.003
									c6.922,0,12.553,5.632,12.553,12.553V340.654z M491.102,340.698l-9.374,0.04l-19.447-0.056
									c-4.966-29.133-30.395-51.379-60.922-51.379c-23.52,0-44.014,13.209-54.454,32.596V161.432h97.139
									c25.948,0,47.057,21.11,47.057,47.057V340.698z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M423.964,178.104h-46.756c-5.771,0-10.449,4.678-10.449,10.449v72.841c0,5.771,4.678,10.449,10.449,10.449h93.466
									c5.771,0,10.449-4.678,10.449-10.449v-26.131C481.123,203.746,455.481,178.104,423.964,178.104z M460.226,250.946L460.226,250.946
									h-72.569v-51.943h36.308c19.994,0,36.261,16.267,36.261,36.261V250.946z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M285.101,140.153h-0.137c-5.771,0-10.449,4.678-10.449,10.449c0,5.771,4.678,10.449,10.449,10.449h0.137
									c5.771,0,10.449-4.678,10.449-10.449C295.55,144.831,290.872,140.153,285.101,140.153z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M501.551,404.36h-0.137c-5.771,0-10.449,4.678-10.449,10.449c0,5.771,4.678,10.449,10.449,10.449h0.137
									c5.771,0,10.449-4.678,10.449-10.449C512,409.038,507.322,404.36,501.551,404.36z"/>
							</g>
						</g>
						<g>
							<g>
								<path d="M467.61,404.361H10.449C4.678,404.361,0,409.039,0,414.81c0,5.771,4.678,10.449,10.449,10.449H467.61
									c5.771,0,10.449-4.678,10.449-10.449C478.059,409.039,473.381,404.361,467.61,404.361z"/>
							</g>
						</g>
					</g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">물류 이동</h3>
                  <p>
                    승인 후, 승인받은 납품 농산물을 저희 물류센터로 보내주세요. 보내주신 상품을 저희가 받아 보관하겠습니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">04</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 372.372 372.372" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                    <g fill="currentColor">
					    <path d="M368.712,219.925c-5.042-8.951-14.563-14.511-24.848-14.511c-4.858,0-9.682,1.27-13.948,3.672l-83.024,46.756
					      c-1.084,0.61-1.866,1.642-2.163,2.85c-1.448,5.911-4.857,14.164-12.865,19.911c-8.864,6.361-20.855,7.686-35.466,3.939
					      c-0.088-0.022-0.175-0.047-0.252-0.071L148.252,267.6c-2.896-0.899-4.52-3.987-3.621-6.882c0.72-2.316,2.83-3.872,5.251-3.872
					      c0.55,0,1.101,0.084,1.634,0.249l47.645,14.794c0.076,0.023,0.154,0.045,0.232,0.065c11.236,2.836,20.011,2.047,26.056-2.288
					      c7.637-5.48,8.982-15.113,9.141-16.528c0.006-0.045,0.011-0.09,0.014-0.136c0.003-0.023,0.004-0.036,0.005-0.039
					      c0.001-0.015,0.002-0.03,0.003-0.044c0.001-0.01,0.001-0.019,0.002-0.029c0.909-11.878-6.756-22.846-18.24-26.089l-0.211-0.064
					      c-0.35-0.114-35.596-11.626-58.053-18.034c-2.495-0.711-9.37-2.366-19.313-2.366c-13.906,0-34.651,3.295-54.549,19.025
					      L1.67,292.159c-1.889,1.527-2.224,4.278-0.758,6.215l44.712,59.06c0.725,0.956,1.801,1.584,2.99,1.744
					      c0.199,0.027,0.398,0.04,0.598,0.04c0.987,0,1.954-0.325,2.745-0.935l57.592-44.345c1.294-0.995,3.029-1.37,4.619-0.995
					      l93.02,21.982c6.898,1.63,14.353,0.578,20.523-2.9l130.16-73.304C371.555,251.012,376.418,233.61,368.712,219.925z"/>
					    <path d="M316.981,13.155h-170c-5.522,0-10,4.477-10,10v45.504c0,5.523,4.478,10,10,10h3.735v96.623c0,5.523,4.477,10,10,10h142.526
					      c5.523,0,10-4.477,10-10V78.658h3.738c5.522,0,10-4.477,10-10V23.155C326.981,17.632,322.503,13.155,316.981,13.155z
					      M253.016,102.417h-42.072c-4.411,0-8-3.589-8-8c0-4.411,3.589-8,8-8h42.072c4.411,0,8,3.589,8,8
					      C261.016,98.828,257.427,102.417,253.016,102.417z M306.981,58.658h-3.738H160.716h-3.735V33.155h150V58.658z"/>
					  </g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">상품판매</h3>
                  <p>
                    각 농가에서 받은 남풉 농산물들을 동일한 품종으로 묶어 단위당 가격으로 소비자 페이지에 노출됩니다.
                  </p>
                </div>
              </div>
            </div>

            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">05</span>
                <div class="service-item-icon">
					<svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 32 32" aria-hidden="true">
						  <!-- 바퀴/세로선: 아웃라인 -->
						  <g fill="none" stroke="currentColor" stroke-width="2" stroke-miterlimit="10" vector-effect="non-scaling-stroke">
						    <circle cx="22" cy="24" r="2"/>
						    <circle cx="13" cy="24" r="2"/>
						    <line x1="17" y1="7" x2="17" y2="13"/>
						  </g>
						
						  <!-- 카트/화살표: 채움 -->
						  <path fill="currentColor" d="M25.658,10l-2.422,9H10.781L8.159,8.515C7.937,7.625,7.137,7,6.219,7H4C3.448,7,3,7.448,3,8
						    c0,0.552,0.448,1,1,1h2.219l2.621,10.485C9.063,20.375,9.863,21,10.781,21h12.455c0.902,0,1.692-0.604,1.93-1.474L27.764,10H25.658z"/>
						  <polygon fill="currentColor" points="21,12 17,16 13,12"/>
					</svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">소비자 주문</h3>
                  <p>
                    소비자가 상품을 장바구니에 담고 결제를 진행하면 주문이 생성됩니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">06</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 32 32" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
					  <g id="box" clip-path="url(#clip-box)">
					    <g id="Group_3126" data-name="Group 3126" transform="translate(-260 -104)">
					      <g id="Group_3116" data-name="Group 3116">
					        <g id="Group_3115" data-name="Group 3115">
					          <g id="Group_3114" data-name="Group 3114">
					            <path id="Path_3990" data-name="Path 3990" d="M291.858,111.843a.979.979,0,0,0-.059-.257.882.882,0,0,0-.055-.14.951.951,0,0,0-.184-.231.766.766,0,0,0-.061-.077c-.006,0-.014,0-.02-.01a.986.986,0,0,0-.374-.18l-.008,0h0l-14.875-3.377a1.008,1.008,0,0,0-.444,0L260.9,110.944a.984.984,0,0,0-.382.184c-.006.005-.014.005-.02.01-.026.021-.038.054-.062.077a.971.971,0,0,0-.183.231.882.882,0,0,0-.055.14.979.979,0,0,0-.059.257c0,.026-.017.049-.017.076v16.162a1,1,0,0,0,.778.975l14.875,3.377a1,1,0,0,0,.444,0l14.875-3.377a1,1,0,0,0,.778-.975V111.919C291.875,111.892,291.86,111.869,291.858,111.843ZM276,114.27l-3.861-.877L282.328,111l4.029.915Zm-9.2-.038,3.527.8v5.335l-.568-.247a.5.5,0,0,0-.351-.018l-1.483.472-1.125-.836Zm9.2-4.664,4.1.931-10.19,2.389-4.269-.969Zm-13.875,3.6L265.8,114v5.985a.5.5,0,0,0,.2.4l1.532,1.139a.5.5,0,0,0,.3.1.485.485,0,0,0,.151-.023l1.549-.493,1.1.475a.5.5,0,0,0,.7-.459V115.26l3.674.833v14.112l-12.875-2.922Zm27.75,14.112L277,130.205V116.093l12.875-2.922Z" fill="currentColor"/>
					          </g>
					        </g>
					      </g>
					      <g id="Group_3119" data-name="Group 3119">
					        <g id="Group_3118" data-name="Group 3118">
					          <g id="Group_3117" data-name="Group 3117">
					            <path id="Path_3991" data-name="Path 3991" d="M278.841,127.452a.508.508,0,0,0,.11-.012l5.613-1.274a.5.5,0,0,0,.39-.488v-6.1a.5.5,0,0,0-.188-.39.5.5,0,0,0-.422-.1l-5.614,1.275a.5.5,0,0,0-.389.488v6.1a.5.5,0,0,0,.5.5Zm.5-6.2,4.613-1.047v5.074l-4.613,1.047Z" fill="currentColor"/>
					          </g>
					        </g>
					      </g>
					      <g id="Group_3122" data-name="Group 3122">
					        <g id="Group_3121" data-name="Group 3121">
					          <g id="Group_3120" data-name="Group 3120">
					            <path id="Path_3992" data-name="Path 3992" d="M280.688,123.093a.524.524,0,0,0,.111-.012l1.918-.435a.5.5,0,0,0-.221-.976l-1.918.435a.5.5,0,0,0,.11.988Z" fill="currentColor"/>
					          </g>
					        </g>
					      </g>
					      <g id="Group_3125" data-name="Group 3125">
					        <g id="Group_3124" data-name="Group 3124">
					          <g id="Group_3123" data-name="Group 3123">
					            <path id="Path_3993" data-name="Path 3993" d="M282.611,123.7l-2.029.44a.5.5,0,0,0,.106.989.492.492,0,0,0,.107-.011l2.029-.441a.5.5,0,0,0,.382-.594A.493.493,0,0,0,282.611,123.7Z" fill="currentColor"/>
					          </g>
					        </g>
					      </g>
					    </g>
					  </g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">포장 준비</h3>
                  <p>
                    주문된 상품은 포장 지침에 따라 농가 또는 물류팀에서 포장을 준비합니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">07</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 512.805 512.805" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                    <g stroke="currentColor"
					   fill="currentColor"
					   stroke-width="2"
					   stroke-linecap="round"
					   stroke-linejoin="round"
					   vector-effect="non-scaling-stroke">
						<g>
							<g>
								<path d="M332.8,460.8h-17.067c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533H332.8c4.71,0,8.533-3.823,8.533-8.533
									S337.51,460.8,332.8,460.8z"/>
								<path d="M264.533,460.8H179.2c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533h85.333c4.71,0,8.533-3.823,8.533-8.533
									S269.244,460.8,264.533,460.8z"/>
								<path d="M128,460.8H8.533c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533H128c4.71,0,8.533-3.823,8.533-8.533
									S132.71,460.8,128,460.8z"/>
								<path d="M500.966,249.967l-23.39-23.39L469.333,128c0-23.526-19.14-42.667-42.667-42.667h-59.733
									c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533h59.733c13.875,0,25.6,11.725,25.626,26.308l7.765,93.158H431.94
									l10.889-21.786c2.116-4.215,0.401-9.335-3.814-11.443c-4.224-2.116-9.344-0.401-11.452,3.814l-14.703,29.414h-45.926
									c-4.71,0-8.533,3.823-8.533,8.533c0,4.71,3.823,8.533,8.533,8.533h98.867l23.1,23.1c4.864,4.864,6.016,16.051,6.033,19.567v8.533
									H486.4c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533h8.533v68.267h-17.749c-4.156-28.902-29.013-51.2-59.051-51.2
									c-32.939,0-59.733,26.795-59.733,59.733s26.795,59.733,59.733,59.733c30.037,0,54.895-22.298,59.051-51.2h26.283
									c4.71,0,8.533-3.823,8.533-8.533V281.6C512,279.492,511.693,260.685,500.966,249.967z M418.133,426.667
									c-23.526,0-42.667-19.14-42.667-42.667s19.14-42.667,42.667-42.667c23.526,0,42.667,19.14,42.667,42.667
									S441.66,426.667,418.133,426.667z"/>
								<path d="M128,358.4c-14.114,0-25.6,11.486-25.6,25.6s11.486,25.6,25.6,25.6s25.6-11.486,25.6-25.6S142.114,358.4,128,358.4z
									 M128,392.533c-4.702,0-8.533-3.831-8.533-8.533s3.831-8.533,8.533-8.533s8.533,3.831,8.533,8.533S132.702,392.533,128,392.533z"
									/>
								<path d="M503.467,460.8H366.933c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533h136.533
									c4.71,0,8.533-3.823,8.533-8.533S508.177,460.8,503.467,460.8z"/>
								<path d="M418.133,358.4c-14.114,0-25.6,11.486-25.6,25.6s11.486,25.6,25.6,25.6s25.6-11.486,25.6-25.6
									S432.247,358.4,418.133,358.4z M418.133,392.533c-4.702,0-8.533-3.831-8.533-8.533s3.831-8.533,8.533-8.533
									s8.533,3.831,8.533,8.533S422.835,392.533,418.133,392.533z"/>
								<path d="M332.8,34.133H42.667C19.14,34.133,0,53.274,0,76.8v273.067c0,23.927,18.739,42.667,42.667,42.667
									c4.71,0,8.533-3.823,8.533-8.533s-3.823-8.533-8.533-8.533c-14.353,0-25.6-11.247-25.6-25.6V76.8c0-14.114,11.486-25.6,25.6-25.6
									h281.6v238.933h-281.6c-4.71,0-8.533,3.823-8.533,8.533s3.823,8.533,8.533,8.533h281.6v68.267H187.051
									c-4.156-28.902-29.022-51.2-59.051-51.2c-32.939,0-59.733,26.795-59.733,59.733S95.061,443.733,128,443.733
									c30.029,0,54.895-22.298,59.051-51.2H332.8c4.71,0,8.533-3.823,8.533-8.533V42.667C341.333,37.956,337.51,34.133,332.8,34.133z
									 M128,426.667c-23.526,0-42.667-19.14-42.667-42.667s19.14-42.667,42.667-42.667c23.526,0,42.667,19.14,42.667,42.667
									S151.526,426.667,128,426.667z"/>
							</g>
						</g>
					</g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">출고 및 배송</h3>
                  <p>
                     소비자에게 배송이 시작됩니다. <br> 신선함을 유지하기 위해 콜드체인(냉장) 택배로 보내드립니다.
                  </p>
                </div>
              </div>
            </div>
            <div class="col-lg-3 col-md-6">
              <div class="service-item">
                <span class="number">07</span>
                <div class="service-item-icon">
                  <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" width="80" height="80" x="0" y="0" viewBox="0 0 512.805 512.805" style="enable-background: new 0 0 512 512" xml:space="preserve" class="">
                    <g stroke="currentColor"
					   fill="currentColor"
					   stroke-width="2"  
					   stroke-linecap="round"
					   stroke-linejoin="round">
					    <path d="M447.77,33.653c-36.385-5.566-70.629,15.824-82.588,49.228h-44.038v37.899h40.902
					        c5.212,31.372,29.694,57.355,62.855,62.436c41.278,6.316,79.882-22.042,86.222-63.341C517.428,78.575,489.07,39.969,447.77,33.653z"/>
					    <path d="M162.615,338.222c0-6.88-5.577-12.468-12.468-12.468H96.16c-6.891,0-12.467,5.588-12.467,12.468
					        c0,6.868,5.576,12.467,12.467,12.467h53.988C157.038,350.689,162.615,345.091,162.615,338.222z"/>
					    <path d="M392.999,237.965L284.273,340.452l-37.966,9.398v-86.619H0v215.996h246.307v-59.454l35.547-5.732
					        c16.95-2.418,29.396-6.692,44.336-15.018l46.302-24.228v104.432h132.435V270.828C504.927,202.618,428.016,202.43,392.999,237.965z
					        M215.996,448.913H30.313v-155.37h185.683v63.805l-36.419,9.01c-15.968,4.395-25.708,20.518-22.174,36.696l0.298,1.247
					        c3.478,15.912,18.651,26.436,34.785,24.14l23.51-3.788V448.913z"/>
					</g>
                  </svg>
                </div>
                <div class="service-item-content">
                  <h3 class="service-heading">소비자 수령 완료</h3>
                  <p>
                    소비자가 상품을 수령하면 유통 과정이 완료되며, 리뷰를 남길 수 있습니다.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
     </section>
  </main>


<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

</body>
</html>