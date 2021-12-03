<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

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
	
		<c:set var="dto" value="${Cont }" />
	
		<div class="notice">
			공지사항 작성
		</div>
		
		<hr color="#000000" width="900" size="3">
		
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/admin_board_updateOk.do">
		
			<input type="hidden" name="board_no" value="${dto.getBoard_no() }">
			<input type="hidden" name="board_page" value="${Page }">
			
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
								<c:if test="${dto.getBoard_code() == '공지' }">
									<%-- 공지를 클릭한 경우 String board_code = "notice"; --%>
									<option value="공지" selected>공지</option>
									<option value="이슈">이슈</option>
									<option value="행사">행사</option>
								</c:if>
								
								<c:if test="${dto.getBoard_code() == '이슈' }">
									<%-- 이슈를 클릭한 경우 String board_code = "issue"; --%>
									<option value="공지">공지</option>
									<option value="이슈" selected>이슈</option>
									<option value="행사">행사</option>
								</c:if>
								
								<c:if test="${dto.getBoard_code() == '행사' }">
									<%-- 행사를 클릭한 경우 String board_code = "promotion"; --%>
									<option value="공지">공지</option>
									<option value="이슈">이슈</option>
									<option value="행사" selected>행사</option>
								</c:if>
							</select>
						</td>
					</tr>
					
					<tr>
						<th scope="row">제목</th>
						<td>
							<input class="form-control" name="board_title" type="text" value="${dto.getBoard_title() }" aria-label="default input example">
						</td>
					</tr>
					
					<tr>	
						<th scope="row">내용</th>	
						<td>
							<textarea class="form-control" id="exampleFormControlTextarea1" rows="25" name="board_content">${dto.getBoard_cont() }</textarea>
					</tr>
					
					<tr>
						<th>첨부파일</th>
						<td>
							기존 첨부파일 [${dto.getBoard_image() }] <br>
		 	 				<input class="form-control form-control-sm" id="formFileSm" type="file" name="board_image_New">
		 	 				<input type="hidden" name="board_image_Old" value="${dto.getBoard_image() }">
	 	 				</td>
					</tr>
				</tbody>
				
				<tfoot>
					<tr>
						<td colspan="2" align="center">
							<input type="button" value="취소" class="btn btn-outline-dark btn-sm" onclick="location.href='admin_board_list.do?page=1'">
							<input type="submit" value="수정" class="btn btn-outline-dark btn-sm">
						</td>
					</tr>
				</tfoot>
			
			</table>
		
		</form>
	
	</div>

</body>
</html>