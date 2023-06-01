<%@page import="java.sql.SQLException"%>
<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@page import="kr.or.nextit.exception.BizDuplicateKeyException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
</head>
<body>
	<jsp:useBean id="member" class="kr.or.nextit.member.vo.MemberVO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>

	<%
	request.setCharacterEncoding("utf-8");
	
	System.out.println("memberVO.toString() :" + member.toString());
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb1 = new StringBuffer();
		sb1.append(" SELECT COUNT(mem_id) FROM member WHERE mem_id = ?");
		
		pstmt = conn.prepareStatement(sb1.toString());
		pstmt.setString(1, member.getMemId());
		rs = pstmt.executeQuery();
		
		rs.next();
		int rowCount = rs.getInt(1);
		System.out.println("rowCount: " + rowCount);
		
		if(rowCount != 0){
			System.out.println("아이디 중복 값 있음 ");
			throw new BizDuplicateKeyException();	
		}else{
			StringBuffer sb2 = new StringBuffer();
			sb2.append(" INSERT INTO MEMBER (       		");
			sb2.append(" mem_id					       		");
			sb2.append(" ,mem_pass					       	");
			sb2.append(" ,mem_name					       	");
			sb2.append(" ,cigarettesPerDay				   	");
			sb2.append(" ,memJoinDate				       	");
			sb2.append(" ,longestSmokeFreeDate			  	");
			sb2.append(" ,loveName				       		");
			sb2.append(" ) values(				       		");
			sb2.append("  ?						       		");
			sb2.append(" ,?						       		");
			sb2.append(" ,?						       		");
			sb2.append(" ,?						       		");
			sb2.append(" ,sysdate				       		");
			sb2.append(" ,sysdate						   		");
			sb2.append(" ,?						       		");
			sb2.append(" )						       		");
			
			pstmt = conn.prepareStatement(sb2.toString());
			
			int cnt = 1;
			pstmt.setString(cnt++, member.getMemId());
			pstmt.setString(cnt++, member.getMemPass());
			pstmt.setString(cnt++, member.getMemName());
			pstmt.setString(cnt++, member.getCigarettesPerDay());
			pstmt.setString(cnt++, member.getLoveName());
			
			int resultCnt1 = pstmt.executeUpdate();
			System.out.println("resultCnt1 : " + resultCnt1);
			
			if(resultCnt1 ==0){
				System.out.println("사용자 정보 디비 등록 안됨");
				throw new BizNotEffectedException();
			}

		}	
	}catch(BizDuplicateKeyException bde){
		bde.printStackTrace();
		request.setAttribute("bde", bde);
	}catch(BizNotEffectedException bne){
		bne.printStackTrace();
		request.setAttribute("bne", bne);
	}catch(SQLException se){
		se.printStackTrace();
		request.setAttribute("se", se);
	}finally{
		if(rs != null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
		if(pstmt != null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
		if(conn != null){try{conn.close();}catch(Exception e){e.printStackTrace();}}
	}
	
	%>
	<div class="container">
		<c:if test="${bne eq null && bde eq null && se eq null}">
			<h3>회원등록 성공</h3>
			<div class="alert alert-success">
				<p>가입 성공! 확인을 클릭하면 로그인 페이지로 이동.</p>
				<div class="btn-area">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/login/login.jsp'">확인</button>
				</div>
			</div>
		</c:if>
		<c:if test="${bde ne null }">
			<h3>회원등록 실패</h3>
			<div class="alert alert-success">
				<p>사용중인 아이디. 다른 아이디를 사용해라.</p>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</c:if>
		<c:if test="${bne ne null or se ne null }">
			<h3>회원등록 실패</h3>
			<div class="alert alert-success">
				<p>가입실패</p>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>