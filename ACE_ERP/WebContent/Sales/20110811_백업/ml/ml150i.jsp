<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��û���_���� 
 * ���α׷�ID 	 : RV270I
 * J  S  P		 : rv270i
 * �� �� ��		 : RV270I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2010-08-09
 * �������	 : ��û���_����
 * [ �������� ][������] ����
 * [2010-12-20][�ɵ���] ������Ʈ ��.. ��.. ���� UI��.. ��;;
 * [2010-12-20][�ɵ���] ������� ����� ���� �ϴ�
 * [2011-01-19][�ڰ汹] �ֹ����(������Ʈ) ȭ��.
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.util.Calendar" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);		   
   String firsttime = m_today.format(date.getTime()).substring(8,12);		      
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
	var v_default_row = 1;
    var v_job = "H";
	<%//�������ε�%>
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	<%//Ʈ���ʱ�ȭ ȣ��%>
			cfStyleGrid(getObjectFirst("gr_default"), "comn");
	        cfStyleGrid(getObjectFirst("gr_master"), "comn");
			cfStyleGrid(getObjectFirst("gr_detail"), "comn");
			fnInit();
		}
	<%// ����Ÿ�� ��� ����%>
	function fnSetHeader(){
		if (ds_default.countrow < 1){
			v_job = "H";
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
	            "JSP(O:DEFAULT=ds_default, O:DETAIL=ds_detail)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);           
		}
	}
	<%// ����ȸ%>
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>'; 
		order_date.text='<%=firstday%>'; 
		
		<%//����%>
        ds_cate1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=ML003&s_item1=Y";
        ds_cate1.Reset(); 
		
        v_job = "H";
        fnSetHeader();
   }
	
	function fnSelect(){
	    gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
					+ "sEmpNo=" + empno.value + "," 
					+ "sUserNm=" + user_nm2.value + "," 
                    + "sOrderNo=" + sOrderNo.text + ","                         
				    + "sBgnDate=" + sBgnDate.text + ","                         
        		    + "sEndDate=" + sEndDate.text;    
        //alert(v_param);                
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
           // "JSP(O:DEFAULT=ds_default, O:DETAIL=ds_detail)",
            "JSP(O:DEFAULT=ds_default)",
            v_param);
        tr_post(tr1);
    }
    
    
    function fnSelectMaster(){
        gr_default.ReDraw = "True";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" 
			    	+ ",sCate1=" + ds_cate1.namevalue(ds_cate1.rowposition,"detail");
        //alert(v_param);                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
     function fnSelectMaster2(){
        gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" 
			    	+ ",sCate1=" + ds_cate1.namevalue(ds_cate1.rowposition,"detail");
        //alert(v_param);                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    function fnSelectDetail(){
	    gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" 
					+ ",sOrderNo="+ ds_default.NameValue(ds_default.rowposition, "order_no")
                    + ",sOrderDate="+ ds_default.NameValue(ds_default.rowposition, "order_date");
        //alert(v_param);                
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
           // "JSP(O:DEFAULT2=ds_default, O:DETAIL2=ds_detail)",
            "JSP(O:DETAIL2=ds_detail)",
            v_param);
        tr_post(tr1);
    }
    
	<%// ���߰�(�׸��庰)%>
	function fnAddRow() {
	
		ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
	            "JSP( O:DETAIL=ds_detail)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	    tr_post(tr1);  
	        
        ds_default.addrow();
		//ds_default.namevalue(ds_default.rowposition,"order_no") = order_no.value;
		//ds_default.namevalue(ds_default.rowposition,"ORDER_DATE") = order_date.text;
		//ds_default.namevalue(ds_default.rowposition,"USER_NM") = user_nm.value;
		//ds_default.namevalue(ds_default.rowposition,"AMT_ORDER") = amt_order.value;
		//ds_default.namevalue(ds_default.rowposition,"REMARKS") = remarks.value;
		
	}
	<%// �����(�׸��庰)%>
	function fnDeleteRow() {
		ds_default.deleterow(ds_default.rowposition);
	}
	<%// ����%>
	function fnApply() {
	
		if ( ds_default.isUpdated||ds_detail.isUpdated ) {	
			v_job = "I";	
			ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
	             "JSP(I:DETAIL=ds_detail,I:DEFAULT=ds_default,O:reqNoDS=reqNoDS,O:msgDS=msgDS,O:RESULT=ds_result)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
	      fnSelect2();   
	    }        
	}
	
	function fnSelect2(){
	    gr_default.ReDraw = "False";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1" + "," 
					+ "sEmpNo=" + empno.value + "," 
				    + "sUserNm="+ ds_default.NameValue(ds_default.rowposition, "user_nm") + ","                         
                    + "sOrderNo=" + sOrderNo.text + ","                         
				    + "sBgnDate="+ ds_default.NameValue(ds_default.rowposition, "order_date") + ","                         
        		    + "sEndDate="+ ds_default.NameValue(ds_default.rowposition, "order_date");
        //alert(v_param);                
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ML%>Ml150I",
           // "JSP(O:DEFAULT=ds_default, O:DETAIL=ds_detail)",
            "JSP(O:DEFAULT=ds_default)",
            v_param);
        tr_post(tr1);
    }
	//���
	function fnCancel() {
		if (ds_default.IsUpdated ) {
			ds_default.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	
	// ��ġ���˾�
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Common/help/rv004h_03.jsp"
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			empno.value = arrParam[1];
			empnm.value = arrParam[2];
		} else {
			empno.value = "";		
			empnm.value = "";		
		}				
	}
	
	// �ֹ����˾�1(�˻�����)
	function fnPopup2() {   
		var arrParam	= new Array(); 
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/ml010h.jsp"
		strPos = "dialogWidth:527px;dialogHeight:550px;status:yes;scroll:yes;resizable:yes";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			user_nm.value = arrParam[1];
			orderer_company.value = arrParam[4];
		} else {
			user_nm.value = "";		
			orderer_company.value = "";		
		}				
	} 
	// �ֹ����˾�2
	function fnPopup3() {   
		var arrParam	= new Array(); 
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/ml010h.jsp"
		strPos = "dialogWidth:527px;dialogHeight:430px;status:yes;scroll:yes;resizable:yes";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			user_nm2.value = arrParam[1];
		} else {
			user_nm2.value = "";		
		}				
	} 		
