<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�          : �Ϻ����γ���
 * ���α׷�ID    : AC520B
 * J  S  P       : ac520b
 * �� �� ��         : Ac520B
 * �� �� ��         : �迵��
 * �� �� ��         : 2006-08-24
 * �������      : �Ϻ����γ���
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

%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/><%
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

		fnInit();
	}
    /*
     * ����ȸ
     */
    function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr_master"), "comn");

	    ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�
    }

    function fnSelectDs3() {
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
                    + ",sSaupSid=" + ds_saup.NameValue(ds_saup.RowPosition,"SAUP_SID")
                    + ",sDepartDate="+ v_depart_date.Text;
		
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods,O:S_DEPART_TIME_DS=ds_time)",
            v_param);
        tr_post(tr2);
    }   

    /*
     * ������ȸ
     */
    function fnSelect() {
        v_job = "S";
        
        gr_master.ReDraw = "false";
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + ",v_goods_sid="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
                    + ",v_depart_date=" + v_depart_date.Text
                    + ",v_depart_time=" + v_time.ValueOfIndex("DEPART_TIME", v_time.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq550S",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }
    
    /*
     * ����
     */
    function fnApply() {
        var v_apply_cnt = 0;
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                    + ",dsType=1"
                    + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                    + ",v_goods_sid="+v_goods.ValueOfIndex("GOODS_SID", v_goods.Index)
                    + ",v_depart_date=" + v_depart_date.Text
                    + ",v_depart_time=" + v_time.ValueOfIndex("DEPART_TIME", v_time.Index);
        
        ln_TRSetting(tr_save, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq550S",
            "JSP(I:MASTER=ds_master,O:RESULT=ds_result)",
            v_param);
        tr_post(tr_save);
    }

</script>

<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>

<script language="javascript" for="tr1" event="OnSuccess()">
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
</script>
<script language="javascript" for="tr1" event="OnFail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";

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

<script language="javascript" for="tr2" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>
<script language="javascript" for="tr2" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr2.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";

    var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_POLICE+firstday%>/"+ds_result.NameValue(1, "FILE_NAME")
                + "&realName="+ds_result.NameValue(1, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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
<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    
    if(v_msg!=""){
        alert(v_msg);
    }
</script>

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)" >
    gr_master.ReDraw = "true";
</script>

<script language=JavaScript  for=ds_goods event="OnLoadCompleted(row)" >
    if(row==0) return;
    
    ds_goods.DeleteRow(1);
    v_goods.Index = 1;
</script>

<script language=JavaScript for=v_saup event=OnSelChange()> <!-- ���� ü���� -->
    fnSelectDs3();
</script>

<script language=JavaScript for=v_depart_date event=OnKillFocus()> <!-- ���ð� ���� -->
    if ( v_depart_date.Modified && v_depart_date.Text.trim().length==8) {
        fnSelectDs3();
    }
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
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                                    <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelect()">
                                    <img src="<%=dirPath%>/Sales/images/n_create.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
                                </td>
                            </tr>
                            <tr height="25px">
                                <td>
                                    <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" align=left>
                                        <tr>
                                            <td class="text" width="100">����</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_saup>
                                                    <param name=ListExprFormat  value="saup_nm^0^100">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text" width="100">�������</td>
                                            <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                                                    <param name=Text        value="<%=firstday%>">
                                                    <param name=Alignment   value=1>
                                                    <param name=Format      value="YYYY-MM-DD">
                                                    <param name=InputFormat value="YYYYMMDD">
                                                    <param name=Cursor      value="iBeam">
                                                    <param name=Border      value="false">
                                                    <param name=InheritColor      value="true">
                                                    <param name=ReadOnly        value="false">
                                                    <param name=SelectAll       value="true">
                                                    <param name=SelectAllOnClick    value="true">
                                                    <param name=SelectAllOnClickAny   value=false>
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class="text" width="100">��߽ð�</td>
                                            <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                                    <param name=ComboDataID     value=ds_time>
                                                    <param name=ListExprFormat  value="DEPART_TIME_NM^0^60">
                                                </object>
                                                <%=HDConstant.COMMENT_END%>
                                            </td>
                                            <td class=text>��ǰ��</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_goods>
                                                    <param name=SearchColumn        value="GOODS_NM">
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="GOODS_NM^0^130">
                                                    <param name=BindColumn          value="GOODS_SID">
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
                                        <Param Name="SuppressOption"       value="1">
                                        <param name="Format"            value=" 
                                            <FC> name=''                ID='{CURROW}'       Width=35  align=center  edit=none</FC>
                                            <FC> name='��ǰ'          ID='GOODS_ENG_NM'       Width=120 align=left    edit=none  show=false</C>		
                                            <FC> name='��ǰ'          ID='GOODS_NM'       Width=120 align=left    edit=none suppress=1</C>	
                                            <FC> name='�������'        ID='DEPART_DATE1'   Width=60  align=center  edit=none suppress=2</C>
                                            <C> name='�԰�����'         ID='ARRIVE_DATE1'   Width=60  align=center  edit=none suppress=3</C>
                                            <C> name='�ڷ��������'   ID='JOB_TIME'       Width=90  align=center    edit=none suppress=4</C>
                                            <C> name='������ȣ'         ID='PRT_NO'         Width=80  align=center    edit=none suppress=5</C>
                                            <C> name='�ֹ�/���ǹ�ȣ'  ID='MANAGE_NO'      Width=120 align=left    edit=none</C>
                                            <C> name='���Ϻι�ȣ'    ID='UNITY_NO'       Width=90  align=left    edit=none</C>
                                            <C> name='�������'         ID='DEPART_DATE'    Width=60  align=center  edit=none</C>
                                            <C> name='��������'         ID='ARRIVE_DATE'    Width=60  align=center  edit=none</C>
                                            <C> name='����'           ID='CUST_NM'        Width=80  align=left    edit=none</C>
                                            <C> name='�������'         ID='BIRTHDAY'       Width=60  align=center    edit=none</C>
                                            <C> name='�ֹι�ȣ'         ID='REGI_NO'        Width=100  align=left    edit=none</C>
                                            <C> name='����'           ID='SEX'            Width=50  align=center  edit=none</C>
                                            <C> name='�����ڵ�'         ID='COUNTRY_CD'     Width=50  align=center  edit=none</C>
                                            <C> name='�ּ�'               ID='ADDRESS1'       Width=120  align=left    edit=none</C>
                                            <C> name='��ȭ��ȣ'         ID='TEL_NO'         Width=90  align=left    edit=none</C>
                                            <C> name='�����'          ID='COMPANY_NM'     Width=80  align=left    edit=none/C>
                                            <C> name='�����������'   ID='JOB_OBJ'        Width=80  align=left    edit=none/C>
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

