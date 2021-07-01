<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ī��ŷ���Ȳ
 * ���α׷�ID   : AC820I
 * J  S  P      : ac820i
 * �� �� ��        : Ac820I
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-08-11
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-12-18][�ɵ���] ������ ������ ���� ��ǰ �÷� �߰�..
 * [2010-01-19][�ڰ汹] ���� GRID���� ��ǰ/������� �÷� ����.. 
                        �������� ��ǰ�� ���ÿ� ����� �ߺ��� �ŷ������� ��ȸ�Ǵ� ���� ����..
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
    
    String toDay = m_today.format(date.getTime());
    String startDay = "";
    String endDay = "";

    //�������̸� ����� ���� �Ͽ��ϱ��� �ŷ��� ���ؼ��� �������ָ�,
    //��Ÿ ������ ���� �����ڿ� ���ؼ��� �������ش�.
    if(java.util.Calendar.DAY_OF_WEEK == java.util.Calendar.MONDAY){
        date.add(java.util.Calendar.DATE, -2);
        startDay = m_today.format(date.getTime());
        date.add(java.util.Calendar.DATE, +1);
        endDay = m_today.format(date.getTime());
    } else {
        date.add(java.util.Calendar.DATE, -1);
        startDay = m_today.format(date.getTime());
        endDay = m_today.format(date.getTime());
    }
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
        var v_today = "<%=toDay%>";
        /*
         * �������ε�
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

            cfStyleGrid(getObjectFirst("gr_default"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn1");
            fnInit(); 
        } 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */ 
        function fnInit() {
            //�۾�����
            ds_job_sel.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC014";
            ds_job_sel.Reset();
 
 			//��������           
   	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_SAUP_DS_ALL=codeDs1)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);   
        }
        
        function fnSelect(v_job_gu){
            if(getObjectFirst("v_fr_date").Text.trim()=="" 
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("�ŷ�����(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()=="" 
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("�ŷ�����(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }

            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
                        + ",v_to_date="+getObjectFirst("v_to_date").Text
                        + ",v_job_sel="+v_job_sel.ValueOfIndex ("DETAIL", v_job_sel.Index)
                        + ",v_card_no="+getObjectFirst("v_card_no").Text
                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
                        + ",v_issue_company_nm="+getObjectFirst("v_issue_company_nm").value
						+ ",v_job_gu="+v_job_gu		//--����� �� 1�� ���ư���..�Ŀ�..
	                    + ",v_saup_sid=" + v_saup_sid.ValueOfIndex("saup_sid", v_saup_sid.Index);

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(O:DEFAULT=ds_default)",
                v_param);
            tr_post(tr1);
        }
//        function fnSelect2(){
//        	gr_default.ReDraw = "False";
//            var v_param = "proType=<%//=HDConstant.PROCESS_TYPE_APPLY%>"
//                        + ",dsType=1"
//                        + ",v_fr_date="+getObjectFirst("v_fr_date").Text
//                        + ",v_to_date="+getObjectFirst("v_to_date").Text
//                        + ",v_job_sel="+v_job_sel.ValueOfIndex ("DETAIL", v_job_sel.Index)
//                        + ",v_card_no="+getObjectFirst("v_card_no").Text
//                        + ",v_accept_no="+getObjectFirst("v_accept_no").Text
//                        + ",v_issue_company_nm="+getObjectFirst("v_issue_company_nm").value;
//
//            ln_TRSetting(tr1, 
//                "<%//=dirPath%><%//=HDConstant.PATH_AC%>Ac820I",
//                "JSP(O:DEFAULT2=ds_default2)",
//                v_param);
//            tr_post(tr1);
        
        
 //       }

        function fnSave(){
            if(ds_default.IsUpdated==false){
                alert("����� ������ �����ϴ�.");
                return;
            }
            
            for(var i=1; i<=ds_default.CountRow; i++){
                if(ds_default.RowStatus(i)==3){
                    var t_req_date = ds_default.NameValue(i, "REQ_DATE").trim();
                    if(ds_default.NameValue(i, "JOB_SEL")=="T"){
                        if(t_req_date=="" || t_req_date.length!=8){
                            alert("û������ <%=HDConstant.A_MSG_MUST_INPUT%>");
                            ds_default.RowPosition = i;
                            gr_default.SetColumn("REQ_DATE");
                            return;
                        } else {
                            if(t_req_date<v_today){
                                alert("û�����ڴ� �������� ���ķ� �����Ͻñ� �ٶ��ϴ�.");
                                ds_default.RowPosition = i;
                                gr_default.SetColumn("REQ_DATE");
                                return;
                            }
                        }
                    } else if(ds_default.NameValue(i, "JOB_SEL")=="F"){
                        if(t_req_date!=""){
                            alert("�����Ͻñ� �ٶ��ϴ�.");
                            ds_default.RowPosition = i;
                            gr_default.SetColumn("JOB_SEL");
                            return;
                        }
                    }
                }
            }
            
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                        + ",dsType=1";
                        
            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(I:DEFAULT=ds_default,O:RESULT=ds_result)",
                v_param);
            tr_post(tr_save);
            fnSelect('2');
        }

        function fnCancel(){
            ds_default.UndoAll();
        }
        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:ī��ŷ� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("ī��ŷ� ��Ȳ", "ī��ŷ� ��Ȳ.xls", 8);
        }
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

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

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
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
</script>

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr_default.ReDraw = "True";
</script>

