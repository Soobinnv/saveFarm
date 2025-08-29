<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<aside class="sidebar-left border-right bg-white shadow"
  id="leftSidebar" data-simplebar>
  
  <a href="#leftSidebar"
    class="btn collapseSidebar toggle-btn d-lg-none text-muted ml-2 mt-3"
    aria-label="Toggle sidebar">
    <i class="fe fe-x"><span class="sr-only">Toggle sidebar</span></i>
  </a>

  <nav class="vertnav navbar navbar-light">
    <!-- nav bar -->
    <div class="w-100 mb-4 d-flex">
      <a class="navbar-brand mx-auto mt-2 flex-fill text-center" href="javascript:void(0)">
      </a>
    </div>
		
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="${pageContext.request.contextPath}/admin"
					aria-expanded="false"
					class="nav-link">
					<i class="fe fe-hard-drive fe-16"></i>
					<span class="ml-3 item-text">대시보드</span>
				</a>
			
			</li>
		</ul>
		
		
		
		<p class="text-muted nav-heading mt-4 mb-1">
			<span>Components</span>
		</p>

		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-member"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-users fe-16"></i>
					<span class="ml-3 item-text">회원관리</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-member">
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/member/">
							<span class="ml-1 item-text">회원 리스트</span>
						</a>
					</li>
				
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/inquiry/inquiryList/100">
							<span class="ml-1 item-text">회원 문의</span>
						</a>
					</li>
				
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/notice/noticeList/100">
							<span class="ml-1 item-text">회원 공지사항</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-farm"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-gift fe-16"></i>
					<span class="ml-3 item-text">농가관리</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-farm">
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/farm/">
							<span class="ml-1 item-text">농가 리스트</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/notice/guideLineslist/2">
							<span class="ml-1 item-text">농가 유통 가이드라인</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/inquiry/inquiryList/200">
							<span class="ml-1 item-text">농가 문의</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/notice/noticeList/200">
							<span class="ml-1 item-text">농가 공지사항</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-product"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-shopping-bag fe-16"></i>
					<span class="ml-3 item-text">상품관리</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-product">
					<li class="nav-item">
						<a id="productList" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">상품리스트</span>
						</a>
					</li>
					<li class="nav-item">
						<a id="supplyManagement" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">납품관리</span>
						</a>
					</li>
					<li class="nav-item">
						<a id="productQna" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">상품문의</span>
						</a>
					</li>
					<li class="nav-item">
						<a id="productReview" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">상품리뷰</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-order"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-shopping-cart fe-16"></i>
					<span class="ml-3 item-text">주문관리</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-order">
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/order/orderList/100">
							<span class="ml-1 item-text">주문완료</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/order/orderList/110">
							<span class="ml-1 item-text">배송</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/order/orderDetailList/100">
							<span class="ml-1 item-text">배송 후 교환</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/order/orderDetailList/110">
							<span class="ml-1 item-text">구매확정</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/order/orderList/120">
							<span class="ml-1 item-text">주문리스트</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-package"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-shopping-cart fe-16"></i>
					<span class="ml-3 item-text">구독패키지</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-package">
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/package/list">
							<span class="ml-1 item-text">구독패키지목록</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/package/memberList">
							<span class="ml-1 item-text">회원 구독리스트</span>
						</a>
					</li>
					<li class="nav-item">
						<a class="nav-link pl-3" href="${pageContext.request.contextPath}/admin/package/review">
							<span class="ml-1 item-text">구독상품 리뷰</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="#ui-elements-withdraw"
					data-toggle="collapse" aria-expanded="false"
					class="dropdown-toggle nav-link">
					<i class="fe fe-credit-card fe-16"></i>
					<span class="ml-3 item-text">고객 서비스</span>
				</a>
				<ul class="collapse list-unstyled pl-4 w-100" id="ui-elements-withdraw">
					<li class="nav-item">
						<a id="refundList" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">주문 취소</span>
						</a>
					</li>
					<li class="nav-item">
						<a id="returnList" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">반품 관리</span>
						</a>
					</li>
					<li class="nav-item">
						<a id="refundReturnList" class="nav-link pl-3" href="javascript:void(0);">
							<span class="ml-1 item-text">취소/반품 통합 내역</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
		
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="${pageContext.request.contextPath}/admin/FAQ/" aria-expanded="false" class="nav-link">
					<i class="fe fe-message-square fe-16"></i>
					<span class="ml-3 item-text">자주하는 질문</span>
				</a>
			
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="${pageContext.request.contextPath}/admin/report/" aria-expanded="false" class="nav-link">
					<i class="fe fe-alert-circle fe-16"></i>
					<span class="ml-3 item-text">신고</span>
				</a>
			</li>
		</ul>
		<ul class="navbar-nav flex-fill w-100 mb-2">
			<li class="nav-item dropdown">
				<a href="" aria-expanded="false" class="nav-link">
					<i class="fe fe-database fe-16"></i>
					<span class="ml-3 item-text">운영관리</span>
				</a>
			
			</li>
		</ul>		
	</nav>
</aside>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const toggleButtons = document.querySelectorAll('.collapseSidebar'); // 모든 버튼 선택
    const sidebar = document.querySelector('#leftSidebar');

    toggleButtons.forEach((btn) => {
      btn.addEventListener('click', function () {
        sidebar.classList.toggle('collapsed');
      });
    });
  });

</script>


