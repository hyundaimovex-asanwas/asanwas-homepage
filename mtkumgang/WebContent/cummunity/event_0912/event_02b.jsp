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
String id = session_id;
%>
<html>
<head>
<title>금강송이 찾기 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="javascript">
<!--
	var item = new Array(5);
	
	function getItem(idx){
		item[idx-1] = true;
		
		count = checkGettedItem();
		
		<%
		if( id == null || id.equals("") ){
		%>
		alert("로그인을 하여주세요.");
		opener.location.href = "../../member/login.jsp";
		window.close();
		return;
		<%
		}
		%>
		
		if( count < 5 ){
			alert("금강송이 "+count+"개 찾으셨네요~~");
		}else{
			alert("금강송이 5개 모두 찾으셨습니다. 추첨행사에 응모되었습니다");
			location.href = "./event_proc.jsp";
		}
	}
	
	function checkGettedItem(){
		count = 0;
		for( i=0; i < item.length; i++ ){
			if( item[i] == true ) count++;
		}
		
		return count;
	}
	
//-->
</script>
</head>

<body style="margin:0">
<table width="800" height="600" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td colspan="3"><img src="<%=imageServer%>song_img/img_tit.jpg" width="800" height="178"></td>
  </tr>
  <tr> 
    <td width="110"><img src="<%=imageServer%>song_img/img_01.jpg" width="110" height="380"></td>
    <td width="580"><img src="<%=imageServer%>song_img/img_map02.jpg" width="580" height="380" border="0" usemap="#Map"></td>
    <td width="110"><img src="<%=imageServer%>song_img/img_02.jpg" width="110" height="380"></td>
  </tr>
  <tr> 
    <td colspan="3"><img src="<%=imageServer%>song_img/img_03.jpg" width="800" height="42"></td>
  </tr>
</table>
<map name="Map">
  <area shape="circle" coords="376,49,21" href="javascript:getItem(1);">
  <area shape="circle" coords="519,30,20" href="javascript:getItem(2);">
  <area shape="circle" coords="205,85,22" href="javascript:getItem(3);">
  <area shape="circle" coords="414,213,21" href="javascript:getItem(4);">
  <area shape="circle" coords="531,244,21" href="javascript:getItem(5);">
</map>
</body>
</html>
