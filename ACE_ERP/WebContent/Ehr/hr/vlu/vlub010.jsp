<!--
***********************************************************************
* @source      : vlub010.jsp
* @description : �ڱ�����������_���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/27      ���뼺        �����ۼ�.
* 2007/03/16      ������        ����. (�����򰡾������� �߰�)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>�ڱ�����������_����(vlub010)</title>
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

        var today = removeChar(getToday(),'-');    //���� �ý��� ��¥(YYYYMMDD)
        var ipt_stdt;             //������ ������
        var ipt_endt;             //������ ������
        var prot_stdt;            //���ǽ�û ������
        var prot_endt;            //���ǽ�û ������
        var updn_url = '/hr/vlu/vlub041.jsp';

        frame.SetEvent("onwinstat", fnc_FormActive);     // �� Form�� Active�Ǵ� ������ ã�Ƽ� Event�� �߻��Ѵ�.

        var btnList = 'TFFFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.reset();

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
        function fnc_Save(s_mode) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

        frame = window.external.GetFrame(window);
        frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            // ��������
            if (frameid == "vlub010") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            fnc_SearchList();

        }

        /************************************
         * 15. Modalâ��    ����               *
         ***********************************/
        function fnc_showModal(gbn, url, i) {

            if ( gbn == '3' || gbn == '4' ) {

                if ( gbn == '3' ) {
                    if( today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-') ) {
                        alert("������ �Ⱓ�� �ƴմϴ�.");
                        return;
                    }
                } else if ( gbn == '4' ) {
                    if( today < removeChar(prot_stdt,'-') || today > removeChar(prot_endt,'-') ) {
                        alert("���ǽ�û �Ⱓ�� �ƴմϴ�.");
                        return;
                    }
                }
            } else {
                var eno_nm = dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                eno_nm = removeChar(removeChar(eno_nm,'['),']').trim();

                //modal������ ���� ���� confirm�� ���ڸ��� �޾� �´�.
                url = url + "?GUBUN=" + GUBUN + "&EVL_YY="+dsT_EV_ABLRST.NameValue(1,'EVL_YY') + "&EVL_GBN=1&EVL_FRQ=" + dsT_EV_ABLRST.NameValue(1,'EVL_FRQ') + "&IPT_STDT=" + ipt_stdt + "&IPT_ENDT=" + ipt_endt + "&EVLENO_NO=" + dsT_EV_ABLRST.NameValue(1,'ENO_NO') + "&EVLENO_NM=" + dsT_EV_ABLRST.NameValue(1,'ENO_NM') + "&GROUP_CD=&DEGREE_GBN=" + dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') + "&ENO_NO=" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO') + "&ENO_NM=" + eno_nm + "&DPT_NM=&UPDN_GBN="+gbn;
            }

  //        window.showModalDialog(url, 'win', "dialogWidth:870px; dialogHeight:590px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            window.showModalDialog(url, 'win', "dialogWidth:1080px; dialogHeight:850px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            fnc_OnLoadProcess();

        }

        /***************************************
         * 16. Form�� Active �� �� ó�� �� ��  *
         **************************************/
        function fnc_FormActive(strID, winstat) {

            if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��

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
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------------------------------+
    | 1. ��ȸ�� DataSet                                                            |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)                                |
    | 3. ���Ǵ� Table List(T_EV_ABLRST,T_EV_ESTINFO,T_EV_SCHCHG,T_EV_ESTINFO)    |
    +--------------------------------------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLIST_DT)     |
    | 3. ���Ǵ� Table List(T_EV_EVLIST_DT, T_EV_TYPE) |
    +--------------------------------------------------->
    <Object ID="dsT_EV_EVLIST_DT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_PROTEST)       |
    | 3. ���Ǵ� Table List(T_EV_PROTEST)              |
    +--------------------------------------------------->
    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">


            dsT_EV_ABLRST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub010.cmd.VLUB010CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_GBN=1&EVL_YY="+dsT_EV_ESTINFO.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            dsT_EV_ABLRST.reset();


    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {
            //�������� �� ������ Setting
            document.getElementById("EVL_YY").innerText  = dsT_EV_ABLRST.NameValue(1,"EVL_YY");
            document.getElementById("EVL_FRQ").innerText = dsT_EV_ABLRST.NameValue(1,"EVL_FRQ");
            document.getElementById("DPT_NM").innerText  = dsT_EV_ABLRST.NameValue(1,"DPT_NM");
            document.getElementById("LEVEL").innerText   = dsT_EV_ABLRST.NameValue(1,"JIK_NM");
            document.getElementById("ENO_NO").innerText  = dsT_EV_ABLRST.NameValue(1,"ENO_NO");
            document.getElementById("ENO_NM").innerText  = dsT_EV_ABLRST.NameValue(1,"ENO_NM");

            // 2006�� 12�� 18�� ����������� ��Ź(�ϴ� �Ⱥ��̰� ó���߾���.)
            // 2007�� 07�� 20�� : ���Ȯ���� ������ ������ ����Ȯ���� ���δ�.(�ǵ��� �Ǿ�� ����� ���̴��� �ƿ�������.(����������))
            document.getElementById("GRADE").innerText = dsT_EV_ABLRST.NameValue(1,"FINAL_GRD");

            if(dsT_EV_ABLRST.NameValue(1,"IPT_STDT") != '') {
                ipt_stdt = dsT_EV_ABLRST.NameValue(1,"IPT_STDT");
                ipt_endt = dsT_EV_ABLRST.NameValue(1,"IPT_ENDT");
            } else {
                ipt_stdt = dsT_EV_ABLRST.NameValue(2,"IPT_STDT");
                ipt_endt = dsT_EV_ABLRST.NameValue(2,"IPT_ENDT");
            }
            if(dsT_EV_ABLRST.NameValue(1,"PROT_STDT") != '') {
                prot_stdt = dsT_EV_ABLRST.NameValue(1,"PROT_STDT");
                prot_endt = dsT_EV_ABLRST.NameValue(1,"PROT_ENDT");
            } else {
                prot_stdt = dsT_EV_ABLRST.NameValue(2,"PROT_STDT");
                prot_endt = dsT_EV_ABLRST.NameValue(2,"PROT_ENDT");
            }

            document.getElementById("IPT_STDT").innerText  = ipt_stdt;
            document.getElementById("IPT_ENDT").innerText  = ipt_endt;
            document.getElementById("PROT_STDT").innerText = prot_stdt;
            document.getElementById("PROT_ENDT").innerText = prot_endt;

            if(dsT_EV_ABLRST.NameValue(1,"FINAL_GRD") != ''){
                document.getElementById("FINAL").innerText = "�Ϸ�";
            } else {
                document.getElementById("FINAL").innerText = "�̿Ϸ�";
            }

            //������ �������� ��ȸ
            dsT_EV_EVLIST_DT.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub010.cmd.VLUB010CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ABLRST.NameValue(1,"EVL_FRQ");
            dsT_EV_EVLIST_DT.reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLIST_DT Event="OnLoadCompleted(iCount)">

        var down_nm_01 = '';      //����1�� �̿Ϸ���
        var down_nm_02 = '';      //����2�� �̿Ϸ���
        var down_nm_03 = '';      //����3�� �̿Ϸ���
        var up_nm_01 = '';        //����1�� �̿Ϸ���
        var up_nm_02 = '';        //����2�� �̿Ϸ���
        var up_nm_03 = '';        //����3�� �̿Ϸ���
        var down_status01 = '';   //����1�� �Ϸ���
        var down_status02 = '';   //����2�� �Ϸ���
        var down_status03 = '';   //����3�� �Ϸ���
        var up_status01 = '';     //����1�� �Ϸ���
        var up_status02 = '';     //����2�� �Ϸ���
        var up_status03 = '';     //����3�� �Ϸ���
        var ipt_term = '';        //���Է±Ⱓ
        var prot_term = '';       //���ǽ�û�Ⱓ

        if (iCount < 1)    {

        } else {

            //�����ڸ� ���ϱ�
            for(i=1;i<dsT_EV_EVLIST_DT.CountRow+1;i++) {

                if(dsT_EV_EVLIST_DT.NameValue(i,'UPDN_GBN') == '2') {        // ������

                    if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '1') {        //1��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                down_nm_01 = down_nm_01 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                down_nm_01 = down_nm_01 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            down_status01 = down_status01 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    } else if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '2') { //2��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                down_nm_02 = down_nm_02 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                down_nm_02 = down_nm_02 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            down_status02 = down_status02 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    } else if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '3') {    //3��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                down_nm_03 = down_nm_03 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                down_nm_03 = down_nm_03 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            down_status03 = down_status03 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    }

                } else if(dsT_EV_EVLIST_DT.NameValue(i,'UPDN_GBN') == '1') {// ������

                    if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '1') {        //1��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                up_nm_01 = up_nm_01 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                up_nm_01 = up_nm_01 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            up_status01 = up_status01 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    } else if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '2') { //2��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                up_nm_02 = up_nm_02 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                up_nm_02 = up_nm_02 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            up_status02 = up_status02 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    } else if(dsT_EV_EVLIST_DT.NameValue(i,'DEGREE_GBN') == '3') {    //3��

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1') != '[�Ϸ�]') {

                            if(today < removeChar(ipt_stdt,'-') || today > removeChar(ipt_endt,'-')) {
                                up_nm_03 = up_nm_03 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1');
                            } else {
                                up_nm_03 = up_nm_03 + "<a href='#' onClick='fnc_showModal(2,updn_url, "+i+")'>" + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO1')+"</a>";
                            }

                        }

                        if(dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2') != '[�Ϸ�]'){
                            up_status03 = up_status03 + dsT_EV_EVLIST_DT.NameValue(i,'ENO_NO2');
                        }

                    }
                }
            } //end for

