<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/1c8b531657.js" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
<style type="text/css">

body{
	margin: 0;
	font-family: ''Source Sans Pro', sans-serif;
	
}

.cate_a {
	text-decoration: none;
	color: white;
}

.bar{
	display: flex;
	justify-content: space-between;
	align-items: center;
	background-color: #263343;
	padding: 8px 12px;
	
	margin-bottom: 90px;
}


.logo{
	font-size:24px;
	color:white;
}

.logo i{
	color:white;
}

.menu{
	display: flex;
	list-style: none;
	padding-left: 0;
}

.menu li{
	padding: 8px 20px;
	
	margin:5px 30px;
	float: left;
	position: relative;
	padding:0;
	
}

.menu li a{
	display: block;
	margin:0;
	padding: 7px 8px;
}

.menu ul{
	list-style: none;
	margin: 0;
	padding: 0;
	position:absolute;
	left:0;
	top: 40px;
	width: 105px;
	background: #263343;
	text-align: center;
	border-radius: 4px;
}

.menu ul li:hover a{
	border-radius: 4px;
	background-color: lightgray;
	
}

.menu ul li{
	float: none;
	margin:0;
	padding: 0;
	font-size: 13px;
}

.menu ul{
	list-style: none;
	margin:0;
	padding: 0;
	position: absolute;
	left: 0;
	top: 40px;
	width: 105px;
	background: #263343;
	text-align: center;
	opacity: 0;
}

.menu li:hover ul{
	opacity: 1;
}

.menu li:hover ul li{
	height: 35px;
	overflow: visible;
	padding: 0;
}

.menu li:hover > a{
	background-color: lightgray;
	color: black;
	border-radius: 4px;
}

.logout{
	list-style: none;
	color: white;
	display: flex;
	padding-left: 0;

}

.logout li {
	padding: 3px;
}

@media screen and (max-width: 666px) {
	.bar{
		flex-direction: column;
		align-items: flex-start;
		padding: 8px 24px;
	}
	
	.menu{
		flex-direction: column;
		align-items: center;
		width: 100%;
	}
	
	.menu li{
	width: 100%;
	text-align: center;
	}
	
	.logout{
		justify-content: center;
		width: 100%;
	}
	
}

</style>

</head>
<body>

<nav class="bar" >
	
	<div class="logo">
		<i class="fab fa-apple"></i>
		<a class="cate_a" href="">매장관리</a>
	</div>
	
	<ul class="menu">
		<li><a class="cate_a" href="<%=request.getContextPath() %>/admin/admin_main.jsp">Home</a></li>
		
		<li><a class="cate_a" href="<%=request.getContextPath() %>/admin/shop_info.jsp">매  장</a>
			<ul class="sub">
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin/shop_info.jsp">Shop Info</a></li>
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin_product_list.do">제품관리</a></li>
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin_board_list.do">공지사항</a></li>
			</ul>
		</li>
		
		<li><a class="cate_a" href="<%=request.getContextPath() %>/admin_product_control.do">재  고</a>
			<ul class="sub">
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin_product_control.do">재고관리</a></li>
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin_order.do">발주현황</a></li>
			</ul>
		</li>
		
		<li><a class="cate_a" href="<%=request.getContextPath() %>/admin_summary.do">매  출</a>
			<ul class="sub">
				<li> <a class="cate_a" href="<%=request.getContextPath() %>/admin_summary.do">주간 매출</a></li>
				<li> <a class="cate_a" href="">매장별 매출</a></li>
			</ul>
		</li>
		
	</ul>
	
	<ul class="logout">
		<li> <a class="cate_a" href="#">관리자 &nbsp;</a> </li>
		<li><i class="fas fa-sign-in-alt"></i></li>
		<li><a class="cate_a" href="<%=request.getContextPath() %>/admin_logout.do">Logout</a></li>
	</ul>
</nav>


</body>
</html>