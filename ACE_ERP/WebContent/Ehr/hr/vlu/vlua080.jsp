<!--
    ************************************************************************************
    * @Source         : vlua080.jsp                                                    *
    * @Description    : �޼����������� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  ������   | �����ۼ�                                               *
    * 2007/03/15  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�޼�����������(vlua080)</title>
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

        var btnList = 'TTTTFFTT';
        var year = getToday().substr(0, 4);

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            // DATASET  �ʱ�ȭ
            fnc_Clear();

            dsT_EV_ACHPNT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
            dsT_EV_ACHPNT.Reset();

            form1.grdT_EV_ACHPNT.Focus();

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

            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_ACHPNT.KeyValue = "tr01(I:SAV=dsT_EV_ACHPNT)";
            trT_EV_ACHPNT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SAV";
            trT_EV_ACHPNT.post();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            if (form1.selEVL_YY_SHR.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� �ű� ���� �� �� �����ϴ�!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_07');
                document.form1.selEVL_YY_SHR.focus();
                return;
            }

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_ACHPNT.CountColumn == 0) {
                dsT_EV_ACHPNT.setDataHeader("GUBUN:STRING, EVL_YY:STRING:KEYVALUETYPE:NORMALKEY, RATE_OVER:INT:KEYVALUETYPE:NORMALKEY, RATE_UNDER:INT, ACH_PNT:INT, GAUGE_THM:STRING, NONGAUGE_THM:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_ACHPNT.AddRow();

            fnc_ColEnabled('E');

            form1.grdT_EV_ACHPNT.setColumn(form1.grdT_EV_ACHPNT.getColumnID(0));

            // KEY �ʵ�� �űԽ� �Է� ����
            form1.txtEVL_YY.readOnly    = true;
            form1.txtRATE_OVER.readOnly = false;

            form1.txtGUBUN.value  = GUBUN;
            form1.txtEVL_YY.value = form1.selEVL_YY_SHR.value;

            form1.txtRATE_OVER.focus();
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
            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_ACHPNT.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (form1.selEVL_YY_SHR.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� ���� �� �� �����ϴ�!");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.selEVL_YY_SHR.focus();
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("�޼��� [" + dsT_EV_ACHPNT.ColumnString(dsT_EV_ACHPNT.RowPosition,3) + "] ~ [" + dsT_EV_ACHPNT.ColumnString(dsT_EV_ACHPNT.RowPosition,4) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            status = dsT_EV_ACHPNT.RowStatus(dsT_EV_ACHPNT.RowPosition);

            dsT_EV_ACHPNT.DeleteRow(dsT_EV_ACHPNT.RowPosition);

            if (status != 1) {
                trT_EV_ACHPNT.KeyValue = "tr01(I:SAV=dsT_EV_ACHPNT)";
                trT_EV_ACHPNT.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=DEL";
                trT_EV_ACHPNT.post();
            }

            bnd.ActiveBind = false;

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_ACHPNT.SetColumn(form1.grdT_EV_ACHPNT.GetColumnID(0));
            form1.grdT_EV_ACHPNT.Focus();

            bnd.ActiveBind = true;

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("resultMessage").innerText = ' ';

            dsT_EV_ACHPNT.ClearData();

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
            var i = 0;
            var j = 0;

            // DataSet�� ���� ���� Ȯ��
            if ( dsT_EV_ACHPNT.IsUpdated ) {

                if (form1.selEVL_YY_SHR.value != year) {
                    alert("�ش� �⵵ �̿��� �ڷ�� ���� �� ������ �Ұ��մϴ�!");
                    fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                    document.form1.selEVL_YY_SHR.focus();
                    return;
                }

                for( i = 1; i <= dsT_EV_ACHPNT.CountRow; i++ ) {
                    if ( dsT_EV_ACHPNT.RowStatus(i) == 1 ||
                         dsT_EV_ACHPNT.RowStatus(i) == 3 ) {

                        if ( dsT_EV_ACHPNT.RowStatus(i) == 1) {
                           form1.txtEVL_YY.readOnly    = false;
                           form1.txtRATE_OVER.readOnly = false;
                        }

                        // �ش�⵵
                        if( dsT_EV_ACHPNT.NameValue(i, "EVL_YY") == '' ) {
                            alert("�ش�⵵�� �ʼ� �Է»����Դϴ�.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtEVL_YY.focus();
                            return false;
                        }

                        // �޼���(�̻�)
                        if( dsT_EV_ACHPNT.NameValue(i, "RATE_OVER") < 0) {
                            alert("�޼���(�̻�)�� �ʼ� �Է»����Դϴ�.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtRATE_OVER.focus();
                            return false;
                        }

                        // �޼���(�̸�)
                        if( dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER") <= 0) {
                            alert("�޼���(�̸�)�� �ʼ� �Է»����Դϴ�.");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtRATE_UNDER.focus();
                            return false;
                        }

                        // ����
                        if( dsT_EV_ACHPNT.NameValue(i, "ACH_PNT") <= 0) {
                            alert("������ �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ACHPNT.RowPosition = i;
                            form1.txtACH_PNT.focus();
                            return false;
                        }

                        // �޼���(�̻�)�� �޼���(�̸�)�� From ~ To üũ
                        if (new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("�ش� �޼���(�̻�)�� ���� �޼���(�̸�)���� ū ���Դϴ�.\n�ٽ� �Է��Ͻñ� �ٶ��ϴ�.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_OVER.focus();
                                    return false;
                        }

                        for ( j = 1;  j <= dsT_EV_ACHPNT.CountRow; j++ ) {
                            if (j != i) {
                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) <= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER"))) {
                                    alert("�ش� �޼���(�̻�)�� ���� " + j + " ��° ���ڵ� �޼��������� ���Դϴ�.\n�ٽ� �Է��Ͻñ� �ٶ��ϴ�.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_OVER.focus();
                                    return false;
                                }

                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) < new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) >= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("�ش� �޼���(�̸�)�� ���� " + j + " ��° ���ڵ� �޼��������� ���Դϴ�.\n�ٽ� �Է��Ͻñ� �ٶ��ϴ�.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_UNDER.focus();
                                    return false;
                                }

                                if (new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_OVER")) > new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_OVER")) &&
                                    new Number(dsT_EV_ACHPNT.NameValue(j, "RATE_UNDER")) <= new Number(dsT_EV_ACHPNT.NameValue(i, "RATE_UNDER"))) {
                                    alert("�ش� �޼���(�̸�)�� ���� " + j + " ��° ���ڵ� �޼���(�̸�)���� Ů�ϴ�.\n�ٽ� �Է��Ͻñ� �ٶ��ϴ�.");
                                    dsT_EV_ACHPNT.RowPosition = i;
                                    form1.txtRATE_UNDER.focus();
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
            else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");

                return false;

            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ACHPNT,15,"false","false");

            getSelYy2('selEVL_YY_SHR');

            form1.selEVL_YY_SHR.value = getToday().cut(4,6);

            fnc_ColEnabled('D');

            // ��������
            if (frameid == "vlua080") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            fnc_SearchList();

            form1.selEVL_YY_SHR.focus();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_ACHPNT.IsUpdated)
            {
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



        /***************************************************
         * �޼���(�̻�)�� ���� ''�� �� 0���� �ν��ϵ��� �� *
         **************************************************/
        function fncInitRateOver() {

            if (form1.txtRATE_OVER.value == '')  {
                form1.txtRATE_OVER.value = 0;
                form1.txtRATE_UNDER.focus();
            }
        }

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                form1.txtRATE_UNDER.disabled   = false;
                form1.txtACH_PNT.disabled      = false;
                form1.txtGAUGE_THM.disabled    = false;
                form1.txtNONGAUGE_THM.disabled = false;
            }
            else if (prop == 'D') {
                form1.txtRATE_UNDER.disabled   = true;
                form1.txtACH_PNT.disabled      = true;
                form1.txtGAUGE_THM.disabled    = true;
                form1.txtNONGAUGE_THM.disabled = true;
            }
        }

        //���⵵ ���� ����
        function fnc_Yearcopy(){

   			if( ! confirm("���⵵ ������ �����Ͻðڽ��ϱ�?") ){
				return false;
			}

            //�޼������� ������ ���� ��ȸ
            dsT_EV_ACHPNT_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
            dsT_EV_ACHPNT_01.reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ACHPNT)    |
    | 3. ���Ǵ� Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHPNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ACHPNT_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr + �ֿ� ���̺��(T_EV_ACHPNT)     |
    | 3. ���Ǵ� Table List(T_EV_ACHPNT)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_ACHPNT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_ACHPNT)">
    </Object>

    <Object ID ="trT_EV_ACHPNT_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script  for=grdT_EV_ACHPNT event=OnClick(row,colid)>

        if (form1.selEVL_YY_SHR.value == year) {

            // �ű��� ��쿡�� �ش�⵵, �޼���(�̻�) ���� ����
            if( dsT_EV_ACHPNT.RowStatus(row) == 1 ) {

                // �ش�⵵, �޼���(�̻�)�� ���� Ű ���� ����
                form1.txtEVL_YY.readOnly    = false;
                form1.txtRATE_OVER.readOnly = false;

            } else {

                // �ű԰� �ƴ� ��� �ش�⵵, �޼���(�̻�)�� ���� Ű ���� �Ұ�
                form1.txtEVL_YY.readOnly    = true;
                form1.txtRATE_OVER.readOnly = true;
            }

        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ACHPNT Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            // ��ȸ�� �ش�⵵, �޼���(�̻�)�� ���� Ű ���� �Ұ�
            form1.txtEVL_YY.readOnly    = true;
            form1.txtRATE_OVER.readOnly = true;

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHPNT.CountRow);

            if (form1.selEVL_YY_SHR.value == year) {

                form1.txtEVL_YY.readOnly       = false;
                form1.txtRATE_OVER.readOnly    = false;
                form1.txtRATE_UNDER.readOnly   = false;
                form1.txtACH_PNT.readOnly      = false;
                form1.txtGAUGE_THM.readOnly    = false;
                form1.txtNONGAUGE_THM.readOnly = false;
            }
            else {

                form1.txtEVL_YY.readOnly       = true;
                form1.txtRATE_OVER.readOnly    = true;
                form1.txtRATE_UNDER.readOnly   = true;
                form1.txtACH_PNT.readOnly      = true;
                form1.txtGAUGE_THM.readOnly    = true;
                form1.txtNONGAUGE_THM.readOnly = true;
            }

        }

    </Script>

    <Script For=dsT_EV_ACHPNT_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("���������Ͱ� �����մϴ�. ��� �Ͻðڽ��ϱ�?") ){
				return false;
			}

        }

		//Ʈ����� üũ�� ���� �ӽû���
        dsT_EV_ACHPNT_01.AddRow();

		//Ʈ����� ����
		trT_EV_ACHPNT_01.KeyValue = "SVL(I:dsT_EV_ACHPNT_01=dsT_EV_ACHPNT_01)";
		trT_EV_ACHPNT_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua080.cmd.VLUA080CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+form1.selEVL_YY_SHR.value;
		trT_EV_ACHPNT_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_ACHPNT_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHPNT Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018 ) {
            alert("�ش� �ʼ��Է��׸�[�޼���(�̻�)/�޼���(�̸�)] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�޼���(�̻�)/�޼���(�̸�)�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_EV_ACHPNT event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <script for=trT_EV_ACHPNT_01 event="OnSuccess()">

		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_ACHPNT event="OnFail()">

        cfErrorMsg(this);

    </script>

    <script for=trT_EV_ACHPNT_01 event="OnFail()">

        cfErrorMsg(this);

    </script>

<!--
**************************************************************
* BODY START
**************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�޼�����������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�޼�����������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgYearcopy','','/images/button/btn_YearcopyOver.gif',1)"><img src="/images/button/btn_YearcopyOn.gif" name="imgYearcopy"    width="110" height="20" border="0" align="absmiddle" onClick="fnc_Yearcopy();"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="80"></col>
                                    <col width="720"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">
                                    <select id="selEVL_YY_SHR" name="selEVL_YY_SHR" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="120"></col>
                    <col width="140"></col>
                    <col width="120"></col>
                    <col width="140"></col>
                    <col width="120"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                    <td align="center" class="creamBold">�ش�⵵</td>
                        <td class="padding2423"><input id=txtEVL_YY value="" size="4" maxlength="4" style="ime-mode:disabled"  onKeyPress="JavaScript: cfCheckNumber()" on> ��</td>
                    <td align="center" class="creamBold">�޼���</td>
                    <td class="padding2423">
                        <input id=txtRATE_OVER size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber()" onBlur="fncInitRateOver();"> % ~
                        <input id=txtRATE_UNDER size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="JavaScript: cfCheckNumber()" > %</td>
                    <td align="center" class="creamBold">����</td>
                    <td class="padding2423"><input id=txtACH_PNT size="3" maxlength="3" style="ime-mode:disabled" onKeyPress="cfCheckNumber()" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�跮��ǥ</td>
                    <td class="padding2423" colspan="5"><input id=txtGAUGE_THM value="" style="WIDTH:100%" maxlength="200"> </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold">��跮��ǥ</td>
                    <td class="padding2423" colspan="5"><input id=txtNONGAUGE_THM value="" style="WIDTH:100%" maxlength="200"> </td>
               </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
                        <comment id="__NSID__">
                        <object id="grdT_EV_ACHPNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
                            <param name="DataID"                  value="dsT_EV_ACHPNT">
                            <param name="Format"                  value="
                                <C> id={currow}        width=30   name='����'         align=center </C>
                                <G> name='�޼���(%)' HeadBgColor='#F7DCBB'
                                    <C> id=RATE_OVER   width=33   name='�̻�'         align=right EditLimit=3 </C>
                                    <C> id=RATE_UNDER  width=33   name='�̸�'         align=right EditLimit=3 </C>
                                </G>
                                <C> id=GAUGE_THM       width=193  name='�跮��ǥ'                  </C>
                                <C> id=NONGAUGE_THM    width=442  name='��跮��ǥ'                </C>
                                <C> id=ACH_PNT         width=33   name='����'         EditLimit=3  </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �޼����������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_ACHPNT">
    <Param Name="BindInfo", Value='
        <C>Col=GUBUN        Ctrl=txtGUBUN          Param=value Disable=disabled</C>
        <C>Col=EVL_YY       Ctrl=txtEVL_YY         Param=value Disable=disabled</C>
        <C>Col=RATE_OVER    Ctrl=txtRATE_OVER      Param=value Disable=disabled</C>
        <C>Col=RATE_UNDER   Ctrl=txtRATE_UNDER     Param=value </C>
        <C>Col=ACH_PNT      Ctrl=txtACH_PNT        Param=value </C>
        <C>Col=GAUGE_THM    Ctrl=txtGAUGE_THM      Param=value </C>
        <C>Col=NONGAUGE_THM Ctrl=txtNONGAUGE_THM   Param=value </C>
    '>
</object>