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
        <h1>높은수익 차트</h1>
        <p>가장 많은 수익금을 가져다준 납품에 대한 정보를 그래프로 보실 수 있습니다.</p>
        <nav class="breadcrumbs">
          <ol>
            <li><a href="${pageContext.request.contextPath}/farm">돌아가기</a></li>
            <li class="current">판매 차트</li>
          </ol>
        </nav>
      </div>
    </div>
    <!-- End Page Title -->  
    
	<section id="comment-form" class="comment-form section">
		<div class="container">
			<div class="row g-2 align-items-end mb-3">
				
			</div>  
	    	
	    	<div>
	    		<div class="left">
	    			<div class="d-flex justify-content-end align-items-center gap-2">
				    <label for="categoryNum" class="form-label mb-0">품목명</label>
				    <select id="categoryNum" name="categoryNum" class="form-select" style="max-width: 220px;">
						<c:forEach var="v" items="${varietyList}">
							<option value="${v.varietyNum}" ${v.varietyNum == varietyNum ? 'selected' : ''}>
								${v.varietyName}
							</option>
						</c:forEach>
				    </select>
					</div>
	    		</div>
	    		<div>
	    			
	    		</div>
	    	</div>
	    	
		</div>
	</section><!-- /Comment Form Section -->
    
</main>

<footer>
	<jsp:include page="/WEB-INF/views/farm/layout/farmFooter.jsp"/>
</footer>

<jsp:include page="/WEB-INF/views/farm/layout/farmFooterResources.jsp"/>

<script src="https://fastly.jsdelivr.net/npm/echarts@5/dist/echarts.min.js"></script>
<script type="text/javascript">

</script>

</body>
</html>