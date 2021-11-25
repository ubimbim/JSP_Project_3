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
	   <a href="<%=request.getContextPath() %>/shop_summary.do">전체 매장 매출</a>
	   <a href="<%=request.getContextPath() %>/shop_report.do">매장별 매출</a>
	</div>
</body>
</html>