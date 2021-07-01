<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 		: 사용자별 프로그램 등록
 * 프로그램ID 	: SY380I
 * J  S  P		: sy380i
 * 서 블 릿		: Sy380I
 * 작 성 자		: 이병욱
 * 작 성 일		: 2006-05-16
 * 기능정의		: 
 * 수정내용		: 
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
	
		<title>[SY380I] 사용자별 프로그램 등록 </title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">

		<script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>
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
// Description 	:  사용자 검색 팝업 
%>			
			function fnPopup() {
			}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  사용자에게 대한 프로그램 목록을 조회한다 
// 				: 각각 틀린 DS에서 값을 얻어오는 함수만을 호출한다 
%>			
			function fnSelect() {
				fnSelectDs1();
				fnSelectDs2();
				
			}		

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체프로그램목록 조회 
// 				: 등록된 프로그램 목록을 조회한다
// Parameter	: proType=S, dsType=1
%>			
			function fnSelectDs1() {
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy380I?proType=S&dsType=1&sLoginSid=" + login_sid.value
				ds1.Reset();			
			}		
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  사용자프로그램목록 조회 
// 				: 사용자가 사용할수 있는 프로그램 목록
// Parameter	: proType=S, dsType=2
%>			
			function fnSelectDs2() {
				alert("2");
				ds2.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy380I?proType=S&dsType=2&sLoginSid=" + login_sid.value
				ds2.Reset();			

			}					
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  취소
%>			
			function fnCancel() {
			}					

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  적용
// 				: 사용자 프로그램을 적용한다 
// Parameter	: proType=A, dsType=1
%>			
			function fnApply() {
				fnApplyDs1();
				fnApplyDs2();
				fnApplyDs3();
				
				fnSelect();
				
			}		
			function fnApplyDs1() {
				tr1.KeyValue = "Sy380I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy380I?proType=A&dsNum=1&sLoginSid=" + login_sid.value
				tr1.post();
			}
			function fnApplyDs2() {
				
				tr1.KeyValue = "Sy380I(I:INPUT_DATA=ds1)";
				tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy380I?proType=A&dsNum=2&sLoginSid=" + login_sid.value
				tr1.post();
			}
			
			function fnApplyDs3() {

				tr3.KeyValue = "Sy380I(I:INPUT_DATA=ds2)";
				tr3.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy380I?proType=A&dsNum=3&sLoginSid=" + login_sid.value
				tr3.post();
			}
			
			
			function XXX() {
			var row1=ds1.countrow;

    		

			for(i=1;i<=row1;i++) {
					alert(ds1.namevalue(i,"colors"));
					if(ds1.namevalue(i,"colors")=="RED") {
			
						//gr1.ColumnProp('program_nm','Color')="RED"
						return false;
					}
				}
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  프로그램 등록 , 삭제 버튼 처리  
//				: 왼쪽에서 오른쪽으로 , 오른쪽에서 왼쪽으로 한개 또는 다중 옮기기 
//				: 추가나 삭제경우 자기 자신의 그리드에서 내용은 빠지게 된다 
%>			
			function fnMove(arg){
				if (arg =='L') { //DS2에서 DS1으로 한개 옮기기 
					
					if (ds2.countrow<1) {
						alert("이동할 프로그램 목록이 없습니다");
						return;
					}
					ds1.addrow();
				
					var lpos = ds1.rowposition;
					var rpos = ds2.rowposition;
					
					ds1.namevalue(lpos,"program_id")		= ds2.namevalue(rpos,"program_id");
					ds1.namevalue(lpos,"program_nm")		= ds2.namevalue(rpos,"program_nm");
					ds1.namevalue(lpos,"colors")			= ds2.namevalue(rpos,"colors");
					
					ds2.deleterow(rpos);
				} else if (arg == 'LA') {
					
					if (ds2.countrow<1)  {
						alert("이동할 프로그램 목록이 없습니다");
						return;
					}
					var tcnt = ds2.countrow;
					for (var i=1;i<=tcnt;i++){
						ds1.addrow();
						var lpos = ds1.rowposition;
						ds1.namevalue(lpos,"program_id")		= ds2.namevalue(1,"program_id");
						ds1.namevalue(lpos,"program_nm")		= ds2.namevalue(1,"program_nm");
						ds1.namevalue(lpos,"colors")			= ds2.namevalue(1,"colors");
						ds2.deleterow(1);
					}	
				} else if (arg == 'R') {
					
					if (ds1.countrow<0) {
						alert("이동할 프로그램 목록이 없습니다");
						return;
					}
					
					ds2.addrow();
			
					var lpos = ds1.rowposition;
					var rpos = ds2.rowposition;
					
					ds2.namevalue(rpos,"program_id")			= ds1.namevalue(lpos,"program_id");
					ds2.namevalue(rpos,"program_nm")			= ds1.namevalue(lpos,"program_nm");
					ds2.namevalue(rpos,"colors")				= ds1.namevalue(lpos,"colors");
					
					ds1.deleterow(lpos);
				} else if (arg == 'RA') {
					if (ds1.countrow<1) {
						alert("이동할 프로그램 목록이 없습니다");
						return;
					}
					var tcnt = ds1.countrow;
					for (var i=1;i<=tcnt;i++){
						ds2.addrow();
						var rpos = ds2.rowposition;
						ds2.namevalue(rpos,"program_id")			= ds1.namevalue(1,"program_id");
						ds2.namevalue(rpos,"program_nm")			= ds1.namevalue(1,"program_nm");
						ds2.namevalue(rpos,"colors")				= ds1.namevalue(1,"colors");
						ds1.deleterow(1);
					}
				}
			}
			
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  취소
%>
			function fnCancel(){
				ds1.undoall();
				ds2.undoall();
				window. status="데이터 변경이 취소되었습니다.";
				return;
			}						
		</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
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
// Description	:  프로그램 목록 조회중 메세지 (Ds1)
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  사용자 프로그램 목록 조회중 메세지 (Ds2)
%>		
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  사용자 프로그램 목록조회 조회 완료 메세지 (Ds1)
%>		
		 		
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("검색된 데이타가 없습니다."); 
			}
		</script>		
				
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  프로그램목록조회  에러 메세지 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("프로그램 목록 조회중 에러가 발생했습니다 : " + ds1.ErrorMsg );
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  사용자 프로그램 목록조회 에러 메세지 
%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			alert("사용자 사용가능한 프로그램 목록 조회중 발생했습니다 : " + ds2.ErrorMsg );
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>				
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  전체 프로그램 목록 
%>
<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  사용자 사용가능  프로그램 목록 
%>
<object  id=ds2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>

