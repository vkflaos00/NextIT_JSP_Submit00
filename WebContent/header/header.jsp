<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberVO headerMember = (MemberVO)session.getAttribute("memberVO");
	if(headerMember == null) {
		request.setAttribute("loginState", "none");
	}
	
%>

<script type="text/javascript">

	$(function(){
		// alert("header.jsp");
		let loginState = $("#loginState").val();
		console.log("loginState", loginState);
		if(loginState == "none"){
			alert("로그인 하셔야 이용 가능합니다.");
			location.href = "${pageContext.request.contextPath}/login/login.jsp";
		}
	});
	
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
			<div class="div_header">
				<ul class="nav">
					<li><a href="#">접속자[ ${memberVO.memId} ]</a></li>
					<li><a href="#about">도움</a></li>
					<li><a href="#service">랭크</a></li>
					<li><a href="#">게시판</a></li>
					<li><a href="#" onclick="fn_logout()">로그아웃</a></li>
				</ul>
			</div>


		</div>
	</div>
</body>
</html>