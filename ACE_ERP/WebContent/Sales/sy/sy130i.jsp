<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �ý��۰���
 * ���α׷�ID 	: SY130I
 * J  S  P		: sy130i
 * �� �� ��		: Sy190i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-05-16
 * �������		: �ý��ۻ�� ���� (��ȸ ��� ���� ����)
 * ��������		: 
 * �� �� ��		: 
 * ������������ 	:  
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import

%>
<%@ page import="sales.common.*"%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �ڹ��ڵ�


	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	
		<title>[SY190I]�ý��ۻ�� ����</title>
		
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
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
		function fnOnLoad(){
			fnInit(); 
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
		function fnSetHeaderDs1(){
				var s_temp = "envicd:STRING,envidesc:STRING,envivalu:STRING,envibigo:STRING";
				ds1.SetDataHeader(s_temp);
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ 
// Parameter 	: 
%>
		function fnInit(){
		    fnSetHeaderDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
		function fnSelect() {
			fnSelectDs1();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  
// Parameter 	: 
%>
		function fnSelectDs1() {
			if(ds1.Isupdated){
				alert("�������� ���� �ֽ��ϴ�.");
			}else{
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy190i?proType=S&dsType=1";
				ds1.Reset();
			}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>

			function fnAddRowDs1() {
			
					ds1.addrow();
	
					ds1.namevalue(ds1.RowPosition, "envicd") = ds1.namevalue(ds1.rowposition, "envicd");
					gr1.setcolumn("envicd");
				
					window.status="���� ���ԵǾ����ϴ�.";
			}
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
		function fnApply() {
				fnApplyDs1();
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ ���� 
// Parameter 	: 
%>			
			function fnApplyDs1() {
				if (ds1.IsUpdated) {
							tr1.KeyValue = "Sy190i(I:INPUT_DATA=ds1)";
							tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy190i?proType=A&dsNum=1";
							tr1.post();
							ds1.ResetStatus();
					}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
		function fnCancelDs1() {
			ds1.undoall();
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �����
// Parameter 	: 
%>
			function fnDeleteRowDs1() {			
				if(ds1.IsUpdated) {
					alert("�������� ���� ������ ������ �� �����ϴ�.");
					return;
				}else{
						ds1.deleterow(ds1.rowposition);
						fnApply();
						window.status="���������� �����Ǿ����ϴ�.";
					
						return;
				}
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �μ� (������)
%>
		function fnPrintDs1() {
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ���� (������)
%>
		function fnExcelDs1() {
			gr1.RunExcelSheet("�ý��ۻ�� ����");
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �з��� �˾� (������)
%>
		function fnPopup() {
			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
			function ln_Chk() {
				
			}

		</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
////////////////////////////////////////////////////////////////////////////////
//// �Ʒ�Ű�� ������ ��� AddRow
%>
<script language=JavaScript for=gr1 event=onKeyPress(keycode)>

          if (keycode == 40) {
				fnAddRowDs1();
          }

 </script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onfail()">
			window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : " + ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<comment id="__NSID__"><object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
<comment id="__NSID__"><object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="fnOnLoad(); namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','images/com_top_m02<%=dirPath %>/Sales/images/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif')">
		<table width="1000" height="100%" border="0" cellpadding="0" cellspacing="0"> 
			<tr>
				<td width="123" valign="top"><!--// ���̵�޴�--><jsp:include page="/Sales/common/include/left_mn1.jsp"/></td>  <!--// ���̵�޴� ��-->
				<td valign="top"><!--// ž�޴����� --> <jsp:include page="/Sales/common/include/top_mn.jsp"/></td> <!--// ž�޴� ��-->
			</tr>
			<tr>
			    <td height="10"></td>
			</tr>
<!-- ���α׷� ���� BODY START -->			
			<tr>
				<td align="center" valign="top">
					<table width="845" border="0" cellspacing="0" cellpadding="0">
                       <tr> 
                         <td><!-- Ÿ��Ʋ INCLUDE --><jsp:include page="/Sales/common/include/title.jsp"/></td><!-- Ÿ��Ʋ INCLUSDE �� -->
                       </tr>
						<tr> 
							<td>
							<!-- ���� �ڵ� �κ� ����  -->
								<table  cellpadding="0" cellspacing="0" border="0">
									<tr height="50px">
									  
								<TD width="845" align="right" ><table  cellpadding="0" cellspacing="0" border="0">
									<tr>        					
										<td align="right" width=100%>					
											<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:hand;position:relative;top:3px" onclick="fnExcelDs1()">   
											<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;top:3px" onclick="fnSelect()">     
											<img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand;position:relative;top:3px"  onClick="fnAddRowDs1()" >
											<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;top:3px" onClick="fnDeleteRowDs1()" >     
											<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;top:3px" onClick="fnApply()">      
											<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;top:3px"  onclick="fnCancelDs1()"> 

									 	</td>
									</tr>
								</table>	
									 	</td>
									</tr>
								</table>		
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:310px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr>
										<td height=3  border="0"></td>
									</tr>
									<tr> 
										<td> 
											<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:310px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
												<tr> 
													<td>
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: xxxxxxxx 
				: �˻� ���� - �з��ڵ�, �з���
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>												
														<comment id="__NSID__"><object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:400px;border:1 solid #777777;">   
															<param name="DataID"			value="ds1">                                                                                                                              
															<param name="BorderStyle"   	value="0">                                                                                                                                        
															<param name="Fillarea"			value="true">                                                                                                                             
															<param name="ColSizing"     	value="true">                                                                                                                                     
															<param name="IndWidth"      	value="0">                                                                                                                                        
															<param name="Editable"      	value="true">                                                                                                                                     
															<param name="LineColor" 		value="#dddddd">                                                             
															<param name="Format"			value="  
																<c> Name='��   ��'		 	ID='envicd'		  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center </c>
																<c> Name='��         ��' 		ID='envidesc'	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=495  align=left </c>
																<c> Name='��' 				ID='envivalu'	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center </c>
																<c> Name='�� �� �� ��'	 	ID='envibigo'  		HeadAlign=Center HeadBgColor=#B9D4DC Width=250  align=left </c>
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
								<!-- ���� �ڵ� �κ� ��  -->
								</td>
							</tr>
						
						</table>
					</td>
			</tr>
<!-- ���α׷� ���� BODY END -->			
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
<input type="hidden" name="row" value="">
	</body>
</html>