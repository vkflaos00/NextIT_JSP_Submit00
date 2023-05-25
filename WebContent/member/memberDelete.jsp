<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NextIT</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/nextit_log.jpg" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/member.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/footer.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<jsp:useBean id="member" class="kr.or.nextit.member.vo.MemberVO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try{
			conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
			StringBuffer sb  = new StringBuffer();
			sb.append(" UPDATE member SET ");
			sb.append(" mem_del_yn = 'Y'  ");
			sb.append(" WHERE mem_id = ?  ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, member.getMemId());
			
			int resultSet = pstmt.executeUpdate();
			if(resultSet == 0) {
				throw new BizNotEffectedException();
			}
			session.removeAttribute("memberVO");
		}catch(BizNotEffectedException bne){
			bne.printStackTrace();
			request.setAttribute("bne", bne);
		}catch(Exception se){
			se.printStackTrace();
			request.setAttribute("se", se);
		}finally {
			if(pstmt != null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(conn != null){try{conn.close();}catch(Exception e){e.printStackTrace();}}
		}
	
	%>
<div class="container">
	<c:if test="${bne eq null && se eq null}">
		<h3>회원탈퇴 성공</h3>
		<div>
			<p>회원 탈퇴가 처리 되었습니다. 확인을 누르시면 로그인 페이지로 이동합니다.</p>
			<div class="btn-area">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/login/login.jsp'">확인</button>
			</div>
		</div>
	</c:if>
	<c:if test="${bne ne null or se ne null }">
		<h3>회원탈퇴 실패</h3>
		<div>
			<p> 회원 탈퇴에 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850</p>
			<div class="btn-area">
				<button type="button" onclick="">뒤로가기</button>
				<button type="button" onclick="">홈</button>
			</div>
		</div>
	</c:if>
</div>


  
</body>
</html>