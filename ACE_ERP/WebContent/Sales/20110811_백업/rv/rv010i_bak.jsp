<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ��ǰ��ݰ��� 
 * ���α׷�ID 	: RV010I
 * J  S  P		: rv010i
 * �� �� ��		: Rv010I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-05-16
 * �������		: ��ǰ��� ���� (��ȸ ��� ���� ����)
 * ��������		: ���(function) ����
 * �� �� ��		: ������
 * ������������ : 2006-05-22 
 * TODO			: ȭ������λ� ��� ����
 * TODO			: �̺�Ʈ ����
 * TODO         : ȭ�鱸�� ����
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
	
		<title>��ǰ��ݰ���</title>
		
<%
/*=============================================================================
			Style Sheet, Common Java Script Link
=============================================================================*/
%>		

		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">

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
// Description 	: ����ȸ 
// Parameter 	: 
%>
		function fnInit(){
				ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=S&s_SaupSid=&s_SaupCd=&s_SaupNm=";
				ds2.Reset(); //�����ڵ�
				ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=S&s_UpjangSid=&s_UpjangCd=&s_UpjangNm=";
				ds3.Reset(); //������
				ds4.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=S&s_Head=RV016&s_Detail=&s_DetailNm=";
				ds4.Reset(); //�����ڵ�(�������)
		}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  
