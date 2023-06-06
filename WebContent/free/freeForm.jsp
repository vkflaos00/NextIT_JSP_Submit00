<%@page import="kr.or.nextit.code.vo.CodeVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.nextit.code.service.CommCodeServiceImpl"%>
<%@page import="kr.or.nextit.code.service.ICommCodeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FreeForm</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/freeBoardView.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%
	ICommCodeService codeService = new CommCodeServiceImpl();
	List<CodeVO> categoryList = codeService.getCodeListByParent("BC00");
	request.setAttribute("categoryList", categoryList);

%>
<div id="wrap">
    <div class="header">
        <div class="top_nav">
            <!-- header 영역 -->
            <%@ include file="/header/header.jsp" %>
        </div>
    </div>
    <!-- header e -->


    <!-- 전체 영역잡기 -->
    <div class="contents">
        <!-- 사용할 영역잡기 -->
        <div class="content01">
            <div class="content01_h1">
                <h1>자유게시판</h1>
            </div>
            <form id="freeForm" 
            	action="${pageContext.request.contextPath }/free/freeRegister.jsp" 
            	method="post">
                  <div id="div_table">
                      <table>
                          <colgroup>
                              <col width="200">
                              <col width="400">
                          </colgroup>
                          <tr>
                              <td class="td_left">제목</td>
                              <td class="td_right">
                                  <input type="text" name="boTitle" value=""
                               		autocomplete="off" required="required">
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">작성자</td>
                              <td class="td_right">
                              		<input type="hidden" name="boWriter" 
                              			value="${memberVO.memId }">	
                              		<c:out value="${memberVO.memId }"></c:out>
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 비번</td>
                              <td class="td_right">
										<input type="password" name="boPass"
											value=""	autocomplete="off" 
											required="required"
											pattern="^\w{4,20}$" 
											title="4글자에서 20글자 이내로 입력해주세요">
										수정 또는 삭제시에 필요합니다.
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 분류</td>
                              <td class="td_right">
                              	<select name="boCategory"  required="required">
										<option value="">-- 선택하세요--</option>					
											<c:forEach items="${categoryList }" 
												var="category">
												<option value="${category.commCd }">
													${category.commNm }
												</option>
											</c:forEach>							
										</select>
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">IP</td>
                              <td class="td_right">
                              		${pageContext.request.remoteAddr }	
                              		<input type="hidden" name="boIp"
                              			value="${pageContext.request.remoteAddr }">
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">내용</td>
                              <td class="td_right">
                              			<textarea rows="10" 
												name="boContent" 
												required="required"></textarea>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <!-- 버튼 -->
                  <div class="div_button">
                      <input type="button" 
                      	onclick="${pageContext.request.contextPath}/free/freeList.jsp" value="목록">
                      <input type="submit" value="등록">
                  </div>
       		</form>
        </div>
    </div>


</div>  
</body>
</html>