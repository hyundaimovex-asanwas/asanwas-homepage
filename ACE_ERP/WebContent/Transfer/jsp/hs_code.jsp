<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ 시 스 템 명	:	현대아산 반출배정조회
+ 프로그램 ID	: TR00103.HTML
+ 기 능 정 의	: 반출배정조회
+ 변 경 이 력	: 정미선
+ 작성일자 : 
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 :
----------------------------------------------------------------------------------*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="transfer.common.*"%>
<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());		
%>


<!-- HTML 시작-->
<html>
	<head>
   <jsp:include page="/Transfer/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>



<script language="javascript">
	/********************************************************************************************************************
		Description : 페이지 로드
	********************************************************************************************************************/
	function ln_Start(){

		gcds_data1.DataID ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=1&vstr2=9999"; 
		gcds_data1.Reset();
	}

	/********************************************************************************************************************
		Description : 조회
	********************************************************************************************************************/
	function ln_Query(){
		gclx_type1.index=-1;
		gclx_type2.index=-1;
		gclx_type3.index=-1;

		if (gn_Rtrim(txt_nsearch.value)=="") {
			alert("검색 조건을 입력해 주십시오.");
			return;
		}

		gcds_data4.DataID   ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=" + gclx_ntype.BindColVal + "&vstr2=" + txt_nsearch.value; 
		gcds_data4.Reset();
	}

</script>

<!--------------------------------------------------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
--------------------------------------------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" id="gcds_data1">
	<param name="SyncLoad" value="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" id="gcds_data2">
	<param name="SyncLoad" value="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" id="gcds_data3">
	<param name="SyncLoad" value="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" id="gcds_data4">
	<param name="SyncLoad" value="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" id="gcds_data5">
	<param name="SyncLoad" value="false">
</OBJECT><%=HDConstant.COMMENT_END%>

<!--------------------------------------------------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
--------------------------------------------------------------------------------------------------------------------->
<script language=javascript for=gclx_type1 event=onSelchange2()>
	txt_nsearch.value = "";
	gcds_data2.DataID  ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=1&vstr2=" + gclx_type1.bindColVal; 
	gcds_data2.Reset();
</script>

<script language=javascript for=gclx_type2 event=onSelchange2()>
	gcds_data3.DataID  ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=1&vstr2=" + gclx_type2.bindColVal; 
	gcds_data3.Reset();
</script>

<script language=javascript for=gclx_type3 event=onSelchange2()>
	gcds_data4.DataID ="<%=dirPath%><%=HDConstant.PATH_TRANSFER%>hscode_s01?vstr1=1&vstr2=" + gclx_type3.bindColVal; 
	gcds_data4.Reset();
</script>

<script language=javascript for=gcgd_data event=onDblClick(row,colid)>
	// alert(gcds_data4.countRow);
	if(gcds_data4.countRow> 0 ){
	var ls_param = new Array();
	ls_param[0] = gcds_data4.NameValue(row,"minor_cd"); // 시스템 구분 
	ls_param[1] = gcds_data4.NameValue(row,"minor_nm"); // 시스템 구분 
	window.returnValue	=	ls_param  ;
	alert(ls_param) ;
	window.close();  
	 }
	
	
 
</script>

</head>

