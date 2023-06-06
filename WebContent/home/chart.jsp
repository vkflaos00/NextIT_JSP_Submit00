<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HEALTHY</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/home.css">

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load("current", {packages:["corechart"]});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var memberData = [
    ["파리맨", 240, "color: #e5e4e2"],
    ["멍2", 200, "gold"],
    ["멍13", 182, "#b87333"],
    ["멍21", 120, "silver"],
    ["멍9",118 , "color: #e5e4e2"]
  ];
  
  var data = new google.visualization.DataTable();
  data.addColumn('string', '날짜');
  data.addColumn('number', '데이터');
  data.addColumn({type: 'string', role: 'style'});
  
  var xLabels = ['파리맨', '멍2', '멍13', '멍21', '멍9'];
  
  for (var i = 0; i < memberData.length; i++) {
    data.addRow([xLabels[i], memberData[i][1], memberData[i][2]]);
  }
  
  var view = new google.visualization.DataView(data);
  view.setColumns([0, 1,
                   { calc: "stringify",
                     sourceColumn: 1,
                     type: "string",
                     role: "annotation" },
                   2]);

  var options = {
    bar: {groupWidth: "100%"},
    legend: { position: "none" },
    hAxis: {
      direction: -1
    }
  };
  
  var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
  chart.draw(view, options);
}
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
		<p class="text-center3">가장 오래 참은 다섯명</p>
		<div id="barchart_values"></div>
		
	</div>
</body>
</html>
