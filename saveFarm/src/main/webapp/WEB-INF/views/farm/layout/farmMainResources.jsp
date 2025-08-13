<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!-- ======= Google Font =======-->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&amp;display=swap" rel="stylesheet">
<!-- End Google Font-->

<!-- ======= Styles =======-->
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/glightbox/glightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/swiper/swiper-bundle.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/aos/aos.css" rel="stylesheet">
<!-- End Styles-->

<!-- ======= Theme Style =======-->
<link href="${pageContext.request.contextPath}/dist/farm/farmMain/css/style.css" rel="stylesheet">
<!-- End Theme Style-->

<!-- ======= Apply theme =======-->
<script>
  // Apply the theme as early as possible to avoid flicker
  (function() {
  const storedTheme = localStorage.getItem('theme') || 'light';
  document.documentElement.setAttribute('data-bs-theme', storedTheme);
  })();
</script>

<!-- ======= Javascripts =======-->
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/gsap/gsap.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/isotope/isotope.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/glightbox/glightbox.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/swiper/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/aos/aos.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/vendors/purecounter/purecounter.js"></script>
<script src="${pageContext.request.contextPath}/dist/farm/farmMain/js/custom.js"></script>
<!-- End JavaScripts-->

