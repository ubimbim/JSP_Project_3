<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
	String imgPath = request.getContextPath()+"/upload/";
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	
		<c:set var="dto" value="${Cont }" />
	
		<h3>공지사항</h3>
		<hr width="80%" color="gray">
		<br>
		
		<table border="0" cellspacing="0" width="1010">
		
			<tr>
				<td> <input type="button" value="목록" onclick="location.href='admin_board_list.do?page=${Page }'"> </td>
			</tr>
			
			<tr> <td> <br> </td> </tr>
				
				<tr>
					<td align="left" style="font-size: 20px"> ${dto.getBoard_title() } </td>
				</tr>
				
				<tr>
					<td>⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯</td>
				</tr>
				
				<tr>
					<td align="right" style="font-size: 13px"> ${dto.getBoard_writer() } &nbsp;&nbsp;&nbsp; ${dto.getBoard_date() } </td>
				</tr>
				
				<tr>
					<c:if test="${dto.getBoard_image() != null }">
						<td align="center"> <br><br> <img src="<%=imgPath %>${dto.getBoard_image() }"> </td>
					</c:if>
				</tr>
				
				<tr> <td> <br> </td> </tr>
					
				<tr>
					<td>⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯</td>
				</tr>
				<tr>
					<td> <br> <textarea rows="20" cols="100" style="border: 0" readonly>${dto.getBoard_cont() } </textarea> </td>
				</tr>

			
			<c:if test="${empty dto }">
				<tr>
					<td> <h3>작성된 내용이 없습니다.</h3> </td>
				</tr>
			</c:if>
				
			<tr>
				<td align="center">
					<input type="button" value="수정" onclick="location.href='admin_board_update.do?num=${dto.getBoard_no() }&page=${Page }'"> &nbsp;
					<input type="button" value="삭제" onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
																location.href='admin_board_delete.do?num=${dto.getBoard_no() }&page=${Page }'
																} else { return; }">
				</td>
			</tr>
		
		</table>
		
	</div>

</body>
</html>