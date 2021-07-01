<!--
    ************************************************************************************
    * @Source         : cdpa010.jsp                                                    *
    * @Description    : ����������� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/29 |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�����������(cdpa010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>
    
    
    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >
    
        var btnList = 'TTTTTTFT';
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            
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

                trT_EV_DUTYSAME.KeyValue = "tr01(I:SAV=dsT_EV_DUTYSAME)";
                trT_EV_DUTYSAME.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SAV";
                trT_EV_DUTYSAME.post();
                
            }            
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            var status = 0;
            
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_DUTYSAME.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            
            status = dsT_EV_DUTYSAME.RowStatus(dsT_EV_DUTYSAME.RowPosition);
            
            //DataSet�� ���� ���� Ȯ��
            if (dsT_EV_DUTYSAME.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }
            
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("�����ڵ� [" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"DUTY_CD") + "][" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"DUTY_NM") + "], �������� [" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"SDUTY_CD") + "][" + dsT_EV_DUTYSAME.NameValue(dsT_EV_DUTYSAME.RowPosition,"SDUTY_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_DUTYSAME.DeleteRow(dsT_EV_DUTYSAME.RowPosition);

            if (status != 1) {
                trT_EV_DUTYSAME.KeyValue = "tr01(I:SAV=dsT_EV_DUTYSAME)";
                trT_EV_DUTYSAME.action = "/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=DEL";
                trT_EV_DUTYSAME.post();
            }

            bnd.ActiveBind = false;
            
            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_DUTYSAME.SetColumn(form1.grdT_EV_DUTYSAME.GetColumnID(0));
            form1.grdT_EV_DUTYSAME.Focus();
            
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

            if(document.tvT_CM_DUTYMST.ItemText.trim() == ""){
                alert("Ʈ�� �������� ���� �������ּ���.");
                return false;
            }
            
            //���� ���õ� Ʈ���� ������ �����´�.
            var overNm = document.tvT_CM_DUTYMST.ItemText;
            var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
            var oDUTY_CD = dsT_CM_DUTYMST.NameValue(Row,"DUTY_CD");
            var oDUTY_NM = dsT_CM_DUTYMST.NameValue(Row,"DUTY_NM");

            var oDUTY_LBL= dsT_CM_DUTYMST.NameValue(Row,"DUTY_LBL");

            if (oDUTY_LBL != '4') {
                alert("���������ڵ带 ����ϰ��� �ϴ� �����ڵ带 �����Ͽ� �ֽʽÿ�");
                return;
            }
            
            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_DUTYSAME.CountColumn == 0) {
                dsT_EV_DUTYSAME.setDataHeader("DUTY_CD:STRING:KEYVALUETYPE, DUTY_NM:STRING, SDUTY_CD:STRING:KEYVALUETYPE, SDUTY_NM:STRING, SEM_RATE:INT");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_DUTYSAME.AddRow();
            
            fnc_ColEnabled('E');

            form1.grdT_EV_DUTYSAME.setColumn(form1.grdT_EV_DUTYSAME.getColumnID(0));
            
            document.getElementById("txtDUTY_CD").disabled  = false;
            document.getElementById("ImgDutyCd").disabled   = false;
            document.getElementById("txtSDUTY_CD").disabled = false;
            document.getElementById("ImgSDutyCd").disabled  = false;
            
            document.getElementById("txtDUTY_CD").value  = oDUTY_CD;
            document.getElementById("txtDUTY_NM").value  = oDUTY_NM;            
            document.getElementById("txtDUTY_CD").focus();

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

            document.getElementById("resultMessage").innerText = ' ';
            
            // DataSet Clear
            dsT_EV_DUTYSAME.ClearData();
            
            fnc_ColEnabled('D');

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
            if (!dsT_EV_DUTYSAME.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return false;
            }  
            
            for ( i = 1; i <= dsT_EV_DUTYSAME.CountRow; i++ ) {
                if ( dsT_EV_DUTYSAME.RowStatus(i) == 1 || 
                     dsT_EV_DUTYSAME.RowStatus(i) == 3 ) {
                
                    // �����ڵ�
                    if( dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") == '' ) {
                        alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtDUTY_CD").focus();
                        return false;
                    }   
                    
                    // �����ڵ� CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") != "" &&
                        dsT_EV_DUTYSAME.NameValue(i, "DUTY_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtMENO_NO").focus();
                        return;
                    }   
                    
                    // ���������ڵ�
                    if( dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD") == '' ) {
                        alert("���������ڵ�� �ʼ� �Է»����Դϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return false;
                    }   
                    
                    // ���������ڵ� CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD") != "" &&
                        dsT_EV_DUTYSAME.NameValue(i, "SDUTY_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return;
                    }   
                    
                    // �����ڵ�� ���������ڵ尡 �������� CHECK
                    if (dsT_EV_DUTYSAME.NameValue(i, "DUTY_CD") == dsT_EV_DUTYSAME.NameValue(i, "SDUTY_CD")) {
                        alert("�����ڵ�� ���������ڵ尡 �����մϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSDUTY_CD").focus();
                        return false;
                    } 
                    
                    // ������
                    if( dsT_EV_DUTYSAME.NameValue(i, "SEM_RATE") <= 0 ) {
                        alert("�������� �ʼ� �Է»����Դϴ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSEM_RATE").focus();
                        return false;
                    }
                    
                    if (dsT_EV_DUTYSAME.NameValue(i, "SEM_RATE") > 100) {
                        alert("�������� 100 ������ ���� �Է��Ͽ� �ֽʽÿ�.");
                        dsT_EV_DUTYSAME.RowPosition = i;
                        document.getElementById("txtSEM_RATE").focus();
                        return false;
                    }
                        
                    if ( dsT_EV_DUTYSAME.RowStatus(i) == 1) {
                       document.getElementById("txtDUTY_CD").disabled  = true;
                       document.getElementById("ImgDutyCd").disabled   = true;
                       document.getElementById("txtSDUTY_CD").disabled = true;
                       document.getElementById("ImgSDutyCd").disabled  = true;
                    }

                }
            }   
        
            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            
            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_DUTYSAME,0,"false","false");
            
            fnc_ColEnabled('D');
            
            // form load�� ������ �����ڵ� Ʈ�����·� ��ȸ
            try {
                dsT_CM_DUTYMST.ClearData();
                dsT_CM_DUTYMST.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SHR";
                dsT_CM_DUTYMST.Reset();

            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
            
        }
        
        
        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
            
            if (dsT_EV_DUTYSAME.IsUpdated)  {

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
               
                document.getElementById("txtDUTY_CD").disabled  = false;
                document.getElementById("txtDUTY_NM").disabled  = false;
                document.getElementById("txtSDUTY_CD").disabled = false;
                document.getElementById("txtSDUTY_NM").disabled = false;
                document.getElementById("txtSEM_RATE").disabled = false;

                document.getElementById("ImgDutyCd").disabled   = false;
                document.getElementById("ImgSDutyCd").disabled  = false;
                
            }
            else if (prop == 'D') {

                document.getElementById("txtDUTY_CD").disabled  = true;
                document.getElementById("txtDUTY_NM").disabled  = true;
                document.getElementById("txtSDUTY_CD").disabled = true;
                document.getElementById("txtSDUTY_NM").disabled = true;
                document.getElementById("txtSEM_RATE").disabled = true;

                document.getElementById("ImgDutyCd").disabled   = true;
                document.getElementById("ImgSDutyCd").disabled  = true;
                
            }
            
        }
         

        /*************************************************
         * ����, ����, ���� �� �����ڵ� ��ȸ�� �˾�      *
         ************************************************/
        function fnc_dutyPopup(ctrl_01, ctrl_02) {

            var obj = new String();

            window.showModalDialog("/common/popup/duty.jsp", obj, "dialogWidth:368px; dialogHeight:520px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if(obj.duty_cd != ''){

                document.getElementById(ctrl_01).value = obj.duty_cd;
                document.getElementById(ctrl_02).value = obj.duty_nm;
            }

        }
        
    </script>

    </head>

    
    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. Ʈ�������� DataSet                         |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_DUTYMST)   |
    | 3. ���Ǵ� Table List(T_CM_DUTYMST)          |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DUTYSAME)  |
    | 3. ���Ǵ� Table List(T_EV_DUTYSAME)         |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYSAME" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_EV_DUTYSAME                     |
    | 3. Table List : T_EV_DUTYSAME                 |
    +----------------------------------------------->
    <Object ID ="trT_EV_DUTYSAME" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_DUTYSAME)">
    </Object>
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->
    
    <!-------------------------------+
    | treeview���� item�� Ŭ�������� |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CM_DUTYMST event=OnItemClick()>
        var overId1 = "DUTY_CD";
        var overId2 = "DUTY_LBL";
        var overNm = tvT_CM_DUTYMST.ItemText;
        var Row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",overNm);
        var overValue1 = dsT_CM_DUTYMST.NameValue(Row,overId1);
        var overValue2 = dsT_CM_DUTYMST.NameValue(Row,overId2);
        
        // ���������� 4�� ��� ������������� ��ȸ�ؿ´�.
        if (overValue2 != "4") {
            return;
        }
        
        try {
            dsT_EV_DUTYSAME.ClearData();
            dsT_EV_DUTYSAME.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.a.cdpa010.cmd.CDPA010CMD&S_MODE=SHR_01&"+overId1+"="+overValue1;
            dsT_EV_DUTYSAME.Reset();

        } catch ( exception ) {
            fcWindowsXpSp2Notice(false);
            return;
        }
        
    </script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_DUTYMST Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_DUTYMST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYSAME Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_DUTYSAME.CountRow );
            
            fnc_ColEnabled('E');
            
            document.getElementById("txtDUTY_CD").disabled  = true;
            document.getElementById("ImgDutyCd").disabled   = true;
            document.getElementById("txtSDUTY_CD").disabled = true;
            document.getElementById("ImgSDutyCd").disabled  = true;
            
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYSAME Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYSAME Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_DUTYSAME event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_DUTYSAME event="OnFail()">
    
        cfErrorMsg(this);
    
    </script>
       
