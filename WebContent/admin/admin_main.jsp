<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Main Page</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}

.big{
   
   margin: 50px auto;
   width: 1100px;
   height: 800px;
   
   display: flex;
   /* border: 1px solid #F0FFF0; */
   
}

.small{
   margin: 30px;
   width: 500px;
   height: 600px;
   
   flex-direction: row-reverse;
   
}
.first{
   
   margin-bottom: 50px;
   width: 500px;
   height: 300px;
   
   
   border: 1px solid #F0FFF0;
}

.second{
   width: 500px;
   height: 300px;
   border: 1px solid #F0FFF0;
}

.third{
   margin-top: 50px;
   
   width: 500px;
   height: 300px;
   border: 1px solid #F0FFF0;
}

.notice_title {
   font-weight: bold;
}

.notice_date {
   text-align: right;
   font-weight: bold;
}

.board_date {
   text-align: right;
}

td a {
   text-decoration: none;
   color: black;
}

div.ordercard {
   width:450px;
   height: 220px;
   /* background-color: white; */
   margin: 0 auto;
}

div.date {
   text-align: center;
   color: black;
   font-size: 20px;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 25px;
}

div.cont {
   text-align: center;
   color:    black;
   font-size: 18px;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 35px;
}

div.count {
   text-align: center;
   color: #1565C0;
   font-size: 35px;
   font-weight: bold;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 35px;
}

</style>

</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<jsp:include page="../include/admin_top.jsp" />

<div class="big" align="center">
	
	<div class="small">
	
	<div class="first">
		<nav class="navbar navbar-light bg-light">
  				<div class="container-fluid">
			    	<a class="navbar-brand">월 매출</a>
			    	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/admin_monthly.do'">+</button>
				</div>
		</nav>
		<canvas id="shopsales" width="400" height="250"></canvas>
	</div>
	
	<div align="center" class="first">
		<nav class="navbar navbar-light bg-light">
  				<div class="container-fluid">
			    	<a class="navbar-brand">주간 매출</a>
			    	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/admin_weekly.do'">+</button>
				</div>
		</nav>
		<canvas id="wholesales" width="400" height="250"></canvas>
	</div>
	
	</div>
	
	<div class="small">
	
		<div class="second">
      <c:set var="now" value="<%=new Date()%>" />
           <nav class="navbar navbar-light bg-light">
              <div class="container-fluid">
                <a class="navbar-brand">발주요청</a>
                <button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/admin_order.do'">+</button>
            </div>
         </nav>
         
         <div class="ordercard">
            <div class="date"><fmt:formatDate value="${now }" pattern="YYYY-MM-dd" /></div>
            <div class="count">${ordercount } 건</div>
            <div class="cont"> total </div>
         </div>
      
      </div>
		
		<div class="third">
			<nav class="navbar navbar-light bg-light">
  				<div class="container-fluid">
			    	<a class="navbar-brand">공지사항</a>
			    	<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/admin_board_list.do'">+</button>
				</div>
			</nav>
			
			<c:set var="notice" value="${noticelist }" />
			<c:set var="board" value="${boardlist }" />
			
			<table class="table">
				<tbody>
					<c:if test="${!empty notice }">
						<c:forEach items="${notice }" var="ndto">
						    <tr>
						    	<td class="notice_title">
						    		<!-- <img src="images/notice3.png" width="41" height="21">&nbsp; --> 
						    		<span class="badge rounded-pill bg-warning text-dark">공지</span> &nbsp;
						    		<a href="<%=request.getContextPath() %>/admin_board_content.do?num=${ndto.getBoard_no() }&page=1 ">
									 ${ndto.getBoard_title() } </a> </td>
						    	<td class="notice_date">${ndto.getBoard_date().substring(0, 10) }</td>
						    </tr>
			    		</c:forEach>
			    	</c:if>
			    		
			    	<c:if test="${!empty board }">
			    		<c:forEach items="${board }" var="bdto">
							<tr>
								<td>[${bdto.getBoard_code() }] &nbsp;
									<a href="<%=request.getContextPath() %>/admin_board_content.do?num=${bdto.getBoard_no() }&page=1 ">
									 ${bdto.getBoard_title() } </a> </td>
								<td class="board_date">${bdto.getBoard_date().substring(0, 10) }</td>
							</tr>
						</c:forEach>
					</c:if>
			  	</tbody>
			</table>
		</div>
		
	</div>
	
</div>

<jsp:include page="../include/shop_bottom.jsp" />
<script>
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
		
//shop monthly sales
<c:set var="gathistotal" value="${gathistotal}" />
<c:set var="githistotal" value="${githistotal}" />
<c:set var="hothistotal" value="${hothistotal}" />
<c:set var="inthistotal" value="${inthistotal}" />
<c:set var="yethistotal" value="${yethistotal}" />

const ctx = document.getElementById('shopsales');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['GAROSU', 'GIMPO', 'HONGDAE', 'INCHEON', 'YEOUIDO'],
        datasets: [{
            data: [${gathistotal},${githistotal},${hothistotal},${inthistotal},${yethistotal}],
            backgroundColor: [
            	'#fd79a8',
            	'#ffeaa7',
                '#55efc4',
                '#74b9ff',
                '#6c5ce7'
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
    	legend: {
	        display: false
	    },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
// monthly shop sales end
</script>
</body>

</html>