<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 0;
  height: 100%;
}
.wow{
   height: 100%;
   display: flex;
   justify-content: center;
   margin-top: 50px;
   
    flex-direction: column;
     align-items: center;
}

.wow1{
   margin-top: 50px;
   margin-bottom: 50px;
}

</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
	<div class="wow">
	
	<h3>발주 내역</h3>
	
	<div class="wow1">
	
	<form method="post"
			action="<%=request.getContextPath() %>/shop_order_check_again.do">
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
	</div>
	<div class="wow2">
		<table width="800">
		<c:set var="list" value="${orderlist }" />
			<c:if test="${!empty list }">
			<tr>
	      		<th>요청 코드</th><th>요청제품</th><th>요청 일자</th><th>상태</th><th>본사 확인</th><th>코멘트</th>
			</tr>
			<c:forEach items="${list }" var="dto">
			<tr>
				<td> ${dto.getOrder_code() } </td>
	            <td> ${dto.getPnum() } </td>
	            <td> ${dto.getOrder_date() } </td>
	            <td> ${dto.getOrder_check() } </td>
	            <td> <c:if test="${!empty dto.getOrder_comment() }">
	            	${dto.getOrderok_date() }</c:if>
	            	<c:if test="${empty dto.getOrder_comment() }">
	             	미확인</c:if> 
	            </td>
	            <td>
	            	<c:if test="${!empty dto.getOrder_comment() }">
	            	${dto.getOrder_comment() }</c:if>
	            	<c:if test="${empty dto.getOrder_comment() }">
	             	없음</c:if>
	            </td>
	         </tr>
			</c:forEach>
	        </c:if>
		</table>
	</div>
</div>
<div>
<jsp:include page="../include/shop_bottom.jsp" />
</div>
</body>
</html>