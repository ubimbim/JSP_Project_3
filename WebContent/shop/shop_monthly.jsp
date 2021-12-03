<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap');
body {
  font-family: 'Noto Sans KR', sans-serif;
}
#container1 {
    width:100%;
    display:flex; flex-flow:row wrap;
    grid-template-columns: 3fr 1fr 1fr 1fr ; 
}
#container2 {
    width:100%;
    display:flex; flex-flow:row wrap;
    grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr; 
}
.item { padding: 8px;  }
</style>	
</head>
<body>

	<jsp:include page="../include/shop_top.jsp" />
<c:set var="month" value="${monthlabel}" />	
<div id="container1">
<div class="item">
	<form method="post" 
			action="<%=request.getContextPath() %>/shop_monthly_check.do">
	<input type="month" id="month" name="month">
	<button type="submit">Check</button>
	</form>
<canvas id="shopsales" width="900" height="250"></canvas>
</div>
<div class="item">
<h4>Apple 가로수길	</h4><br>
<table width="230">
	<tr>
		<td> ${month[0] } 매출</td>
		<td> ${galasttotal} 원</td>
	</tr>
	<tr>
		<td> ${month[1] } 매출</td>
		<td> ${gathistotal} 원</td>
	</tr>
	<tr>
		<td> 전월대비 </td>
		<td>
		 ${gathistotal-galasttotal} 원</td>
	</tr>
	<tr>
		<td> (%) </td>
		<td id="check"> 
		<fmt:formatNumber value="${(gathistotal-galasttotal)/galasttotal*100}" pattern=".00"/>%</td>
	</tr>
</table>
</div>
<div class="item">
	<canvas id="gashopsales"width="250" height="250"></canvas>
</div>
<div class="item">
<c:set var="gamonthlysaleslist" value="${gamonthlysaleslist}" />
<c:set var="galasttotal" value="${galasttotal}" />	
<c:set var="gathistotal" value="${gathistotal}" />
<canvas id="gamonthsales" width="400" height="250"></canvas>
</div>
</div>
<div id="container2">
<div class="item">
<h4>윌리스 김포공항	</h4>
<table width="230">
	<tr>
		<td> ${month[0] } 매출</td>
		<td> ${gilasttotal} 원</td>
	</tr>
	<tr>
		<td> ${month[1] } 매출</td>
		<td> ${githistotal} 원</td>
	</tr>
	<tr>
		<td> 전월대비 </td>
		<td>
		 ${githistotal-gilasttotal} 원</td>
	</tr>
	<tr>
		<td> (%) </td>
		<td><fmt:formatNumber value="${(githistotal-gilasttotal)/gilasttotal*100}" pattern=".00"/>%</td>
	</tr>
</table>
</div>	
<div class="item">
	<canvas id="gishopsales"width="250" height="250"></canvas>
</div>
<div class="item">
<c:set var="gimonthlysaleslist" value="${gimonthlysaleslist}" />
<c:set var="gilasttotal" value="${gilasttotal}" />	
<c:set var="githistotal" value="${githistotal}" />
<canvas id="gimonthsales" width="400" height="250"></canvas>
</div>
<div class="item">
<h4>프리스비 홍대점	</h4>
<table width="230">
	<tr>
		<td> ${month[0] } 매출</td>
		<td> ${holasttotal} 원</td>
	</tr>
	<tr>
		<td> ${month[1] } 매출</td>
		<td> ${hothistotal} 원</td>
	</tr>
	<tr>
		<td> 전월대비 </td>
		<td>
		 ${hothistotal-holasttotal} 원</td>
	</tr>
	<tr>
		<td> (%) </td>
		<td><fmt:formatNumber value="${(hothistotal-holasttotal)/holasttotal*100}" pattern=".00"/>%</td>
	</tr>
</table>
</div>	
<div class="item">
	<canvas id="hoshopsales"width="250" height="250"></canvas>
</div>
<div class="item">
<c:set var="homonthlysaleslist" value="${homonthlysaleslist}" />
<c:set var="holasttotal" value="${holasttotal}" />	
<c:set var="hothistotal" value="${hothistotal}" />
<canvas id="homonthsales" width="400" height="250"></canvas>
</div>
</div>
<div id="container2">
<div class="item">
<h4>윌리스 인천터미널점	</h4>
<table width="230">
	<tr>
		<td> ${month[0] } 매출</td>
		<td> ${inlasttotal} 원</td>
	</tr>
	<tr>
		<td> ${month[1] } 매출</td>
		<td> ${inthistotal} 원</td>
	</tr>
	<tr>
		<td> 전월대비 </td>
		<td>
		 ${inthistotal-inlasttotal} 원</td>
	</tr>
	<tr>
		<td> (%) </td>
		<td><fmt:formatNumber value="${(inthistotal-inlasttotal)/inlasttotal*100}" pattern=".00"/>%</td>
	</tr>