</script>	    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for=gr_master event="OnDblClick(Row,Colid)">
	if(Row==0) return;
    ds_detail.AddRow();
    ds_detail.NameValue(ds_detail.RowPosition, "ITEM_SID")    		= ds_master.NameValue(Row, "ITEM_SID");
    ds_detail.NameValue(ds_detail.RowPosition, "ITEM_NM")     		= ds_master.NameValue(Row, "ITEM_NM");
    ds_detail.NameValue(ds_detail.RowPosition, "SELLER_CD")     		= ds_master.NameValue(Row, "SELLER_CD");
    ds_detail.NameValue(ds_detail.RowPosition, "AMT_ORDERED")     = ds_master.NameValue(Row, "AMT_EMP");
    ds_detail.NameValue(ds_detail.RowPosition, "AMT_USED")       	= ds_master.NameValue(Row, "AMT_EMP");
    ds_detail.NameValue(ds_detail.RowPosition, "AMT_CURR_CD")      = ds_master.NameValue(Row, "CURRENCY_CD");
    ds_detail.NameValue(ds_detail.RowPosition, "EXCH_RATE")      	= ds_master.NameValue(Row, "EXCH_AMT");
    ds_detail.NameValue(ds_detail.RowPosition, "ORDER_SID")      		= ds_default.NameValue(ds_default.RowPosition, "ORDER_SID");