<%
/*=============================================================================
			Transaction Components(TR) 선언
=============================================================================*/
%>
<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object>	
<object  id="tr2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object>	
<object  id="tr3" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object>
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

								<table width="845px" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td>
<!--------------------------------- 코딩 부분 시작 ------------------------------->	
											<table border="0" cellpadding="0" cellspacing="0">
												<tr>
													<td>
<%
/*---------------------------------------------------------------------------->
	Html Desc 	: 사용자 검색 
-----------------------------------------------------------------------------*/
%>			
														<table border="0" cellpadding="0" cellspacing="0" >
															<tr>
																<td>
																	<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="435px">
																		<tr height="30px">
																			<td bgcolor="#ffffff" width="100px">사용자</td>
																			<td bgcolor="#ffffff" align="center">
																				<input class="textbox" type="text" name="login_sid" value="4" disabled="disabled" size="10" >&nbsp;&nbsp; 
																				<a href="#"><img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle ></a></td>
																			<td bgcolor="#ffffff" aling="center">
																				<input type="text" name="login_nm" value="이병욱" disabled="disabled" size="10">
																			</td>
																	</table>																
																</td>
																<td>
																	<table border="0" cellpadding="0" cellspacing="0">
																		<tr>
																			<td align="right" width="420px" bgcolor="#ffffff">
																				<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" align=absmiddle onclick="fnSelect()">
																				<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" align=absmiddle onClick="fnApply()">
																				<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  align=absmiddle onclick="fnCancel()">	
																			</td>
																		</tr>
																	</table>																
																</td>
															</tr>
														</table>

													</td>
												</tr>
												<tr>
													<td height="10px"></td>
												</tr>
												<tr>
													<td>
																
														<table border="0" cellspacing="0" cellpadding="0">
															<tr>
