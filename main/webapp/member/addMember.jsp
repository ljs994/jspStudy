<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css" />
  <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
  <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  <title>회원 가입</title>
  
  <script type="text/javascript">
    $(function(){
      // 숫자만 입력
      $('#phone1, #phone2, #phone3').on('input', function(){
        this.value = this.value.replace(/\D/g, '');
      });
      // 자동 포커스 이동
      $('#phone1').on('input', function(){ 
        if (this.value.length >= this.maxLength) $('#phone2').focus(); 
      });
      $('#phone2').on('input', function(){ 
        if (this.value.length >= this.maxLength) $('#phone3').focus(); 
      });
      // 폼 제출 시 합쳐서 hidden phone 으로 추가
      $('form[name="newMember"]').on('submit', function(){
        var p1 = $('#phone1').val(),
            p2 = $('#phone2').val(),
            p3 = $('#phone3').val();
        if (!p1 || !p2 || !p3) {
          alert('전화번호를 모두 입력하세요.');
          return false;
        }
        var full = p1 + '-' + p2 + '-' + p3;
        // 기존 hidden phone 제거 후 새로 생성
        $(this).find('input[name="phone"]').remove();
        $('<input>').attr({
          type: 'hidden',
          name: 'phone',
          value: full
        }).appendTo(this);
        return true;
      });
    });
  </script>
  
  <script type="text/javascript">
    $(document).ready(function() {
      flatpickr("#birth", {
        locale: "ko",
        dateFormat: "Y-m-d",
        altInput: true,
        altFormat: "Y년 m월 d일",
        allowInput: false
      });

      // 아이디 중복 확인
      $("#checkIdBtn").click(function(e) {
        e.preventDefault();
        var userId = $("#userId").val().trim();
        if (!userId) { alert("아이디를 입력하세요."); return; }
        // UserController에서 checkId 액션으로 처리
        $.get("${pageContext.request.contextPath}/user.do", { action: "checkId", userId: userId }, function(res) {
          if (res === "true") {
            $("#idCheckMsg").text("사용 가능한 아이디입니다.").css("color","green");
          } else {
            $("#idCheckMsg").text("이미 사용 중인 아이디입니다.").css("color","red");
          }
        }, "text");
      });

      // 비밀번호 정책 실시간 확인
      $("#userPw, #userPwConfirm").on("input", function() {
    	    var pw      = $("#userPw").val();
    	    var confirm = $("#userPwConfirm").val();

    	    // 정책 체크
    	    var hasUpper   = /[A-Z]/.test(pw);
    	    var hasSpecial = /[!@#$%^&*(),.?\":{}|<>]/.test(pw);
    	   
    	    // 길이 체크 추가
    	    var lengthOK   = pw.length >= 8;

    	    // 점수 계산 (0~3)
    	    var score = [hasUpper, hasSpecial, lengthOK].filter(Boolean).length;

    	    $("#pwStrength").val(score);
    	    var texts = ["약함","보통","강함","매우 강함"];
    	    $("#pwStrengthText").text(texts[score] || "");

    	    // 기존 정책 메시지
    	    if (hasUpper && hasSpecial) {
    	      $("#pwPolicyMsg").text("사용 가능합니다.").css("color","green");
    	    } else {
    	      $("#pwPolicyMsg").text("대문자 1개, 특수문자 1개 이상 포함해야 합니다").css("color","red");
    	    }

    	    // 기존 확인 메시지
    	    if (confirm) {
    	      if (pw === confirm) {
    	        $("#idCheckMsg_pw").text("비밀번호가 일치합니다.").css("color","green");
    	      } else {
    	        $("#idCheckMsg_pw").text("비밀번호가 다릅니다.").css("color","red");
    	      }
    	    }
    	  });
    });

    function checkForm() {
      var pw = $("#userPw").val();
      var confirm = $("#userPwConfirm").val();
      if (!$("#userId").val()) { alert("아이디를 입력하세요."); return false; }
      if ($("#idCheckMsg").text() !== "사용 가능한 아이디입니다.") { alert("아이디 중복검사를 해주세요."); return false; }

      if (!pw) { alert("비밀번호를 입력하세요."); return false; }
      if (!/[A-Z]/.test(pw) || !/[!@#$%^&*(),.?\":{}|<>]/.test(pw)) {
        alert("비밀번호에 대문자 1개 및 특수문자 1개 이상 포함해야 합니다.");
        return false;
      }
      if (pw !== confirm) { alert("비밀번호 확인이 일치하지 않습니다."); return false; }

      if (!$("#name").val()) { alert("이름을 입력하세요."); return false; }
      if (!$("#birth").val()) { alert("생일을 선택하세요."); return false; }
      return true;
    }
  </script>
</head>
<body>
  <div class="container py-4">
    <jsp:include page="/menu.jsp" />
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">회원 가입</h1>
        <p class="col-md-8 fs-4">Membership Joining</p>
      </div>
    </div>
    <div class="row align-items-md-stretch text-center">
      <form name="newMember" action="${pageContext.request.contextPath}/user.do" method="post" onsubmit="return checkForm()">
        <input type="hidden" name="action" value="register" />
        
        <!-- 아이디 -->
        <div class="mb-3 row">
          <label class="col-sm-2" for="userId">아이디</label>
          <div class="col-sm-3">
            <div class="input-group">
              <input id="userId" name="userId" type="text" class="form-control" placeholder="아이디" />
              <button type="button" id="checkIdBtn" class="btn btn-outline-secondary">중복확인</button>
            </div>
            <small id="idCheckMsg" class="form-text"></small>
          </div>
        </div>
        
        <!-- 비밀번호 -->
        <div class="mb-3 row">
          <label class="col-sm-2" for="userPw">비밀번호</label>
          <div class="col-sm-3">
            <input id="userPw" name="userPw" type="password" class="form-control" placeholder="비밀번호" />
            <small id="pwPolicyMsg" class="form-text"></small>
          </div>
        </div>
        <!-- 비밀번호 확인 -->
        <div class="mb-3 row">
          <label class="col-sm-2" for="userPwConfirm">비밀번호 확인</label>
          <div class="col-sm-3">
            <input id="userPwConfirm" name="userPwConfirm" type="password" class="form-control" placeholder="비밀번호 확인" />
            <small id="idCheckMsg_pw" class="form-text"></small>
          </div>
        </div>
        
        <!-- 비밀번호 강도 -->
        <div class="mb-3 row">
          <label class="col-sm-2">비밀번호 강도</label>
          <div class="col-sm-3">
            <progress id="pwStrength" max="3" value="0" style="width:100%"></progress>
            <small id="pwStrengthText" class="form-text"></small>
          </div>
        </div>

        <!-- 이름 -->
        <div class="mb-3 row">
          <label class="col-sm-2">성명</label>
          <div class="col-sm-3">
            <input id="name" name="name" type="text" class="form-control" placeholder="이름" />
          </div>
        </div>
        <!-- 성별 -->
        <div class="mb-3 row">
          <label class="col-sm-2">성별</label>
          <div class="col-sm-2">
            <input name="gender" type="radio" value="남자" /> 남자
            <input name="gender" type="radio" value="여자" /> 여자
          </div>
        </div>
        
        <!-- 생일 -->
        <div class="mb-3 row">
          <label class="col-sm-2">생일</label>
          <div class="col-sm-3">
            <input id="birth" name="birth" type="text" class="form-control" placeholder="YYYY-MM-DD" readonly />
          </div>
        </div>

		<!-- 이메일 -->
		<div class="mb-3 row">
		<label class="col-sm-2" for="email1">이메일</label>
		<div class="col-sm-6">
			<div class="input-group">
			<input id="email1" name="mail1" type="text" class="form-control" placeholder="이메일 입력" />
			<span class="input-group-text">@</span>
			<input id="emailDomainInput" type="text" class="form-control d-none" placeholder="입력하세요" />
			<select id="emailDomainSelect" class="form-select" name="mail2">
				<option value="custom">직접 입력</option>
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
				<option value="gmail.com">gmail.com</option>
				<option value="nate.com">nate.com</option>
			</select>
			</div>
		</div>
		</div>

		<script>
		$(function(){
			$('#emailDomainSelect').on('change', function(){
				if (this.value === 'custom') {
				// 직접 입력 선택 → input 보이고 select name 제거
					$('#emailDomainInput').removeClass('d-none').attr('name','mail2').focus();
					$(this).prop('name','');
					} else {
						// 도메인 선택 → input 숨기고 select name 복원
						$('#emailDomainInput').addClass('d-none').removeAttr('name');
						$(this).attr('name','mail2');
					}
				});
			});
		</script>

		<!-- 전화번호 -->
		<div class="mb-3 row">
		<label class="col-sm-2" for="phone1">전화번호</label>
		<div class="col-sm-3">
			<div class="input-group">
				<input id="phone1" type="text" class="form-control" maxlength="3" placeholder="010" />
				<span class="input-group-text">-</span>
				<input id="phone2" type="text" class="form-control" maxlength="4" placeholder="1234" />
				<span class="input-group-text">-</span>
				<input id="phone3" type="text" class="form-control" maxlength="4" placeholder="5678" />
			</div>
			<small class="form-text text-muted">예: 010‐1234‐5678</small>
		</div>
		</div>
		
		<div class="mb-3 row">
		<label class="col-sm-2" for="address">주소</label>
			<div class="col-sm-5">
				<input id="address" name="address" type="text" class="form-control" placeholder="주소를 입력하세요" />
			</div>
		</div>

        <!-- 등록 버튼 -->
        <div class="mb-3 row">
          <div class="offset-sm-2 col-sm-10">
            <input type="submit" class="btn btn-primary" value="가입" />
            <input type="reset" class="btn btn-secondary" value="취소" />
          </div>
        </div>
      </form>
    </div>

    <jsp:include page="/footer.jsp" />
  </div>
</body>
</html>
