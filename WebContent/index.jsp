<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/1c8b531657.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">

<style type="text/css">

body{
	background-color: #263343;
}
.top{
	font-size:40px;
	color:white;
}

.top i{
	color:white;
}


.parent{
	 display: flex;
     justify-content: center;
     margin-top: 200px;
}
div.login1{
	width: 300px;
    height: 270px;
    border: 3px solid gray;
    text-align: center;
    margin-right: 100px;
    color: white;
}

.log1{
	margin-left: 18px;
}

.log2{
	margin-left: 18px;
}

div.login2{
	width: 300px;
    height: 270px;
    border: 3px solid gray;
    text-align: center;
    color: white;
}
#bottom{
	min-height: 100%;
	padding-bottom: 100px;
}
.footer{
	width:100%;
	height: 999px;
	position: absolute;
	bottom: 0;
	left: 0;
}

</style>

</head>
<body>

<div class="top" align="center">
	<i class="fab fa-apple"></i>
	<a>영훈이네 관리 시스템</a>
</div>

<div class="parent">
        <div class="login1" >
        
        <h4>Shop Login</h4>
        
        <br><br>
        
        <form class="log1" method="post"
        	action="<%=request.getContextPath() %>/shop_login_ok.do">
        	<table>
        		<tr>
				<th>I  D</th>
				<td> <input name="shop_id"> </td>
				</tr>
			
				<tr>
				<th>Password</th>
				<td> <input type="password" name="shop_pwd"> </td>
				</tr>
				
				<tr>
				<td colspan="3" align="center">
					<br><input type="submit" value="로그인">
				</td>
				</tr>
        	</table>	
        
        </form>
        </div>
           
        <div class="login2" >
        <h4>Manager Login</h4>
        
        <br><br>
        
        <form class="log2" method="post"
        	action="<%=request.getContextPath() %>/main_login_ok.do">
        	<table>
        		<tr>
				<th>I  D</th>
				<td> <input name="main_id"> </td>
				</tr>
			
				<tr>
				<th>Password</th>
				<td> <input type="password" name="main_pwd"> </td>
				</tr>
				
				<tr>
				<td colspan="3" align="center">
					<br><input type="submit" value="로그인">
				</td>
				</tr>
        	</table>	
        
        </form>
        </div>
</div>

</body>
</html>