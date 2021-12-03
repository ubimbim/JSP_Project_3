<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}
.table-wrapper {
  width: 500px; height:500px;
  overflow: auto;
  border:1px solid lightgrey;
}
table {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  margin: 2px 10px;
}
.wrapper {
  width: 550px; height:650px;
  border-spacing: 10;
  border:0.5px solid lightgrey;
}
#container {
    width:100%;
    display:flex; flex-flow:row wrap;
    grid-template-columns: 1fr 1fr; 
    justify-content: center;
}
.item { padding: 8px;  }

</style>	
</head>
<body>
	<jsp:include page="../include/shop_top.jsp" />
	<div id="container">
	<div class="item">
	<div class="wrapper">
		<c:set var="psales" value="${proddata}" />
		<canvas id="prodsales" width="500" height="500"></canvas>
		<table width="400">
		<tr>
			<th>제품군</th><th>판매대수</th>
		</tr>
		<tr>
			<td> iPad</td>
			<td> ${psales[0]} </td>
		</tr>
		<tr>
			<td> iPhone</td>
			<td> ${psales[1]} </td>
		</tr>
		<tr>
			<td> AirPods</td>
			<td> ${psales[2]} </td>
		</tr>
		<tr>
			<td> AppleWatch</td>
			<td> ${psales[3]} </td>
		</tr>
	</table>
	</div>
	</div>
	<div class="item">
	<div class="wrapper">
	<form method="post" 
			action="<%=request.getContextPath() %>/shop_summary_check.do">
	<table>
		<tr>
			<td>검색 기간&nbsp;&nbsp;</td>
			<td><input type="date" name="sdate">&nbsp;&nbsp;&nbsp;&nbsp;-</td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="edate"></td>
		</tr>
		<tr>
			<td>검색 매장&nbsp;&nbsp;</td>
			<td><select name="shopname" required>
	            	   <option value="garosu" selected>Apple 가로수길</option>
	            	   <option value="yeouido">Apple 여의도점</option>
	            	   <option value="hongdae">프리스비 홍대점</option>
	            	   <option value="gimpo">윌리스 김포공항</option>
	            	   <option value="incheon">윌리스 인천터미널점</option>
			</select></td>
			<td align="right"><button type="submit">확인</button></td>
		</tr>
	</table>
	</form>
	<c:set var="dsales" value="${perioddata}" />
	<c:set var="submitdata" value="${submitdata}" />
	<p>${submitdata[0] }&nbsp;&nbsp;&nbsp;  ${submitdata[1] } - ${submitdata[2] }</p>
	<div class='table-wrapper'>
	<table width="400">
		<tr>
			<th>매출 일자</th><th>매출액</th>
		</tr>
		<c:forEach var="i" items="${dsales}">
		<tr>
			<td> ${i.key}</td>
			<td> ${i.value} </td>
		</tr>
		</c:forEach>
	</table>
	</div>
	</div>
	</div>	
</div>
<script>


let proddata=[];
<c:forEach items="${psales}" var="sales">
proddata.push('${sales}');
</c:forEach>

const pie = document.getElementById('prodsales');
const pieChart = new Chart(pie, {
    type: 'pie',
    data: {
        labels: ['iPad','iPhone','Airpods','AppleWatch'],
        datasets: [{
            label: '제품별 매출액',
            data: proddata,
            backgroundColor: [
            	'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
            	'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});


</script>
</body>
</html>