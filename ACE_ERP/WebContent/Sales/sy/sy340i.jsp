<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 메인메뉴 등록
 * 프로그램ID 	: SY340I
 * J  S  P		: sy340i
 * 서 블 릿		: Sy340I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-16
 * 기능정의		: 대리점 관리 (조회 등록 삭제 수정)
 * 수정내용		: [이병욱 2006-05-19] 디자인 적용
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
	
		<title>[SY340I] 메인메뉴 등록 </title>
		
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
// Description 	: 페이지 로딩
%>
			function fnOnLoad(){
				fnInit();
				
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 프로젝트 조회 
//              : 셀렉트박스에 프로젝트 NAME를 보여준다 
//				: 테이블 = TCU020
// Parameter	: dsType = 1 (첫번째 조회)
// 				: proType = INIT (초기화)
%>
			function fnInit(){ 
				fnSelectDs1();
					fnSetDataHeader2();
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 프로젝트 조회 
//              : 셀렉트박스에 프로젝트 NAME를 보여준다 
//				: 테이블 = TCU020
// Parameter	: dsType = 1 (첫번째 조회)
// 				: proType = INIT (초기화)
%>
			function fnSelectDs1(){ 
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy340I?proType=INIT&dsType=1";
				ds1.Reset();
			}
						
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 메뉴 조회
// Parameter 	: dsType = 1 (두번째조회)
//				: proType = S (검색)
%>
			function fnSelectDs2(){   
				if (ds2.IsUpdated) {
					alert("작업중인 행이 있을 경우 조회 할수 없습니다!");
					return;
				} else {
					ds2.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy340I?proType=S&dsType=1&sProjectId="+ds1.namevalue(ds1.rowposition,"project_id");
					ds2.Reset();
				}
			} 
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  신규
// Parameter 	: 
%>
	
			function fnAddRowDs2(){
				
				if (ds2.RowStatus(ds2.RowPosition) == 1 && 
					ds2.namevalue(ds2.rowposition,"menu_nm")== ""  || 
					ds2.namevalue(ds2.rowposition,"menu_id")== "" ) {

						return false;
					
				} else {
					ds2.addrow();
					alert(ds1.namevalue(ds1.rowposition,"project_nm"));
					ds2.namevalue(ds2.rowposition, "project_id") = ds1.namevalue(ds1.rowposition,"project_id");
					ds2.namevalue(ds2.rowposition, "project_nm") = ds1.namevalue(ds1.rowposition,"project_nm");
					gr1.setcolumn("display_seq");
				}
				
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  행삭제
// Parameter 	: 
%>
			function fnDeleteRowDs2() {
					ds2.deleterow(ds2.rowposition);
			}
	

<%
	///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용 
// Parameter 	: 
%>
			function fnApply(){
				if (ds2.IsUpdated) {
					tr1.KeyValue = "Sy340I(I:INPUT_DATA=ds2)";
					tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy340I?proType=A&dsNum=1";
					tr1.post();
					ds2.ClearAll();
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
			function fnCancel(){
				ds2.undoall();
				window. status="데이터 변경이 취소되었습니다.";
				return;
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description : 엑셀 
%>
			function fnExcelGr1(){
				gr2.runexcel("메인 메뉴 등록");
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 (메뉴) Header 설정 
//				: 조회를 안하고 바로 메뉴를 등록시키기 위해서는 헤더가 먼저 설정되야한다
// Parameter	:
%>	
			function fnSetDataHeader2(){
				if (ds2.countrow<1){
					var s_temp 	= "project_id:STRING,"
								+ "project_nm:STRING,"
								+ "menu_id:STRING,"
								+ "menu_nm:STRING,"
								+ "display_seq";
					ds2.SetDataHeader(s_temp);
				}
			}			
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 (메뉴) Header 설정 
//				: 조회를 안하고 바로 메뉴를 등록시키기 위해서는 헤더가 먼저 설정되야한다
// Parameter	:
%>	
			function fnIsChecked() {		
			var row1=ds2.countrow;	
				for(i=1;i<row1;i++) {
					if(ds2.namevalue(i,"menu_id")==ds2.namevalue(i+1,"menu_id")) {
						alert("분류코드값이 중복됩니다.");
						return false;
					}
					
					if(ds2.namevalue(i,"menu_id") == "") {
						alert("메뉴 ID를 입력하세요!");
						return false;
					}
					
					if (ds2.namevalue(i,"menu_nm") =="") {
						alert("메뉴명을 입력하세요!");
						return false;
					}
				}			
			}
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
////////////////////////////////////////////////////////////////////////////////
//// 아래키가 눌렸을 경우 AddRow
%>
<script language=JavaScript for=gr1 event=onKeyPress(keycode)>

          if (keycode == 40) {
				fnAddRowDs2();
          }

 </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: Ds1 조회 에러 
%>
		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
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
			alert("작업이 성공적으로 완료되었습니다!");
			window.status="작업이 성공적으로 완료되었습니다.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  TR1 에러 
%>	
		<script language="javascript" for="tr1" event="onfail()">
			alert("작업이 성공적으로 완료되지 못했습니다!");
			window.status="작업이 성공적으로 완료되지 못했습니다.";
		</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 (프로젝트) 조회 중.. 메세지  
%>	
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 (프로젝트) 조회 완료 메세지 
%>			
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS1 (프로젝트) 조회중 에러 메세지
%>				
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 (메뉴) 조회 중.. 메세지  
%>		
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 (메뉴) 조회중 에러 메세지
%>			
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DS2 (메뉴) 조회 완료 메세지 
%>			
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  프로젝트 이름 DataSet
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: 프로젝트의 메인메뉴 DataSet
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
							<td>
                         		<table width="845px" border="0" cellpadding="0" cellspacing="0">
                         			<tr>	
                         				<td>
                         					<table border="0" width="845px" cellpadding="0" cellspacing="0">
                         						<tr>
                         							<td><jsp:include page="/Sales/common/include/title.jsp"/></td>
                         						</tr>
                         					</table>
                         				</td>
                         			</tr>
                         		</table>
                       </tr>
						<tr> 
							<td align="center">
								<table width="845px" border="0" cellpadding="0" cellspacing="0">
									<tr>
										<td width="100%">
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
								

											<table border="0" cellpadding="0" cellspacing="0" width="100%">
<%
/*---------------------------------------------------------------------------->
HTML Desc	: 검색 부분 (LuxeCombo1)
: 프로젝트 이름 검색 
-----------------------------------------------------------------------------*/
%>				
												<tr>
													<td>
														<table width="100%" border="0" cellpadding="0" cellspacing="0">
															<tr height="50px">
																<td>
																	<table border="0" width="300px" cellpadding="0" cellspacing="1"  bgcolor="#666666">
																		<tr height="30px">
																			<td  bgcolor="#eeeeee" class="text">프로젝트</td>
																			<td  bgcolor="#ffffff">&nbsp;&nbsp;
												 								<comment id="__NSID__"><object id=lc1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=120 width=150 align=absmiddle>
																					<param name=ComboDataID		value=ds1>
																					<param name=EditExprFormat	value="%;project_nm">
																					<param name=ListExprFormat  value="project_nm^0^100">
																				</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>								
																			</td>
																		</tr>
																	</table>
																</td>
																<td bgcolor="#ffffff" width="100%">
																	<table width="100%" border="0" cellpadding="0" cellspacing="0">
																		<tr>
																			<td align="right" bgcolor="#ffffff" >
																				<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelectDs2()">
																				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"  align=absmiddle onClick="fnAddRowDs2()" >
																				<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs2()" >
																				<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply()">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  align=absmiddle onclick="fnCancel()">
																				
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr height="10px">
													<td></td>
												</tr>
			<%
			/*---------------------------------------------------------------------------->
			HTML Desc	: 메뉴등록 , 프로젝트와 종속적인 메뉴를 관리한다 
			Object ID 	: 그리드 , gr1
			Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>					
												<tr>
													<td>
														<table width="100%" border="0" cellpadding="0" cellspacing="0">
															<tr>
																<td>
																	<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:840px;HEIGHT:400px" border="1">
																		<param name="DataID"		value="ds2">
																		<param name="BorderStyle"   value="0">
																		<param name="Fillarea"		value="true">
																		<param name=ColSizing       value="true">
																		<param name="IndWidth"      value="0">
																		<param name="editable"      value="true">
																		<param name="Format"		value="  
																			<C> name='' 			ID='{CURROW}' 		HeadAlign=Center HeadBgColor=#b8d2ed Width=20  align=center edit=false</C>						
																			<C> name='프로젝트' 		ID='project_id'  	HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=center editlimit=5 edit=none</C>
																			<C> name='프로젝트명'		ID='project_nm'		HeadAlign=Center HeadBgColor=#b8d2ed Width=200 align=center editlimit=50 edit=none</C>
																			<C> name='화면표시순서'  	ID='display_seq'   	HeadAlign=Center HeadBgColor=#b8d2ed Width=100 align=center editlimit=50</C>
																			<C> name='메뉴 ID'  		ID='menu_id'  		HeadAlign=Center HeadBgColor=#b8d2ed Width=100 align=center editlimit=50</C>											
																			<C> name='메뉴명'  		ID='menu_nm'   		HeadAlign=Center HeadBgColor=#b8d2ed Width=320 align=center editlimit=50</C>											
																		">
																	</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>								
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
	</body>
</html>