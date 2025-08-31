<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<table class="table table-bordered">
  <thead>
    <tr>
      <th width="80">번호</th>
      <th width="200">제품명</th>
      <th width="100">단위(g)</th>
      <th width="100">가격</th>
      <th width="100">수량</th>
    </tr>
  </thead>
  <tbody>
    <c:choose>
      <c:when test="${not empty list}">
        <c:forEach var="p" items="${list}" varStatus="st">
          <tr>
            <td>${st.index + 1}</td>
            <td>${p.productName}</td>
            <td>${p.unit}</td>
            <td><fmt:formatNumber value="${p.unitPrice}" pattern="#,###"/>원</td>
            <td>
              <input type="number" name="qty[]" value="${p.qty}" min="1" class="form-control form-control-sm" style="max-width:80px;">
              <input type="hidden" name="productNum[]" value="${p.productNum}">
            </td>
          </tr>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <tr><td colspan="5" class="text-center text-muted">구성품 없음</td></tr>
      </c:otherwise>
    </c:choose>
  </tbody>
</table>