</table>
</div>	

<div class="item">
	<canvas id="inshopsales"width="250" height="250"></canvas>
</div>
<div class="item">
<c:set var="inmonthlysaleslist" value="${inmonthlysaleslist}" />
<c:set var="inlasttotal" value="${inlasttotal}" />	
<c:set var="inthistotal" value="${inthistotal}" />
<canvas id="inmonthsales" width="400" height="250"></canvas>
</div>

<div class="item">
<h4>Apple 여의도 점	</h4>
<table width="230">
	<tr>
		<td> ${month[0] } 매출</td>
		<td> ${yelasttotal} 원</td>
	</tr>
	<tr>
		<td> ${month[1] } 매출</td>
		<td> ${yethistotal} 원</td>
	</tr>
	<tr>
		<td> 전월대비 </td>
		<td>
		 ${yethistotal-yelasttotal} 원</td>
	</tr>
	<tr>
		<td> (%) </td>
		<td><fmt:formatNumber value="${(yethistotal-yelasttotal)/yelasttotal*100}" pattern=".00"/>%</td>
	</tr>
</table>
</div>	
<div class="item">
	<canvas id="yeshopsales"width="250" height="250"></canvas>
</div>
<div class="item">
<c:set var="yemonthlysaleslist" value="${yemonthlysaleslist}" />
<c:set var="yelasttotal" value="${yelasttotal}" />	
<c:set var="yethistotal" value="${yethistotal}" />
<canvas id="yemonthsales" width="400" height="250"></canvas>
</div>

</div>
<script>
/* <h4>Apple 가로수길	</h4>
<h4>윌리스 김포공항	</h4>
<h4>프리스비 홍대점	</h4>
<h4>윌리스 인천터미널점	</h4>
<h4>Apple 여의도 점	</h4> */

document.getElementById('month').value= new Date().toISOString().slice(0, 7);

let label=[];
<c:forEach items="${month}" var="month">
label.push('${month}');
</c:forEach>

