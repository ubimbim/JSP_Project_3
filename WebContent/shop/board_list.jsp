<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gothic+A1:wght@200;500&display=swap');
</style>
<style type="text/css">

	div.notice {
		width: 1000px;
		height: 30px;
		font-size: 20px;
		font-weight: bold;
		font-family: 'Gothic A1', sans-serif;
		text-align: left;
		margin-top: 50px;
		margin-bottom: 20px;
	}

	tr th {
		text-align: center;
		background: #EEEEEE;
		font-family: 'Gothic A1', sans-serif;
	}
	
	tr {
		height: 60px;
	}
	
	td {
		text-align: center;
		font-family: 'Gothic A1', sans-serif;
	}
	
	h3 {
		text-align: center;
		font-family: 'Gothic A1', sans-serif;
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

</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />

	<div align="center">
		
		<div class="notice">
			공지사항
		</div>
		
		<table border="0" cellspacing="0" width="1000">
			
			<tr>
				<th>번호</th> <th>구분</th> <th>제목</th> <th>작성자</th> <th>작성일자</th>
			</tr>
			
			<c:set var="list" value="${Boardlist }" />
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<tr>
						<td>${dto.getBoard_no() }</td>
						<td>${dto.getBoard_code() }</td>
						<td> <a href="<%=request.getContextPath() %>/shop_board_content.do?num=${dto.getBoard_no() }&page=${page } ">
										   ${dto.getBoard_title() } </a></td>
						<td>${dto.getBoard_writer() }</td>
						<td>${dto.getBoard_date().substring(0, 10) }</td>
					</tr>
				</c:forEach>
			</c:if>
			
			<c:if test="${empty list }">
				<tr>
					<td colspan="5" align="center">
						<h3>공지사항이 없습니다.</h3>
					</td>
				</tr>
			</c:if>
			
			<tr> <td colspan="5"></td> </tr>
		
		</table>
		
		<c:if test="${page <= endBlock && page != 1 }">
	 		<button type="button" class="btn btn-light" onclick="location.href='<%=request.getContextPath() %>/admin_board_list.do?page=1'"><<</button>
		</c:if>
 	
 		<c:forEach begin="${startBlock }" end="${endBlock }" var="i">
	 		<c:if test="${i == page }">
	 			<button type="button" class="btn btn-dark" onclick="location.href='<%=request.getContextPath() %>/admin_board_list.do?page=${i }'">${i }</button>
	 		</c:if>
	 		
	 		<c:if test="${i != page }">
	 			<button type="button" class="btn btn-light" onclick="location.href='<%=request.getContextPath() %>/admin_board_list.do?page=${i }'">${i }</button>
	 		</c:if>
 		</c:forEach>
 	
	 	<c:if test="${allPage > 1 && page != endBlock }">
	 		<button type="button" class="btn btn-light" onclick="location.href='<%=request.getContextPath() %>/admin_board_list.do?page=${endBlock }'">>></button>
	 	</c:if>
	
	</div>

<jsp:include page="../include/shop_bottom.jsp" />

</body>
</html>