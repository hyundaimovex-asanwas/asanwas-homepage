<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : �븮����������
 * ���α׷�ID   : MY320I
 * J  S  P      : my320i
 * �� �� ��        : My320I
 * �� �� ��        : �迵��
 * �� �� ��        : 2006-07-15
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
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">
        
        var jobFlag = "";
        /*
         * �������ε�
         */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

            //cfStyleGrid(getObjectFirst("gr1"), "comn");
            cfStyleGrid(getObjectFirst("gr2"), "comn");
            cfStyleGrid(getObjectFirst("gr3"), "comn");
            
            fnInit(); 
            
            // 
            codeDs1.deleteRow(1);
            codeDs2.deleteRow(1);
            codeDs3.deleteRow(1);
            codeDs4.deleteRow(1);
            codeDs5.deleteRow(1);
            
            agen_gu.index = 0;
            dir_yn.index = 0;
            area_cd.index = 0;
            cunt_status.index = 0;
            use_yn.index = 0;
        } 
            
        /*
         * �ʱ��۾�
         * Header ���� 
         */
        function fnInit(){
            jobFlag = "INIT";
            
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                "JSP(O:AGENGU=codeDs1,O:DIRYN=codeDs2,O:AREACD=codeDs3,O:CUNTSTATUS=codeDs4,O:USEYN=codeDs5,O:INSURCOMPCD=codeDs6,O:CLIENTDOWNYN=codeDs7,O:S_USEYN=sCodeDs1)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
            
            fnSelect();
        }
            
        /*
         * ���� ��ȸ
         */
        function fnSelect() {
            if (ds1.IsUpdated==false || !ds2.IsUpdated==false || !ds3.IsUpdated==false) {
                var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                          + ",sClient_nm=71000";
                
                ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                    "JSP(O:DS1=ds1)",
                    param);
                tr_post(tr1);
            } else {
                alert("�۾����� ���¿����� ��ȸ�Ҽ� �����ϴ�!");
            }
        }
            
        /*
         * ����
         */     
        function fnApply() {
            if (ds1.IsUpdated) {
                if(fnCheck()){
                  ln_TRSetting(tr1, 
                    "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                    "JSP(I:DS1=ds1)",
                    "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                    tr_post(tr1);
                }
            } else {
                alert("����� ������ �����ϴ�.");
                return;
            }
        }
      
        /*
         * �������, ������ȸ
         */ 
        function fnSelectDs1() {
            jobFlag = "DETAIL";
            var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",sClient_sid=" + ds1.namevalue(ds1.rowposition,"client_sid");
                     
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu040I",
                "JSP(O:DS3=ds3,O:DS2=ds2)",
                param);
            tr_post(tr1);
        }
            
        /*
         * �Է� üũ
         */
        function fnCheck() {
            if (ds1.IsUpdated) {
                if (jobFlag != "D") {
                    if(ds1.NameValue(ds1.rowposition, "client_dam_nm")=="") {
                        alert("�븮������ڸ� �Է��ϼ���!");
                        getObjectFirst("client_dam_nm").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "tel_no")=="") {
                        alert("��ȭ��ȣ�� �Է��ϼ���!");
                        getObjectFirst("tel_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "mobile_no")=="") {
                        alert("�޴���ȭ�� �Է��ϼ���!");
                        getObjectFirst("mobile_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "fax_no")=="") {
                        alert("�ѽ��� �Է��ϼ���!");
                        getObjectFirst("fax_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "e_mail")=="") {
                        alert("�̸����� �Է��ϼ���!");
                        getObjectFirst("e_mail").focus();
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "zip_cd")=="") {
                        alert("�����ȣ�� �����ϼ���!");
                        return false;
                    }
                    if(ds1.NameValue(ds1.rowposition, "address2")=="") {
                        alert("���ּҸ� �Է��ϼ���!");
                        getObjectFirst("address2").focus();
                        return false;
                    }
                }
            }
            return true;
        } 

        /*
         * ��� 
         */
        function fnCancel() {
            ds1.undoall();
            window. status="������ ������ ��ҵǾ����ϴ�.";
            return;     
        }

        /*
         * ����
         */
        function fnExcelDs1() {
            gr1.runexcelsheet("���������");
        }
            
        /*
         * �����ȣ �˾� 
         */ 
        function fnZipCodePopup() {
           var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
                
            strURL = "<%=dirPath%>/Sales/help/sy002h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);    
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                zip_cd.Text= arrParam[0];
                address1.value = arrParam[1];
                
            } else {
              zip_cd.Text = "";
              address1.value = "";
            }                       
        }           
        
        /*
         * ���������
         */
         
         function fnSalDamPopup(flag) {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            
            strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            
            
            arrResult = showModalDialog(strURL,arrParam,strPos);    
            
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                
                
                if (flag == "S") {
                    sSal_dam_sid.value = arrParam[0];
                    sSal_dam_nm.value = arrParam[2];
                } else if (flag == "I") {
                    sal_dam_sid.value = arrParam[0];
                    sal_dam_nm.value = arrParam[2];
                }
            } else {
                if (flag == "S") {
                    sSal_dam_sid.value = "";
                    sSal_dam_nm.value = "";
                } else if (flag == "I") {
                    sal_dam_sid.value = "";
                    sal_dam_nm.value = "";
                }
            }
         }

        /*
         * �븮�� �˾�
         */
        function fnClientPopup() {
            
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL; 
            var strPos;
            var dir = '<%=dirPath%>';
            
            arrResult = fnClientPop(dir,'1');
        
            if (arrResult != null) {
                arrParam = arrResult.split(";");
                client_cd.value = arrParam[2];
                client_nm.value = arrParam[1];
            } else {
              client_nm.value = "";
              client_cd.value = "";
            }               
        }        
        </script>
        

