<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
  /* 토글 시 사이드바 너비 변경 */
  #leftSidebar.collapsed { width: 0 !important; overflow: hidden; }

  #sidebar {
    position: fixed; top: 0; left: 0; width: 240px; height: 100vh;
    background-color: #343a40; transition: transform 0.3s ease-in-out; z-index: 1030;
  }
  /* 숨겨졌을 때 */
  .sidebar-collapsed #sidebar { transform: translateX(-100%); }

  #leftSidebar { width: 250px; transition: width 0.3s ease; }
  #leftSidebar.collapsed { width: 0 !important; overflow: hidden; }
</style>

<title>세이브팜</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
</head>
<body class="vertical light">
<div class="wrapper">
  <header>
    <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
  </header>

  <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

  <main role="main" class="main-content">
    <div class="container-fluid">
      <div class="row justify-content-center">
        <div class="col-12">
          <h2 class="mb-2 page-title">구독패키지목록</h2>

          <div class="row my-4">
            <!-- Small table -->
            <div class="col-md-9">
              <div class="card shadow">
                <div class="card-body">
                  <!-- table -->
                  <table class="table datatables" id="dataTable-1">
                    <thead>
                      <tr>
                        <th style="width: 100px;">번호</th>
                        <th style="width: 200px;">패키지명</th>
                        <th style="width: 200px;">가격</th>
                        <th style="width: 500px;">설명</th>
                        <th style="width: 100px;">선택</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="dto" items="${list}" varStatus="status">
                        <tr>
                          <td>${dataCount - status.index}</td>
                          <td>
                            <a href="#collapse${status.index}" data-toggle="collapse" data-target="#collapse${status.index}" aria-expanded="false" aria-controls="collapse${status.index}">
                              ${dto.packageName}
                            </a>
                          </td>
                          <td><fmt:formatNumber value="${dto.price}" pattern="#,###"/>원</td>
                          <td>${dto.content}</td>
                          <td>
                            <button class="btn btn-sm dropdown-toggle more-horizontal" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                              <span class="text-muted sr-only">선택</span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right">
                              <!-- a 태그 대신 button으로, 기본 이동 제거 -->
                              <button type="button" class="dropdown-item js-open-package-details" data-package-num="${dto.packageNum}">
                                품목/추가
                              </button>
                              <button type="button" class="dropdown-item js-open-product-picker" data-package-num="${dto.packageNum}">
                               	상세정보
                              </button>
                            </div>
                          </td>
                        </tr>

                        <!-- 열/닫을 때 보이는 구성품 요약 -->
                        <tr id="collapse${status.index}" class="collapse">
                          <td></td>
                          <td colspan="3">
                            <strong>구성품:</strong>
                            <c:choose>
                              <c:when test="${not empty dto.productList}">
                                <c:forEach var="product" items="${dto.productList}" varStatus="productStatus">
                                  <a>${product.productName}</a>
                                  <c:if test="${!productStatus.last}">, </c:if>
                                </c:forEach>
                              </c:when>
                              <c:otherwise>
                                구성품 없음
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td></td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>

                  <!-- 페이지네이션 자리 -->
                  <div class="row">
                    <div class="col-sm-12 col-md-3"></div>
                    <div class="col-sm-12 col-md-6">
                      <div class="row justify-content-center">
                        <div class="dataTables_paginate paging_simple_numbers" id="dataTable-1_paginate"></div>
                      </div>
                    </div>
                  </div>

                  <!-- 검색 폼 (기존 유지) -->
                  <div class="row">
                    <div class="col-sm-12 col-md-3 d-flex align-items-start"></div>
                    <div class="col-sm-12 col-md-6 d-flex justify-content-center ">
                      <form name="searchForm" class="dataTables_paginate paging_simple_numbers" id="packageSearchForm">
                        <ul class="pagination">
                          <li class="paginate_button page-item mr-2">
                            <button type="button" class="fe fe-rotate-ccw btn mb-2 btn-outline-primary" onclick="resetList();"></button>
                          </li>
                          <li class="paginate_button page-item previous disabled">
                            <select name="schType" id="searchType" class="form-control">
                              <option value="packageName" ${schType=="packageName" ? "selected":""}>패키지명</option>
                              <option value="content" ${schType=="content" ? "selected":""}>설명</option>
                            </select>
                          </li>
                          <li class="paginate_button page-item active mr-2">
                            <input type="text" name="kwd" id="keyword" class="form-control" placeholder="Search" value="${fn:escapeXml(kwd)}">
                          </li>
                          <li class="paginate_button page-item ">
                            <button type="submit" class="btn mb-2 btn-outline-primary" onclick="searchList();">검색</button>
                          </li>
                        </ul>
                      </form>
                    </div>
                  </div>
                  <!-- // 검색 폼 -->
                </div>
              </div>
            </div> <!-- simple table -->
          </div> <!-- end section -->
        </div> <!-- .col-12 -->
      </div> <!-- .row -->
    </div> <!-- .container-fluid -->
  </main>

  <!-- 상세정보 모달 (현재 패키지 품목) -->
  <div class="modal fade" data-backdrop="static" id="UpdateDialogModal" tabindex="-1" aria-labelledby="UpdateDialogModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="UpdateDialogModalLabel">패키지품목 변경</h5>
          <button type="button" class="btn fe fe-x" data-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <!-- AJAX로 /admin/package/details fragment 주입 -->
          <div class="p-4 text-center text-muted">내용을 불러오는 중...</div>
        </div>
      </div>
    </div>
  </div>

  <!-- 품목 선택 모달 (후보 상품 리스트) -->
  <div class="modal fade" data-backdrop="static" id="UpdateDialogModalDetails" tabindex="-1" aria-labelledby="UpdateDialogModalLabelDetails" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="UpdateDialogModalLabelDetails">패키지 품목 선택</h5>
          <button type="button" class="btn fe fe-x" data-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <!-- AJAX로 /admin/package/packageProduct fragment 주입 -->
          <div class="p-4 text-center text-muted">내용을 불러오는 중...</div>
        </div>
      </div>
    </div>
  </div>

  <footer>
    <jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
  </footer>

  <jsp:include page="/WEB-INF/views/admin/layout/footerResources.jsp"/>
