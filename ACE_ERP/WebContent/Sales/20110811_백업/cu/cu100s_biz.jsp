<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: ������
 * ���α׷�ID 	: CU100S
 * J  S  P		: CU100S
 * �� �� ��		: CU100S
 * �� �� ��		: �迵��
 * �� �� ��		: 2006-06-14
 * �������		: �������� ����Ʈ ��ȸ
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
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ 
// Parameter 	: 
%>
	function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu100S",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	: 
%>
	function fnSelect() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sClientCd="  + getObjectFirst("sClientSid").value + ","
            + "sDriveNo=" + getObjectFirst("v_drive_no").value + ","
            + "sCustNm=" + getObjectFirst("v_cust_nm").value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu100S",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description : ���� (������)
%>
	function fnExcel() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:����������ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("����������ȸ", "����������ȸ.xls", 8);
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���¾�ü�˾�
%>
    function fnClientFind() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnClientPop("<%=dirPath%>", "2");    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_client_nm.value = arrParam[1];
            v_client_cd.value = arrParam[2];
            sClientSid.value = arrParam[0];
        } else {
          v_client_nm.value = "";
          v_client_cd.value = "";
          sClientSid.value = "";
        }
    }
</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
    <script language="javascript" for="tr1" event="OnSuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";

        var info_cnt = tr1.SrvErrCount("INFO");
        var info_msg = "";
        for(var i=0; i<info_cnt; i++){
            info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
        }
        if(info_msg!="") 
            alert("============= �ȳ� �޽���=============\n\n" + info_msg);
    </script>
    
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
    <script language="javascript" for="tr1" event="OnFail()">
        window.status="�۾��� ���������� �Ϸ���� ���߽��ϴ�.";
        document.all.LowerFrame.style.visibility="hidden";
        
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
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ü ���α׷� ��� 
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
                    <td>
                        <table width=520 border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
                            <tr>
                                <td width="100px" height="30px" class="text">���������ȣ</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;
                                    <input type=text name=v_drive_no size="20" maxlength="20" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                </td>
                            
                                <td width="100px" height="30px" class="text">������</td>
                                <td align="left" bgcolor="#ffffff">&nbsp;
                                    <input type=text name=v_cust_nm size="15" maxlength="10" class="textbox" OnKeyUp="cfLengthCheck(this, 18);">
                                </td>
                            </tr>
                            <tr>
                                <td width="100px" height="30px" class="text">���¾�ü�ڵ�</td>
                                <td align="left" bgcolor="#ffffff" colspan="3">&nbsp;
                                    <input type="text" name="v_client_cd" size="6" maxlength="4" class="input01" readonly OnKeyUp="cfLengthCheck(this, 4);">
                                    <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:hand" alt="���¾�ü�ڵ带 ��ȸ�մϴ�." align='absmiddle' onClick="fnClientFind()">
                                    <input type="text" name="v_client_nm" size="15" maxlength="10" class="input01" readonly>
                                    <input type="hidden" name="sClientSid" value="">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="bottom">
                        <table width="325" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <table width="120" border="0" cellspacing="0" cellpadding="0" align="right">
                                         <tr>
                                            <td width="55" height="20" align="right"><img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor:hand" onClick="fnSelect()"></td>
                                             <td width="55" align="right"><img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor:hand" onClick="fnExcel()"></td>
                                         </tr>
                                     </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="10"></td>
                </tr>             
                <tr>
                    <td colspan="2">
                    <%=HDConstant.COMMENT_START%>
                    <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845; height:430px" border="1">
                        <param name="DataID"            value="ds1">
                        <param name="BorderStyle"       value="0">
                        <param name="ColSizing"         value="true">
                        <param name="editable"          value="true">
                        <param name="SuppressOption"    value="1">
                        <param name="Format"            value=" 
                            <FC>name='���¾�ü�ڵ�'   ID='CLIENT_CD'          Width=80   Edit=none align=Left suppress=1</FC>
                            <FC>name='���¾�ü��'     ID='CLIENT_NM'          Width=120  Edit=none align=Left suppress=2</FC>
                            <C> name='�����ڸ�'       ID='CUST_NM'            Width=80   Edit=none align=Left suppress=3</C>
                            <C> name='�ֹ�/���ǹ�ȣ'  ID='MANAGE_NO'          Width=120  Edit=none align=Left</C>
                            <C> name='���������ȣ'   ID='DRIVE_NO'           Width=120  Edit=none align=Left</C>
                            <C> name='��������'       ID='LICENSE_DATE'       Width=80   Edit=none align=Left</C>
                            <C> name='���űⰣ'       ID='RENEWAL_DATE'       Width=80   Edit=none align=Left</C>
                            <C> name='���������ڵ�'   ID='LICENSE_TYPE_NAME'  Width=80   Edit=none align=Left</C>
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

