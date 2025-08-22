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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle3.webp);">
      <div class="container position-relative">
        <h1>
        	<span class="title">납품신청 확인</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm/${back}/list">돌아가기</a></li>
            <li class="current">신청서 확인하기</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    <form name="registerForm" method="post" action="${pageContext.request.contextPath}/farm/register/${mode}" enctype="application/x-www-form-urlencoded">
		     	<h4>신청서</h4>
		      	<c:choose>
		      		<c:when test="${dto.state == 1}">
			      		<p>작성하신 신청서의 정보를 기준으로 납품 승인여부가 결정됩니다.* </p>
		      		</c:when>
		      		<c:otherwise>
						<p>승인된 납품 신청서 입니다. 작성하신 신청서를 바탕으로 승인되었습니다.* </p>
		      		</c:otherwise>
		      </c:choose>
		      <table class="table write-form">
					<tr>
						<td class="col-md-3 bg-light center align-middle">농산물 종류</td>
						<td colspan="2">
					    	<div class="row g-2">
						        <div class="col-md-2">
						        	${varietyName}
									<input type="hidden" name="varietyNum"   value="${dto.varietyNum}"/>
									<input type="hidden" name="varietyName"  value="${varietyName}"/>
						        </div>
						        <div class="col-md-10">
						        	<c:if test="${not empty dto.coment}">
										${dto.coment}
									</c:if>
									<input type="hidden" name="coment" value="${dto.coment}"/>
						      	</div>
					    	</div>
					    </td>
					</tr>
					<tr>
						<td class="col-md-2 bg-light align-middle">총 납품량</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
								${dto.supplyQuantity}
								<input type="hidden" name="supplyQuantity" value="${dto.supplyQuantity}">
					        </div>
					        <div class="col-md-5 align-items-center align-middle">
					         	<h6>단위 무게의 단위는 g* 입니다.</h6>
					        </div>
					      </div>
					    </td>
					</tr>
				
					<tr>
						<td class="col-md-2 bg-light align-middle">판매단위</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					        	${dto.unitQuantity}
					        	<input type="hidden" name="unitQuantity" value="${dto.unitQuantity}">
					        </div>
					        <div class="col-md-5 align-items-center">
					         	<h6>단위 무게의 단위는 g* 입니다.</h6>
					        </div>
					      </div>
					    </td>
					</tr>
					
					<tr>
						<td class="col-md-2 bg-light align-middle">단위당 금액</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					        	${dto.unitPrice}
					        	<input type="hidden" name="unitPrice" value="${dto.unitPrice}">
					        </div>
					        <div class="col-md-5 align-items-center">
					         	<h6>금액의 단위는 1원* 입니다.</h6>
					        </div>
					      </div>
					    </td>
					</tr>
					
					<tr>
						<td class="col-md-2 bg-light align-middle">수확날짜</td>
						<td colspan="2">
					     	<div class="row g-2 align-items-center">
					        	<div class="col-md-7">
									<input type="hidden" name="harvestDate" value="${dto.harvestDate != null ? dto.harvestDate.substring(0,10) : ''}">
						        	<c:choose>
										<c:when test="${not empty dto.harvestDate}">
											${dto.harvestDate.substring(0,10)}
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>
					      		</div>
					    	</div>
					    </td>
					</tr>
					
					<tr>
						<td class="col-md-2 bg-light align-middle">긴급구출상품신청</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					        	<input type="hidden" name="rescuedApply" value="${dto.rescuedApply}">
								 <c:choose>
									<c:when test="${dto.rescuedApply == 1}">신청</c:when>
									<c:otherwise>
										미신청
									</c:otherwise>
								</c:choose>
					        </div>
					      </div>
					    </td>
					</tr>
				</table>
		
				<div class="text-center">
		      		<button type="button" class="btn-primary" style="width: 110px; background-color: white; color: black; border: 1px solid #116530;" onclick="location.href='${pageContext.request.contextPath}/farm/${back}/list'">리스트</button>
		      	<c:if test="${dto.state==1}">
					<button type="button" class="btn-primary" style="width: 110px;" onclick="location.href='${pageContext.request.contextPath}/farm/register/update?supplyNum=${dto.supplyNum}&back=${back}'">수정하기</button>
				</c:if>
					<input type="hidden" name="supplyNum" value="${dto.supplyNum}">
					<input type="hidden" name="farmNum" value="${dto.farmNum}">
					<input type="hidden" name="productNum" value="${dto.productNum}">
					<input type="hidden" name="state" value="${dto.state}">
					<input type="hidden" name="page" value="${page}">
					<input type="hidden" name="back" value="${back}">
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
function sendOk() {
  const f = document.registerForm;

  // 필드 존재할 때만 검증
  const mustBeNumber = ['supplyQuantity','unitQuantity','unitPrice'];
  const p = /^[0-9]+(\.[0-9]+)?$/;

  for (const name of mustBeNumber) {
    if (!f[name]) continue;                // 없으면 스킵
    const v = (f[name].value || '').trim();
    if (!v) { alert('값을 확인하세요: ' + name); return; }
    if (!p.test(v)) { alert('숫자만 입력: ' + name); return; }
  }

  if (f.harvestDate) {
    const v = (f.harvestDate.value || '').trim();
    const t = new Date();
    const today = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
    if (!v) { alert('수확일을 확인하세요.'); return; }
    if (v > today) { alert('미래 날짜는 불가합니다.'); return; }
  }

  f.submit();
}
</script>
</body>
</html>