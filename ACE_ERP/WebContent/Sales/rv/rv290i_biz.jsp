<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : �������� ���� ����ȭ��
 * ���α׷�ID 	 :  RV290
 * J  S  P		 : RV290
 * �� �� ��		 : RV290
 * �� �� ��		 : ���ϳ�
 * �� �� ��		 : 2009-05-15
 * �������		 : �������� ���� ����ȭ��
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
   String firstday = m_today.format(date.getTime());		   
%>


<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	// �������ε�
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
	//����ȸ
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		gr1.TitleHeight = "35";        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";        
        alert("1");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv290I",
            "JSP(O:DS2=ds2,O:DS3=ds3,O:DS5=ds5,O:DS6=ds6)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);	
        alert("2");
	}
	//������ȸ
	function fnSelect() {
	alert("5");
		    v_job = "S";
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sSN=" + sSN.value  	//serial_no
	            + ",sMODEL=" 	+ sMODEL.value 				//��
	            + ",sKIND=" 	+ sKIND.Text 						//ǰ��
	            + ",sCOMPANY_NM=" 	+ sCOMPANY_NM.value   		//�ҼӾ�ü
	            + ",sCUST_NM=" 	+ sCUST_NM.value					 //����� �̸�
	            + ",sUSE=" 	+ sUSE.Text 						//�뵵
	            + ",sFROM_OUT_DT=" 	+ sFROM_OUT_DT.Text 	//������
	            + ",sTO_OUT_DT=" 	+ sTO_OUT_DT.Text 			//������
	            + ",sFROM_IN_DT=" 	+ sFROM_IN_DT.Text 			//������
	            + ",sTO_IN_DT=" 	+ sTO_IN_DT.Text;		   			//������         	             
			alert(param);
	       	ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv290I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
	<%
	// ���߰� (�׸��庰)
	%>
	function fnAddRow() {
	alert("3");
		ds1.addrow();
    }
	<%
	// ����� (�׸��庰)
	%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
		alert("4");
	}

	//����
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	         ln_TRSetting(tr1, 
	              "<%=dirPath%><%=HDConstant.PATH_RV%>Rv290I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	// ���
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	
<% 
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ��� 
// Parameter    : 
%>
    function fnExcel() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("ds1").SetExcelTitle(0, "");
        getObjectFirst("ds1").SetExcelTitle(1, "value:�������� �������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("ds1").GridToExcel("�������� �������", "�������� �������.xls", 8);
    }
 
  function fnUpload() {
				//ln_SetHeader();
				//gcds_data.UseChangeInfo = "false"; 
				tb_InputFile.Open();	  
				ds1 = tb_InputFile.Value;
			   ds1.Reset();				
}  
    	
	
 // �ο� �˾� : �ο� �׸��忡�� 
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rv290i_03.jsp"
		strPos = "dialogWidth:420px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"CUST_NM") = arrParam[0];
	   	//	ds1.namevalue(ds1.rowposition, "D_RSV_SID") = arrParam[3];
	   		ds1.namevalue(ds1.rowposition, "COMPANY_NM") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"CUST_NM") = "";
	  // 		ds1.namevalue(ds1.rowposition, "D_RSV_SID") = "";
			ds1.namevalue(ds1.rowposition,"COMPANY_NM") = 
   		}					
	}			 	 
	
			
// ��ǻ�� ��ȸ  �˾� :  �׸��忡�� 
function fnComputerPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rv290i_05.jsp"
			strPos = "dialogWidth:420px;dialogHeight:570px;status:no;scroll:no;resizable:no";		
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				ds1.namevalue(ds1.rowposition,"KIND") = arrParam[0];
		   		ds1.namevalue(ds1.rowposition,"SN")   = arrParam[1];
		   		ds1.namevalue(ds1.rowposition,"MODEL") = arrParam[2];
		   		ds1.namevalue(ds1.rowposition,"CPU") = arrParam[3];
		   		ds1.namevalue(ds1.rowposition,"RAM") = arrParam[4];
		   		ds1.namevalue(ds1.rowposition,"HDD") = arrParam[5];
		   		ds1.namevalue(ds1.rowposition,"USE") = arrParam[6];
		   		ds1.namevalue(ds1.rowposition,"NOTE") = arrParam[7];
		   		ds1.namevalue(ds1.rowposition,"COM_KEY") = arrParam[8];		   				   				   				   		
			} else {
				ds1.namevalue(ds1.rowposition,"KIND") = "";
				ds1.namevalue(ds1.rowposition,"SN") = "";
				ds1.namevalue(ds1.rowposition,"MODEL") = "";
				ds1.namevalue(ds1.rowposition,"CPU") = "";
				ds1.namevalue(ds1.rowposition,"RAM") = "";
				ds1.namevalue(ds1.rowposition,"HDD") = "";
				ds1.namevalue(ds1.rowposition,"USE") = "";
				ds1.namevalue(ds1.rowposition,"NOTE") = "";
				ds1.namevalue(ds1.rowposition,"COM_KEY") = "";
		  			  			  
			}				
		}	
		
