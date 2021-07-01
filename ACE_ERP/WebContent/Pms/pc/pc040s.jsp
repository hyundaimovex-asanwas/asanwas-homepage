<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���庰 ������Ȳ
 * ���α׷�ID 	 : PMS/PC020S
 * J  S  P		 : pc020s.jsp
 * �� �� ��		 : Pc020S
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2011-07-01
 * �������		 : �����̷�(����-��������) ��Ȳ
 * [ �������� ][������] ����
 * [2011-07-01][�ɵ���] �ű�
 * [2013-07-12][�ڰ汹] ������������ ���庰 ������Ȳ�޴� �ű�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
        ds_reco_dept.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT006&s_item1=Y";
        ds_reco_dept.Reset(); //��õ�μ�

        ds_bid_style.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT005&s_item1=Y";
        ds_bid_style.Reset();	//��������
    
        v_fr_bid_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_bid_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        v_pct_fr.Text = "  0";
        v_pct_to.Text = "  0";

    }
    
    
    
    <%//���� ��ȸ pr_rv200s_01_plz ȣ�� %>
    function fnSelect() {
        var fr_date = v_fr_bid_date.Text.trim();
        var to_date = v_to_bid_date.Text.trim();
        var bid_status = "only";
        if(fr_date.length!=8) {
            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
        if(to_date.length!=8) {
            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
    	}
    	if(v_bid_status.checked){
    		bid_status="ALL";	//�������� ���ζ�� ��
    	}
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                  + ",v_site_sid="+ v_site_sid.value
                  + ",v_bid_kind_cd=" + v_bid_kind_cd.value
                  + ",v_fr_bid_date=" + fr_date
                  + ",v_to_bid_date=" + to_date
                  + ",v_coop_sid=" + v_coop_sid.value                      
                  + ",v_pct_fr=" + v_pct_fr.Text
                  + ",v_pct_to=" + v_pct_to.Text
                  + ",v_reco_cd=" + lc_reco_cd.ValueOfIndex("detail", lc_reco_cd.Index)
                  + ",v_bid_style=" + lc_bid_style.ValueOfIndex("detail", lc_bid_style.Index)
                  + ",v_bid_status=" + bid_status;

        //alert(param);
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PC%>Pc040S",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
           
        tr_post(tr1);
    }    

    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:���庰 ������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("������Ȳ", "������Ȳ.xls", 8);        
    }
    

	<%//���� ��%>
    function fnSelSitePopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    

	<%//ǰ�� ��%>
    function fnSelKindPopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtKindPop2(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_bid_kind_cd.value = arrParam[0];
            v_bid_kind_nm.value = arrParam[1];
        } else {
		    fnSelKindCleanup();
        }               
    }

	<%//���»� ��%>
    function fnSelCoopPopup(dirPath) {
        v_cust_row = 0;
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtCoopPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_coop_nm.value = arrParam[1];	//NM
            v_coop_sid.value = arrParam[2];	//SID
        } else {
			fnSelCoopCleanup();
        }               
    }
    function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    function fnSelKindCleanup(){
        v_bid_kind_cd.value = "";
        v_bid_kind_nm.value  = "";
    }
    function fnSelCoopCleanup(){
        v_coop_nm.value = "";
        v_coop_sid.value  = "";
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
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_default event="OnLoadCompleted(row)">
        window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_reco_dept classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��õ�μ� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bid_style classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
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
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td align="center" class="text" width="70">�����</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="�� �����">
                                    </td>
                                    <td align="center" class="text" width="70">ǰ��</td>
                                    <td bgcolor="#FFFFFF" WIDTH="220">&nbsp;<input type="text" name='v_bid_kind_nm' id='v_bid_kind_nm' style="width:130px;" class='input01' onkeydown="if(event.keyCode==113) fnSelKindPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindCleanup();" alt="�� �����">
                                        <input type="hidden" name='v_bid_kind_cd' id='v_bid_kind_cd' style="width:40px;" class='input01' readOnly>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">����</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_bid_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=v_to_bid_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
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
                                    <td width="70" align="center" class="text">��ü��</td>
                                    <td colspan="3" bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_coop_nm' id='v_coop_nm' style="width:160px;" class='input01' onkeydown="if(event.keyCode==113) fnSelCoopPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCoopPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCoopCleanup();" alt="�� �����">
                                        <input type="hidden" name='v_coop_sid' id='v_coop_sid'  style="width:40px;" class='input01' readOnly>
                                    </td>

                                </tr>
	                    		<tr>

		                			<td align=left class="text">����(%)</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;<%=HDConstant.COMMENT_START%>
		                                    <object id="v_pct_fr" classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='40px' align='absmiddle' class='textbox'>            
												<param name=Format      value="000">
	                                            <param name=Alignment   value=1>
	                                            <param name=ClipMode    value=true>
	                                            <param name=Border      value=false>
	                                            <param name=Enable      value=true>
	                                            <param name=SelectAll   value=true>
	                                            <param name=SelectAllOnClick      value=true>
	                                            <param name=SelectAllOnClickAny   value=false>
	                                        </object>
	                                        <%=HDConstant.COMMENT_END%>&nbsp;~&nbsp;<%=HDConstant.COMMENT_START%>
	                                        <object id="v_pct_to" classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='40px' align='absmiddle' class='textbox'>            
												<param name=Format      value="000">
	                                            <param name=Alignment   value=1>
	                                            <param name=ClipMode    value=true>
	                                            <param name=Border      value=false>
	                                            <param name=Enable      value=true>
	                                            <param name=SelectAll   value=true>
	                                            <param name=SelectAllOnClick      value=true>
	                                            <param name=SelectAllOnClickAny   value=false>
	                                        </object>
	                                        <%=HDConstant.COMMENT_END%>
	                                        &nbsp;<b>(%)</b>
					              	</td>
			                        <td align=left class="text">��õ�μ�</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_reco_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_reco_dept>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^100">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>
                    				<td align=left class="text">��������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_bid_style classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_bid_style>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                            ��<input type="checkbox" name="v_bid_status" id="v_bid_status">��������
			                        </td>   			                        
			             		</tr>
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0' id="tb_cust_id">
                    <tr>
                        <td valign='top'>
                            <table  border='0' cellpadding='0' cellspacing='0' width='845px' height='350px' >
                                <tr>
                                    <td valign=top>
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                            <param name="DataID"            value="ds_default">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
                                            <param name="SuppressOption"    value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="ViewSummary"       value="1">
                                            <param name="Format"            value="
                                                 <C> name='��������' 		ID='BID_DAY'    	width=60 	align=CENTER	Edit=None suppress=1</C>
                                                 <C> name='����'		ID='CT_GUBN' 		width=40 	align=CENTER	Edit=None suppress=2 sumtext='��'  sumtextalign='right'</C>
                                                 <C> name='�����'      ID='SITE_NM'       	width=120 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                                 <C> name='ǰ��'  		ID='CT_KIND'      	width=60 	align=left 		Edit=None suppress=4 sumtext='��' sumtextalign='left'</C>
                                                 <C> name='��ü��'		ID='COOP_NM'		width=80	align=left 		Edit=None </C>
                                                 <C> name='����'    	    ID='ACT_AMT'   		width=80 	align=right 	Edit=None suppress=5 decao=0</C>
                                                 <C> name='����'    	    ID='ACT_AMT_HA'   	width=60 	align=right 	Edit=None suppress=6 decao=0</C>
                                                 <C> name='�����ݾ�'	ID='BID_AMT'    	width=80 	align=right 	Edit=None decao=0</C>
                                                 <C> name='����(%)'		ID='BID_AMT_PCT2'	width=50 	align=right 	Edit=None dec=1</C>
                                                 <C> name='����(%)'		ID='BID_AMT_PCT1'	width=50 	align=right 	Edit=None dec=1</C>
                                                 <C> name='����'		ID='SEQ'	 	    width=40 	align=center	Edit=None</C>
                                                 <C> name='��ü��'		ID='COOP_CNT' 	    width=40 	align=center	Edit=None</C>
                                                 <C> name='���'   		ID='RESULT_CP'		width=60 	align=CENTER	Edit=None</C>
                                                 <C> name='��õ�μ�'	ID='RECO_DEPT'      width=70 	align=left 		Edit=None</C>
                                                 <C> name='���'   		ID='REMARK'         width=160 	align=LEFT		Edit=None</C>
                                         ">                             
                                        </object>   
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                �� <b>��</b>
            </td>
        </tr>
    </table>

	
	
	
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		