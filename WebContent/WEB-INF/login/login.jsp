<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY</title>
<script type="text/javascript">
	function fn_login() {
		alret("fn_login")

	}
</script>
</head>
<body>



	<section class="login_form">
		<h1>금연</h1>
		<form name="loginForm" method="post">
			<div class="int-area">
				<input type="text" id="memId" name="memId" value="${memId }"
					autocomplete="off" requird> <label for="memId">ID</label>
			</div>
			<div class="int-area">
				<input type="password" id="memPass" name="memPass"
					autocomplete="off" requird> <label for="memPass">PASSWORD</label>
			</div>
			<div class="div_rememberMe">
				<label for="rememberMe"> <input type="checkbox"
					id="rememberMe" name="rememberMe" value="Y" ${checkBox } />ID 기억하기
				</label>
			</div>
			<div class="btn-area">
				<button type="button" id="btn_id" name="btn_id" onclick="fn_login()">LOGIN</button>
				<button type="button" id="btn_join" name="btn_join"
					onclick="location.href='${pageContext.request.contextPath}/login/join.jsp'">JOIN</button>
			</div>
		</form>
	</section>

</body>
</html>