//���¾�ü ��ȸ �˾� 				
function fnClientPopup() {
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	 
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/rv290i_04.jsp"
			strPos = "dialogWidth:420px;dialogHeight:350px;status:no;scroll:no;resizable:no";		
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
			if (arrResult != null) {
				arrParam = arrResult.split(";");
		   		sClient_sid.value = arrParam[0];
		   		sClient_nm.value = arrParam[1];
			} else {
			  sClient_nm.value = "";
			  sClient_sid.value = "";
			}				
		}	
		

					
	</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && ( colid=='south_permit_yn' || colid=='north_permit_yn' ) ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }	
		</script>	
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="CUST_NAME") {
			fnCustPopup();
		}
		else if (colid=="SN") {
			fnComputerPopup();
		}		
		</script>         
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
	<%
		// �۾�����
	%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg);             
	</script>
<%
		// �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        //���� �޽���
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);      
        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		       
	</script>
<%
	//�۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
	//�۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);            
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds5 event="OnLoadCompleted(row)">
	//	lc4.index=lc4.IndexOfColumn("detail","1");
	</script>
	
	<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
		//div='';	
		//fnSelectDs4(); 	
	</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
		<%=HDConstant.COMMENT_START%>
		<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="false">
		</object>
		<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value=false>
		</object>
		<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
		    <param name="SyncLoad"  value="False">
		</object>
		<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		    <param name="ServerIP"   value="">
		    <param name="Action"     value="">
		    <param name="KeyName"    value="">
		    <param name="KeyValue"   value="">
		    <param name="Parameters" value="">
		</object>
		<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
		    <param name="ServerIP"   value="">
		    <param name="Action"     value="">
		    <param name="KeyName"    value="">
		    <param name="KeyValue"   value="">
		    <param name="Parameters" value="">
		</object>
		<%=HDConstant.COMMENT_END%>
		</head>
		<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">												
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand"  onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/plus.gif"	 	style="cursor:hand"  onClick="fnAddRow()" >
            									<img src="<%=dirPath%>/Sales/images/minus.gif" 		style="cursor:hand"  onClick="fnDeleteRow()" >
												<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand"  onClick="fnApply();">
												<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
												<object id=tb_InputFile classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03 style="position:absolute;left:305;top=20; width=0; height=0;">
												<param name="Text"		value='fnUpload'>
												</object>
												&nbsp; <img src="<%=dirPath%>/Sales/images/upload.gif"   	style="cursor:hand"  onclick="fnUpload()">																					
												<img src="<%=dirPath%>/Sales/images/excel.gif"   	style="cursor:hand"  onclick="fnExcel()">													
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                        	<tr bgcolor="#6f7f8d">
		            						<td align="center" width="100px" class="text">Serial_No</td>
											<td align="center" bgcolor="#ffffff">
												<input type="text" name="sSN" value="" size="29" maxlength="40" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align="center" width="100px" class="text">��</td>
											<td align="center" bgcolor="#ffffff">
												<input type="text" name="sMODEL" value="" size="29" maxlength="40" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
											</td>
			            					<td align=center width=100 class="text">&nbsp;&nbsp;&nbsp;ǰ��&nbsp;&nbsp;&nbsp;</td>
			                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																										
													<comment id="__NSID__">
						    						<object id=sKIND classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
						    							<param name=CBData			value="1^��Ʈ��,2^����ũž,3^PDA">
														<param name=CBDataColumns		value="Code, Parm">
														<param name=SearchColumn		value="Parm">
														<param name=Sort						value="false">
														<param name=ListExprFormat	value="Parm^0^80">
														<param name=BindColumn			value="Code">
														</OBJECT></comment><script>__ws__(__NSID__);</script>
											</td>
			            				</tr>	
					                        	<tr bgcolor="#6f7f8d">
				            						<td align="center" width="100px" class="text">�Ҽ�</td>
													<td align="center" bgcolor="#ffffff">
													<input type="text" name="sCOMPANY_NM" value="" size="20"  class="textbox">
														<!--<input type="text" name="sClient_nm" value="����ƻ�(��)" size="20" readonly="readonly" class="textbox">&nbsp;
														<input type="hidden" name="sClient_sid"  value="1237" size="5" readonly="readonly" class="textbox">&nbsp;
														<img src="/services/Sales/images/help.gif" 	style="cursor:hand" 	align=absmiddle onClick="fnClientPopup();" > -->
													</td>
					            					<td align="center" width="100px" class="text">�̸�</td>
													<td align="center" bgcolor="#ffffff"><input type="text" name="sCUST_NM" value="" size="29" maxlength="30" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">
													</td>
					            					<td align=center width=100 class="text">&nbsp;&nbsp;&nbsp;�뵵&nbsp;&nbsp;&nbsp;</td>
					                                <td align=center bgcolor="#ffffff" colspan="3">&nbsp;																										
															<comment id="__NSID__">
								    						<object id=sUSE classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100  class="txtbox"  align=absmiddle >
																<param name=CBData					value="1^�����,2^����ҿ�">
																<param name=CBDataColumns		value="Code, Parm">
																<param name=SearchColumn		value="Parm">
																<param name=Sort						value="false">
																<param name=ListExprFormat	value="Parm^0^80">
																<param name=BindColumn			value="Code">
																</OBJECT></comment><script>__ws__(__NSID__);</script>
													</td>
					            				</tr>	
					     		               	<tr bgcolor="#6f7f8d">
				            						<td align="center" width="100px" class="text">������</td>
													<td align="center" bgcolor="#ffffff">
														<comment id="__NSID__">
														<object id=sFROM_OUT_DT classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
														~
														<comment id="__NSID__">
														<object id=sTO_OUT_DT classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
													</td>
					            					<td align="center" width="100px" class="text">������</td>
													<td align="center" bgcolor="#ffffff">
														<comment id="__NSID__">
														<object id=sFROM_IN_DT classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
														~
														<comment id="__NSID__">
														<object id=sTO_IN_DT classid='clsid:E6876E99-7C28-43AD-9088-315DC302C05F' codebase='http://erp.hdasan.com/services/Sales/common/component/cabfiles/ToinbEMEdit.cab#version=1,1,1,61'   height='16px' width='80px' align='absmiddle' class='textbox'>			
															<param name=Alignment 	value=1>
															<param name=Format      value="YYYY-MM-DD">
							                                <PARAM NAME=InputFormat value="YYYYMMDD">
							                                <param name=Cursor      value="iBeam">
							                                <param name=Border      value="false">
							                                <param name=InheritColor      value="true">
							                                <param name=ReadOnly    value="false">
							                                <param name=SelectAll   value="true">
							                                <param name=SelectAllOnClick    value="true">
							                                <param name=SelectAllOnClickAny   value=false>
														</object>
														</comment><script>__WS__(__NSID__);</script>
												</td>
													<td align=center class="text" colspan="4"></td>
					                                								
					            				</tr>			            				
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption	value=1>								                                        
										<param name="Format" 		value="
        								   <C> name='COM_KEY'      ID='COM_KEY'	align=left editlimit=30 show=false width=30</C>										
							               <C> name='ǰ��'   			ID='KIND' 		 width=70 	align=left 	EditStyle=Combo 
			 										Data='1:��Ʈ��,2:����ũž,3:PDA,4:POS'		editlimit=200 	show=true </C>										
										   <C> name='Serial_No'     	ID='SN' 		 width=80 	BgColor=#fefec0   align=left editlimit=200 	editstyle=popup show=true </C>
							               <C> name='CPU'    			ID='CPU'   	 		 width=70   align=left 	editlimit=200 	show=true </C>
							               <C> name='HDD'      			ID='HDD'     	 	 width=70 	align=left 	editlimit=200 	show=true </C>
							               <C> name='RAM'      		ID='RAM'     	 	 width=70 	align=left 	editlimit=200 	show=true </C>										   
							               <C> name='�𵨸�'   			ID='MODEL' 		 width=70 	align=left 	editlimit=200 	show=true </C>
							               <C> name='�Ҽ�'    			ID='COMPANY_NM'   	 	 width=80 	align=left 	  editlimit=200  show=true</C>
							               <C> name='�̸�'    			ID='CUST_NM'   	 	 width=80 	align=center 	editlimit=200  BgColor=#fefec0 	editstyle=popup show=true</C>							               
							               <C> name='������'    		ID='OUT_DT'   width=80 	align=center 	Mask=XXXX-XX-XX  editlimit=200  	show=true </C>
							               <C> name='������'        	ID='IN_DT'     width=80 	align=center 	Mask=XXXX-XX-XX </C>
							               <C> name='�뵵'       	    ID='USE'       width=80 	align=left 	EditStyle=Combo 
			 										Data='1:�����,2:����ҿ�' editlimit=200  	show=true</C>
							               <C> name='���'   			ID='NOTE'  	 		 width=100 	align=left 	editlimit=200 show=true</C>					           
										">
									</object>
									<%=HDConstant.COMMENT_END%>
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
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
