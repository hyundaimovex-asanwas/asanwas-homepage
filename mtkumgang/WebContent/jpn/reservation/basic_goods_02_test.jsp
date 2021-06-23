<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%!
//DNS
public static final String ROOT_DNS= "test1.hdasan.com";
//public static final String ROOT_DNS= "test1.hdasan.com";
%>
<%
//이미지 서버 위치
String imageServer = "http://test1.hdasan.com/asanway/img/";
String rootServer = "http://test1.hdasan.com/";

//현재 URL FULL 경로
String qryStr = request.getQueryString();
qryStr = (qryStr!=null && !qryStr.equals(""))?"?"+qryStr:"";
String requestUri = request.getRequestURI();
String nowUri = requestUri+qryStr; 
nowUri = java.net.URLEncoder.encode(nowUri);
%>

<div id="TourRia"></div> 



<% 
  String McNum = "2";
  String sub = "2";
  String pageNum = "2";
  String subNum = "1";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=uft-8" />
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>

<script language="JavaScript" type="text/JavaScript">
<!--
/* function autoblur(){
if(event.srcElement.tagName == "A") document.body.focus();
}
document.onfocusin = autoblur;
*/
/*  High-peak season/ Peak season/ Low season/ ????? ?????? */
function nation_01()
{
	document.all("nat_01").style.display="";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="none";
	document.all("nat_04").style.display="none";
}

function nation_02()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="";
	document.all("nat_03").style.display="none";
	document.all("nat_04").style.display="none";
}

function nation_03()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="";	
	document.all("nat_04").style.display="none";
}

function nation_04()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="none";	
	document.all("nat_04").style.display="";
}


/*
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);*/

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<style type="text/css">
<!--
.style2 {font-family: SimHei}
.style3 {
	font-family: SimHei;
	font-weight: bold;
}
-->
</style>
</head>

<body>

<table>
<tr>
<td>

数日間の休暇をもらうことは難しく、金銭的にも余裕がなく、だからといって金剛山の風景を
見逃すわけにはいかない，， 
金剛山一泊二日（8時出発）商品は、そのような皆様の悩みを全て解決してくれるでしょう
北側についてすぐ金剛山へ登り、功藝公演か温泉かどちらかを選ぶ悩みをしてみたり
金剛山の夜景を楽しんで忙しかった一日を終えて
その次の日は萬物相と三日浦/海金剛のどちらかで悩む事となるでしょう


<img src="<%=imageServer%>/jpn_img/guide/jpn_logo.gif" border="0">
</td>
</tr>
</table>

</body>
</html>