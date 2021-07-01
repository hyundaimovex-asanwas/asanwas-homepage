<!--
    ************************************************************************************
    * @Source         : pira028.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>��������</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_EDUCATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_EDUCATION.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if(fnc_SaveItemCheck()) {

                trT_CM_EDUCATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=SAV";
                trT_CM_EDUCATION.post();

            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CM_EDUCATION.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_EDUCATION.RowStatus(dsT_CM_EDUCATION.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_EDUCATION.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�����ڵ��["+ dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition,"EDU_NM") + "], ����[" + dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition,"SEQ_NO") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_EDUCATION.DeleteRow(dsT_CM_EDUCATION.RowPosition);

            if (status != 1) {
                trT_CM_EDUCATION.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira028.cmd.PIRA028CMD&S_MODE=DEL";
                trT_CM_EDUCATION.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_CM_EDUCATION.SetColumn(form1.grdT_CM_EDUCATION.GetColumnID(0));
            form1.grdT_CM_EDUCATION.Focus();

            bnd.ActiveBind = true;

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_CM_EDUCATION.CountColumn == 0) {
                dsT_CM_EDUCATION.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, STR_YMD:STRING, END_YMD:STRING, PLACE_CD:STRING, PLACE_NM:STRING, INT_NAM:STRING, EDU_CD:STRING:KEYVALUETYPE, EDU_NM:STRING, SEQ_NO:STRING:KEYVALUETYPE, EDU_GBN_CD:STRING, EDU_TAG:STRING, APP_VAL:STRING, DPT_CD:STRING, JOB_CD:STRING, EDU_AMT:INT, TRA_AMT:INT, BOLO_AMT:INT, REMARK:STRING, EDU_NM:STRING, CPT_PNT:INT");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_CM_EDUCATION.AddRow();


            document.getElementById("cmbEDU_TAG").disabled  = false;
            document.getElementById("txtEDU_CD").enabled      = true;
            document.getElementById("cmbEDU_TAG").enabled     = true;
            document.getElementById("txtREMARK").disabled      = false;
            document.getElementById("txtREMARK").enabled      = true;

            form1.grdT_CM_EDUCATION.setColumn(form1.grdT_CM_EDUCATION.getColumnID(0));

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;
            document.getElementById("txtOCC_CD").value = parent.document.getElementById("txtOCC_CD").value;
            document.getElementById("txtEDU_CD").focus();


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_EDUCATION.ClearData();
			document.getElementById("ENO_NO").value = ENO_NO;
			document.getElementById("resultMessage").innerText = ' ';

        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            var f = document.form1;

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_EDUCATION.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }

            for ( i = 1; i <= dsT_CM_EDUCATION.CountRow; i++ ) {
            	
                if ( dsT_CM_EDUCATION.RowStatus(i) == 1 || dsT_CM_EDUCATION.RowStatus(i) == 3 ) {

                    // �������
                    if( dsT_CM_EDUCATION.NameValue(i, "PLACE_CD") == '' ) {
                    	
                        alert("��������ڵ�� �ʼ� �Է»����Դϴ�.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;
                        
                        document.getElementById("txtPLACE_CD").focus();
                        
                        return false;
                        
                    }

                    // �������
                    if (dsT_CM_EDUCATION.NameValue(i, "PLACE_CD") != "" && dsT_CM_EDUCATION.NameValue(i, "PLACE_NM") == "") {
                    	
                        alert("��������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;
                        
                        document.getElementById("txtPLACE_CD").focus();
                        
                        return;
                    }

                    // �����ڵ�
                    if( dsT_CM_EDUCATION.NameValue(i, "EDU_CD") == '' ) {
                    	
                        alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                        
                        dsT_CM_EDUCATION.RowPosition = i;

                        return false;
                    }


                    if ( dsT_CM_EDUCATION.RowStatus(i) == 1) {

                       document.getElementById("ImgEduCd").disabled   = false;

                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            //Grid Style ����
            cfStyleGrid_New(form1.grdT_CM_EDUCATION, 0,"false","false");

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                document.getElementById("cmbEDU_TAG").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;
                document.getElementById("ImgEduCd").disabled       = false;
            }
            else if (prop == 'D') {
                document.getElementById("cmbEDU_TAG").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;
                document.getElementById("ImgEduCd").disabled       = true;
            }
        }


        //�����ڵ� �˾�
        function fnc_eduPopup(){

            //�����ڵ�(T_CM_COMMON, Q1) ��ȸ�� �˾�
            obj = fnc_eduCode_Popup();

            if(obj.edu_cd == "") {
                return;
            }

            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_CD")  = obj.edu_cd;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_NM")  = obj.edu_nm;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "SEQ_NO")  = obj.seq_no;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_NM") = obj.edu_nm;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "STR_YMD") = obj.edu_str_ymd;
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "END_YMD") = obj.edu_end_ymd;

            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "DECISION_CD") = "D";
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_TAG") = "Y";


            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "EDU_GBN_CD")  = obj.edu_gbn_cd;


            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "INT_NAM")  = obj.int_nam;//����ó
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "PLACE_CD") = obj.place_cd;//��������ڵ�
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "PLACE_NM") = obj.place_nm;//������Ҹ�
            dsT_CM_EDUCATION.NameValue(dsT_CM_EDUCATION.RowPosition, "CPT_PNT") =  obj.cpt_pnt;//�̼�����

        }


		// �����ڵ�(T_CM_COMMON, Q1) ��ȸ�� �˾�
		function fnc_eduCode_Popup() {
			var obj = new String();
			window.showModalDialog("/common/popup/educourse.jsp", obj, "dialogWidth:500px; dialogHeight:525px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      		return obj;//return edu_cd, seq_no, Str_ymd, end_ymd, int_nam, place_cd, place_nm, cpt_pnt
		}

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_EDUCATION)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
        	
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');
            
        } else {
        	
            fnc_ColEnabled('E');
            
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow);

            document.getElementById("ImgEduCd").disabled   = true;
            
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {

            document.getElementById("ImgEduCd").disabled   = false;
            
            alert("�ش� �ʼ��Է��׸�[�����Ⱓ/�����ڵ�/����] �Է� �� ���� �۾��� �����մϴ�.");
            
        }
        else if (this.ErrorCode == 50020) {

            document.getElementById("ImgEduCd").disabled   = false;
            
            alert("�����Ⱓ/�����ڵ�/������ ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
            
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_EDUCATION event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_EDUCATION event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script language=JavaScript for=dsT_CM_EDUCATION Event="OnRowPosChanged(row)">

        var SysStatus = dsT_CM_EDUCATION.SysStatus(row);

        if (SysStatus == 1) {

            document.getElementById("ImgEduCd").disabled   = false;

        }
        else {

            document.getElementById("ImgEduCd").disabled   = true;

        }

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdd','','../../images/button/btn_AddnewOver.gif',1)">   <img src="../../images/button/btn_AddnewOn.gif" name="imgAdd"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','../../images/button/btn_CancelOver.gif',1)"> <img src="../../images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="70 "></col>
                    <col width="160"></col>
                    <col width="70 "></col>
                    <col width="110 "></col>
                    <col width="70 "></col>
                    <col width="105 "></col>
                    <col width="70 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">�����ڵ��</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" size="10" maxlength="10" >
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_eduPopup()"></a>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtPLACE_CD" size="2" maxlength="2" onChange="fnc_GetCommNm('Q9', 'txtPLACE_CD','txtPLACE_NM');"> <input id="txtPLACE_NM" style="width:74%">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtSEQ_NO" style="width:100%;">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����Ⱓ</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        ~
                        <input id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '��������');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                    </td>
                    <td align="center" class="blueBold">�ʼ�����</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100%" >
                            <option value="AA" >�ʼ�</option>
                            <option value="AB" >����</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">���Ῡ��</td>
                    <td class="padding2423">
                        <select id="cmbEDU_TAG" style="width:100%" >
                            <option value="Y" >����</option>
                            <option value="N" >�̼���</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">����������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_NM" style="width:100%;">
                    </td>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423">
                        <input id="txtINT_NAM" maxlength="22" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREMARK" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">�̼�����</td>
                    <td class="padding2423">
                        <input id="txtCPT_PNT" maxlength="5" style="width:100%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="blueBold"></td>
                    <td class="padding2423">
                    </td>
                    <input type=hidden   id="txtENO_NO" size="10">
                    <input type=hidden   id="txtOCC_CD" size="1">
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="994" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:994px;height:300px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="Format"                  value="
                                <C> id={currow}        width=29     name='����'            align=center </C>
                                <C> id=STR_YMD         width=80     name='������'          align=center </C>
                                <C> id=END_YMD         width=80     name='������'          align=center </C>
                                <C> id=EDU_CD          width=100     name='�����ڵ�'        align=center </C>
                                <C> id=PLACE_NM        width=60     name='�������'        align=center </C>
                                <C> id=SEQ_NO          width=50     name='����'            align=center </C>
                                <C> id=EDU_GBN_CD      width=70     name='�ʼ�����'        align=center value={DECODE(EDU_GBN_CD,'AA','�ʼ�','AB','����')} </C>
                                <C> id=EDU_NM          width=150    name='����������'                   </C>
                                <C> id=INT_NAM         width=120    name='����ó'                       </C>
                                <C> id=EDU_TNM         width=60     name='���Ῡ��'        align=center value={DECODE(EDU_TAG,'N','�̼���','Y','����')} </C>
                                <C> id=CPT_PNT         width=60     name='�̼�����'        align=center  </C>
                                <C> id=REMARK          width=100    name='�����о�'                      </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_EDUCATION">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=txtENO_NO       Param=value Disable=disabled</C>
        <C> Col=OCC_CD        Ctrl=txtOCC_CD       Param=value </C>
        <C> Col=STR_YMD       Ctrl=txtSTR_YMD      Param=value </C>
        <C> Col=END_YMD       Ctrl=txtEND_YMD      Param=value </C>
        <C> Col=PLACE_CD      Ctrl=txtPLACE_CD     Param=value </C>
        <C> Col=PLACE_NM      Ctrl=txtPLACE_NM     Param=value </C>
        <C> Col=SEQ_NO        Ctrl=txtSEQ_NO       Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C> Col=EDU_CD        Ctrl=txtEDU_CD       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM       Param=value </C>
        <C> Col=INT_NAM       Ctrl=txtINT_NAM      Param=value </C>
        <C> Col=EDU_TAG       Ctrl=cmbEDU_TAG      Param=value </C>
        <C> Col=APP_VAL       Ctrl=txtAPP_VAL      Param=value </C>
        <C> Col=DPT_CD        Ctrl=txtDPT_CD       Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_CD        Ctrl=txtJOB_CD       Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=DECISION_CD   Ctrl=txtDECISION_CD  Param=value </C>
        <C> Col=DECISION_NM   Ctrl=txtDECISION_NM  Param=value </C>
        <C> Col=CPT_PNT       Ctrl=txtCPT_PNT      Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK       Param=value </C>
    '>
</object>