<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����������</td>
                    <td align="right" class="navigator">HOME/��������/CDP/��������/<font color="#000000">�����������</font></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="290"></col>
                    <col width="100"></col>
                    <col width="210"></col>
                    <col width="50 "></col>
                    <col width="40 "></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" maxlength="10" style="width:90%;ime-mode:disabled" onChange="fnc_GetCommNm('DUTY', 'txtDUTY_CD','txtDUTY_NM')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDutyCd" name="ImgDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtDUTY_CD','txtDUTY_NM')"></a>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtDUTY_NM" style="width:100%;" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���������ڵ�</td>
                    <td class="padding2423">
                        <input id="txtSDUTY_CD" maxlength="10" style="width:90%;ime-mode:disabled" onChange="fnc_GetCommNm('DUTY', 'txtSDUTY_CD','txtSDUTY_NM')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSDutyCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSDutyCd" name="ImgSDutyCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_dutyPopup('txtSDUTY_CD','txtSDUTY_NM')"></a>
                    </td>
                    <td align="center" class="creamBold">����������</td>
                    <td class="padding2423" >
                        <input id="txtSDUTY_NM" style="width:100%;"  class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
                        <input id="txtSEM_RATE" maxlength="3" style="width:70%;ime-mode:disabled;text-align:right;" onKeyPress="JavaScript: cfNumberCheck();">%
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <!-- ���� ��ȸ Ʈ�� ����-->
                        <comment id="__NSID__">
                        <object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:340px">
                            <param name=DataID        value="dsT_CM_DUTYMST">
                            <param name=TextColumn    value="DUTY_NM">
                            <param name=LevelColumn    value="DUTY_LBL">
                            <param name=ExpandLevel    value="1">
                            <param name=BorderStyle  value="2">
                            <param name=UseImage      value="false">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                        <!-- ���� ��ȸ Ʈ�� ��-->
                    </td>
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_DUTYSAME" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:340px;">
                            <param name="DataID"             value="dsT_EV_DUTYSAME">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
                                <C> id='{currow}'            width=40    name='����'         align=center </C>
                                <C> id='SDUTY_CD'            width=120   name='���������ڵ�' align=center </C>
                                <C> id='SDUTY_NM'            width=220   name='����������'   align=left   </C>
                                <C> id='SEM_RATE'            width=100   name='������'       align=right  </C>
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
<!-- ����������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_DUTYSAME">
    <Param Name="BindInfo", Value='
        <C> Col=DUTY_CD     Ctrl=txtDUTY_CD        Param=value </C>
        <C> Col=DUTY_NM     Ctrl=txtDUTY_NM        Param=value </C>
        <C> Col=SDUTY_CD    Ctrl=txtSDUTY_CD       Param=value </C>
        <C> Col=SDUTY_NM    Ctrl=txtSDUTY_NM       Param=value </C>
        <C> Col=SEM_RATE    Ctrl=txtSEM_RATE       Param=value </C>
    '>
</object>
