<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>Apple store sales summary here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 0;
  height: 100%;
}
#container {
    justify-content: center;
    display:flex; flex-flow:row wrap;
    grid-template-columns: 1fr 1fr ; 
}
table.type05 {
  border-collapse: separate;
  border-spacing: 1px;
  text-align: center;
  line-height: 1.2;
  border-top: 1px solid #ccc;
  margin: 10px 10px;
}
table.type05 th {
  width: 650px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
  background: #efefef;
}
table.type05 td {
  width: 350px;
  padding: 10px;
  vertical-align: top;
  border-bottom: 1px solid #ccc;
}
.wrapper {
  width: 500px; height:500px;
  border-spacing: 10;
  border:0.5px solid lightgrey;
}
</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
<div id="container">
<div class="item">
<div class="wrapper">
    <span>전체 매출(최근 1주일)</span>
<canvas id="wholesales" width="450" height="450"></canvas>
</div>
</div>
<div class="item">
<div class="wrapper">
    <span>매장별 매출</span>
<canvas id="shopsales" width="450" height="450"></canvas>
</div>
</div>
</div>
<div align="center">
	<table width="1000" class="type05">
		<tr>
			<th scope="row">매장명</th>
			<c:set var="week" value="${week}" />
			<c:forEach var="week" items="${week}"><td>${week}</td></c:forEach>
		</tr>
		<c:set var="garosu" value="${garosu}" />
		<c:set var="gimpo" value="${gimpo}" />
		<c:set var="hongdae" value="${hongdae}" />
		<c:set var="incheon" value="${incheon}" />
		<c:set var="yeouido" value="${yeouido}" />
		<tr>
			<th scope="row"> Apple 가로수길 </th>
			<c:forEach var="garosu" items="${garosu}">
			<td>${garosu }</td></c:forEach>
		</tr>
		<tr>
			<th scope="row"> 윌리스 김포공항 </th>
			<c:forEach var="gimpo" items="${gimpo}">
			<td>${gimpo }</td></c:forEach>
		</tr>
		<tr>
			<th scope="row"> 프리스비 홍대점 </th>
			<c:forEach var="hongdae" items="${hongdae}">
			<td>${hongdae }</td></c:forEach>
		</tr>
		<tr>
			<th scope="row"> 윌리스 인천터미널점 </th>
			<c:forEach var="incheon" items="${incheon}">
			<td>${incheon }</td></c:forEach>
		</tr>
		<tr>
			<th scope="row"> Apple 여의도 점 </th>
			<c:forEach var="yeouido" items="${yeouido}">
			<td>${yeouido }</td></c:forEach>
		</tr>
	</table>
	</div>
	
<script>
let shopdata=[];
<c:set var="sales" value="${shopsales}" />
<c:forEach items="${sales}" var="sales">
shopdata.push('${sales}');
</c:forEach>
const ctx = document.getElementById('shopsales');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['가로수', '김포', '홍대', '인천', '여의도'],
        datasets: [{
            label: 'WEEKLY SALES REPORT',
            data: shopdata,
            backgroundColor: [
            	'rgba(255, 99, 132, 0.2)',
                'rgba(255, 205, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
            	 'rgb(255, 99, 132)',
                 'rgb(255, 205, 86)',
                 'rgb(75, 192, 192)',
                 'rgb(54, 162, 235)',
                 'rgb(153, 102, 255)'
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

let week=[];
<c:set var="week" value="${week}" />
<c:forEach items="${week}" var="week">
week.push('${week}'.substring(5, 10));
</c:forEach>
let garosu=[];
<c:set var="garosu" value="${garosu}" />
<c:forEach items="${garosu}" var="garosu">
garosu.push('${garosu}');
</c:forEach>
let gimpo=[];
<c:set var="gimpo" value="${gimpo}" />
<c:forEach items="${gimpo}" var="gimpo">
gimpo.push('${gimpo}');
</c:forEach>
let hongdae=[];
<c:set var="hongdae" value="${hongdae}" />
<c:forEach items="${hongdae}" var="hongdae">
hongdae.push('${hongdae}');
</c:forEach>
let incheon=[];
<c:set var="incheon" value="${incheon}" />
<c:forEach items="${incheon}" var="incheon">
incheon.push('${incheon}');
</c:forEach>
let yeouido=[];
<c:set var="yeouido" value="${yeouido}" />
<c:forEach items="${yeouido}" var="yeouido">
yeouido.push('${yeouido}');
</c:forEach>
const con = document.getElementById('wholesales');
const config = new Chart(con, {
		  type: 'bar',
		  data: {
				  labels: week,
				  datasets: [
				    {
				      label: '가로수',
				      data: garosu,
				      backgroundColor: 'rgba(255, 99, 132, 0.2)',
				      borderColor: 'rgba(255, 99, 132, 0.2)',
				      borderWidth: 1,
				    },
				    {
				      label: '김포',
				      data: gimpo,
				      backgroundColor: 'rgba(255, 205, 86, 0.2)',
				      borderColor: 'rgba(54, 162, 235, 0.2)',
				      borderWidth: 1,
				    },
				    {
				      label: '홍대',
				      data: hongdae,
				      backgroundColor: 'rgba(75, 192, 192, 0.2)',
				      borderColor: 'rgba(255, 206, 86, 0.2)',
				      borderWidth: 1,
				    },
				    {
				        label: '인천',
				        data: incheon,
				        backgroundColor: 'rgba(54, 162, 235, 0.2)',
				        borderColor: 'rgba(75, 192, 192, 0.2)',
					    borderWidth: 1,
				    },
				    {
				        label: '여의도',
				        data: yeouido,
				        backgroundColor: 'rgba(153, 102, 255, 0.2)',
				        borderColor: 'rgba(153, 102, 255, 0.2)',
					    borderWidth: 1,
				      },
				  ]
				},
		  options: {
		    plugins: {
		      title: {
		        display: true,
		        text: 'Chart.js Bar Chart - Stacked'
		      },
		    },
		    responsive: false,
		    scales: {
		        xAxes: [{
		           stacked: true 
		        }],
		        yAxes: [{
		           stacked: true 
		        }]
		     }
		  }
		});
</script>
</body>
</html>