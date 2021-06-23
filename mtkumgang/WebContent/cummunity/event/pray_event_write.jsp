<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.*"%>
<%@ page import="com.hmm.ejb.common.UtilDB"%>

<%
if(session_id.equals("")){
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
alert("로그인 해주세요.");
opener.location.href= "http://www.mtkumgang.com/member/login.jsp";
window.self.close();
//-->
</SCRIPT>
<%
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>수능 D-100일 문필봉 기도 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>

<script language="javascript">
function event_go(){
	var f = document.frm;
	if(f.content.value == ""){
		alert("소원을 기입해 주세요.");
		return;
	}

	var strValue = f.content.value;
	var intDataLength = strValue.length;
	if(intDataLength > 100)
	{
		alert("소원은 100자 이내로만 입력이 가능합니다.");
		f.content.value = strValue.substr(0, 100);
		return;
	}

	f.action = "pray_eventProc.jsp";
	f.submit();
}
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%    
   int i_total_no=0;

   Connection conn = null;
   PreparedStatement pstmt = null; 
   ResultSet rs = null;   
   
   String query = ""; 
   try { 
	  conn = UtilDB.getConnection("jdbc/tourds"); 
	  query = "select count(*) from asan.EVENT_WISH"; 
	  pstmt = conn.prepareStatement(query); 
	  rs = pstmt.executeQuery(); 

	  if(rs.next()) {
		i_total_no=rs.getInt(1);  //총 글수
	  }

	  query = "select IDX, ID, NAME, CONTENT, I_DATE from asan.EVENT_WISH "; 				  

	  pstmt = conn.prepareStatement(query);
	  rs = pstmt.executeQuery(); 
		
	  String idx = ""; 
	  String name = "";
	  String content = "";
	  String i_date = "";
      int i = 0;

	  while (rs.next()) {             
		idx = rs.getString("IDX"); 
		name = rs.getString("NAME"); 
		content = rs.getString("CONTENT"); 
		i_date = rs.getString("I_DATE").substring(0,10); 	  
%> 			
<div id="Layer<%=i%>" style="position:absolute; left:284px; top:331px; width:200px; height:130px; z-index:1; overflow: visible; visibility: hidden;">
  <table width="200" height="130" border="0" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC">
    <tr bgcolor="#FFFFFF"> 
      <td valign="top"> 
        <table width="200" height="30" border="0" cellpadding="5" cellspacing="0">
          <tr> 
            <td width="123" height="22"><%=name%> </td>
            <td width="79">[<%=i_date%>]</td>
          </tr>
          <tr bgcolor="#669900"><td height="1" colspan="2"></td></tr>
        </table>
        <table width="200" height="85" border="0" cellpadding="5" cellspacing="0">
          <tr> 
            <td height="25" valign="top"><%=content%></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<% 
		 i++;	
	   }  
	%> 
   <% 
	}catch (Exception e) {
		e.printStackTrace();
		System.out.println("Exception during connection :"+e.getMessage());
	} finally {
		UtilDB.closeConnection(conn, pstmt, rs);
	}
%>  
<table width="800" height="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="60" colspan="2"><img src="<%=imageServer%>/moon_img/tit.gif" width="800" height="60"></td>
  </tr>
  <tr> 
    <td height="60"><img src="<%=imageServer%>/moon_img/img01.gif" width="575" height="60"></td>
    <td width="1"><a href="pray_event_view.jsp" onFocus="this.blur()"><img src="<%=imageServer%>/moon_img/btn_list.gif" width="225" height="60" border="0" ></a></td>
  </tr>
  <tr> 
    <td rowspan="3" width="570" align="center" background="<%=imageServer%>/moon_img/img02.jpg">
	 <table width="540" border="0" cellpadding="0" cellspacing="0">
	  <tr>
	   <td align="center">
			<!-- Data List -->
			<% for(int n=0;n<i_total_no;n++) { %>
			<img src="<%=imageServer%>/moon_img/icon_off.gif" name="Image<%=n%>" onMouseOut="cnj_hide(document.all.Layer<%=n%>.style);MM_swapImgRestore()" onMouseOver="cnj_show(document.all.Layer<%=n%>.style);MM_swapImage('Image<%=n%>','','<%=imageServer%>/moon_img/icon_on.gif',1)" width="20" height="57" border="0"> 
			<% } %>
			<!-- Data List -->
	   </td>
	  </tr>
	 </table>
	</td>
    <td height="257" background="<%=imageServer%>/moon_img/img03.jpg">
	  <form name="frm" method="post">
	  <table width="210" border="0" cellspacing="0" cellpadding="5">
        <tr>
          <td align="center" style="padding-top:60px;"><input name="name" type="text" id="name" value="<%=session_name%>(<%=session_id%>)" size="25">
		  </td>
        </tr>
        <tr>
          <td align="center"><textarea name="content" cols="24" rows="6" wrap="VIRTUAL" id="text" style="height:90px;"></textarea></td>
        </tr>
      </table>
	  </form>
	  </td>
  </tr>
  <tr>
    <td><a href="javascript:event_go()"  onFocus="this.blur()"><img src="<%=imageServer%>/moon_img/btn_ok.gif" width="225" height="28" border="0"></a></td>
  </tr>
  <tr> 
    <td><img src="<%=imageServer%>/moon_img/img04.jpg" width="225" height="195"></td>
  </tr>
</table>

</body>
<script language='JavaScript'>
<!--  
 document.write('<st'+'yle>');
 document.write('td {font-size:12px; font-family:굴림; text-decoration:none; }');
 document.write('A:link,A:active,A:visited{text-decoration:none;font-size:12PX;color:#333333;}');
 document.write('A:hover {text-decoration:none; color:ff9900}');
 document.write('font { font-size: 9pt; }');
 document.write('.cnj_input {background-color:rgb(240,240,240);border-width:1pt; height:16pt;cursor:hand;}');
 document.write('.cnj_input2 {border-width:1; border-color:rgb(204,204,204); border-style:solid;cursor:hand;}');
 document.write('.cnj_input3 { border-width:1; border-style:solid; border-color:#000000; color:#0084D4; background-color:white;cursor:hand;}');
 document.write('.cnj_input4 { scrollbar-face-color: #FFCC33;scrollbar-shadow-color:  #ffffff;scrollbar-highlight-color: #F3f3f3;scrollbar-3dlight-color: #ffffff;scrollbar-darkshadow-color: #F3f3f3;scrollbar-track-color: #ffffff;scrollbar-arrow-color: #f9f9f9;cursor:hand; }');
 document.write('</st'+'yle>');

 var cnj_obj = document.all.Layer0.style;
 var wx=0, wy=0;
 function cnj_move() {
	// wx 와 wy 뒤에 - 이면 마우스포인터의 툴팁내용이 상단에 위치
	// wx 와 wy 뒤에 + 이면 마우스포인터의 툴팁내용이 하단에 위치
	cnj_obj.pixelLeft = wx-30; // 마우스포인터와 레이어와의 가로 간격
	cnj_obj.pixelTop  = wy-150; // 마우스포인터와 레이어와의 세로 간격
	cnj_obj.pixelLeft += document.body.scrollLeft;
	cnj_obj.pixelTop  += document.body.scrollTop;
 }
 function cnj_show(lyName) {
    cnj_obj = lyName;
	if(cnj_obj.visibility != "hidden")
	return;
	cnj_move();
	cnj_obj.visibility = 'visible';
 }
 function cnj_hide(lyName) {
	cnj_obj = lyName;
	cnj_obj.visibility = 'hidden';
 }
 function dragIt(evt) {
	wx = event.x;
	wy = event.y;
	if(cnj_obj.visibility == "visible")
	cnj_move();
 }
 document.onmousemove = dragIt;
</script> 
</html>
