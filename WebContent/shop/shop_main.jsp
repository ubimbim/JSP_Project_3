<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body{
	background: aliceblue;
}
.big{
	margin-top: 400px;
	margin: 0 auto;
	width: 900px;
	height: 300px;
	
	display: flex;
	border: 1px solid #000;
	
}

.first{
	
	width: 450px;
	height: 300px;
	
	
	background-color: #ff0;
}

.small{
	width: 450px;
	height: 300px;
	
	flex-direction: row-reverse;
	
}

.second{
	width: 450px;
	height: 150px;
	background-color: aliceblue;
}

.third{
	width:450px;
	height: 150px;
	background-color: skyblue;
}

</style>

</head>
<body>

<jsp:include page="../include/shop_top.jsp" />

<div class="big">
	
	<div class="first">
		<a>ㅇㅇ</a>
	</div>
	
	<div class="small">
	
		<div class="second">
		
		</div>
		
		<div class="third">
			
		</div>
		
	</div>
	
</div>



</body>
</html>