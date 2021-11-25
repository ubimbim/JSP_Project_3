<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center">
	<hr width="50%" color="tomato">
		<h3>매장 관리 시스템 회원 가입</h3>
	<hr width="50%" color="skyblue">
	<form method="post" action="<%=request.getContextPath() %>/shop_write_ok.do">
	
	<table border="1" cellspacing="0" width="300">
	
	<tr>
		<th>I  D</th>
		<td> <input name="shop_id"> </td>
	</tr>
	
	<tr>
		<th>Password</th>
		<td> <input type="password" name="shop_pwd"> </td>
	</tr>
	
	<tr>
		<th>매장이름</th>
		<td> <input name="shop_name"> </td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="계정등록">&nbsp;&nbsp;&nbsp;
			<input type="reset" value="다시작성">
		</td>
	</tr>
	
	
	</table>
	</form>
</div>

</body>
</html>