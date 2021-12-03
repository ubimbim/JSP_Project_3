<%@page import="java.util.Date"%>
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
#body-wrapper {
    min-height: 100%;
    position: relative;
}

#body-content {
    margin-top: 0px;
    padding-bottom: 170px; /* footer의 높이 */
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
   display: flex;
   width: 450px;
   height: 220px;
}

div.date {
   position: absolute;
   width: 450px;
   height: 45px;
   text-align: center;
   color: black;
   font-size: 20px;
   font-family: 'Noto Sans KR', sans-serif;
   padding-top: 20px;
}

div.request {
   flex: 1;
}

div.cont {
   width: 150px;
   height: 30px;
   text-align: center;
   color:    black;
   font-size: 15px;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 43px;
}

div.count {
   width: 150px;
   height: 15px;
   text-align: center;
   color: #757575;
   font-size: 30px;
   font-weight: bold;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 95px;
}

div.cont_main {
   width: 150px;
   height: 30px;
   text-align: center;
   color:    black;
   font-size: 18px;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 46px;
}

div.count_main {
   width: 150px;
   height: 15px;
   text-align: center;
   color: #1565C0;
   font-size: 40px;
   font-weight: bold;
   font-family: 'Noto Sans KR', sans-serif;
   margin-top: 85px;
}
</style>

</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
	<div id="body-wrapper">
	<div id="body-content">
	<div class="big" align="center">
	<div class="small">
	<div class="first">
		<nav class="navbar navbar-light bg-light">
			<div class="container-fluid">
				<c:set var="label" value="${label}" />
				<a class="navbar-brand">${shopName } ${label}월 매출</a>
				<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/shop_order.do'">+</button>
			</div>
		</nav>
		<canvas id="shopsales" width="500" height="250"></canvas>
	</div>
   
	<div align="center" class="first">
		<nav class="navbar navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand">주간 제품 판매량 [${shopName }]</a>
				<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/shop_order.do'">+</button>
			</div>
		</nav>
		<canvas id="prodsales" width="500" height="250"></canvas>
	</div>
   
	</div>
   
	<div class="small">
   
	<div class="second">
	<c:set var="now" value="<%=new Date()%>" />
		<nav class="navbar navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand">발주요청 진행현황</a>
				<button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/shop_order.do'">+</button>
            </div>
		</nav>
         
         <div class="ordercard">
            <div class="date"><fmt:formatDate value="${now }" pattern="YYYY.MM.dd" /></div>
               <div class="request">
                  <div class="count">${okcount } 건</div>
                  <div class="cont">승인</div>
               </div>
               
               <div class="request">
                  <div class="count_main">${ordercount } 건</div>
                  <div class="cont_main"> 요청 </div>
               </div>
               
               <div class="request">
                  <div class="count">${cancelcount } 건</div>
                  <div class="cont">취소</div>
               </div>
         </div>
   
      </div>
      
      <div class="third">
         <nav class="navbar navbar-light bg-light">
              <div class="container-fluid">
                <a class="navbar-brand">공지사항</a>
                <button type="button" class="btn btn-outline-dark" onclick="location.href='<%=request.getContextPath() %>/shop_board_list.do'">+</button>
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
                            <a href="<%=request.getContextPath() %>/shop_board_content.do?num=${ndto.getBoard_no() }&page=1 ">
                            ${ndto.getBoard_title() } </a> </td>
                         <td class="notice_date">${ndto.getBoard_date().substring(0, 10) }</td>
                      </tr>
                   </c:forEach>
                </c:if>
                   
                <c:if test="${!empty board }">
                   <c:forEach items="${board }" var="bdto">
                     <tr>
                        <td>[${bdto.getBoard_code() }] &nbsp;
                           <a href="<%=request.getContextPath() %>/shop_board_content.do?num=${bdto.getBoard_no() }&page=1 ">
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
</div>
<c:set var="monthlysaleslist" value="${monthlysaleslist}" />
<jsp:include page="../include/shop_bottom.jsp" />

</div>
<script>
// monthly report
let monthList=[];
<c:forEach var="i" items="${monthlysaleslist}">
monthList.push('${i.key}');
</c:forEach>
let monthData=[];
<c:forEach var="i" items="${monthlysaleslist}">
monthData.push('${i.value}');
</c:forEach>
const l = document.getElementById('shopsales');
const line = new Chart(l, {
		  type: 'line',
		  data: {
			  labels: monthList,
			  datasets: [
			    {
			      data: monthData,
			      borderColor: '#55E6C1',
			      backgroundColor: '#9AECDB',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
// end

// prodsales
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
            	'#fd79a8',
            	'#ffeaa7',
                '#55efc4',
                '#74b9ff'
            ],
            borderColor: [
            	'rgba(255, 99, 132, 0.2)',
            	'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(54, 162, 235, 0.2)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: true,
            position:'right'
	    },
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