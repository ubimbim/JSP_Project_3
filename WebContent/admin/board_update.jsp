<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

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
	
		<h3>글 수정</h3>
		<hr width="80%" color="gray">
		<br>
		
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin_board_updateOk.do">
		
			<input type="hidden" name="board_no" value="${dto.getBoard_no() }">
			<input type="hidden" name="board_page" value="${Page }">
			
			<table border="1" cellspacing="0" width="600">
			
				<tr>
					<td>
						<select name="board_code">
							<c:if test="${dto.getBoard_code() == '공지' }">
								<%-- 공지를 클릭한 경우 String board_code = "notice"; --%>
								<option value="notice" selected>공지</option>
								<option value="issue">이슈</option>
								<option value="promotion">행사</option>
							</c:if>
							
							<c:if test="${dto.getBoard_code() == '이슈' }">
								<%-- 이슈를 클릭한 경우 String board_code = "issue"; --%>
								<option value="notice">공지</option>
								<option value="issue" selected>이슈</option>
								<option value="promotion">행사</option>
							</c:if>
							
							<c:if test="${dto.getBoard_code() == '행사' }">
								<%-- 행사를 클릭한 경우 String board_code = "promotion"; --%>
								<option value="notice" selected>공지</option>
								<option value="issue">이슈</option>
								<option value="promotion" selected>행사</option>
							</c:if>
						</select>
					</td>
					
					<td align="right"> <input name="board_writer" value="admin"> </td>
				</tr>
				
				<tr>
					<td colspan="5"> <input name="board_title" value="${dto.getBoard_title() }"> </td>
				</tr>
				
				<tr>	
					<td colspan="5">
						<textarea rows="20" cols="100" name="board_content">${dto.getBoard_cont() }</textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="5">기존 첨부파일 [${dto.getBoard_image() }] <br>
						<input type="file" name="board_image_New">
						<input type="hidden" name="board_image_Old" value="${dto.getBoard_image() }">
					</td>
				</tr>
				
				<tr>
					<td colspan="5" align="center">
						<input type="submit" value="수정"> &nbsp;
						<input type="reset" value="다시작성">
					</td> 
				</tr>
			
			</table>
		
		</form>
	
	</div>

</body>
</html>