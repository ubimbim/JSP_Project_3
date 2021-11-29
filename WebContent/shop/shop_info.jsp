<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>지도 이동시키기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

body{
font-family: 'Nanum Gothic', sans-serif;
}

#menu {
	height : 40px;
	width : 850px;
	margin-left : auto;
	margin-right : auto;
	
}

#menu ul li {
	list-style : none;
	color: #4F4F4F;
	background-color : white;
	float:left;
	line-height:35px;
	vertical-align:middle;
	text-align:center;
}

#menu .menuLink {
	text-decoration: none;
	color: #4F4F4F;
	display: block;
	width: 150px;
	font-size:15px;
	font-weight: bold;
	
	
}

#shopname {
	font-size:30px;
	font-weight: bold;
}

#title {
	font-size:20px;
	font-weight: bold;
}
</style>
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />

<div id = "menu" align="center">
	<ul>
		<li><a class="menuLink" onclick="garosu()">Apple 가로수길</a></li>
		<li><a class="menuLink" onclick="gimpo()">윌리스 김포공항</a></li>
		<li><a class="menuLink" onclick="hongdae()">프리스비 홍대</a></li>
		<li><a class="menuLink" onclick="incheon()">윌리스 인천터미널점</a></li>
		<li><a class="menuLink" onclick="yeouido()">Apple 여의도</a></li>
	</ul>
</div>

<div align="center">
<hr color="lightgray" width = "50%">
<p id="shopname">Apple 가로수길</p>
<div id="info" align="center">
<p><img src="../images/location.png" width="18" height="18"> 서울 강남구 가로수길 43 (우)06028</p>
<p><img src="../images/time.png" width="18" height="18"> 10:00 ~ 22:00</p>
<p><img src="../images/phone.png" width="18" height="18"> 080-500-0029</p>
<p><img src="../images/man.png" width="18" height="18"> 담당자 : 표은비</p>
</div><br>
<hr color="lightgray" style="width:550px;"><br>
<div id="map" style="width:500px; height:400px;"></div>
</div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4285c890083d1f612cc44cfdd5d0dc4f"></script>
<script>
	let container = document.getElementById('map');
	let options = {
		center: new kakao.maps.LatLng(37.52081891686327, 127.02272035982348),
		level: 3
	};
		
	let garosuinfo = "<p><img src='../images/location.png' width='18' height='18'> 서울 강남구 가로수길 43 (우)06028</p>"
					+"<p><img src='../images/time.png' width='18' height='18'> 10:00 ~ 22:00</p>"
					+"<p><img src='../images/phone.png' width='18' height='18'> 080-500-0029</p>"
					+"<p><img src='../images/man.png' width='18' height='18'> 담당 매니저 : 표은비</p>";

	let yeouidoinfo = "<p><img src='../images/location.png' width='18' height='18'> 서울 영등포구 국제금융로 10 IFC몰 지하 1층 (우)07326</p>"
					+"<p><img src='../images/time.png' width='18' height='18'> 10:00 ~ 22:00</p>"
					+"<p><img src='../images/phone.png' width='18' height='18'> 080-500-0013</p>"
					+"<p><img src='../images/man.png' width='18' height='18'> 담당 매니저 : 표은비</p>"

	let hongdaeinfo = "<p><img src='../images/location.png' width='18' height='18'> 서울 마포구 홍익로 11 (우)04040</p>"
					+"<p><img src='../images/time.png' width='18' height='18'> 11:00 ~ 21:00</p>"
					+"<p><img src='../images/phone.png' width='18' height='18'> 02-323-1765</p>"
					+"<p><img src='../images/man.png' width='18' height='18'> 담당 매니저 : 이도엽</p>"

	let gimpoinfo = "<p><img src='../images/location.png' width='18' height='18'> 서울 강서구 하늘길 38 롯데몰 MF층 롯데하이마트 내 (우)07505</p>"
					+"<p><img src='../images/time.png' width='18' height='18'> 10:30 ~ 21:00</p>"
					+"<p><img src='../images/phone.png' width='18' height='18'> 02-6116-1700</p>"
					+"<p><img src='../images/man.png' width='18' height='18'> 담당 매니저 : 이유빈</p>"

	let incheoninfo = "<p><img src='../images/location.png' width='18' height='18'> 인천 미추홀구 관교동 15 지하1층</p>"
					+"<p><img src='../images/time.png' width='18' height='18'> 10:30 ~ 21:00</p>"
					+"<p><img src='../images/phone.png' width='18' height='18'> 032-242-2710</p>"
					+"<p><img src='../images/man.png' width='18' height='18'> 담당 매니저 : 이영훈</p>"

