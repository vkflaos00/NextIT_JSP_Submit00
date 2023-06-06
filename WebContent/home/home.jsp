<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/home.css">

<%
	MemberVO member = (MemberVO) session.getAttribute("memberVO");
	if (member == null) {
		response.sendRedirect(request.getContextPath() + "/login/login.jsp?msg=none");
	}
%>

<script>
	function fn_reset() {
		let ret = confirm("정말 피우셨습니까? 장난치면 곤란합니다.");
		if (ret) {
			location.href = "${pageContext.request.contextPath}/member/memberReset.jsp";
		}
	}

	$(document).ready(
			function() {
				// 페이지 로드 시 실행되는 함수
				var count = parseInt(getCookie("hitButton")); // 쿠키에서 카운트 가져오기

				// 카운트 값이 존재하지 않으면 0으로 초기화
				if (isNaN(count)) {
					count = 0;
				}

				// 카운트 업데이트
				$("#count").text(count);

				function fn_hit() {
					count++;
					$("#count").text(count);

					document.cookie = "hitButton="
							+ count
							+ "; expires="
							+ new Date(new Date().getTime()
									+ (2 * 365 * 24 * 60 * 60 * 1000))
									.toUTCString();
				}

				$("#hitButton").click(fn_hit);

				// 쿠키에서 값을 가져오는 함수
				function getCookie(name) {
					var value = "; " + document.cookie;
					var parts = value.split("; " + name + "=");
					if (parts.length === 2) {
						return parts.pop().split(";").shift();
					}
					return "";
				}
			});
	
	
</script>

</head>
<body>
	<div id="wrap">
		<header id="page_header">
			<%@ include file="/header/header.jsp"%>
		</header>

		<!-- header e -->
		<hr>
		<h1>가만히 있어도 성공하는 세상에서 가장 쉬운 도전</h1>
		<hr>

		<div id="content-container">
			<div class="lung">
				<img src="${pageContext.request.contextPath}/images/lung.png"
					alt="${memberVO.memName} 의  폐">
			</div>
			
			<div class="content">
				
				<p class="text-center">${memberVO.memName} 탈출까지  ${memberVO.dDay}일</p>
				<button type="button" id="hitButton" name="hitButton">말릴때마다
					누르는 버튼</button>
				<p class="text-center">
					        현재까지 <span id="count" name="count" value="count"></span> 번 만큼
					참아냈단다.
				</p>
				<button type="button" id="resetButton" name="resetButton" value="버튼" onclick="fn_reset()">피우면
					누르는 버튼</button>
			</div>
		</div>
	</div>
</body>
</html>