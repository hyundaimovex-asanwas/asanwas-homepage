<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���Ϻι�ȣ ����
 * ���α׷�ID 	 : RV760I_00001
 * J  S  P		 : rm760i_00001
 * �� �� ��		 : RM760I_00001
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-07-07
 * �������		 :  ���Ϻι�ȣ ���� (��ȣ����, �ϰ�����, ��ȸ, ����, ���)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-12-02][�ڰ汹] ��� ������ �˻����� �߰�
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
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			sBgnDate.text='<%=firstday%>';		
			fnInit();
		}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
            "JSP(O:DS5=ds5,O:DS8=ds8)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

		ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds2.Reset(); //�����ڵ�
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {        
			if ( sBgnDate.text.trim() == '' ) {
				alert("������ڸ� �Է����ּ���.");
				return;
			}			
	        v_job = "S";
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			var Row = ds5.NameValueRow("detail","1");
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","
	            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
	            + "sGoodsSid=" + ds4.namevalue(ds4.rowposition,"goods_sid") + ","
	            + "sCustGu=" + ds5.namevalue(ds5.rowposition,"detail") + ","
	            + "sClass=" + ds6.namevalue(ds6.rowposition,"class") + ","
	            + "sTeams=" + ds7.namevalue(ds7.rowposition,"teams") + ",";
	            if ( sSRejectYn.checked == true ) 
		            param += "sSRejectYn=Y,";	            	
		        else 
		            param += "sSRejectYn=N,"	            			        
	            param += "sCountryGu=" + ds8.namevalue(ds8.rowposition,"country_gu");	
	            
	            ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ���ð�, ��ǰ��ȸ
	 */		
	function fnSelectDs3() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS3=ds3,O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	
	/*
	 * ����ȸ
	 */		
	function fnSelectDs6() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text + ","	            
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time");			
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS6=ds6)",
            param);
        tr_post(tr3);
	}	  
	/*
	 * �� ��ȸ
	 */		
	function fnSelectDs7() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sDepartDate=" + sBgnDate.text + ","	
            + "sDepartTime=" + ds3.namevalue(ds3.rowposition,"depart_time") + ","        
            + "sClass=" + ds6.namevalue(ds6.rowposition,"class");
        ln_TRSetting(tr4, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv710I",
            "JSP(O:DS7=ds7)",
            param);
        tr_post(tr4);
	}		
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.isUpdated ){ 
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv760I",
	             "JSP(I:DEFAULT=ds1,O:DS9=ds9)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
         }
	}
	/*
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow() {
		if ( ds1.CountRow < 1 ) {
			alert("�ּ��� �ϳ� �̻��� �����Ͱ� �־�� �մϴ�.");
			return;
		}
		var maxUnityNo = 1;
		var row = 1;
		for ( i=1;i<=ds1.CountRow;i++ ) {
			if ( ds1.namevalue(i,"unity_no").length == 12 && ds1.namevalue(i,"unity_no") != '' ) {
				maxUnityNo = Number(ds1.namevalue(i,"unity_no").substring(8,12));
				row = i;
				break;
			}
		}
		for ( j=1;j<=ds1.CountRow;j++ ) {
			if ( ds1.namevalue(j,"unity_no").length == 12 && ds1.namevalue(j,"unity_no") != '' && ( maxUnityNo < Number(ds1.namevalue(j,"unity_no").substring(8,12)) ) ) {
				maxUnityNo = Number(ds1.namevalue(j,"unity_no").substring(8,12));
				row = j;
			}
		}
//		ds1.addrow();
		for ( k=1;k<=ds1.CountRow;k++ ) {
			if ( ds1.namevalue(k,"unity_no") == '' ) {
				maxUnityNo += 1;					
				if ( maxUnityNo < 10 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "000" + maxUnityNo;
				else if ( maxUnityNo < 100 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "00" + maxUnityNo;						
				else if ( maxUnityNo < 1000 ) 
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + "0" + maxUnityNo;												
				else
					ds1.namevalue(k,"unity_no") = ds1.namevalue(row,"unity_no").substring(0,8) + maxUnityNo;																				
			}
		}
	}	
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();		
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	/*
	 * ��ȣ����
	 */
	function fnEraser() {
		if (ds1.CountRow < 1 ) {
			alert("�ּ��� �ϳ� �̻��� �����Ͱ� �־�� �մϴ�.");
			return;
		}		
        window.status="��ȣ�� ����� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";	
		for( i=1; i<=ds1.CountRow; i++ )
			ds1.namevalue(i,"unity_no") = '';		
        window.status="��ȣ������ �Ϸ� �Ǿ����ϴ�.";				
	}		
	/*
	 * �ϰ�����
	 */
	function fnCreate() {
		if ( ds1.CountRow < 1 ) {
			alert("�ּ��� �ϳ� �̻��� �����Ͱ� �־�� �մϴ�.");
			return;
		}	
      
      window.status="�ϰ����� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
      var count=1;
		if(ds2.namevalue(ds2.rowposition,"saup_sid")=="2"){
			count=5001;
		}

		for(i=1;i<=ds1.CountRow;i++ ) {
         ds1.namevalue(i,"data_modify") = 'T';									
         if (count < 10 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "000" + count;
         else if ( count < 100 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "00" + count;						
         else if ( count < 1000 ) 
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + "0" + count;												
         else
            ds1.namevalue(i,"unity_no") = ds1.namevalue(i,"default_unity_no") + count;																		
         count++;
		}
      window.status="�ϰ������� �Ϸ�Ǿ����ϴ�.";		
	}
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDs3();			
			}
		}				
	</script>

	<script language=JavaScript for= lc1 event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDs3();
		}
	</script>	
	
	<script language=JavaScript for= lc2 event=OnSelChange()>
		if ( div != 'init' ) {	//���ð�
			div = 'init';					
			fnSelectDs6();		
		}
	</script>	
	
	<script language=JavaScript for= lc5 event=OnSelChange()>
		if ( div != 'init' ) {	//��
			div = 'init';					
			fnSelectDs7();		
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            //�޽��� ó��
            if ( ds9.namevalue(1,"pMsg") != '' )
            	alert(ds9.namevalue(1,"pMsg"));
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        //�����޽���ó��
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
		    
		//�޽���ó��
        if ( ds9.namevalue(1,"pMsg") != '' )
        	alert(ds9.namevalue(1,"pMsg"));		    
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onsuccess()">
		div='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr4" event="onfail()">
		div='';	
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
          
        var alertMsg = '';
       	var nErrCnt = tr4.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr4.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr4.SrvErrMsg("ERROR", i) + "\n";            
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	totalNum.value = ds1.CountRow;
</script>

<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	fnSelectDs3();
</script>

<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	fnSelectDs6();
</script>

<script language=JavaScript  for=ds6 event="OnLoadCompleted(row)">
	fnSelectDs7();
</script>

<script language=JavaScript  for=ds7 event="OnLoadCompleted(row)">
	div='';
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
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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
				<tr>
					<td align="right" colspan="2">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/eraser.gif"   	style="cursor:hand" onclick="fnEraser()">
									<img src="<%=dirPath%>/Sales/images/bundle.gif"		style="cursor:hand" onClick="fnCreate();">																																		
									<img src="<%=dirPath%>/Sales/images/add_create.gif"		style="cursor:hand" onClick="fnAddRow();">			
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
					 			</td>
							</tr>	
						</table>
					</td>											
				</tr>
				<tr height="50px">
					<td align="left"  colspan='2' width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="710px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d" height=26>
			            					<td align=left class="text" width="70">����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds2>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left class="text"  width="70"><b>�������</b></td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
  												<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
													<param name=Text 		value="">
													<param name=Alignment 	value=1>
													<param name=Format 		value="0000-00-00">
													<param name=Cursor	 	value="iBeam">
													<param name=Border	 	value="false">		
													<param name=InheritColor      value="true">																																																				
													<param name=ReadOnly  	value="false">
													<param name=SelectAll  	value="true">
													<param name=SelectAllOnClick  	value="true">		
													<param name=SelectAllOnClickAny  	value="false">																							
												</object>
												<%=HDConstant.COMMENT_END%>&nbsp;	
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="depart_time">
                                                    <param name=BindColVal      value="depart_time">
													<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^50"></object>
												<%=HDConstant.COMMENT_END%>																				
											</td>																							
			            					<td align=left class="text" width="70">��ǰ����</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds4>
													<param name=BindColumn      value="goods_sid">
                                                    <param name=BindColVal      value="goods_sid">
													<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
													<param name=ListExprFormat  value="goods_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>&nbsp;	
											</td>
										</tr>
			                            <tr bgcolor="#6f7f8d" height=26>	
			            					<td align=left class="text" width="70">��/��</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc5 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds6>
													<param name=BindColumn      value="class">
                                                    <param name=BindColVal      value="class">
													<param name=EditExprFormat	value="%,%;class,class_nm">
													<param name=ListExprFormat  value="class_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>	
												<%=HDConstant.COMMENT_START%>
					                            <object id=lc6 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds7>
													<param name=BindColumn      value="teams">
                                                    <param name=BindColVal      value="teams">
													<param name=EditExprFormat	value="%,%;teams,teams_nm">
													<param name=ListExprFormat  value="teams_nm^0^70"></object>
												<%=HDConstant.COMMENT_END%>																					
											</td>											                            
			            					<td align=left class="text" width="70">������</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
											<%=HDConstant.COMMENT_START%>
					                            <object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds5>
													<param name=BindColumn      value="detail">
                                                    <param name=BindColVal      value="detail">
													<param name=EditExprFormat	value="%,%;detail,detail_nm">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>		
											</td>	
		            						<td align=left class="text" width="70">��������</td>
			                                <td align=left bgcolor="#ffffff" valign="middle" colspan="5">&nbsp;																							
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc7 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=120 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds8>
													<param name=BindColumn      value="country_gu">
                                                    <param name=BindColVal      value="country_gu">
													<param name=EditExprFormat	value="%,%;country_gu,country_gu_nm">
													<param name=ListExprFormat  value="country_gu_nm^0^120">
												</object>
												<%=HDConstant.COMMENT_END%>	
											</td>	
			            				</tr>		
			            			</table>
			            			<td  id=cancel_cd width="130px">
										<table width='130' border='0' cellpadding='0' cellspacing='0' style='border:1px solid #6f7f8d'>
											<tr >
												<td width='130' height='20'>
													<table width='100%' border='0' cellspacing='0' cellpadding='0'>
														<tr >
															<td width='25' height='25'><input name='sSRejectYn' type='checkbox' value='Y'></td>
															<td>&nbsp;��� ������</td>
														</tr >
													</table>							
												</td>							
											</tr>
										</table>
									</td>	
								</tr>															
							</table>
						</td>											
					</tr>
					<tr height="10">
						<td colspan='2'></td>
					</tr>													
					<tr>
						<td width="845px" colspan='2'>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
	                            			<param name="DataID"		VALUE="ds1">
	                            			<param name="BorderStyle"   VALUE="0">
	                            			<param name=ColSizing       value="true">
	                            			<param name="editable"      value="true">
	                            			<param name=UsingOneClick  	value="1">
	                                        <Param Name="AllShowEdit"   value="True">
	                                        <param name="SortView"      value="Right">
											<param name=SuppressOption value=1>								                                        
											<param name="Format" 			value="
								               <C> name='���Ϻι�ȣ'     ID='unity_no'    width=100 align=center editlimit=12 show=true</C>
								               <C> name='��'        ID='class'        BgColor=#fefec0 width=40 align=right editlimit=3 edit=none show=true</C>
								               <C> name='��'        ID='teams'      BgColor=#fefec0 width=40  align=right editlimit=3 edit=none show=true</C>
								               <C> name='����Ÿ��' ID='room_type_cd'     BgColor=#fefec0 width=60   align=center edit=none editlimit=10 show=true</C>
								               <C> name='����'      ID='cust_nm'     BgColor=#fefec0 width=60 align=left editlimit=30 edit=none sort=true show=true</C>
								               <C> name='�ֹι�ȣ'    ID='manage_no'   BgColor=#fefec0 width=90  align=center editlimit=20 edit=none show=true</C>
								               <C> name='������'   ID='cust_gu_nm'  BgColor=#fefec0 width=60 align=left editlimit=50 edit=none show=true</C>
								               <C> name='�ּ�'     ID='address1'    BgColor=#fefec0 width=170  align=left editlimit=60 edit=none show=true</C>
								               <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
								               <C> name='�⺻���Ϻι�ȣ'     ID='default_unity_no'    align=left editlimit=8 show=false</C>
								               <C> name='data_modify'     ID='data_modify'    align=left editlimit=8 show=false</C>															               
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
		<tr id="total">
			<td width="845px" height="30" class="textbox" style="border:0">
				�ѰǼ� : <input type="text" name="totalNum" style="border:0;align=left" width="20">
			</td>
		</tr>							
	</table>
	
	<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
	
	<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
	
