<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/1c8b531657.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  background-color: #263343;
  font-family: 'Noto Sans KR', sans-serif;
}

div.main_top {
	 display: flex;
     justify-content: center;
     margin-top: 150px;
}

div.main_bottom {
	 display: flex;
     justify-content: center;
     margin-top: 50px;
}

div.back_login {
	position: relative;
	width: 1000px;
	height: 500px;
	background-color: white;
	border-radius: 1em;
}

div.login1 {
	position: absolute;
	top: 50px;
	width: 500px;
    height: 400px;
    text-align: center;
    color: black;
    border-right: 1px solid #C5CAE9;
}

.login_id {
	margin-top: 35px;
	margin-left: 78px;
	width: 60%;
}

.login_id input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

div.login2 {
	position: absolute;
	top: 50px;
	left: 500px;
	width: 500px;
    height: 400px;
    text-align: center;
    color: black;
    border-radius: 2em;
}

.login_pw {
	margin-top: 10px;
	margin-left: 78px;
	width: 60%;
}

.login_pw input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.login_submit {
	margin-top: 50px;
	margin-left: 78px;
	width: 340px;
	height: 50px;
}
.login_submit input {
	width: 100%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 30px;
	background: linear-gradient(to left, rgb(46, 139, 255), rgb(47, 191, 255));
	color: white;
	font-size: 1.0em;
	letter-spacing: 2px;
	font-weight: bold;
}

.hr {
	margin-top: 30px;
	margin-bottom: 30px;
}

.footer {
	width:100%;
	height: 999px;
	position: absolute;
	bottom: 0;
	left: 0;
}

</style>

</head>
<body>
	
	<div class="main_top">
		<img class="img" src="images/applelogo.png">
	</div>
	<div class="main_bottom">
	<div class="back_login">
        <div class="login1" >
	        <form method="post" action="<%=request.getContextPath() %>/main_login_ok.do">
	        	<h2>Admin Login</h2>
	        	<hr class="hr" color="#2e8cff" width="30" size="3">
	        	<div class="login_id">
	                <input name="main_id" placeholder="ID">
	            </div>
	            <div class="login_pw">
	                <input type="password" name="main_pwd" placeholder="Password">
	            </div>	
				<div class="login_submit">
	                <input type="submit" value="LOGIN">
	            </div>
	        </form>
        </div>
           
        <div class="login2" >
        	<form method="post" action="<%=request.getContextPath() %>/shop_login_ok.do">
	        	<h2>Shop Login</h2>
	        	<hr class="hr" color="#2e8cff" width="30" size="3">
	        	<div class="login_id">
	                <input name="shop_id" placeholder="ID">
	            </div>
	            <div class="login_pw">
	                <input type="password" name="shop_pwd" placeholder="Password">
	            </div>	
				<div class="login_submit">
	                <input type="submit" value="LOGIN">
	            </div>
	        </form>
        </div>
    </div>
	</div>

</body>
</html>