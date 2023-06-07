<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="kr.or.nextit.member.vo.MemberVO"%>
<%@ page import="java.io.InputStreamReader"%>

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
// API 요청 URL
  var apiUrl = "https://api.odcloud.kr/api/15018867/v1/uddi:9fdf2982-70c8-4295-8174-a958d32f7056?page=1&perPage=10&serviceKey=oTZF%2FauXJZcuxpo6Nq2Sy5LIy68VV%2B%2FDisNVz8G6HcqBntJgCQsYNSGPMRds1xzonxMBE%2BD77qZuSKquOC3%2B4Q%3D%3D";

  // API 호출
  fetch(apiUrl)
    .then(function(response) {
      return response.json();
    })
    .then(function(data) {
      // 필요한 데이터 추출
      var dataArr = data.data;

      // HTML로 테이블 생성
      var table = document.createElement("table");
      var headerRow = table.insertRow();
      for (var key in dataArr[0]) {
        var headerCell = document.createElement("th");
        headerCell.textContent = key;
        headerRow.appendChild(headerCell);
      }

      for (var i = 0; i < dataArr.length; i++) {
        var rowData = dataArr[i];
        var row = table.insertRow();
        for (var key in rowData) {
          var cell = row.insertCell();
          cell.textContent = rowData[key];
        }
      }

      // 테이블을 페이지에 추가
      var container = document.getElementById("table-container");
      if (container) {
        container.appendChild(table);
      } else {
        console.error("table-container element not found");
      }
    })
    .catch(function(error) {
      console.log(error);
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

		<div id="map" style="width: 500px; height: 200px;"></div>

		<div id="table-container">
			<!-- 테이블이 여기에 동적으로 생성됩니다 -->
		</div>
	</div>

</body>

</html>