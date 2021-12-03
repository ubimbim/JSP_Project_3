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

<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}
.num{
		text-align:center;
	}
	
	.top{
		display: flex;
		justify-content: center;
		margin-top: 50px;
	}

	.all{
		display: flex;
		justify-content: center;
		margin-top: 80px;
	}

	.ordertable {
		
		width: 500px;
		height: 300px;
		
	}
	
	.ordercontent {
		
		margin-left: 100px;
		
		width:500px;
		height: 500px;
	}
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />
	
	<div class="top">
	<form method="post" action="<%=request.getContextPath() %>/admin_order.do">
		<input type="date" name="date1" required>
		<input type="date" name="date2" required>
		&nbsp;&nbsp;&nbsp;매장 :
			<select name="search_shop" required>
				<option value="all">전체</option>
				<option value="yeouido">Apple 여의도</option>
				<option value="garosu">Apple 가로수길</option>
				<option value="hongdae">프리스비 홍대</option>
				<option value="gimpo">윌리스 김포공항</option>
				<option value="incheon">윌리스 인천터미널</option>
			</select>
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
	
	
	<div class="all">
	<c:set var="list" value="${List }" />
	
	<div class="ordertable">
		
		<table border="0" cellspacing="0" width="500">
			<tr>
				<th>요청번호</th> <th>요청매장</th> <th>요청날짜</th> <th>상태</th>
			</tr>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<%-- <td> <input type="button" name="code" value="${dto.getOrder_code() }" onclick="loaction.href='admin_order_cont.do?code=${dto.getOrder_code() }"> </td> --%>
						<td> <a href="<%=request.getContextPath() %>/admin_order.do?code=${dto.getOrder_code() }">${dto.getOrder_code() }</a></td>
						<td> ${dto.getShop_id() } </td>
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
			<form method="post" action="<%=request.getContextPath() %>/admin_update.do">
			<table border="1" cellspacing="0" width="600">
				<tr>
					<td colspan="2" align="center">
						<h3>발주 요청 확인서</h3>
					</td>
				</tr>
				
				<tr>
					<th>발주코드</th>
					<td> <input name="order_code" value="${cont.getOrder_code() }" readonly></td>
				</tr>
				
				<tr>
					<th>매장</th>
					<td> <input value="${cont.getShop_name() }" readonly></td>
				</tr>
				
				<tr>
					<th>매장코드</th>
					<td> <input name="shop_id" value="${cont.getShop_id() }" readonly></td>
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
						<c:if test="${!empty cont.getOrderok_date() }">
							<td> <input value="${cont.getOrder_no() }" readonly> </td>
						</c:if>
						
						<c:if test="${empty cont.getOrderok_date() }">
							<td> <input type="number" name="order_no" value="${cont.getOrder_no() }" min="1" max="100"> </td>
						</c:if>
				</tr>
				
				<!-- 본사에서 발주 승인 시에는 상세 내역에 현재 매장 수량이 나타나지 않도록(본사/매장 둘다) -->
				<c:if test="${cont.getOrder_check() != '발주승인'}">
				
				<tr>
					<th>현재 매장 수량</th>
					<td> <input name="now_no" value="${cont.getNow_no() }"> </td>
				</tr>
				
				</c:if>
				
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
					<c:if test="${!empty cont.getOrderok_date() }">
						<th>진행 상황</th>
						<td> <input value="${cont.getOrder_check() }" readonly> </td>
					</c:if>
						
					<c:if test="${empty cont.getOrderok_date() }">
						<th>처리 방법</th>
						<td>
							<select name="order_check"> 
								<option value="confirm">발주승인</option>
								<option value="cancel">발주취소</option>
							</select>
						</td>
					</c:if>
				</tr>
				
				<tr>
					<th>Comment</th>
					<td>
						<c:if test="${!empty cont.getOrderok_date() }">
							<textarea rows="2" cols="65" readonly>${cont.getOrder_comment() }</textarea>
						</c:if>
						
						<c:if test="${empty cont.getOrderok_date() }">
							<textarea rows="2" cols="65" name="order_comment"></textarea>
						</c:if>
					</td>
				</tr>

				
				<tr>
					<td colspan="2" align="right">
					<%-- <a href="<%=request.getContextPath() %>/admin_order_cancel.do?check=${cont.getOrder_code() }">
						<img src="<%=request.getContextPath() %>/images/cancelled.png" border="0" width="80" height="80">
					</a> --%>
					<input type="submit" value="확인">
				</tr>
				
			</table>
			</form>
		</div>
	</c:if>
	</div>
	<jsp:include page="../include/shop_bottom.jsp" />
</body>
</html>