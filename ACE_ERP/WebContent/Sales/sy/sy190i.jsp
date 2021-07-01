<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�    	: ȯ������
 * ���α׷�ID  	: SY190I
 * J  S  P     	: sy190i
 * �� �� ��    	: Sy190I
 * �� �� ��    	: ����ǥ
 * �� �� ��    	: 2006-09-19
 * �������    	: ȯ������
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
	date.set(java.util.Calendar.HOUR_OF_DAY, 240);      
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
    var v_job = "H";
  
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
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr_master"), "comn");
                
        ds_currency.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV022&s_item1=Y";
        ds_currency.Reset();//ȯ������
		
    }
    
    /*
     * ������ȸ
     */
    function fnSelect() {
        v_job = "S";
        
        gr_master.ReDraw = "false";
        
        if(ds_master.IsUpdated){
            alert("�������� ������ �ֽ��ϴ�.");
            return;
        }
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_currency_cd="+v_currency_cd.ValueOfIndex("DETAIL", v_currency_cd.Index)
                    + ",v_job_date="+v_job_date.Text;
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy190I",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    
    function fnAddRow(){
        ds_master.AddRow();
        if(ds_master.CountRow==0){
            alert("���� ��ȸ�� �߰��Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        ds_master.NameValue(ds_master.CountRow, "CURRENCY_CD") = v_currency_cd;
        ds_master.NameValue(ds_master.CountRow, "FR_DATE") = v_job_date;
    }
    
    function fnDeleteRow(){
        if(ds_master.RowPosition==0) return;
        
        ds_master.DeleteRow(ds_master.RowPosition);
    }
    
    /*
     * ����
     */
    function fnApply() {
        var v_apply_cnt = 0;
        if (ds_master.IsUpdated==false) {
            alert("����� ������ �����ϴ�.");
            return;
        }
        
        for(i=1; i<=ds_master.CountRow; i++) {
            if(ds_master.NameValue(i, "TO_DATE")=="" || ds_master.NameValue(i, "TO_DATE")=="0"){
                alert("�������� <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("TO_DATE");
                ds_master.RowPosition = i;
                return;
            }
            if(ds_master.NameValue(i, "EXCH_RATE")=="" || ds_master.NameValue(i, "EXCH_RATE")=="0"){
                alert("ȯ�� <%=HDConstant.A_MSG_MUST_INPUT%>");
                gr_master.SetColumn("EXCH_RATE");
                ds_master.RowPosition = i;
                return;
            }
            
        }

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy190I",
            "JSP(I:MASTER=ds_master,O:RESULT=ds_result)",
            v_param);
        tr_post(tr_save);
       
       ds_master.Reset();
    }

    /*
     * ���
     */
    function fnCancel() {
        ds_master.UndoAll();
        window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
    }

</script>

<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
</script>

<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<%
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)" >
    gr_master.ReDraw = "true";
</script>

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id=ds_currency classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
    <param name="StatusResetType"  value="2">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


                                    
<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <table border="0" width="845px"  cellpadding="0" cellspacing="0">
                <tr>
                    <td align="right" colspan="2">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr bgcolor="#ffffff">
                                <td align="right" height="30px">        
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/plus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnAddRow()">
                                    <img src="<%=dirPath%>/Sales/images/minus.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()">
                                    <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                                    <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr>
                                            <td class=text>��������</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                 <object id=v_job_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox">			
													<param name=Text 		value="<%=firstday%>">
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
                                            <td class=text>��ȭ�ڵ�</td>
                                            <td bgcolor="#ffffff" colspan=3>&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_currency_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_currency>
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="DETAIL_NM^0^130">
                                                    <param name=BindColumn          value="DETAIL">
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
                    <td height='5px'></td>
                </tr>
                <tr>
                    <td width="845px" colspan='2'>
                        <table  border="0" cellpadding="0" cellspacing="0" >
                            <tr valign="top"">
                                <td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
                                    <%=HDConstant.COMMENT_START%>
                                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_master  style="width=845px; height:420px" border="1">
                                        <param name="DataID"            value="ds_master">
                                        <param name="BorderStyle"       value="0">
                                        <param name="ColSizing"         value="true">
                                        <param name="editable"          value="true">
                                        <Param Name="UsingOneClick"     value="1">
                                        <Param Name="AllShowEdit"       value="True">
                                        <param name="Format"            value=" 
                                            <C> name='��ȭ�ڵ�'       	ID='CURRENCY_CD'     	Width=60  	align=left 		editstyle=Lookup Data='ds_currency:DETAIL:DETAIL_NM'</C>
                                            <C> name='��������'     		ID='FR_DATE'      		Width=100  	align=center 	mask=XXXX-XX-XX</C>
                                            <C> name='��������'          	ID='TO_DATE'      		Width=100  	align=center 	mask=XXXX-XX-XX</C>
                                            <C> name='ȯ��'     			ID='EXCH_RATE'        	Width=60  	align=right 	DEC=2</C>
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