</div>

<script type="text/javascript">
(function(){
  const ctx = '${pageContext.request.contextPath}';

  // 검색 reset
  window.resetList = function() {
    const f = document.searchForm;
    f.schType.value = 'packageName';
    f.kwd.value = '';
    location.href = ctx + '/admin/package/list';
  };

  // 검색 submit
  window.searchList = function() {
    const f = document.searchForm;
    f.schType.value = $('#searchType').val();
    f.kwd.value = $('#keyword').val();
    const params = 'schType=' + encodeURIComponent(f.schType.value) + '&kwd=' + encodeURIComponent(f.kwd.value);
    location.href = ctx + '/admin/package/list?' + params;
  };

  // 상세정보 열기 (현재 packageItem 목록)
  $(document).on('click', '.js-open-package-details', function(e){
    e.preventDefault();
    const packageNum = $(this).data('package-num');
    if (!packageNum) return alert('패키지 번호가 없습니다.');

    const $m = $('#UpdateDialogModal');
    $m.find('.modal-body').html('<div class="p-4 text-center text-muted">로딩 중...</div>');
    $m.appendTo('body').modal('show');

    $.post(ctx + '/admin/package/details', { packageNum: packageNum }, function(html){
      $m.find('.modal-body').html(html);
    }).fail(function(xhr){
      $m.find('.modal-body').html('<div class="p-4 text-danger text-center">불러오기에 실패했습니다.</div>');
    });
  });

  // 품목 선택(후보) 모달 열기
  $(document).on('click', '.js-open-product-picker', function(e){
    e.preventDefault();
    const packageNum = $(this).data('package-num');
    if (!packageNum) return alert('패키지 번호가 없습니다.');

    const $m = $('#UpdateDialogModalDetails');
    $m.find('.modal-body').html('<div class="p-4 text-center text-muted">로딩 중...</div>');
    $m.appendTo('body').modal('show');

    $.post(ctx + '/admin/package/packageProduct', { packageNum: packageNum }, function(html){
      $m.find('.modal-body').html(html);
    }).fail(function(){
      $m.find('.modal-body').html('<div class="p-4 text-danger text-center">불러오기에 실패했습니다.</div>');
    });
  });

  // 후보에서 선택된 상품을 상세 모달 테이블에 추가
  window.addPickedProduct = function(productNum, productName, unit) {
    const $tbody = $('#UpdateDialogModal #uf_tbody');
    if (!$tbody.length) { alert('추가할 테이블이 없습니다.'); return; }

    // 중복 방지
    if ($tbody.find('tr[data-product-num="'+productNum+'"]').length) {
      alert('이미 추가된 품목입니다.');
      return;
    }
    const no = $tbody.children('tr').length + 1;
    const row = `
      <tr data-product-num="${productNum}">
        <td class="bg-light">${no}</td>
        <td>${productName}<input type="hidden" name="productNum[]" value="${productNum}"></td>
        <td>${unit}</td>
        <td><input type="number" name="qty[]" min="1" step="1" class="form-control form-control-sm" value="1" style="max-width:80px;"></td>
        <td><button type="button" class="btn btn-sm btn-outline-danger" onclick="$(this).closest('tr').remove();">삭제</button></td>
      </tr>`;
    $tbody.append(row);

    // 선택 모달은 닫아도 되고 유지해도 됨. 여기선 닫지 않음.
    // $('#UpdateDialogModalDetails').modal('hide');
  };

  // 상세 모달에서 저장 (controller에 /admin/package/updateItems 만들어 처리)
  window.submitPackageItems = function(packageNum) {
    const $tbody = $('#UpdateDialogModal #uf_tbody');
    if (!$tbody.length) { alert('저장할 품목이 없습니다.'); return; }
    const rows = $tbody.find('tr');
    if (!rows.length) { alert('저장할 품목이 없습니다.'); return; }

    const form = new FormData();
    form.append('packageNum', packageNum);

    rows.each(function(){
      const productNum = $(this).data('product-num');
      const qty = $(this).find('input[name="qty[]"]').val();
      form.append('productNum[]', productNum);
      form.append('qty[]', qty);
    });

    fetch(ctx + '/admin/package/updateItems', { method: 'POST', body: form })
      .then(function(res){ if (!res.ok) throw new Error(); return res.text(); })
      .then(function(){
        alert('저장 완료');
        $('#UpdateDialogModal').modal('hide');
      })
      .catch(function(){ alert('저장 실패'); });
  };

})();
</script>
</body>
</html>
