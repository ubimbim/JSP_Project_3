$(function() {
	
	// 여러 ajax에서 동일하게 사용되는 속성 설정
	$.ajaxSetup({
		// ajax에서 한글 깨짐 문제 해결
		ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		type : "post"
	});
	
	let code;
	
	// 선택된 발주코드에 맞는 데이터를 가져오는 함수
	function process(code) {
		$.ajax({
			// url : "/Project/admin_order_cont.do",
			url : "/Project/admin_order_cont.do?code="+code,
			datatype: "xml",
			success : function(data) {
				$("#listTable tr:gt(0)").remove();
				
				let table = "";
				
				$(data).find("orderconts").each(function() {
					table += "<tr>";
					table += "<th>매장코드</th>";
					table += "<td>"+$(this).find("order_code").text()+"</td>";
					table += "</tr>"
					table += "<tr>";
					table += "<th>매장이름</th>";
					table += "<td>"+$(this).find("shop_name").text()+"</td>";
					table += "</tr>"
					table += "<tr>";
					table += "<th>매장코드</th>";
					table += "<td>"+$(this).find("shop_id").text()+"</td>";
					table += "</tr>"
					table += "<tr>";
					table += "<th>제품</th>";
					table += "<td>"+$(this).find("pname").text()+"["+$(this).find("pnum")+"]"+"</td>";
					table += "</tr>"
					table += "<tr>";
					table += "<th>발주수량</th>";
					table += "<td><input type='number' name='cnt' min='1' max='100' value='1'>"+$(this).find("order_no").text()+"</td>";
					table += "</tr>"
					table += "<tr>";
					table += "<th>발주날짜</th>";
					table += "<td>"+$(this).find("order_date").text()+"</td>";
					table += "</tr>";
					table += "<tr>"
					table += "<td><input type='button' value='수정'>"+"</td>";
					table += "</tr>";
				});
				
				$("#listTable tr:eq(0)").after(table);	
			},
			error : function() {
				alert('통신 에러 발생');
			}
		})
	}

 	
});