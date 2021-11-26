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
		&nbsp;&nbsp;&nbsp;
	      <h2>상품 수정</h2>
	      
	   <br>
	   
	   <form method="post" enctype="multipart/form-data"
	      action="<%=request.getContextPath() %>/admin_product_update_ok.do">
	      <c:set var="dto" value="${productDto}" />
	 
	      
	      <table bgcolor="E0E0E0" border="1" cellspacing="0" width="500"> 
	            
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
	            <th>상품 번호 </th>
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
	            <td colspan="2" align="center">
	               <input type="submit" value="상품수정">&nbsp;&nbsp;&nbsp;
	               <input type="reset" value="다시작성">
	            </td>
	         </tr>
	      
	      </table>
	   
	   
	   </form>
	
	</div>
	
<jsp:include page="../include/shop_bottom.jsp" />

</body>
</html>