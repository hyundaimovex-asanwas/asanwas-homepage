<!--
*****************************************************
* @source       : vluc180.jsp
* @description : ����������_���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/11      ���뼺        �����ۼ�.
* 2007/03/18      ������        ����. (�����򰡾������� �߰�)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����������_����(vluc180)</title>
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

        var btnList = 'TFTTTFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var CHG_CHK  = "0";

            if(form1.chkCHG_CHK_SHR.checked){
                CHG_CHK = "1";
            } else {
                CHG_CHK = "0";
            }

            if( document.getElementById("cmbGROUP_CD_SHR").value != '' ) {
                if (GUBUN == "01") {
                    document.getElementById("txtCOMM_CD_SHR").value = 'EG';
                }
                else if (GUBUN == "02") {
                    document.getElementById("txtCOMM_CD_SHR").value = '4';
                }
            }
            else {
                document.getElementById("txtCOMM_CD_SHR").value = '';
            }

            //�����ͼ� ����
            dsT_EV_ABLRST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&EVL_GBN=2&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&cmbHEAD_CD_SHR="+document.getElementById("cmbHEAD_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value+"&CHG_CHK="+CHG_CHK;
            dsT_EV_ABLRST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //���� ������Ⱓ�� �ش��ϴ� �⵵,ȸ�� ����
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //Ʈ����� ����
            trT_EV_ABLRST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SAV";
            trT_EV_ABLRST.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("������������", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("���� �� �ڷᰡ �����ϴ�.");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_ABLRST.NameValue(dsT_EV_ABLRST.RowPosition,'ENO_NO') + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_ABLRST.DeleteRow(dsT_EV_ABLRST.RowPosition);

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_ABLRST.SetColumn("ENO_NO");
            form1.grdT_EV_ABLRST.Focus();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM_SHR.value = '';
            f.cmbHEAD_CD_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

            dsT_EV_ABLRST.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("btnReflect").disabled=false;

            f.txtENO_NO_SHR.focus();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_ABLRST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if ( dsT_EV_ABLRST.isUpdated ) {

            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return false;
            }
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_ABLRST,15,"true","false");      // Grid Style ����

            //���� �޺�
            var oOption;
            for( i=1; i<=dsCOMMON_B2.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text = dsCOMMON_B2.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);
            }

            // ��������
            if (frameid == "vluc180") {
                // �λ���
                GUBUN = "01";

                //�򰡱׷�
                for( var i = 1; i <= dsCOMMON_EG.CountRow; i++ ) {

                    oOption       = document.createElement("OPTION");
                    oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                    oOption.text  = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);

                }

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                var tempDS = fnc_GetDutyCd('DUTY2', '4');
                var oOption;

                for( i=1; i<=tempDS.CountRow; i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = tempDS.NameValue(i,"COMM_CD");
                    oOption.text = tempDS.NameValue(i,"COMM_NM");
                    document.getElementById("cmbGROUP_CD_SHR").add(oOption);
                }

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";

            }

            //�� ���� ���� ���� ���� ��ȸ
            fnc_SearchItem();

            document.form1.txtENO_NO_SHR.focus();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. �ϰ��ݿ� �۾� ó�� �κ�  *
         *******************************************/
        function fnc_Reflect() {

            if(confirm("������ ����� ������ ���� �ڷ�� ��� �ʱ�ȭ �˴ϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) {

                dsT_EV_ABLRST_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,'EVL_YY')+"&EVL_GBN=2&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,'EVL_FRQ');
                dsT_EV_ABLRST_02.Reset();

            } else {
                return;
            }

        }

        /********************************************
         * 16. ���ǿ� ���� enable/disable ó��    *
         *******************************************/
        function fnc_EnableDisableSet( div ) {

            //Enableó��
            if( div == '1' ) {
                document.getElementById("image3").disabled=false;
                document.getElementById("btnReflect").disabled=false;
                form1.grdT_EV_ABLRST.Editable='true';
            }
            //Disableó��
            if( div == '2' ) {
                document.getElementById("image3").disabled=true;
                document.getElementById("btnReflect").disabled=true;
                form1.grdT_EV_ABLRST.Editable='false';
            }

        }

        /********************
         * 17. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ABLRST_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_ABLRST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST)">
    </Object>

    <Object ID ="trT_EV_ABLRST_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ABLRST_01)">
    </Object>

    <!-- ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"  value="B2"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"    value="EG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ABLRST.CountRow);

            if( dsT_EV_ABLRST.NameValue(1,"FEEDBK_GBN") == 'T' ) {
                //��ư �Ұ�ó��
                fnc_EnableDisableSet('2');
                document.getElementById("resultMessage").innerText = '* ������ ��� ������ Ȯ���Ǿ����Ƿ� ���� �Ұ��մϴ�.';
                alert("������ ��� ������ Ȯ���Ǿ����Ƿ� ���� �Ұ��մϴ�.");
            } else {
                //��ư ����ó��
                fnc_EnableDisableSet('1');
            }

        }

           grdT_EV_ABLRST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_ABLRST_02 Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

            // ���������Ͱ� �������� �ʴ� ���
            if (dsT_EV_ABLRST_02.NameValue(1, "CNT") == "0") {
                document.getElementById("resultMessage").innerText = '* �ϰ��ݿ� ����� �������� �ʽ��ϴ�.';
                alert("�ϰ��ݿ� ����� �������� �ʽ��ϴ�.");

                return;
            }

            // FEED BACK ���� üũ�Ͽ� FEED BACK �Ǿ��ٸ� �ϰ��������� ����
            if (dsT_EV_ABLRST_02.NameValue(2, "CNT") != "0") {
                document.getElementById("resultMessage").innerText = '* ������ ��� ������ Ȯ���Ǿ����Ƿ� ���� �Ұ��մϴ�.';
                alert("������ ��� ������ Ȯ���Ǿ����Ƿ� ���� �Ұ��մϴ�.");

                return;
            }

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_ABLRST_01.CountColumn == 0) {
                dsT_EV_ABLRST_01.setDataHeader("EVL_YY:STRING");
            }
            dsT_EV_ABLRST_01.AddRow();
            //�ϰ� ������ ���� DateSet�� UserStatus�� ���Ƿ� �����Ѵ�.
            dsT_EV_ABLRST_01.UserStatus(1) = 1;

            trT_EV_ABLRST_01.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc180.cmd.VLUC180CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,'EVL_YY')+"&EVL_GBN=2&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,'EVL_FRQ');
            trT_EV_ABLRST_01.post();
            fnc_SearchList();
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("������Ⱓ�� �ƴմϴ�.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST_02 Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST_02 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"),"MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);

    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ABLRST_01 event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ABLRST_01 event="OnFail()">

        if (trT_EV_ABLRST_01.ErrorCode != 50015) {
            document.getElementById("resultMessage").innerText = ' ';
            cfErrorMsg(this);
        }

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������_����</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">����������_����</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="70"></col>
                                    <col width="50"></col>
                                    <col width="50"></col>
                                    <col width="30"></col>
                                    <col width="90"></col>
                                    <col width="100"></col>
                                    <col width="60"></col>
                                    <col width="110"></col>
                                    <col width="70"></col>
                                    <col width="170"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                    <td><input id=txtEVL_YY_SHR name=txtEVL_YY_SHR style="width 100%;text-align:center;" size="4" class="input_ReadOnly" readonly valid="key=true" field="�ش�⵵"></td>
                                    <td align="right" class="searchState">ȸ��&nbsp;</td>
                                    <td class=""><input id=txtEVL_FRQ_SHR name=txtEVL_FRQ_SHR size="4" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchState">�򰡱׷�&nbsp;</td>
                                    <td class="">
                                        <input type="hidden" id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR">
                                        <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>�� ü</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">����&nbsp;</td>
                                    <td class="">
                                        <select id="cmbHEAD_CD_SHR" name="cmbHEAD_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>�� ü</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">���&nbsp;</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','1','1');">
                                    <input id=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState" width="77%"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right" class="searchState">
                            <input type="checkbox" name="chkCHG_CHK_SHR" id=chkCHG_CHK_SHR style="border:0" align="absmiddle" onClick="fnc_SearchList()">�����ο�
                        </td>
                        <td align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnReflect','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btnReflect" name="btnReflect" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Reflect()"></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <!--
        <tr>
            <td class="paddingTop8" style="padding-top:1">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="2" bgcolor="#A4A4A1"></td>
                    </tr>
                </table>
            </td>
        </tr>
         -->

        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                            value="dsT_EV_ABLRST">
                                <param name="EdiTABLE"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                        value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"              value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                            value="
                                    <C> id='EVL_YY'     width=40   name='EVL_YY'    align=center    show=false </C>
                                    <C> id='EVL_GBN'    width=40   name='EVL_GBN'   align=center    show=false </C>
                                    <C> id='EVL_FRQ'    width=40   name='EVL_FRQ'   align=center    show=false </C>
                                    <C> id='GROUP_NM'   width=100  name='�򰡱׷�'  align=left      edit=none </C>
                                    <C> id='HEAD_NM'    width=104  name='����'      align=left      edit=none </C>
                                    <C> id='DPT_NM'     width=100  name='�Ҽ�'      align=left      edit=none </C>
                                    <C> id='JOB_NM'     width=100  name='����'      align=left      edit=none </C>
                                    <C> id='ENO_NO'     width=80   name='���'      align=center    edit=none </C>
                                    <C> id='ENO_NM'     width=80   name='����'      align=center    edit=none </C>
                                    <C> id='RNUM'       width=40   name='����'      align=center    edit=none </C>
                                    <C> id='CHANGE_GRD' width=60   name='���ʵ��'  align=center    edit=none </C>
                                    <C> id='CHIEP_GRD'  width=100  name='�������������'  align=center    editstyle=combo    data='S:S,A:A,B:B,C:C,D:D' bgcolor={Decode(CHIEP_GRD,CHANGE_GRD,'#FFFFFF',NULL,'#FFFFFF','#F2AC47')}</C>
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

    <!-- Validation Init  -->
    <jsp:include page="/common/CommonValid.jsp" flush="true">
       <jsp:param name="INIT"    value="false"/>
    </jsp:include>

</body>
</html>