<script language=javascript for=gr_default event="OnClick(Row,Colid)">
    if(Row==0) {
        if(Colid=="JOB_SEL" || Colid=="REQ_DATE"){
            gr_default.ReDraw = "false";
            for(var i=2; i<=ds_default.CountRow; i++) {
                if(ds_default.NameValue(i, "REQ_YN")!="Y")
                    ds_default.NameValue(i, Colid) = ds_default.NameValue(1, Colid);
            }
            gr_default.ReDraw = "true";
        }
        return;
    }
    
    if(Colid=="JOB_SEL" || Colid=="REQ_DATE"){
        if(ds_default.NameValue(Row, "REQ_YN")=="Y"){
            ds_default.NameValue(Row, "JOB_SEL") = "T";
            if(Colid=="REQ_DATE"){
                gr_default.ColumnProp(Colid, "Edit") = "None";
            }
        } else {
            if(Colid=="REQ_DATE"){
                gr_default.ColumnProp(Colid, "Edit") = "Numeric";
            }
        }
    }
    if(Colid=="JOB_SEL" || Colid=="REQ_DATE" || Colid=="ACCEPT_NO" || Colid=="PAY_DATE" || Colid=="CARD_COMPANY_NM" || Colid=="CARD_NO" || Colid=="AGREE_NO" || Colid=="PAY_AMT" || Colid=="PAY_MANAGE_NO"){
    	 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
						+ ",v_pay_manage_no="+ds_default.NameValue(ds_default.RowPosition,"PAY_MANAGE_NO");
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820I",
                "JSP(O:DS2=ds2)",
                v_param);
            tr_post(tr1);
    }
</script>

