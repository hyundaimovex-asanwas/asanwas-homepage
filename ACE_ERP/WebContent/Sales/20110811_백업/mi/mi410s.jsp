<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�         : �Ϻ����� ��Ȳ
 * ���α׷�ID       : MI410S
 * J  S  P      : Mi410s
 * �� �� ��        : Mi410S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-08-21
 * �������     : �Ϻ� ���� ��Ȳ
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
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
                Developer Java Script
=============================================================================*/
%>      
        <script language="javascript">
        var v_default_row = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ �ε� 
// Parameter    : 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

        fnInit(); 
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  : ����ȸ 
// Parameter    : 
%>
    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�
        
        ds_cust_gu.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CU001&s_item=Y";
        ds_cust_gu.Reset();
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ȸ
// Parameter    : 
%>
    function fnSelect() {
        if(getObjectFirst("v_job_yymm").Text.trim()=="" || getObjectFirst("v_job_yymm").Text.trim().length!=6){
            alert("�۾������ �Է��Ͻñ� �ٶ��ϴ�.");
            getObjectFirst("v_job_yymm").Focus();
            return;
        }
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_saup_sid="+v_saup.ValueOfIndex ("SAUP_SID", v_saup.Index)
                    + ",v_job_yymm="+getObjectFirst("v_job_yymm").Text
                    + ",v_cust_gu="+v_cust.ValueOfIndex ("DETAIL", v_cust.Index);
                    
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_MI%>Mi410S",
            "JSP(O:MASTER=ds_master)",
            v_param);
        tr_post(tr1);
    }

<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ���� ���� ��� 
// Parameter    : 
%>
    function fnExcel() {
        if(ds_master.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:�Ϻ� ���� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("�Ϻ� ���� ��Ȳ", "�Ϻ� ���� ��Ȳ.xls", 8);
    }

    </script>
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<script language=javascript for="ds_master" event="OnLoadCompleted(row)">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";

    if(row==0)
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
</script>

<%
/*=============================================================================
            Transaction Component's Event Message Scripts
=============================================================================*/
%>  
<script language="javascript" for="tr1" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
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

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<!-- �⺻���� -->
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_cust_gu classid=<%=HDConstant.CT_DATASET_CLSID%>>
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

<table width="845" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()">
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="25px" class="text">����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_saup>
                                        <param name=ListExprFormat  value="saup_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" height="25px" class="text">�۾����</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_job_yymm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Text        value="<%=firstday%>">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                                <td width="100px" height="25px" class="text">������</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_cust_gu>
                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width=845>
                        <%=HDConstant.COMMENT_START%>
                        <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:450px" border="1">
                            <param name="DataID"            value="ds_master">
                            <param name="BorderStyle"       value="0">
                            <param name="ColSizing"         value="true">
                            <param name="editable"          value="False">
                            <param name="SuppressOption"    value="1">
                            <param name="ViewSummary"       value="1">
                            <param name="Format"            value=" 
                                <FC> name='�ڼ�'     ID='GOOD_CLASS'     Width=70   Edit=none align=Center suppress=1 </FC>
                                <FC> name='��ǰ'     ID='GOODS_NM'       Width=100  Edit=none align=Left   suppress=2 </FC>
                                <FC> name='������'   ID='UPJANG_NM'      Width=100  Edit=none align=Left   suppress=3 SumText=�հ�</FC>
                                <C> name='��'       ID='DD_AMT_TT'         Width=100   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='1��'      ID='DD_AMT_01'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='2��'      ID='DD_AMT_02'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='3��'      ID='DD_AMT_03'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='4��'      ID='DD_AMT_04'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='5��'      ID='DD_AMT_05'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='6��'      ID='DD_AMT_06'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='7��'      ID='DD_AMT_07'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='8��'      ID='DD_AMT_08'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='9��'      ID='DD_AMT_09'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='10��'     ID='DD_AMT_10'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='11��'     ID='DD_AMT_11'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='12��'     ID='DD_AMT_12'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='13��'     ID='DD_AMT_13'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='14��'     ID='DD_AMT_14'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='15��'     ID='DD_AMT_15'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='16��'     ID='DD_AMT_16'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='17��'     ID='DD_AMT_17'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='18��'     ID='DD_AMT_18'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='19��'     ID='DD_AMT_19'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='20��'     ID='DD_AMT_20'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='21��'     ID='DD_AMT_21'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='22��'     ID='DD_AMT_22'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='23��'     ID='DD_AMT_23'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='24��'     ID='DD_AMT_24'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='25��'     ID='DD_AMT_25'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='26��'     ID='DD_AMT_26'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='27��'     ID='DD_AMT_27'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='28��'     ID='DD_AMT_28'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='29��'     ID='DD_AMT_29'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='30��'     ID='DD_AMT_30'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                                <C> name='31��'     ID='DD_AMT_31'         Width=80   Edit=none align=Right  SumText=@sum dec=0</C>
                            ">
                        </object>
                        <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
             </table>
         </td>
     </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