// garosu
const garosu = document.getElementById('gashopsales');
const garosuChart = new Chart(garosu, {
    type: 'bar',
    data: {
        labels: label,
        datasets: [{
            data: [${galasttotal}, ${gathistotal}],
            backgroundColor: [
            	'rgba(211,211,211)',
            	'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
            	'rgb(169,169,169)',
            	 'rgb(255, 99, 132)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: false
        },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let gamonthList=[];
<c:forEach var="i" items="${gamonthlysaleslist}">
gamonthList.push('${i.key}');
</c:forEach>
let gamonthData=[];
<c:forEach var="i" items="${gamonthlysaleslist}">
gamonthData.push('${i.value}');
</c:forEach>
const gal = document.getElementById('gamonthsales');
const galine = new Chart(gal, {
		  type: 'line',
		  data: {
			  labels: gamonthList,
			  datasets: [
			    {
			      label: label[1],
			      data: gamonthData,
			      borderColor: 'rgba(255, 99, 132, 0.2)',
			      backgroundColor: 'rgba(255, 99, 132, 0.2)',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
//garosu end

//gimpo
const gimpo = document.getElementById('gishopsales');
const gimpoChart = new Chart(gimpo, {
    type: 'bar',
    data: {
        labels: label,
        datasets: [{
            data: [${gilasttotal}, ${githistotal}],
            backgroundColor: [
            	'rgba(211,211,211)',
            	'rgba(255, 205, 86, 0.2)'
            ],
            borderColor: [
            	'rgb(169,169,169)',
            	 'rgb(255, 205, 86)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: false
        },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let gimonthList=[];
<c:forEach var="i" items="${gimonthlysaleslist}">
gimonthList.push('${i.key}');
</c:forEach>
let gimonthData=[];
<c:forEach var="i" items="${gimonthlysaleslist}">
gimonthData.push('${i.value}');
</c:forEach>

const gimpol = document.getElementById('gimonthsales');
const gimpoline = new Chart(gimpol, {
		  type: 'line',
		  data: {
			  labels: gimonthList,
			  datasets: [
			    {
			      data: gimonthData,
			      borderColor: 'rgba(255, 205, 86)',
			      backgroundColor: 'rgba(255, 205, 86, 0.2)',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
//gimpo end

// hongdae
const hongdae = document.getElementById('hoshopsales');
const hongdaeChart = new Chart(hongdae, {
    type: 'bar',
    data: {
        labels: label,
        datasets: [{
            data: [${holasttotal}, ${hothistotal}],
            backgroundColor: [
            	'rgba(211,211,211)',
            	'rgba(75, 192, 192, 0.2)'
            ],
            borderColor: [
            	'rgb(169,169,169)',
            	 'rgb(75, 192, 192)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: false
        },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let homonthList=[];
<c:forEach var="i" items="${homonthlysaleslist}">
homonthList.push('${i.key}');
</c:forEach>
let homonthData=[];
<c:forEach var="i" items="${homonthlysaleslist}">
homonthData.push('${i.value}');
</c:forEach>
const hol = document.getElementById('homonthsales');
const holine = new Chart(hol, {
		  type: 'line',
		  data: {
			  labels: homonthList,
			  datasets: [
			    {
			      label: label[1],
			      data: homonthData,
			      borderColor: 'rgba(75, 192, 192)',
			      backgroundColor: 'rgba(75, 192, 192, 0.2)',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
//hongdae end

// incheon
const incheon = document.getElementById('inshopsales');
const incheonChart = new Chart(incheon, {
    type: 'bar',
    data: {
        labels: label,
        datasets: [{
            data: [${inlasttotal}, ${inthistotal}],
            backgroundColor: [
            	'rgba(211,211,211)',
            	'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
            	'rgb(169,169,169)',
            	 'rgb(54, 162, 235)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: false
        },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let inmonthList=[];
<c:forEach var="i" items="${inmonthlysaleslist}">
inmonthList.push('${i.key}');
</c:forEach>
let inmonthData=[];
<c:forEach var="i" items="${inmonthlysaleslist}">
inmonthData.push('${i.value}');
</c:forEach>
const inl = document.getElementById('inmonthsales');
const inline = new Chart(inl, {
		  type: 'line',
		  data: {
			  labels: inmonthList,
			  datasets: [
			    {
			      label: label[1],
			      data: inmonthData,
			      borderColor: 'rgba(54, 162, 235)',
			      backgroundColor: 'rgba(54, 162, 235, 0.2)',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
//incheon end

// yeouido
const yeouido = document.getElementById('yeshopsales');
const yeouidoChart = new Chart(yeouido, {
    type: 'bar',
    data: {
        labels: label,
        datasets: [{
            data: [${yelasttotal}, ${yethistotal}],
            backgroundColor: [
            	'rgba(211,211,211)',
            	'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
            	'rgb(169,169,169)',
            	 'rgb(153, 102, 255)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
            display: false
        },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

let yemonthList=[];
<c:forEach var="i" items="${yemonthlysaleslist}">
yemonthList.push('${i.key}');
</c:forEach>
let yemonthData=[];
<c:forEach var="i" items="${yemonthlysaleslist}">
yemonthData.push('${i.value}');
</c:forEach>
const yel = document.getElementById('yemonthsales');
const yeline = new Chart(yel, {
		  type: 'line',
		  data: {
			  labels: yemonthList,
			  datasets: [
			    {
			      label: label[1],
			      data: yemonthData,
			      borderColor: 'rgba(153, 102, 255)',
			      backgroundColor: 'rgba(153, 102, 255, 0.2)',
			      fill: 'start'
			    }
			  ]
			},
		  options: {
				legend: {
			        display: false
			    },
			responsive: false,
		  },
		});
//yeouido end

// shop monthly sales
let shopdata=[];
<c:set var="sales" value="${shopsales}" />
<c:forEach items="${sales}" var="sales">
shopdata.push('${sales}');
</c:forEach>
const ctx = document.getElementById('shopsales');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['GAROSU', 'GIMPO', 'HONGDAE', 'INCHEON', 'YEOUIDO'],
        datasets: [{
            data: [${gathistotal},${githistotal},${hothistotal},${inthistotal},${yethistotal}],
            backgroundColor: [
            	'rgba(255, 99, 132, 0.2)',
                'rgba(255, 205, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
            	 'rgb(255, 99, 132)',
                 'rgb(255, 205, 86)',
                 'rgb(75, 192, 192)',
                 'rgb(54, 162, 235)',
                 'rgb(153, 102, 255)'
            ],
            borderWidth: 1
        }]
    },
    options: {
    	legend: {
	        display: false
	    },
    	responsive: false,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
// monthly shop sales end
</script>
</body>
</html>