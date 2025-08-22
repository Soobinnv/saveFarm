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
</head>
<body class="index-page">

<header>
	<jsp:include page="/WEB-INF/views/farm/layout/farmHeader.jsp"/>
</header>

<main class="main register-actions">
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
		    <form id="registerForm" name="registerForm" method="post" action="${pageContext.request.contextPath}/farm/register/${mode}" enctype="application/x-www-form-urlencoded">
		      <h4>${mode=='update'?'신청서 수정':'신청서 작성'}</h4>
		      <p>작성하신 신청서의 정보를 기준으로 납품 승인여부가 결정됩니다.* </p>
		      <table class="table write-form">
					<tr>
						<td class="col-md-2 bg-light center align-middle">농산물 종류</td>
						<td colspan="2">
					    	<div class="row g-2">
						        <div class="col-md-4">
						          	<select id="supplySelect" name="varietyNum" class="form-select" onchange="toggleComent(this)">
										<c:if test="${mode=='write'}">
											<option value="">-- 선택하세요 --</option>
										</c:if>
										<option value="0" <c:if test="${mode=='update' && dto.varietyNum == 0}">selected</c:if>>기타</option>
										<c:forEach var="v" items="${varieties}">
											<option value="${v.varietyNum}" <c:if test="${mode=='update' && dto.varietyNum == v.varietyNum}">selected</c:if>>
												${v.varietyName}
											</option>
										</c:forEach>
									</select>
						        </div>
						        <div class="col-md-8">
						          <!-- collapse 적용: 기타일 때만 show -->
						          <div id="otherBox" class="collapse <c:if test='${mode=="update" && dto.varietyNum == 0}'>show</c:if>">
							          <input type="text" id="supplyOther" name="coment" class="form-control"
											maxlength="100" placeholder="종류에 없으면 ‘기타’ 선택 후 입력"
											value="<c:if test='${mode=="update"}'>${dto.coment}</c:if>"
											<c:if test='${mode=="write"}'>disabled</c:if>
											<c:if test='${mode=="update" && dto.varietyNum != 0}'>disabled</c:if> />
						          </div>
						      	</div>
					    	</div>
					    </td>
					</tr>

					<tr>
						<td class="col-md-2 bg-light align-middle">총 납품량</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					          <input type="text" name="supplyQuantity" class="form-control" maxlength="100" placeholder="총 납품할 농산물의 양을 적어주세요." value="${dto.supplyQuantity}">
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
					          <input type="text" name="unitQuantity" class="form-control" maxlength="100" placeholder="납품단위별 양을 입력해주세요." value="${dto.unitQuantity}">
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
					        	<input type="date" name="harvestDate" class="form-control" value="${not empty dto.harvestDate ? fn:substring(dto.harvestDate, 0, 10) : ''}">
					        </div>
					      </div>
					    </td>
					</tr>
					
					<tr>
						<td class="col-md-2 bg-light align-middle">긴급구출상품신청</td>
						<td colspan="2">
					      <div class="row g-2 align-items-center">
					        <div class="col-md-7">
					          	<input type="checkbox" name="rescuedApply" value="1" <c:if test="${mode=='update' && dto.rescuedApply == 1}">checked</c:if> />
								<input type="hidden" name="rescuedApply" value="0" />
					        </div>
					      </div>
					    </td>
					</tr>
				</table>
		
				
				<div class="sf-actions">
					<c:if test="${mode=='update' && dto.state == 1}">
						<button type="button" class="sf-btn sf-btn-danger" onclick="deleteOk();">삭제하기</button>
					</c:if>
					
					<button type="button" class="sf-btn btn-primary" onclick="sendOk();">
						${mode=='update'?'수정완료':'신청완료'}
					</button>
					
					<c:if test="${mode=='write'}">
						<button type="button" class="sf-btn sf-btn-outline" onclick="location.href='${pageContext.request.contextPath}/farm/register/main'">
					  		신청취소
						</button>
					</c:if>
					
					<c:if test="${mode=='update'}">
				       	<button type="button" class="btn btn-primary" style="background-color: white; color: black; border: 1px solid #116530;"
        					onclick="location.href='${pageContext.request.contextPath}/farm/register/detail?supplyNum=${dto.supplyNum}&back=${back}'">
  							수정취소</button>
						<input type="hidden" name="supplyNum" value="${dto.supplyNum}">
						<input type="hidden" name="farmNum" value="${dto.farmNum}">
						<input type="hidden" name="productNum" value="${dto.productNum}">
						<input type="hidden" name="state" value="${dto.state}">
						<input type="hidden" name="page" value="${page}">
						<input type="hidden" name="page"    value="${empty page ? 1 : page}">
						<input type="hidden" name="schType" value="${empty schType ? 'all' : schType}">
						<input type="hidden" name="kwd"     value="${empty kwd ? '' : kwd}">
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

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
  const sel = document.getElementById('supplySelect');
  if (sel) toggleComent(sel); // 초기 상태 맞추기

  const d = document.querySelector('input[name="harvestDate"]');
  if (d) {
    const t = new Date();
    const todayStr =
      t.getFullYear() + '-' +
      String(t.getMonth() + 1).padStart(2, '0') + '-' +
      String(t.getDate()).padStart(2, '0');
    d.setAttribute('max', todayStr); // 미래 선택 차단
  }
});

