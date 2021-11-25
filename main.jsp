<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
	   <hr width="65%" color="gray">
	      <h3>메인 페이지</h3>
	   <hr width="65%" color="gray">
	   <br> <br>
	   <a href="<%=request.getContextPath() %>/report_main.jsp">매출 현황</a>
	   <a href="<%=request.getContextPath() %>/shop_report.do">매장 매출보고</a>
	   <a href="<%=request.getContextPath() %>/shop_order.do">발주 입력</a>
	   <a href="<%=request.getContextPath() %>/shop/shop_order_check.jsp">발주 현황</a>
	   <a href="<%=request.getContextPath() %>/shop/shop_info.jsp">매장 정보</a>
	      
	</div>
	
</body>
</html>