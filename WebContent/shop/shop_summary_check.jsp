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

	div.row {
		width: 80%;
		display: flex;
	}
	div.left {
        width: 40%;
        float: left;
	}
	div.right {
        width: 60%;
        float: right;
	}
</style>	
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
<div class="row">
	<div class="left">
	<canvas id="shopsales"></canvas>
	
<table>
	<tr>
		<td> 이번달 총 매출</td>
		<td> 20000</td>
	</tr>
	<tr>
		<td> 저번달 총 매출</td>
		<td> 30000 </td>
	</tr>
	<tr>
		<td> 전달대비 증감액</td>
		<td> -10000 </td>
	</tr>
	<tr>
		<td> 전달대비 매출(%) </td>
		<td> 66% </td>
	</tr>
</table>	
</div>
</div>
<div class="right">
	<form type="post">
	<input type="date"> <input type="date"> <button type="submit">확인</button>
	</form>
	<canvas id="prodsales" height="400vh" width="400vw"></canvas>
	<table>
	<tr>
		<th>매출 일자</th><th>매출액</th>
	</tr>
	<tr>
		<td> 2021-11-29</td>
		<td> 30000 </td>
	</tr>
</table>	
</div>
<script>
const ctx = document.getElementById('shopsales');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['10월', '11월'],
        datasets: [{
            label: '전월대비 매출액',
            data: [30000, 20000],
            backgroundColor: [
            	'rgba(54, 162, 235, 0.2)',
            	'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
            	'rgb(54, 162, 235)',
            	 'rgb(255, 99, 132)'
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