<%
/****************************************************************************
            ���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
    <script language="javascript" for="tr1" event="onsuccess()">
        window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
        
        if(ds1.CountRow>0 && jobFlag!="DETAIL"){
            fnSelectDs1()
        }
    </script>   
    
    <script language=JavaScript for=mxTab event=OnSelChanged(index)>
        if (index == 1) {
            tabFlag.value = "1";
        } else if (index == 2) {
            tabFlag.value = "2";
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
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮�� ��ȸ -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="true">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮������ -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���Ǳ��� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs5 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs6 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��������ȸ�� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=codeDs7 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����븮�� ���� -->
    <param name="SyncLoad"  value="false">
</object>
<object id=sCodeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
    <param name="SyncLoad"  value="false">
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
    
    <table border='0' cellpadding='0' cellspacing='0' width='845'>  
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand" align=absmiddle onClick="fnApply();">
                            <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand" align=absmiddle onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr> 
        <tr>
            <td height='10px'></td>
        </tr>
        <tr>
            <td colspan='3' valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top'>
                            <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                                <tr>
                                    <td width='100%'height='244px'>
                                        <table border='0' cellpadding='0' cellspacing='1' width='100%' height='244px' bgcolor="#666666">
                                            <tr>
                                                <td class='text'>�븮���ڵ�</td>
                                                <td bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=client_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="00000">
                                                        <param name=Enable      value="false">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                                <td  class='text'>�븮����</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;<input type='text' id='client_nm'       name='client_nm'        value='' maxlength='30' size='20'   class='input01' readOnly> <!-- �븮�� �� -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>�ŷ�ó��</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='vend_cd'           name='vend_cd'          value='' maxlength='13' size='10'   class='textbox'> <!-- �ŷ�ó�ڵ� -->
                                                    &nbsp;&nbsp;<input type='text' id='vend_nm'             name='vend_nm'          value='' maxlength='62' size='15'   class='input01' readOnly> <!-- �ŷ�ó�� -->
                                                </td>
                                                <td  class='text'>���������</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    <input type='hidden' id='sal_dam_sid'       name='sal_dam_sid'      value='' maxlength='12' size='12'   class='textbox' readonly> <!-- ����������ڵ� -->
                                                    &nbsp;&nbsp;<input type='text' id='sal_dam_nm'      name='sal_dam_nm'       value='' maxlength='22' size='10'   class='input01' readOnly> <!-- ��������ڸ� -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>�븮�� ����</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=agen_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs1>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                     
                                                </td>
                                                <td  class='text'>���ǿ���</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=dir_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs2>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class='boardt02'>�븮�������</td>
                                                <td colspan='3' width='300px' bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='client_dam_nm'   name='client_dam_nm'    value='' maxlength='20' size='20'   class='textbox'> <!-- �븮������� -->
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>��ȭ��ȣ</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='tel_no'          name='tel_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- ��ȭ��ȣ -->
                                                    
                                                </td>
                                                <td  class='boardt02'>�޴���ȭ</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='mobile_no'       name='mobile_no'        value='' maxlength='15' size='20'   class='textbox'> <!-- �޴���ȭ -->
                                                </td>
                                            </tr>

                                            <tr>
                                                <td  class='boardt02'>�ѽ���ȣ</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='fax_no'          name='fax_no'           value='' maxlength='20' size='20'   class='textbox'> <!-- FAX��ȣ -->
                                                </td>
                                                <td  class='boardt02'>�����ּ�</td>
                                                <td  bgcolor='#FFFFFF'>
                                                     &nbsp;&nbsp;<input type='text' id='e_mail'             name='e_mail'           value='' maxlength='30' size='23'   class='textbox'> <!-- �̸��� -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>�����ȣ</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' onkeydown="if (event.keyCode == 13) fnZipCodePopup();" align='absmiddle' class='textbox'>            
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="###-###">
                                                        <param name=Cursor      value="Hand">
                                                        <param name=Enable      value="False">
                                                        <param name=ReadOnly    value="True">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>&nbsp;&nbsp;
                                                    <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ȣ�� �˻��մϴ�"  style="cursor:hand" id="zipcode_btn" onclick="fnZipCodePopup();" align='absmiddle'>                                                 
                                                </td>
                                                <td  class='boardt02'>�����ڵ�</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=area_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs3>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>�ּ�1</td>
                                                <td  bgcolor='#FFFFFF' colspan='3'>
                                                    &nbsp;&nbsp;<input type='text' id='address1'        name='address1'         value='' maxlength='60' size='50'   class='textbox'> <!-- �ּ�1 -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='boardt02'>�ּ�2</td>
                                                <td  bgcolor='#FFFFFF'colspan='3'>
                                                    &nbsp;&nbsp;<input type='text' id='address2'        name='address2'         value='' maxlength='60' size='50'   class='textbox'> <!-- �ּ�2 -->
                                                </td>
                                            </tr>

                                            <tr>
                                                <td  class='text'>��������</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=commi_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>           
                                                        <param name=Alignment   value=1>
                                                        <param name=Format      value="00.00">
                                                        <param name=Enable      value="false">
                                                        <param name=Border      value=false>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>

                                                </td>
                                                <td  class='text'>������</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=cunt_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs4>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">   
                                                        <param name=Enable          value="false">                                                 </object>
                                                    <%=HDConstant.COMMENT_END%>                                                     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>����</td>
                                                <td  bgcolor='#FFFFFF'>
                                                     <input type='hidden' id='bancod'           name='bancod'           value='' maxlength='6'  size='6'    class='input01' readOnly> <!-- �����ڵ� -->
                                                     &nbsp;&nbsp;<input type='text' id='bannam'             name='bannam'           value='' maxlength='30' size='20'   class='input01' readOnly> <!-- ����� -->
                                                </td>
                                                <td  height='22px' class='text'>���¹�ȣ</td>
                                                <td  height='22px' bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='bank_acc_no'         name='bank_acc_no'      value='' maxlength='20' size='20'   class='input01' readOnly> <!-- ������¹�ȣ -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  class='text'>������</td>
                                                <td  bgcolor='#FFFFFF'>
                                                    &nbsp;&nbsp;<input type='text' id='bank_acct_nm'    name='bank_acct_nm'     value='' maxlength='32' size='20'   class='input01' readOnly> <!-- ������ -->
                                                </td>
                                                <td  class='text'>�������</td>
                                                <td  bgcolor='#FFFFFF'>&nbsp;
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=use_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                                        <param name=ComboDataID     value=codeDs5>
                                                        <param name=BindColumn      value="detail">
                                                        <param name=BindColVal      value="detail">
                                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                                        <param name=ListExprFormat  value="detail_nm^0^100">
                                                        <param name=Enable          value="false">
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%> 
                                                    
                                                </td>
                                            </tr>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height='10px'></td>
                                </tr>
                                <tr>
                                    <td>
                                        <table  border='0' cellpadding='0' cellspacing='0' width='845px'>
                                            <tr>
                                                <td align='left'>
                                                    <%=HDConstant.COMMENT_START%>
                                                    <object id=mxTab classid=<%=HDConstant.CT_TAB_CLSID%> width='200px' height='20px'> 
                                                        <param name="BackColor"         value="#00FFFF">
                                                        <param name="DisableBackColor"  value="#fffff0">
                                                        <param name="Format"            value='
                                                            <T>divid="tab1" title="�������"</T>
                                                            <T>divid="tab2" title="��������"</T>'>
                                                    </object>
                                                    <%=HDConstant.COMMENT_END%>
                                                </td>
                                            <tr >
                                                <td valign=top>
                                                    <div id=tab1 style="position:absolute; width:845; height:97">     
                                                        <%=HDConstant.COMMENT_START%>                                                                                                        
                                                        <object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=845; height=97" border='1'>                                       
                                                            <param name="DataID"            value="ds2">                                                                                                                            
                                                            <param name="Fillarea"          value="true">                                                                                                                           
                                                            <param name="Editable"          value="false">                                                                                                                           
                                                            <param name="BorderStyle"       value="0">                                                                                                                       
                                                            <param name="Format"            value="                                                                                                                                 
                                                               <C> name='�븮��SID'        ID='client_sid'         align=left editlimit=12 width=100 show=false</C>
                                                               <C> name='�������'          ID='cont_date'          align=left editlimit=8  width=100 show=true</C>
                                                               <C> name='��������'              ID='expire_date'        align=left editlimit=8  width=100 show=true</C>
                                                               <C> name='�����'               ID='insur_amt'          align=left editlimit=10 width=100 show=true</C>
                                                               <C> name='��������ȸ���ڵ�'      ID='insur_comp_cd'      align=left editlimit=2  width=100 show=false </C>
                                                               <C> name='��������ȸ���'   ID='insur_comp_cd_name' align=left editlimit=50 width=205 show=true editstyle=popup</C>
                                                            ">                                                                                                                                                                              
                                                        </object> 
                                                        <%=HDConstant.COMMENT_END%>                                                                                                                                                                               
                                                    </div>   
                                                    <div id=tab2 style="position:absolute; width:845; height:97">   
                                                        <%=HDConstant.COMMENT_START%>                                                                                                                          
                                                        <object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="left:5; top:5; width=845; height=97" border='1'>                                                  
                                                            <param name="DataID"            value="ds3">                                                                                                                            
                                                            <param name="Fillarea"          value="true">                                                                                                                           
                                                            <param name="Editable"          value="false">                                                                                                                           
                                                             <param name="BorderStyle"       value="0">                                                                                                                                  
                                                            <param name="Format"            value="                                                                                                                                            
                                                               <C> name='�����ڵ�'        ID='branch_cd'              width=60 align=left editlimit=3    show=true</C>
                                                               <C> name='������'          ID='branch_nm'              width=100 align=left editlimit=20 show=true</C>
                                                               <C> name='������'          ID='area_nm'                width=60 align=left editlimit=10 show=true editstyle=popup</C>
                                                               <C> name='��������'        ID='client_down_yn_name'    width=80 align=left editlimit=50 show=true editstyle=popup</C>
                                                               <C> name='�����'          ID='empno'                  width=60 align=left editlimit=7    show=true</C>
                                                               <C> name='��ȭ��ȣ'        ID='tel_no'                 width=100 align=left editlimit=15 show=true</C>
                                                               <C> name='�޴���ȭ'        ID='mobile_no'              width=100 align=left editlimit=15 show=true</C>
                                                               <C> name='�ѽ���ȣ'        ID='fax_no'                 width=100 align=left editlimit=20 show=true</C>
                                                               <C> name='����Ȩ������'     ID='branch_url'             width=200 align=left editlimit=40 show=true</C>
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
            </td>
        </tr>
    </table>
    
        <%
        /*=============================================================================
                                Bind ����
        =============================================================================*/
        %>
        <%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
                    <C>Col=vend_cd          Ctrl=vend_cd            Param=value </C>
                    <C>Col=vend_nm          Ctrl=vend_nm            Param=value </C>
                    <C>Col=client_cd        Ctrl=client_cd          Param=Text </C>
                    <C>Col=client_nm        Ctrl=client_nm          Param=value </C>
                    <C>Col=client_gu        Ctrl=client_gu          Param=value </C>
                    <C>Col=agen_gu          Ctrl=agen_gu            Param=BindColVal </C>
                    <C>Col=agen_gu_name     Ctrl=agen_gu_name       Param=value </C>
                    <C>Col=dir_yn           Ctrl=dir_yn             Param=BindColVal </C>
                    <C>Col=dir_yn_name      Ctrl=dir_yn_name        Param=value </C>
                    <C>Col=area_cd          Ctrl=area_cd            Param=BindColVal </C>
                    <C>Col=area_cd_name     Ctrl=area_cd_name       Param=value </C>
                    <C>Col=sal_dam_sid      Ctrl=sal_dam_sid        Param=value </C>
                    <C>Col=sal_dam_nm       Ctrl=sal_dam_nm         Param=value </C>
                    <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
                    <C>Col=tel_no           Ctrl=tel_no             Param=value </C>
                    <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
                    <C>Col=fax_no           Ctrl=fax_no             Param=value </C>
                    <C>Col=e_mail           Ctrl=e_mail             Param=value </C>
                    <C>Col=zip_cd           Ctrl=zip_cd             Param=Text </C>
                    <C>Col=address1         Ctrl=address1           Param=value </C>
                    <C>Col=address2         Ctrl=address2           Param=value </C>
                    <C>Col=commi_rate       Ctrl=commi_rate         Param=Text </C>
                    <C>Col=cunt_status      Ctrl=cunt_status        Param=BindColVal </C>
                    <C>Col=cunt_status_name Ctrl=cunt_status_name   Param=value </C>
                    <C>Col=bancod           Ctrl=bancod             Param=value </C>
                    <C>Col=bannam           Ctrl=bannam             Param=value </C>
                    <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
                    <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
                    <C>Col=use_yn           Ctrl=use_yn             Param=BindColVal </C>
                    <C>Col=use_yn_name      Ctrl=use_yn_name        Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

