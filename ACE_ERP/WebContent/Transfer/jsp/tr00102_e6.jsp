
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*-------------------------------------------------------------------------------
+ 시 스 템 명	: 현대아산  OMS
+ 프로그램 ID	: TR00102_E6.HTML
+ 기 능 정 의	: 첨부문서
+ 변 경 이 력	:   
+ 서 블 릿 명	: TR00102_E6.HTML
-----------------------------------------------------------------------------*/
%>

<%@ page import="transfer.common.*"%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<HTML>
<head>
<jsp:include page="/Transfer/common/include/head.jsp"/>
<TITLE>첨부문서</TITLE>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>


<!-- /******************************************************************************
	Description : Java Script 
******************************************************************************/ --> 
<SCRIPT language=JavaScript>
	var	lb_boolean1 =  false ; 
	var garg = "";
	var pan = "";
	var tid = "";
	var gfile_type = "";

	/******************************************************************************
		Description :
	******************************************************************************/ 
	function Start(){
		garg = opener.gcDs1.namevalue(1,"ORDER_NO");
		gfile_type = opener.gcDs1.namevalue(1,"ATT_FILENM");
		
		alert("garg:::"+garg);
		alert("gfile_type:::"+gfile_type);
		alert("dirPath::<%=dirPath%>");
		
		gfile_type = gfile_type.toUpperCase();
		alert("gfile_type::"+gfile_type);
		if (gfile_type=="GIF" || gfile_type=="JPG"){
			//alert("dirPath::");
			//alert("dirPath::"+dirPath);
			//img_map.src = dirPath+"servlet/transfer.tr00102_s0?v_str1=" + garg;
			img_map.src = "<%=dirPath%>/servlet/transfer.tr00102_s0?v_str1=" + garg;
			
			prompt('img_map.src',img_map.src);

			if (img_map.width=="28"&&img_map.height=="30") img_map.style.display = "none";
			else img_map.style.display = "";
		} else {
			img_map.style.display = "";
			img_map.src="<%=dirPath%>/Common/img/noimage.gif";
		}
	}
	
	/******************************************************************************
		Description :
	******************************************************************************/ 
	function ln_Download(){
		if (gfile_type=="") {
			alert("다운로드 하실 파일이 없습니다.");
			return;
		}

		var surl = "<%=dirPath%>/servlet/transfer.tr00102_s1?v_str1=" + garg + "&v_str2=" + gfile_type;
		tid = "";
		pan = window.open(surl,"_self","toolbar=no,menubar=no,scrollbars=no,resizable=yes,width=0,height=0,left=999999,top=999999");
	}

</SCRIPT> 

</HEAD>

<BODY onLoad="Start();">
	<table width="775" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
		<tr> 
			<td background="<%=dirPath%>/Common/img/com_t_bg.gif" ><img src="<%=dirPath%>/Common/img/TR00102_E6.gif"></td>
			<td width="575" align="right" background="<%=dirPath%>/Common/img/com_t_bg.gif" style="padding-top:4px;">  
				<img src="<%=dirPath%>/Common/img/btn/com_b_filedown.gif" style="cursor:hand" onclick="ln_Download()">
			</td>
		</tr>
		<tr><td height="10px" colspan=2></td></tr>
		<tr>
			<td colspan=2 style="width:775px;height:525px;text-align:center">
				<img id=img_map>
			</td>
		</tr>  
	</table>
</BODY>
</HTML>
