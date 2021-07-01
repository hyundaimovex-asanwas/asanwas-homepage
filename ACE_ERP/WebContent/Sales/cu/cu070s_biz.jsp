<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ������
 * ���α׷�ID 	 : CU070S
 * J  S  P		 : cu070s
 * �� �� ��		 : Cu070S
 * �� �� ��		 : ����ǥ
 * �� �� ��		 : 2006-06-16
 * �������		 : ��ϱ��� ����� ��� (��ȸ|����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-01-31][�ɵ���] �� ���̺� + �� ���� 
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
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">

    var v_job = "";
    var today = "";
	/*
	 * Description 	:  ������ �ε� 
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			fnInit(); 
		}

	/*
	 * Description : �ʱ�ȭ
	 * �������� ���´�
	 */
	function fnInit(){
		
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
		ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU015";
		ds2.Reset(); //����۾�����
 		ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds3.Reset(); //�����ڵ�
 		ds4.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU016";
		ds4.Reset(); //��ϸ���
 		ds5.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU023";
		ds5.Reset(); //�߱ް��
		codeDs1.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CU014";
		codeDs1.Reset(); //��ϱ�������
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
	function fnSelect() {
	
        v_job = "S";
        if(ds1.IsUpdated!=false && confirm("���� ���� �۾����� �����Ͱ� �ֽ��ϴ�. �����Ͻðڽ��ϱ�")==false)
            return;
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
//                  + ",sNJobGu=" + drp_n_job_gu.ValueOfIndex("detail", drp_n_job_gu.Index) 
                  + ",sClientSid=" + txt_client_sid.value												// �ŷ�ó ���̵�
                  + ",sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)				// ����� SID
                  + ",sEducPlanDt=" + txt_educ_plan_dt.text												// ��������
				  + ",sVisitObjCd=" + drp_visit_object.ValueOfIndex("detail", drp_visit_object.Index)	// ��ϸ����ڵ�
                  + ",sCustNm=" + txt_cust_nm.value														// ���� 
                  + ",sManageNo=" + txt_manage_no.value													// �ֹ�/���ǹ�ȣ
                  + ",sEducReqNo=" + txt_educ_req_no.value												// ��ϱ�����û��ȣ
                  + ",sEducNo=" + txt_educ_no.value;													// ����� ���ι�ȣ
                  
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu080I",
            "JSP(O:DEFAULT=ds1)",
            param);
		fnOnProgressStart();
        tr_post(tr1);

	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
	function fnApply() {
	
		if (ds1.IsUpdated) {
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                +",sNJobGu="+drp_n_job_gu.ValueOfIndex("detail", drp_n_job_gu.Index)
                +",sEdutDt="+txt_educ_plan_dt.text
                +",sReqDt="+txt_educ_plan_dt.text
              	+ ",sSaupSid=" + drp_saup_sid.ValueOfIndex("saup_sid",drp_saup_sid.Index)
              	+ ",sEducPlanDt=" + txt_educ_plan_dt.text
              	+ ",sCustNm=" + txt_cust_nm.value
              	+ ",sManageNo=" + txt_manage_no.value;
              	
              	
              	
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu080I",
                "JSP(I:DS1=ds1)",
                param);
            tr_post(tr1);
        }
	}

	/*
	 * ��� 
	 */
	function fnCancel(){
	
		if(ds1.IsUpdated) {
			ds1.undoall();
		}
//		head.readOnly = true;
//		head_name.readOnly = false;
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;
	}