// Parameter 	: 
%>
		function fnSelectDs1() {
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_RV%>Rv010I?proType=S&dsType=1&s_SaupSid="+drp_saup.bindcolval
				+"&s_UpjangSid="+drp_upjang.bindcolval+"&s_MenuGubunCd="+drp_menugubun.bindcolval
				+"&s_MenuItem1="+txt_item11.value+"&s_MenuItem2="+txt_item21.value
				+"&s_MenuItem3="+txt_item31.value+"&s_MenuItem4="+txt_item41.value
				+"&s_MenuItem5="+txt_item51.value;
				ds1.Reset(); //���� �׸���
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	: 
%>
		function fnAddRowDs1() {
				ds1.addrow();
				fnCheck("1");//tax_yn(��������)
				fnCheck("2");//use_yn(��뿩��)
				ds1.namevalue(ds1.rowposition,"saup_sid")=drp_saup.bindcolval;
				ds1.namevalue(ds1.rowposition,"upjang_sid")=drp_upjang.bindcolval;
				ds1.namevalue(ds1.rowposition,"menu_gubun_cd")=drp_menugubun.bindcolval;
				window.status="���� ���ԵǾ����ϴ�.";
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	: 
%>
		function fnDeleteRowDs1() {
				if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					ds1.deleterow(ds1.rowposition);
					window.status="���� �����Ǿ����ϴ�.";
					fnApply();
				}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
		function fnApply() {
				if (ds1.IsUpdated) {
					if (fnChk()) {
						txt_save.value="1";
						tr1.KeyValue = "Rv010I(I:INPUT_DATA=ds1)";
						tr1.Action = "<%=dirPath%><%=HDConstant.PATH_RV%>Rv010I?proType=A&dsNum=1";
						tr1.post();
						txt_save.vaue="0";
						ds1.resetstatus();
					}
				}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �з��� �˾�
%>
		function fnPopup(p) {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				//arrParam[0] : head
				//arrParam[1] : detail
				//arrParam[2] : detail_nm
				//arrParam[3] : item1
				if(p=="11") {
					arrParam[0] = "RM006";
					arrParam[1] = "���𱸺�"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_item11.value = arrParam[1];
						txt_item12.value = arrParam[2];
					} else {
				 		txt_item11.value="";
						txt_item12.value="";
					}
				} else if(p=="12") {
					arrParam[0] = "RV003";
					arrParam[1] = "���α���"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_item21.value = arrParam[1];
						txt_item22.value = arrParam[2];
					} else {
				 		txt_item21.value="";
						txt_item22.value="";
					}
				} else if(p=="13") {
					strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_item31.value = arrParam[1];
						txt_item32.value = arrParam[2];
					} else {
				 		txt_item31.value="";
						txt_item32.value="";
					}
				} else if(p=="14") {
					arrParam[0] = "RV014";
					arrParam[1] = "���ɱ���"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_item41.value = arrParam[1];
						txt_item42.value = arrParam[2];
					} else {
				 		txt_item41.value="";
						txt_item42.value="";
					}
				} else if(p=="21") {
					arrParam[0] = "RM006";
					arrParam[1] = "���𱸺�"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_menu_item11.value = arrParam[1];
						txt_menu_item12.value = arrParam[2];
					} else {
				 		txt_menu_item11.value="";
						txt_menu_item12.value="";
					}
				} else if(p=="22") {
					arrParam[0] = "RV003";
					arrParam[1] = "���α���"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_menu_item21.value = arrParam[1];
						txt_menu_item22.value = arrParam[2];
					} else {
				 		txt_menu_item21.value="";
						txt_menu_item22.value="";
					}
				} else if(p=="23") {
					strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_menu_item31.value = arrParam[1];
						txt_menu_item32.value = arrParam[2];
					} else {
				 		txt_menu_item31.value="";
						txt_menu_item32.value="";
					}
				} else if(p=="24") {
					arrParam[0] = "RV014";
					arrParam[1] = "���ɱ���"; //�����ڵ��� �����Ͱ�
					strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
					strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
					arrResult = showModalDialog(strURL,arrParam,strPos);
					if (arrResult != null) {
						arrParam = arrResult.split(";");
			    		txt_menu_item41.value = arrParam[1];
						txt_menu_item42.value = arrParam[2];
					} else {
				 		txt_menu_item41.value="";
						txt_menu_item42.value="";
					}
				}			
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  �Է°� üũ 
%>
		function fnChk() {
				var row1=ds1.countrow;
				for(i=1;i<=row1;i++) {
					if(ds1.namevalue(i,"menu_cd")=="") {
						alert("�޴��ڵ带 �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"menu_item1")=="") {
						alert("�޴�����1�� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"menu_item2")=="") {
						alert("�޴��ڵ�2�� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"menu_item3")=="") {
						alert("�޴�����3�� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"menu_item4")=="") {
						alert("�޴��ڵ�4�� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"menu_item5")=="") {
						alert("��ǰ�ڼ��� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"bgn_date")=="") {
						alert("���� �������ڸ� �Է��� �ֽʽÿ�");
						return false;
					}
					if(ds1.namevalue(i,"end_date")=="") {
						alert("���� �������ڸ� �Է��� �ֽʽÿ�");
						return false;
					}
				}
				return true;
		}
				
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ����� �˾�
%>
			function fnPopup1(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy003h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ""; //�ڵ�
				arrParam[1] = ""; //�ڵ��̸�
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != null) {
					arrParam = arrResult.split(";");
		    		txt_saup_sid.value = arrParam[1];
					txt_saup_sid1.value = arrParam[2];
				} else {
			 		txt_saup_sid.value="";
					txt_saup_sid1.value="";
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description :   �˾�
%>
			function fnPopup2(){ 
			
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy004h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
				arrParam[0] = ""; //�ڵ�
				arrParam[1] = ""; //�ڵ��̸�
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != null) {
					arrParam = arrResult.split(";");
		    		txt_upjang_sid.value = arrParam[1];
					txt_upjang_sid1.value = arrParam[2];
				} else {
			 		txt_upjang_sid.value="";
					txt_upjang_sid1.value="";
				}
			}

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  üũ�ڽ� üũ 
%>
			function fnCheck(p) {
				
				if(p=="1") {
					if(txt_tax_yn.checked==false) {
						ds1.namevalue(ds1.rowposition,"tax_yn")="N";
					}
					else {
						ds1.namevalue(ds1.rowposition,"tax_yn")="Y";
					}
				}else if(p=="2") {
					if(txt_use_yn.checked==false) {
						ds1.namevalue(ds1.rowposition,"use_yn")="N";
					}
					else {
						ds1.namevalue(ds1.rowposition,"use_yn")="Y";
					}
				}
			}		
		
		
		</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object  id=ds1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<object  id=ds4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="SyncLoad" 	value="false">
</object>
<%
/*=============================================================================
			Transaction Components(TR) ����
=============================================================================*/
%>
<object  id="tr1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<param name="KeyName"  value="toinb_dataid4">
</object>		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=ds1 event=CanRowPosChange(row)>
			if(ds1.IsUpdated && txt_save.value=="0") { //��������� �ƴϸ� rowpos�̵��Ұ���
				alert("�������� ���� ������ �ű� �� �����ϴ�.");
				return false;
			}
			else {
				//txt_focus.value=ds1.rowposition;
				return true;
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
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 2
%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ� 2
%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 3
%>
		<script language=JavaScript  for=ds3 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ� 3
%>
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 4
%>
		<script language=JavaScript  for=ds4 event="OnLoadStarted()" >
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ� 4
%>
		<script language=JavaScript  for=ds4 event="OnLoadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			drp_menugubun.bindcolval="1";
		</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : "+ds1.ErroeCode+" "+ds1.ErrorMsg );
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 2 
%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : "+ds2.ErroeCode+" "+ds2.ErrorMsg );
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 3 
%>		
 		<script language=JavaScript  for=ds3 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : "+ds3.ErroeCode+" "+ds3.ErrorMsg );
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 4 
%>		
 		<script language=JavaScript  for=ds4 event="OnLoadError()">
			alert(" ��ȸ�� ������ �߻��߽��ϴ� : "+ds4.ErroeCode+" "+ds4.ErrorMsg );
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
		
	</head>
	
<!--------------------------------- BODY Start ------------------------------->		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"	onLoad="namosw_init_slide_layers('layer1', 2); MM_preloadImages('<%=dirPath %>/Sales/images/com_top_m01.gif','images/com_top_m02<%=dirPath %>/Sales/images/images/com_top_m03.gif','<%=dirPath %>/Sales/images/com_top_m04.gif','<%=dirPath %>/Sales/images/com_top_m05.gif','<%=dirPath %>/Sales/images/com_top_m06.gif','<%=dirPath %>/Sales/images/com_top_m07.gif','<%=dirPath %>/Sales/images/com_top_m08.gif','<%=dirPath %>/Sales/images/com_top_m01_on.gif','<%=dirPath %>/Sales/images/com_top_m02_on.gif','<%=dirPath %>/Sales/images/com_top_m03_on.gif','<%=dirPath %>/Sales/images/com_top_m04_on.gif','<%=dirPath %>/Sales/images/com_top_m05_on.gif','<%=dirPath %>/Sales/images/com_top_m06_on.gif','<%=dirPath %>/Sales/images/com_top_m07_on.gif','<%=dirPath %>/Sales/images/com_top_m08_on.gif','<%=dirPath %>/Sales/images/com_top_m09_on.gif'); fnOnLoad()">
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
								<table width="845px">
									<tr>
										<td>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->
					<table  cellpadding="0" cellspacing="0" border="0">
						<tr> 
							<td width="575px">
					<table width="575px" cellpadding="0" cellspacing="0" border="0"  style='width:575px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090' onload="fnOnLoad()">
						<tr> 
							<td>
									<comment id="__NSID__">
									<object id=drp_saup classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=135 style="position:relative;left:1px;top:2px" class="txtbox" >
										<param name=ComboDataID			value=ds2>
										<param name=SearchColumn		value="saup_nm">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="saup_nm^0^140">
										<param name=BindColumn			value="saup_sid">
									</object>
									</comment><script>__WS__(__NSID__);</script>
							</td>
							<td>
									<comment id="__NSID__">
									<object id=drp_upjang classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=135 style="position:relative;left:1px;top:2px" class="txtbox" >
										<param name=ComboDataID			value=ds3>
										<param name=SearchColumn		value="upjang_nm">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="upjang_nm^0^140">
										<param name=BindColumn			value="upjang_sid">
									</object>
									</comment><script>__WS__(__NSID__);</script>
							</td>
							<td>
									<comment id="__NSID__">
									<object id=drp_menugubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=135 style="position:relative;left:1px;top:2px" class="txtbox" >
										<param name=ComboDataID			value=ds4>
										<param name=SearchColumn		value="detail_nm">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="detail_nm^0^140">
										<param name=enable              value=false>
										<param name=BindColumn			value="detail">
									</object>
									</comment><script>__WS__(__NSID__);</script>
							</td>
							<td>
									����<input id="txt_item11" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:25px; height:20px;" maxlength="5">
									<img src="<%=dirPath%>/Sales/common/img/btn/btn_find.gif" border="0"  ALT="������ �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:2px" align=center onclick="fnPopup('11');">
									<input id="txt_item12" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:30px; height:20px;" maxlength="16"">
							</td>
							<td>
							</td>
						</tr>
						<tr>
							<td>
									����<input id="txt_item21" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:25px; height:20px;" maxlength="5">
									<img src="<%=dirPath%>/Sales/common/img/btn/btn_find.gif" border="0"  ALT="������ �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:2px" align=center onclick="fnPopup('12');">
									<input id="txt_item22" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:30px; height:20px;" maxlength="16"">
							</td>
							<td>
									����<input id="txt_item31" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:25px; height:20px;" maxlength="5">
									<img src="<%=dirPath%>/Sales/common/img/btn/btn_find.gif" border="0"  ALT="������ �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:2px" align=center onclick="fnPopup('13');">
									<input id="txt_item32" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:30px; height:20px;" maxlength="16"">
							</td>
							<td>
									����<input id="txt_item41" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:25px; height:20px;" maxlength="5">
									<img src="<%=dirPath%>/Sales/common/img/btn/btn_find.gif" border="0"  ALT="������ �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:2px" align=center onclick="fnPopup('14');">
									<input id="txt_item42" type="text" class="txtbox"  style= "position:relative;left:0px;top:3px;width:30px; height:20px;" maxlength="16"">
							</td>
							<td>
									��ǰ�ڼ�<input id="txt_item51" type="text" class="txtbox"  style= "position:relative;left:0px;top:1px;width:85px; height:20px;" maxlength="16">
									<inpt id="txt_save" type="hidden" width="1" value="0">
							</td>
						</tr>
					</table>
					</td>
					<td width="270" align="right"><table  cellpadding="0" cellspacing="0" border="0">
						<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
						<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
						<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRowDs1()" >
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
										<td valign=top> 
											<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
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
											<comment id="__NSID__">												
											<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:270px;HEIGHT:400px;border:1 solid #777777;">
												<param name="DataID"		VALUE="ds1">
												<param name="BorderStyle"   VALUE="0">
												<param name="Fillarea"		VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"       value="0">
												<param name="editable"      value="false">
												<param name="Format"		      VALUE="  
													<C> name='' 		ID='{CURROW}' 	HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center </C>						
													<C> name='�������' ID='upjang_nm' HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=left</C>
													<C> name='�޴��ڵ�' ID='menu_cd'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center</C>
													<C> name='�޴���'  	ID='menu_nm'  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left</C>
													">
											</object> 
											</comment><script>__WS__(__NSID__);</script>
											</td>
		           							</tr>
											</table>
										</td>
									<td valign=top>
								<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:5px;top:0px;width:560px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">�޴��ڵ�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px">&nbsp;
											<input id="txt_menu_cd" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="13">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�޴���</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px">&nbsp;
											<input id="txt_menu_nm" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="30">
										</td>
									</tr>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">���𱸺�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_item11" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:40px; height:20px;" maxlength="5">
											<img SRC="<%=dirPath%>/Sales/common/img/btn/com_b_find.gif" BORDER="0" ALT="�޴�����1�� �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnPopup('21');">
											<input id="txt_menu_item12" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:80px; height:20px;" maxlength="16">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">���α���</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_item21" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:40px; height:20px;" maxlength="5">
											<img SRC="<%=dirPath%>/Sales/common/img/btn/com_b_find.gif" BORDER="0" ALT="�޴�����2�� �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnPopup('22');">
											<input id="txt_menu_item22" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:80px; height:20px;" maxlength="16">
										</td>
									</tr>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">����Ÿ��</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_item31" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:40px; height:20px;" maxlength="5">
											<img SRC="<%=dirPath%>/Sales/common/img/btn/com_b_find.gif" BORDER="0" ALT="�޴�����3�� �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnPopup('23');">
											<input id="txt_menu_item32" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:80px; height:20px;" maxlength="16">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">���ɱ���</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_item41" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:40px; height:20px;" maxlength="5">
											<img SRC="<%=dirPath%>/Sales/common/img/btn/com_b_find.gif" BORDER="0" ALT="�޴�����4�� �˻��մϴ�" style="cursor:hand;position:relative;left:-5px;top:0px" align=center onclick="fnPopup('24');">
											<input id="txt_menu_item42" type="text" class="txtbox"  style= "position:relative;left:-5px;top:3px;width:80px; height:20px;" maxlength="16">	
										</td>
									</tr>	
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">��ǰ�ڼ�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_item51" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:40px; height:20px;" maxlength="5">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�޴������</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_short_nm" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="12">
										</td>
									</tr>	
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�����ο�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_bgn_persons" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="2">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�����ο�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_end_persons" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="2">
										</td>
									</tr>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�����������</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_bgn_date" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="8">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">������������</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;											
											<input id="txt_end_date" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="8">
										</td>
									</tr>
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">������</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_menu_eng_nm" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="30">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">��������</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_tax_yn" type="checkbox" style= "position:relative;left:-5px;top:0px;width:20px; height:20px;" onclick="fnCheck('1')">
										</td>
									</tr>	
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�ܰ�</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;
											<input id="txt_unit_amt" type="text" class="txtbox"  style= "position:relative;left:-5px;top:0px;width:100px; height:20px;" maxlength="10">
										</td>
										<td style="width:100px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">����/�ΰ�����</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px">&nbsp;

										</td>
									</tr>	
									<tr>
										<td style="width:100px;height:30px;border:1 solid #708090;border-top-width:0px" bgcolor="#eeeeee" align=center class="txtbox">��뿩��</td>
										<td style="width:200px;height:30px;border:1 solid #708090;border-left-width:0px;border-top-width:0px" colspan="3">&nbsp;
											<input id="txt_use_yn" type="checkbox" style= "position:relative;left:-5px;top:0px;width:20px; height:20px;" onclick="fnCheck('2')">
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->		
										</td>
									</tr>
								</table>
								
						
							</td>
						</tr>
					</table>
				</td>
			</tr>
<!-- ���α׷� ���� BODY END -->			
		</table>
	
	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds1">           
	<param name=BindInfo	value="                                                
	<C>Col=menu_cd  	           Ctrl=txt_menu_cd            Param=value</C>
	<C>Col=menu_nm                 Ctrl=txt_menu_nm            Param=value</C>
	<C>Col=menu_item1              Ctrl=txt_menu_item11        Param=value</C>
	<C>Col=menu_item1_nm           Ctrl=txt_menu_item12        Param=value</C>
	<C>Col=menu_item2              Ctrl=txt_menu_item21        Param=value</C>
	<C>Col=menu_item2_nm           Ctrl=txt_menu_item22        Param=value</C>
	<C>Col=menu_item3              Ctrl=txt_menu_item31        Param=value</C>
	<C>Col=menu_item3_nm           Ctrl=txt_menu_item32        Param=value</C>
	<C>Col=menu_item4              Ctrl=txt_menu_item41        Param=value</C>
	<C>Col=menu_item4_nm           Ctrl=txt_menu_item42        Param=value</C>
	<C>Col=menu_item5              Ctrl=txt_menu_item51        Param=value</C>
	<C>Col=menu_short_nm           Ctrl=txt_menu_short_nm      Param=value</C>
	<C>Col=bgn_persons         	   Ctrl=txt_bgn_persons        Param=value</C>
	<C>Col=end_persons             Ctrl=txt_end_persons        Param=value</C>
	<C>Col=bgn_date           	   Ctrl=txt_bgn_date           Param=value</C>
	<C>Col=end_date                Ctrl=txt_end_date           Param=value</C>
	<C>Col=tax_yn1				   Ctrl=txt_tax_yn             Param=checked</C>
	<C>Col=unit_amt                Ctrl=txt_unit_amt           Param=value</C>
	<C>Col=use_yn1                 Ctrl=txt_use_yn             Param=checked</C>
	">	
</object>
<%
/*=============================================================================
			Status Bar Falsh
=============================================================================*/
%>	
	<iframe id="LowerFrame" 
			name="work" 
			style="visibility:hidden; position:absolute; left:350px; top:300px;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
			width="320px" 
			height="42px">
	</iframe>		
<!---------------------------------- BODY End -------------------------------->	
	</body>
</html>