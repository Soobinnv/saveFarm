<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MY PAGE</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/myPage.css" type="text/css">
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>

</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

  <div class="container">
    <aside class="sidebar">
      <h2>MY PAGE</h2>
      <ul>
        <li>주문내역 조회</li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">주문/배송 조회</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">정기배송 조회</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">취소/교환/반품 조회</a></li>
        <li>내 활동</li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">찜</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">나의 리뷰</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">1:1 문의</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">상품 문의</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">FAQ</a></li>
        <li>회원정보</li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">회원정보 수정</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">회원탈퇴</a></li>
      </ul>
    </aside>

    <main class="content">
      <div class="welcome-box">
        <div class="welcome-left">
          <img src="${pageContext.request.contextPath}/dist/images/person.png" class="profile-avatar" alt="프로필 사진">
          <div>
            <strong>회원님 반갑습니다.</strong><br />
            가입하신 회원은 <span style="color: red;">WELCOME</span> 입니다.
          </div>
        </div>
        <div class="welcome-right">
          <div>쿠폰<br><strong>1</strong></div>
          <div style="margin-top: 10px;">구매후기<br><strong>0</strong></div>
        </div>
      </div>

      <section class="tab-section">
		  <div class="tab-menu">
		    <button class="active" data-tab="tab1">일반택배</button>
		    <button data-tab="tab2">정기배송 구독</button>
		    <button data-tab="tab3">취소/교환/반품</button>
		  </div>
		
		  <div class="tab-content" id="tab1">
		    <div class="order-steps">
		      <div><i class="fas fa-clipboard-list"></i>주문접수</div>
		      <div><i class="fas fa-credit-card"></i>결제완료</div>
		      <div><i class="fas fa-box"></i>상품준비중</div>
		      <div><i class="fas fa-truck"></i>배송중</div>
		      <div><i class="fas fa-gift"></i>배송완료</div>
		    </div>
		    <p style="text-align:center; color:#aaa; margin-top: 20px;">내역이 없습니다.</p>
		  </div>
		
		  <div class="tab-content" id="tab2" style="display:none;">
		    <p>정기배송 구독 내역이 없습니다.</p>
		  </div>
		
		  <div class="tab-content" id="tab3" style="display:none;">
		    <p>취소/교환/반품 내역이 없습니다.</p>
		  </div>
	</section>

      <section class="like-section">
        <h3>MY LIKE ITEMS</h3>
        <p>MY LIKE ITEMS가 없습니다.</p>
      </section>
    </main>
  </div>
  
<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/layout/footerResources.jsp"/>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
	  const buttons = document.querySelectorAll(".tab-menu button");
	  const contents = document.querySelectorAll(".tab-content");

	  buttons.forEach(btn => {
	    btn.addEventListener("click", () => {
	      // 모든 버튼 비활성화
	      buttons.forEach(b => b.classList.remove("active"));
	      // 클릭한 버튼 활성화
	      btn.classList.add("active");

	      // 모든 탭 내용 숨김
	      contents.forEach(c => c.style.display = "none");
	      // 해당 탭 내용만 표시
	      document.getElementById(btn.dataset.tab).style.display = "block";
	    });
	  });
	});
</script>


</body>
</html>
