<!--
*****************************************************
* @source       : vluc200.jsp
* @description : ���ǽ�û(����)_���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/10/10      ���뼺        �����ۼ�.
* 2007/03/18      ������        ����. (�����򰡾������� �߰�)
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ǽ�û(����)_����(vluc200)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN      = request.getParameter("GUBUN");          //��������
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFTT';
        //�������±���
        var stateDiv='';
        var flag= false;        //���ǽ�û �Ⱓüũ
        var file_flag = '0';    //1:���ϻ�����

        //���â���� ����� ��� �����ϱ� ���� ��� by DS
        var modal_yn = window.dialogArguments;

        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����(���ǽ�û(����)_����)
            dsT_EV_PROTEST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_PROTEST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem(searchDiv) {

            if( searchDiv == '1') {
                 //���� ������Ⱓ�� �ش��ϴ� �⵵,ȸ�� ����
                dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=3";
                dsT_EV_ESTINFO.Reset();
            }

            if( searchDiv == '2') {
                //���ǽ�û�Ⱓ ���� üũ
                dsT_EV_ESTINFO_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub080.cmd.VLUB080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value;
                dsT_EV_ESTINFO_01.Reset();
            }

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //Ʈ����� ����
            trT_EV_PROTEST.Value="SVL(I:SAV=dsT_EV_PROTEST, I:FILE=oFileListGDS, O:RELOAD=dsT_EV_PROTEST2)";
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SAV&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&FLAG="+file_flag;
            trT_EV_PROTEST.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if ( dsT_EV_PROTEST.CountRow  < 1 || dsT_EV_PROTEST.RowStatus(dsT_EV_PROTEST.RowPosition) == 1 ) {
                   fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }

            if( !fnc_DeleteEnableCheck() ) {
                alert("������ �ڷ��̹Ƿ� �����Ҽ� �����ϴ�.")
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_PROTEST.ColumnString(1,6) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_EV_PROTEST.DeleteRow(1);

            stateDiv = 'delete';
            //Ʈ����� ����
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc200.cmd.VLUC200CMD&S_MODE=SAV";
            trT_EV_PROTEST.Post();

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
            if (dsT_EV_PROTEST.CountColumn == 0) {
                dsT_EV_PROTEST.setDataHeader("GUBUN:STRING, EVL_YY:STRING, EVL_GBN:STRING, EVL_FRQ:INT, ENO_NO:STRING, PROTEST_YMD:STRING, PROTEST_TIT:STRING, PROTEST_DEC:STRING, ACCEPT_GBN:STRING");
            }

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_PROTEST.AddRow();

            dsT_EV_PROTEST.NameValue(1,"GUBUN") =  GUBUN;
            dsT_EV_PROTEST.NameValue(1,"EVL_YY") = document.getElementById("txtEVL_YY_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"EVL_GBN") = document.getElementById("txtEVL_GBN_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"EVL_FRQ") = document.getElementById("txtEVL_FRQ_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO_SHR").value;
            dsT_EV_PROTEST.NameValue(1,"ACCEPT_GBN") = 'N';

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

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(modal_yn != null){
                window.close();
            } else {
                frame = window.external.GetFrame(window);
                frame.CloseFrame();
            }

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( dsT_EV_PROTEST.isUpdated ) {
                if( form1.txtEVL_YY_SHR.value == '') {
                    alert("�ش�⵵�� �ʼ��Է»����Դϴ�.");
                    form1.txtEVL_YY_SHR.focus();
                    return false;
                }
                if( form1.txtEVL_FRQ_SHR.value == '') {
                    alert("ȸ���� �ʼ��Է»����Դϴ�.");
                    form1.txtEVL_FRQ_SHR.focus();
                    return false;
                }
                if( form1.txtENO_NO_SHR.value == '') {
                    alert("����� �ʼ��Է»����Դϴ�.");
                    form1.txtENO_NO_SHR.focus();
                    return false;
                }
                if( form1.txtPROTEST_YMD.value == '') {
                    alert("���ڴ� �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( (form1.txtPROTEST_YMD.value != '' && cfDateExpr(form1.txtPROTEST_YMD.value) == false) ) {
                    alert("���ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( form1.txtPROTEST_TIT.value == '') {
                    alert("������ �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_TIT.focus();
                    return false;
                }
                if( form1.txtPROTEST_DEC.value == '') {
                    alert("������ �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_DEC.focus();
                    return false;
                }
                //��ȿ�� üũ
                if( !valid() ) return;
            } else {
                fnc_Message(document.getElementById("resultMessage"),"MSG_04");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return false;
            }
            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
            if( dsT_EV_PROTEST.isUpdated ) {
                if( form1.txtEVL_YY_SHR.value == '') {
                    alert("�ش�⵵�� �ʼ��Է»����Դϴ�.");
                    form1.txtEVL_YY_SHR.focus();
                    return false;
                }
                if( form1.txtEVL_FRQ_SHR.value == '') {
                    alert("ȸ���� �ʼ��Է»����Դϴ�.");
                    form1.txtEVL_FRQ_SHR.focus();
                    return false;
                }
                if( form1.txtENO_NO_SHR.value == '') {
                    alert("����� �ʼ��Է»����Դϴ�.");
                    form1.txtENO_NO_SHR.focus();
                    return false;
                }
                if( form1.txtPROTEST_YMD.value == '') {
                    alert("���ڴ� �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( (form1.txtPROTEST_YMD.value != '' && cfDateExpr(form1.txtPROTEST_YMD.value) == false) ) {
                    alert("���ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                    form1.txtPROTEST_YMD.focus();
                    return false;
                }
                if( form1.txtPROTEST_TIT.value == '') {
                    alert("������ �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_TIT.focus();
                    return false;
                }
                if( form1.txtPROTEST_DEC.value == '') {
                    alert("������ �ʼ��Է»����Դϴ�.");
                    form1.txtPROTEST_DEC.focus();
                    return false;
                }
                //��ȿ�� üũ
                if( !valid(form1) ) return;
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
            // ���� ÷�ο� �����ͼ��� ��� ���� ����.
            oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

            if (modal_yn == null) {
                var frameid = window.external.GetFrame(window).FrameId;
            }

            // ��������
            if (frameid == "vlug200" || "<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            //���� ������Ⱓ�� �ش��ϴ� �⵵,ȸ�� ����
            fnc_SearchItem('1');
            //���ǽ�û���� ����
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. �������� ���� (��������) �κ�  *
         *******************************************/
        function fnc_DeleteEnableCheck() {

            if( dsT_EV_PROTEST.NameValue(1,"ACCEPT_GBN") == 'N' ) {
                return true;
            } else {
                document.getElementById("txtPROTEST_YMD").readOnly=true;
                document.getElementById("txtPROTEST_TIT").readOnly=true;
                document.getElementById("txtPROTEST_DEC").readOnly=true;
                return false;
            }
               form1.txtPROTEST_TIT.focus();//set focus
        }

        /********************************************
         * 16. ���ǿ� ���� ���ǽ�û(����)_������ enable/disable ó��    *
         *******************************************/
        function fnc_DisableSet() {

            document.getElementById("image1").disabled='disabled';
            document.getElementById("image2").disabled='disabled';
            document.getElementById("txtPROTEST_TIT").readOnly=true;
            document.getElementById("txtPROTEST_TIT").style.backgroundColor = 'EEEEEE';
            document.getElementById("txtPROTEST_DEC").readOnly=true;
            document.getElementById("txtPROTEST_DEC").style.backgroundColor = 'EEEEEE';

        }

        /********************
         * 17. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************
         * ÷������ ó��    *
         *******************/
        function fnc_FileUpload() {

            oFileListGDS.addrow();
            oFileListGDS.NameValue(oFileListGDS.RowPosition, "ENO_NO") = form1.txtENO_NO_SHR.value;

            oFileGF.OpenFileName = form1.txtFILE_NAME.value;

            oFileGF.open();

            if(oFileGF.SelectState == true)
            {
                form1.txtFILE_NAME.value = oFileGF.value;
                form1.txtFILE_URL2.value = '';
            }
            else {
                oFileListGDS.deleterow(oFileListGDS.RowPosition);
            }

        }

        /********************
         * ÷������ ����    *
         *******************/
        function fnc_FileDelete() {
            // ������ ����� ���ϰ�ο� ȭ�鿡�� ����ϴ� �ӽ����ϰ�ΰ� ������ ���������ϰ� �Ѵ�.
            if (form1.txtFILE_URL.value != "" && form1.txtFILE_URL.value == form1.txtFILE_URL2.value) {

                file_flag = '1';

                form1.txtFILE_NAME.value = "";

                fnc_Save();
            }
            else {
                if (form1.txtFILE_NAME.value != "") {
                    form1.txtFILE_NAME.value = "";
                    form1.txtFILE_URL.value = "";
                    form1.txtFILE_URL2.value = "";
                }
                else {
                    alert("������ ������ �������� �ʽ��ϴ�.");
                }
            }
        }

        function fnc_link() {
            if (dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME") != "" && form1.txtFILE_URL2.value != "") {    // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
                cfDownload(dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME"), form1.txtFILE_URL2.value);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

     <Object ID="dsT_EV_ESTINFO_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- Reload�� �����ͼ� -->
    <Object ID="dsT_EV_PROTEST2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_PROTEST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_PROTEST, I:FILE=oFileListGDS, O:RELOAD=dsT_EV_PROTEST2)">
    </Object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="oFileListGDS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=oFileGF classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"        value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            if( flag == true ) { //���ǽ�û �Ⱓüũ
                fnc_AddNew();
                document.getElementById("resultMessage").innerText = ' ';

                document.getElementById("txtPROTEST_YMD").value = getToday();

                form1.txtPROTEST_TIT.focus();//set focus
            }

        } else {

            if( flag == true ) {        //���ǽ�û �Ⱓ üũ
                document.getElementById("resultMessage").innerText = '* �ڷᰡ ��ȸ �Ǿ����ϴ�!';

                //�������� ����üũ
                if( !fnc_DeleteEnableCheck() ) {
                    fnc_DisableSet();
                    document.getElementById("resultMessage").innerText = '* ������ �Ϸ�� �����Դϴ�.';
                    alert("������ �Ϸ�� �����Դϴ�.");

                    document.getElementById("btnUPLOAD").disabled = "true";
                    document.getElementById("btnDEL").disabled = "true";

                    return;
                }
            }

            form1.txtFILE_URL2.value = form1.txtFILE_URL.value;
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_DisableSet();
            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

            document.getElementById("btnUPLOAD").disabled = "true";
            document.getElementById("btnDEL").disabled = "true";

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            document.getElementById("txtENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NAME_SHR").value = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NAME_SHR").value = '<%=box.get("SESSION_DPTNM")%>';

            //���ǽ�û �Է±Ⱓ ���� üũ
            fnc_SearchItem('2');

        }

    </Script>

    <Script For=dsT_EV_ESTINFO_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_DisableSet();
            document.getElementById("resultMessage").innerText = '* ���� ���� ��û �Ⱓ�� �ƴմϴ�!';
            alert("���� ���� ��û �Ⱓ�� �ƴմϴ�.");

            document.getElementById("btnUPLOAD").disabled = "true";
            document.getElementById("btnDEL").disabled = "true";

        } else {

            flag=true;        //���ǽ�û���� �Ⱓ�� ���
            //���ǽ�û(����)_���� ��ȸ

        }

        fnc_SearchList();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_PROTEST event="OnSuccess()">

        // ���ϻ�����
        if (file_flag == '1') {

            document.getElementById("resultMessage").innerText = '* ÷�������� �����Ǿ����ϴ�.';
            file_flag == '0';
        }
        else {

            if( stateDiv == 'delete' ) {
                fnc_AddNew();
                //���ǽ�û���� ����
                document.getElementById("txtPROTEST_YMD").value = getToday();
            }
            stateDiv = '';
            fnc_Message(document.getElementById("resultMessage"),"MSG_01");
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_PROTEST event="OnFail()">

        cfErrorMsg(this);
        file_flag == '0';

    </script>

    <!-- �����͸� ���������� ������ �� ��� �߻��ϴ� �̺�Ʈ -->
    <script for=dsT_EV_PROTEST2 event="OnLoadCompleted(iCount)">
        if (iCount == 0){
            alert("��ȸ�� �����Ͱ� �����ϴ�.");
            return;
        }

        /** �����ͼ� ���� **/
        cfCopyDataSet(dsT_EV_PROTEST2, dsT_EV_PROTEST, "copyHeader=yes");
        form1.txtFILE_URL2.value = form1.txtFILE_URL.value;
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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ǽ�û(����)_����</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���ǽ�û(����)_����</font></td>
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
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_DeleteOver.gif',2)"><img src="/images/button/btn_DeleteOn.gif" id="image2" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',3)">  <img src="/images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>

            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <input type="hidden" id="txtEVL_GBN_SHR" name="txtEVL_GBN_SHR" value='2'>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="greenTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right" class="searchBold">�ش�⵵&nbsp;</td>
                                    <td><input id="txtEVL_YY_SHR" name="txtEVL_YY_SHR" style="width 100%;text-align: center" size="4" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">ȸ��&nbsp;</td>
                                    <td><input id="txtEVL_FRQ_SHR" name="txtEVL_FRQ_SHR" style="width 100%;text-align: center" size="2" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">�Ҽ�&nbsp;</td>
                                    <td><input id="txtDPT_NAME_SHR" name="dept" style="width 100%;" size="10" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">���&nbsp;</td>
                                    <td><input id="txtENO_NO_SHR" name="txtENO_NO_SHR" style="width 100%;text-align: center" size="10" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">����&nbsp;</td>
                                    <td><input id="txtENO_NAME_SHR" name="eno_nm" style="width 100%;text-align:center" size="10" class="input_ReadOnly" readonly></td>
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
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" height="160" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="25"></col>
                        <col width="30"></col>
                        <col width=""></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold" rowspan="3">��<BR><BR>��<BR><BR>��<BR><BR>û</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_YMD name=txtPROTEST_YMD class="input_ReadOnly" size="15" maxlength=10 onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" readonly>
                            &nbsp;&nbsp;<B>÷�����ϸ�</B>&nbsp;
                            <input id=txtFILE_NAME name=txtFILE_NAME size="58" valid='maxlength=255' readonly style="cursor:hand" onClick="fnc_link()">&nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)">  <img src="/images/button/FileAddOn.gif"   id="btnUPLOAD" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnDEL','','/images/button/FileDelOver.gif',3)">  <img src="/images/button/FileDelOn.gif"   id="btnDEL" name="btnDEL" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete()"></a>
                            <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60"><input type=hidden id=txtFILE_URL2 name=txtFILE_URL2 size="60">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_TIT name=txtPROTEST_TIT size="121" valid='maxlength=100' field='����'>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��<BR><BR>��</td>
                        <td align="center">
                            <textarea id=txtPROTEST_DEC name=txtPROTEST_DEC rows="9" cols="120" valid='maxlength=4000' field='����'></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" rowspan="2">��<BR><BR><BR>��</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <input id=txtANSWER_YMD name=txtANSWER_YMD style="text-align: center" size="15" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��<BR><BR>��</td>
                        <td align="center">
                            <textarea id=txtANSWER_DEC name=txtANSWER_DEC rows="9" cols="120" class="input_ReadOnly" readonly></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>

    <!--
    **************************************************************
    * ���ε� ������Ʈ
    **************************************************************
    -->
    <!--  ���̺� -->
    <comment id="__NSID__">
    <object id="bndT_EV_PROTEST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_EV_PROTEST">
        <Param Name="ActiveBind"        Value=true>
        <Param Name="BindInfo", Value='
            <C>Col=PROTEST_YMD       Ctrl=txtPROTEST_YMD      Param=value</C>
            <C>Col=PROTEST_TIT       Ctrl=txtPROTEST_TIT      Param=value</C>
            <C>Col=PROTEST_DEC       Ctrl=txtPROTEST_DEC      Param=value</C>
            <C>Col=ANSWER_YMD       Ctrl=txtANSWER_YMD      Param=value</C>
            <C>Col=ANSWER_DEC       Ctrl=txtANSWER_DEC      Param=value</C>
            <C>Col=FILE_NAME        Ctrl=txtFILE_NAME       Param=Value</C>
            <C>Col=FILE_URL         Ctrl=txtFILE_URL        Param=Value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

    <!-- ÷�����Ͽ� ���ε� ������Ʈ -->
    <object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="oFileListGDS">
        <Param Name="BindInfo", Value='
            <C>Col=FILE_NAME        Ctrl=oFileGF            Param=Value</C>
            <C>Col=FILE_URL            Ctrl=oFileGF            Param=Value</C>'>
    </object>
