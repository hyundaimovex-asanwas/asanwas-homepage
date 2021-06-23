<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
  String McNum = "0"; 
  String sub = "0"; 
%>  
<html> 
<head> 
<title> 금강산관광 </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script>
function go_MusicDown() {
	<%if(session_id.equals("")){%>
		alert("로그인 후 이용해 주시기 바랍니다.");
	<%} else {%>
		window.open("http://credin.co.kr/credin/ad/hyundai-asan_0/");
	<%}%>
}

</script>
<script language="javascript">

function familyPop(val)
{
   if(val !=""){
          window.open(val,"family");
   }
}


//팝업띄우는 펑션
function checkPopup()
{

//	if(getCookie("091230") != "done" ) {		// 불러온 쿠키의 값이 "done"이 아니면~
//		showNyAD();
//	}

	
//	if(getCookie("mt100121") != "done" )		// 불러온 쿠키의 값이 "done"이 아니면~
//	{																	
// 		window.open("/popup/pop100121.jsp","mt100121"," width=380, height=255, top=10, left=10, scrollbars=no");
//	}
	


}	//펑션블럭 끝


function getCookie( name )
{
        var nameOfCookie = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
                var y = (x+nameOfCookie.length);
                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                endOfCookie = document.cookie.length;
                        return unescape( document.cookie.substring( y, endOfCookie ) );
                }
                x = document.cookie.indexOf( " ", x ) + 1;
                if ( x == 0 )
                        break;
        }
        return "";
}

function setCookie(name, value, expiredays) { 

	var endDate = new Date();
	endDate.setDate( endDate.getDate()+ expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + endDate.toGMTString() + ";"
}


</script>

 <script language="javascript">
		<!--
			function na_open_window(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable)
			{
			  toolbar_str = toolbar ? 'yes' : 'no';
			  menubar_str = menubar ? 'yes' : 'no';
			  statusbar_str = statusbar ? 'yes' : 'no';
			  scrollbar_str = scrollbar ? 'yes' : 'no';
			  resizable_str = resizable ? 'yes' : 'no';
			  window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
			}
		// -->
		
function notice_getCookie( name )
{
        var nameOfCookie = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
   
                var y = (x+nameOfCookie.length);
    
                if ( document.cookie.substring( x, y ) == nameOfCookie ) {
                        if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                                endOfCookie = document.cookie.length;
    
                        return unescape( document.cookie.substring( y, endOfCookie ) );
                }
    
                x = document.cookie.indexOf( " ", x ) + 1;
                if ( x == 0 )
                        break;
        }
        return "";
}



//function open_popup(){
	
// if (notice_getCookie("popnew")!= "NOPOPnew"){
//  na_open_window('mainpop', '/popup/plzpop.jsp', 10, 10, 401, 501, 0, 0, 0, 0, 0);
// }

//}

</script>

<style type="text/css">

</style></head>

<body onload="checkPopup()">

<!-- 레이어팝업  관광장기중단화 HNJ_20110627추가 -->
<div id='layer_pop1' style='position:absolute; left:55px; top:110px; width:141px; height:112px;border:0px solid #cccccc; background-color:#ffffff; visibility:hidden; z-index:1000000;'>
<table width="141" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="2">
	<img src="../popimgs/20110624_notice.jpg" width="287" height="333" border="0" /></a></td>
  </tr>
  <tr>
    <td width="20" height="20" bgcolor="#c8e6ff" >
		<form name="layerForm1" style="display:inline;margin:0px;">
		<input type="checkbox" name="chkbox" id="chkbox" onfocus='this.blur()'  />
		</form>
	</td>
    <td width="270" align="left" bgcolor="#c8e6ff"><a href="javascript:closeLayerPopup(1);" onfocus='this.blur()'><img src="../popimgs/popup_close2.jpg" border="0"   /></a></td> 
  </tr>
</table>


<script language="Javascript">

cookiedata = document.cookie; 

if ( cookiedata.indexOf("layer_pop1=done") < 0 ){ 

	document.all['layer_pop1'].style.visibility = "visible";
} else {

	document.all['layer_pop1'].style.visibility = "hidden";  
}


function closeLayerPopup(a) {
	if (document.getElementById("layerForm"+a).chkbox.checked){ 
		setCookie("layer_pop"+a, "done", 1); 
	}

	document.all['layer_pop'+a].style.visibility = "hidden";
}

</script>


</div>
<!-- 레이어팝업 끝-->


