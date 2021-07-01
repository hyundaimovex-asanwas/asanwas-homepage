<!--
***********************************************************************
* @source      : vlua030.jsp
* @description : �򰡹ݿ��������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/09/22      ���뼺        �����ۼ�.
* 2007/03/15      ������        ����. (�����򰡾������� �߰�)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>�򰡹ݿ���������(vlua030)</title>
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

        var insert_flag;                                 //���¸� �Է����� �����ϱ� ���� Flag
        frame.SetEvent("onwinstat", fnc_FormActive);     // �� Form�� Active�Ǵ� ������ ã�Ƽ� Event�� �߻��Ѵ�.

        var frameid = window.external.GetFrame(window).FrameId;
        var year    = getToday().substring(0,4);
        var btnList = 'TFTFFFFT';
        var GUBUN   = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�� ���� ���� ���� ��ȸ
            dsT_EV_TYPE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_01&GUBUN="+document.form1.txtGUBUN.value+"&EVL_YY="+document.getElementById("selEVL_YY_SHR").value;
            dsT_EV_TYPE.reset();

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

                //DateSet�� EVL_YY�� �˻��⵵�� Setting
                for (i=0;i<dsT_EV_ADJRATE.CountRow;i++){

                    if (dsT_EV_ADJRATE.NameValue(i+1,"EVL_YY") == '') {
                        dsT_EV_ADJRATE.NameValue(i+1,"GUBUN")  = GUBUN;
                        dsT_EV_ADJRATE.NameValue(i+1,"EVL_YY") = document.form1.selEVL_YY_SHR.value;

                    }
                }

                trT_EV_ADJRATE.KeyValue = "tr01(I:dsT_EV_ADJRATE=dsT_EV_ADJRATE)";
                trT_EV_ADJRATE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SAV";
                trT_EV_ADJRATE.post();

            } else {
                return;
            }

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

            if (dsT_EV_ADJRATE.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.form1.selEVL_YY_SHR.value != year) {
                alert("����⵵ �̿��� �ڷ�� ���� �� ������ �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_06');
                document.form1.selEVL_YY_SHR.focus();
                return false;
            }

            if (!dsT_EV_ADJRATE.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
            }

            var temp;

            //�հ谡 100���� ���� üũ
            for (i=1;i<=dsT_EV_ADJRATE.CountRow;i++){
                temp = 0;

                // ����
                for (j=1; j<=4; j++){

                    temp = temp + eval("dsT_EV_ADJRATE.NameValue("+i+", 'ACH_0"+j+"')");
                }

                // ����
                for (j=1; j<=4; j++){

                    temp = temp + eval("dsT_EV_ADJRATE.NameValue("+i+", 'ABL_0"+j+"')");

                }

                if(temp != 0 && temp != 100){
                    alert(dsT_EV_ADJRATE.NameValue(i,"COMM_NM")+" �׷��� ���� 100�� �ƴմϴ�.");
                    document.form1.grdT_EV_ADJRATE.SetColumn("ACH_01");//set focus
                    return false;
                } else if(temp == 100){
                    dsT_EV_ADJRATE.NameValue(i,"TOTAL") = 100;
                } else if(temp == 0){
                    dsT_EV_ADJRATE.NameValue(i,"TOTAL") = 0;
                }
            }

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_ADJRATE,0,"true","false");      // Grid Style ����

            getSelYy2('selEVL_YY_SHR');                //SelectBox�⵵ Setting

            // ��������
            if (frameid == "vlua030") {
                // �λ���
                GUBUN = "01";
                document.getElementById("loctitle").innerText = "HOME/�λ���/�򰡱�������/";
            }
            else {
                // ������
                GUBUN = "02";
                document.getElementById("loctitle").innerText = "HOME/��������/������/�򰡱�������/";
            }

            document.form1.txtGUBUN.value = GUBUN;

            fnc_SearchList();                          //�⺻���� ��ȸ
            document.form1.grdT_EV_ADJRATE.SetColumn("ACH_01");

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /***************************************
         * 16. Form�� Active �� �� ó�� �� ��  *
         **************************************/
        function fnc_FormActive(strID, winstat) {

            if (winstat == "activate") {
                fnc_SearchList();
            }   //Form�� Active �� �� ���� ����ȸ ó��

        }

		//���⵵ ���� ����
        function fnc_Yearcopy(){

   			if( ! confirm("���⵵ ������ �����Ͻðڽ��ϱ�?") ){
				return false;
			}

	        var tempYear = document.form1.selEVL_YY_SHR.value;

            //�� �ݿ� ���� ������ ���� ��ȸ
            dsT_EV_ADJRATE_01.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_04&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
            dsT_EV_ADJRATE_01.reset();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ADJRATE)       |
    | 3. ���Ǵ� Table List(T_CM_COMMON, T_EV_ADJRATE) |
    +--------------------------------------------------->
    <Object ID="dsT_EV_ADJRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ADJRATE)       |
    | 3. ���Ǵ� Table List(T_CM_COMMON, T_EV_ADJRATE) |
    +--------------------------------------------------->
    <Object ID="dsT_EV_ADJRATE_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ADJRATE)       |
    | 3. ���Ǵ� Table List(T_EV_ADJRATE, T_EV_TYPE)   |
    +--------------------------------------------------->
    <Object ID ="trT_EV_ADJRATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="sample_tr01(O:VLUA010=dsT_EV_TYPE,O:VLUA030=dsT_EV_ADJRATE,I:VLUA030=dsT_EV_ADJRATE)">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_EV_ADJRATE_01                   |
    | 3. Table List : T_EV_ADJRATE                  |
    +----------------------------------------------->
    <Object ID ="trT_EV_ADJRATE_01" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        var tempYear = document.form1.selEVL_YY_SHR.value;
        if (iCount < 1)    {

            alert(tempYear+"�⵵ �򰡱��������� �Ϸ��Ͻ� �Ŀ�\n\n�򰡹ݿ����������� �����մϴ�.");
            dsT_EV_ADJRATE.ClearAll();
            document.getElementById("resultMessage").innerText = "* "+tempYear+"�⵵ �򰡱������� �� �۾��ϼ���.";

        } else {

            if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 1) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 2) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 3) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 4) {
                grdT_EV_ADJRATE.ColumnProp('ABL_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ABL_04','Show') = true;
            }

            if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 1) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 2) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = false;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 3) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = false;
            } else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 4) {
                grdT_EV_ADJRATE.ColumnProp('ACH_02','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_03','Show') = true;
                grdT_EV_ADJRATE.ColumnProp('ACH_04','Show') = true;
            }

            //�� ���� ���� �׸��� Setting �� �ش� �ڷ� ��ȸ
            dsT_EV_ADJRATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SHR_02&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
            dsT_EV_ADJRATE.reset();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ADJRATE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�� �׷� ���� ���� �� �ش� �۾��� ���� �ϼ���.");


        } else {

            //�ش�⵵�� ���� �����Ͱ� �������
            if (dsT_EV_ADJRATE.NameValue(1,"EVL_YY") == '') {
                fnc_Message(document.getElementById("resultMessage"), 'MSG_02');
            }
            else {    //�ش�⵵�� ���� �����Ͱ� �������

                if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 1) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_02') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_02') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 2) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                } else if(dsT_EV_TYPE.NameValue(1,"ABL_CNT") == 3) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ABL_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ABL_04') = 0;
                    }
                }

                if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 1) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_02') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_02') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }
                else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 2) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_03') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_03') = 0;
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }
                else if(dsT_EV_TYPE.NameValue(1,"ACH_CNT") == 3) {
                    for(i=1;i<dsT_EV_ADJRATE.CountRow+1;i++) {
                        if(dsT_EV_ADJRATE.NameValue(i,'ACH_04') != 0) dsT_EV_ADJRATE.NameValue(i,'ACH_04') = 0;
                    }
                }


                fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);
            }
            document.form1.grdT_EV_ADJRATE.focus();

        }

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

        } else {

			if( ! confirm("���������Ͱ� �����մϴ�. ��� �Ͻðڽ��ϱ�?") ){
				return false;
			}

        }

        var tempYear = document.form1.selEVL_YY_SHR.value;

		//Ʈ����� üũ�� ���� �ӽû���
        dsT_EV_ADJRATE_01.AddRow();

		//Ʈ����� ����
		trT_EV_ADJRATE_01.KeyValue = "SVL(I:dsT_EV_ADJRATE_01=dsT_EV_ADJRATE_01)";
		trT_EV_ADJRATE_01.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua030.cmd.VLUA030CMD&S_MODE=SAV_01&GUBUN="+GUBUN+"&EVL_YY="+tempYear;
		trT_EV_ADJRATE_01.Post();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ADJRATE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ADJRATE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ADJRATE_01 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_ADJRATE event="OnSuccess()">

        //���� �� �ش� �ڷ� �� ��ȸ
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <script for=trT_EV_ADJRATE_01 event="OnSuccess()">

        //���� �� �ش� �ڷ� �� ��ȸ
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_ADJRATE event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=trT_EV_ADJRATE_01 event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�򰡹ݿ���������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�򰡹ݿ���������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <input type="hidden" name="txtGUBUN" id="txtGUBUN">
                                <td align="center" class="searchBold">�ش�⵵</td>
                                <td>
                                    <select id="selEVL_YY_SHR" name="selEVL_YY_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                    </select>
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
                        <object id="grdT_EV_ADJRATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ADJRATE">
                            <param name="Format"                  value="
                                <C> id='COMM_NM'      width=150   name='�򰡱׷�'   align=left    Edit=none</C>
                                <G> name='������' HeadBgColor='#F7DCBB'>
                                    <C> id='ACH_01'   width=70    name='1ȸ'        align=right   EditLimit=3</C>
                                    <C> id='ACH_02'   width=70    name='2ȸ'        align=right   EditLimit=3</C>
                                    <C> id='ACH_03'   width=70    name='3ȸ'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ACH_04'   width=70    name='4ȸ'        align=right   EditLimit=3    Show=false</C>
                                </G>
                                <G> name='������' HeadBgColor='#F7DCBB'>
                                    <C> id='ABL_01'   width=70    name='1ȸ'        align=right   EditLimit=3</C>
                                    <C> id='ABL_02'   width=70    name='2ȸ'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ABL_03'   width=70    name='3ȸ'        align=right   EditLimit=3    Show=false</C>
                                    <C> id='ABL_04'   width=70    name='4ȸ'        align=right   EditLimit=3    Show=false</C>
                                </G>
                                <C> id='TOTAL'        width=70    name='�հ�(%)'    Value={(ACH_01+ACH_02+ACH_03+ACH_04+ABL_01+ABL_02+ABL_03+ABL_04)} align=right  Edit=none</C>
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