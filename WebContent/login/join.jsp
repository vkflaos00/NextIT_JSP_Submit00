<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function() {
		$("#memId").click(function() {
			$(this).next().removeClass("warning");
		});
		$("#memPass").click(function() {
			$(this).next().removeClass("warning");
		});
		$("#memPassCheck").click(function() {
			$(this).next().removeClass("warning");
		});
		$("#memName").click(function() {
			$(this).next().removeClass("warning");
		});
		$("#loveName").click(function() {
			$(this).next().removeClass("warning");
		});
	});
	
	$(document).ready(function() {
		  $('button[name="btn_join"]').click(function() {
		    let selectedValue = $('select[name="cigarettesPerDay"]').val();
		    if (selectedValue === '') {
		      alert('평소 흡연량을 선택해라.');
		      return;
		    }
		  });
		});

	function join() {
		/* alert("가입"); */
		console.log("가입버튼눌러버림");

		let memId = $("#memId");
		let memPass = $("#memPass");
		let memPassCheck = $("#memPassCheck");
		let memName = $("#memName");
		let loveName = $("#loveName");

		if (memId.val() == "") {
			alert("아이디를 입력해라.");
			memId.next("label").addClass("warning");
			return;
		} else if (memPass.val() == "") {
			alert("비번을 입력해라.");
			memPass.next("label").addClass("warning");
			return;
		} else if (memPassCheck.val() == "") {
			alert("비번을 다시 입력해라.");
			memPassCheck.next("label").addClass("warning");
			return;
		} else if (memName.val() == "") {
			alert("닉네임을 입력해라.");
			memName.next("label").addClass("warning");
			return;
		} else if (loveName.val() == "") {
			alert("사랑하는 사람의 이름을 입력해라.");
			loveName.next("label").addClass("warning");
			return;
		}

		
		let checkWord = /^[a-zA-Z]{1,10}$/;
		console.log("checkWord: ", checkWord.test(memId.val()));
		
		if(! checkWord.test(memId.val())){
			alert("아이디 영문 1~10글자로 넣어라.");
			memId.val("");
			memId.next("label").addClass("warning");
			return;
		} else if (! checkWord.test(memPass.val())) {
			alert("비번 영문 1~10글자로 넣어라.");
			memPass.val("");
			memPassCheck.val("");
			memPass.next("label").addClass("warning");
			return;
		}
		
		let checkWord2 = /^[가-힣a-zA-Z]{1,10}$/;
		console.log("checkWord2: ", checkWord2.test(memName.val()));
		
		if (! checkWord2.test(memName.val())) {
			alert("1~10글자로 제대로 넣어라.");
			memName.val("");
			memName.next("label").addClass("warning");
			return;
		}  else if (! checkWord2.test(loveName.val())) {
			alert("1~10글자로 제대로 넣어라.");
			loveName.val("");
			loveName.next("label").addClass("warning");
			return;
		}
			

		let checkBlank = /\s/;
		console.log("checkBlank: ", checkBlank.test(memId.val()));

		if (checkBlank.test(memId.val())) {
			alert("아이디 띄어쓰기 안 됨. 붙여써라.");
			memId.val("");
			memId.next("label").addClass("warning");
			return;
		}  else if (checkBlank.test(memPass.val())) {
			alert("비번 띄어쓰기 안 됨. 붙여써라.");
			memPass.val("");
			memPassCheck.val("");
			memPass.next("label").addClass("warning");
			return;
		} else if (checkBlank.test(memName.val())) {
			alert("닉네임 띄어쓰기 안 됨. 붙여써라.");
			memName.val("");
			memName.next("label").addClass("warning");
			return;
		} else if (checkBlank.test(loveName.val())) {
			alert("띄어쓰기 안 됨. 붙여써라.");
			loveName.val("");
			loveName.next("label").addClass("warning");
			return;
		}
		
		if(memPass.val() != memPassCheck.val()){
			alert("비번 두 개 다르게 적음. 다시 적어라.");
			memPass.val("");
			memPassCheck.val("");
			memPass.next("label").addClass("warning");
			memPassCheck.next("label").addClass("warning");
			return;
		}
		
		let f = document.loginForm;
		f.action = "${pageContext.request.contextPath}/member/memberRegister.jsp"
		f.submit();
		
	}
</script>


</head>
<body>
	<section class="login_form">
		<h1>가입</h1>
		<form name="loginForm" method="post">
			<div class="int-area">
				<label for=memId></label> <input type="text" id="memId" name="memId"
					placeholder="ID" value="" autocomplete="off" required="required">
			</div>
			<div class="int-area">
				<label for=memPass></label> <input type="password" id="memPass"
					name="memPass" placeholder="PASSWORD" value="" autocomplete="off"
					required="required">
			</div>
			<div class="int-area">
				<label for=memPassCheck></label> <input type="password"
					id="memPassCheck" name="memPassCheck" placeholder="PASSWORDCHECK"
					value="" autocomplete="off" required="required">
			</div>
			<div class="int-area">
				<label for=memName></label> <input type="text" id="memName"
					name="memName" placeholder="NICKNAME" value="" autocomplete="off"
					required="required">
			</div>


			<div class="int-area int-area-select">
				<label for=cigarettesPerDay> 평소 흡연량 </label> <select
					name="cigarettesPerDay" required="required">
					<option value="">-- 평소 흡연량 --</option>
					<option value="CD01">일주일에 한 갑</option>
					<option value="CD02">3일에 한 갑</option>
					<option value="CD03">이틀에 한 갑</option>
					<option value="CD04">하루에 한 갑</option>
					<option value="CD05">하루에 한 갑 반</option>
					<option value="CD06">하루에 두 갑 이상</option>
				</select>
			</div>
			<div class="int-area">
				<label for=loveName></label> <input type="text" id="loveName"
					name="loveName" placeholder="사랑하는 사람의 이름" value=""
					autocomplete="off" required="required">
			</div>

			<div class="btn-area">
				<button type="button" id="btn_join" name="btn_join" onclick="join()">가입</button>
			</div>
		</form>
	</section>
</body>
</html>