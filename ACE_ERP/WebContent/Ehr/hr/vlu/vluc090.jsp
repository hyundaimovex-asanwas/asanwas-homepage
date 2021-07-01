<!--
    ************************************************************************************
    * @Source         : vluc090.jsp                                                    *
    * @Description    : ��ǥ���� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/12/12  |  ������   | �����ۼ�                                               *
    * 2007/03/17  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>��ǥ����(vluc090)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String MOD       = request.getParameter("MOD");           //�ڱ����������� ����
    String GUBUN     = request.getParameter("GUBUN");         //��������
    String ENO_NO    = request.getParameter("ENO_NO");        //���ڻ��
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        // ������
        var EVL_GBN = "2";
        var btnList = 'TFTFFFFT';
        var aim_gbn = '';

        //���â���� ����� ��� �����ϱ� ���� ��� by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";
        var OBJ_STDT = '';
        var OBJ_ENDT = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY    = form1.txtEVL_YY_SHR.value;
            var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;

            // DATASET �ʱ�ȭ
            fnc_Clear();

            // ������ǥ ��ȸ
            dsT_EV_AIMLST_ORG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
            dsT_EV_AIMLST_ORG.Reset();

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
            var EVL_YY    = form1.txtEVL_YY_SHR.value;
            var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
            var AIM_YMD   = form1.txtAIM_YMD.value;

            // ����� �� �ʵ��� ��ȿ��üũ
            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_EV_AIMLST.KeyValue = "tr01(I:SAV=dsT_EV_AIMLST)";
            trT_EV_AIMLST.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SAV&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
            trT_EV_AIMLST.post();

            dsT_EV_AIMLST.UseChangeInfo = "true";

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

            if (dsT_EV_AIMLST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_AIMLST.GridToExcel("��ǥ����", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            form1.txtAIM_YMD.value    = '';
            form1.txtRETURN_DEC.value = '';
            form1.txtMODIFY_DEC.value = '';
            form1.txtTOT_ADDING_PCT.value = '';

            // DataSet Clear
            dsT_EV_AIMLST.ClearData();
            dsT_EV_AIMLST_ORG.ClearData();

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
            var aim_seq  = 0;
            var item_seq = 0;

            // DataSet�� ���� ���� Ȯ��
            if ( !dsT_EV_AIMLST.IsUpdated ) {

                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if (dsT_EV_AIMLST.CountRow != 0 && form1.txtTOT_ADDING_PCT.value != 100) {
                document.getElementById("resultMessage").innerText = "* ����ġ�� �հ谡 100 �̾�� �մϴ�!!!";
                alert("����ġ�� �հ谡 100 �̾�� �մϴ�!!!");
                return false;
            }

            if (form1.txtAIM_YMD.value == "") {
                alert("�������ڴ� �ʼ��Է��׸��Դϴ�.");

                form1.txtAIM_YMD.focus();
                return false;
            }

            if (form1.txtMODIFY_DEC.value == "") {
                alert("���������� �ʼ��Է��׸��Դϴ�.");

                form1.txtMODIFY_DEC.focus();
                return false;
            }

            // ��������� �����ϸ� ��� row ���¸� insert�� ������
            dsT_EV_AIMLST.UseChangeInfo = "false";

            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    aim_seq  = aim_seq + 1;
                    item_seq = 1;
                }

                dsT_EV_AIMLST.NameValue(i, "AIM_SEQ") = aim_seq;

                if (dsT_EV_AIMLST.NameValue(i, "ITEM_DEC") != '') {
                    dsT_EV_AIMLST.NameValue(i, "ITEM_SEQ") = item_seq;
                    item_seq = item_seq + 1;

                }

                if( dsT_EV_AIMLST.RowStatus(i) == 1 || dsT_EV_AIMLST.RowStatus(i) == 3 ) {
                  if( dsT_EV_AIMLST.NameValue(i,"GAUGE_GB") == '1' ) {
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_S") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_S") = '110% �̻�';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_A") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_A") = '100% �̻� ~110% �̸�';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_B") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_B") = '95% �̻� ~100% �̸�';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_C") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_C") = '85% �̻� ~ 95% �̸�';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_D") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_D") = '85% �̸�';
				 } else {
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_S") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_S") = '���ġ�� �ſ� ��ȸ / ������ ������ �����񱳽� Ź��';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_A") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_A") = '���ġ�� ��ȸ / ������ ������ �����񱳽� ���';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_B") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_B") = '���ġ�� ����.���� / ������ ������ �����񱳽� ����';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_C") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_C") = '���ġ�� �ణ �̴� / ������ ������ �����񱳽� ����';
                    if( dsT_EV_AIMLST.NameValue(i,"CRITR_D") == '' )
                        dsT_EV_AIMLST.NameValue(i,"CRITR_D") = '���ġ�� �ſ� �̴� / ������ ������ �����񱳽� ����';
				 }
                }

                dsT_EV_AIMLST.NameValue(i, "AIM_YMD") = form1.txtAIM_YMD.value;
                dsT_EV_AIMLST.NameValue(i, "MODIFY_DEC") = form1.txtMODIFY_DEC.value;
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style ����
            cfStyleGrid2(form1.grdT_EV_AIMLST_ORG);
            form1.grdT_EV_AIMLST_ORG.Editable = 'false';
            form1.grdT_EV_AIMLST_ORG.ColSelect = true;
            form1.grdT_EV_AIMLST_ORG.IndWidth  = 0;

            cfStyleGrid2(form1.grdT_EV_AIMLST);
            form1.grdT_EV_AIMLST.ColSelect = true;
            form1.grdT_EV_AIMLST.IndWidth  = 0;

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // ��������
            if (frameid == "vluc090" || "<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_EV_AIMLST.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /************************
         * ��ǥ�߰� ��ư Ŭ���� *
         ************************/
        function fnc_InsertAimLst() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CountRow = dsT_EV_AIMLST.CountRow + 1;

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_AIMLST.CountColumn == 0) {

                alert("���� ���ڸ� ����, ��ȸ�۾��� �Ͻ� ������ ��ǥ�߰� �۾��� �Ͻñ� �ٶ��ϴ�.");
                return;
            }
            else {
                TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
                BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
                GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
                AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
                ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
                TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");

                for (var i = dsT_EV_AIMLST.RowPosition + 1; i <= CountRow; i++) {

                    if (TASK_AIM      != dsT_EV_AIMLST.NameValue(i, "TASK_AIM")      ||
                        BASIC_PAR     != dsT_EV_AIMLST.NameValue(i, "BASIC_PAR")     ||
                        GAUGE_GB      != dsT_EV_AIMLST.NameValue(i, "GAUGE_GB")      ||
                        AIM_LEVEL     != dsT_EV_AIMLST.NameValue(i, "AIM_LEVEL")     ||
                        ADDING_PCT    != dsT_EV_AIMLST.NameValue(i, "ADDING_PCT")    ||
                        TASK_CSF != dsT_EV_AIMLST.NameValue(i, "TASK_CSF") ) {

                        aim_gbn = 'L';

                        // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
                        dsT_EV_AIMLST.InsertRow(i);
                        dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") = 'L';      // ��ǥ
                        dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN") = '0';

                        break;

                    }
                }

                if (CountRow == 1) {
                    // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
                    dsT_EV_AIMLST.InsertRow(1);
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") = 'L';      // ��ǥ
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN") = '0';

                }
            }

            form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
            form1.grdT_EV_AIMLST.Focus();

            fnc_DisableFld(dsT_EV_AIMLST.RowPosition);

        }

        /************************
         * ��ǥ���� ��ư Ŭ���� *
         ***********************/
        function fnc_DeleteAimLst() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CNT = 0;
            var TOT_ADDING_PCT = 0;
            var CountRow      = dsT_EV_AIMLST.CountRow;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") != 'L') {
                alert("�����ϰ��� �ϴ� ��ǥ ���ڵ带 �����Ͽ� �ֽñ� �ٶ��ϴ�.");
                return;
            }

            TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
            BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
            GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
            AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
            ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
            TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + TASK_AIM + "][" + BASIC_PAR + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            //dsT_EV_AIMLST.RowPosition = 1;

            for (var i = dsT_EV_AIMLST.RowPosition; i <= CountRow; i++) {

                if (TASK_AIM      == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      &&
                    BASIC_PAR     == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     &&
                    GAUGE_GB      == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      &&
                    AIM_LEVEL     == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     &&
                    ADDING_PCT    == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    &&
                    TASK_CSF == dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") ) {

                    dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
                    CNT = 1;

                }
                else {
                    if (CNT == 1) {

                        break;
                    }

                    dsT_EV_AIMLST.RowPosition = dsT_EV_AIMLST.RowPosition + 1;
                }
            }

            // ����ġ�հ�
            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {

                    TOT_ADDING_PCT = TOT_ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = TOT_ADDING_PCT;

            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Save();
            }
            else {
                // ���� �� �ش� �׸���� Focus �̵�
                form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
                form1.grdT_EV_AIMLST.Focus();
            }

        }

        /****************************
         * ���ΰ�ȹ�߰� ��ư Ŭ���� *
         ***************************/
        function fnc_InsertAimSub() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var ACCEPT_GBN    = '';
            var RETURN_DEC    = '';

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_AIMLST.CountRow == 0) {

                alert("��ǥ�߰��� ���� �Ͻð�, �����׸� �߰��۾��� �Ͻñ� �ٶ��ϴ�.");

                form1.grdT_EV_AIMLST.focus();
                return;

            }
            else {

                TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
                BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
                GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
                AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
                ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
                TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");
                ACCEPT_GBN    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN");
                RETURN_DEC    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "RETURN_DEC");

            }

            aim_gbn = 'S';

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_AIMLST.InsertRow(dsT_EV_AIMLST.RowPosition + 1);

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") != 'L') {
                dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN")   = 'S';      // ����
            }
            else {
                return;
            }

            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      = TASK_AIM;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     = BASIC_PAR;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      = GAUGE_GB;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     = AIM_LEVEL;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    = ADDING_PCT;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") = TASK_CSF;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ACCEPT_GBN")    = ACCEPT_GBN;
            dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "RETURN_DEC")    = RETURN_DEC;

            fnc_DisableFld(dsT_EV_AIMLST.RowPosition);

            form1.grdT_EV_AIMLST.SetColumn("ITEM_DEC");
            form1.grdT_EV_AIMLST.Focus();

        }

        /****************************
         * ���ΰ�ȹ���� ��ư Ŭ���� *
         ***************************/
        function fnc_DeleteAimSub() {
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';
            var ITEM_DEC      = '';
            var CNT = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_AIMLST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            TASK_AIM      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM");
            BASIC_PAR     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR");
            GAUGE_GB      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB");
            AIM_LEVEL     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL");
            ADDING_PCT    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT");
            TASK_CSF = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF");
            ITEM_DEC      = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC");

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + TASK_AIM + "][" + BASIC_PAR + "] ��ǥ�� [" + ITEM_DEC + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;

            if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {

                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition + 1, "AIM_GBN") == 'S') {
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition + 1, "AIM_GBN") = 'L';
                    dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
                }
                else {

                }
            }
            else {
                dsT_EV_AIMLST.DeleteRow(dsT_EV_AIMLST.RowPosition);
            }

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_AIMLST.SetColumn("TASK_AIM");
            form1.grdT_EV_AIMLST.Focus();
        }

        function fnc_DisableFld(Row) {

            // ��ǥ������ '��ǥ' �� ��, �Է� �����ϵ��� ��
            if (dsT_EV_AIMLST.NameValue(Row, "AIM_GBN") == 'L') {
                form1.grdT_EV_AIMLST.ColumnProp('TASK_AIM', 'Edit')      = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('BASIC_PAR', 'Edit')     = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('GAUGE_GB', 'Edit')      = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('AIM_LEVEL', 'Edit')     = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('ADDING_PCT', 'Edit')    = 'true';
                form1.grdT_EV_AIMLST.ColumnProp('TASK_CSF', 'Edit') = 'true';

            }
            // ��ǥ������ '����' �� ��, �Է� �Ұ����ϵ��� ��
            else if (dsT_EV_AIMLST.NameValue(Row, "AIM_GBN") == 'S') {
                form1.grdT_EV_AIMLST.ColumnProp('TASK_AIM', 'Edit')      = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('BASIC_PAR', 'Edit')     = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('GAUGE_GB', 'Edit')      = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('AIM_LEVEL', 'Edit')     = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('ADDING_PCT', 'Edit')    = 'None';
                form1.grdT_EV_AIMLST.ColumnProp('TASK_CSF', 'Edit') = 'None';

            }
        }

        function fnc_CopyGrid() {
            var ADDING_PCT = 0;

            // ������ǥ �����Ͱ� �����ϸ�
            if (dsT_EV_AIMLST.CountRow > 0) {
                if(!confirm("��ǥ�����Ͻ� ������ �����ϸ� ��� �ʱ�ȭ�˴ϴ�.\n\n�׷��� ���� �Ͻðڽ��ϱ�?")) return;
            }

            /** �����ͼ� ���� **/
            cfCopyDataSet(dsT_EV_AIMLST_ORG, dsT_EV_AIMLST, "copyHeader=yes");

            if (dsT_EV_AIMLST.CountRow > 0) {

                for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {
                    // ��ǥ��������
                    dsT_EV_AIMLST.NameValue(i, "AIM_YMD") = getToday();
                    dsT_EV_AIMLST.NameValue(i, "ACCEPT_GBN") = "0";
                    dsT_EV_AIMLST.NameValue(i, "RETURN_DEC") = "";
                    dsT_EV_AIMLST.NameValue(i, "MODIFY_DEC") = "";

                    // ����ġ�հ�
                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                        ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                    }
                }

                form1.txtTOT_ADDING_PCT.value = ADDING_PCT;

                document.getElementById("txtAIM_YMD").value = getToday();
                document.getElementById("resultMessage").innerText = '* �ϰ��ݿ��Ǿ����ϴ�.';
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
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_AIMLST)    |
    | 3. ���Ǵ� Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST_ORG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_AIMLST)    |
    | 3. ���Ǵ� Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_AIMLST)    |
    | 3. ���Ǵ� Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST_ORG_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_SCHCHG)    |
    | 3. ���Ǵ� Table List(T_EV_SCHCHG)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_HD) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_HD)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_HD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_DT) |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_DT)        |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_AIMLST)    |
    | 3. ���Ǵ� Table List(T_EV_AIMLST)           |
    +----------------------------------------------->
    <Object ID ="trT_EV_AIMLST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EV_AIMLST)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script for=dsT_EV_AIMLST Event=onColumnChanged(row,colid)>

        var ADDING_PCT = 0;

        // ����ġ�հ�
        if (colid == 'ADDING_PCT' && dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {
            for (var i = 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = ADDING_PCT;
        }


        if ((colid == 'GAUGE_GB' || colid == 'AIM_LEVEL') && dsT_EV_AIMLST.NameValue(row, "GAUGE_GB") == '1') {

                 var StrFrom, sufix, StrTo;

                 var EXT_NUM = 0;

			var colStr = dsT_EV_AIMLST.NameValue(row, "AIM_LEVEL");
			var values = colStr.split(" ");

              for( x = 0; x < values.length; x++ ){

					if (values[x] >= "1" && values[x] <= "9"){
						EXT_NUM = values[x].toUnComma();
						//alert("EXT_NUM = "+EXT_NUM);
						break;
				    }
			  }
			if(EXT_NUM == 0){
			   alert("KPI(�������) ������ '�跮'�϶� ���ڸ� �������� �и��Ͽ� �Է� �ٶ��ϴ�.");
               form1.grdT_EV_AIMLST.SetColumn("AIM_LEVEL");
               form1.grdT_EV_AIMLST.Focus();
			}


			if(x+1 < values.length){
            	sufix = values[x+1];
            }else{
                sufix = "";
			}

			StrFrom = "";
			StrTo = String(EXT_NUM * 1.10);
			dsT_EV_AIMLST.NameValue(row, "CRITR_S") = StrTo.toRound(2) + sufix + "�̻�";

			StrFrom = String(EXT_NUM * 1.00);
			dsT_EV_AIMLST.NameValue(row, "CRITR_A") = StrFrom.toRound(2) + sufix + "�̻�" +"~"+ StrTo.toRound(2)  + sufix + "�̸�";

			StrTo   = String(EXT_NUM * 1.00);
			StrFrom = String(EXT_NUM * 0.95);
			dsT_EV_AIMLST.NameValue(row, "CRITR_B") = StrFrom.toRound(2) + sufix + "�̻�" +"~"+ StrTo.toRound(2)  + sufix + "�̸�";

			StrTo   = String(EXT_NUM * 0.95);
			StrFrom = String(EXT_NUM * 0.85);
			dsT_EV_AIMLST.NameValue(row, "CRITR_C") = StrFrom.toRound(2) + sufix + "�̻�" +"~"+ StrTo.toRound(2)  + sufix + "�̸�";

			dsT_EV_AIMLST.NameValue(row, "CRITR_D") = StrFrom.toRound(2) + sufix + "�̸�";

        }
    </script>

    <script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
        var T_CHECK = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"T_CHECK");

        // ��ü �÷� checkbox Ŭ���� �ش� ���� �������� chekbox�� �ݿ�
        if( grdT_EV_AIMLST.Editable == true) {
            if (colid == 'T_CHECK' ) {

            }

        }

    </script>

<script language=JavaScript for=grdT_EV_AIMLST event=OnDblClick(row,colid)>

        var colid_1 = '';

        // �������� chekbox�� ����Ŭ���Ͽ� �ش� ���� �ݿ�
        if( grdT_EV_AIMLST.Editable == true) {

        }

    </script>

    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_AIMLST event=OnPopup(Row,Colid,data)>

        // KPI POOL ��ȸ
        if ( Colid == 'BASIC_PAR') {

            var obj = new String();

            obj.title = "KPI POOL";
            obj.gbn = "KPI";

            window.showModalDialog("/common/popup/codenm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            dsT_EV_AIMLST.NameValue(Row,'BASIC_PAR') = obj.comm_nm;

            for (var i = Row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                  dsT_EV_AIMLST.NameValue(i, 'BASIC_PAR') = obj.comm_nm;
                }
                else {
                    break;
                }
            }

        }
    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        var ADDING_PCT = 0;

        if (iCount > 0)  {

            form1.txtAIM_YMD.value    = dsT_EV_AIMLST.NameValue(1, "AIM_YMD");
            form1.txtRETURN_DEC.value = dsT_EV_AIMLST.NameValue(1, "RETURN_DEC");
            form1.txtMODIFY_DEC.value = dsT_EV_AIMLST.NameValue(1, "MODIFY_DEC");

            // ����ġ�հ�
            for (var i = 1; i <= iCount; i++) {

                if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'L') {
                    ADDING_PCT = ADDING_PCT + dsT_EV_AIMLST.NameValue(i, "ADDING_PCT");
                }
            }

            form1.txtTOT_ADDING_PCT.value = ADDING_PCT;

        }

        if (dsT_EV_AIMLST_ORG_02.CountRow > 0)    {

            document.getElementById("resultMessage").innerText = '* ���۾��� �������̰ų� �Ϸ�Ǿ����ϴ�.';
            alert("���۾��� �������̰ų� �Ϸ�Ǿ����ϴ�.");

            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

        }
        else {
            form1.grdT_EV_AIMLST.Editable = 'true';

            document.getElementById("btnINSLST").disabled = false;
            document.getElementById("btnDELLST").disabled = false;

            if (iCount > 0)  {
                document.getElementById("txtAIM_YMD").disabled = true;
                document.getElementById("image20").disabled = true;
                document.getElementById("image30").disabled = true;
            }
            else {
                document.getElementById("txtAIM_YMD").disabled = false;
                document.getElementById("image20").disabled = false;
                document.getElementById("image30").disabled = false;
            }

            // �������ڰ� ��ǥ�����Ⱓ������ ���̸� �޼��� �� �޼��� �Է°����ϵ��� ��
            if (OBJ_STDT <= getToday() && OBJ_ENDT >= getToday()) {
                ;
            }
            else {

                document.getElementById("resultMessage").innerText = '* ��ǥ�Է� �Ⱓ�� �ƴմϴ�.';
                form1.grdT_EV_AIMLST.Editable = 'false';

                document.getElementById("btnINSLST").disabled = true;
                document.getElementById("btnDELLST").disabled = true;
                document.getElementById("image30").disabled   = true;

                document.getElementById("txtAIM_YMD").disabled    = true;
                document.getElementById("image20").disabled       = true;
                document.getElementById("txtMODIFY_DEC").disabled = true;

            }

            document.getElementById("txtMODIFY_DEC").disabled = false;
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            if (aim_gbn == 'S' && dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {
                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC")      != "" ) {
                    alert("�ش� �ʼ��Է��׸�[�ֿ������ǥ/��������ǥ/�跮����/��ǥ����/����ġ/���̵�/�����׸�] �Է� �� ���� �۾��� �����մϴ�.");
                }
                else {
                    alert("��ǥ�� ���� �Է��Ͻð� ����������ȹ�� �Է��Ͻñ� �ٶ��ϴ�.");
                }
            }
            else {

                alert("�ش� �ʼ��Է��׸�[�ֿ������ǥ/��������ǥ/�跮����/��ǥ����/����ġ/���̵�/�����׸�] �Է� �� ���� �۾��� �����մϴ�.");
            }
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST_ORG Event="OnLoadCompleted(iCount)">
        var ADDING_PCT = 0;

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = '* �������ε� ��ǥ�� �����ϴ�. ��ǥ������ �������ε� �ڷᰡ �־�� �����մϴ�.';
            alert("�������ε� ��ǥ�� �����ϴ�.\n\n��ǥ������ �������ε� �ڷᰡ �־�� �����մϴ�.");

            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

        } else {

            // �����࿩��(��ǥ�ڷ����翩��) ��ȸ
            dsT_EV_AIMLST_ORG_02.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("txtEVL_YY_SHR").value+"&EVL_FRQ="+document.getElementById("txtEVL_FRQ_SHR").value+"&AIM_YMD=1900-01-01&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&EVLENO_NO="+document.getElementById("cmbEVLENO_NO_SHR").value;
            dsT_EV_AIMLST_ORG_02.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG Event="OnDataError()">
            var TASK_AIM      = '';
            var BASIC_PAR     = '';
            var GAUGE_GB      = '';
            var AIM_LEVEL     = '';
            var ADDING_PCT    = '';
            var TASK_CSF = '';

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            if (aim_gbn == 'S' && dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_GBN") == 'L') {
                if (dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_AIM")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "BASIC_PAR")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "GAUGE_GB")      != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "AIM_LEVEL")     != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ADDING_PCT")    != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "TASK_CSF") != ""  ||
                    dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition, "ITEM_DEC")      != "" ) {
                    alert("�ش� �ʼ��Է��׸�[�ֿ������ǥ/��������ǥ/�跮����/��ǥ����/����ġ/���̵�/�����׸�] �Է� �� ���� �۾��� �����մϴ�.");
                }
                else {
                    alert("��ǥ�� ���� �Է��Ͻð� ����������ȹ�� �Է��Ͻñ� �ٶ��ϴ�.");
                }
            }
            else {

                alert("�ش� �ʼ��Է��׸�[�ֿ������ǥ/��������ǥ/�跮����/��ǥ����/����ġ/���̵�/�����׸�] �Է� �� ���� �۾��� �����մϴ�.");
            }
        }
        else {
            cfErrorMsg(this);
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnLoadCompleted(iCount)">

        var EVL_YY    = form1.txtEVL_YY_SHR.value;
        var EVL_FRQ   = form1.txtEVL_FRQ_SHR.value;
        var ENO_NO    = form1.txtENO_NO_SHR.value;
        var EVLENO_NO = form1.cmbEVLENO_NO_SHR.value;
        var AIM_YMD   = '';

        if (iCount > 0) {
            AIM_YMD = dsT_EV_AIMLST_ORG.NameValue(1, "AIM_YMD");
        }
        else {
            AIM_YMD = '1900-01-01';
        }

        // ������ǥ ��ȸ
        dsT_EV_AIMLST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO;
        dsT_EV_AIMLST.Reset();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST_ORG_02 Event="OnDataError()">

            cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

            dsT_EV_EVLIST_HD.ClearData();
            dsT_EV_EVLIST_DT.ClearData();
            dsT_EV_AIMLST.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value  = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtENO_NO_SHR.value   = '<%=box.get("SESSION_ENONO")%>';
            form1.txtENO_NM_SHR.value   = '<%=box.get("SESSION_ENONM")%>';
            form1.txtDPT_NM_SHR.value   = '<%=box.get("SESSION_DPTNM")%>';


            // �򰡴�������� ��ȸ
            dsT_EV_EVLIST_HD.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtENO_NO_SHR.value;
            dsT_EV_EVLIST_HD.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadCompleted(iCount)">

        if ( iCount == 0 )    {

            alert('�򰡴���ڰ� �ƴϹǷ� �Է� �Ұ��մϴ�.');
            document.getElementById("resultMessage").innerText = '* �򰡴���ڰ� �ƴϹǷ� �Է� �Ұ��մϴ�.';
            form1.grdT_EV_AIMLST.Editable = 'false';

            document.getElementById("btnINSLST").disabled = true;
            document.getElementById("btnDELLST").disabled = true;

            document.getElementById("image30").disabled   = true;

            document.getElementById("txtAIM_YMD").disabled    = true;
            document.getElementById("image20").disabled       = true;
            document.getElementById("txtMODIFY_DEC").disabled = true;

            dsT_EV_EVLIST_DT.ClearData();
            dsT_EV_AIMLST.ClearData();

        } else {

            // ��ܺ� ������ ��ȸ
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtENO_NO_SHR.value;
            dsT_EV_SCHCHG.Reset();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_HD Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        if ( iCount == 0 )    {

            OBJ_STDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_STDT");
            OBJ_ENDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "OBJ_STDT") == "") {

                OBJ_STDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_STDT");
                OBJ_ENDT = dsT_EV_ESTINFO.NameValue(1, "OBJ_ENDT");

            }
            else {

                OBJ_STDT = dsT_EV_SCHCHG.NameValue(1, "OBJ_STDT");
                OBJ_ENDT = dsT_EV_SCHCHG.NameValue(1, "OBJ_ENDT");
            }
        }

        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        ENO_NO  = form1.txtENO_NO_SHR.value;

        // ���ڸ� ��ȸ
        dsT_EV_EVLIST_DT.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc090.cmd.VLUC090CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO;
        dsT_EV_EVLIST_DT.Reset();

        // �������ڰ� ��ǥ�����Ⱓ������ ���̸� �޼��� �� �޼��� �Է°����ϵ��� ��
        if (OBJ_STDT <= getToday() && OBJ_ENDT >= getToday()) {

            form1.grdT_EV_AIMLST.Editable = 'true';

            document.getElementById("btnINSLST").disabled = false;
            document.getElementById("btnDELLST").disabled = false;


            fnc_SearchList();

        }
        else {

            // ��ǥ������ �Է±Ⱓ�� ������� �������� �Է°����ϹǷ�
            // �Ʒ� �κ��� ����...
            //alert('��ǥ�Է� �Ⱓ�� �ƴմϴ�.');
            //document.getElementById("resultMessage").innerText = '* ��ǥ�Է� �Ⱓ�� �ƴմϴ�.';
            //form1.grdT_EV_AIMLST.Editable = 'false';

            //document.getElementById("btnINSLST").disabled = true;
            //document.getElementById("btnDELLST").disabled = true;
            //document.getElementById("btnINSSUB").disabled = true;
            //document.getElementById("btnDELSUB").disabled = true;
            //document.getElementById("image30").disabled   = true;

            //document.getElementById("txtAIM_YMD").disabled    = true;
            //document.getElementById("image20").disabled       = true;
            //document.getElementById("txtMODIFY_DEC").disabled = true;

            fnc_SearchList();

        }


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        var oOption;

        if ( iCount != 0 )    {

            for(var i = 0 ; i < iCount ; i++) {

                oOption = document.createElement("OPTION");
                oOption.text  = dsT_EV_EVLIST_DT.NameValue(i + 1, "EVLENO_NM");
                oOption.value = dsT_EV_EVLIST_DT.NameValue(i + 1, "EVLENO_NO");

                document.getElementById("cmbEVLENO_NO_SHR").add(oOption);
            }

            //�ڱ��������������� ���������..
            if( '<%=MOD%>' == '1' ) {

                document.getElementById("cmbEVLENO_NO_SHR").value = "<%=ENO_NO%>";
                document.getElementById("cmbEVLENO_NO_SHR").readOnly = true;
            }
            else {
                document.getElementById("cmbEVLENO_NO_SHR")[0].selected = true;
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLIST_DT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- Ʈ������ ����. (����) -->
    <script for=trT_EV_AIMLST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_EV_AIMLST event="OnFail()">

        cfErrorMsg(this);

    </script>


    <script language="javascript"  for=dsT_EV_AIMLST event=OnRowPosChanged(Row)>

        fnc_DisableFld(Row);

     </script>


     <script language="javascript"  for=grdT_EV_AIMLST  event=OnColumnPosChanged(Row,Colid)>

        fnc_DisableFld(Row);

     </script>

    <!---------------------------------------------------------------------------------------------------+
    | �׸��忡�� ��ǥ �߰��� �̹� �Էµ� ������ üũ �Ǵ� ������ suppress�� �÷��� �����ϰ� �ϵ��� ��    |
    +---------------------------------------------------------------------------------------------------->
    <script language="javascript"  for=grdT_EV_AIMLST event=OnExit(row,colid,olddata)>

        if (dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {

            if (colid == 'TASK_AIM'      ||
                colid == 'BASIC_PAR'     ||
                colid == 'GAUGE_GB'      ||
                colid == 'AIM_LEVEL'     ||
                colid == 'ADDING_PCT'    ||
                colid == 'TASK_CSF') {

                for (var i = row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                        dsT_EV_AIMLST.NameValue(i, colid) = dsT_EV_AIMLST.NameValue(row, colid);
                    }
                    else {
                        break;
                    }
                }
            }
        }

        dsT_EV_AIMLST.RowPosition = row;

    </script>


    <!---------------------------------------------------------------------------------------------------+
    | �׸��忡�� ��ǥ �߰��� �̹� �Էµ� ������ üũ �Ǵ� ������ suppress�� �÷��� �����ϰ� �ϵ��� ��    |
    +---------------------------------------------------------------------------------------------------->
    <script language=JavaScript for=grdT_EV_AIMLST event=OnCloseUp(row,colid)>

        // �÷��� �޺��� ���
        if (dsT_EV_AIMLST.NameValue(row, "AIM_GBN") == 'L') {

            if (colid == 'TASK_AIM'      ||
                colid == 'BASIC_PAR'     ||
                colid == 'GAUGE_GB'      ||
                colid == 'AIM_LEVEL'     ||
                colid == 'ADDING_PCT'    ||
                colid == 'TASK_CSF') {

                for (var i = row + 1; i <= dsT_EV_AIMLST.CountRow; i++) {

                    if (dsT_EV_AIMLST.NameValue(i, "AIM_GBN") == 'S') {
                      dsT_EV_AIMLST.NameValue(i, colid) = dsT_EV_AIMLST.NameValue(row, colid);
                    }
                    else {
                        break;
                    }
                }
            }
        }

        dsT_EV_AIMLST.RowPosition = row;

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ǥ����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">��ǥ����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
                                <col width="80 "></col>
                                <col width="40 "></col>
                                <col width="40 "></col>
                                <col width="30 "></col>
                                <col width="40 "></col>
                                <col width="65 "></col>
                                <col width="120 "></col>
                                <col width="75 "></col>
                                <col width="40 "></col>
                                <col width="75 "></col>
                                <col width="65 "></col>
                                <col width="65 "></col>
                                <col width="10"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵ </td>
                                <td class="padding2423">
                                    <input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly valid='key=true' field='�ش�⵵'>
                                </td>
                                <td align="right" class="searchState">ȸ�� </td>
                                <td class="padding2423">
                                    <input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly valid='key=true' field='ȸ��'>
                                </td>
                                <td align="right" class="searchState">�Ҽ� </td>
                                <td class="padding2423">
                                    <input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">������ ��� </td>
                                <td class="padding2423">
                                    <input id=txtENO_NO_SHR size="10" class="input_ReadOnly" readonly valid='key=true' field='���'>
                                </td>
                                <td align="right" class="searchState">���� </td>
                                <td class="padding2423">
                                    <input id=txtENO_NM_SHR size="10" class="input_ReadOnly" readonly>
                                </td>

                                <td align="right" class="searchState">���� </td>
                                <td class="padding2423">
                                    <select id=cmbEVLENO_NO_SHR style="width:100" valid='key=true' field='����' onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    </select>
                                </td>
                                <td align="center" class="padding2423"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- power Search���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="800" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������ǥ </strong>
        </td>
    </tr>
</table>

<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_AIMLST_ORG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:219px;">
                            <param name="DataID"                    value="dsT_EV_AIMLST_ORG">
                            <param name="EdiTABLE"                  value="true">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                            <param name="IndWidth"                  value=0>
                            <param name="VIEWSUMMARY"               value=0>
                            <Param name="TranslateKeyDown"          value=1>
                            <param name="Format"                    value="
                                <FC> id='AIM_GBN'         width=40       name='��ǥ;����'        	  align=center    show=false        </FC>
                                <FC> id='EVL_YY'          width=40        name='�ش�⵵'         	  align=center    show=false        </FC>
                                <FC> id='EVL_FRQ'         width=40        name='��ȸ��'          	  align=center    show=false        </FC>
                                <FC> id='AIM_YMD'         width=40       name='��ǥ��������'     	  align=center    show=false        </FC>
                                <FC> id='ENO_NO'          width=40        name='�����ڻ��'     	  align=center    show=false        </FC>
                                <FC> id='EVLENO_NO'       width=40        name='���ڻ��'       	  align=center    show=false        </FC>
                                <FC> id='AIM_SEQ'         width=50        name='����'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='�ֿ� �ٽɰ���(����)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='�ٽɼ��� ���(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (�������)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='��ǥ (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='�跮;����'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:�跮,2:��跮'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='��ǥ���ο���'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='����'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='�ֿ������׸�'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='����ǥ(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%�̻�)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%�̸�)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%�̸�)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%�̸�)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%�̸�)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='����ñ�'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='����ġ;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='������û����'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>

                    ">
                </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop15" width="800" ><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������ǥ </strong>
        </td>
        <td>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="Image30" name="Image30" width="80" height="20" border="0" align="left" onClick="fnc_CopyGrid()"></a>
        </td>
 <!--         <td width="10%" align="right" valign="bottom">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="Image30" name="Image30" width="80" height="20" border="0" align="absmiddle" onClick="fnc_CopyGrid()"></a>
        </td>  -->
    </tr>
 </table>
 <table>
    <tr>
        <td width="800" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <colgroup>
                        <col width="60"></col>
                        <col width="100"></col>
                        <col width="60"></col>
                        <col width="*"></col>
                        <col width="113"></col>
                    </colgroup>
                    <td align="center" class="searchState">��������</td>
                    <td class="padding2423">
                        <input id=txtAIM_YMD size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAIM_YMD','','30','360');"></a>
                    </td>
                    <td align="center" class="searchState">��������</td>
                    <td class="padding2423">
                        <input id=txtMODIFY_DEC size="74" maxlength="100" >
                    </td>
                    <td class="searchState" align="center">
                        <font color="red">����ġ�հ�:</font><input type=text id=txtTOT_ADDING_PCT  name=txtTOT_ADDING_PCT size="3" style="text-align:left;font-weight:bold;" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <colgroup>
                        <col width=""></col>
                        <col width="100"></col>
                        <col width="83"></col>
                        <col width="112"></col>
                        <col width="103"></col>
                    </colgroup>
                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td align="right">
                        <img id="btnINSLST" width="80" height="20" src="/images/button/GoalAppend.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle" onclick="fnc_InsertAimLst();">
                    </td>
                    <td align="right">
                        <img id="btnDELLST" width="80" height="20" src="/images/button/GoalRemove.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_DeleteAimLst();">
                    </td>
                 <!--   <td align="right">
                        <img id="btnINSSUB" width="100" height="20" src="/images/button/SubAppend.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_InsertAimSub();">
                    </td>
                    <td align="right">
                        <img id="btnDELSUB" width="100" height="20" src="/images/button/SubRemove.gif" style="border:0px;padding:0 0 0 0;cursor:hand" align="absmiddle"  onclick="fnc_DeleteAimSub();">
                    </td> -->
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:219px;">
                            <param name="DataID"                    value="dsT_EV_AIMLST">
                            <param name="EdiTABLE"                  value="true">
                            <param name="DragDropEnable"            value="true">
                            <param name="SortView"                  value="Left">
                            <param name="ColSizing"                 value="true">
                            <param name="FixSizing"                 value="true">
                            <param name="IndWidth"                  value=0>
                            <param name="VIEWSUMMARY"               value=0>
                            <Param name="TranslateKeyDown"          value=1>
                            <param name="Format"                    value="
                                <FC> id='AIM_GBN'         width=40       name='��ǥ;����'        	  align=center    show=false        </FC>
                                <FC> id='EVL_YY'          width=40        name='�ش�⵵'         	  align=center    show=false        </FC>
                                <FC> id='EVL_FRQ'         width=40        name='��ȸ��'          	  align=center    show=false        </FC>
                                <FC> id='AIM_YMD'         width=40       name='��ǥ��������'     	  align=center    show=false        </FC>
                                <FC> id='ENO_NO'          width=40        name='�����ڻ��'     	  align=center    show=false        </FC>
                                <FC> id='EVLENO_NO'       width=40        name='���ڻ��'       	  align=center    show=false        </FC>
                                <FC> id='AIM_SEQ'         width=50        name='����'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='�ֿ� �ٽɰ���(����)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='�ٽɼ��� ���(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (�������)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='��ǥ (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='�跮;����'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:�跮,2:��跮'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='��ǥ���ο���'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='����'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='�ֿ������׸�'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='����ǥ(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%�̻�)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%�̸�)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%�̸�)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%�̸�)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%�̸�)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='����ñ�'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='����ġ;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='������û����'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>

                    ">
                </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <STRONG>�ݷ�����</STRONG>&nbsp;<input id=txtRETURN_DEC size="122" class="input_ReadOnly" readonly>
        </td>
    </tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

</body>
</html>
