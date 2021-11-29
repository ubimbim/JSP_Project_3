<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
	
	<h3>발주 내역</h3>
	
	<form method="post"
			action="<%=request.getContextPath() %>/shop_order_check.do">
			<input type="date" name="date1" required>
			<input type="date" name="date2" required>
			&nbsp;&nbsp;&nbsp;상태 : 
			<select name="search_field" required>
				<option value="all">전체</option>
				<option value="order">요청</option>
				<option value="order_ok">발주승인</option>
				<option value="order_cancel">발주취소</option>
			</select>
			<input type="submit" value="확인">
		</form>
	
		<table width="600">
		<c:set var="list" value="${orderlist }" />
			<c:if test="${!empty list }">
			<tr>
	      		<th>요청 코드</th><th>요청매장</th><th>요청제품</th><th>요청 일자</th><th>상태</th>
			</tr>
			<c:forEach items="${list }" var="dto">
			<tr>
				<td> ${dto.getOrder_code() } </td>
				<td> ${shopid } </td>
	            <td> ${dto.getPnum() } </td>
	            <td> ${dto.getOrder_date() } </td>
	            <td> ${dto.getOrder_check() } </td>
	         </tr>
			</c:forEach>
	        </c:if>
		</table>
		
</body>
</html>