<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
    if(Row==0) return;
    
    var v_result_msg = "";
    for(var i=1; i<=ds_result.CountRow; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_result_msg += ds_result.NameValue(i, "MSG")+"\n"
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
</script>

<script language=JavaScript for=v_fr_date event=OnKillFocus()>
   if( v_fr_date.Modified == true )
		v_to_date.text = v_fr_date.text;
</script>		
<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_default2 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_job_sel classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ�ڵ� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ�ڵ� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����������� -->
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect('1')">
                            <img src="<%=dirPath%>/Sales/images/save.gif"  style="cursor:hand" align=absmiddle onclick="fnSave()">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif"  style="cursor:hand" align=absmiddle onclick="fnCancel()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="100">�ŷ�����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=startDay%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object> ~ 
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=endDay%>">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>                                                                                           
                        <td class="text" width="100">�۾�����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_job_sel classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=120 border="0" align=absmiddle>
                                <param name=ComboDataID     value=ds_job_sel>
                                <param name=ListExprFormat  value="detail_nm^0^120"></object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text" >����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup_sid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=codeDs1>
                                <param name=ListExprFormat  value="saup_nm^1^80,saup_sid^1^40">
								<param name=SearchColumn	value="saup_nm">
								<param name=BindColumn		value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>					
                        
                    </tr>
                    <tr height='25px'>
                        <td class="text" width=100>��û����ȣ</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000-000000000">
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
                        <td class="text" width=100>ī���ȣ</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_card_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=130 align=center class="textbox">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="0000-0000-0000-0000">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class="text" width=100>ī����</td>
                        <td bgcolor="#FFFFFF">&nbsp;<input type="text" name="v_issue_company_nm" size="10" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 10);"></td>
                    </tr>
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td width="845" valign=top>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                    <tr>
                        <td width=630>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='630px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="true">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
								<param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='���á�'     ID='JOB_SEL'            width=35  align=center EditStyle='CheckBox' CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</FC>
                                     <C> name='û���ϡ�'      ID='REQ_DATE'              width=70  align=center Edit=Numeric EditLimit=8 Mask='XXXX-XX-XX' SumText=�հ�</C>
                                     <C> name='��û����ȣ'  ID='ACCEPT_NO'           width=90 align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' SumText=@cnt</C>
                                     <C> name='�ŷ���'      ID='PAY_DATE'              width=70  align=center Edit=None Mask='XXXX-XX-XX' bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='ī���'      ID='CARD_COMPANY_NM'   width=40  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='ī���ȣ'    ID='CARD_NO'            width=120  align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' mask='XXXX-XXXX-XXXX-XXXX'</C>
									 <C> name='�Һ�'    ID='CARD_HALBU'            width=30  align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' mask='XX'</C>
                                     <C> name='���ι�ȣ'    ID='AGREE_NO'           width=60 align=center Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                     <C> name='�ŷ��ݾ�'    ID='PAY_AMT'            width=70  align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0 SumText=@sum</C>
                                     <C> name='����������ȣ'    ID='PAY_MANAGE_NO'   width=90  align=left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
									 <C> name='����'		ID='SAUP_SID' Width=60 Align=center editstyle=lookup data='codeDs1:saup_sid:saup_nm' bgcolor='<%=HDConstant.GRID_ITEM%>' Show=true </C>
							 ">                             
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td width=207>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='207px' height='420px' border='1'>
                                <param name="DataID"            value="ds2">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <Param Name="UsingOneClick"     value="1">
                                <Param Name="AllShowEdit"       value="True">
                                <param name="ViewSummary"		value="1">
                                <param name="Format"            value="
									<C> name='�̸�'     	 ID='CUST_NM'       width=60 align=center  SumText='�հ�' </C>
									<C> name='�ֹ�/���ǹ�ȣ' ID='MANAGE_NO'		width=90 align=center </C>
									<C> name='������'  		 ID='PAY_AMT'       width=60 align=right dec=0 SumText=@sum</C>
									<C> name='ȸ��\\����'    ID='ACCT_GUBN_NM'  Width=40 align=Center</C>
									<C> name='�Ա�\\���'    ID='PAY_CD_NM'     Width=40 align=Left   show=false </C>
									<C> name='�Ա�\\����'    ID='PAY_YN'        Width=35 align=Center show=false </C>
									<C> name='��û����ȣ'	 ID='ACCEPT_NO'     width=90 align=center show=false </C>
                             ">                             
                            </object>    
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><br>�� ��ǰ�� ���������� ��ȸ�Ϸ��� [����=��ü]�̾�� �ϸ� ��û����ȣ,ī���ȣ�� ���õ˴ϴ�.

            </td>
        </tr>
        
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

