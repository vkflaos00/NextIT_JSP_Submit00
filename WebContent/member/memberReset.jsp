<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.or.nextit.exception.BizPasswordNotMatchedException"%>
<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RESET</title>
</head>
<body>

	<%

	MemberVO member = (MemberVO)session.getAttribute("memberVO");
	System.out.println("member.toString():" + member.toString());

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
			StringBuffer sb1  = new StringBuffer();
			sb1.append("SELECT count(mem_id) FROM member WHERE mem_id = ?");
			
			pstmt = conn.prepareStatement(sb1.toString());
			pstmt.setString(1, member.getMemId());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			int rowCount = rs.getInt(1);
			System.out.println("rowCount : "+ rowCount);
			
			if(rowCount != 1) {
				throw new BizPasswordNotMatchedException();
			}else {
				StringBuffer sb2 = new StringBuffer();
				sb2.append("UPDATE member SET ");
				sb2.append("join_date = sysdate, ");
				sb2.append("d_day = 730, ");
				sb2.append("money = 0, ");
				sb2.append("good_count = 0 ");
				sb2.append("WHERE mem_id = ?");

				pstmt = conn.prepareStatement(sb2.toString());

				int cnt = 1;
				pstmt.setString(cnt++, member.getMemId());

				int resultCnt = pstmt.executeUpdate();
				
				session.setAttribute("memberVO", member);
				
				if(resultCnt== 0){
					throw new BizNotEffectedException();
					

				}
			}
			
		}catch(BizPasswordNotMatchedException bpe){
			bpe.printStackTrace();
			request.setAttribute("bpe", bpe);
		}catch(BizNotEffectedException bne){
			bne.printStackTrace();
			request.setAttribute("bne", bne);
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("e", e);
		}finally {
			if(rs != null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt != null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(conn != null){try{conn.close();}catch(Exception e){e.printStackTrace();}}
		}
				
	%>

	<div class="container">
		<c:if test="${bpe eq null and bne eq null and se eq null }">

			<div>
				<p>한 대라도 피우면 금연 중이 아니란다.</p>
				<p>너의 도전은 리셋되었다.</p>
				<p>마음을 다잡고 다시 도전해라.</p>
				<div class="btn-area">
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/login/login.jsp'">확인</button>
				</div>
			</div>
		</c:if>
		<c:if test="${bne ne null or se ne null }">
			<h3>실패????</h3>
			<div>
				<div class="btn-area">
					<button type="button" onclick="history.back();">뒤로가기</button>
					<button type="button"
						onclick="location.href='${pageContext.request.contextPath}/home/home.jsp'">홈</button>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>