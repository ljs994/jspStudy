<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<header class="pb-3 mb-4 border-bottom">
  <div class="container">
    <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">

      <!-- Home 로고 및 링크 -->
      <a href="${ctx}/welcome.jsp"
         class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
          <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 
                   0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 
                   0 .708-.708L13 5.793V2.5a.5.5 0 0 
                   0-.5-.5h-1a.5.5 0 0 
                   0-.5.5v1.293L8.707 1.5Z"/>
          <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 
                   1-1.5 1.5h-9A1.5 1.5 0 0 
                   1 2 13.5V9.293l6-6Z"/>
        </svg>
        <span class="fs-4">Home</span>
      </a>

      <ul class="nav nav-pills">
        <!-- 로그인 전/후 분기 -->
        <c:choose>
          <c:when test="${empty sessionScope.loginUser}">
            <li class="nav-item">
              <a class="nav-link" href="${ctx}/user.do?action=loginForm">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${ctx}/user.do?action=registerForm">회원가입</a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item">
              <span class="nav-link disabled">[${sessionScope.loginUser.userName}님]</span>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${ctx}/user.do?action=myInfo">내 정보</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="${ctx}/user.do?action=logout">로그아웃</a>
            </li>
          </c:otherwise>
        </c:choose>

        <!-- 모든 사용자 공통 메뉴 -->
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/books.jsp">DVD 목록</a>
        </li>

        <!-- 관리자 전용 메뉴 -->
        <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.isAdmin == 1}">
          <li class="nav-item">
            <a class="nav-link" href="${ctx}/addBook.jsp">DVD 등록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${ctx}/editBook.jsp?edit=update">DVD 수정</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${ctx}/editBook.jsp?edit=delete">DVD 삭제</a>
          </li>
        </c:if>

        <!-- 기타 공통 메뉴 -->
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/cart.jsp">장바구니</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${ctx}/BoardListAction.do?pageNum=1">게시판</a>
        </li>
      </ul>
    </div>
  </div>
</header>