</script>
<script language=javascript for=gr_detail event="OnDblClick(Row,Colid)">
    if(Row==0) return;
    ds_master.AddRow();
    ds_master.NameValue(ds_detail.RowPosition, "ITEM_SID")    		= ds_detail.NameValue(Row, "ITEM_SID");
    ds_master.NameValue(ds_detail.RowPosition, "ITEM_NM")     		= ds_detail.NameValue(Row, "ITEM_NM");
    ds_master.NameValue(ds_detail.RowPosition, "SELLER_CD")     		= ds_detail.NameValue(Row, "SELLER_CD");
    ds_master.NameValue(ds_detail.RowPosition, "AMT_EMP")   = ds_detail.NameValue(Row, "AMT_ORDERED");
    ds_master.NameValue(ds_detail.RowPosition, "EXCH_AMT")      	= ds_detail.NameValue(Row, "EXCH_RATE");
    ds_master.NameValue(ds_detail.RowPosition, "AMT_EMP")   = ds_detail.NameValue(Row, "AMT_USED");
    ds_master.NameValue(ds_detail.RowPosition, "CURRENCY_CD")      	= ds_detail.NameValue(Row, "AMT_CURR_CD");
    ds_detail.DeleteRow(Row);
</script>
<script language=javascript for=gr_detail event="OnExit(Row,Colid,OldData)">
    if(Row==0) return;
   	ds_detail.NameValue(Row, "SUM_AMT") = 	ds_detail.NameValue(Row, "ORDER_CNT") * ds_detail.NameValue(Row, "AMT_USED");
</script>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(ds_result.CountRow>0){
        for(var i=1, j=1; i<=ds_detail.CountRow; i++){
            if(ds_detail.RowStatus(i)==1){
                ds_detail.NameValue(i, "KEY_SEQ")=ds_result.NameValue(j, "KEY_SEQ");
                j++;
            }
        }
    }
     fnSelectDetail();
    //ds_detail.ResetStatus();
</script>
<script language=javascript for=gr_default event="OnClick(Row,Colid)">
	if(Row<1) return;
    fnSelectDetail();
</script>
<script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
	fnSelectDetail();
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
        var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
          	            
			//order_no����          	            
            var count=1;
            for ( i=1;i<=ds_default.CountRow;i++ ) {
            	if ( ds_default.namevalue(i,"order_no") == '' )
		            ds_default.namevalue(i,"order_no") = reqNoDS.namevalue(count++,"order_no");
            }
            ds_default.ResetStatus();
            
            //�޽��� ó��
			if ( msgDS.CountRow > 0 ) {
		        for ( j=1; j<=msgDS.CountRow; j++ )
		          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
				if(msg!='')
					alert(msg);
		    }
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
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
            
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = tr1.SrvErrMsg("ERROR", i) + "\n";
		
		if(alertMsg!='')
			alert(alertMsg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
            var count=1;
            for ( i=1;i<=ds_default.CountRow;i++ ) {
            	if ( ds_default.namevalue(i,"order_no") == '' )
		            ds_default.namevalue(i,"order_no") = reqNoDS.namevalue(count++,"order_no");
            }
            ds_default.ResetStatus();
       	}
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
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>	
	<script language="javascript" for="tr_save" event="onfail()">
    
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
        
    fnSelect();
</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript for=sCate1 event=OnSelChange()>
	if(ds_default.CountRow>0)
    fnSelectMaster();
