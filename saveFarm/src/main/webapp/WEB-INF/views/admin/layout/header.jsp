<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<div>
<nav class="topnav navbar navbar-light">
<button type="button" class="navbar-toggler text-muted mt-2 p-0 me-3 collapseSidebar">
  <i class="fe fe-menu navbar-toggler-icon white"></i>
</button>
  <form class="form-inline me-auto text-muted">
  </form>
  <ul class="nav">
    
    <li class="nav-item">
      <a class="nav-link text-muted my-2" href="#" data-toggle="modal" data-bs-target=".modal-shortcut">
        <span class="fe fe-grid fe-16 white"></span>
      </a>
    </li>
    <li class="nav-item nav-notif">
      <a class="nav-link text-muted my-2" href="#" data-toggle="modal" data-bs-target=".modal-notif">
        <span class="fe fe-bell fe-16 white"></span>
        <span class="dot dot-md bg-success"></span>
      </a>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle text-muted pe-0" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        <span class="avatar avatar-sm mt-2 white">
          <img src="${pageContext.request.contextPath}/dist/images/avatar.png" alt="..." class="avatar-img rounded-circle" />
        </span>
      </a>
      <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
        <li><a class="dropdown-item" href="#">Profile</a></li>
        <li><a class="dropdown-item" href="#">Settings</a></li>
        <li><a class="dropdown-item" href="#">Activities</a></li>
      </ul>
    </li>
  </ul>
</nav>
</div>