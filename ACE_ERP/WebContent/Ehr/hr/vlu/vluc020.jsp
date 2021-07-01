<!--
***********************************************************************
* @source      : vluc020.jsp
* @description : ���κ�����������_���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/04      ������        �����ۼ�.
* 2006/09/29      ���뼺
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ�����������_����(vluc020)</title>
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

        var btnList = 'TFTTFFTT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var year = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");         //�ش�⵵
            var frq  = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");        //ȸ��

            //�˻����� 3����
            var eno_no   = document.form1.txtENO_NO_SHR.value;       //���
            var dpt_cd   = document.form1.txtDPT_CD_SHR.value;       //�Ҽ�
            var group_cd = document.form1.cmbGROUP_CD_SHR.value;     //�򰡱׷�

            //�� ���� ���� ���� ��ȸ
            dsT_EV_SCHCHG.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+year+"&EVL_FRQ="+frq+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&GROUP_CD="+group_cd;
            dsT_EV_SCHCHG.reset();

            document.form1.grdT_EV_SCHCHG.SetColumn("OBJ_STDT");

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

                if(!fnc_SaveItemCheck()) return;    //��ȿ�� üũ

                trT_EV_SCHCHG.KeyValue = "tr01(I:dsT_EV_SCHCHG=dsT_EV_SCHCHG)";
                trT_EV_SCHCHG.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=SAV";
                trT_EV_SCHCHG.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            if(dsT_EV_SCHCHG.CountRow < 1) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            if(confirm("["+dsT_EV_SCHCHG.NameValue(dsT_EV_SCHCHG.RowPosition,'ENO_NM')+"]���� ���������������� �����Ͻðڽ��ϱ�?")){
                dsT_EV_SCHCHG.DeleteRow(dsT_EV_SCHCHG.RowPosition);
                trT_EV_SCHCHG.KeyValue = "tr01(I:dsT_EV_SCHCHG=dsT_EV_SCHCHG)";
                trT_EV_SCHCHG.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc020.cmd.VLUC020CMD&S_MODE=DEL";
                trT_EV_SCHCHG.post();
            }

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

            var f = document.form1;
            f.txtENO_NO_SHR.value = '';
            f.txtENO_NM.value = '';
            f.txtDPT_CD_SHR.value = '';
            f.txtDPT_NM_SHR.value = '';
            f.cmbGROUP_CD_SHR.value = '';

            dsT_EV_SCHCHG.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            f.txtDPT_CD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_SCHCHG.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }
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

            if (!dsT_EV_SCHCHG.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }

            //�Է��� ��¥�� ��ȿ�� üũ
            for(i=0;i<dsT_EV_SCHCHG.CountRow;i++){
                if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT'))){
                        alert(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT'));
                        alert("���Է±Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT') == ''){
                        alert("���Է±Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT'))) {
                            alert("���Է±Ⱓ(������)�� ���Է±Ⱓ(������)���� �ݵ�� �۾ƾ� �մϴ�.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'IPT_ENDT'))){
                        alert("���Է±Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'IPT_STDT') == ''){
                        alert("���Է±Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('IPT_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT'))){
                        alert("��ǥ�Է±Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT') == ''){
                        alert("��ǥ�Է±Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT'))) {
                            alert("��ǥ�Է±Ⱓ(������)�� ��ǥ�Է±Ⱓ(������)���� �ݵ�� �۾ƾ� �մϴ�.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_ENDT'))){
                        alert("��ǥ�Է±Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'OBJ_STDT') == ''){
                        alert("��ǥ�Է±Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('OBJ_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT'))){
                        alert("�����򰡱Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT') == ''){
                        alert("�����򰡱Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT'))) {
                            alert("�����򰡱Ⱓ(������)�� �����򰡱Ⱓ(������)���� �ݵ�� �۾ƾ� �մϴ�.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'SELF_ENDT'))){
                        alert("�����򰡱Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'SELF_STDT') == ''){
                        alert("�����򰡱Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('SELF_STDT');
                        return false;
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT'))){
                        alert("���ǽ�û�Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT') == ''){
                        alert("���ǽ�û�Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_ENDT');
                        return false;
                    } else {
                        if (removeChar(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT')) > removeChar(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT'))) {
                            alert("���ǽ�û�Ⱓ(������)�� ���ǽ�û�Ⱓ(������)���� �ݵ�� �۾ƾ� �մϴ�.");
                            dsT_EV_SCHCHG.RowPosition = i+1;
                            document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                            return false;
                        }
                    }
                }
                if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT') != ''){
                    if(!cfDateExpr(dsT_EV_SCHCHG.NameValue(i+1,'PROT_ENDT'))){
                        alert("���ǽ�û�Ⱓ(������)��\n��¥ ���Ŀ� ���� �ʽ��ϴ�.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_ENDT');
                        return false;
                    }
                    if(dsT_EV_SCHCHG.NameValue(i+1,'PROT_STDT') == ''){
                        alert("���ǽ�û�Ⱓ(������)�� �Է��ϼ���.");
                        dsT_EV_SCHCHG.RowPosition = i+1;
                        document.getElementById('grdT_EV_SCHCHG').SetColumn('PROT_STDT');
                        return false;
                    }
                }

            }//for
            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_SCHCHG,15,"true","false");      // Grid Style ����

            // ��������
            if (frameid == "vluc020") {
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

            //�⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN=01&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            document.form1.txtDPT_CD_SHR.focus();

        }

        /********************
         * 15. ����Ű ó��  *
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

    <!-----------------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_SCHCHG)                       |
    | 3. ���Ǵ� Table List(T_EV_SCHCHG, T_EV_EVLIST_HD, T_CM_PERSON) |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_SCHCHG)        |
    | 3. ���Ǵ� Table List(T_EV_SCHCHG)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_SCHCHG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(O:VLUA010=dsT_EV_TYPE,O:VLUA030=dsT_EV_ADJRATE,I:VLUA030=dsT_EV_ADJRATE)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
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
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�򰡱Ⱓ �� ��ȸ��������\n�Ǿ����� �ʽ��ϴ�.");

        } else {

            document.form1.txtEVL_YY.value  = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.form1.txtEVL_FRQ.value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
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
    <Script For=dsT_EV_SCHCHG Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

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

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_SCHCHG event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_SCHCHG event="OnFail()">
        cfErrorMsg(this);
    </script>


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ�����������_����</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���κ�����������_����</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<!-- ���� �Է� ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="65"></col>
                                <col width="30"></col>
                                <col width="35"></col>
                                <col width="10"></col>
                                <col width="65"></col>
                                <col width="*"></col>
                                <col width="35"></col>
                                <col width="175"></col>
                                <col width="35"></col>
                                <col width="165"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵</td>
                                <td class="padding2423"><input name=txtEVL_YY size="4" maxlength="4"  class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423"><input name=txtEVL_FRQ size="2" maxlength="1" class="input_ReadOnly" readonly></td>
                                <td align="right" class="searchState">�򰡱׷�</td>
                                <td class="padding2423">
                                    <select id="cmbGROUP_CD_SHR" name="cmbGROUP_CD_SHR" style="WIDTH: 90%" onChange="fnc_SearchList()" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value=''>�� ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input name=txtDPT_CD_SHR size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');">
                                    <input name=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image7" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423"><input name=txtENO_NO_SHR size="10" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();"  onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM','1','1');">
                                    <input name=txtENO_NM size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image6" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM')"></a>
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
                        <object    id="grdT_EV_SCHCHG" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_SCHCHG">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}        width=50   name='����'              align=center </C>
                                <C> id='GROUP_NM'   width=75   name='�򰡱׷�'   Edit=None   align=left </C>
                                <C> id='HEAD_NM'    width=90   name='����'       Edit=None   align=left </C>
                                <C> id='DPT_NM'     width=90   name='�Ҽ�'       Edit=None   align=left </C>
                                <C> id='JOB_NM'     width=60   name='����'       Edit=None   align=left </C>
                                <C> id='ENO_NO'     width=60   name='���'       Edit=None   align=center </C>
                                <C> id='ENO_NM'     width=50   name='����'       Edit=None   align=center </C>
                                <G> name='��ǥ�Է±Ⱓ' HeadBgColor='#F7DCBB'>
                                    <C> id='OBJ_STDT'    width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='OBJ_ENDT'   width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='�����򰡱Ⱓ' HeadBgColor='#F7DCBB'>
                                    <C> id='SELF_STDT'  width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='SELF_ENDT'    width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='���Է±Ⱓ' HeadBgColor='#F7DCBB'>
                                    <C> id='IPT_STDT'   width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                    <C> id='IPT_ENDT'   width=70    name='������'   Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX    align=center </C>
                                </G>
                                <G> name='���ǽ�û�Ⱓ' HeadBgColor='#F7DCBB'>
                                    <C> id='PROT_STDT'  width=70    name='������'    Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX   align=center </C>
                                    <C> id='PROT_ENDT'  width=70    name='������'    Edit=Numeric    EditLimit=8   Mask=XXXX-XX-XX   align=center </C>
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

</body>
</html>