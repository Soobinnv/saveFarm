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
    <div class="page-title dark-background" data-aos="fade" style="background-image: url(${pageContext.request.contextPath}/dist/farm/header_footer/img/registerTitle2.webp);">
      <div class="container position-relative">
        <h1>
        	<span class="title">납품신청 ${mode=='update'?'수정':'신청'}</span>
        </h1>
       <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm/register">돌아가기</a></li>
            <li class="current">신청서 ${mode=='update'?'수정하기':'신청하기'}</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->
    
    <section id="comment-form" class="comment-form section">
		<div class="container">
		    <form name="registerForm" method="post" enctype="application/x-www-form-urlencoded">
		      <h4>신청서</h4>
		      <p>작성하신 신청서의 정보를 기준으로 납품 승인여부가 결정됩니다.* </p>
		      <table class="table write-form">
					<tr>
						<td class="col-md-2 bg-light center align-middle">농산물 종류</td>
						<td colspan="2">
					      <div class="row g-2">
					        <div class="col-md-4">
					          <select id="supplySelect" name="supplyName" class="form-select">
					            <option value="${dto.supplyName}">${dto.supplyName}</option>
					          </select>
					        </div>
					        <div class="col-md-8">
					          <input type="text" id="supplyOther" name="coment" class="form-control"
					                 maxlength="100"
					                 placeholder="종류에 없으면 ‘기타’ 선택 후 입력"
					                 value="${dto.coment}">
					        </div>
					      </div>
					    </td>
					</tr>
					<tr>
						<td class="col-md-2 bg-light align-middle">총 납품량</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					          <input type="text" name="supplyQuantity" class="form-control" maxlength="100" placeholder="총 납품할 농산물의 양을 적어주세요." value="${dto.saleQuantity}">
					        </div>
					        <div class="col-md-5 align-items-center align-middle">
					         	<h6>단위 무게의 단위는 g* 입니다.</h6>
					        </div>
					      </div>
					    </td>
					</tr>
				
					<tr>
						<td class="col-md-2 bg-light align-middle">단위량</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					          <input type="text" name="unitQuantity" class="form-control" maxlength="100" placeholder="납품단위별 양을 입력해주세요." value="${dto.unitPrice}">
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
					          <input type="text" name="unitPrice" class="form-control" maxlength="100" placeholder="단위별 금액을 입력해주세요." value="${dto.unitPrice}">
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
					          <input type="date" name="harvestDate" class="form-control" maxlength="100" value="${dto.harvestDate}">
					        </div>
					      </div>
					    </td>
					</tr>
				</table>
		
		      <div class="text-center">
		        <button type="button" class="btn btn-primary" onclick="sendOk();">${mode=='update'?'수정완료':'신청완료'}</button>
       			<c:if test="${mode=='update'}">
		        	<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/farm/registerList';">수정취소</button>
					<input type="hidden" name="supplyNum" value="${dto.supplyNum}">
					<input type="hidden" name="farmNum" value="${dto.farmNum}">
					<input type="hidden" name="page" value="${page}">
				</c:if>
		      </div>
		    </form>
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script src="${pageContext.request.contextPath}/dist/farm/js/supplyForm.js"></script>
</body>
</html>