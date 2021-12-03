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
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}

	tr th {
		text-align: center;
		background: #EEEEEE;
	}
	
	tr {
		height: 60px;
	}
	
	td {
		text-align: center;
	}
	
	h3 {
		text-align: center;
		left: 150px;
		top: 50px;
	}
	
	td a {
		text-decoration: none;
		color: black;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	tr:hover {
    	background-color:#CCCCCC;
	}

</style>
</head>
<body>
<jsp:include page="../include/admin_top.jsp" />
	<div align="center">
	      <h2>매장별 재고관리 페이지</h2>
	   <br>

	<table border="0" cellspacing="0" width="800">
			<tr>
	         <th>매장이름</th> <th >상품 번호</th>
	          <th >상품 이름</th> <th >남은 수량</th>
	      </tr>
	      
	      <c:set var="list" value="${productcontrol }" />
	      <c:if test="${!empty list }">
	         <c:forEach items="${list }" var="dto">
	            <tr>
	               <td> ${dto.getShop_id() } </td>
	               <td> ${dto.getPnum() } </td>
	               <td> ${dto.getPname() }</td>  
	               <td> ${dto.getNow_no() }</td>  
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