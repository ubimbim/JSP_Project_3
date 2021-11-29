<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String imgPath = request.getContextPath()+"/upload/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	td, tr {
		text-align: center;
	}
	
	tr:hover {
    background-color:#CCCCCC;
	}
	
	.na{
	color:white;
	}
	
	

</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />

	<div align="center">
	&nbsp;&nbsp;&nbsp;
		<br>
	      <h2>${shopName }<br>
	      재고 리스트</h2>
		<br>
	   
	   <table bgcolor="E0E0E0" border="1" cellspacing="0" width="700">
	      <tr bgcolor="#263343">
	          <th class = na>상품번호</th> <th class = na>상품 이름</th> <th class = na>상품 수량</th>
	      </tr>
	      
	      <c:set var="list" value="${shoplist }" />
	      <c:if test="${!empty list }">
	         <c:forEach items="${list }" var="dto">
	            <tr>
	            
	               <td> ${dto.getPnum()} </td>
	               <td> ${dto.getPname()} </td>
	               <td> ${dto.getNow_no()} </td>   
	            </tr>
	            
	            
	         </c:forEach>
	      </c:if>

	
	      <c:if test="${empty list }">
	         <tr>
	            <td colspan="9" align="center">
	               <h3>등록된 상품 리스트가 없습니다.....</h3>
	            </td>
	         </tr>
	      </c:if>
	   
	   </table>   	   
	</div>

	<jsp:include page="../include/shop_bottom.jsp" />
</body>
</html>