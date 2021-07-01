<!--
    ************************************************************************************
    * @Source         : vlua060.jsp                                                    *
    * @Description    : ����������                                                   *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/20  |  ���뼺   | �����ۼ�                                               *
    * 2007/03/15  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>����������(vlua060)</title>
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

        var year = getToday().substring(0,4);
        var btnList = 'TTTTFFTT';
        var EVL_FRQ = '';        //ȸ��

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            //�����ͼ� ����
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY_ST="+document.getElementById("cmbEVL_YY_ST_SHR").value+"&EVL_YY_EN="+document.getElementById("cmbEVL_YY_EN_SHR").value;
            dsT_EV_ESTINFO.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�����ͼ� ����(�򰡱����������� ��ȸ)
            dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY").value;
            dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //Ʈ����� ����
            trT_EV_ESTINFO.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SAV";
            trT_EV_ESTINFO.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            fnc_Remove();

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_ESTINFO.CountColumn == 0) {
                dsT_EV_ESTINFO.setDataHeader("GUBUN:STRING,EVL_YY:STRING:KEYVALUETYPE, EVL_GBN:STRING:KEYVALUETYPE, EVL_FRQ:INT:KEYVALUETYPE, EVL_NM:STRING, EVL_STDT:STRING, EVL_ENDT:STRING, IPT_STDT:STRING, IPT_ENDT:STRING, PROT_STDT:STRING, PROT_ENDT:STRING, OBJ_STDT:STRING, OBJ_ENDT:STRING, SELF_STDT:STRING, SELF_ENDT:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_ESTINFO.AddRow();

            fnc_ColEnabled('E');

            //ȸ�� �޺��ʱ�ȭ
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);

            }

            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
            form1.grdT_EV_ESTINFO.Focus();

            form1.txtGUBUN.value = GUBUN;
            form1.cmbEVL_YY[0].selected = true;
            form1.cmbEVL_GBN.disabled=false;
            form1.cmbEVL_FRQ.disabled=false;

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //Row���°�
            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_ESTINFO.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

            if (document.form1.cmbEVL_YY.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� ���� �� �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.grdT_EV_ESTINFO.focus();
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_ESTINFO.NameValue(dsT_EV_ESTINFO.RowPosition,"EVL_NM") + "] �ڷḦ ���� �Ͻðڽ��ϱ�?") == false) return;

            status = dsT_EV_ESTINFO.RowStatus(dsT_EV_ESTINFO.RowPosition);
            dsT_EV_ESTINFO.DeleteRow(dsT_EV_ESTINFO.RowPosition);

            if( status != 1 ) {
                //Ʈ����� ����
                trT_EV_ESTINFO.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=DEL";
                trT_EV_ESTINFO.Post();
            }

            // ���� �� �ش� �׸���� Focus �̵�
            form1.grdT_EV_ESTINFO.SetColumn(form1.grdT_EV_ESTINFO.GetColumnID(8));
            form1.grdT_EV_ESTINFO.Focus();

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbEVL_YY")[0].selected = true;
            document.getElementById("cmbEVL_GBN").value      = '';
            document.getElementById("cmbEVL_FRQ").value      = '';
            document.getElementById("txtEVL_NM").value       = '';
            document.getElementById("txtEVL_STDT").value     = '';
            document.getElementById("txtEVL_ENDT").value     = '';
            document.getElementById("txtIPT_STDT").value     = '';
            document.getElementById("txtIPT_ENDT").value     = '';
            document.getElementById("txtPROT_STDT").value    = '';
            document.getElementById("txtPROT_ENDT").value    = '';
            document.getElementById("txtOBJ_STDT").value     = '';
            document.getElementById("txtOBJ_ENDT").value     = '';
            document.getElementById("txtSELF_STDT").value    = '';
            document.getElementById("txtSELF_ENDT").value    = '';

            document.getElementById("cmbEVL_YY_ST_SHR")[4].selected = true;
            document.getElementById("cmbEVL_YY_EN_SHR")[4].selected = true;

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_ESTINFO.ClearAll();

            form1.cmbEVL_GBN.disabled=false;
            form1.cmbEVL_FRQ.disabled=false;

            form1.txtOBJ_STDT.disabled=false;
            document.getElementById("txtOBJ_STDT").style.backgroundColor = 'FFFFFF';
            form1.txtOBJ_ENDT.disabled=false;
            document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'FFFFFF';
            form1.txtSELF_STDT.disabled=false;
            document.getElementById("txtSELF_STDT").style.backgroundColor = 'FFFFFF';
            form1.txtSELF_ENDT.disabled=false;
            document.getElementById("txtSELF_ENDT").style.backgroundColor = 'FFFFFF';

            fnc_ColEnabled('D');

            document.getElementById("image26").disabled = false;
            document.getElementById("image27").disabled = false;
            document.getElementById("image28").disabled = false;
            document.getElementById("image29").disabled = false;

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_ESTINFO.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( !cfCheckYearTerm('cmbEVL_YY_ST_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR') ) {
                return false;
            }
            else {
                return true;
            }

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if ( dsT_EV_ESTINFO.isUpdated ) {
                for( i=1; i<=dsT_EV_ESTINFO.CountRow; i++ ) {
                    if( dsT_EV_ESTINFO.RowStatus(i) == 1 || dsT_EV_ESTINFO.RowStatus(i) == 2 || dsT_EV_ESTINFO.RowStatus(i) == 3 ) {

                        if (dsT_EV_ESTINFO.RowStatus(i) == 1) {
                            for (var j = 1; j<=dsT_EV_ESTINFO.CountRow; j++) {
                                if (i != j &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_YY") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_YY") &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_GBN") &&
                                    dsT_EV_ESTINFO.NameValue(i, "EVL_FRQ") ==  dsT_EV_ESTINFO.NameValue(j, "EVL_FRQ") )  {

                                    alert("�ش�����/����/ȸ���� ������ �����Ͱ� �����մϴ�.");
                                    dsT_EV_ESTINFO.RowPosition = i;
                                    form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                                    form1.grdT_EV_ESTINFO.focus();
                                    return false;
                                }
                            }
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_YY") != year ) {
                            alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                            fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_YY") == '' ) {
                            alert("�ش�⵵�� �ʼ��Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_YY");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") == '' ) {
                            alert("������ �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_GBN");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }
                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_FRQ") == '' ) {
                            alert("ȸ���� �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_FRQ");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_NM") == '' ) {
                            alert("�򰡸�Ī�� �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_NM");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "EVL_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "EVL_ENDT") == '' ) {
                            alert("������Ⱓ�� �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "EVL_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "EVL_ENDT")) == false ) {
                            alert("������Ⱓ�� ��¥���Ŀ� �����ʽ��ϴ�.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("EVL_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "IPT_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "IPT_ENDT") == '' ) {
                            alert("���Է±Ⱓ�� �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("IPT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "IPT_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "IPT_ENDT")) == false ) {
                            alert("���Է±Ⱓ�� ��¥���Ŀ� �����ʽ��ϴ�.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("IPT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( dsT_EV_ESTINFO.NameValue(i, "PROT_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "PROT_ENDT") == '' ) {
                            alert("���ǽ�û�Ⱓ�� �ʼ� �Է»����Դϴ�..");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("PROT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "PROT_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "PROT_ENDT")) == false ) {
                            alert("���ǽ�û�Ⱓ�� ��¥���Ŀ� �����ʽ��ϴ�.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("PROT_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( (dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT")) == false)  || (dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT")) == false) ) {
                            alert("��ǥ�Է±Ⱓ�� ��¥���Ŀ� �����ʽ��ϴ�.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("OBJ_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        if( (dsT_EV_ESTINFO.NameValue(i, "SELF_STDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_STDT")) == false)  || (dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT") != '' && cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT")) == false) ) {
                            alert("�����򰡱Ⱓ�� ��¥���Ŀ� �����ʽ��ϴ�.");
                            dsT_EV_ESTINFO.RowPosition = i;
                            form1.grdT_EV_ESTINFO.SetColumn("SELF_STDT");
                            form1.grdT_EV_ESTINFO.focus();
                            return false;
                        }

                        //�������� ��� ��ǥ�Է±Ⱓ/�����򰡱Ⱓ �ʼ��Է� üũ  Modified by DS
                        if(dsT_EV_ESTINFO.NameValue(i, "EVL_GBN") == "2"){
                            if(dsT_EV_ESTINFO.NameValue(i, "OBJ_STDT") == '' || dsT_EV_ESTINFO.NameValue(i, "OBJ_ENDT") == ''){
                                alert("��ǥ�Է±Ⱓ�� �ʼ� �Է»����Դϴ�.");
                                dsT_EV_ESTINFO.RowPosition = i;
                                form1.grdT_EV_ESTINFO.SetColumn("OBJ_STDT");
                                form1.grdT_EV_ESTINFO.focus();
                                return false;
                            }

                            if( cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_STDT")) == false  || cfDateExpr(dsT_EV_ESTINFO.NameValue(i, "SELF_ENDT")) == false ) {
                                alert("�����򰡱Ⱓ�� �ʼ� �Է»����Դϴ�.");
                                dsT_EV_ESTINFO.RowPosition = i;
                                form1.grdT_EV_ESTINFO.SetColumn("SELF_STDT");
                                form1.grdT_EV_ESTINFO.focus();
                                return false;
                            }
                        }
                    }
                }
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

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ESTINFO, 15, "false", "false");

            getSelYy2('cmbEVL_YY');
            form1.cmbEVL_YY.disabled=true;
            getSelYy2('cmbEVL_YY_ST_SHR');
            getSelYy2('cmbEVL_YY_EN_SHR');

            // ��������
            if (frameid == "vlua060") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            fnc_ColEnabled('D');

            document.getElementById("cmbEVL_YY_ST_SHR").focus();//set focus

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /****************************************************
         * 15. �򰡱���(����,����)�� ���� ��ǥ�Է±Ⱓ,        *
         *        �����򰡱Ⱓ�� �Է� disable,                *
         *         �׸��� show ���θ� ���� ó�� �κ�              *
         ***************************************************/
        function fnc_EvlGbnSet() {

            //�򰡱���(����,����)�� ���� ��ǥ�Է±Ⱓ, �����򰡱Ⱓ�� �Է� disable
            if( form1.cmbEVL_GBN.value == '1'  || form1.cmbEVL_GBN.value == '3' ) {    //����

                form1.txtOBJ_STDT.value='';
                form1.txtOBJ_ENDT.value='';
                form1.txtSELF_STDT.value='';
                form1.txtSELF_ENDT.value='';

                form1.txtOBJ_STDT.disabled=true;
                document.getElementById("txtOBJ_STDT").style.backgroundColor = 'EEEEEE';
                form1.txtOBJ_ENDT.disabled=true;
                document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'EEEEEE';
                form1.txtSELF_STDT.disabled=true;
                document.getElementById("txtSELF_STDT").style.backgroundColor = 'EEEEEE';
                form1.txtSELF_ENDT.disabled=true;
                document.getElementById("txtSELF_ENDT").style.backgroundColor = 'EEEEEE';

                document.getElementById("image26").disabled=true;
                document.getElementById("image27").disabled=true;
                document.getElementById("image28").disabled=true;
                document.getElementById("image29").disabled=true;

            } else if( form1.cmbEVL_GBN.value == '2') {

                form1.txtOBJ_STDT.disabled=false;
                document.getElementById("txtOBJ_STDT").style.backgroundColor = 'FFFFFF';
                form1.txtOBJ_ENDT.disabled=false;
                document.getElementById("txtOBJ_ENDT").style.backgroundColor = 'FFFFFF';
                form1.txtSELF_STDT.disabled=false;
                document.getElementById("txtSELF_STDT").style.backgroundColor = 'FFFFFF';
                form1.txtSELF_ENDT.disabled=false;
                document.getElementById("txtSELF_ENDT").style.backgroundColor = 'FFFFFF';

                document.getElementById("image26").disabled=false;
                document.getElementById("image27").disabled=false;
                document.getElementById("image28").disabled=false;
                document.getElementById("image29").disabled=false;

            }

        }

        /********************
         * 16. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {
            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {
                form1.cmbEVL_GBN.disabled    = false;
                form1.cmbEVL_FRQ.disabled    = false;
                form1.txtEVL_NM.disabled     = false;
                form1.txtEVL_STDT.disabled   = false;
                form1.txtEVL_ENDT.disabled   = false;
                form1.txtIPT_STDT.disabled   = false;
                form1.txtIPT_ENDT.disabled   = false;
                form1.txtPROT_STDT.disabled  = false;
                form1.txtPROT_ENDT.disabled  = false;
                form1.txtOBJ_STDT.disabled   = false;
                form1.txtOBJ_ENDT.disabled   = false;
                form1.txtSELF_STDT.disabled  = false;
                form1.txtSELF_ENDT.disabled  = false;

                document.getElementById("image20").disabled = false;
                document.getElementById("image21").disabled = false;
                document.getElementById("image22").disabled = false;
                document.getElementById("image23").disabled = false;
                document.getElementById("image24").disabled = false;
                document.getElementById("image25").disabled = false;
                document.getElementById("image26").disabled = false;
                document.getElementById("image27").disabled = false;
                document.getElementById("image28").disabled = false;
                document.getElementById("image29").disabled = false;
            }
            // �ش� �÷��� �Ӽ��� Disabled�� ����
            else if (prop == 'D') {
                form1.cmbEVL_GBN.disabled    = true;
                form1.cmbEVL_FRQ.disabled    = true;
                form1.txtEVL_NM.disabled     = true;
                form1.txtEVL_STDT.disabled   = true;
                form1.txtEVL_ENDT.disabled   = true;
                form1.txtIPT_STDT.disabled   = true;
                form1.txtIPT_ENDT.disabled   = true;
                form1.txtPROT_STDT.disabled  = true;
                form1.txtPROT_ENDT.disabled  = true;
                form1.txtOBJ_STDT.disabled   = true;
                form1.txtOBJ_ENDT.disabled   = true;
                form1.txtSELF_STDT.disabled  = true;
                form1.txtSELF_ENDT.disabled  = true;

                document.getElementById("image20").disabled = true;
                document.getElementById("image21").disabled = true;
                document.getElementById("image22").disabled = true;
                document.getElementById("image23").disabled = true;
                document.getElementById("image24").disabled = true;
                document.getElementById("image25").disabled = true;
                document.getElementById("image26").disabled = true;
                document.getElementById("image27").disabled = true;
                document.getElementById("image28").disabled = true;
                document.getElementById("image29").disabled = true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID ="trT_EV_ESTINFO" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_ESTINFO)">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script language="javascript"  for=grdT_EV_ESTINFO event=OnClick(row,colid)>

        if (dsT_EV_ESTINFO.ErrorCode == 50018) {
            return;
        }

        if( row > 0 ) {
            EVL_FRQ = dsT_EV_ESTINFO.NameValue(row,"EVL_FRQ");

            //�ش�⵵,����,ȸ���� ���� Ű ���� �Ұ�ó��
            if( dsT_EV_ESTINFO.RowStatus(row) == 0 ) {

                var oOption;
                //ȸ���޺� ����
                for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                    document.getElementById("cmbEVL_FRQ").remove(0);
                    document.getElementById("cmbEVL_FRQ").remove(1);
                }
                oOption = document.createElement("OPTION");
                oOption.value = EVL_FRQ;
                oOption.text = EVL_FRQ;
                document.getElementById("cmbEVL_FRQ").add(oOption);
                dsT_EV_ESTINFO.NameValue(row,"EVL_FRQ")=EVL_FRQ;

                form1.cmbEVL_YY.disabled=true;
                form1.cmbEVL_GBN.disabled=true;
                form1.cmbEVL_FRQ.disabled=true;

                EVL_FRQ = '';    //EVL_FRQ �ʱ�ȭ
            } else {

                //ȸ���޺� ����
                fnc_SearchItem();

                form1.cmbEVL_GBN.disabled=false;
                form1.cmbEVL_FRQ.disabled=false;

            }

            //�򰡱���(����,����)�� ���� ��ǥ�Է±Ⱓ, �����򰡱Ⱓ�� �Է� disable
            fnc_EvlGbnSet();

            grdT_EV_ESTINFO.SetColumn("colid");
        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

            fnc_ColEnabled('D');

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ESTINFO.CountRow);

            EVL_FRQ = dsT_EV_ESTINFO.NameValue(dsT_EV_ESTINFO.RowPosition,"EVL_FRQ");
            //�ش�⵵,����,ȸ���� ���� Ű ���� �Ұ�ó��
            if( dsT_EV_ESTINFO.RowStatus(dsT_EV_ESTINFO.RowPosition) == 0 ) {
                var oOption;
                //ȸ���޺� ����
                for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                    document.getElementById("cmbEVL_FRQ").remove(0);
                    document.getElementById("cmbEVL_FRQ").remove(1);
                }
                oOption = document.createElement("OPTION");
                oOption.value = EVL_FRQ;
                oOption.text = EVL_FRQ;
                document.getElementById("cmbEVL_FRQ").add(oOption);

                fnc_ColEnabled('E');

                //�ش�⵵,����,ȸ���� ���� Ű ���� �Ұ�ó��
                form1.cmbEVL_YY.disabled=true;
                form1.cmbEVL_GBN.disabled=true;
                form1.cmbEVL_FRQ.disabled=true;

                EVL_FRQ = '';    //EVL_FRQ �ʱ�ȭ
            }

        }

        grdT_EV_ESTINFO.SetColumn("ABL_CD");//set focus
        fnc_EvlGbnSet();

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //ȸ���޺� ��λ���
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);
            }

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            var oOption;
            //ȸ���޺� ��λ���
            for( i=0; i<=document.getElementById("cmbEVL_GBN").length; i++ ) {
                document.getElementById("cmbEVL_FRQ").remove(0);
                document.getElementById("cmbEVL_FRQ").remove(1);
            }

            if( document.getElementById("cmbEVL_GBN").value == '1' ) {        //����
                for( i=1; i<=Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {        //������ȸ��
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            if( document.getElementById("cmbEVL_GBN").value == '2' ) {        //����
                for( i=1; i<=dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i++ ) {        //������ȸ��
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            if( document.getElementById("cmbEVL_GBN").value == '3' ) {        //����
                for( i=1; i<=1; i++ ) {        //������ȸ��
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text = i;
                    document.getElementById("cmbEVL_FRQ").add(oOption);
                }
            }
            //�ű��ڷ� OnClick�� ȸ�� ����
            if( EVL_FRQ != '' ) {
                document.getElementById("cmbEVL_FRQ")[eval(EVL_FRQ-1)].selected = true;
            }

            EVL_FRQ = '';    //EVL_FRQ �ʱ�ȭ
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�ش�⵵/����/ȸ��] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�ش�⵵/����/ȸ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }


    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ESTINFO event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ESTINFO event="OnFail()">

        document.getElementById("resultMessage").innerText = ' ';
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">����������</td>
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
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <tr>
                                    <td align="right" width="1"></td>
                                    <td align="center" class="searchState">�ش�⵵</td>
                                    <td><select id=cmbEVL_YY_ST_SHR name=cmbEVL_YY_ST_SHR onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="if(!cfCheckYearTerm('cmbEVL_YY_ST_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR')) return; fnc_SearchList();"><select> �� ~
                                        <select id=cmbEVL_YY_EN_SHR name=cmbEVL_YY_EN_SHR onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="if(!cfCheckYearTerm('cmbEVL_YY_EN_SHR','cmbEVL_YY_ST_SHR','cmbEVL_YY_EN_SHR')) return; fnc_SearchList();"><select> ��</td>
                                    <td align="left" width="500"></td>
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
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                        <col width="133"></col>
                    </colgroup>
                    <tr>
                        <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                        <td align="center" class="creamBold">�ش�⵵</td>
                        <td class="padding2423"><select id=cmbEVL_YY  onChange="fnc_SearchItem();"><select></td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <select id="cmbEVL_GBN" style="WIDTH: 100%" onChange="fnc_EvlGbnSet();fnc_SearchItem();">
                                <option value="1">����</option>
                                <option value="2">����</option>
                                <option value="3">����</option>
                            </select> </td>
                        <td align="center" class="creamBold">ȸ��</td>
                        <td class="padding2423">
                            <select id="cmbEVL_FRQ" style="WIDTH: 100%">
                                <option value="1">��ݱ�</option>
                                <option value="2">�Ϲݱ�</option>                       
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��Ī</td>
                        <td class="padding2423" colspan="2"><input id=txtEVL_NM style="WIDTH: 100%" onBlur="cfCheckLength('txtEVL_NM','��Ī','100');"></td>
                        <td align="center" class="creamBold">������Ⱓ</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtEVL_STDT" name="txtEVL_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }  cfCheckDateTerm('txtEVL_STDT','txtEVL_STDT','txtEVL_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image20" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEVL_STDT','','500','125');"></a>
                            ~
                            <input id="txtEVL_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEVL_ENDT','txtEVL_STDT','txtEVL_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image21" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEVL_ENDT','','615','125');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">���Է±Ⱓ</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtIPT_STDT" style="ime-mode:disabled"  size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtIPT_STDT','txtIPT_STDT','txtIPT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image22','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image22" name="Image22" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtIPT_STDT','','95','150');"></a>
                            ~
                            <input id="txtIPT_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtIPT_ENDT','txtIPT_STDT','txtIPT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image23','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image23" name="Image23" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtIPT_ENDT','','210','150');"></a>
                        </td>
                        <td align="center" class="creamBold">���ǽ�û�Ⱓ</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtPROT_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtPROT_STDT','txtPROT_STDT','txtPROT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image24','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image24" name="Image24" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPROT_STDT','','500','150');"></a>
                            ~
                            <input id="txtPROT_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtPROT_ENDT','txtPROT_STDT','txtPROT_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image25','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOver.gif" id="Image25" name="Image25" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPROT_ENDT','','615','150');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��ǥ�Է±Ⱓ</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtOBJ_STDT" name="txtOBJ_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtOBJ_STDT','txtOBJ_STDT','txtOBJ_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image26','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image26" name="Image26" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtOBJ_STDT','','95','175');"></a>
                            ~
                            <input id="txtOBJ_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtOBJ_ENDT','txtOBJ_STDT','txtOBJ_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image27','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image27" name="Image27" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtOBJ_ENDT','','210','175');"></a>
                        </td>
                        <td align="center" class="creamBold">�����򰡱Ⱓ</td>
                        <td class="padding2423" colspan="2">
                            <input id="txtSELF_STDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSELF_STDT','txtSELF_STDT','txtSELF_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image28','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image28" name="Image28" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSELF_STDT','','500','175');"></a>
                            ~
                            <input id="txtSELF_ENDT" style="ime-mode:disabled" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSELF_ENDT','txtSELF_STDT','txtSELF_ENDT'); cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image29','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOver.gif" id="Image29" name="Image29 " width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSELF_ENDT','','615','175');"></a>
                        </td>
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
                        <td align="right">&nbsp;</td>
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
                            <object    id="grdT_EV_ESTINFO" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:240px;">
                                <param name="DataID"                     value="dsT_EV_ESTINFO">
                                <param name="EdiTABLE"                   value="false">
                                <param name="DragDropEnable"             value="true">
                                <param name="SortView"                   value="Left">
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="FixSizing"                  value="true">
                                <param name="AutoReSizing"               value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                     value="
                                    <FC> id='EVL_YY'        width=60     name='�ش�⵵'   align=center    edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_GBN'       width=40     name='����'       align=center    editstyle=combo data='1:����,2:����,3:����'  edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_FRQ'       width=40     name='ȸ��'       align=center    editstyle=combo data='1:1,2:2,3:3'    edit={IF(Status='N',none,'')} </FC>
                                    <FC> id='EVL_NM'        width=100    name='��Ī'       align=left      editlimit=100 </FC>
                                    <G> name='������Ⱓ' HeadBgColor='#F7DCBB'
                                        <C> id='EVL_STDT'   width=70     name='������'     align=center    editlimit=10 </C>
                                        <C> id='EVL_ENDT'   width=70     name='������'     align=center    editlimit=10  </C>
                                    </G>
                                    <G> name='���Է±Ⱓ' HeadBgColor='#F7DCBB'
                                        <C> id='IPT_STDT'   width=70     name='������'     align=center    editlimit=10 </C>
                                        <C> id='IPT_ENDT'   width=70     name='������'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='���ǽ�û�Ⱓ' HeadBgColor='#F7DCBB'
                                        <C> id='PROT_STDT'  width=70     name='������'     align=center    editlimit=10 </C>
                                        <C> id='PROT_ENDT'  width=70     name='������'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='��ǥ�Է±Ⱓ' HeadBgColor='#F7DCBB'
                                        <C> id='OBJ_STDT'   width=70     name='������'     align=center    editlimit=10 </C>
                                        <C> id='OBJ_ENDT'   width=70     name='������'     align=center    editlimit=10 </C>
                                    </G>
                                    <G> name='�����򰡱Ⱓ' HeadBgColor='#F7DCBB'
                                        <C> id='SELF_STDT'  width=70     name='������'     align=center    editlimit=10 </C>
                                        <C> id='SELF_ENDT'  width=70     name='������'     align=center    editlimit=10 </C>
                                    </G>
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
    <!-- KPI Pool ���� ���̺� -->
    <comment id="__NSID__">
    <object id="bndT_EV_ESTINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",    Value="dsT_EV_ESTINFO">
        <Param Name="ActiveBind" Value=true>
        <Param Name="BindInfo",  Value='
            <C>Col=GUBUN         Ctrl=txtGUBUN       Param=value</C>
            <C>Col=EVL_YY        Ctrl=cmbEVL_YY      Param=value</C>
            <C>Col=EVL_GBN       Ctrl=cmbEVL_GBN     Param=value</C>
            <C>Col=EVL_FRQ       Ctrl=cmbEVL_FRQ     Param=value</C>
            <C>Col=EVL_NM        Ctrl=txtEVL_NM      Param=value</C>
            <C>Col=EVL_STDT      Ctrl=txtEVL_STDT    Param=value</C>
            <C>Col=EVL_ENDT      Ctrl=txtEVL_ENDT    Param=value</C>
            <C>Col=IPT_STDT      Ctrl=txtIPT_STDT    Param=value</C>
            <C>Col=IPT_ENDT      Ctrl=txtIPT_ENDT    Param=value</C>
            <C>Col=PROT_STDT     Ctrl=txtPROT_STDT   Param=value</C>
            <C>Col=PROT_ENDT     Ctrl=txtPROT_ENDT   Param=value</C>
            <C>Col=OBJ_STDT      Ctrl=txtOBJ_STDT    Param=value</C>
            <C>Col=OBJ_ENDT      Ctrl=txtOBJ_ENDT    Param=value</C>
            <C>Col=SELF_STDT     Ctrl=txtSELF_STDT   Param=value</C>
            <C>Col=SELF_ENDT     Ctrl=txtSELF_ENDT   Param=value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