//            if(down_nm_01 == '') down_nm_01 = '[��ü�Ϸ�]';
//            if(down_nm_02 == '') down_nm_02    = '[��ü�Ϸ�]';
//            if(down_nm_03 == '') down_nm_03    = '[��ü�Ϸ�]';
//            if(up_nm_01 == '') up_nm_01    = '[��ü�Ϸ�]';
//            if(up_nm_02 == '') up_nm_02    = '[��ü�Ϸ�]';
//            if(up_nm_03 == '') up_nm_03    = '[��ü�Ϸ�]';
//            if(down_status01 == '') down_status01 = '[��ü�̿Ϸ�]';
//            if(down_status02 == '') down_status02 = '[��ü�̿Ϸ�]';
//            if(down_status03 == '') down_status03 = '[��ü�̿Ϸ�]';
//            if(up_status01 == '') up_status01 = '[��ü�̿Ϸ�]';
//            if(up_status02 == '') up_status02 = '[��ü�̿Ϸ�]';
//            if(up_status03 == '') up_status03 = '[��ü�̿Ϸ�]';

            //���Է±Ⱓ ���ϱ�
            ipt_term = ipt_stdt + " ~ " + ipt_endt;
            //���ǽ�û�Ⱓ ���ϱ�
            prot_term = prot_stdt  +" ~ " + prot_endt;

            if(dsT_EV_EVLIST_DT.NameValue(1,'DOWN_YN') == '1'){

                //����1���򰡶� Setting
                if(dsT_EV_EVLIST_DT.NameValue(1,'DOWN_CNT') == 1) {
                    document.getElementById("down01").style.display = '';
                }
                //����2���򰡶� Setting
                else if(dsT_EV_EVLIST_DT.NameValue(1,'DOWN_CNT') == 2) {
                    document.getElementById("down01").style.display = '';
                    document.getElementById("down02").style.display = '';
                }
                //����3���򰡶� Setting
                else if(dsT_EV_EVLIST_DT.NameValue(1,'DOWN_CNT') == 3) {
                    document.getElementById("down01").style.display = '';
                    document.getElementById("down02").style.display = '';
                    document.getElementById("down03").style.display = '';
                }

            }

            if(dsT_EV_EVLIST_DT.NameValue(1,'UP_YN') == '1') {

                //����1���򰡶� Setting
                if(dsT_EV_EVLIST_DT.NameValue(1,'UP_CNT') == 1) {
                    document.getElementById("up01").style.display = '';
                }
                //����2���򰡶� Setting
                else if(dsT_EV_EVLIST_DT.NameValue(1,'UP_CNT') == 2) {
                    document.getElementById("up01").style.display = '';
                    document.getElementById("up02").style.display = '';
                }
                //����3���򰡶� Setting
                else if(dsT_EV_EVLIST_DT.NameValue(1,'UP_CNT') == 3) {
                    document.getElementById("up01").style.display = '';
                    document.getElementById("up02").style.display = '';
                    document.getElementById("up03").style.display = '';
                }

            }

            document.getElementById("protest").style.display = '';

            document.getElementById("IPT_TERM_01").innerText   = ipt_term;
            document.getElementById("DOWN_NM_01").innerHTML    = down_nm_01;
            document.getElementById("DOWN_STATUS01").innerText = down_status01;
            document.getElementById("IPT_TERM_02").innerText   = ipt_term;
            document.getElementById("DOWN_NM_02").innerHTML    = down_nm_02;
            document.getElementById("DOWN_STATUS02").innerText = down_status02;
            document.getElementById("IPT_TERM_03").innerText   = ipt_term;
            document.getElementById("DOWN_NM_03").innerHTML    = down_nm_03;
            document.getElementById("DOWN_STATUS03").innerText = down_status03;
            document.getElementById("IPT_TERM_04").innerText   = ipt_term;
            document.getElementById("UP_NM_01").innerHTML      = up_nm_01;
            document.getElementById("UP_STATUS01").innerText   = up_status01;
            document.getElementById("IPT_TERM_05").innerText   = ipt_term;
            document.getElementById("UP_NM_02").innerHTML      = up_nm_02;
            document.getElementById("UP_STATUS02").innerText   = up_status02;
            document.getElementById("IPT_TERM_06").innerText   = ipt_term;
            document.getElementById("UP_NM_03").innerHTML      = up_nm_03;
            document.getElementById("UP_STATUS03").innerText   = up_status03;
            document.getElementById("PROT_TERM").innerText     = prot_term;

            //���ǽ�û ���� ��ȸ
            dsT_EV_PROTEST.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub010.cmd.VLUB010CMD&S_MODE=SHR_03&GUBUN="+GUBUN+"&EVL_YY="+dsT_EV_ABLRST.NameValue(1,"EVL_YY")+"&EVL_FRQ="+dsT_EV_ABLRST.NameValue(1,"EVL_FRQ");
            dsT_EV_PROTEST.reset();

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

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            document.getElementById("PROT_STAT").innerText = '�̽�û';
            document.getElementById("PROT_STAT1").innerText = '�̽�û';

        } else {

            document.getElementById("PROT_STAT").innerText = "��û";
            document.getElementById("PROT_STAT1").innerText = dsT_EV_PROTEST.NameValue(1,"STSTUS");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="15" rightmargin="20" bottommargin="30" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onLoad="fnc_OnLoadProcess()">
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <!-- Ÿ��Ʋ �� ���̺� ���� -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ڱ�����������_����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�ڱ�����������_����</font></td>
                </tr>
            </table>
            <!-- Ÿ��Ʋ �� ���̺� �� -->
        </td>
    </tr>
    <tr>
        <!-- ��ư -->
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
    <tr>
        <td height="125" background="/images/specialHr/gridGreen.gif">
            <!--�����������̺� ���� -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11"><img src="/images/specialHr/gridWhiteL.gif" width="11" height="125"></td>
                    <td align="center" valign="top">
                        <table width="775" height="112" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="32" style="padding:5 0 0 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title1.gif" width="44" height="15" align="absmiddle"></td>
                            </tr>
                            <tr>
                                <td class="hrWtable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="110" align="center" valign="bottom"><img src="/images/specialHr/iconPc.gif" width="92" height="70"></td>
                                            <td>
                                                <!--������������Ÿ ���̺� -->
                                                <table width="640" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td height="27" colspan="9" class="hrTextGreen"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info1.gif" width="21" height="15" align="absmiddle">&nbsp;<span id="EVL_YY">&nbsp;</span>
                                                            <img src="/images/specialHr/info2.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="EVL_FRQ">&nbsp;</span>
                                                            <img src="/images/specialHr/info3.gif" width="20" height="15" align="absmiddle"></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="1" background="/images/specialHr/dot.gif" colspan="12"></td>
                                                    </tr>
                                                    <tr>
                                                        <td height="27" class="hrTextGreen" style="padding:5 0 0 0"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info4.gif" width="19" height="15" align="absmiddle">&nbsp;<span id="DPT_NM">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info5.gif" width="21" height="15" align="absmiddle">&nbsp;<span id="LEVEL">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info6.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="ENO_NO">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info7.gif" width="20" height="15" align="absmiddle">&nbsp;<span id="ENO_NM">&nbsp;</span></td>
                                                        <td width="1" background="/images/specialHr/dot.gif"></td>
                                                        <td class="hrTextGreen" style="padding:5 0 0 10"><img src="/images/specialHr/arrowGreen.gif" width="8" height="15" align="absmiddle">
                                                            <img src="/images/specialHr/info8.gif" width="41" height="15" align="absmiddle">&nbsp;<span id="GRADE">&nbsp;</span></td>
                                                    </tr>
                                                </table></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteR.gif" width="11" height="125"></td>
                </tr>
            </table>
            <!--�����������̺� �� -->
        </td>
    </tr>
    <tr>
        <td height="15">&nbsp;</td>
    </tr>
    <tr>
        <td height="110" bgcolor="F3F5EB">
            <!--���������̺� ���� -->
            <table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center" valign="top">
                        <table width="775" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title2.gif" width="44" height="15" align="absmiddle">
                                </td>
                            </tr>
                            <tr>
                                <td height="175" class="hrWtable" style="padding:20 6 6 6">
                                    <table width="100%" height="163" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="25" align="center" valign="top" background="/images/specialHr/inputTbg.gif"><img src="/images/specialHr/inputT4.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td align="center" valign="top" background="/images/specialHr/inputTbg.gif"><img src="/images/specialHr/inputT5.gif" width="116" height="20"></td>
                                            <td width="13" rowspan="3" background="/images/specialHr/dotV.gif"></td>
                                            <td align="center" valign="top" background="/images/specialHr/inputTbg.gif"><img src="/images/specialHr/inputT6.gif" width="116" height="20"></td>
                                        </tr>
                                        <tr>
                                            <td align="center"><img src="/images/specialHr/inputImg4.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal('3','/hr/vlu/vlub040.jsp?GUBUN='+GUBUN,'');"></td>
                                            <td align="center"><img src="/images/specialHr/inputImg5.gif" width="116" height="80" style="cursor:hand" onClick="fnc_showModal('4','/hr/vlu/vlub080.jsp?GUBUN='+GUBUN,'');"></td>
                                            <td align="center"><img src="/images/specialHr/inputImg6.gif" width="116" height="80"></td>
                                        </tr>
                                        <tr>
                                            <td height="43" align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="IPT_STDT"></span>&nbsp;����<br>&nbsp;<span id="IPT_ENDT"></span>&nbsp;����</td>
                                            <td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="PROT_STDT"></span>&nbsp;����<br>&nbsp;<span id="PROT_ENDT"></span>&nbsp;����</td>
                                            <td align="center" bgcolor="EFFAEB" class="hrTextGreen" style="padding-top:5px;">&nbsp;<span id="FINAL">&nbsp;</span></td>
                                        </tr>
                                    </table></td>
                            </tr>
                        </table></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="11" width="13"><img src="/images/specialHr/gridWhiteLB.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td><img src="/images/specialHr/gridWhiteRB.gif" width="11" height="11"></td>
                </tr>
            </table>
            <!--���������̺� �� -->
        </td>
    </tr>
    <tr>
        <td height="15">&nbsp;</td>
    </tr>
    <tr>
        <td bgcolor="F6F4DF">
            <!--�����༼������ ���̺� ���� -->
            <table width="100%" height="220" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="11" height="11"><img src="/images/specialHr/gridWhiteLT.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td width="11"><img src="/images/specialHr/gridWhiteRT.gif" width="11" height="11"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center" valign="top">
                        <table width="775" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="385" valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/dotOlive.gif" width="10" height="10" align="absmiddle">
                                    <img src="/images/specialHr/title3.gif" width="89" height="15" align="absmiddle">
                                </td>
                                <!-- <td width="385" align="right" valign="top" style="padding:0 0 7 4;"><img src="/images/specialHr/pen.gif" width="230" height="16"></td> -->
                            </tr>
                            <!--1����-->
                            <tr id='down01' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg5.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_01">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="DOWN_NM_01">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="DOWN_STATUS01">&nbsp;</span>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--1���򰡳�-->
                            <!--2����-->
                            <tr id='down02' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg6.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_02">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="DOWN_NM_02">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="DOWN_STATUS02">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--2���򰡳�-->
                            <!--3����-->
                            <tr id='down03' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg7.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_03">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="DOWN_NM_03">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="DOWN_STATUS03">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--3���򰡳�-->
                            <!--����1����-->
                            <tr id='up01' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg8.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_04">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="UP_NM_01">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="UP_STATUS01">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--����1���򰡳�-->
                            <!--����2����-->
                            <tr id='up02' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg9.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_05">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="UP_NM_02">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="UP_STATUS02">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--����2���򰡳�-->
                            <!--����3����-->
                            <tr id='up03' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg10.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="IPT_TERM_06">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT11.gif" width="38" height="12"></td>
                                            <td class="hrTextBlue">&nbsp;<span id="UP_NM_03">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT12.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="UP_STATUS03">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!--����3���򰡳�-->
                            <tr id='protest' style="display:none;">
                                <td colspan="2" class="hrWtable2">
                                    <!--���ǽ�û-->
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="60" rowspan="5"><img src="/images/specialHr/detailTimg4.gif" width="60" height="70"></td>
                                            <td width="12"><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td width="50"><img src="/images/specialHr/detailT1.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="PROT_TERM">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT5.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="PROT_STAT">&nbsp;</span></td>
                                        </tr>
                                        <tr>
                                            <td height="1"></td>
                                            <td height="1" background="/images/specialHr/dot.gif" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td><img src="/images/specialHr/arrowOlive.gif" width="12" height="24"></td>
                                            <td><img src="/images/specialHr/detailT6.gif" width="38" height="12"></td>
                                            <td class="hrTextBlack">&nbsp;<span id="PROT_STAT1">&nbsp;</span></td>
                                        </tr>
                                    </table>
                                    <!--���ǽ�û��-->
                                </td>
                            </tr>
                        </table></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td height="11" width="13"><img src="/images/specialHr/gridWhiteLB.gif" width="11" height="11"></td>
                    <td height="11"></td>
                    <td><img src="/images/specialHr/gridWhiteRB.gif" width="11" height="11"></td>
                </tr>
            </table>
            <!--������ �������� ���̺� �� -->
        </td>
    </tr>
</table>
</body>
</html>