function toggleComent(select) {
  const box   = document.getElementById('otherBox');   // collapse 래퍼
  const input = document.getElementById('supplyOther');

  if (select.value === '0') {         // '기타'
    box.classList.add('show');        // 슬라이드 다운
    input.disabled = false;
    input.required = true;
    setTimeout(() => input.focus({ preventScroll: true }), 150);
  } else {                            // 다른 품종
    box.classList.remove('show');     // 슬라이드 업
    input.required = false;
    input.disabled = true;
    input.value = '';                 // 남은 값 지우기
  }
}

function sendOk() {
    const f = document.registerForm;
    let p, str;

    if (!f.varietyNum.value) {
      alert('농산물 종류를 선택하세요.');
      f.varietyNum.focus();
      return false;
    }

    if (f.varietyNum.value === '0') {
      const c = (f.coment.value || '').trim();
      if (!c) {
        alert('기타를 선택하셨습니다. 내용을 입력하세요.');
        f.coment.focus();
        return false;
      }
    }

    const labels = {
		supplyQuantity: "총 납품량",
		unitQuantity: "판매단위",
		unitPrice: "단위당 금액"
	};
    const n = ['supplyQuantity', 'unitQuantity', 'unitPrice'];
	p = /^[0-9]+(\.[0-9]+)?$/;

    for (const field of n) {
        str = f[field].value.trim();
        if (!str) {
            alert(labels[field] +'를 입력해주세요');
            f[field].focus();
            return false;
        }
        if (!p.test(str)) {
            alert(labels[field] +'는 숫자만 입력 가능합니다');
            f[field].focus();
            return false;
        }
    }

    str  = (f.harvestDate.value || '').trim();
	const t = new Date();
	const todayStr = t.getFullYear() + '-' + String(t.getMonth()+1).padStart(2,'0') + '-' + String(t.getDate()).padStart(2,'0');
	
	if (!str) { 
		alert('수확일을 입력하세요.'); 
		f.harvestDate.focus(); 
		return false; 
	}
	if (str > todayStr) { 
		alert('미래 날짜는 입력할 수 없습니다.'); 
		f.harvestDate.focus(); 
		return false; 
	}

    f.submit();
}

function deleteOk() {
	  if (!confirm('정말 삭제하시겠습니까? 삭제 후에는 복구할 수 없습니다.')) return;

	  const f = document.getElementById('registerForm'); // 이제 존재함
	  if (!f) { alert('삭제 폼을 찾을 수 없습니다.'); return; }

	  // update 화면에서만 버튼이 노출되므로 supplyNum hidden 이미 있음.
	  // 혹시 몰라 값 체크
	  const sn = f.querySelector('input[name="supplyNum"]');
	  if (!sn || !sn.value) {
	    alert('삭제할 항목 번호(supplyNum)를 찾을 수 없습니다.');
	    return;
	  }

	  // 삭제 엔드포인트로 action 변경 후 제출
	  f.action = '${pageContext.request.contextPath}/farm/register/delete';
	  f.method = 'post';
	  f.submit();
	}
</script>
</body>
</html>
