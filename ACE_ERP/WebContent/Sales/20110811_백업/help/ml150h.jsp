<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * �ý��۸� 	: �ֹ���(���θ�)
 * ���α׷�ID 	: ML010J.JSP
 * J  S  P		: ml010h
 * �� �� ��		: Ml010H
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-01-19
 * �������		: ���θ� �ֹ��� ���/��ȸ
 * ��������		: 
 * �� �� ��		: 
 * ������������ :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%@ page import="java.net.URLEncoder" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String toDay     = m_today.format(date.getTime());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>�ֹ���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
<script language="javascript">
	function fnOnLoad() {
		var v_job = "H";
		cfStyleGrid(getObjectFirst("gr1"), "comn");
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	:
%>
	function fnSelect() {
     v_job = "S";
                var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                + ",sUserNm="  + USER_NM.value;
                
        ln_TRSetting(tr1, 
        "<%=dirPath%><%=HDConstant.PATH_HELP%>Ml010H",
        "JSP(O:MASTER=ds1)",
        v_param);
    tr_post(tr1);
   }
   
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ġ���˾� 
// Parameter 	:
%>
	function fnCustPopup() {
			
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
			ds1.namevalue(ds1.rowposition,"send_empnmk") = arrParam[2];
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = arrParam[0];
	   		ds1.namevalue(ds1.rowposition, "EMPNO") = arrParam[1];
		} else {
			ds1.namevalue(ds1.rowposition,"send_empnmk") = "";
	   		ds1.namevalue(ds1.rowposition, "send_deptnm") = "";
			ds1.namevalue(ds1.rowposition,"EMPNO") = "";
   		}				
	}
	<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	:
%>
		 function fnAdd() {
					var row = ds1.rowposition;
					window.returnValue =
										 ds1.namevalue(row, "ORDERER_SID")		+";"+ 
										 ds1.namevalue(row, "USER_NM")			+";"+ 
									     ds1.namevalue(row, "MOBILE_NO")		+";"+ 
		   							     ds1.namevalue(row, "TEL_NO")				+";"+ 
									     ds1.namevalue(row, "EMPNO");
		 			fnClose();
		}
		function fnClose() {
				window.close();
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	:
%>
	function fnAddRow() {
		ds1.addrow();
        gr1.SetColumn("USER_NM");
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	:
%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����
// Parameter 	:
%>
	function fnApply() {
        v_job = "I";
        if (ds1.IsUpdated) {
            if(confirm("�����Ͻðڽ��ϱ�?")){
                for(var i=1; i<=ds1.CountRow; i++){
                    if(ds1.NameValue(i, "USER_NM")==""){
                        alert("�ֹ���<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("USER_NM");
                        return;
                    }
                }
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
               ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_HELP%>Ml010H",
                    "JSP(I:DS1=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr1);
            }
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
    </script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        var error_cnt = tr1.SrvErrCount("ERROR");
        var error_msg = "";
        for(var i=0; i<error_cnt; i++){
            error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
        }
        if(error_msg!="") 
            alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
        else
            alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �׸��� ����Ŭ�� �̺�Ʈ �߻�
//
%>			
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			fnAdd();
		</script>
		
		<script language=JavaScript for=gr1 event=onKeyPress(keycode)>
  			
            if (keycode == 13) {
            	fnAdd();
            }
		</script>
		<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
		if (colid=="EMPNO") {
			fnCustPopup();
		}
		</script>     
<%=HDConstant.COMMENT_START%>		
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>
<%=HDConstant.COMMENT_END%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
	</head>	<!--  BODY START -->
	  <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
		<table border="0" cellpadding="0" cellspacing="0" width='500px' style="position:relative;top:1px;width:50;height:15;left:3;">
			<tr>
				<td align='center' width='500px' colspan='4'>
					<table  border="0" cellpadding="0" cellspacing="0" width='500px'>
						<tr>
							<td colspan=4 height=25 width="500px" align=left>
								<img src="<%=dirPath%>/Sales/images/p_icon.gif" > <font style="position:relative;top:1px;width:50;height:15;">�ֹ���</font>
							</td>
						</tr>
						<tr>
							<td width=500 colspan="4">
								<table  border="0" cellpadding="0" cellspacing="0" width='500px'>
									<tr>
										<td align=left class="text">�ֹ���</td>
										<td align=left bgcolor="#ffffff"><input id="USER_NM" type="text" class="txtbox" size=10 maxlength="40" onkeydown="if(event.keyCode==13) fnSelect();"></td>
										<td align="right" height="30px">		
										    <img name="btn_select" border="0" src="<%=dirPath%>/Sales/images/p_select.gif" style="cursor:hand;" onClick="fnAdd()">
											<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
					            			<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
					            			<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
					            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
					            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
					            		</td>
									</tr>
								</table>
							</td>
						</tr>
					<tr height="5px" >
				<td colspan='4'></td>
			</tr>
			<tr>
				<td width='400px' align='center' colspan='4'>
					<table cellpadding="0" cellspacing="0" border="0" width='400px'>
						<tr>
							<td align='center'>
			<%
			/*---------------------------------------------------------------------------->
				Object ID 	: �׸��� , gr1
				Data ID		: ds1
			-----------------------------------------------------------------------------*/
			%>
								<%=HDConstant.COMMENT_START%>
								<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=550px; height:260px;" border="1">
									<param name="DataID"		value="ds1">
									<param name="BorderStyle" 	value="0"> 
									<param name="AllShowEdit" 	value="true"> <!-- Edit����  -->
									<param name="ColSizing"     value="true">
									<param name="Fillarea"		value="true">
									<param name="AutoResizing" 	value=true> 
									<param name="Editable"  	value="true">
									<param name="AddSelectRows" value=true>
									<param name="IndWidth"      value="0">
									<param name="LineColor" 	value="#dddddd">
                                    <param name=ViewSummary  value="1">
									<param name="Format" 		value="
											<FC> name='�ֹ���SID'   ID='ORDERER_SID'      Width=125   align=center     editlimit=20  Sort=True	Show=False</FC>
										    <FC> name='�ֹ���'   ID='USER_NM'      Width=125   align=center     editlimit=20  Sort=True</FC>
                                            <FC> name='�ڵ���'   ID='MOBILE_NO'   Width=125   align=left      	editlimit=20 </FC>
                                            <C> name='��ȭ��ȣ'  ID='TEL_NO'      	Width=125   align=left      	editlimit=20</C>
                                            <C> name='��ġ��'     ID='EMPNO'         Width=125   align=center     editlimit=20  EditStyle=popup</C>
    					                ">
								</object>
								<%=HDConstant.COMMENT_END%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>	<!-- BODY END -->
</html>