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
}
#container {
    justify-content: center;
    display:flex; flex-flow:row wrap;
    grid-template-columns: 1fr 1fr ; 
}
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />
<div id="container">
<div class="item">
    <span>전체 매출(최근 1주일)</span>
<canvas id="wholesales" width="400" height="400"></canvas>
</div>
<div class="item">
    <span>매장별 매출</span>
<canvas id="shopsales" width="400" height="400"></canvas>
</div>
</div>
<div align="center">
	<table width="900">
		<tr>
			<th>매장명</th>
			<c:set var="week" value="${week}" />
			<c:forEach var="week" items="${week}"><th>${week}</th></c:forEach>
		</tr>
		<c:set var="garosu" value="${garosu}" />
		<c:set var="gimpo" value="${gimpo}" />
		<c:set var="hongdae" value="${hongdae}" />
		<c:set var="incheon" value="${incheon}" />
		<c:set var="yeouido" value="${yeouido}" />
		<tr>
			<td> Apple 가로수길 </td>
			<c:forEach var="garosu" items="${garosu}">
			<td>${garosu }</td></c:forEach>
		</tr>
		<tr>
			<td> 윌리스 김포공항 </td>
			<c:forEach var="gimpo" items="${gimpo}">
			<td>${gimpo }</td></c:forEach>
		</tr>
		<tr>
			<td> 프리스비 홍대점 </td>
			<c:forEach var="hongdae" items="${hongdae}">
			<td>${hongdae }</td></c:forEach>
		</tr>
		<tr>
			<td> 윌리스 인천터미널점 </td>
			<c:forEach var="incheon" items="${incheon}">
			<td>${incheon }</td></c:forEach>
		</tr>
		<tr>
			<td> Apple 여의도 점 </td>
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
        labels: ['GAROSU', 'GIMPO', 'HONGDAE', 'INCHEON', 'YEOUIDO'],
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
week.push('${week}');
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
				      label: 'GAROSU',
				      data: garosu,
				      backgroundColor: 'rgba(255, 99, 132, 0.2)',
				      borderColor: 'rgba(255, 99, 132, 0.2)',
				      borderWidth: 1,
				    },
				    {
				      label: 'GIMPO',
				      data: gimpo,
				      backgroundColor: 'rgba(255, 205, 86, 0.2)',
				      borderColor: 'rgba(54, 162, 235, 0.2)',
				      borderWidth: 1,
				    },
				    {
				      label: 'HONGDAE',
				      data: hongdae,
				      backgroundColor: 'rgba(75, 192, 192, 0.2)',
				      borderColor: 'rgba(255, 206, 86, 0.2)',
				      borderWidth: 1,
				    },
				    {
				        label: 'INCHEON',
				        data: incheon,
				        backgroundColor: 'rgba(54, 162, 235, 0.2)',
				        borderColor: 'rgba(75, 192, 192, 0.2)',
					    borderWidth: 1,
				    },
				    {
				        label: 'YEOUIDO',
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