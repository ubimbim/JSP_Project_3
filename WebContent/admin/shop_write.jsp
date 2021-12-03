<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/1c8b531657.js" crossorigin="anonymous"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}
.login h3{
	color: white;
}

.join{
	display: flex;
	justify-content: center;
	margin-top: 100px;
}

.join_back{
	position: relative;
	width: 1000px;
	height: 500px;
	background-color: #263343;
	border-radius: 1em;
}


div.login {
	position: absolute;
	top: 50px;
	left: 280px;
	width: 500px;
    height: 400px;
    text-align: center;
    color: black;
    border-radius: 2em;
}

.login_id {
	margin-top: 35px;
	margin-left: 97px;
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

.login_pw {
	margin-top: 10px;
	margin-left: 97px;
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

.login_name {
	margin-top: 10px;
	margin-left: 97px;
	width: 60%;
}

.login_name input {
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
}

.hr {
	margin-top: 30px;
	margin-bottom: 30px;
}

</style>
</head>
<body>

<jsp:include page="../include/admin_top.jsp" />

<div class="join">
	<div class="join_back">
		<div class="login" >
           <form method="post" action="<%=request.getContextPath() %>/shop_write_ok.do">
            <h3>Sign Up</h3>
            
            <hr class="hr" color="#2e8cff" width="30" size="3">
            
            <div class="login_id">
                   <input name="shop_id" placeholder="ID">
            </div>
            
            <div class="login_pw">
                   <input type="password" name="shop_pwd" placeholder="Password">
            </div>   
            
            <div class="login_name">
					<input name="shop_name" placeholder="ShopName">
			</div>
            
            <div class="login_submit">
                   <input type="submit" value="Join">
            </div>
           </form>
        </div>
	</div>
</div>

<jsp:include page="../include/shop_bottom.jsp" />

</body>
</html>