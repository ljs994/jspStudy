<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>회원가입 완료</title>
  <!-- 3초 뒤 로그인 폼으로 자동 이동 -->
  <meta http-equiv="refresh"
        content="3;url=${pageContext.request.contextPath}/user.do?action=loginForm" />
  <link rel="stylesheet" 
        href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <style>
    body { background-color: #f8f9fa; }
    .center-box {
      max-width: 500px;
      margin: 100px auto;
      padding: 30px;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
  <div class="center-box text-center">
    <h1 class="mb-4">회원가입이 완료되었습니다!</h1>
    <p class="lead">
      아이디 <strong><c:out value="${newUserId}"/></strong> 로 가입되었어요.
    </p>
    <p class="mb-4 text-secondary">
      3초 후에 로그인 페이지로 이동합니다.
    </p>
    <a href="${pageContext.request.contextPath}/user.do?action=loginForm"
       class="btn btn-primary">지금 로그인하기</a>
  </div>
</body>
</html>