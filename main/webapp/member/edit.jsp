<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/menu.jsp" />

<html>
<head>
  <title>회원정보 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container py-4">
  <h2 class="mb-4">회원정보 수정</h2>

  <form method="post" action="${pageContext.request.contextPath}/user.do">
    <input type="hidden" name="action" value="update" />

    <!-- 아이디 -->
    <div class="col-sm-3">
      <label class="form-label">아이디</label>
      <input type="text" class="form-control" name="userId" value="${user.userId}" readonly />
    </div>

    <!-- 이름 -->
    <div class="col-sm-3">
      <label class="form-label">이름</label>
      <input type="text" class="form-control" name="name" value="${user.userName}" readonly />
    </div>

    <!-- 비밀번호 -->
    <div class="col-sm-3">
      <label class="form-label">비밀번호</label>
      <input type="password" name="userPw" class="form-control" value="${user.userPw}" />
    </div>

    <!-- 이메일 -->
    <div class="col-sm-3">
      <label class="form-label">이메일</label>
      <div class="input-group">
        <input type="text" name="mail1" class="form-control" value="${fn:split(user.userEmail, '@')[0]}" />
        <span class="input-group-text">@</span>
        <input type="text" name="mail2" class="form-control" value="${fn:split(user.userEmail, '@')[1]}" />
      </div>
    </div>

    <!-- 전화번호 -->
    <div class="col-sm-3">
      <label class="form-label">전화번호</label>
      <input type="text" name="phone" class="form-control" value="${user.userPhone}" />
    </div>

    <!-- 주소 -->
    <div class="col-sm-3">
      <label class="form-label">주소</label>
      <input type="text" name="address" class="form-control" value="${user.userAddress}" />
    </div>

    <button type="submit" class="btn btn-primary">회원정보 수정</button>
    <a href="${pageContext.request.contextPath}/user.do?action=myInfo" class="btn btn-secondary">취소</a>
  </form>

  <jsp:include page="/footer.jsp" />
</body>
</html>