// yeouido : 37.525100134561754, 126.92588452406844
//				서울 영등포구 국제금융로 10 IFC몰 지하 1층 (우)07326
//				10:00 ~ 22:00
//				080-500-0013
// hongdae : 37.55350248354633, 126.92326480411504
//				서울 마포구 홍익로 11 (우)04040
//				11:00 ~ 21:00
//				02-323-1765
// gimpo : 37.56318424549044, 126.80318825591408
//				서울 강서구 하늘길 38 롯데몰 MF층 롯데하이마트 내 (우)07505
//				10:30 ~ 21:00
//				02-6116-1700
// incheon : 37.44150644089625, 126.70136555595195
//				인천 미추홀구 관교동 15 지하1층
//				10:30 ~ 21:00
//				032-242-2710
// 지도를 클릭한 위치에 표출할 마커입니다

		let map = new kakao.maps.Map(container, options);
		let marker = new kakao.maps.Marker({ 
		    position: map.getCenter() 
		}); 
		marker.setMap(map);	
		
function yeouido() {            
	
	document.getElementById("shopname").innerHTML = "Apple 여의도점";
	document.getElementById("info").innerHTML
	= yeouidoinfo
	
	let moveLatLon = new kakao.maps.LatLng(37.525100134561754, 126.92588452406844);
		    
	map.setCenter(moveLatLon);
	let marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);	
}

function gimpo() {            
	
	document.getElementById("shopname").innerHTML = "윌리스 김포공항";
	document.getElementById("info").innerHTML
	= gimpoinfo
	
	// 이동할 위도 경도 위치를 생성합니다 
	let moveLatLon = new kakao.maps.LatLng(37.56318424549044, 126.80318825591408);
		    
	map.setCenter(moveLatLon);
	let marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);	
}

function garosu() {            

	document.getElementById("shopname").innerHTML = "Apple 가로수길";
	document.getElementById("info").innerHTML
	= garosuinfo
	
	// 이동할 위도 경도 위치를 생성합니다 
	let moveLatLon = new kakao.maps.LatLng(37.52081891686327, 127.02272035982348);
		    
	map.setCenter(moveLatLon);
	let marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);	
}

function hongdae() {            

	document.getElementById("shopname").innerHTML = "프리스비 홍대";
	document.getElementById("info").innerHTML
	= hongdaeinfo
	
	// 이동할 위도 경도 위치를 생성합니다 
	let moveLatLon = new kakao.maps.LatLng(37.55350248354633, 126.92326480411504);
	
	map.setCenter(moveLatLon);
	let marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);	
}

function incheon() {            

	document.getElementById("shopname").innerHTML = "윌리스 인천터미널점";
	document.getElementById("info").innerHTML
	= incheoninfo
	
	// 이동할 위도 경도 위치를 생성합니다 
	let moveLatLon = new kakao.maps.LatLng(37.44150644089625, 126.70136555595195);
		    
	map.setCenter(moveLatLon);
	let marker = new kakao.maps.Marker({ 
	    position: map.getCenter() 
	}); 
	marker.setMap(map);	
}


</script>



</body>
</html>