<%
/*---------------------------------------------------------------------------->
	Html Desc	: 전체 프로그램 목록 
	Object ID 	: 그리드 , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>					
																<td>
																
																	<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1" width="400">
																		<param name="DataID"		value="ds1">
																		<param name="BorderStyle"   value="0">
																		<param name="Fillarea"		value="true">
																		<param name="ColSizing"     value="true">
																		<param name="IndWidth"      value="0">
																		<param name="editable"      value="false">
																		<param name="AddSelectRows" value=true>
																		<param name=MultiRowSelect  value="true">
																			
																		<param name="Format"		value="  
																			<G> name='전체프로그램목록' HeadBgColor=#B9D4DC
																			<C> name='프로그램ID' 	ID='program_id'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center editlimit=5 Color=$Color</C>
																			<C> name='프로그램명' 	ID='program_nm'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=300  align=center editlimit=30 Color=$Color</C>
																			<C> name='COLORS' 		ID='colors'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=300  align=center editlimit=30 Color=$Color</C>
																		">
																	</object> 	
																								
																</td>
<%
/*---------------------------------------------------------------------------->
	Html Desc 	: 버튼 
-----------------------------------------------------------------------------*/
%>								
																<td valign="center">
																	<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td><a href="javascript:fnMove('RA');"><img src="<%=dirPath%>/Sales/common/img/btn/com_btn_rightall.gif" border="0"></a></td>
																		</tr>
									
																		<tr>
																			<td><a href="javascript:fnMove('R');"><img src="<%=dirPath%>/Sales/common/img/btn/com_btn_right.gif" border="0"></a></td>
																		</tr>
																		<tr>
																			<td>&nbsp;</td>
																		</tr>
																		<tr>
																			<td><a href="javascript:fnMove('L');"><img src="<%=dirPath%>/Sales/common/img/btn/com_btn_left.gif" border="0"></a></td>
																		</tr>
																		<tr>
																			<td><a href="javascript:fnMove('LA');"><img src="<%=dirPath%>/Sales/common/img/btn/com_btn_leftall.gif" border="0"></a></td>
																		</tr>
									
																	</table>
																</td>
<%
/*---------------------------------------------------------------------------->
	Html Desc	: 사용자 사용 가능 프로그램 목록 
	Object ID 	: 그리드 , gr2
	Data ID		: ds2
-----------------------------------------------------------------------------*/
%>								
																<td>
																		<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr2 width="400">
																			<param name="DataID"		value="ds2">
																			<param name="BorderStyle"   value="0">
																			<param name="Fillarea"		value="true">
																			<param name="ColSizing"     value="true">
																			<param name="IndWidth"      value="0">
																			<param name="editable"      value="false">										
																			<param name="AddSelectRows" value=true>
																			<param name=MultiRowSelect  value="true">
									
																			
																		    <param name="SelectionColor" value="
																				<SC>Type='FocusCurRow', BgColor='#e2e2e2', TextColor='#000000'</SC>">
																				
																			<param name="Format"		value="  
																				<G> name='사용자 프로그램 목록' HeadBgColor=#B9D4DC
																				<C> name='프로그램ID' 	ID='program_id'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=100  align=center editlimit=5 Color=$Color</C>
																				<C> name='프로그램명' 	ID='program_nm'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=300  align=center editlimit=30 Color=$Color</C>
																				<C> name='COLORS' 		ID='colors'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=300  align=center editlimit=30 Color=$Color</C>
																			">
																		</object> 
																</td>
															</tr>
															<tr>
																<td>
																	<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td width="15" height="10" bgcolor="#7BCF18"></td>
																			<td>'사용자'에게 사용 권한이 부여되지 않는 프로그램</td>
																		</tr>
																		<tr>
																			<td width="15" height="10"  bgcolor="#FF0000"></td>
																			<td>레벨에는 권한이 있으나 '사용자'에게 권한 취소된 프로그램</td>
																		</tr>
																	</table>
																</td>
																<td>&nbsp;</td>
																<td>
																	<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td width="15" height="10"  bgcolor="#000000"></td>
																			<td>'사용자'가 속한 레벨에 사용 권한이 있는 프로그램</td>
																		</tr>
																		<tr>
																			<td width="15" height="10"  bgcolor="#0000FF"></td>
																			<td>'사용자가' 속한 레벨에 없는 프로그램 중 권한 추가된 프로그램 </td>
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