<%
//////////////////////////////////////////////////////////////////////////////
//	Description : Dataset Head ����
%>
/*	function fnSetDataHeader() {
		var s_temp = "job_sel:STRING,edud_req_no:INT,cust_sid:INT,manage_no:STRING,cust_nm:STRING,"
		            +"saup_sid:INT,saup_name:STRING,educ_yn_name:STRING,educ_saup_name:STRING,educ_dt:STRING,"
		            +"visit_object:STRING,n_card_no:STRING,visit_object_cd:STRING,educ_no:STRING,visit_fr_dt:STRING,"
		            +"visit_to_dt:STRING,credit_fr_dt:STRING,credit_to_dt:STRING,n_educ_yn:STRING";
		ds5.SetDataHeader(s_temp);
	}
*/

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�ڵ� Help
%>
    function fnClientSidPopup() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
            
        strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=2";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    	
        if (arrResult != null) {
            arrParam = arrResult.split(";");        
            txt_client_sid.value= arrParam[0];
            txt_client_nm.value= arrParam[1];
            txt_client_cd.value = arrParam[2];
          	fnSelectDs13();
        } else {

        }       
    }

    function fnExcel() {
        if(ds1.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:��ϱ��� ����� ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("��ϱ��� ����� ���", "��ϱ���_�����_���.xls", 8);
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
<script language="javascript" for="tr1" event="OnSuccess()">
    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);        
</script>
<script language="javascript" for="tr1" event="OnFail()">
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
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	
	</script> 
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();    
	    if(v_job == "H") return; //fnInit();
	    if(row < 1){
			window.status = "��ȸ�� ������ �����ϴ�."; 
	    }
	    else
			window.status="��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
			window.status="��ȸ�� ������ �߻��߽��ϴ�.";
	</script>
	
	<script language=JavaScript  for=ds2 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds2 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>    
	<script language=JavaScript  for=ds3 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadStarted()">
	    window.status="��ȸ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	</script> 
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		window.status = "��ȸ�� �Ϸ�Ǿ����ϴ�.";
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadError()">
	    fnOnProgressEnd();
		window.status="��ȸ �߿� ������ �߻��߽��ϴ�.";
	</script>

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
	<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><%-- TR�����ͼ� --%>
	<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object><%-- ��ϱ������� --%>
	
	
	
	<object id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
	<tr height="30px">
		<td align=right><img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;" align=absmiddle onclick="fnExcel()">&nbsp;&nbsp;</td>
	</tr>
	<tr height="50px">
		<td>
			<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="845px">
				<tr height="25px">
					<td align="center" width="100px" class="text">���¾�ü�ڵ�</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
                     	<input id="txt_client_nm" type="text" class="textbox"  size='15' maxlength="10" onchange="txt_client_sid.value='',txt_client_nm.value=''" onblur="fnSelectDs11()" onkeyup="this.value=this.value.toUpperCase()">
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="���¾�ü�� �˻��մϴ�" style="cursor:hand;position:relative;left:0px;top:0px" align='absmiddle' onclick="fnClientSidPopup();">
						<input id="txt_client_cd" type="hidden" class="boardt04"  style= "position:relative;left:0px;top:3px;color:black;width:100px; height:20px;" maxlength="50" readonly>
						<input id="txt_client_sid" type="hidden"> 
					</td>
					<td align="center" width="100px" class="text">��������</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
             			<%=HDConstant.COMMENT_START%>
         				<object id=txt_educ_plan_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
              				<param name=Format      value="YYYY-MM-DD">
               				<PARAM NAME=InputFormat value="YYYYMMDD">
               				<param name=Alignment   value=1>
               				<param name=ClipMode    value=true>
             				<param name=Border      value=false>
             				</object>
             			<%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text">����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds3>
                        	<param name=SearchColumn    value="saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^150">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
									
				<tr height="25px">
					<td align="center" width="100px" class="text">��ϸ���</td>
					<td bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
                        <object id=drp_visit_object classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
						<param name=ComboDataID     value=ds4>
						<param name=SearchColumn    value="detail_nm">
						<param name=ListExprFormat  value="detail_nm^0^150">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" width="100px" class="text">����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input type="text" name="txt_cust_nm" size="20" maxlength="30" class="textbox"></td>
					<td align="center" width="100px" class="text">�ֹ�/���ǹ�ȣ</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
						<input type="text" name="txt_manage_no" size="20" maxlength="20" class="textbox" onkeyup="this.value=this.value.toUpperCase()"></td>
				</tr>
				<tr>
					<!--<td align="center" width="100px" class="text">����۾�����</td>
					<td align="left" bgcolor="#ffffff">&nbsp;
					   <%=HDConstant.COMMENT_START%>
                        <object id=drp_n_job_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=140 border="0" align=absmiddle>
                            <param name=ComboDataID     value=ds2>
                            <param name=SearchColumn    value="detail_nm">
                            <param name=ListExprFormat  value="detail_nm^0^150">
                        </object>
                        <%=HDConstant.COMMENT_END%>
					</td>-->
					<td align="center" width="100px" class="text">���� ��û��ȣ</td>
					<td bgcolor="#ffffff">&nbsp;
						<input type="text" name="txt_educ_req_no" size="15" maxlength="14" class="textbox" onkeyup="this.value=this.value.toUpperCase()">
					</td>
					<td align="center" width="100px" class="text">��������ι�ȣ</td>
					<td bgcolor="#ffffff" COLSPAN=3>&nbsp;
						<input type="text" name="txt_educ_no" size="15" maxlength="14" class="textbox" onkeyup="this.value=this.value.toUpperCase()">
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	
	<tr height="5px">
		<td></td>										
	</tr>
	
	<tr>
		<td width="100%" colspan="6">
			<table  border="0" cellpadding="0" cellspacing="0" width="100%" >
				<tr height="5px">
					<td></td>										
				</tr>
				<tr>
					<td  valign="top">
						<table border="0" cellpadding="0" cellspacing="0" width="840px" >
							<tr>
								<td>
									<%=HDConstant.COMMENT_START%>
									<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=840px; height:350px" border="1">
									    <param name="DataID"            value="ds1">
									    <param name="BorderStyle"       value="0">
									    <param name="ColSizing"         value="true">
									    <param name="editable"          value="true">
									    <param name="viewSummary"       value="1">
                                        <param name="Format"            value=" 
                                            <C> name='����'				ID={CURROW}			Width=50  align=center </C>
                                            <C> name='�Ҽ�'				ID='client_nm'      Width=130 align=left edit=none</C>
                                            <C> name='����(��)'			ID='positions'      Width=100 align=left edit=none</C>
                                            <C> name='����'				ID='cust_nm'        Width=60 align=left edit=none sumtext=��</C>
									        <C> name='�ֹ�/���ǹ�ȣ'	ID='manage_no'      Width=110  align=left edit=none sumtext=@cnt</C>
                                            <C> name='��ϸ���'			ID='visit_object'	Width=160  align=Left </C>
									        <C> name='�������'			ID='saup_sid'       Width=90  align=left edit=none editstyle=lookup data='ds3:saup_sid:saup_nm'</C>
									        <C> name='���\\(����)'  	ID='req_dt'			Width=100  align=center edit=none mask=XXXX-XX-XX</C>
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

