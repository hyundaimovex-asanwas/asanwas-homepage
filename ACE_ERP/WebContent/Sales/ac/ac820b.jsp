<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ����������Ȳ
 * ���α׷�ID   : RV200S
 * J  S  P      : rv200s
 * �� �� ��        : Rv200S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2011-02-21][�ɵ���] ��ȸ���ǿ� [���ͱ���] �߰�
 *						��ȸ�ÿ��� ��� ����. �����ÿ��� ���� ���� ��ũ��Ʈ ó
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

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);

    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());
    date.add(Calendar.DATE, +1);
    String lastday = m_today.format(date.getTime());
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
        var v_default_row = 1;
        /*
         * �������ε�
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

            cfStyleGrid(getObjectFirst("gr_default"), "comn");
            cfStyleGrid(getObjectFirst("gr_master"), "comn");
            fnInit(); 
        } 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */
        function fnInit() {
            fnDateSelect()
        }
        
        function fnDateSelect(){
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_req_date="+ getObjectFirst("v_req_date").Text;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:DATE=ds_date)",
                v_param);
            tr_post(tr1);
        }
        
        function fnSelect(){
            if(getObjectFirst("v_req_date").Text.trim()=="" 
                || getObjectFirst("v_req_date").Text.trim().length!=8){
                alert("û������<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_req_date").Focus();
                return;
            }
            
            gr_default.ReDraw = "False";
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                        + ",dsType=1"
                        + ",v_req_date="+ getObjectFirst("v_req_date").Text
   			          	+ ",sJob_seq=" + sJob_seq.value;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:DEFAULT=ds_default,O:MASTER=ds_master)",
                v_param);
            tr_post(tr1);
        }

        function fnApply() {
			if(sJob_seq.value==""){
				alert("���� ������ ���� ���ͱ����� �� �����ؾ� �մϴ�.");
				return;
			}
            var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
                        + ",v_req_date="+getObjectFirst("v_req_date").Text
   			          	+ ",sJob_seq=" + sJob_seq.value;
                        
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac820B",
                "JSP(O:RESULT=ds_result)",
                v_param);
            tr_post(tr1);
        }
        
        function fnExcel() {
            if(ds_default.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr_master").SetExcelTitle(0, "");
            getObjectFirst("gr_master").SetExcelTitle(1, "value:�ſ�ī�����Ȯ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_master").GridToExcel("�ſ�ī�����Ȯ�� (����)", "�ſ�ī�����Ȯ��.xls", 32);

            getObjectFirst("gr_default").SetExcelTitle(0, "");
            getObjectFirst("gr_default").SetExcelTitle(1, "value:�ſ�ī�����Ȯ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_default").GridToExcel("�ſ�ī�����Ȯ��", "�ſ�ī�����Ȯ��.xls", 32);
        }
    </script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";         
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

<script language=javascript for=ds_default event="OnLoadCompleted(Row)">
    if(Row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
    gr_default.ReDraw = "True";
</script>

<script language=javascript for=v_req_date event="OnKillFocus()">
    if(v_req_date.Modified)
        fnDateSelect();
</script>

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

	
	var v_param = "sourceName=<%=HDConstant.FILE_UPLOAD_PATH_CARD%>"+ds_result.NameValue(row, "FILE_NAME")
                + "&realName="+ds_result.NameValue(row, "FILE_NAME");
    
    location.href = "<%=dirPath%><%=HDConstant.PATH_COMMON%>DownLoadFile?"+v_param;
</script>


<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_master classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_date classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width='100%'> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/n_create.gif" style="cursor:pointer" align=absmiddle onClick="fnApply()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='25px'>
                        <td class="text"  width="100">û������</td>
                        <td align=left bgcolor="#ffffff">&nbsp;
                            <object id=v_req_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="<%=firstday%>">
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
                                                                                                         
                        </td>                                                                                           
                        <td class="text"  width="100">��������</td>
                        <td align=left bgcolor="#ffffff">&nbsp;
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">
                                <param name=InheritColor      value="true">
                                <param name=Enable      value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object> ~ 
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=InputFormat value="YYYYMMDD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=Enable      value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                                                                                                         
                        </td>
					 	<td align=center class="text" width="70">���ͱ���</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<select name="sJob_seq">
								<option value=""> �� ü </option>
								<option value="1"> �� �� </option>
								<option value="2"> �� �� </option>
							</select>
						</td>	
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
                        <td width=495>
                            
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='495px' height='420px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='ī���'    ID='CARD_COMPANY_NM'      width=80 align=center Edit=None SumText='�հ�'</C>
                                     <G> name='���γ���'
                                     <C> name='�Ǽ�'      ID='Y_CNT'        width=95 align=right Edit=None SumText=@sum</C>
                                     <C> name='�ݾ�'      ID='Y_AMT'          width=100 align=right Edit=None dec=0 SumText=@sum</C>
                                     </G>
                                     <G> name='��ҳ���'
                                     <C> name='�Ǽ�'      ID='N_CNT'        width=95 align=right Edit=None SumText=@sum</C>
                                     <C> name='�ݾ�'      ID='N_AMT'          width=100 align=right Edit=None dec=0 SumText=@sum</C>
                                     </G>
                             ">                             
                            </object>   
                            
                        </td>
                        <td width=10>&nbsp;</td>
                        <td width=340 valign=top>
                            
                            <object id=gr_master classid=<%=HDConstant.CT_GRID_CLSID%> width='340px' height='420px' border='1'>
                                <param name="DataID"            value="ds_master">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="Format"            value="
                                     <C> name='����'          ID='NAME'       width=120 align=center Edit=None</C>
                                     <C> name='�Ǽ�'          ID='TOT_CNT'        width=100 align=right Edit=None</C>
                                     <C> name='�ݾ�'          ID='TOT_AMT'        width=100 align=right Edit=None dec=0</C>
                             ">
                            </object>
                            
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <object id=Bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
        <param name="DataId" value="ds_date">
        <param name=BindInfo    value="
            <C>Col=FR_DATE     Ctrl=v_fr_date          Param=Text</C>
            <C>Col=TO_DATE      Ctrl=v_to_date          Param=Text</C>
        ">
    </object>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

