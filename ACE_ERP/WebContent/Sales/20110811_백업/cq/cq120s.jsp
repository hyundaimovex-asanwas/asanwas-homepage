<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ž���ڿ�����Ȳ
 * ���α׷�ID   : CQ120S
 * J  S  P      : cq120s
 * �� �� ��        : Cq120s
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
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
    date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
    String firstday = m_today.format(date.getTime());        

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
            var div = "";
            var jobFlag = "";
        /*
         * �������ε�
         */
       	function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

            cfStyleGrid(getObjectFirst("gr_cust"), "comn");
            cfStyleGrid(getObjectFirst("gr_tour"), "comn");
            fnInit(); 
        } 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */
        function fnInit() {
            sBgnDate.text='<%=firstday%>';  
                div.value = 'init';
            initDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			initDs1.Reset(); //�����ڵ�
        }
        
        /*
         * ���ð�, ��ǰ��ȸ
         */     
        function fnSelectCodeDs() {
        
            window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";  
            var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
                + "sSaupSid=" + initDs1.namevalue(initDs1.rowposition,"saup_sid") + ","
                + "sDepartDate=" + sBgnDate.text;
            ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
                "JSP(O:S_DEPART_TIME_DS=initDs2,O:S_GOODS_DS=initDs3)",
                param);
            tr_post(tr2);
        }   
    
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
                      + ",sDepart_date=" + sBgnDate.Text
                      + ",sDepart_time=" + lc2.ValueOfIndex("depart_time", lc2.Index)
                      + ",sGoods_sid=" + lc3.ValueOfIndex("goods_sid", lc3.Index);
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq120S",
                "JSP(O:DS_CUST=ds_cust, O:DS_TOUR=ds_tour)",
                param);
               
            tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr_tour").SetExcelTitle(0, "");
            getObjectFirst("gr_tour").SetExcelTitle(1, "value:��/�� ������ ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_tour").GridToExcel("���� ������ ���", "ž���ڿ�����Ȳ.xls", 32);        

            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:ž�¿��� �ο���Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("ž�¿��� �ο���Ȳ", "ž���ڿ�����Ȳ.xls", 32);        
        }
        </script>
        

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
    <script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row,colid)">
        window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";
        for (i = 1; i<=ds_cust.countrow; i++) {
            ds_cust.namevalue(i,"flag") = "y";
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
    </script>   
    
    
    <script language=JavaScript  for=initDs1 event="OnLoadCompleted(row)"> <!-- ���� -->
            fnSelectCodeDs();
    </script>
    
    <script language=JavaScript  for=initDs2 event="OnLoadCompleted(row)"> <!-- ���ð� -->
            lc2.Index = 0;
    </script>
    
    
    <script language=JavaScript  for=initDs3 event="OnLoadCompleted(row)"> <!-- ��ǰ -->
            div.value = '';
            initDs3.deleteRow(1);
            lc3.Index = 0;
    </script>
    
    
    <script language=JavaScript for= lc1 event=OnSelChange()> <!-- ���� ü���� -->
        if ( div.value != 'init') {
            fnSelectCodeDs();
        }
    </script>
    
    <script language=JavaScript for=sBgnDate event=OnKillFocus()> <!-- ���ð� ���� -->
        if ( div.value != 'init' ) {    //�������
            if ( sBgnDate.Modified ) {
                div.value = 'init';
                fnSelectCodeDs();           
            }
        }               
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
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_tour classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=initDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=initDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ð� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=initDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ǰ���� -->
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    <tr height='30px'>
                        <td align=left class="text" width="70">����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;                                                                                                     
                            <%=HDConstant.COMMENT_START%>
                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                <param name=ComboDataID     value=initDs1>
                                <param name=BindColumn      value="saup_sid">
                                <param name=BindColVal      value="saup_sid">
                                <param name=EditExprFormat  value="%,%;saup_sid,saup_nm">
                                <param name=ListExprFormat  value="saup_nm^0^120">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>   
                        <td align=left class="text"  width="70"><b>�������</b></td>
                        <td align=left bgcolor="#ffffff">&nbsp;                                                                                         
                            <%=HDConstant.COMMENT_START%>
                            <object id=sBgnDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">            
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="0000-00-00">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">                                                                                   
                            </object>&nbsp;
                        
                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
                                <param name=ComboDataID     value=initDs2>
                                <param name=BindColumn      value="depart_time">
                                <param name=BindColVal      value="depart_time">
                                <param name=EditExprFormat  value="%,%;depart_time,depart_time_nm">
                                <param name=ListExprFormat  value="depart_time_nm^0^50">
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>                                                                                           
                        <td align=left class="text" width="70">��ǰ����</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;                                                                                         
                                <%=HDConstant.COMMENT_START%>
                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=150 border="0" align=absmiddle>
                                <param name=ComboDataID     value=initDs3>
                                <param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
                                <param name=EditExprFormat  value="%,%;goods_sid,goods_nm">
                                <param name=ListExprFormat  value="goods_nm^0^140"></object>
                            <%=HDConstant.COMMENT_END%>&nbsp;   
                        </td>
                    </tr>
                </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <%=HDConstant.COMMENT_START%>
                <object id=tb_config classid=<%=HDConstant.CT_TAB_CLSID%> style="width=300; height=20">
                    <param name="BackColor"         value="#F3F3F3">
                    <param name="DisableBackColor"  value="#fffff0">
                    <param name="Format"            value='
                      <T>divid="tb_cust"        title="ž�¿��� �ο���Ȳ"</T>
                      <T>divid="tb_tour"        title="���� ������ ���"</T>'>
              </object>
              <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                            <table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
                                <tr>
                                    <td valign=top>
                                        <div id="tb_cust"  style="position:absolute; width:845px; height=350px">
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                                <param name="DataID"            value="ds_cust">
                                                <param name="ColSizing"         value="true">
                                                <param name="Editable"          value="true">
                                                <param name="SuppressOption"    value="1">
                                                <param name="BorderStyle"       value="0">
                                                <param name="Format"            value="
                                                     <C> name='������'      ID='CUST_GU'      width=100 align=left Edit=None suppress=1</C>
                                                     <C> name='�������'      ID='SAUP_GU'      width=100 align=left Edit=None suppress=2</C>
                                                     <C> name='��������'      ID='COUNTRY_GU'   width=100 align=left Edit=None suppress=3</C>
                                                     <C> name='��'           ID='CLASS'        width=100 align=left Edit=None</C>
                                                     <C> name='�ο�'         ID='I_CNT'        width=60 align=rightt Edit=None</C>
                                             ">                             
                                            </object>   
                                            <%=HDConstant.COMMENT_END%>
                                        </div>
                                        <div id="tb_tour"  style="position:absolute; width:845px; height=350px">
                                            <%=HDConstant.COMMENT_START%>
                                            <object id=gr_tour classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                                <param name="DataID"            value="ds_tour">
                                                <param name="ColSizing"         value="true">
                                                <param name="Editable"          value="true">
                                                <param name="SuppressOption"    value="1">
                                                <param name="BorderStyle"       value="0">
                                                <param name="Format"            value="
                                                     <C> name='��'            ID='CLASS'         width=100 align=left Edit=None suppress=1</C>
                                                     <C> name='��'            ID='TEAMS'         width=40 align=right Edit=None suppress=2</C>
                                                     <C> name='����'           ID='TOUR_NO'       width=40 align=right Edit=None</C>
                                                     <C> name='����'           ID='CUST_NM'       width=70 align=left Edit=None</C>
                                                     <C> name='�������'        ID='BIRTHDAY'      width=60 align=left Edit=None</C>
                                                     <C> name='����/����'       ID='COMP_NM1'      width=140 align=left Edit=None</C>
                                                     <C> name='�ּ�'           ID='ADDRESS1'      width=200 align=left Edit=None</C>
                                                     <C> name='����Ÿ��'        ID='ROOM_TYPE_CD'  width=80 align=left Edit=None</C>
                                                     <C> name='����'           ID='ROOM_NO'       width=60 align=left Edit=None</C>
                                             ">                             
                                            </object>   
                                            <%=HDConstant.COMMENT_END%>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
   
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
        <input type='hidden' name='div' value=''>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

