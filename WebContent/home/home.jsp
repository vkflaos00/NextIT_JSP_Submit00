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
	function fn_delete() {
		let ret = confirm("정말 피우셨습니까? 장난치면 곤란합니다.");
		if (ret) {
			location.href = "${pageContext.request.contextPath}/member/memberDelete.jsp";
		}
	}

 	
 	function fn_hit() {
 	 
 	let goodCount = 0;
 	}
 
</script>

</head>
<body>
	<div id="wrap">
		<div id="img_div" class="intro_bg">
			<div class="header">
				<ul class="nav">
					<li><a href="#">접속자[ ${memberVO.memId} ]</a></li>
					<li><a href="#about">도움</a></li>
					<li><a href="#service">랭크</a></li>
					<li><a href="#">게시판</a></li>
					<li><a href="#" onclick="fn_logout()">로그아웃</a></li>
				</ul>
			</div>
			<!-- header e -->
			<h2>가만히 있어도 성공하는 세상에서 가장 쉬운 도전</h2>
			<p>${memberVO.memName} 탈출까지 ${memberVO.dDay}일 (점점 줄어든다)</p>
			<p>${memberVO.memName}의 폐 (점점 깨끗해진다)</p>
			<p>${memberVO.loveName}님이 당신을 응원하는 중 </p>
			<p>현재까지 아낀 돈 : ${memberVO.money}원 (점점 늘어난다)</p>
			<button type="button" id="hitButton" onclick="fn_hit()">말릴때마다
				누르는 버튼</button>
			<p>현재까지 ${memberVO.goodCount} 번 만큼 참아냈단다.</p>
			<button type="button" value="버튼" onclick="fn_delete()">피우면
				누르는 버튼</button>

		</div>
	</div>
</body>
</html>