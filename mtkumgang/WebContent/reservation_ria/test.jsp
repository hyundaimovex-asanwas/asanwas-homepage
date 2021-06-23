<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
  String McNum = "0"; 
  String sub = "0"; 
%>  
<html> 
<head> 
<title> ±Ý°­»ê°ü±¤ </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language=JavaScript>
function Reservation01(){

   var str = ""
   str += "<table width=\"884\" height=\"529\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
   str += "<tr>\n";
   str += "<td width=\"884\" height=\"529\">\n";
   str += "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0\" width=\"884\" height=\"529\" id=\"Reservation_Check5\" align=\"middle\">\n";      
   str += "<param name=\"allowScriptAccess\" value=\"sameDomain\" />\n";
   str += "<param name=\"movie\" value=\"/asanway/img//tour_swf/Reservation.swf\" />\n";
   str += "<param name=\"quality\" value=\"high\" />\n";
   str += "<param name=\"bgcolor\" value=\"#ffffff\" />\n";
   str += "<embed src=\"/asanway/img/tour_swf/Reservation_Check.swf\" quality=\"high\" bgcolor=\"#ffffff\" width=\"884\" height=\"529\" name=\"Reservation_Check5\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />\n";
   str += "</object>\n";
   str += "</td></tr></table>\n";
   document.all.TourRia.style.posLeft = 0;
   document.all.TourRia.style.posTop = 100;
   document.all.TourRia.style.display = "";
   document.all.TourRia.innerHTML = str;
   Q_navi01();
}

function Q_navi01(){
   var str = ""
   str += "<table width=\"884\" height=\"529\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n";
   str += "<tr>\n";
   str += "<td width=\"884\" height=\"529\">\n";
          str += "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0\" width=\"884\" height=\"529\" id=\"Reservation_Check5\" align=\"middle\">\n";      
          str += "<param name=\"allowScriptAccess\" value=\"sameDomain\" />\n";
          str += "<param name=\"movie\" value=\"/asanway/img//tour_swf/Reservation.swf\" />\n";
          str += "<param name=\"quality\" value=\"high\" />\n";
          str += "<param name=\"bgcolor\" value=\"#ffffff\" />\n";
          str += "<embed src=\"/asanway/img/tour_swf/Reservation_Check.swf\" quality=\"high\" bgcolor=\"#ffffff\" width=\"884\" height=\"529\" name=\"Reservation_Check5\" align=\"middle\" allowScriptAccess=\"sameDomain\" type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />\n";
          str += "</object>\n";
          str += "</td></tr></table>\n";
   
       document.all.TourRia.style.position = "absolute";
       document.all.TourRia.style.posLeft = 26;
       document.all.TourRia.style.posTop = 87;
       document.all.TourRia.style.display = "";
       document.all.TourRia.innerHTML = str;    
}
</script>
</head>


<body onload="Reservation01();">
</body>
</html>