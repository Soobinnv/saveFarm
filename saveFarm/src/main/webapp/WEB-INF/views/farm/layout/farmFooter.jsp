<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>


  <footer id="footer" class="footer dark-background">

    <div class="footer-top">
      <div class="container">
        <div class="row gy-4">
          <div class="col-lg-4 col-md-6 footer-about">
            <a href="index.html" class="logo d-flex align-items-center">
              <span class="sitename">SaveFarm</span>
            </a>
            <div class="footer-contact pt-3">
              <p>월드컵북로 21 풍성빌딩</p>
              <p>서울특별시, S.L. 04001</p>
              <p class="mt-3"><strong>대표번호 :</strong> <span>0507-1371-8548</span></p>
              <p><strong>이메일 :</strong> <span>SaveFarm@gmail.com</span></p>
            </div>
          </div>

          <div class="col-lg-2 col-md-4 footer-links">
            <h4>이용방법</h4>
            <ul>
              <li><a href="${pageContext.request.contextPath}/farm">홈</a></li>
              <li><a href="${pageContext.request.contextPath}/farm/guide">과정</a></li>
            </ul>
          </div>

          <div class="col-lg-2 col-md-4 footer-links">
            <h4>활동하기</h4>
            <ul>
              <li><a href="#">납품신청</a></li>
              <li><a href="#">신청목록</a></li>
              <li><a href="#">농장관리</a></li>
            </ul>
          </div>

          <div class="col-lg-2 col-md-4 footer-links">
            <h4>고객지원</h4>
            <ul>
              <li><a href="#">공지사항</a></li>
              <li><a href="#">문의</a></li>
              <li><a href="#">자주묻는 질문</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <div class="copyright text-center">
      <div class="container d-flex flex-column flex-lg-row justify-content-center justify-content-lg-between align-items-center">

		<div class="d-flex flex-column align-items-center align-items-lg-start">
			<div>
		    	© Copyright <strong><span>SaveFarm</span></strong>. 농가와 소비자가 함께 웃는 유통의 시작
		  	</div>
		  	<div class="credits">
				이 사이트는 <a href="${pageContext.request.contextPath}/farm/home" class="footer_a">농가 전용 서비스</a>입니다. 정직한 농산물이 정당한 가치를 받을 수 있도록 함께합니다.
		  	</div>
		</div>

      </div>
    </div>

  </footer>

<!-- Scroll Top -->
<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Preloader -->
<div id="preloader"></div>

  
