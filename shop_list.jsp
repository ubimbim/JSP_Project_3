<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div align="center">
      <hr width="100%" color="gold">
         <h3>매장 재고 관리 </h3>
      <hr width="100%" color="red">
      <br><br>
      
      
	<form method="post" 
		action="<%=request.getContextPath() %>/shop_order.do">
      <table border="1" cellspacing="0" width="40%">
         <tr bgcolor="#CCEEFF">
            <th>지  점</th> <th>상품 코드</th> <th>발주 수량</th> <th>발주 날짜</th> <th>발주요청</th> <th>발주</th>
         </tr>
         
         <c:set var="list" value="${shopList }" />
         <c:if test="${!empty list }">
            <c:forEach items="${list }" var="dto">
               <tr align="center">
                  <td> ${dto.getShop_id() } </td>
                  <td> ${dto.getPnum() } </td>
                  <td> <input type="number" name="order_no" min="0" max="50" value="${dto.getOrder_no() }"> </td>
                  <td> ${dto.getOrder_date() }</td>
                  <td> ${dto.getOrder_check() }</td>
                  <td colspan="1" align="center">
                   	<input type="submit" value="발주">
                  </td>
               </tr>
               
               
            </c:forEach>
         </c:if>

   
         <c:if test="${empty list }">
            <tr>
               <td colspan="6" align="center">
                  <h3>등록된 상품이 없습니다.....</h3>
               </td>
            </tr>
         </c:if>
      
      </table>
     </form>
   </div>
   
   

</body>
</html>