</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_cate1 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
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
<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
			            			<img src="<%=dirPath%>/Sales/images/new.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply();">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px"  onclick="fnCancel()">
			            			<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >																																								
					 			</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>											
	</tr>
	<tr height="30px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=left width=70 class="text">&nbsp;��ġ��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="empno" type="text" class="textbox"  show=false style= "position:relative;center:-20px;top:2px;width:100px; height:20px; text-align:center;" onkeydown="if(event.keyCode==13) fnSelect();">									
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��ġ�ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="empnm" type="text" class="textbox"  style= "position:relative;center:-20px;top:2px;width:100px; height:20px; text-align:center;" onkeydown="if(event.keyCode==13) fnSelect();">									
								</td>	
								<td align=left width=70 class="text">&nbsp;�ֹ���</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="user_nm2" type="text" class="textbox"  style= "position:relative;center:-20px;top:2px;width:100px; height:20px; text-align:center;" onkeydown="if(event.keyCode==13) fnSelect();">									
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�ֹ��ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup3();">
								</td>			
							</tr>
							<tr>	
            					<td align=left width=70 class="text">&nbsp;�ֹ�����</td>
                                <td align=left bgcolor="#ffffff" width=300>&nbsp;																										
								     <%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox" onkeydown="if(event.keyCode==13) fnSelect();">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="0000-00-00">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">		
										<param name=InheritColor      value="true">																																																				
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">																				
										<param name=SelectAllOnClick   value="true">		
										<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>

								<td class="text">&nbsp;�ֹ���ȣ</td>
		                        <td align=left bgcolor="#ffffff">&nbsp;
		                        	<%=HDConstant.COMMENT_START%>
		                            <object id=sOrderNo classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox' onkeydown="if(event.keyCode==13) fnSelect();">            
		                                <param name=Format      value="ZZZZZZZZZZZZZ">
		                                <param name=Alignment   value=1>
		                                <param name=ClipMode    value=true>
		                                <param name=Border      value=false>
		                                <param name=Enable      value=true>
		                                <param name=UpperFlag   value=1>
		                                <param name=SelectAll   value=true>
		                                <param name=SelectAllOnClick      value=true>
		                                <param name=SelectAllOnClickAny   value=false>
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
	<tr>
		<td height="10"></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
			  <tr>
				<td width=20px align=center bgcolor="#303030" style="color:#ffffff;weight:heavy;">��<br>��<br>��<br>��</td>
			  	<td>
				  <table border="0" cellpadding="0" cellspacing="0">
				  	<tr>
				  	  <td>
					    <%=HDConstant.COMMENT_START%>
					    <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> style="width=340px; height:200" border="1" >
         				<param name="DataID"		VALUE="ds_default">
            			<param name="BorderStyle"   VALUE="0">
            			<param name=ColSizing       value="true">
            			<param name="editable"      value="true">
            			<param name=UsingOneClick  	value="1">
                        <Param Name="AllShowEdit"   value="True">
                        <param name="SortView"      value="Right">
                        <param name="ViewSummary" value="1">
						<param name="Format" 			value="
							<%//�ֹ�����%>
			                <C> name='�ֹ�����' 	ID='ORDER_DATE' 	width=60  	align=center show=true sumtext=@cnt edit=none </C>
			                <C> name='�ֹ���ȣ'   	ID='ORDER_NO' 	width=90  	align=center edit=none  show=true sumtext=��</C>
			                <C> name='�ֹ�SID'   	ID='ORDER_SID' 	width=90  	align=center edit=none  show=false </C>
			                <C> name='�ֹ���'   	ID='USER_NM'  		width=120  	align=center edit=none  show=true</C>
			                <C> name='�Ҽ�'   ID='ORDERER_COMPANY'  	width=100 	align=center edit=none  show=false</C>
			                <C> name='��� �ڸ�Ʈ'  ID='REMARKS'     align=left  show=false</C>
							">
						</object>
						<%=HDConstant.COMMENT_END%>
				  	  </td>
					  <td width=8></td>
					  <td>
						<table width="470px" height="200px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
						  <tr>
							<td  height="35px" width="80px" bgcolor="#eeeeee" align="center" class="text">�ֹ��Ͻ�</td>
							<td  height="35px"  bgcolor="#FFFFFF" align="left">&nbsp;
							     <%=HDConstant.COMMENT_START%>
							     <object id=order_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
									<param name=Text 		value="">
									<param name=Alignment 	value=1>
									<param name=Format 		value="0000-00-00">
									<param name=Cursor	 	value="iBeam">
									<param name=Border	 	value="0">		
									<param name=InheritColor      value="true">																																																				
									<param name=ReadOnly  	value="false">
									<param name=ReadOnlyBackColor  	value="#dddddd">																											
									<param name=SelectAll   value="true">																				
									<param name=SelectAllOnClick   value="true">		
									<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
								</object>
								<%=HDConstant.COMMENT_END%>&nbsp;
							</td>																								
							<td height="35px" width="80px" bgcolor="#eeeeee" align=center class="text">�ֹ���ȣ</td>
							<td height="35px"  bgcolor="#FFFFFF" align="left">&nbsp;
								<input id="order_no" type="text" class="textbox_d"   style= "position:relative;center:-20px;top:2px;width:120px; height:20px;color:black; text-align:center;" value="" size="20" readonly>
							</td>																																																			
						  </tr>
						  <tr>
							<td height="35px" width="80px" bgcolor="#eeeeee" align=center class="text">�ֹ���</td>
							<td  height="35px"  bgcolor="#FFFFFF" align="left">&nbsp;
								<input id="user_nm" type="text" class="textbox_d"  style= "position:relative;center:-20px;top:2px;width:100px; height:20px;color:black; text-align:center;"  readonly>
								<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�ֹ��ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup2();">
							</td>
							<td height="35px" width="80px" bgcolor="#eeeeee" align=center class="text">�Ҽ�</td>
							<td height="35px"  bgcolor="#FFFFFF" align="left">&nbsp;
								<input id="orderer_company" type="text" class="textbox_d"   style= "position:relative;center:-20px;top:2px;width:120px; height:20px;color:black; text-align:center;" value="" size="20" readonly>
							</td>	
						  </tr>																												
						  <tr>
							<td  height="35px" width="80px" bgcolor="#eeeeee" align="center" class="text">���</td>
							<td  height="35px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
								<input id="remarks" type="text" class="textbox"  size="50" value=""  style="text-align: left" >
							</td>
						  </tr>
						  <tr>
							<td  height="35px" width="100px" bgcolor="#eeeeee" align="center" class="text" colspan="4" rowspan="2"></td>
						  </tr>							  					  
						</table>
					  </td>
				  	</tr>
				  </table>
				</td>
			  </tr>
			  <tr height=5>
			  	<td colspan=2></td>
			  </tr>
			  <tr>
				<td width=20px align=center bgcolor="#303030" style="color:#ffffff;weight:heavy;">��<br>��<br>��<br>��</td>
			  	<td>
					<table width="100%" border=0 cellspacing=0 cellpadding=0>
					  <tr>
						<td>
							<table border=0 cellspacing=0 cellpadding=0>
								<tr>
									<td class="text">����</td>
									<td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=sCate1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 
											style="position:relative;left:1px;top:2px" class="txtbox" >
											<param name=ComboDataID         value=ds_cate1>
											<param name=SearchColumn        value=detail_nm>
											<param name=Sort                value="false">
											<param name=ListExprFormat      value="detail_nm^0^100">
											<param name=BindColumn          value="detail">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
							    <tr>
									<td colspan=2>
										<%=HDConstant.COMMENT_START%>
										<object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='340px' height='180px' border='1'>
											<param name="DataID"            value="ds_master">
											<param name="ColSizing"         value="true">
											<param name="Editable"          value="true">
											<param name="SuppressOption"    value="1">
											<param name="BorderStyle"       value="0">
											<param name="Format"            value="
												 <C> name='��ǰSID' 		ID='ITEM_SID'       width=40 align=right Edit=None DEC=0 show=false</C>
												 <C> name='��ǰ��'  			ID='ITEM_NM'      width=100 align=left Edit=None suppress=1 show=true</C>
												 <C> name='������'  		ID='MAKER'        width=100 align=left Edit=None show=true</C>
			 									 <C> name='�ڵ�' 			ID='SELLER_CD'    	width=60 align=right Edit=None DEC=0 show=true</C>
			 									 <C> name='��ȭ' 			ID='CURRENCY_CD'    	width=60 align=right Edit=None DEC=0 show=false</C>			 									 
												 <C> name='�ܰ�'			ID='AMT_EMP'       width=60 align=right Edit=None DEC=0  show=true</C>
												 <C> name='ȯ��'    		ID='EXCH_AMT'       width=40 align=center Edit=None dec=0 show=false</C>			
												 <C> name='�Ұ�'    		ID='REMARKS'        width=95 align=left Edit=None show=false</C>
											">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
							</table>
						</td>
						<td width=16 align=center>��</td>
						<td  valign=top>
							<%=HDConstant.COMMENT_START%>
							<object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='470px' height='205px' border='1'>
								<param name="DataID"            value="ds_detail">
								<param name="ColSizing"         value="true">
								<param name="Editable"          value="true">
								<param name="SuppressOption"    value="1">
								<param name="BorderStyle"       value="0">
								<param name=UsingOneClick       value="1">
								<Param Name="AllShowEdit"       value="True">
								<param name="ViewSummary"       value="1">
								<param name="Format"            value="
					                 <C> name='�ֹ�SID'     	ID='ORDER_SID'     	align=left  Edit=None show=false</C>
					                 <C> name='����'     	ID='ORDER_SEQ'     	width=30 align=center  editlimit=12 show=true</C>
									 <C> name='��ǰSID' 		ID='ITEM_SID'       		width=40 align=right Edit=None DEC=0 show=false</C>
									 <C> name='��ǰ��' 			ID='ITEM_NM'			width=100 align=left Edit=None DEC=0   sumtext=��</C>
									 <C> name='�ڵ�' 			ID='SELLER_CD'    	width=40 align=left Edit=None DEC=0 show=true</C>
									 <C> name='�ֹ��ܰ�'     	ID='AMT_ORDERED'		width=60 align=right Edit=None SumText=@sum  bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0  show=false</C>
 									 <C> name='�̿�ܰ�'     	ID='AMT_USED'				width=60 align=right sumtext=@cnt Edit=Numeric editlimit=12 bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0  show=true</C>
 									 <C> name='ȯ������ܰ�'     	ID='AMT_EXCH'		width=60 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0  show=false</C> 									 
									 <C> name='��ȭ'    			ID='AMT_CURR_CD'		width=40 align=center Edit=None sumtext=��</C>
									 <C> name='ȯ��'	    		ID='EXCH_RATE'       		width=40 align=center sumtext=�հ� Edit=Numeric  DEC=0  Edit=None</C>
									 <C> name='����'        		ID='ORDER_CNT'       	width=40 align=right    Edit=Numeric bgcolor='<%=HDConstant.GRID_ITEM%>' EditLimit=5 DEC=0</C>
									 <C> name='�հ�'     	ID='SUM_AMT'				width=80 align=right sumtext=@sum Edit=None editlimit=12 bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0  show=true</C>
							 ">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>				
					  </tr>
					</table>
				</td>
			  </tr>
			  <tr height=5>
			  	<td colspan=2></td>
			  </tr>
			</table>
			*** [��ٱ���]-[����]�� ���� �� �Ŀ� ������� �ڵ� �����˴ϴ�.</br>
			*** [��ٱ���]���� �׸��� [����]�ϴ� ���: ���ϴ� ��ٱ��� ��Ͽ��� �ش� ǰ���� ����Ŭ�� �� �� , ����� [����]��ư�� ������.
		</td>
	</tr>											
</table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>     
	<param name="DataId" value="ds_default">           
	<param name=BindInfo	value="                                                
        <C>Col=order_no           	Ctrl=order_no             	Param=value </C>
        <C>Col=order_date      		Ctrl=order_date	        	Param=text </C>
        <C>Col=user_nm    			Ctrl=user_nm      			Param=value </C>
        <C>Col=orderer_company	Ctrl=orderer_company			Param=value </C>        
        <C>Col=remarks          		Ctrl=remarks               			Param=value </C>        
        <C>Col=order_sid          	Ctrl=order_sid               			Param=value </C>        
        <C>Col=order_seq          	Ctrl=order_seq              			Param=value </C>        
   ">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>	    
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		