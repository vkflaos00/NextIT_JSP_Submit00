<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<%
	MemberVO member = (MemberVO) session.getAttribute("memberVO");
	if (member == null) {
		response.sendRedirect(request.getContextPath() + "/login/login.jsp?msg=none");
	}
%>

<script>
	function fn_logout() {
		// alert("fn_logout");
		let ret = confirm("로그아웃?");
		if (ret) {
			location.href = "${pageContext.request.contextPath}/login/logout.jsp";
		}
	}
</script>

</head>
<body>
	<div id="wrap">
		<div id="img_div" class="intro_bg">
			<div class="header">
				<ul class="nav">
					<li><a href="#">접속자[ ${memberVO.memId} ]</a></li>
					<li><a href="#about">HELP</a></li>
					<li><a href="#service">RANK</a></li>
					<li><a href="#">FREEBOARD</a></li>
					<li><a href="#" onclick="fn_logout()">LOGOUT</a></li>



				</ul>
				<!-- header e -->



			</div>
		</div>
	</div>
</body>
</html>