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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">	

	td,tr {
		text-align: center;padding : 30px;
	}

	.na{
	color:white;
	}
	
	.ac{
		display: flex;
	}
	table {
		margin : 25px;
	}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	      <h2>상품 리스트</h2>
	   <br>
	     <c:set var="list" value="${productListpho }" />
	      <c:if test="${!empty list }">
	      
	   <table class="ac" border="1" cellspacing="0" width="1600">

	      <tr>
	         <c:forEach items="${list }" var="dto">
	         <c:set var="count" value="${count + 1 }" />
	             <td width="400"> <img src="<%=imgPath %>${dto.getPimage() }"
	                         width="150" height="150"> <br>
	                ${dto.getPnum() } <br>
	                <h4>${dto.getPname() } <br></h4>
	                <fmt:formatNumber value="${dto.getPrice() }" /> 원<br>
	               
	                  <a class="btn btn-outline-secondary" href="<%=request.getContextPath() %>/admin_product_update.do?pnum=${dto.getPnum() } ">수 정</a>
	                        &nbsp;&nbsp;|&nbsp;&nbsp;
	                  <a class="btn btn-outline-danger" href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭 제</a>
	                  </td>
	             <c:if test="${count % 4 == 0 }">
	                 </tr>
	                 <tr>   	            
	            </c:if>
	         </c:forEach>
   
	   </table>
	   </c:if>
	   
	   <c:set var="list" value="${productListpad }" />
	      <c:if test="${!empty list }">
	      
	   <table class="ac" border="1" cellspacing="0" width="1600">

	      <tr>
	         <c:forEach items="${list }" var="dto">
	         <c:set var="count" value="${count + 1 }" />
	             <td width="400"> <img src="<%=imgPath %>${dto.getPimage() }"
	                         width="150" height="150"> <br>
	                ${dto.getPnum() } <br>
	                <h4>${dto.getPname() } <br></h4>
	                <fmt:formatNumber value="${dto.getPrice() }" /> 원<br>
	               
	                  <a class="btn btn-outline-secondary" href="<%=request.getContextPath() %>/admin_product_update.do?pnum=${dto.getPnum() } ">수 정</a>
	                        &nbsp;&nbsp;|&nbsp;&nbsp;
	                  <a class="btn btn-outline-danger" href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭 제</a>
	                  </td>
	             <c:if test="${count % 4 == 0 }">
	                 </tr>
	                 <tr>   	            
	            </c:if>
	         </c:forEach>
   
	   </table>
	   </c:if>
	   
	   <c:set var="list" value="${productListwch }" />
	      <c:if test="${!empty list }">
	      
	   <table class="ac" border="1" cellspacing="0" width="1600">

	      <tr>
	         <c:forEach items="${list }" var="dto">
	         <c:set var="count" value="${count + 1 }" />
	             <td width="400"> <img src="<%=imgPath %>${dto.getPimage() }"
	                         width="150" height="150"> <br>
	                ${dto.getPnum() } <br>
	                <h4>${dto.getPname() } <br></h4>
	                <fmt:formatNumber value="${dto.getPrice() }" /> 원<br>
	               
	                  <a class="btn btn-outline-secondary" href="<%=request.getContextPath() %>/admin_product_update.do?pnum=${dto.getPnum() } ">수 정</a>
	                        &nbsp;&nbsp;|&nbsp;&nbsp;
	                  <a class="btn btn-outline-danger" href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭 제</a>
	                  </td>
	             <c:if test="${count % 4 == 0 }">
	                 </tr>
	                 <tr>   	            
	            </c:if>
	         </c:forEach>
   
	   </table>
	   </c:if>
	   
	   <c:set var="list" value="${productListpod }" />
	      <c:if test="${!empty list }">
	      
	   <table class="ac" border="1" cellspacing="0" width="1600">

	      <tr>
	         <c:forEach items="${list }" var="dto">
	         <c:set var="count" value="${count + 1 }" />
	             <td width="400"> <img src="<%=imgPath %>${dto.getPimage() }"
	                         width="150" height="150"> <br>
	                ${dto.getPnum() } <br>
	                <h4>${dto.getPname() } <br></h4>
	                <fmt:formatNumber value="${dto.getPrice() }" /> 원<br>
	               
	                  <a class="btn btn-outline-secondary" href="<%=request.getContextPath() %>/admin_product_update.do?pnum=${dto.getPnum() } ">수 정</a>
	                        &nbsp;&nbsp;|&nbsp;&nbsp;
	                  <a class="btn btn-outline-danger" href="<%=request.getContextPath() %>/admin_product_delete.do?pnum=${dto.getPnum() }">삭 제</a>
	                  </td>

	         </c:forEach>
	         
	         
   
	   </table>
	   <table>
	   <tr>
	      	<td colspan="5">
	      		<a class="btn btn-outline-dark" href="<%=request.getContextPath() %>/admin_product_input.do">제품추가</a> 
	      		<br>
	      	</td>

	      </tr>
	   </table>
	   </c:if>
	   
	   
	   <br>
	</div>
	
	<%-- <div align="center">
	 <a href="<%=request.getContextPath() %>/admin_product_input.do">제품추가</a>   	   
	</div> --%>

</body>
</html>