<%--
  - 작성자: 심동현
  - 일자: 2015.05.19
  - 설명: 현대면세점 상품안내
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>현대 면세점 이용 안내</title>
<link rel="STYLESHEET" type="text/css" href="css/common.css">
<script langage="JavaScript">

</script>
<style type="text/css">
<!--
	html,body { width:100%; height: 100%; }
	.container {
		width:70%;
		height:70%;
		margin: 40px auto;
		background: red;
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
		
		width: 50%;
		padding: 1em;
		background: orange;
		color: white;
	}
	.positioned-absolutely {
	  position: absolute;
	  top: -2em;
	  right: -2em;	/* Device의 body 폰트 사이즈 = 1em(대문자1개) 오오옹..가독성 확보의 새 단위냐!*/
	  background: #00f;
	  padding: 1em;
	}
-->
</style>
</head>

<body>

<div class="container">
	<div class="outer">
		<div class="inner">
			<div class="centered">
		        <p>
		          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam assumenda blanditiis.
		        </p>
		        <div class="positioned-absolutely">나나</div>
				
			</div>
		</div>
	</div>
</div>
<table width="100%" cellpadding="0" cellspacing="0" border="1">
<tr>
	<td valign="top" align="center">
	
	<!-- / content  -->
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
	</td>
  </tr>
</table>

</body>
</html>