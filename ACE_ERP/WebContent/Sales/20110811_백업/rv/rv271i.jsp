<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��û����_���� 
 * ���α׷�ID 	 : RV271I
 * J  S  P		 : rv271i
 * �� �� ��		 : RV271I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2010-08-09
 * �������	 : ��û����_����
 * [��  ��   ��  ��][������] ����
 * [2010-08-12][�ڰ汹] ��û����_���� �űԱ���.
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
        var v_job = "H";
        var sApproveLine;

	
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit();
		}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>';

        v_job = "H";
        cfStyleGrid(getObjectFirst("gr_default"), "comn");
        cfStyleGrid(getObjectFirst("gr_detail"), "comn1");
		
        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270I",
            "JSP(O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);
        
		//�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();
        //�۾�����1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset();
        //�۾�����2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();
    }
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds_default.isUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sClientSid=" + sClientSid.value + ","
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + ","
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text + ","
            + "sCustNm=" + sCustNm.value +","
            + "sManageNo=" + sManageNo.value +","
            + "sDpBgnDate=" + sDpBgnDate.text + ","
            + "sDpEndDate=" + sDpEndDate.text;
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv271I",
            "JSP(O:DEFAULT=ds_default)",
            param);
        tr_post(tr1);
    }
    //DETAIL GRID ��ȸ
     function fnSelectDefault(Row){

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",sRsvSid="+ ds_default.NameValue(Row, "RSV_SID");
      //alert(v_param);        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv271I",
            "JSP(O:DETAIL=ds_detail)",
            v_param);
        tr_post(tr1);
    }
	// ����
	function fnApply() {
		if ( ds_default.isUpdated  ) {
			for ( i=1; i<= ds_default.CountRow; i++ )  {		
				//alert(ds_default.namevalue(i,"job_type") );
				if(ds_default.namevalue(i,"accept_sid") == '' || ds_default.namevalue(i,"accept_sid") == '0' ) {
					alert("��û�� ��ȣ�� �Է��� �ּ���.");
					return;
				}			
				if(ds_default.namevalue(i,"rsv_sid") == '' || ds_default.namevalue(i,"rsv_sid") == '0' ) {
					alert("������ �Է��� �ּ���.");
					return;
				}
			};				
	        v_job = "I";
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	         ln_TRSetting(tr1,
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv271I",
	             "JSP(I:DEFAULT=ds_default,I:DETAIL=ds_detail, O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);
		}else{
			alert("������ ������ ���� ������ �� �����ϴ�.");
		}
	}

	// ���
	function fnCancel() {
		if (ds_default.IsUpdated ) {
			ds_default.undoall();
			lc_status2.index = lc_status2.IndexOfColumn("detail", ds_default.namevalue(	ds_default.rowposition,"status_cd"));
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	
	/*
	 * �븮���˾�
	 */
	function fnPopup1() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	}
	/*
	 * ���缱 ����
	 */
	function fnApproval() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
			strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);
			//alert("arrResult===========");
			//alert(arrResult);
			sApproveLine = arrResult;
			//alert("sApproveLine==========");
			//alert(sApproveLine);
	}
	/*
	 * ���
	 */
	function fnDraft() {
		if(ds_default.CountRow ==0){
			alert("��� �� ������ ��ȸ �� �ּ���");
			return;
		}
			var array1= new Array();
			var array2= new Array();
			var array3= new Array();
			var array4= new Array();
			var array5= new Array();

			array1=sApproveLine.split(";");
			array2 = array1[0].split("/");
			array3 = array1[1].split("/");
			array4 = array1[2].split("/");
			array5 = array1[3].split("/");
			/*				
			alert(array2[0]);				alert(array2[1]);				alert(array2[2]);				alert(array2[3]);				
			alert(array3[0]);				alert(array3[1]);				alert(array3[2]);				alert(array3[3]);				
			alert(array4[0]);				alert(array4[1]);				alert(array4[2]);				alert(array4[3]);				
			alert(array5[0]);				alert(array5[1]);				alert(array5[2]);				alert(array5[3]);
			*/
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+",req_no="+req_no.value
 											+",array10="+array2[0]		//���
 											+",array11="+array2[1]		//���
 											+",array12="+array2[2]		//���
 											+",array13="+array2[3]		//���
 											+",array20="+array3[0]		//����
 											+",array21="+array3[1]		//����
 											+",array22="+array3[2]		//����
 											+",array23="+array3[3]		//����
 											+",array30="+array4[0]		//Ȯ��
 											+",array31="+array4[1]		//Ȯ��
 											+",array32="+array4[2]		//Ȯ��
 											+",array33="+array4[3]		//Ȯ��
 											+",array40="+array5[0]		//����
 											+",array41="+array5[1]		//����
 											+",array42="+array5[2]		//����
 											+",array43="+array5[3];		//����
 											//alert(param);
		    ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv271I",
	            "JSP(I:DRAFT=ds_default, O:msgDS=msgDS)",
	            param);
	        tr_post(tr1);
	        alert("����� �Ϸ� �Ǿ����ϴ�.");
	        
	 }
	/*
	 * �븮�� �ڵ�����(����)
	 */
	function fnSetting(dataSet) {
		var exit=false;
		if ( dataSet == 'ds_saldam' ) {	//���������
			for ( i=1; i<=ds_saldam.CountRow; i++ ) {
				if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
					sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
					sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
					sSalDamSid.value = '';
					sSalDamNm.value = '';
			}
		}
		if ( dataSet == 'ds6' ) {	//�븮��
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}
		}
	}
	/*
	 * �۾����� ����
	 */
	function fnStatusSet(status) {
		if(status=='JO') {//�����Ϸ� ��ư Ŭ��
			if (ds_default.namevalue(ds_default.rowposition,"status_cd")=='RR') {
				lc_status2.index = lc_status2.IndexOfColumn("detail", status);
			} else {
				alert("[��û]������ �͵鸸 [�����Ϸ�]�� ������ �� �ֽ��ϴ�.");
			}
		};
		
		if(status=='RC') {//��û��� ��ư Ŭ��
			if (ds_default.namevalue(ds_default.rowposition,"status_cd")=='RR') {
				lc_status2.index = lc_status2.IndexOfColumn("detail", status);
			} else {
				alert("[��û]������ �͵鸸 [��û���]�� ������ �� �ֽ��ϴ�.");
			}
		};
	}
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr_default event=OnClick(Row,Colid)>
			var index=lc_status2.IndexOfColumn("detail", ds_default.namevalue(ds_default.Rowposition,"status_cd"));
			lc_status2.index=index;
		    if(Row<1) return;
		</script>
		<script language=JavaScript for= lc_status2 event=OnSelChange()>
			ds_default.namevalue(ds_default.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");
		</script>
		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
			}
		</script>
		<script language=JavaScript for=sDpBgnDate event=OnKillFocus()>
			if ( sDpBgnDate.Modified ) {
				sDpEndDate.text = sDpBgnDate.text;
			}
		</script>
		<script language=javascript for=gr_default event="OnClick(Row,Colid)">
		    if(Row<1) return;
		    fnSelectDefault(Row);
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

            //�޽��� ó��
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
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
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";
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
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
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
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds_default event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	<script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
		var index=lc_status2.IndexOfColumn("detail", ds_default.namevalue(ds_default.Rowposition,"status_cd"));
		lc_status2.index=index;
		if ( ds_default.CountRow > 0 )
				fnSelectDefault();
	</script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �˻� : ��ǰ -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDsSrch classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr>
		<td align=right height="30px">
			<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td align="left" width=845>
						<img src="<%=dirPath%>/Sales/images/ap_line.gif"   		style="cursor:hand" align=absmiddle 	onclick="fnApproval()">
						<input id="sApproveLine" type="hidden" value="">
						<img src="<%=dirPath%>/Sales/images/ap_up.gif"			style="cursor:hand" align=absmiddle 	onClick="fnDraft()">
					</td>
					<td align="right" width=845>
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle 	onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" align=absmiddle 	onClick="fnApply()">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle  	onclick="fnCancel()">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr>
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=center class="text">�븮��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<input id="sClientSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
								<td align=center class="text"><B>��û����</B></td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
								<td align=center width=80 class="text">�������</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
            				</tr>
                            <tr bgcolor="#6f7f8d">
            					<td align=center class="text"><B>�۾�����</B></td>
			                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value="ds_status1">
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>
	            				<td align=center width=60 class="text">����</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" value="" size=20 class="textbox">
                                <td align=center width=80 class="text">�ֹ�/���ǹ�ȣ</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sManageNo" value="" size=20 class="textbox">
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
				<tr valign="top"">
					<td align="left" width="290px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> style="width=290px; height:395" border="1" >
             				<param name="DataID"		VALUE="ds_default">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
                            <param name="ViewSummary" value="1">
							<param name="Format" 			value="
				                <C> name='�۾�����'    	ID='status_cd' width=60 sumcolor=#000000 sumbgcolor=#E0CFE4  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true sumtext=��</C>
				                <C> name='��û��'  		ID='accept_date'     width=70    sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX sumtext=@count suppress=1</C>
				                <C> name='��û����ȣ'  	ID='accept_no'  width=100 sumcolor=#000000 sumbgcolor=#E0CFE4 align=center editlimit=15 edit=none show=true sort=true sumtext=�� suppress=2</C>
				                <C> name='�̸�'      	ID='cust_nm'   width=60  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=30 edit=none show=true sort=true suppress=3</C>
				                <C> name='������ȣ'     ID='req_no'  width=100 sumcolor=#000000 sumbgcolor=#E0CFE4  align=center editlimit=20 edit=none show=true suppress=4</C>
				                <C> name='�۾�����'    	ID='job_type'  width=60  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left EditStyle=Lookup Data='codeds_default:DETAIL:DETAIL_NM' show=false</C>
				                <C> name='�븮��SID'   	ID='client_sid' width=60  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='��ǰ'   		ID='lc_goods' width=60  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='��û�ð�'  	ID='accept_time'        sumcolor=#000000 sumbgcolor=#E0CFE4  align=left show=false </C>
				                <C> name='�����'       ID='client_dam_nm'       sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=20 show=false</C>
				                <C> name='����ó'    ID='mobile_no'   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=15 show=false</C>
				                <C> name='�����'  ID='depart_date'         sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=8 show=false</C>
				                <C> name='��߽ð�'  ID='depart_time'       sumcolor=#000000 sumbgcolor=#E0CFE4   align=left editlimit=8 show=false</C>
				                <C> name='��ûSID'   ID='accept_sid'  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='����SID'      ID='rsv_sid'     sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='��SID'     ID='cust_sid'    sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=12 show=false</C>
				                <C> name='�ֹ�/���ǹ�ȣ'    ID='manage_no'  sumcolor=#000000 sumbgcolor=#E0CFE4  align=left editlimit=20 show=false</C>
				                <C> name='�����'   ID='company_nm'  sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=30 show=false</C>
				                <C> name='����'    ID='positions'  sumcolor=#000000 sumbgcolor=#E0CFE4  align=left editlimit=30 show=false</C>
				                <C> name='����ó'    ID='cust_mobile_no'   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=15 show=false</C>
				                <C> name='�ǸŰ�'      ID='tour_amt'    sumcolor=#000000 sumbgcolor=#E0CFE4  align=left editlimit=33 show=false</C>
				                <C> name='�Աݾ�'      ID='pay_amt'     sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=33 show=false</C>
				                <C> name='ȯ�Ҿ�'      ID='amt'        sumcolor=#000000 sumbgcolor=#E0CFE4  align=left editlimit=12 show=False</C>
   				                <C> name='ȯ�ҿ�û�ݾ�' ID='rq_amt'   sumcolor=#000000 sumbgcolor=#E0CFE4   align=left editlimit=12 show=False</C>
				                <C> name='�����ڵ�'    ID='charge_cd'  sumcolor=#000000 sumbgcolor=#E0CFE4  align=left editlimit=1 show=false</C>
				                <C> name='ǥ�ذ�����'     ID='charge_rate'   sumcolor=#000000 sumbgcolor=#E0CFE4 align=left show=false</C>
				                <C> name='�۱�����'       ID='bancod'    sumcolor=#000000 sumbgcolor=#E0CFE4   align=left editlimit=2 show=False</C>
				                <C> name='�۱������'     ID='bannm'    sumcolor=#000000 sumbgcolor=#E0CFE4   align=left editlimit=50 show=false</C>
				                <C> name='�۱ݰ���'  ID='bank_acc_no'    sumcolor=#000000 sumbgcolor=#E0CFE4      align=left editlimit=20 show=false</C>
				                <C> name='������' ID='bank_acct_nm'     sumcolor=#000000 sumbgcolor=#E0CFE4    align=left editlimit=32 show=false</C>
				                <C> name='����'       ID='reason'      sumcolor=#000000 sumbgcolor=#E0CFE4 align=left editlimit=200 show=false</C>
				                <C> name='���' ID='desc'      sumcolor=#000000 sumbgcolor=#E0CFE4   align=left editlimit=200 show=false</C>
				                <C> name='�������' ID='approval' width=80     sumcolor=#000000 sumbgcolor=#E0CFE4    align=center edit=none show=true</C>
							">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td width="25px">
					</td>
					<td align="left" valign="top" width="530px">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="530px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_status2>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=BindColumn      value="detail">
		                                                        <param name=BindColVal      value="detail">
																<param name=Enable  value=false>
															</object>
															<%=HDConstant.COMMENT_END%>
															<img src="<%=dirPath%>/Sales/images/take_com.gif"   	style="cursor:hand;position:relative;left:3px;top:1px" onclick="fnStatusSet('JO')">
															<img src="<%=dirPath%>/Sales/images/request_can.gif"		style="cursor:hand;position:relative;left:3px;top:1px" onClick="fnStatusSet('RC')">

														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">������ȣ</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="req_no" type="text" class="textbox_d"   value="" size="20" readonly>
														</td>
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">�����</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="textbox_d"  style="text-align:left;" value="�����" size="20" readonly>
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">����ó</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="textbox_d"  style="text-align:left;" value="010-3399-0101" size="20" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û����ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;
															<input id="accept_no" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ֹ�/���ǹ�ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="textbox_d"  size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û�ǰ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="textbox_d"  size="50" value=""  style="text-align: left"  readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����ǰ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc" type="text" class="textbox"  " size="50" value="" bgcolor="#FFFFFF" style="text-align: left" >
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr height=100>
											<td>
												<table width="100%" border=0 cellspacing=0 cellpadding=0>
													<tr height=5><td></td></tr>
													<tr height=5><td></td></tr>
													<tr>
														<td>
															<%=HDConstant.COMMENT_START%>
															<object id=gr_detail classid=<%=HDConstant.CT_GRID_CLSID%> width='530px' height='200px' border='1'>
															<param name="DataID"            value="ds_detail">
															<param name="ColSizing"         value="true">
															<param name="Editable"          value="true">
															<param name="SuppressOption"    value="1">
															<param name="BorderStyle"       value="0">
															<param name=UsingOneClick       value="1">
															<Param Name="AllShowEdit"       value="True">
															<param name="ViewSummary"       value="1">
															<param name="Format"            value="
																 <C> name='RSV_SID' 	ID='RSV_SID'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None DEC=0 show=false</C>
																 <C> name='�̿�����'  	ID='USE_DATE'     	sumcolor=#000000 sumbgcolor=#E0CFE4 sumtext=�� width=70 align=center editlimit=8 bgcolor='<%=HDConstant.GRID_ITEM%>' edit=none show=true mask=XXXX-XX-XX suppress=1</C>
																 <C> name='������'         ID='UPJANG_NM' sumcolor=#000000 sumbgcolor=#E0CFE4  sumtext=@count    width=70 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' suppress=2</C>
		   													     <C> name='�׸�'          	ID='MENU_NM'   sumcolor=#000000 sumbgcolor=#E0CFE4  sumtext='��'		 width=100 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' suppress=3</C>
																 <C> name='ȸ��' 			ID='USE_SEQ'    sumcolor=#000000 sumbgcolor=#E0CFE4   	width=40 align=right Edit=None DEC=0 bgcolor='<%=HDConstant.GRID_ITEM%>' suppress=4</C>
																 <C> name='����' 			ID='AVAILABLE_CNT'    sumcolor=#000000 sumbgcolor=#E0CFE4    width=60 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
																 <C> name='�ܰ�'     		ID='UNIT_AMT'       	sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
																 <C> name='��ȭ'    		ID='CURRENCY_CD' sumcolor=#000000 sumbgcolor=#E0CFE4   width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
																 <C> name='ȯ��'	      	ID='EXCH_AMT'       sumcolor=#000000 sumbgcolor=#E0CFE4 width=40 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' DEC=0</C>
																 <C> name='����'          	ID='SALE_QTY'     sumcolor=#000000 sumbgcolor=#E0CFE4  SumText='�ݾ�'  width=40 align=right Edit=Numeric EditLimit=5 DEC=0</C>
																 <C> name='�հ�\\(��)'  ID='SUM_AMT'   	sumcolor=#000000 sumbgcolor=#E0CFE4 	SumText=@sum width=70 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0 </C>
																 <C> name='�����\\����'  ID='RSV_PAY_YN'     sumcolor=#000000 sumbgcolor=#E0CFE4 SumText='��' width=60 align=center EditStyle=CheckBox show=true</C>
																 <C> name='�������'      ID='REMARKS'        sumcolor=#000000 sumbgcolor=#E0CFE4 width=100 align=left Edit=true</C>
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
						<B><BR>* �����׸��忡�� �ο�(ROW)�� Ŭ���ϸ� ���ϴ� �׸��忡�� �󼼳����� Ȯ�ε˴ϴ�.</BR></B>
					</td>
				</tr>
			</table>
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
        <C>Col=req_no           Ctrl=req_no             Param=value </C>
        <C>Col=goods_sid        Ctrl=goods_sid          Param=value </C>
        <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
        <C>Col=accept_date      Ctrl=accept_date                Param=text </C>
        <C>Col=accept_time      Ctrl=accept_time                Param=text </C>
        <C>Col=client_dam_nm    Ctrl=client_dam_nm              Param=value </C>
        <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
        <C>Col=depart_date      Ctrl=depart_date                Param=text </C>
        <C>Col=depart_time      Ctrl=depart_time                Param=text </C>

        <C>Col=goods_nm			Ctrl=goods_nm			Param=value </C>
        <C>Col=confirm_yn		Ctrl=confirm_yn			Param=value </C>
        <C>Col=status_nm		Ctrl=status_nm			Param=value </C>
        
        <C>Col=accept_sid       Ctrl=accept_sid         Param=value </C>
        <C>Col=accept_no        Ctrl=accept_no          Param=value </C>
        <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
        <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
        <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
        <C>Col=manage_no        Ctrl=manage_no          Param=value </C>
        <C>Col=company_nm       Ctrl=company_nm         Param=value </C>
        <C>Col=positions        Ctrl=positions          Param=value </C>
        <C>Col=cust_mobile_no   Ctrl=cust_mobile_no     Param=value </C>
        <C>Col=tour_amt         Ctrl=tour_amt           Param=text </C>
        <C>Col=pay_amt          Ctrl=pay_amt            Param=text </C>
        <C>Col=amt              Ctrl=amt                Param=text </C>
        <C>Col=rq_amt           Ctrl=rq_amt             Param=text </C>        

        <C>Col=charge_cd        Ctrl=lc_charge   	 	Param=BindColVal</C>

        <C>Col=charge_rate      Ctrl=charge_rate        Param=value </C>
        <C>Col=bancod           Ctrl=lc_bancod          Param=BindColVal </C>
        <C>Col=bannm            Ctrl=bannm              Param=value </C>
        <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
        <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
        <C>Col=reason           Ctrl=reason             Param=value </C>
        <C>Col=desc             Ctrl=desc               Param=value </C>
        <C>Col=desc2            Ctrl=desc2              Param=value </C>
        <C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>
		<C>Col=job_type         Ctrl=sJobType           Param=BindColVal </C>
		<C>Col=status_cd        Ctrl=lc_status2         Param=BindColVal </C>
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
<input type="hidden" name="row" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
<script language=javascript>
	var login_id;
	var login_nm;
	get_cookdata();
	login_id=GetCookie("vusrid");
	login_nm=GetCookie("vusrnm");
</script>