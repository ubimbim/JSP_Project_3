<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

.main_a{
	text-decoration: none;
	color: black;
}

.big{
	
	margin: 0 auto;
	
	width: 900px;
	height: 500px;
	
	display: flex;
	border: 1px solid #F0FFF0;
	
	
}

.small1{
	width: 450px;
	height: 500px;
	
	flex-direction: row-reverse;
	
}
.first{
	
	width: 450px;
	height: 250px;
	
	
	border: 1px solid #F0FFF0;
}
.first1{
	
	width: 450px;
	height: 250px;
	
	
	border: 1px solid #F0FFF0;
}

.small{
	width: 450px;
	height: 500px;
	
	flex-direction: row-reverse;
	
}

.second{
	width: 450px;
	height: 230px;
	border: 1px solid #F0FFF0;
}

.third{
	margin-top: 40px;
	
	width:450px;
	height: 230px;
	border: 1px solid #F0FFF0;
}

</style>

</head>
<body style="background-color: aliceblue;">

<jsp:include page="../include/shop_top.jsp" />

<div class="big" align="center">
	
	<div class="small1">
	
	<div class="first">
		<a class="main_a" href="">품목별 주간 매출</a>
	</div>
	
	<div align="center" class="first1">
		<a class="main_a" href="">매출보고 내역</a>
	</div>
	
	</div>
	
	<div class="small">
	
		<div class="second">
			<a class="main_a" href="">발주 요청</a>
		</div>
		
		<div class="third">
			<a class="main_a" href="">공지사항</a>
		</div>
		
	</div>
	
</div>

<jsp:include page="../include/shop_bottom.jsp" />

</body>
</html>