<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}
td,tr {
		padding : 10px;
	}
	tr th {
		text-align: center;
		background: #EEEEEE;
		font-family: 'Gothic A1', sans-serif;
	}

</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="../include/admin_top.jsp" />
	
	<div align="center">
	      <h2>상품 수정</h2>
	   <br>
	   
	   <form method="post" enctype="multipart/form-data"
	      action="<%=request.getContextPath() %>/admin_product_update_ok.do">
	      <c:set var="dto" value="${productDto}" />
	 
	      
	      <table  border="0" cellspacing="0" width="800"> 
	            
	          <tr>
	            <th>상품 이미지</th>
	            <td>
	               <img src="<%=request.getContextPath() %>/upload/${dto.getPimage() }"
	               		width="100" height="100">
	               <input type="file" name="pimage_New">
	               <%-- 이미지를 수정하지 않고 그대로 사용할 경우에는
	                                     상품 등록시 입력한 이미지를 그대로 사용하여 히든으로 넘겨줄 예정. --%>
	               <input type="hidden" name="pimage_Old"
	                      value="${dto.getPimage() }">
	            </td>
	         </tr>
	         
	         <tr>
	            <th>상품 번호</th>
	            <td> <input name="pnum"
	                      value="${dto.getPnum() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>상품이름</th>
	            <td> <input name="pname"
	                     value="${dto.getPname() }"> </td>
	         </tr>
	                  
	         
	         <tr>
	            <th>상품 가격</th>
	            <td> <input name="price" maxlength="8"
	                      value="${dto.getPrice() }"> </td>
	         </tr>
	         
	         <tr>
	            <th>상품 정보</th>
	            <td> <textarea name = "pcont" rows="5" cols="50">${dto.getPcont() }</textarea> </td>
	         </tr>
	         
	         
	         <tr>
	            <td colspan="2" align="center">
	               <input class="btn btn-outline-secondary" type="submit" value="상품수정">&nbsp;&nbsp;&nbsp;
	               <input class="btn btn-outline-secondary" type="reset" value="다시작성">
	            </td>
	         </tr>
	      
	      </table>
	   
	   
	   </form>
	
	</div>

<jsp:include page="../include/shop_bottom.jsp" />
</body>
</html>