<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}

	td,tr {
		padding : 10px;
	}
	tr th {
		text-align: center;
		background: #EEEEEE;
	}

	
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	      <h2>상품 추가</h2>
	   <br>
	   
	   <form method="post" enctype="multipart/form-data"
	      action="<%=request.getContextPath() %>/admin_product_input_ok.do">
	   
	      <table border="0" cellspacing="0" width="800">
	         
	         <tr>
	            <th>상품 이미지</th>
	            <td> <input type="file" name="pimage"> <br> </td>
	         </tr>
	         
	         
	         <tr>
	            <th>상품번호</th>
	            <td> <input name="pnum"> </td>
	         </tr>
	         
	         <tr>
	            <th>상품 이름</th>
	            <td> <input name="pname"> </td>
	         </tr>
        	         
	         <tr>
	            <th>상품 가격</th>
	            <td> <input name="price" maxlength="8"> </td>
	         </tr>
	         
	         <tr>
	            <th>상품 정보</th>
	            <td><textarea name = "pcont" rows="5" cols="50"></textarea> </td>
	         </tr>
	         
	         
	         
	         <tr>
	            <td colspan="2" align="center">
	               <input class="btn btn-outline-secondary" type="submit" value="상품등록">&nbsp;&nbsp;&nbsp;
	         	   <input class="btn btn-outline-secondary" type="reset" value="다시작성">
	            </td>
	         </tr>
	      
	      </table>
	   </form>
	
	</div>
	
<jsp:include page="../include/shop_bottom.jsp" />
</body>
</html>