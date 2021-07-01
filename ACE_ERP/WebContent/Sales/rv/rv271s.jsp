<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ���� ��û�� ��ȸ
 * ���α׷�ID   : RV270S
 * J  S  P      : rv270s
 * �� �� ��        : Rv270S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-08-31
 * �������     :
 * ��������     : 
 * �� �� ��        :
 * ������������   :
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
    // ContextPath
    String dirPath = request.getContextPath(); //HDASan
    
    
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());           
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <!-- HEAD ���� -->
    <jsp:include page="/Sales/common/include/head.jsp"/>
    
<%
/****************************************************************************
                ����� ��ũ��Ʈ
******************************************************************************/
%>      
        <script language="javascript">
         var div='';
        /*
         * �������ε�
         */
        function fnOnLoad(){
            cfStyleGrid(getObjectFirst("gr1"), "comn");
            fnInit();
        } 
         
        function fnInit() {
            // ����
            ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=S";
            ds_saup.Reset(); //�����ڵ�
        }
        
        
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            if(getObjectFirst("v_fr_date").Text.trim()=="" 
                || getObjectFirst("v_fr_date").Text.trim().length!=8){
                alert("�������(From)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_fr_date").Focus();
                return;
            }
            if(getObjectFirst("v_to_date").Text.trim()=="" 
                || getObjectFirst("v_to_date").Text.trim().length!=8){
                alert("�������(To)<%=HDConstant.A_MSG_MUST_INPUT%>");
                getObjectFirst("v_to_date").Focus();
                return;
            }
            
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ v_saup.ValueOfIndex("saup_sid", v_saup.Index)
                      + ",v_upjang_sid=" + v_upjang.ValueOfIndex("upjang_sid", v_upjang.Index)
                      + ",v_fr_date=" + v_fr_date.Text
                      + ",v_to_date=" + v_fr_date.Text
                      + ",v_cust_nm=" + v_cust_nm.value;
                      
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv270S",
                "JSP(O:MASTER=ds1)",
                param);
               
            tr_post(tr1);
        }
            
        /*
         * ����
         */
        function fnExcel() {
            if(ds1.countrow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            } 
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:���񽺿�û����ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("���񽺿�û����ȸ","���񽺿�û����ȸ.xls", 8);
        }
        
    
        </script>
<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
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

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)" >
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
        return;
    }
</script>

<script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=2"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=99"
                + "&s_use_yn=Y";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //����
</script>

<script language=JavaScript  for=v_fr_date event="OnKillFocus()" >
    if(v_fr_date.Modified)
        v_to_date.Text = v_fr_date.Text
</script>

<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=true>
</object>
<object id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������-->
    <param name="SyncLoad"  value="true">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
    </head>
    
<body leftmargin="10" topmargin="10" marginwidth="0" marginheight="0" onLoad="fnOnLoad();">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->       
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
       <td width="422" height="30" align="left" valign="middle" class="tt"><img src="/HDASan/Sales/images/icon.gif" width="14" height="14"> ���� ��û�� ��ȸ</td>
     </tr>
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td width='845px'>
                <table  border='0' cellpadding='0' cellspacing='0' width='845'>
                    <tr>
                        <td align=right>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"      style="cursor:hand" align=absmiddle onclick="fnSelect()">       <!-- ��ȸ -->
                            <img src="<%=dirPath%>/Sales/images/excel.gif"      style="cursor:hand" align=absmiddle onClick="fnExcelDs1()">     <!-- ���� -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px">
            <td></td>
        </tr>
        <tr height="30px">
            <td width='845px'>
                <table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
                    <tr height='30px'>
                        <td align=left class="text" width="80">����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^80">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td align=left class="text" width="80">������</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^180">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td align=left class="text" width="80">�������</td>
                        <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                            <%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox">
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
                                <param name=SelectAllOnClickAny   value="false">
                            </object>~
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox">
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
                                <param name=SelectAllOnClickAny   value="false">
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>
                        <td align=left class="text" width="80">����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<input type=text name=v_cust_nm class=txtbox size=10>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height='10px'>
            <td></td>
        </tr>
        <tr>
            <td colspan='2'>
                <table  border='0' cellpadding='0' cellspacing='1' >
                    <tr>
                        <td>
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='480px' border='1'>
                                <param name="DataID"        value="ds1">
                                <param name="ColSizing"     value="true">
                                <param name="Fillarea"      value="false">
                                <param name="Editable"      value="false">
                                <param name="BorderStyle"   value="0">
                                <param name=SortView        value="Left">
                                <param name="SuppressOption"    value="1">
                                <param name="Format"            value="
                                    <C> name=''             ID='{CURROW}'     width=35    align=center edit=none</C>
                                    <C> name='�����'        ID='UPJANG_NM'    width=120   align=left suppress=1</C>
                                    <C> name='�޴���'        ID='MENU_NM'      width=120   align=left suppress=2</C>
                                    <C> name='������'        ID='CUST_NM'      width=80   align=left </C>
                                    <C> name='������ȣ'      ID='MANAGE_NO'    width=90    align=left </C>
                                    <C> name='�������'      ID='DEPART_DATE'  width=80    align=left mask='XXXX-XX-XX'</C>
                                    <C> name='�ο�'         ID='SALE_QTY'     width=40    align=center </C>
                                    <C> name='��ȭ'         ID='CURRENCY_NM'  width=40    align=center </C>
                                    <C> name='�ܰ�'         ID='UNIT_AMT'     width=70   align=right dec=0</C>
                                    <C> name='�ݾ�'         ID='SUM_AMT'      width=80   align=right dec=0</C>
                                    <C> name='����'         ID='RSV_PAY_YN'   width=40   align=center</C>
                                    <C> name='�������'      ID='REMARKS'      width=150   align=left</C>
                                    <C> name='��û����ȣ'    ID='ACCEPT_NO'    width=100   align=left</C>
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
    <iframe id="LowerFrame" 
            name="work" 
            style="visibility:hidden; position:absolute; left:280px; top:220px;" 
            Frameborder="0" src="/HDASan/Sales/common/img/flash/loading.swf" 
            width="320px" 
            height="42px">
    </iframe>   
<!---------------------------------- BODY End --------------------------------> 
    </body>
</html>