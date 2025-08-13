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
<body data-context-path="${pageContext.request.contextPath}">

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

  <div class="container" id="container">
    <aside class="sidebar">
      <h2 onclick="loadContent('/api/myPage', renderMyPageMainHtml);">MY PAGE</h2>
      <ul>
        <li>주문내역 조회</li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">주문/배송 조회</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">정기배송 조회</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">취소/교환/반품 조회</a></li>
        <li>내 활동</li>
        <li style="margin-left: 10px;"><a href="javascript:void(0);" onclick="loadContent('/api/myPage/wish', renderMyWishListHtml);">찜</a></li>
        <li style="margin-left: 10px;"><a href="javascript:void(0);" onclick="loadContent('/api/myPage/reviews', renderMyReviewListHtml);">나의 리뷰</a></li>
        <li style="margin-left: 10px;"><a href="javascript:void(0);" onclick="loadContent('/api/myPage/inquirys', renderMyInquiryListHtml);">1:1 문의</a></li>
        <li style="margin-left: 10px;"><a href="javascript:void(0);" onclick="loadContent('/api/myPage/qnas', renderMyQnaListHtml);">상품 문의</a></li>
        <li style="margin-left: 10px;"><a href="javascript:void(0);" onclick="loadContent('/api/myPage/faqs', renderFaqListHtml);">FAQ</a></li>
        <li>회원정보</li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">회원정보 수정</a></li>
        <li style="margin-left: 10px;"><a href="${pageContext.request.contextPath}/">회원탈퇴</a></li>
      </ul>
    </aside>

    <main class="content" id="content">

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
<script type="text/javascript"
		src="${pageContext.request.contextPath}/dist/js/myPage.js"></script>

</body>
</html>
