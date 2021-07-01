<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ����������Ȳ
 * ���α׷�ID   : RV201S
 * J  S  P      : rv201S
 * �� �� ��        : Rv201S
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-14
 * �������     :  ������ȸ(��)
 *             ������ ������ �������� �湮Ƚ�� ��ȸ �� ������Ʈ. ��� ����.
 * ��������     :  2007-03-30 
 * �� �� ��        : �ɵ���
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
            fnInit(); 
        } 
        
        /*
         * �ʱ��۾�
         * Header ���� 
         * ����
         */
        function fnInit() {
			v_job = "H";

	        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_saup.Reset(); //�����ڵ�
        }
        
    
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            var manage_no = getObjectFirst("v_manage_no").value.trim();//v_manage_no.value
            if(manage_no.length=0) {
                alert("�ֹ�/���ǹ�ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                return;
            }
        
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                      + ",v_manage_no=" + v_manage_no.value;
                      
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv201S",
                "JSP(O:DS_CUST=ds_cust)",
                param);
               
            tr_post(tr1);
        }
         
        function fnExcelDs1() {
            if(ds_cust.CountRow==0 && ds_tour.CountRow==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            var manage_no = getObjectFirst("v_manage_no").value.trim();//v_manage_no.value

            getObjectFirst("gr_cust").SetExcelTitle(0, "");
            getObjectFirst("gr_cust").SetExcelTitle(1, "value:������ȸ (��) - " + manage_no + "; font-face:; font-size:24pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr_cust").GridToExcel("������ȸ (��)", "������ȸ (��).xls", 8);        
        }
        </script>
        

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
    <script language=JavaScript  for=ds_cust event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_cust event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
        if(row==0){
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
        }
    </script>
    
    <script language="javascript" for="tr1" event="onsuccess()">
        msgTxt.innerHTML="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
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

<%
/*******************************************************************************
            ���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<!-- ���� ���� ���ʵ����� ���� -->
<object id=init_businessDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
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

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
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
                            <img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointer" align=absmiddle onclick="fnExcelDs1()">
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
                            <table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                                <tr>
                    				<td class="text" width="100">����</td>
                                    <td align="left" bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_saup>
                                            <param name=ListExprFormat  value="saup_nm^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
                                    <td align=left class="text">�ֹ�/���ǹ�ȣ</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;<input type="text" name="v_manage_no" size="20" maxlength="20" class="textbox" OnKeyUp="if(event.keyCode==13) fnSelect();"></td>
			                       </tr>
                            </table>
                    	</td>
                    </tr>
	                <tr>
	                  <td style="padding-top:8px;padding-bottom:8px">
	                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                      <tr>
	                      	<td style="padding:6px" width=44><img src=../images/attention_Mark.jpg border=0></td>
	                      	<td width=100%>��1. ���� ��� ��, ���°� <font color=blue>���(DP), �԰�(AR)</font>�� ��츸 ��ȸ�˴ϴ�.<br>
	                      	��2. ��ȸ�� ���ÿ� <A HREF="../cu/cu010i.jsp?scode=SAL&id=m1&menu=1">[�����]</A> �޴��� �����湮Ƚ�� �׸��� ������Ʈ �˴ϴ�.<br>
	                      	</td>
	                      </tr>
	                    </table>
	                  </td>
	                </tr>                    
                </table>
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
                                        <%=HDConstant.COMMENT_START%>
                                        <object id=gr_cust classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='350px' border='1'>
                                            <param name="DataID"            value="ds_cust">
                                            <param name="ColSizing"         value="true">
                                            <param name="Editable"          value="true">
				                            <param name="SuppressOption"    value="1">
				                            <param name="ViewSummary"       value="1">
                                            <param name="BorderStyle"       value="0">
                                            <param name="Format"            value="

  										 	   <C> name='No.'         ID='{STRING(CURROW)}' Width=40  align=RIGHT </C>
                                               <C> name='��û����ȣ'    ID='ACCEPT_NO'        width=100 align=CENTER Edit=None SumText=��</C>
                                               <C> name='�������'      ID='DEPART_DATE'      width=80 align=CENTER Edit=None SumText=@cnt</C>
                                               <C> name='��ǰ'         ID='GOODS_NM'        width=100 align=CENTER Edit=None SumText=ȸ</C>
                                               <C> name='�����ϼ�'      ID='NIGHTS'          width=60 align=CENTER Edit=None</C>
                                               <C> name='��������'     ID='DEPART_DATE'      width=80 align=CENTER  Edit=None </C>
                                               <C> name='������'     ID='CUST_GU'          width=80 align=CENTER  Edit=None </C>
                                               <C> name='��� �ڵ���'   	ID='MOBILE_NO'        width=100 align=CENTER  Edit=None</C>
                                               <C> name='����'         ID='STATUS_NM'        width=60 align=CENTER  Edit=None</C>
                                               <C> name='�Է���'       ID='I_EMPNO'      width=100 align=CENTER  Edit=None</C>
                                                            
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

