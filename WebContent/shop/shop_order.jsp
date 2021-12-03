<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apple store order page</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  padding: 0;
  height: 100%;
}

	.kor{
		display: flex;
		
		justify-content: center;
     	
     	
     	margin-top: 80px;
	}
	
	.qwe{
		margin-bottom: 50px;
	}

	.right{
		margin-left: 100px;
	}
	
	
	input[type='number']{
    width: 80px;
	} 
	th, td {
	border-bottom: 1px solid lightgrey;
	}
</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />

	<c:set var="shopid" value="${shopId }" />
	<div class="kor" align="center">
	<div class="left">
	<h3 class="qwe">${shopName } 재고 현황</h3>
		<table width="300">
		<c:set var="list" value="${prodList }" />
		<c:set var="total" value="${total }" />
			<c:if test="${!empty list }">
	      	<tr>
	      		<th>상품명</th> <th>상품 코드</th><th>현재 재고</th>
	         <c:forEach items="${list }" var="dto">
	         <tr>
	               <td> ${dto.getPname() } </td>
	               <td> ${dto.getPnum() } </td>
	               <td> ${dto.getNow_no() }</td>
	         </tr>
			</c:forEach>
	        </c:if>
		</table>
		</div>
		<div class="right">
		<form method="post" 
		action="<%=request.getContextPath() %>/shop_order_ok.do"
		onsubmit = "return confirm('본사에 발주 요청 하시겠습니까?');">
		<br> <br>
		<table>
			<tr>
				<td>상품</td>
				<td>
					<select name="pnum" required>
						<option value="PAD001" selected>iPadPro [PAD001]</option>
		            	<option value="PAD002">iPadAir [PAD002]</option>
		            	<option value="PAD003">iPad [PAD003]</option>
		            	<option value="PAD004">iPadmini [PAD004]</option>
		            	<option value="PHO001">iPhone13Pro [PHO001]</option>	            	
		            	<option value="PHO002" >iPhone13 [PHO002]</option>
		            	<option value="PHO003">iPhone13mini [PHO003]</option>
		            	<option value="PHO004">iPhoneSE [PHO004]</option>
		            	<option value="POD001">AirPodsPro [POD001]</option>
		            	<option value="POD002">AirPods3 [POD002]</option>	            	
		            	<option value="POD003">AirPods2 [POD003]</option>
		            	<option value="WCH001">AppleWatch7 [WCH001]</option>
		            	<option value="WCH002">AppleWatchSE [WCH002]</option>
		            	<option value="WCH003">AppleWatch3 [WCH003]</option>             	
					</select>
				</td>
				<td>수량</td>
				<td><input size="3" type="number" min="0" name="order_no" required></td>
	            <td colspan="2" align="center">
	               <input type="submit" value="발주전송">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>	
		</table>
	</form>
		<table width="600">
		<c:set var="list" value="${orderlist }" />
			<c:if test="${!empty list }">
			<tr>
	      		<th>제품 코드</th><th>수 량</th><th>날 짜</th><th>발주 STATUS</th><th>발주 코드</th><th>삭제</th>
			</tr>
			<c:forEach items="${list }" var="dto">
			<tr>
				<td> ${dto.getPnum() } </td>
	            <td> ${dto.getOrder_no() } </td>
	            <td> ${dto.getOrder_date() } </td>
	            <td> ${dto.getOrder_check() } </td>
	            <td> ${dto.getOrder_code() } </td>
	            <td><a href="<%=request.getContextPath() %>/order_delete.do?no=${dto.getOrder_code() } ">삭 제</a>
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