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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/memberRegister.css"/>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/nextit_log.jpg" />
</head>
<body>
	<%request.setCharacterEncoding("utf-8"); %>	
	<jsp:useBean id="member" class="kr.or.nextit.member.vo.MemberVO"></jsp:useBean>
	<jsp:setProperty property="*" name="member"/>
	
	<%
	System.out.println("memberVO .toString() :" + member.toString());
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
		StringBuffer sb1 = new StringBuffer();
		sb1.append(" SELECT COUNT(mem_id) FROM member WHERE mem_id = ?");
		
		pstmt = conn.prepareStatement(sb1.toString());
		pstmt.setString(1, member.getMemId());
		rs = pstmt.executeQuery();
		
		rs.next();
		int rowCount = rs.getInt(1);
		System.out.println("rowCount: " + rowCount);
		
		
		
		if(rowCount != 0) {
			// 사용하는 아이디가 있어서 에러 발생
			// throw new Exception();
			throw new BizDuplicateKeyException();
		}else {
			StringBuffer sb2 = new StringBuffer();
			sb2.append("INSERT INTO member (     ");
			sb2.append(" mem_id     			 ");
			sb2.append(" ,mem_pass   	            ");  
			sb2.append(" ,mem_name   	            ");  
			sb2.append(" ,mem_bir   	           ");  
			sb2.append(" ,mem_zip   	           ");  
			sb2.append(" ,mem_add1   	           ");  
			sb2.append(" ,mem_add2   	           ");  
			sb2.append(" ,mem_hp   	           ");  
			sb2.append(" ,mem_mail   	           ");  
			sb2.append(" ,mem_job   	           ");  
			sb2.append(" ,mem_hobby   	           ");  
			sb2.append(" ,mem_mileage 	           ");  
			sb2.append(" ,mem_del_yn              ");  
			sb2.append(" ,mem_join_date           ");  
			sb2.append(" ,mem_edit_date           ");  
			sb2.append(" ) values(	             ");  
			sb2.append(" ?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,?			             ");  
			sb2.append(" ,0			             ");  
			sb2.append(" ,'N'		             ");  
			sb2.append(" ,sysdate	             ");  
			sb2.append(" ,sysdate	             ");  
			sb2.append(" )	     		         ");  
			
			pstmt = conn.prepareStatement(sb2.toString());
			
			int cnt = 1;
			pstmt.setString(cnt++, member.getMemId());
			pstmt.setString(cnt++, member.getMemPass());
			pstmt.setString(cnt++, member.getMemName());
			pstmt.setString(cnt++, member.getMemBir());
			pstmt.setString(cnt++, member.getMemZip());
			pstmt.setString(cnt++, member.getMemAdd1());
			pstmt.setString(cnt++, member.getMemAdd2());
			pstmt.setString(cnt++, member.getMemHp());
			pstmt.setString(cnt++, member.getMemMail());
			pstmt.setString(cnt++, member.getMemJob());
			pstmt.setString(cnt++, member.getMemHobby());
			
			int resultCnt1 = pstmt.executeUpdate();
			System.out.println("resultCnt1 : " + resultCnt1);
			if(resultCnt1 == 0) {
				// 사용자 정보를 디비에 등록하려고 했는데 안된 경우 
				// throw new Exception();
				throw new BizNotEffectedException();
			}
			
			StringBuffer sb3 = new StringBuffer();
			sb3.append("INSERT INTO member_role(user_id, user_role, user_role_nm) values(?, 'ME', 'MEMBER')");
			pstmt = conn.prepareStatement(sb3.toString());
			pstmt.setString(1, member.getMemId());
			int resultCnt2 = pstmt.executeUpdate();
			
			if(resultCnt2 == 0) {
				// 사용자 권한 정보를 디비에 등록하려고 했는데 안된 경우 
				// throw new Exception();
				throw new BizNotEffectedException();
			}
		}
/* 	}catch(Exception error){
		error.printStackTrace();
		request.setAttribute("error", error); */
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
	
<%-- 	<div class="container">
		<c:if test="${error eq null }">
			<h3>회원등록 성공</h3>
			<div class="alert alert-success">
				<p>정상적으로 회원 등록 되었습니다. 확인 클릭하시면 로그인 페이지로 이동합니다.</p>
				<div class="btn-area">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/login/login.jsp'">확인</button>
				</div>
			</div>
		</c:if>
		<c:if test="${error ne null }">
			<h3>회원등록 실패</h3>
			<div class="alert alert-success">
				<p>회원등록에 실패하였습니다. 전산실에 문의부탁드립니다. 042-719-8850</p>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</c:if>
	</div> --%>
	<div class="container">
		<c:if test="${bne eq null && bde eq null && se eq null}">
			<h3>회원등록 성공</h3>
			<div class="alert alert-success">
				<p>정상적으로 회원 등록 되었습니다. 확인 클릭하시면 로그인 페이지로 이동합니다.</p>
				<div class="btn-area">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/login/login.jsp'">확인</button>
				</div>
			</div>
		</c:if>
		<c:if test="${bde ne null }">
			<h3>회원등록 실패</h3>
			<div class="alert alert-success">
				<p>회원등록에 실패하였습니다. 이미 사용중인 아이디입니다. 다른 아이디를 사용해주세요.</p>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</c:if>
		<c:if test="${bne ne null or se ne null }">
			<h3>회원등록 실패</h3>
			<div class="alert alert-success">
				<p>회원등록에 실패하였습니다. 전산실에 문의부탁드립니다. 042-719-8850.</p>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>