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
//		alert("fn_login");
		let f = document.loginForm;
		console.log("f:", f);
		
		f.action = "${pageContext.request.contextPath}/login/loginCheck.jsp";
		f.submit();
	}
</script>
</head>
<body>

<%
	String msg = request.getParameter("msg");
	System.out.println("msg :" + msg);
	if(msg != null && msg.equals("null")){
		out.print("<script>");
		out.print("alert('정확히 입력해라.')");
		out.print("</script>");
	}else if(msg != null && msg.equals("fail")){
		out.print("<script>");
		out.print("alert('아이디나 패스워드를 확인해라.')");
		out.print("</script>");
	}else if(msg != null && msg.equals("none")){
		out.print("<script>");
		out.print("alert('로그인 후 접속 가능.')");
		out.print("</script>");
	}
	
	Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length > 0){
		for(int i = 0; i < cookies.length; i++){
			if(cookies[i].getName().equals("rememberMe"));
			System.out.println(cookies[i].getName()+ " : " + cookies[i].getValue());
			request.setAttribute("checkBox", "Checked");
			request.setAttribute("memId", cookies[i].getValue());
		}
	}
	
%>



	<section class="login_form">
		<h1>금연</h1>
		<form name="loginForm" method="post">
			<div class="int-area">
			 <label for="memId"></label>
				<input type="text" id="memId" name="memId" value="${memId }"
					placeholder="ID"  autocomplete="off" requird >
			</div>
			<div class="int-area">
			 <label for="memPass"></label>
				<input type="password" id="memPass" name="memPass"
					placeholder="PASSWORD" autocomplete="off" requird>
			</div>
			<div class="div_rememberMe">
				<label for="rememberMe"> <input type="checkbox"
					id="rememberMe" name="rememberMe" value="Y" ${checkBox } />ID 저장
				</label>
			</div>
			<div class="btn-area">
				<button type="button" id="btn_id" name="sbtn_id" onclick="fn_login()">LOGIN</button>
				<button type="button" id="btn_join" name="btn_join"
					onclick="location.href='${pageContext.request.contextPath}/login/join.jsp'">JOIN</button>
			</div>
		</form>
	</section>

</body>
</html>