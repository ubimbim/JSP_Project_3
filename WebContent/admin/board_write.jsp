<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	div.notice {
		width: 900px;
		height: 30px;
		font-size: 20px;
		font-weight: bold;
		font-family: 'Gotdic A1', sans-serif;
		text-align: left;
		margin-top: 50px;
		margin-bottom: 20px;
	}

	tr {
		height: 80px;
	}
	
</style>
</head>
<body>

	<jsp:include page="../include/admin_top.jsp" />

	<div align="center">
		
		<div class="notice">
			공지사항 작성
		</div>
		
		<hr color="#000000" width="900" size="3">
		
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin_board_writeOk.do">
		
			<table border="0" cellspacing="0" width="900">
			
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			
			<tbody>
				<tr>
					<th scope="row">카테고리</th>
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
				</tr>
				
				<tr>
					<th scope="row">제목</th>
					<td>
						<input class="form-control" name="board_title" type="text" placeholder="제목을 입력하세요." aria-label="default input example">
					</td>
				</tr>
				
				<tr>
					<th scope="row">내용</th>	
					<td>
						<textarea class="form-control" id="exampleFormControlTextarea1" rows="25" name="board_content" placeholder="내용을 입력하세요."></textarea>
					</td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td>
	 	 				<input class="form-control form-control-sm" id="formFileSm" type="file">
 	 				</td>	
				</tr>
				
				<tr>
					<td colspan="2"> <hr color="#000000" width="900" size="3"> </td>
				</tr>
				
				<tfoot>
					<tr>
						<td colspan="2" align="center">
							<input type="button" value="취소" class="btn btn-outline-dark btn-sm" onclick="location.href='admin_board_list.do?page=1'">
							<input type="submit" value="작성" class="btn btn-outline-dark btn-sm">
						</td>
					</tr>
				</tfoot>
			</tbody>
			
			</table>
		
		</form>
	
	</div>

</body>
</html>