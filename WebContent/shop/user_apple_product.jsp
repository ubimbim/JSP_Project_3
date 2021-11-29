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

	td {
		text-align: center;
	}
	tr:hover {
    background-color:#CCCCCC;
	}
</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />

	<div align="center">
	      <h1>2-2)상품(제품) 리스트 페이지</h1>
	   <br>
	   
	   <table bgcolor="E0E0E0" border="1" cellspacing="0" width="65%">
	      <tr bgcolor="#263343">
	         <th>이미지</th> <th>상품번호</th>
	          <th>상품 이름</th> <th>상품 가격</th>
	      </tr>
	      
	      <c:set var="list" value="${productList }" />
	      <c:if test="${!empty list }">
	         <c:forEach items="${list }" var="dto">
	            <tr>
	             <td> <img src="<%=imgPath %>${dto.getPimage() }"
	                         width="60" height="60"> </td>
	               <td> ${dto.getPnum() } </td>
	               <td> ${dto.getPname() } </td>
	               <td> <fmt:formatNumber value="${dto.getPrice() }" /> 원</td>   
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

</body>
</html>