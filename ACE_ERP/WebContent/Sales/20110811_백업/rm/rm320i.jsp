<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ĳ����/��� ������
 * ���α׷�ID 	 : rm320i.jsp
 * J  S  P		 : rm320i
 * �� �� ��		 : RM320I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-08-17
 * �������		 :  ��ĳ����/��� ������
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
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
   	String firstday = m_today.format(date.getTime());
   	date.add(date.MONTH,+1);
    String lastday = m_today.format(date.getTime());
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
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		var v_job = "H";
		v_req_date.text='<%=firstday%>';
		v_req_date2.text='<%=lastday%>';
		v_req_date3.text='<%=firstday%>';
		v_req_date4.text='<%=lastday%>';
		fnInit();
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "INIT";
      	 window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:UPJANG=ds1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
		window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
	}

	/*
	 * ������ȸ
	 */
    function fnSelect() {
    }
	/*
	 * ����
	 */
	function fnApply() {
		if ( v_req_date.text.trim() == '' ) {
			alert("�۾������ �Է��� �ּ���.");
			return;
		}
	        v_job = "I";
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	           + "v_upjang_sid=" + v_upjang_sid.ValueOfIndex("upjang_sid", v_upjang_sid.Index)
	           + ",v_req_date=" + v_req_date.text
	            + ",v_req_date2=" + v_req_date2.text;

	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm320I",
	            "JSP(I:DEFAULT=ds2,O:RESULT=msgDS)",
	            param);
	        tr_post(tr1);
	}
		function fnApply1() {
		if ( v_req_date.text.trim() == '' ) {
			alert("�۾������ �Է��� �ּ���.");
			return;
		}
	        v_job = "I";
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	           + "v_req_date3=" + v_req_date3.text
	            + ",v_req_date4=" + v_req_date4.text;

	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm320I",
	            "JSP(I:DEFAULT=ds2,O:RESULT=msgDS)",
	            param);
	        tr_post(tr1);
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
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "���谡 �Ϸ�Ǿ����ϴ�";
             alert("���谡 �Ϸ�Ǿ����ϴ�");
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
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
<!-- 	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "�����߿� ������ �߻��Ͽ����ϴ�.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        //���� �޽��� ó��
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);

        //�޽��� ó��
        var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 )
          	alert(msg);
	</script>		-->

	<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
   window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="")
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
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
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
       				<td align="left"   width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
						  <tr>
       				        <td  width="645px">
								<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
									<tr>
	                             		<td align=left class="text"  width="100" >��Ͻ��� ������</td>
										<td width="260px" height="25px" bgcolor="#ffffff" colspain=2></td>
										<td align=left class="text"  width="70"><b>�Ⱓ</b></td>
										<td align=left bgcolor="#ffffff">&nbsp;
											<%=HDConstant.COMMENT_START%>
											<object id=v_req_date3 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
											<param name=Text     value="">
											<param name=Alignment   value=1>
											<param name=Format      value="0000-00-00">
											<param name=Cursor      value="iBeam">
											<param name=Border      value="false">
											<param name=InheritColor      value="true">
											<param name=ReadOnly    value="false">
											<param name=SelectAll   value="true">
											<param name=SelectAllOnClick     value="true">
											<param name=SelectAllOnClickAny     value="false">
											</object>
											<%=HDConstant.COMMENT_END%>&nbsp;~
											<%=HDConstant.COMMENT_START%>
											<object id=v_req_date4 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
											<param name=Text     value="">
											<param name=Alignment   value=1>
											<param name=Format      value="0000-00-00">
											<param name=Cursor      value="iBeam">
											<param name=Border      value="false">
											<param name=InheritColor      value="true">
											<param name=ReadOnly    value="false">
											<param name=SelectAll   value="true">
											<param name=SelectAllOnClick     value="true">
											<param name=SelectAllOnClickAny     value="false">
											</object>
											<%=HDConstant.COMMENT_END%>
										</td>
									</tr>
								</table>
							</td>
							<td align="right" height="30px"><img src="<%=dirPath%>/Sales/images/save.gif"      style="cursor:hand" onClick="fnApply1();">
							</td>
						  </tr>
						</table>
					</td>
				</tr>
				<tr height="40px"><td>&nbsp;</td></tr>
				<tr height="30px">
					<td> * ��Ͻ��� ������ ���� �� ��ĳ���� �����踦 �ϼž��� ��ĳ������ ��Ȯ�ϰ� �ݿ��˴ϴ�...</td>
				</tr>
				<tr height="50px">
					<td align="left"   width="845px">
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr height="30">
								<td  width="645px">
	    							<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	    								<tr bgcolor="#6f7f8d">
	    							    	<td align=left class="text"  width="100">���ɽ��� ������</td>
	    							        <td width="100px" height="25px" class="text">�����</td>
	    							        <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
	    							        	<object id=v_upjang_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
	    							            <param name=ComboDataID		value=ds1>
												<param name=EditExprFormat	value="%;upjang_nm">
												<param name=ListExprFormat  value="upjang_nm^0^120">
	    	            						</object>
	    	            						<%=HDConstant.COMMENT_END%>
	    	        						</td>
											<td align=left class="text"  width="70"><b>�Ⱓ</b></td>
	    	        						<td align=left bgcolor="#ffffff">&nbsp;
												<%=HDConstant.COMMENT_START%>
												<object id=v_req_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
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
												<%=HDConstant.COMMENT_END%>&nbsp;~
												<%=HDConstant.COMMENT_START%>
												<object id=v_req_date2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">
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
												<%=HDConstant.COMMENT_END%>
											</td>
										</tr>
									</table>
								</td>
								<td align="right" height="30px"><img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
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

