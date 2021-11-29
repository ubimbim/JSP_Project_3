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

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	&nbsp;&nbsp;&nbsp;
	      <h2>상품 리스트</h2>
	   <br>
	   
	   <table bgcolor="E0E0E0" border="1" cellspacing="0" width="65%">
	      <tr bgcolor="#263343">
	         <th class = na>이미지</th> <th class = na>상품번호</th>
	          <th class = na>상품 이름</th> <th class = na>상품 가격</th>
	           <th class = na>수 정&nbsp;&nbsp;|&nbsp;&nbsp;삭 제</th>
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
	               <td>
	                  <a href="<%=request.getContextPath() %>/admin_product_update.do?pnum=${dto.getPnum() }">수 정</a>
	                        &nbsp;&nbsp;|&nbsp;&nbsp;
	                  <a href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭 제</a>
	               </td>    
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
	      
	      <tr>
	      	<td colspan="5">
	      		<a href="<%=request.getContextPath() %>/admin_product_input.do">제품추가</a> 
	      	</td>
	      </tr>
	   
	   </table>
	</div>
	
	<%-- <div align="center">
	 <a href="<%=request.getContextPath() %>/admin_product_input.do">제품추가</a>   	   
	</div> --%>

</body>
</html>