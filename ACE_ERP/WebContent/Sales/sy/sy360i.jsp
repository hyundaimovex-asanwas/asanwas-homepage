<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
/******************************************************************************
 * 시스템명 		: 시스템 관리 
 * 프로그램ID 		: SY360I 
 * J  S  P		: sy360i
 * 서 블 릿		: Sy360i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-05-19
 * 기능정의		: 사용자별 레벨 조회, 등록, 삭제 엑셀, 팝업조회 , 검색 
 * 수정내용		: 
 * 수 정 자		:
 * 최종수정일자 	: 2006-05-19
 * T O D O		: 1. xxxxxx 미처리
 * T O D O		: 2. yyyyyy 미처리 
 *
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  자바코드


	// ContextPath
	String dirPath = request.getContextPath(); //HDASan

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
		<title>[SY010I] 공통코드관리 </title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">

		<script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/embedControl.js"></script>
		<script language="JavaScript">
			<!--
				function namosw_init_slide_layers()
				{
				  var layer;
				  var i;
				  var args = namosw_init_slide_layers.arguments;
				
				  for (i = 0; i < args.length; i += 2) {
				      if (navigator.appName == 'Netscape') {
					layer = document.layers[args[i]];
				        if (args[i+1] == 1)
				          layer.left = -layer.clip.width  + 5;
				        else if (args[i+1] == 2)
				          layer.top  = -layer.clip.height + 5;
					layer._sl_dir    = (layer.top < 0) ? 'v' : ((layer.left < 0) ? 'h' : '');
				        if (layer._sl_dir == '') return;
					layer._sl_maxpos = 0
					layer._sl_minpos = (layer.top < 0) ? layer.top : layer.left;
				        if (layer.document.namoswmenucontainer)
				          layer = layer.document.namoswmenucontainer;
					if (layer.captureEvents)
					  layer.captureEvents(Event.MOUSEOVER|Event.MOUSEOUT);
				      } else {
					layer = document.all[args[i]];
				        if (args[i+1] == 1)
				          layer.style.pixelLeft = -layer.style.pixelWidth  + 5;
				        else if (args[i+1] == 2)
				          layer.style.pixelTop  = -layer.style.pixelHeight + 5;
					layer._sl_dir    = (layer.style.pixelTop < 0) ? 'v' : ((layer.style.pixelLeft < 0) ? 'h' : '');
				        if (layer._sl_dir == '') return;
					layer._sl_maxpos = 0;
					layer._sl_minpos = (layer.style.pixelTop < 0) ? layer.style.pixelTop : layer.style.pixelLeft;
				      }
				      layer.onmouseover  = namosw_sl_mouseover;
				      layer.onmouseout   = namosw_sl_mouseout;
				  }
				}
			
				function namosw_sl_mouseover() 
				{
				  var layer = this;
				  var name  = (navigator.appName == 'Netscape') ? layer.name : layer.id;
				  if (name == 'namoswmenucontainer') {
				    if (navigator.appName == 'Netscape') {		// redundant check
				      layer = layer.parentLayer;
				      name  = layer.name;
				    }
				  }
				  if (layer._down_interval)
				    clearInterval(layer._down_interval)
				  layer._up_interval = setInterval("namosw_sl_mouseover2('" + name + "')", 50)
				}
			
				function namosw_sl_mouseout() 
				{
				  var layer = this;
				  var name  = (navigator.appName == 'Netscape') ? layer.name : layer.id;
				  if (name == 'namoswmenucontainer') {
				    if (navigator.appName == 'Netscape') {		// redundant check
				      layer = layer.parentLayer;
				      name  = layer.name;
				    }
				  }
				  if (layer._up_interval)
				    clearInterval(layer._up_interval)
				  layer._down_interval = setInterval("namosw_sl_mouseout2('" + name + "')", 50)
				}
			
				function namosw_sl_mouseover2(name) 
				{
				  var layer;
				  if (navigator.appName == 'Netscape') {
				    layer = document.layers[name];
				    if (layer._sl_dir == 'h' && layer.left < layer._sl_maxpos)
				      layer.left += 5;
				    else if (layer._sl_dir == 'v' && layer.top < layer._sl_maxpos)
				      layer.top += 5;
				    else if (layer._up_interval)
				      clearInterval(layer._up_interval);
				  } else {
				    layer = document.all[name];
				    if (layer._sl_dir == 'h' && layer.style.pixelLeft < layer._sl_maxpos)
				      layer.style.pixelLeft += 5
				    else if (layer._sl_dir == 'v' && layer.style.pixelTop < layer._sl_maxpos)
				      layer.style.pixelTop += 5;
				    else if (layer._up_interval)
				      clearInterval(layer._up_interval);
				  }
				}
			
				function namosw_sl_mouseout2(name) 
				{
				  var layer;
				  if (navigator.appName == 'Netscape') {
				    layer = document.layers[name];
				    if (layer._sl_dir == 'h' && layer._sl_minpos < layer.left)
				      layer.left -= 5;
				    else if (layer._sl_dir == 'v' && layer._sl_minpos < layer.top)
				      layer.top  -= 5;  
				    else if (layer._down_interval)
				      clearInterval(layer._down_interval);
				  } else { 
				    layer = document.all[name];
				    if (layer._sl_dir == 'h' && layer._sl_minpos < layer.style.pixelLeft)
				      layer.style.pixelLeft -= 5;
				    else if (layer._sl_dir == 'v' && layer._sl_minpos < layer.style.pixelTop)
				      layer.style.pixelTop -= 5;
				    else if (layer._down_interval)
				      clearInterval(layer._down_interval);
				  }
				}
			
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
<% 
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
		<script language="javascript">
		
		
			get_cookdata();
			var gs_userid = gusrid;
			var gs_fdcode = gfdcode;
			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  페이지 로딩 
// Parameter 	: 
%>
			function fnOnLoad(){
				fnInit();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  선조회
// Parameter 	: 
%>
			function fnInit(){ 
			
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs1(){
				if (ds1.countrow<1){
					var s_temp = "client_cd:STRING,client_nm:STRING,branch:STRING,login_id:STRING,login_nm:STRING";
					ds1.SetDataHeader(s_temp);
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head 설정 
// Parameter	:
%>	
			function fnSetHeaderDs2(){
				if (ds2.countrow<1){
					var s_temp = "project_level:STRING,project_level_nm:STRING,level_yn:STRING"
					ds2.SetDataHeader(s_temp);
				}
			}			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 조회 
// Parameter 	: dsType = 1
%>
		function fnSelect() {
			fnSelectDs1();
			fnSelectDs2();
		}

			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 조회 
// Parameter 	: dsType = 1
%>
			function fnSelectDs1(){   
				if (ds1.IsUpdated || ds2.IsUpdated) {
					alert("수정중인 행인 있습니다.");
				} else {
					ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy360i?proType=S&dsType=1&s_Client_Nm=" + txt_client_nm.value + "&s_Login_Nm=" + txt_login_nm.value;
					ds1.Reset();
				}
			} 
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  조회2 
// Parameter 	: 
%>
	
			function fnSelectDs2(){
				if (ds1.IsUpdated || ds2.IsUpdated) {
					alert("수정중인 행인 있습니다.");
				} else {
					ds2.DataID = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy360i?proType=S&dsType=2";
					ds2.Reset();
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>


			function fnApply(){
				fnApplyDs1();
				fnApplyDs2();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  마스터 정보 
// Parameter 	: 
%>
			function fnApplyDs1() {
				if (ds1.IsUpdated) {
			
						if (ln_Chk())	{
							tr1.KeyValue = "Sy360i(I:INPUT_DATA=ds1)";
							tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy360i?proType=A&dsNum=1";
							tr1.post();
						}
					}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  디테일 정보  
// Parameter 	: 
%>			
			function fnApplyDs2() {
				
				if (ds2.IsUpdated) {
							fnChk();
							tr2.KeyValue = "Sy360i(I:INPUT_DATA=ds2)";
							tr2.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy360i?proType=A&dsNum=2";
							tr2.post();
						
				}	
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
			function fnCancel(){
			
				if(ds1.IsUpdated || ds2.IsUpdated) {
					ds1.undoall();
					ds2.undoall();
				}
				window.status="데이터 변경이 취소되었습니다.";
				return;
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 
%>
			function fnExcelGr1(){
				gr2.RunExcelSheet("사용자별 레벨등록");
			}
			
			function fnChk() {
				if(ds2.namevalue(ds2.rowposition,"level_yn")=="F") {
					ds2.namevalue(ds2.rowposition,"level_yn1")="N";
				}
				else if(ds2.namevalue(ds2.rowpoistion,"level_yn")=="T") {
					ds2.namevalue(ds2.rowposition,"level_yn1")="Y";
				}
			}
		</script>
		
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////////////////
///// 분류 DataSet
%>

<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="true">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 처리 에러 
%>	
<comment id="__NSID__"><object  id=ds2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object  id="tr2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

<%
////////////////////////////////////////////////////////////////////////////////
//// 공통코드 상세를 조회한다 
%>	
		<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
		
			if (ds1.IsUpdated || ds2.IsUpdated) {
				
					alert("수행중인 작업이 있을 경우에는 조회를 할수 없습니다!");
					ds1.RowPosition = row.value;
					return false;
				
			} else {
				fnSelectDs2();
				row.value = ds1.RowPosition;
				
			}
			
			
		</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 처리 완료  
%>	
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="작업이 성공적으로 완료되었습니다.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 에러 
%>	
		<script language="javascript" for="tr1" event="onfail()">
			window.status="작업이 성공적으로 완료되지 못했습니다.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR2처리 완료  
%>	
		
		<script language="javascript" for="tr2" event="onsuccess()">
			window.status="작업이 성공적으로 완료되었습니다.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 처리 에러 
%>	
		<script language="javascript" for="tr2" event="onfail()">
			window.status="작업이 성공적으로 완료되지 못했습니다.";
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 조회중
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 조회완료
%>			
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="조회중에 에러가 발생했습니다!.";
			document.all.LowerFrame.style.visibility="hidden";
				
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 조회중 에러 
%>	 		
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 조회중
%>			
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
	<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 조회중  에러
%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 조회 완료
%>			
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다.");
			}			
		</script>
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','images/com_top_m02<%=dirPath %>/Sales/images/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
		<table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="123" valign="top"><!--// 사이드메뉴--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// 사이드메뉴 끝-->
				<td valign="top"><!--// 탑메뉴시작 --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// 탑메뉴 끝-->
			</tr>
			<tr>
			    <td height="10"></td>
			</tr>
<!-- 프로그램 들어가는 BODY START -->			
			<tr>
				<td align="center" valign="top">
					<table width="845" border="0" cellspacing="0" cellpadding="0">
                       <tr> 
                         <td><!-- 타이틀 INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- 타이틀 INCLUSDE 끝 -->
                       </tr>
						<tr> 
							<td>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
											<table  width="845px"  cellpadding="0" cellspacing="0" >
<!-- 검색부분 -->											
												<tr>
													<td align="left">
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr height="50px" > 
																<td align="left"  width="250px">
																	<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
																		<tr  bgcolor="#6f7f8d" align="left">
																			<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">대리점</td>
																			<td bgcolor="#ffffff" width="143px">
																				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="110px" align="center"  bgcolor="#FFFFFF">
																							<input height="22px" id="txt_client_nm" type="text" size="10"  maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox">&nbsp;&nbsp;
																							<a href="#"><img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle ></a></td>	
																					</tr>
																				</table>
																			</td>
																			
																		</tr>
																	 
																	</table>
																</td>
																<td align="left"  width="250px">
																	<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left">
																
																		<tr  bgcolor="#6f7f8d" align="left">
																			<td height="30px" width="60px"  bgcolor="#eeeeee" align="center" class="text">사용자</td>
																			<td bgcolor="#ffffff" width="143px">
																				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="110px" align="center"  bgcolor="#FFFFFF">
																							<input height="22px" id="txt_login_nm" type="text" size="10"  maxlength="36" onBlur="bytelength(this,this.value,36);" onkeydown="if(event.keyCode==13) fnSelectDs1();" class="textbox">&nbsp;&nbsp;
																							<a href="#"><img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle ></a></td>	
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</table>
																</td>
																<td align="right">
																	<table border="0"  cellpadding="0" cellspacing="0" width="100%">
																		<tr>
																			<td align="right" height="30px">		
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApplyDs2()">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
																 			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>	
													</td>											
												</tr>
												<tr height="10">
													<td></td>
												</tr>			
												<tr>
													<td align="left">
														<table  width="845px"  cellpadding="0" cellspacing="0">
															<tr>
																<td colspan="5"  align="left">
																	<table width="845px" border="0" cellpadding="0" cellspacing="0" >
																		<tr>
																			<td align="left" valign="top" width="300px" >
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: 분류코드 검색
	항목			: 분류코드, 분류코드명
	Object ID 	: 그리드 gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>												
																				<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=457px; height:361px" border="1">
																					<param name="DataID"				value="ds1">
																					<param name="BorderStyle"   	value="0">
																					<param name="Fillarea"			value="true">
																					<param name="ColSizing"     	value="true">
																					<param name="IndWidth"     		value="0">
																					<param name="editable"      		value="false">
																					<param name="LineColor" 		value="#dddddd">
																					<param name="Format"		value="
																						<C> name='대리점 코드' 		ID='client_cd' 				HeadAlign=Center HeadBgColor=#b8d2ed Width=70  align=left editlimit=5</C>
																						<C> name='대리점명' 			ID='client_nm' 				HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20</C>  
																						<C> name='지점명'	 			ID='branch_nm' 				HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20</C>
																						<C> name='로그인 SID' 		ID='login_sid' 				HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=10 show=false</C>
																						<C> name='로그인 ID' 			ID='login_id' 				HeadAlign=Center HeadBgColor=#b8d2ed Width=87  align=left editlimit=10</C>
																						<C> name='로그인명'  			ID='login_nm'				HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=20</C>											
																					">
																				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT> 	
																			</td>
																			<td width="10px"></td>
																			<td valign="top">
																				<table width="380px" cellpadding="0" cellspacing="0" >
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: 상세코드 
	항목			: 코드, 코드명, 속성 1 - 15 
	Object ID 	: 그리드 gr2
	Data ID		: ds2
-----------------------------------------------------------------------------*/
%>
																					<tr>
																						<td align="right" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																							<comment id="__NSID__"><object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id=gr2  style="WIDTH:345px;HEIGHT:361px" border="1">
																								    <param name="DataID"		value="ds2"> 
																									<param name="BorderStyle"   value="0">       
																									<param name="Fillarea"		value="true">
																									<param name="ColSizing"		value="true">
																									<param name="IndWidth"		value="0">   
																									<param name="Editable"      value="true">    
																									<Param Name="UsingOneClick"     value="1">   
																									<param name="Format"		value="  
																									<C> name='로그인SID' 		ID=login_sid show=false </C>  
																									<C> name='레  벨'	 		ID= project_level 				HeadAlign=Center HeadBgColor=#b8d2ed Width=100 	align=left </C>
																									<C> name='레벨명'   		ID= project_level_nm	 		HeadAlign=Center HeadBgColor=#b8d2ed Width=145 	align=left editlimit=10 </C>
																									<C> name='권한여부' 		ID= level_yn 					HeadAlign=Center HeadBgColor=#b8d2ed Width=100 	align=center EditStyle=CheckBox</C>
																								">
																							</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
																						</td>
																					</tr>
																				</table>
																			</td>																		
																		</tr>
																	</table>														
																</td>
															</tr>
														</table>											
													</td>												
												</tr>
											</table>												 
<!--------------------------------- 코딩 부분 끝 -------------------------------->		
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
<!-- 프로그램 들어가는 BODY END -->			
		</table>
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>	
<object  id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='  
	<C>Col=head                    Ctrl=head             	 Param=value</C>
	<C>Col=head_nm          Ctrl=head_name         Param=value</C>
	'>
</object>
<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:280px; top:220px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>		
<!---------------------------------- BODY End -------------------------------->	
<input id="txt_save1" type="hidden" size="1" value="0">
<input id="txt_save2" type="hidden" size="1" value="0">
<input type="hidden" name="row" value="">
	</body>
</html>