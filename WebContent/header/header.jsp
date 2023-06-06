<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	MemberVO headerMember = (MemberVO)session.getAttribute("memberVO");
	if(headerMember == null) {
		request.setAttribute("loginState", "none");
	}
	
%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css">
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
	

</script>
</head>
<body>
	<div id="wrap">
		<div id="img_div" class="intro_bg">
			<div class="div_header">
				<ul class="nav">
					<li><a onclick="location.href ='${pageContext.request.contextPath}/home/home.jsp'">[ ${memberVO.memName} ]</a></li>
					<li><a onclick="location.href ='${pageContext.request.contextPath}/home/help.jsp'">도움</a></li>
					<li><a onclick="location.href ='${pageContext.request.contextPath}/home/chart.jsp'">랭크</a></li>
					<li><a onclick="location.href ='${pageContext.request.contextPath}/free/freeList.jsp'">게시판</a></li>
					<li><a onclick="location.href ='${pageContext.request.contextPath}/login/logout.jsp'">로그아웃</a></li>
				</ul>
			</div>


		</div>
	</div>
</body>
</html>