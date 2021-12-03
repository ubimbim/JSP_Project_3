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
#body-wrapper {
    min-height: 100%;
    position: relative;
}

#body-content {
    margin-top: 0px;
    padding-bottom: 170px; /* footer의 높이 */
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
	<jsp:include page="../include/shop_top.jsp" />
	<div id="body-wrapper">
	<div id="body-content">
	<div align="center">
		
	      <h3>${shopName } 재고 리스트</h3>

		<br>
	   
	   <table border="0" cellspacing="0" width="700">
	      <tr>
	          <th>상품번호</th> <th>상품 이름</th> <th>상품 수량</th>
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
	</div>
	<jsp:include page="../include/shop_bottom.jsp" />
	</div>
</body>
</html>