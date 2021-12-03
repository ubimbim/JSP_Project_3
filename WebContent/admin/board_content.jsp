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
	
	.listbtn {
		width:200px;
		background-color: #000000;
		border: none;
		color:#fff;
		padding: 15px 0;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 15px;
 		margin: 4px;
		cursor: pointer;
		border-radius: 10px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	
		<c:set var="dto" value="${Cont }" />
	
		<div class="notice">
		공지사항
			<button type="button" style="margin-left: 820px" class="btn btn-outline-dark btn-sm" onclick="location.href='admin_board_update.do?num=${dto.getBoard_no() }&page=${Page }'">수정</button>
			<button type="button" class="btn btn-outline-dark btn-sm" onclick="if(confirm('게시글을 삭제하시겠습니까?')) {
																location.href='admin_board_delete.do?num=${dto.getBoard_no() }&page=${Page }'
																} else { return; }">삭제</button>
		</div>

		<hr color="#000000" width="1000" size="3">
		
		<table border="0" cellspacing="0" width="1010">
		
			<tr height="70px">
					<td align="left" style="font-size: 20px">&nbsp;&nbsp; ${dto.getBoard_title() } </td>
					<td align="right" style="font-size: 15px"> ${dto.getBoard_writer() } &nbsp;&nbsp; ${dto.getBoard_date() } &nbsp;&nbsp; </td>
				</tr>
				
				<tr>
					<td colspan="2"><hr width="1000" color="#000000"></td>
				</tr>

				<tr>
					<c:if test="${dto.getBoard_image() != null }">
						<td align="center" colspan="2"> <br><br> <img src="<%=imgPath %>${dto.getBoard_image() }"> </td>
					</c:if>
				</tr>
				
				<tr> <td> </td> </tr>
					
				<tr>
					<td colspan="2"> <br> <textarea rows="20" cols="120" style="border: 0" readonly>${dto.getBoard_cont() } </textarea> </td>
				</tr>
				
				<tr>
					<td colspan="2"><hr width="1000" color="#000000"></td>
				</tr>

			
			<c:if test="${empty dto }">
				<tr>
					<td colspan="2"> <h3>작성된 내용이 없습니다.</h3> </td>
				</tr>
			</c:if>
			
			<tr>
				<td colspan="2" align="center">
					<button type="button" class="listbtn" onclick="location.href='admin_board_list.do?page=${Page }'">전체목록</button>
				</td>
			</tr>
		
		</table>
		
	</div>

</body>
</html>