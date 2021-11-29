<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="js/customer.js"></script> -->
<script type="text/javascript">

	function content(ocode) {
		
		document.checkForm.action = "<%=request.getContextPath() %>/admin_order_cont.do?code="+ocode;
		
	}

</script>

<style type="text/css">

	.order {
		display: flex;
	}
	
	.ordertable {
		flex: 1;
	}
	
	.ordercontent {
		flex: 1;
	}

	/* .order {
		width: 100%;
		height: 500px;
		bordder: 3px solid red;
		margin: 0px auto;
		padding: 0px;
		overflow: hidden;
	} */

	/* .ordertable {
		width: 400px;
		height: 400px;
		line-height: 100px;
		background-color: orange;
		margin: 0 auto;
		display: inline-block;
	}
	
	.ordercontent {
		width: 400px;
		height: 400px;
		line-height: 100px;
		background-color: orange;
		margin: 0 auto;
		display: inline-block;
	} */

</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
	
	<br><br><br><br><br>
	
	<c:set var="list" value="${List }" />
	
	<div class="order" style="width: 500px; height: 500px;"> 
	<div class="ordertable">
	
		<input type="hidden" name="shopid" value="${shopId }">
		
		<table border="0" cellspacing="0" width="500">
			<tr>
				<th>요청번호</th> <th>요청날짜</th> <th>상태</th>
			</tr>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<%-- <td> <input type="button" name="code" value="${dto.getOrder_code() }" onclick="loaction.href='admin_order_cont.do?code=${dto.getOrder_code() }"> </td> --%>
						<td> <a href="<%=request.getContextPath() %>/shop_order.do?code=${dto.getOrder_code() }">${dto.getOrder_code() }</a></td>
						<td> ${dto.getOrder_date().substring(0, 10) } </td>
						<td> ${dto.getOrder_check() } </td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="5" align="center">
						<h3>발주 없음</h3>
					</td>
				</tr>
			</c:if>
		</table>
		
	</div>
	
	<c:set var="cont" value="${Cont }" />
	
	<c:if test="${empty cont }">
		<div class="ordercontent">
		
		</div>
	</c:if>
	
	<c:if test="${!empty cont }">
		<div class="ordercontent">
			<table border="1" cellspacing="0" width="600">
			
				<tr>
					<td colspan="2" align="center">
						<h3>발주 요청서</h3>
					</td>
				</tr>
				
				<tr>
					<th>발주코드</th>
					<td> <input name="order_code" value="${cont.getOrder_code() }" readonly></td>
				</tr>
				
				<tr>
					<th>제품명</th>
					<td> <input value="${cont.getPname() }" readonly></td>
				</tr>
				
				<tr>
					<th>제품코드</th>
					<td> <input name="pnum" value="${cont.getPnum() }" readonly></td>
				</tr>

				<tr>
					<th>발주 수량</th>
					<td> <input value="${cont.getOrder_no() }" readonly> </td>
				</tr>
								
				<tr>
					<th>발주 시각</th>
					<td> <input value="${cont.getOrder_date() }" readonly></td>
				
				<c:if test="${!empty cont.getOrderok_date() }">
					<tr>
						<th>처리 시각</th>
						<td> <input value="${cont.getOrderok_date() }" readonly> </td>
					</tr>
				</c:if>
				
				<tr>
					<th>진행 상황</th>
					<td> <input value="${cont.getOrder_check() }" readonly> </td>
				</tr>
				
				<tr>
					<th>Comment</th>
					<td>
						<textarea rows="2" cols="65" readonly>${cont.getOrder_comment() }</textarea>
					</td>
				</tr>
				
			</table>
		</div>
	</c:if>
	</div>
	
</body>
</html>