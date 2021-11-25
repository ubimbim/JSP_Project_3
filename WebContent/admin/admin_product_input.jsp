<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">	

</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	   <hr width="100%" color="gold">
	      <h1>제품 추가</h1>
	   <hr width="100%" color="gold">
	   <br>
	   
	   <form method="post" enctype="multipart/form-data"
	      action="<%=request.getContextPath() %>/admin_product_input_ok.do">
	   
	      <table bgcolor="E0E0E0" border="1" cellspacing="0" width="400">
	         
	         <tr>
	            <th>상품 이미지</th>
	            <td> <input type="file" name="pimage"> </td>
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
	            <td colspan="2" align="center">
	               <input type="submit" value="상품등록">&nbsp;&nbsp;&nbsp;
	         	   <input type="reset" value="다시작성">
	            </td>
	         </tr>
	      
	      </table>
	   </form>
	
	</div>
	

</body>
</html>