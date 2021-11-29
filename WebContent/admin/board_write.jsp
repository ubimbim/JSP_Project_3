<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	tr {
		height: 60px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
	
		<h3> 공지사항 작성 </h3>
		<hr width="80%" color="gray" width="800">
		<br>
		
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin_board_writeOk.do">
		
			<table border="0" cellspacing="0" width="600">
			
				<tr>
					<td>
						<select class="form-select" aria-label="Default select example" name="board_code">
							<%-- 공지를 클릭한 경우 String board_code = "notice"; --%>
							<option value="공지">공지</option>
							<%-- 이슈를 클릭한 경우 String board_code = "issue"; --%>
							<option value="이슈">이슈</option>
							<%-- 행사를 클릭한 경우 String board_code = "promotion"; --%>
							<option value="행사">행사</option>
						</select>
					</td>
					
					<td> </td> <td> </td> <td> </td>
					
					<td align="right"> <input name="board_writer" value="${adminId }"> </td>
				</tr>
				
				<tr>
					<td colspan="5"> <input name="board_title" placeholder="제목을 입력하세요."> </td>
				</tr>
				
				<tr>	
					<td colspan="5">
						<textarea rows="20" cols="100" name="board_content" placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
				
				<tr>
					<td>
	 	 				<input class="form-control form-control-sm" id="formFileSm" name="board_image" type="file">
 	 				</td>	
				</tr>
				
				<tr>
					<td colspan="5" align="center">
						<input type="submit" value="작성"> &nbsp;
						<input type="reset" value="다시작성">
					</td> 
				</tr>
			
			</table>
		
		</form>
	
	</div>

</body>
</html>