<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : �����⺰ ������ ��Ȳ
 * ���α׷�ID 	 : AM120I
 * J  S  P		     : AM120I
 * �� �� ��		 : AM120I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2008-12-05
 * �������		 : �����⺰ ������ ������Ȳ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
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
	}
	//������ȸ
	function fnSelect() {
		    v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sITEM_SID=" 	+ sITEM_SID.value
	            + ",sMODEL_NM=" + sMODEL_NM.value;
	       	ln_TRSetting(tr1, 
	           "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Am120I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
   }
	
	// �ο� �˾� : �ο� �׸��忡�� 
	function fnCustPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:420px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds1.namevalue(ds1.rowposition,"EMPNO") 	= arrParam[0];
	   		ds1.namevalue(ds1.rowposition,"EMPNMK")  = arrParam[1];
	   		
	   	} else {
			ds1.namevalue(ds1.rowposition,"EMPNO") 	= "";
	   		ds1.namevalue(ds1.rowposition, "EMPNMK") = "";
	   	}				
		
	}
	
		function fnExcel() {
		    getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("�̸����","�̸����.xls", 8);
	
	}
	</script>
	
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="EMPNMK") {
			fnCustPopup();
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
		<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

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
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onClick="fnExcel();">
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
		            						<td align=CENTER width="100px" class="text">SERIAL_NO</td>
											<td align=CENTER bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sITEM_SID" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
			            					<td align=CENTER width=100 class="text">&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;</td>
			                                <td align=CENTER bgcolor="#ffffff" colspan="3">&nbsp;																										
												<input id="sMODEL_NM" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:200px; height:20px;">
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
							               <C> name='S/N'	 ID='ITEM_SID' 		width=50  align=center 	  show=true edit=true						</C>
							               <C> name='�𵨸�'   	 ID='MODEL_NM' 		width=100  align=center 	  show=true edit=true						</C>
							               <C> name='������'     ID='MADE_COMPANY'  width=60  align=center 	  show=true editlimit=200 		edit=true	</C>
							               <C> name='CPU'      	 ID='CPU'     	 	width=150  align=right	  show=true BgColor=#fefec0  	editlimit=12 edit=true </C>
							               <C> name='HDD'      	 ID='HDD'     	 	width=40  align=right	  show=true BgColor=#fefec0  	editlimit=12 edit=TRUE </C>
							               <C> name='RAM'  		 ID='RAM'      	 	width=40  align=right	  show=true BgColor=#fefec0  	editlimit=20 edit=TRUE </C>
							               <C> name='GRAPHIC'    ID='GRAPHIC'   	width=40  align=right	  show=true BgColor=#fefec0  	editlimit=20 edit=TRUE </C>
							               <C> name='�μ�'       ID='DEPTNM'       	width=70  align=right	  show=true align=left 			Edit=true  </C>
							               <C> name='���'       ID='EMPNO'        	width=50  align=right	  show=true align=left 			Edit=true </C>
							               <C> name='����'       ID='EMPNMK'      	width=50  align=right	  show=true BgColor=#b4f0b4  	editlimit=20 editstyle=popup </C>
							               <C> name='���'   	 ID='REMARKS'  	 	width=100 align=right	  show=true BgColor=#fefec0  	editlimit=30 edit=TRUE</C>
							               <C> name='��������'   ID='PURCHASE_DATE' width=60  align=right	  show=true editlimit=200 		edit=true </C>
										   <C> name='�ݳ�����'   ID='RETURN_DATE'  	width=60  align=right	  show=true editlimit=200 		edit=true </C>
										   <C> name='�������'   ID='DONE_DATE'  	width=60  align=right	  show=true editlimit=200 		edit=true </C>
							               <C> name='ASSETCODE'	 ID='ASSETCODE' 	width=60  align=center 	  show=true edit=true						</C>
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