<table width="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top"> 
	<td valign="top">   
		<!-------- / top area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>   
			<td height="87" valign="top">
			<!-- top menu flash -->
              <script language="javascript">
                  writeObject("<%=imageServer%>/tour_swf/topMenu1.swf?McNum=<%=McNum%>&sub=<%=sub%>&aaa=<%=aaa%>&bbb=<%=bbb%>","910","87","transparent")
              </script>
			</td>
		</tr>
		<tr>
			<td height="165" valign="top">
				<!-- main flash -->
              <script language="javascript">
                  writeObject("<%=imageServer%>/tour_swf/Main_Vi.swf","100%","529","transparent")
              </script>
              
			</td>
		</tr>
		</table>
		
		<!-------- main area / -------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="922">
				<table width="884" cellpadding="0" cellspacing="0" border="0" class="footer2">
				<tr valign="top"> 
					<td width="104" height="20" rowspan="2"><a href="javascript:;" onClick="javascript:familyPop('http://www.hyundai-asan.com')"><img src="<%=imageServer%>/tour_img/footer_logo.gif"></a></td>
					<td width="645" class="tpad_3">
					<a href="/include/intro.jsp"><img src="<%=imageServer%>/tour_img/footer_01.gif"></a>
					<a href="center/download/download_view.jsp"><img src="<%=imageServer%>/tour_img/footer_02.gif"></a>
					<a href="http://www.hdasan.com/nember/privacy.jsp" target="_blank"><img src="<%=imageServer%>/tour_img/footer_03.gif"></a>
					<a href="/include/contactus.jsp"><img src="<%=imageServer%>/tour_img/footer_04.gif"></a>
					<a href="https://com.hdasan.com/baton/" target="_blank"><img src="<%=imageServer%>/tour_img/footer_080324.gif" border="0"></a>					</td>
					<td width="135">
						<table width="132" height="17" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="center" style="background:url('<%=imageServer%>/tour_img/bgbox_select.gif');fixed no-repeat left top;">
								<script>
								var strCombo = ""
								+ "<select name='family' style='width:128px; height:15px;' onchange='javascript:familyPop(document.all.family.value);'>"
								+ "<option value='' selected>FAMILY SITE</option>"
								+ "<option value='http://www.hyundaigroup.com'>현대그룹</option>"
								+ "<option value='http://www.hyundai-asan.com'>현대아산</option>"
								+ "<option value='http://www.unikorea.go.kr'>통일부</option>"
								+ "<option value='http://www.knto.or.kr'>한국관광공사</option>"
								+ "<option value='http://tour.goseong.org'>고성관광</option>"
								<%if(session_isfrom.equals("a")){%>
								+ "<option value='http://toursales.hdasan.com'>대리점전용</option>"
							          <%}else if(session_isfrom.equals("c")){%>
							          + "<option value='http://toursales.hdasan.com/services/index.jsp?ut=C&c_sid=<%=session_client_sid%>&c_id=<%=session_id%>'>협력사전용</option>"
						                     <%}%>
								+ "</select>";
								SS_write(strCombo, 6, '', 'down');
								</script>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="61" colspan="2" valign="top"><img src="<%=imageServer%>/tour_img/footer_right.gif"></td></tr>
				</table>
			</td>
			<td valign="top" style="padding-top:40px;"><!-- <a href="#top"><img src="<%=imageServer%>/tour_img/btn/btn_top.gif"></a> --></td>
		</tr>
		</table>
		
		
<!--로거삽입 시작-->
<script type="text/javascript" charset="euc-kr" src="http://log.inside.daum.net/dwi_log/js/dwi.js"></script>
<script type="text/javascript" >
	_dwiPID="d-P9Y-226";
	if(typeof(_dwiCatch) == "function") { _dwiCatch();}
</script>
<!--로거삽입 끝-->


<!-- 호텔엔조이 관련 시작 2009-09-21 심동현 -->
<script language="javascript">
function showHotel(){//팝업으로 수정
//	document.all.hotelLayer.style.display='';
	window.open("http://www.plztour.com/reservation/hotelLayer3.html","hnj","width=800,height=600,top=20,left=20,scrollbars=yes,resizable=yes, status=yes");	//새창 띄워라. ()
}
</script>
<!-- 호텔엔조이 관련 끝 2009-09-21 심동현 -->

<!-- PLZ 대형배너 시작 2009-12-15 심동현 -->
<iframe id="plzAD" name="plzAD" 
		style="display:;position:absolute;z-index:9;top:105px;left:49px;width:840;height:480;" 
		Frameborder="0" src="/reservation/plz_ad_kg.html" scrolling="no">
</iframe>

<script language="javascript">
function hidePlzAD(){
	document.all.plzAD.style.display='none';
}
function showPlzAD(){
	top.location="http://www.hdasantour.com";
}
</script>
<!-- PLZ 대형배너 끝 2009-12-15 심동현 -->


<!-- 새해인사 배너 시작 2009-12-30 심동현 -->
<iframe id="nyAD" name="nyAD" 
		style="display:none;position:absolute;z-index:11;top:182px;left:259px;width:420;height:325;" 
		Frameborder="0" src="/popup/pop091230.jsp" scrolling="no">
</iframe>

<script language="javascript">
function hideNyAD(){
	document.all.nyAD.style.display='none';
}
function showNyAD(){
	document.all.nyAD.style.display='inline';
}
</script>
<!-- 새해인사 배너 끝 2009-12-30 심동현 -->

		<!-- footer /-->
	</td>
</tr>
</table>

</body>
</html>


