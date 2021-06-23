<%--
  - 작성자: 심동현
  - 일자: 2015.05.19
  - 설명: 현대면세점 상품안내
  - IE10에서도 이미지 팝업 작동한다. 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<!DOCTYPE html>
<head>
<title>현대 면세점 이용 안내</title>

<!-- Magnific Popup core CSS file -->
<link rel="stylesheet" href="magnific-popup/magnific-popup.css"> 

<!-- jQuery 1.7.2+ or Zepto.js 1.0+ -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> 

<!-- Magnific Popup core JS file -->
<script src="magnific-popup/jquery.magnific-popup.js"></script>


<link rel="STYLESHEET" type="text/css" href="css/common.css">
<SCRIPT LANGUAGE="JavaScript"> 
$(document).ready(function() {

	$('.image-popup-vertical-fit').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		mainClass: 'mfp-img-mobile',
		image: {
			verticalFit: true
		}
		
	});
	$('.image-popup-fit-width').magnificPopup({
		type: 'image',
		closeOnContentClick: true,
		image: {
			verticalFit: false
		}
	});
	
});
</script> 
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td valign="top" align="center">
	

		<!-------- / center area -------->
<table cellpadding="0" cellspacing="0" border="0" width="932">
  <tr height="10"><td></td></tr>
  <tr>
		<td><!-- header -->
			<%@ include file="./hddf_topnav.jsp" %>
		</td>
  </tr>
  <tr height="30"><td></td></tr>
  <tr>
	<td><table cellpadding="0" cellspacing="0" border="0" width="932">
		  <tr>
		  	<td width="133" valign="top">
		  	<table width="133" cellpadding="0" cellspacing="0" border="0">
		  	  <tr>
		  	  	<td><a href="hddf_event.jsp"><img src="./imgs/sub_tit4.jpg" ></a></td>
		  	  </tr>
		  	  <tr height="20"><td></td></tr>
		  	  <tr height="21"><td><img src="./imgs/sub_tit41.jpg" ></td></tr>
		  	  <tr height="171"><td></td></tr>
		  	  
		  	  <tr>
		  	  	<td><a href="mailto:suno@hdasan.com" ><img src="./imgs/but4.jpg" ></a></td>
		  	  </tr>
		  	</table>
		  	</td>
		  	<td width="30"></td>
		  	<td valign="top" align="center">
		  	
			  	<table cellpadding="0" cellspacing="0" border="0">
			  	  <tr>
			  	  	<td width="300">
						<a title="Well Being" class="image-popup-fit-width" href="./imgs/ban_160127b.jpg">
							<img src="./imgs/ban_160127.jpg">
						</a>
			  	  	
			  	  	</td>
			  	  	<td width="30">&nbsp;</td>
			  	  	<td width="300">
						<a title="Brand SALE MISSHA 2015.12.12~31" class="image-popup-fit-width" href="./imgs/ban_151212b.jpg">
							<img src="./imgs/ban_151212.jpg">
						</a>

			  	  	</td>
			  	  </tr>
				  <tr>
				  	<td height="30" colspan="3"></td>
			  	  </tr>
			  	  <tr>
			  	  	<td width="300">
						<a title="Super Sale 2015.10.1~31" class="image-popup-fit-width" href="./imgs/ban_151031b.jpg">
							<img src="./imgs/ban_151031.jpg">
						</a>

			  	  	</td>
			  	  	<td width="30">&nbsp;</td>
			  	  	<td width="300">&nbsp;<!-- 
						<a title="Super Sale 2015.10.1~31" class="image-popup-fit-width" href="./imgs/ban_151031b.jpg">
							<img src="./imgs/ban_151031.jpg">
						</a> -->

			  	  	</td>
			  	  </tr>
			  	</table>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
</table> 





	<!-- footer -->
	<%@ include file="./hddf_footer.jsp" %>
	</td>
  </tr>
</table>


</body>
</html>