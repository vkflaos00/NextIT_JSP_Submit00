<%@page import="kr.or.nextit.exception.DaoException"%>
<%@page import="kr.or.nextit.exception.BizNotEffectedException"%>
<%@page import="kr.or.nextit.free.vo.FreeBoardVO"%>
<%@page import="kr.or.nextit.free.service.FreeBoardServiceImpl"%>
<%@page import="kr.or.nextit.free.service.IFreeBoardService"%>
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
<title>FreeView</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/freeBoardForm.css">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
/* modal css */
#modal_div1{
	width: 100%;
	height: 100%;
	position: fixed; 
	top: 0; right: 0; bottom: 0; left: 0;
	background-color: rgba(0,0,0,0.4);	
	z-index: 1;
	display: none;
}
#modal_div2{
	width: 400px;
	height: 200px;
	background-color: lightgrey;
	text-align: center;
	position: fixed;
	left: calc(50% - 200px);
	top: calc(50% - 200px);
}
#modal_div2 > p {
	margin-top: 50px;
}
#modal_div2 > a {
	margin-left: 300px;
}
form[name="deleteForm"]{
	width: 350px;
    height: 350px;
    /* background-color: tomato; */
    margin-top: 20px;
}
.int-area{
    width: 300px;
    height: 150px;
    /* background-color: lightblue; */ 
}
.int-area:first-child{
	padding-top: 40px;
}
.int-area input{
    width: 80%;
    padding: 30px 10px 10px;
    background-color: transparent;
    border: none;
    border-bottom: 1px solid #999;
    font-size: 18px;
    color: #fff;
}
.btn-area > button{
    width: 40%;
    height: 40px;
    color: #fff;
    font-size: 20px;
    border: none;
    border-radius: 15px;
    background-color: lightpink;
    position: relative;
    top: -50px
}
/* 버튼클릭액션 */
.btn-area > button:active{
	color: gray;
}
</style>
<script>
function fn_freeDelete(){
	console.log("fn_freeDelete");
	$("#modal_div1").fadeIn();
}
function fn_Cancel(){
	console.log("fn_Cancel");
	$("#modal_div1").fadeOut();
}

function fn_freeHide(){
	let result = confirm("숨김 처리 하시겠습니까?");
	if(result){
		let f = $("form[name='freeHide']");
		f.submit();
	}
}

</script>


</head>
<body>

<jsp:useBean id="searchVO" class="kr.or.nextit.free.vo.FreeBoardSearchVO"></jsp:useBean>
<jsp:setProperty property="*" name="searchVO"/>

<%
	System.out.println(searchVO.toString());
	
	String boNo = request.getParameter("boNo");
	System.out.println("boNo : " + boNo);
	IFreeBoardService freeBoardService = new FreeBoardServiceImpl();
	
	try{
		FreeBoardVO freeBoard = freeBoardService.getBoard(boNo);
	
		freeBoardService.increaseHit(boNo);
		
		System.out.println("freeBoard: "+ freeBoard.toString());
		request.setAttribute("freeBoard", freeBoard);
	}catch(BizNotEffectedException bne){
		request.setAttribute("bne", bne);
		bne.printStackTrace();
	}catch(DaoException de){
		request.setAttribute("de", de);
		de.printStackTrace();
	}


%>

<div id="wrap">
    <div class="header">
        <div class="top_nav">
            <!-- header 영역 -->
            <%@ include file="/header/header.jsp" %>
        </div>
    </div>
    <!-- header e -->

    <div class="intro_bg">
        <div class="intro_text">s
        </div>
    </div>
    <!-- intro_bg e -->

    <!-- 전체 영역잡기 -->
    <div class="contents">
        <!-- 사용할 영역잡기 -->
        <div class="content01">
            <div class="content01_h1">
                <h1>자유게시판</h1>
            </div>
				<c:if test="${bne ne null or de ne null }">
					<div class="alert alert-warning">
							해당글을 불러오지 못하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850
					</div>	
					<div class="div_button">
	                      <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList.jsp'" value="목록">
	                </div>
                </c:if>
            	<c:if test="${bne eq null and de eq null }">
                  <div id="div_table">
                      <table>
                          <colgroup>
                              <col width="200">
                              <col width="400">
                          </colgroup>
                          <tr>
                              <td class="td_left">글 번호</td>
                              <td class="td_right">
                                  ${freeBoard.boNo }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 제목</td>
                              <td class="td_right">
                                 ${freeBoard.boTitle }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 분류</td>
                              <td class="td_right">
                                  ${freeBoard.boCategoryNm }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">작성자명</td>
                              <td class="td_right">
								  ${freeBoard.boWriter }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 내용</td>
                              <td class="td_right">
                              		${freeBoard.boContent }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">IP</td>
                              <td class="td_right">
                              		${freeBoard.boIp }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">조회수</td>
                              <td class="td_right">
                                  ${freeBoard.boHit }
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">최근 등록 일자</td>
                              <td class="td_right">
                                  ${freeBoard.boModDate ne null ? freeBoard.boModDate : freeBoard.boRegDate }
                              </td>
                          </tr>
                      </table>
                  </div>
                  <!-- 버튼 -->
                  <div class="div_button">
                      <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList.jsp?searchType=${searchVO.searchType}&searchWord=${searchVO.searchWord}&searchCategory=${searchVO.searchCategory}&curPage=${searchVO.curPage}&rowSizePerPage=${searchVO.rowSizePerPage}'" value="목록">
                      
                      <c:if test="${freeBoard.boWriter eq memberVO.memId  }">
                      	<input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeEdit.jsp?boNo=${freeBoard.boNo }'" value="수정">
                      	<input type="button" onclick="fn_freeDelete()" value="삭제">
                      </c:if>
						

                  </div>
             </c:if>
             
        </div>
    </div><!--contents	e  -->


	<!-- 글삭제 모달 -->
	<div id="modal_div1" >
		<div id="modal_div2" >
			<form name="deleteForm" action="${pageContext.request.contextPath}/free/freeDelete.jsp" method="post">
				<input type="hidden" id="boNo" name="boNo" value="${freeBoard.boNo }"/>
				<input type="hidden" id="boWriter" name="boWriter" value="${memberVO.memId }"/>
	            <div class="int-area">
	                <input type="password" id="boPass" name="boPass" value="" placeholder="PASSWORD" autocomplete="off" required/>
	            </div>
	            <div class="btn-area">
	                <button type="submit" >삭제</button>
	                <button type="button" onclick="fn_Cancel()">취소</button>
	            </div>
	        </form>
		</div>
	</div>


</div>  
</body>
</html>