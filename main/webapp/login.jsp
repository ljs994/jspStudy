<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<title>Login</title>
</head>
<body>
	<div class="container py-4">
		<%@ include file="menu.jsp"%>

		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold">로그인</h1>
				<p class="col-md-8 fs-4">Login</p>
			</div>
		</div>

		<div class="row justify-content-center text-center">
			<div class="col-md-6 p-5">
				<h3>로그인</h3>
				<c:if test="${param.error == '1'}">
					<div class="alert alert-danger">아이디와 비밀번호를 확인해 주세요</div>
				</c:if>

				<!-- ★ 컨트롤러 로그인 분기로 변경 ★ -->
				<form class="form-signin"
					action="${pageContext.request.contextPath}/user.do" method="post">
					<!-- UserController#doPost 의 login 분기 -->
					<input type="hidden" name="action" value="login" />

					<div class="form-floating mb-3">
						<input type="text" class="form-control" id="floatingUserId"
							name="userId" placeholder="ID" required autofocus> <label
							for="floatingUserId">아이디</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control" id="floatingPassword"
							name="userPw" placeholder="Password" required> <label
							for="floatingPassword">비밀번호</label>
					</div>
					<button class="btn btn-lg btn-success w-100" type="submit">로그인</button>
				</form>
			</div>
		</div>

		<%@ include file="footer.jsp"%>
	</div>
</body>
</html>
