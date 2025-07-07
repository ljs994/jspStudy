<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>내 정보</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
</head>
<body>
	<%@ include file="/menu.jsp"%>

	<c:if test="${param.updated eq 'true'}">
		<script>
			alert("회원정보가 성공적으로 수정되었습니다.");
		</script>
	</c:if>

	<div class="container py-4">
		<h2>회원 정보</h2>
		<table class="table table-bordered">
			<tr>
				<th>아이디</th>
				<td>${user.userId}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${user.userName}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${user.userGender}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${user.userBirth}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${user.userEmail}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${user.userPhone}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${user.userAddress}</td>
			</tr>
			<tr>
				<th>계정 생성일</th>
				<td>${formattedDate}</td>
			</tr>
			<tr>
				<th>회원 권한</th>
				<td><c:choose>
						<c:when test="${user.isAdmin == 1}">관리자</c:when>
						<c:otherwise>일반 회원</c:otherwise>
					</c:choose></td>
			</tr>
		</table>
		<div class="d-flex justify-content-between mt-3">
			<div>
				<a href="${pageContext.request.contextPath}/user.do?action=updateForm" class="btn btn-primary">회원정보 수정</a>
  			</div>
  			<div>
				<form method="post" action="${pageContext.request.contextPath}/user.do" onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
				<input type="hidden" name="action" value="delete" />
				<button type="submit" class="btn btn-danger">회원 탈퇴</button>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="/footer.jsp"%>
</body>
</html>