<body bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="ln_Start()">
<table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:480px" background="/trsweb/img/body_bg.gif">
	<tr><td>&nbsp;</td></tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 style="position:absolute;left:5px;top:5px;width:840px;height:425px;">
	<tr><td height=5px bgcolor="#ffffff"></td></tr>
	<tr>
		<td style="width:840px" bgcolor="#ffffff" valign=top>
			<table border=0 cellpadding=0 cellspacing=0 style="position:relative;left:5px;top:-2px;height:30px;width:830;border:0 solid #F0FAE2;border-bottom-width:1px;">
				<tr>
					<td style="width:8px"></td>
					<td><img src="/trsweb/img/body_top_003.gif"></td>
					<td align=right>
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_ntype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:90px;">
								<param name=CBData			   value="2^HS CODE,3^품목명">
								<param name=CBDataColumns	 value="code,name">
								<param name=SearchColumn	 value="name">
								<param name=ListExprFormat value="name">								
								<param name=BindColumn		 value="code">
								<param name=Index			     value="0">
						</OBJECT><%=HDConstant.COMMENT_END%>
						<input type=text id=txt_nsearch style="position:relative;left:0px;top:0px;width:100px;" onkeydown="if(event.keyCode==13) ln_Query();">
						<a href="#" onclick="ln_Query()" style="position:relative;left:0px;top:1px;"><img src="/trsweb/img/btn/btn_search.gif" border=0></a>
					</td>
					<td style="width:8px;"></td>
				</tr>
			</table>

			<table border=0 cellpadding=0 cellspacing=0 style="position:relative;left:10px;top:5px;height:30px;width:820;border:1 solid #C7D4ED">
				<tr>
					<td class="tab11" style="width:80px;height:25px;"><FONT SIZE="2" COLOR="">부 목록</FONT></td>
					<td class="tab12">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_type1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:730px;">
							<param name=ComboDataID			value="gcds_data1">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="0">
							<param name=ListExprFormat	value="minor_nm^0^700">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr>
					<td class="tab11" style="height:25px;"><FONT SIZE="2" COLOR="">류 목록</FONT></td>
					<td class="tab12">&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_type2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:730px;">
							<param name=ComboDataID			value="gcds_data2">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="0">
							<param name=ListExprFormat	value="minor_nm^0^700">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
				<tr>
					<td class="tab12" style="height:25px;"><FONT SIZE="2" COLOR="">4단위 목록</FONT></td>
					<td>&nbsp;
						<%=HDConstant.COMMENT_START%><OBJECT id=gclx_type3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:3px;font-size:12px;width:730px;">
							<param name=ComboDataID			value="gcds_data3">
							<param name=SearchColumn		value="minor_nm">
							<param name=BindColumn      value="minor_cd">
							<param name=Index						value="0">
							<param name=ListExprFormat	value="minor_nm^0^700">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
			<table border=0 cellpadding=0 cellspacing=0 style="position:relative;left:10px;top:10px;width:820;height:100px;">
				<tr>
					<td style="border:1 solid #CED9EF;">
						<%=HDConstant.COMMENT_START%><OBJECT classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gcgd_data" style="width:818px;height:288;" style='font-size:12'>
							<param name="DataID",				value="gcds_data4">
							<param name="Indwidth" 			value="0">
							<param name="HeadBorder" 		value="4">
							<param name="HeadLineColor" value="#CED9EF">
							<param name="LineColor" 		value="#CED9EF">
							<param name="TitleHeight"		value="25">
							<param name="RowHeight"			value="22">
							<param name="BorderStyle" 	value="0">
							<param name="ColSizing" 		value="1">
							<param name="FillArea" 			value="1">
							<param name="ViewUnbind" 		value="-1">
							<param name="ViewHeader" 		value="-1">
							<param name="UsingOneClick" value=1>
							<param name="Format"				value="
								<C> Name='번호'		ID={CURROW}		HeadAlign=Center HeadBgColor=#E8EDF6 HeadColor=#555555 Color=#555555 Width=40, align=center</C>
								<C> Name='HS'			ID=minor_cd		HeadAlign=Center HeadBgColor=#E8EDF6 HeadColor=#555555 Color=#555555 Width=150, mask={if(MLEN=10,'XXXX.XX-XXXX','XXXX.XX')}</C>
								<C> Name='품명'		ID=minor_nm		HeadAlign=Center HeadBgColor=#E8EDF6 HeadColor=#555555 Color=#555555 Width=612</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 style="position:absolute;left:5px;top:435px;width:820px;">
	<tr>
		<td align=center>
			<a href="#"><img src="/trsweb/img/btn/btn_submit.gif" border=0></a>
			<a href="#" onclick="window.close()"><img src="/trsweb/img/btn/btn_close.gif" border=0></a>
		</td>
	</tr>
</table>

</body>

</html>
