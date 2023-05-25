<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NextIT</title>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/nextit_log.jpg" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/memberView.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/footer.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function fn_memberEdit(memId){
		// alert("memid :" + memId);
		location.href = "${pageContext.request.contextPath}/member/memberEdit.jsp?memId="+memId;
	}
	function fn_delete(memId){
		// alert("memId :" + memId)
		let real = confirm("정말 삭제 하시겠습니까? 돌이킬 수 없습니다. ");
		if(real) {
			location.href='${pageContext.request.contextPath}/member/memberDelete.jsp?memId='+memId;
		}
		
	}
</script>
</head>
<body>
<%
	String memId = request.getParameter("memId");
	System.out.println("memId : " + memId);
	
	MemberVO mem = (MemberVO)session.getAttribute("memberVO");
	
	if(memId != null && mem != null && memId.equals(mem.getMemId())) {
		System.out.println("(memberView) memId of request and memId of session are the same");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:study");
			
			StringBuffer sb = new StringBuffer();
			sb.append(" SELECT 						 	");
			sb.append(" mem_id     			 		 	");
			/* sb.append(" ,mem_pass   	           		");   */
			sb.append(" ,mem_name   	            	");  
			sb.append(" ,mem_bir   	           		 	");  
			sb.append(" ,mem_zip   	           		 	");  
			sb.append(" ,mem_add1   	           	  	");  
			sb.append(" ,mem_add2   	           		");  
			sb.append(" ,mem_hp   	           			");  
			sb.append(" ,mem_mail   	           		");  
			sb.append(" ,mem_job   	           			");  
			sb.append(" ,mem_hobby   	          		");  
			sb.append(" ,mem_mileage 		            ");  
			sb.append(" FROM member WHERE mem_id = ? 	");  
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, memId);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				MemberVO member = new MemberVO();
				member.setMemId(rs.getString("mem_id"));
				/* member.setMemPass(rs.getString("mem_pass")); */
				member.setMemName(rs.getString("mem_name"));
				member.setMemBir(rs.getString("mem_bir"));
				member.setMemZip(rs.getString("mem_zip"));
				member.setMemAdd1(rs.getString("mem_add1"));
				member.setMemAdd2(rs.getString("mem_add2"));
				member.setMemHp(rs.getString("mem_hp"));
				member.setMemMail(rs.getString("mem_mail"));
				member.setMemJob(rs.getString("mem_job"));
				member.setMemHobby(rs.getString("mem_hobby"));
				member.setMemMileage(rs.getInt("mem_mileage"));
				/* member.setMemDelYn(rs.getString("mem_del_yn"));
				member.setMemJoinDate(rs.getString("mem_join_date"));
				member.setMemEditDate(rs.getString("mem_edit_date")); */
				
				System.out.println("member.toString() : " + member.toString());
				
				request.setAttribute("member", member);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			request.setAttribute("error", e);
		}finally{
			if(rs != null){try{rs.close();}catch(Exception e){e.printStackTrace();}}
			if(pstmt != null){try{pstmt.close();}catch(Exception e){e.printStackTrace();}}
			if(conn != null){try{conn.close();}catch(Exception e){e.printStackTrace();}}
		}
		
	}else { 
		System.out.println("(memberView) memId of request and memId of session are not the same");
		BizNotEffectedException bne = new BizNotEffectedException();
		request.setAttribute("bne", bne);
		
	}
%>


    <div id="wrap">
        <div class="header">
            <div class="top_nav">
                <!-- header 영역 -->
                <%@ include file = "/header/header.jsp" %>
            </div>
        </div>
        <!-- header e -->

        <div class="intro_bg">
            <div class="intro_text">
                <h1>NextIT</h1>
                <h4>넥스트아이티</h4>
            </div>
        </div>
        <!-- intro_bg e -->
		
        <!-- 전체 영역잡기 -->
        <div class="contents">
            <!-- 사용할 영역잡기 -->
            <div class="content01">
                <div class="content01_h1">
                    <h1>회원 정보 상세</h1>
                </div>
                <!-- 회원 정보 테이블 -->  
                <div id="div_table">
                 	<c:choose>
                 		<c:when test="${error ne null or bne ne null }">
                 			<!-- 회원정보 조회 실패 -->
                 			<h3>회원정보 조회 실패</h3>
                 			<div class= "alert alert-success">
                 				<p>회원 정보 조회 실패하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850</p>
                 				<div class="btn-area">
                 					<button type="button" onclick="history.back()">뒤로가기</button>
                 				</div>
                 			</div>
                 		</c:when>
                 		<c:when test="${error eq null and bne eq null }">
                 			<!-- 회원정보 조회 성공 -->
                 			<table>
                 				<tbody>
                 					<tr>
                 						<td class="td_left">아이디</td>
                 						<td class="td_right"><c:out value="${member.memId }"></c:out></td>
                 					</tr>
                 					<tr>
                 						<td class="td_left">회원명</td>
                 						<td class="td_right"><c:out value="${member.memName }"></c:out></td>
                 					</tr>
                 					<tr>
                 						<td class="td_left">우편번호</td>
                 						<td class="td_right"><c:out value="${member.memZip }"></c:out></td>
                 					</tr>
                 					<tr>
                 						<td class="td_left">주소</td>
                 						<td class="td_right"><c:out value="${member.memAdd1 } ${member.memAdd2 }"></c:out></td>
                 					</tr>
                 					<tr>
                 						<td class="td_left">생일</td>
                 						<td class="td_right"><input type="date" name="memBir" value="${fn:substring(member.memBir,0,10) }" readonly="readonly"></td>
                 					</tr>
                  					<tr>
                 						<td class="td_left">핸드폰</td>
                 						<td class="td_right"><c:out value="${member.memHp }"></c:out></td>
                 					</tr>
                  					<tr>
                 						<td class="td_left">직업</td>
                 						<td class="td_right"><c:out value="${member.memJob }"></c:out></td>
                 					</tr>
                  					<tr>
                 						<td class="td_left">취미</td>
                 						<td class="td_right"><c:out value="${member.memHobby }"></c:out></td>
                 					</tr>
                  					<tr>
                 						<td class="td_left">마일리지</td>
                 						<td class="td_right"><c:out value="${member.memMileage }"></c:out></td>
                 					</tr>
                 				</tbody>
                 			</table>
                 			<div class="div_button">
                 				<input type="button" onclick="location.href='${pageContext.request.contextPath}/home/home.jsp'" value="HOME">
                 				
                 				<input type="button" onclick="fn_memberEdit('${member.memId}')" value="수정">
                 				<input type="button" onclick="fn_delete('${member.memId}')" value="삭제">
                 			</div>
                 		</c:when>
                 	</c:choose>
                </div>
            </div>
        </div>

         <!-- footer -->
         <footer id="page_footer">
            <!-- footer영역 -->
            <%@ include file = "/footer/footer.jsp" %>
        </footer>

   </div>    
</body>
</html>