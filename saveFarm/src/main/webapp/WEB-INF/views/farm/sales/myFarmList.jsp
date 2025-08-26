<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.webp);">
      <div class="container position-relative">
        <h1>내 농가 매출 관리</h1>
        <p>납품목록에 따른 판매량과 금액을 확인할 수 있습니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">돌아가기</a></li>
            <li class="current">내 농가</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->  
    
	<section id="comment-form" class="comment-form section">
		<div class="container">
			<div class="row g-2 align-items-end mb-3">
				
				<div class="col-md-12" style="padding: 50px 0 20px 0;">
					<h3>지금까지 총 납품한 금액</h3>
					<form action="">
						<fmt:formatNumber value="${totalEarning}" type="currency" currencySymbol="₩"/>
					</form>
				</div>
				
				<div class="col-md-3">
					<span class="small text-muted">
						총 <strong>${dataCount}</strong>건
						<c:if test="${total_page > 0}"> _ <strong>${page}</strong> / ${total_page} 페이지</c:if>
					</span>
				</div>
				<div class="col-md-6 text-center">
					<select name="schType">
						<option value="varietyName" ${schType=="varietyName"?"selected":""}>제품명</option>
						<option value="coment" ${schType=="coment"?"selected":""}>'기타'로 작성한 제품명</option>
					</select>
					<input type="text" name="kwd" value="${kwd}">
					<button type="button" class="btn-default" onclick="searchList();"><i class="bi bi-search"></i></button>
				</div>
				
				<div class="col-md-3">
					<div class="d-flex justify-content-end align-items-center gap-2">
						<label for="varietyNum" class="form-label mb-0">품목</label>
						<select id="varietyNum" name="varietyNum" class="form-select" style="max-width: 180px;">
						  <option value="-1" ${varietyNum == -1 ? 'selected' : ''}>전체</option>
						  <c:forEach var="v" items="${varietyList}">
						    <option value="${v.varietyNum}" ${v.varietyNum == varietyNum ? 'selected' : ''}>
						      ${v.varietyName}
						    </option>
						  </c:forEach>
						</select>
					</div>
				</div>
			</div>  
	    	
	    	<form name="searchForm" method="get" action="${pageContext.request.contextPath}/farm/sales/myFarmList" class="mb-3">
    			<input type="hidden" name="size" value="${size}"/>

				<c:if test="${varietyNum != -1}">
				  <div class="row g-3 mb-3">
				    <c:choose>
				      <c:when test="${not empty saleList}">
				        <c:forEach var="vo" items="${saleList}">
				          <div class="col-md-6">
				            <div class="p-3 border rounded-3 h-100">
				              <div class="d-flex justify-content-between">
				                <strong>${vo.varietyName}</strong>
				                <c:if test="${vo.varietyNum != -1}">
				                  <a class="small"
				                     href="${pageContext.request.contextPath}/farm/sales/myFarmList?varietyNum=${vo.varietyNum}&schType=${schType}&kwd=${kwd}">
				                    해당 품목만 보기
				                  </a>
				                </c:if>
				              </div>
				
				              <div class="mt-2">
				                총 납품한 양:
				                <strong>
				                  <fmt:formatNumber value="${empty vo.totalQty ? 0 : vo.totalQty}" pattern="#,##0.###"/>
				                </strong>
				              </div>
				              <div>
				                총 납품 금액:
				                <strong>
				                  <fmt:formatNumber value="${empty vo.totalVarietyEarning ? 0 : vo.totalVarietyEarning}"
				                                    type="currency" currencySymbol="₩"/>
				                </strong>
				              </div>
				            </div>
				          </div>
				        </c:forEach>
				      </c:when>
				
				      <c:otherwise>
				        <div class="col-md-6">
				          <div class="p-3 border rounded-3 h-100">
				            <div class="d-flex justify-content-between">
				              <strong>합계</strong>
				            </div>
				            <div class="mt-2">
				              총 납품한 양:
				              <strong><fmt:formatNumber value="${empty totalQty ? 0 : totalQty}" pattern="#,##0.###"/></strong>
				            </div>
				            <div>
				              총 납품 금액:
				              <strong><fmt:formatNumber value="${empty totalVarietyEarning ? 0 : totalVarietyEarning}" type="currency" currencySymbol="₩"/></strong>
				            </div>
				          </div>
				        </div>
				      </c:otherwise>
				    </c:choose>
				  </div>
				</c:if>

    			<!-- /카드 섹션 -->

	      		<table class="table table-hover">
					<thead>
						<tr>
							<th class="text-center">번호</th>
							<th class="text-center">제품명</th>
							<th class="text-center">납품총량</th>
							<th class="text-center">판매단위</th>
							<th class="text-center">단위금액</th>
							<th class="text-center">코멘트</th>
						</tr>
					 </thead>
				  	<tbody>
					  <c:forEach var="dto" items="${supplyList}" varStatus="status">
						  <tr class="align-middle">
						    <td class="text-center">${dataCount - (page-1) * size - status.index}</td>
						    <td class="text-center">
						      <c:choose>
						        <c:when test="${not empty dto.varietyName}">${dto.varietyName}</c:when>
						        <c:otherwise>${dto.varietyNum}</c:otherwise>
						      </c:choose>
						    </td>
						    <!-- 납품총량 -->
						    <td class="text-center">
						      <fmt:formatNumber value="${dto.supplyQuantity}" pattern="#,##0.###"/>
						    </td>
						    <!-- 판매단위 -->
						    <td class="text-center">
						      <fmt:formatNumber value="${dto.unitQuantity}" pattern="#,##0.###"/>
						    </td>
						    <!-- 단위금액 -->
						    <td class="text-center">
						      <fmt:formatNumber value="${dto.unitPrice}" type="currency" currencySymbol="₩"/>
						    </td>
						    <!-- 코멘트 -->
						    <td class="text-center"><c:out value="${empty dto.coment ? '-' : dto.coment}"/></td>
						  </tr>
						</c:forEach>
					</tbody>

				</table>
				<div class="page-navigation d-flex justify-content-center my-3">
					${dataCount == 0 ? "등록된 게시글이 없습니다" : paging}
				</div>
				<div class="row mt-3">
					<div class="col-md-3">
						<button type="button" class="btn-default" onclick="location.href='${pageContext.request.contextPath}/farm/sales/myFarmList';" title="새로고침"><i class="bi bi-arrow-clockwise"></i></button>
					</div>
				</div>
	    	</form>
	    
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script type="text/javascript">
// 폼과 폼 밖 검색값을 합쳐 쿼리스트링 생성
function buildSearchParams() {
  const f = document.forms['searchForm'];
  const sel = document.querySelector('select[name="schType"]');
  const kwdEl = document.querySelector('input[name="kwd"]');
  const varietySel = document.getElementById('varietyNum'); // ✅

  const params = new URLSearchParams(new FormData(f));
  if (sel) params.set('schType', sel.value || 'varietyName');

  let kwd = (kwdEl?.value ?? '').trim();
  params.set('kwd', kwd);

  if (varietySel) params.set('varietyNum', varietySel.value); // ✅

  return { f, params };
}

// 검색 실행(버튼/엔터)
function searchList() {
  try {
    const { f, params } = buildSearchParams(); // 한번만 호출
    params.delete('page');
    location.href = f.action + '?' + params.toString();
  } catch (e) {}
}

//품목 변경 시 자동 검색
(function () {
  const varietySel = document.getElementById('varietyNum');
  if (!varietySel) return;

  varietySel.addEventListener('change', function () {
    try {
      const { f, params } = buildSearchParams();
      params.delete('page'); // 첫 페이지부터
      location.href = f.action + '?' + params.toString();
    } catch (e) {}
  });
})();

// 엔터키로도 검색 / 행 클릭 이동
document.addEventListener('DOMContentLoaded', function () {
  const kwdEl = document.querySelector('input[name="kwd"]');
  if (kwdEl) {
    kwdEl.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        searchList();
      }
    });
  }

  // 테이블 행 클릭 이동(data-href)
  document.querySelectorAll('tr[data-href]').forEach(tr => {
    tr.style.cursor = 'pointer';
    tr.addEventListener('click', () => {
      const href = tr.getAttribute('data-href');
      if (href) location.href = href;
    });
  });
});
</script>

</body>
</html>
