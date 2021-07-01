<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 회계 전표분개 기초등록
 * 프로그램ID 	: SY240
 * J  S  P		: sy240i
 * 서 블 릿		: Sy240I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-19
 * 기능정의		: 
 * 수정내용		: [이병욱 2006-05-19] 화면 디자인 적용
 * 수 정 자		: 이병욱
 * 최종수정일자 	: 2006-05-19 
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
	
		<title>[SY240I] 회계 전표분개 기초등록 </title>
		
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
				var s_temp = "atclscd:STRING,atclsnm:STRING,desc:STRING";
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
					var s_temp = "atclscd:STRING,atclsno:STRING,atname:STRING,atcode:STRING,atkornam:STRING,atdecr:STRING,desc:STRING";
										
					ds2.SetDataHeader(s_temp);
				}
			}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [조회]
%>
			function fnSelect() {
				
				
				fnSelectDs1();
				fnSelectDs2();
				
				atclscd.readOnly = true;
				atclsnm.readOnly = false;
				desc.readOnly = false;
			}
									
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  분개코드 조회
// Parameter 	: 
%>
			function fnSelectDs1() {
				if (ds1.IsUpdated || ds2.IsUpdated) {
					alert("수정중인 행이 있습니다!");
				} else {
					ds1.ClearAll();
					ds1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy240I?dsType=1&proType=S&sAtclsCd="+sAtclsCd.value;
					ds1.Reset();
				}
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  분개코드 조회 디테일
// Parameter 	: 
%>
			function fnSelectDs2() {
				if (ds1.IsUpdated || ds2.IsUpdated) {
				} else {
					ds2.ClearAll();
					ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy240I?dsType=2&proType=S&sAtclsCd="+ds1.namevalue(ds1.rowposition, "atclscd");
					ds2.Reset();
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  신규 
// Parameter 	: 
%>
			function fnAddRowDs1() {
				if (ds2.IsUpdated) {
					alert("수정중인 행이 있으면 삽입할 수 없습니다");
					return;
				} else {
					fnSetHeaderDs1();
					ds1.AddRow();
					
					atclscd.readOnly = false;
					atclsnm.readOnly = false;
					desc.readOnly = false;
					
					row.value = ds1.RowPosition;
					gr1.setcolumn("atclscd");
					ds2.clearAll();

				}
				
			}
						
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  행추가 
// Parameter 	: 
%>
			function fnAddRowDs2() {
				fnSetHeaderDs2();
				
				
				if (ds2.RowStatus(ds2.RowPosition) == 1 && ds2.namevalue(ds2.rowposition,"atclsno") == "") {
						alert('추가할수 없습니다');
						gr2.setcolumn("atclsno");
						return false;
				}
				
				
				if (ds1.namevalue(ds1.rowposition,"atclscd") == undefined || ds1.namevalue(ds1.rowposition,"atclscd") == "" ) {
					alert('추가할수 없습니다');
				} else {
				
			
					ds2.AddRow();
					ds2.namevalue(ds2.rowposition,"atclscd") = ds1.namevalue(ds1.rowposition,"atclscd");
					gr2.setColumn("atclsno");
					
					window.status = "Detail 행이 삽입되었습니다!";
				}
			}
			

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ]
%>

		function fnApply() {
			fnApplyDs1();
			fnApplyDs2();
			
			atclscd.readOnly = true;
			atclsnm.readOnly = false;
			desc.readOnly = false;
		
		}
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ] 
// 					: 마스터  
%>
			function fnApplyDs1() {
				if(ds2.IsUpdated) {
					tr1.KeyValue = "Sy240I(I:INPUT_DATA=ds1)";
					tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy240I?proType=A&dsNum=1";
					tr1.post();
				}
			}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  [적용 ] 
// 					: 디테일 
%>
			function fnApplyDs2() {
				if(ds2.IsUpdated) {
					tr2.KeyValue = "Sy240I(I:INPUT_DATA=ds2)";
					tr2.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy240I?proType=A&dsNum=2";
					tr2.post();
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  [버튼] 삭제 
//						: 마스터는 삭제시 Commit
%>
			function fnDeleteRowDs1() {			
				if(ds2.IsUpdated) {
					alert("수정중인 행이 있으면 삭제할 수 없습니다.");
					return;
				}else{
					if (confirm("입력하신 사항을 삭제하시겠습니까?")) {
						
						ds1.deleterow(ds1.rowposition);
						ds2.deleteall();
						
						fnApplyDs1();
						fnApplyDs2();
						
						
						window.status="Master 행이 삭제되었습니다.";
					
						return;
					}
				}
			}
				
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  행삭제
// Parameter 	: 
%>
			function fnDeleteRowDs2() {
				ds2.DeleteRow(ds2.Rowposition);
				window.status="Detail 행이 삭제되었습니다.";
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
					atclscd.readOnly = true;
					atclsnm.readOnly = false;
					desc.readOnly = false;
					
				window.status="데이터 변경이 취소되었습니다.";
				return;
			}
						
<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 
%>
			function fnExcelGr2() {
				gr2.RunExcel("회계전표 분개 기초등록");
			}
		</script>
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  계정코드  팝업
%>		
		<script language="javascript"  for=gr2 event=OnPopup(Row,Colid,data)>
    
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy240h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ds2.namevalue(1,"atcode");
				arrParam[1] = ds2.namevalue(1,"atkornam"); //공통코드의 마스터값

				arrResult = showModalDialog(strURL,arrParam,strPos);	

				if (arrResult != null) {
					arrParam = arrResult.split(";");
			    	ds2.NameValue(ds2.RowPosition,"atcode") = arrParam[0];
				ds2.NameValue(ds2.RowPosition, "atkornam") = arrParam[1];
				} else {
			    	ds2.NameValue(ds2.RowPosition,"atcode") = "";
				ds2.NameValue(ds2.RowPosition, "atkornam") = "";
				}	 
  		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>		
<%
////////////////////////////////////////////////////////////////////////////////
//// 분개코드에 속한 세부코드를 조회한다 
%>	
		<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
			if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("수행중인 작업이 있을 경우에는 조회를 할 수 없습니다");
				ds1.RowPosition = row.value;
				return false;
			} else {
				fnSelectDs2();
				row.value = ds1.RowPosition;
			}
		</script>

<%
////////////////////////////////////////////////////////////////////////////////
//// 아래 화살표 키가 눌렸을 경우 AddRow
%>
<script language=JavaScript for=gr2 event=onKeyPress(keycode)>

          if (keycode == 40) {
				fnAddRowDs2();
          }

</script>
<%
////////////////////////////////////////////////////////////////////////////////
//// 회계코드 조회
%>		
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
						
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="true">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	
		
<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>			
<comment id="__NSID__"><object id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<comment id="__NSID__"><object id="tr2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName" value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad();namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','images/com_top_m02<%=dirPath %>/Sales/images/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
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
                       	<!-- 타이틀 INCLUDE -->
                         <td><jsp:include page="/Sales/common/include/title.jsp"/></td>
                         <!-- 타이틀 INCLUSDE 끝 -->
                       </tr>
						<tr> 
							<td>
								<table width="845px" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: 검색 부분 
				: 분개코드, 분개명칭
-----------------------------------------------------------------------------*/
%>											
												<tr height="50px">
													<td align="left" >
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="355px">
																	<table  bgcolor="#666666"  border="0" cellpadding="0" cellspacing="1">
																		<tr  bgcolor="#6f7f8d" height="30px" >
																			<td width="60px" class="boardt02"> 분개코드 </td>
																			<td bgcolor="#ffffff" width="220px">
																				<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#ffffff">
																					<tr>
																						<td width="150px" align="center"  bgcolor="#FFFFFF">
																							<input height="22px" type="text" name="sAtclsCd" value="" size="20" class="textbox">
																							
																						</td>	
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
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDs1()" >
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
																				<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDs1()" >
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
													<td width="845px">
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="255px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: 검색 종류 - 분개코드, 분개명칭:  
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>							
																	<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=255px; height:400" border="1" >
																		<param name="DataID"			value="ds1">
																		<param name="ColSizing"			value="true">
																		<param name="Fillarea"			value="true">
																		<param name="AutoResizing" 		value="true"> 
																		<param name="Editable"  		value="false">
																		<param name="AddSelectRows" 	value="true">
																		<param name="BorderStyle"   value="0">
																		<param name=LineColor 		value="#dddddd">
																		<param name="IndWidth"		value="0">
																		<param name="Format" 			value="
																			<c> Name='분개코드' 	ID='atclscd'  	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left </c>
																			<c> Name='분개명칭'	ID='atclsnm'  	HeadAlign=Center HeadBgColor=#b8d2ed Width=155  align=left </c>
																			<c> Name='비고'			ID='desc'  		HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left show=false </c>
																		">
																	</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
																</td>		
																
																<td width="25px">
																
																</td>					
																
																<td align="left" valign="top" width="565px">
																	<table border="0" cellpadding="0" cellspacing="0">
																		<tr>
																			<td>
																				<table border="0" cellpadding="0" cellspacing="0">
																					<tr>
																						<td>
																							<table width="565px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
																								<tr bgcolor="#ffffff">
																									<td width="100px" height="30px" class="boardt02">분개코드</td>
																									<td aling="left">&nbsp;&nbsp;<input type="text" id="atclscd" value=""  size="20" readonly="true"></td>
																								</tr>
																								<tr bgcolor="#ffffff">
																									<td  height="30px" width="100px" class="boardt02">분개명칭</td>
																									<td align="left">&nbsp;&nbsp;<input type="text" id="atclsnm" value="" readonly="true"></td>
																								</tr>
																								<tr bgcolor="#ffffff">
																									<td  height="90px" width="100px" class="text">비고</td>
																									<td  align="left" width="430px">&nbsp;&nbsp;
																										<textarea name="searchKeyWordk" id="desc" value="" rows="5" cols="55" readonly="true"></textarea>
																									</td>
																								</tr>
																							</table>																						
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																		
																		<tr>
																			<td height="15px"></td>
																		</tr>
												
																		<tr>
																			<td height=3  border="0" align=right>
																				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs2()" >
																				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs2()" >
																			</td>
																		</tr>
												
																		<tr>
																			<td height="15px"></td>
																		</tr>
												
																		<tr>
																			<td>
																				<table border="0" cellpadding="0" cellspacing="0">
																					<tr>
																						<td>
																							<table align="left" width="565px" border="0" cellpadding="0" cellspacing="1" >
																								<tr align="left" >
																									<td align="left">
																										<comment id="__NSID__"><object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=565px; height:190" border="1">
																							
																											<param name="DataID"		value="ds2">
																											<param name="BorderStyle"   value="0">
																											<param name="Fillarea"		value="true">
																											<param name="ColSizing"		value="true">
																											<param name="IndWidth"		value="0">
																											<param name="Editable"      value="true">
																											<param name="Format" 		value="
																									
																												<c> Name='분개코드'		ID='atclscd'	  		HeadAlign=Center HeadBgColor=#b8d2ed Width=100  	align=left show=true 		</c> <!-- TSY241.atclscd -->
																												<c> Name='분류일련번호' 	ID='atclsno'  		HeadAlign=Center HeadBgColor=#b8d2ed Width=140  	align=left Show=true		</c> <!-- TSY241.atclsno -->
																												<c> Name='적요'				ID='atname' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  	align=left show=true		</c> <!-- TSY241.atname -->
																												<c> Name='계정코드' 		ID='atcode'  			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  	align=left editStyle=Popup	</c> <!-- TSY241.atcode -->
																												<c> Name='계정명칭' 		ID='atkornam'  		HeadAlign=Center HeadBgColor=#b8d2ed Width=100  	align=left show=true		</c> <!--  -->
																												<c> Name='차/대' 			ID='atdecr'  			HeadAlign=Center HeadBgColor=#b8d2ed Width=50  	align=left show=true		</c> <!-- TSY241.atdecr -->
																												<c> Name='비고' 				ID='desc'  			HeadAlign=Center HeadBgColor=#b8d2ed Width=140  	align=left show=true		</c> <!-- TSY241.desc -->
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
													</td>
												</tr>											
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
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
		<C>Col=atclscd 		Ctrl=atclscd 		    Param=value </C>
		<C>Col=atclsnm 		Ctrl=atclsnm 		Param=value </C>
		<C>Col=desc 			Ctrl=desc 				Param=value </C>"     
	>
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    
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
<input type="hidden" name="row" value="">
	</body>
</html>