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
#container {
	width: 1200px;
	height: 600px;
	display: flex;
}
#box-left {
  flex: 2;
  text-align: left;
}
#box-center {
  flex: 2;
  text-align: center;
}
#box-right {
  flex: 1;
  text-align: right;
}
header {
  height: 75px;
  padding: 1rem;
  color: black;
  background: white;
  font-weight: bold;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
	body{
		font-family: Monospace,"돋움", dotum, "굴림", gulim, arial, helvetica, sans-serif;
		color: #ffffff;
		}
</style>
</head>
<body>
<jsp:include page="../include/admin_top.jsp" />

<header>
  <h1>매출 관리</h1>
  <nav>
    <span>전체 매출(최근 1주일)</span>
    <span>매장별 매출</span>
</nav>
</header>

<div id="container" width="900" height="300">
<div id="box-left">
<canvas id="shopsales"></canvas>
</div>
<div id="box-center">
<canvas id="wholesales"></canvas>
</div>
<div id="box-right">
<canvas id="prodsales"></canvas>
</div>
</div>
	<h2>Weekly Sales report</h2>
	<table>
		<tr>
			<th>Date</th><th>Shop</th>
		</tr>
	</table>
	<h3>매출보고 내역</h3>
		<table width="300">
	      	<tr>
	      		<th>상품명</th> <th>수 량</th><th>합 계</th><th>삭 제</th>
	         <tr>
	               <td> ${dto.getPname() } </td>
	               <td> ${dto.getSales_no() } </td>
	               <td> ${dto.getTotal() }</td>
		</table>
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
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let proddata=[];
<c:set var="psales" value="${prodsales}" />
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
				    },
				    {
				      label: 'GIMPO',
				      data: gimpo,
				      backgroundColor: 'rgba(54, 162, 235, 0.2)',
				    },
				    {
				      label: 'HONGDAE',
				      data: hongdae,
				      backgroundColor: 'rgba(255, 206, 86, 0.2)',
				    },
				    {
				        label: 'INCHEON',
				        data: incheon,
				        backgroundColor: 'rgba(75, 192, 192, 0.2)',
				    },
				    {
				        label: 'YEOUIDO',
				        data: yeouido,
				        backgroundColor: 'rgba(255, 159, 64, 0.2)',
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
		    responsive: true,
		    /* legend: {
		         position: 'right' // place legend on the right side of chart
		      }, */
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