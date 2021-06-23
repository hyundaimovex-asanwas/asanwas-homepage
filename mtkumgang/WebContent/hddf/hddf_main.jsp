<%--
  - 작성자: 심동현
  - 일자: 2015.05.19
  - 설명: 현대면세점 상품안내
  - 문서: euc-kr
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>

<title>현대 면세점 이용 안내</title>
<link rel="STYLESHEET" type="text/css" href="css/common.css">
<style type="text/css">
<!--
	html,body { width:100%; height: 100%;}
	.container {
		width:100%;
		height:100%;
		margin: 0px auto;
		background: #fff; 
	}
	.outer {
		display: table;
		width: 100%;
		height: 100%;
	}
	.inner {
		display: table-cell;
		vertical-align: middle;	/* 요소의 수직정렬 : ie10에선 안됨.. 크롬은 정상*/
		text-align: center;		/* 요소의 수평정렬*/
	}
	.centered {
		position: relative;
		display: inline-block;
		
		width: 932px;
		padding: 0em;
		background: #fff;
		color: #666;
	}
	.positioned-absolutely {
	  position: absolute;
	  width: 240px;
	  height:365px;
	  top: 100px;
	  right: 2em;	/* Device의 body 폰트 사이즈 = 1em(대문자1개) 오오옹..가독성 확보의 새 단위냐!*/
	  background: #00f;
	  color: #fff;
	  font-size:12px;
	  padding: 0em;
	  visibility: hidden;
	}
-->
</style>

<script>

function checkPop(){
	cookiedata = document.cookie; 
	
	if ( cookiedata.indexOf("layer_pop1=done") < 0 ){
		document.all['layer_pop1'].style.visibility = "visible";	//visible
	} else {
		document.all['layer_pop1'].style.visibility = "hidden";  
	}
}

function closeLayerPopup(a) {
	//if (document.getElementById("layerForm"+a).chkbox.checked){ 
	setCookie("layer_pop"+a, "done", 1); 
	document.all['layer_pop'+a].style.visibility = "hidden";
}


function setCookie(name, value, expiredays) { 

	var endDate = new Date();
	endDate.setDate( endDate.getDate()+ expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + endDate.toGMTString() + ";"
}
	
</script>
</head>
<body onload="checkPop()">


<div class="container">
	<div class="outer">
		<div class="inner">
			<div class="centered">

	<table cellpadding="0" cellspacing="0" border="0" width="932">
	  <tr height="10"><td></td></tr>
	  <tr>
		<td><!-- header -->
			<%@ include file="./hddf_topnav.jsp" %>
		</td>
	  </tr>
	  <tr height="30"><td></td></tr>
	  <tr>
		<td><img src="./imgs/main_ban1.jpg" >
		</td>
	  </tr>
	  <tr height="32"><td></td></tr>	  
	  <tr>
		<td align="center"><img src="./imgs/main_txt1.gif" ></td>
	  </tr>
	</table>
	<!-- footer -->
	<%@ include file="./hddf_footer.jsp" %>
				
		        
		        <div class="positioned-absolutely" id="layer_pop1"><img src="./imgs/ban_ings.jpg" ><br>
		        	<span style="cursor:pointer;" onclick="javascript:closeLayerPopup(1);">하루 동안 안 보기</span>
		        </div>
				
			</div>
		</div>
	</div>
</div>

</body>
</html>