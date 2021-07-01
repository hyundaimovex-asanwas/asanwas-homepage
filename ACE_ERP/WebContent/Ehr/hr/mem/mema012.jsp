<!--
    ************************************************************************************
    * @Source         : mema012.jsp                                                    *
    * @Description    : �λ�⺻3 PAGE                                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/01/16  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>
    <head>
    <title>�λ�⺻3</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

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

            if (form1.ENO_NO.value == "" || (parent.dsT_ME_PERSON.CountRow < 1 && parent.dsT_ME_PERSON.RowStatus(1) != 1)) {

                dsT_ME_PERSON.ClearData();
                dsT_ME_ARMY.ClearData();

                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

            trT_ME_PERSON.KeyValue = "SVL(O:dsT_ME_PERSON=dsT_ME_PERSON, O:dsT_ME_ARMY=dsT_ME_ARMY)";
            trT_ME_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema012.cmd.MEMA012CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            trT_ME_PERSON.post();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_ME_PERSON.IsUpdated && !dsT_ME_ARMY.IsUpdated) {
//                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                document.getElementById("txtENO_NO").value = document.getElementById("ENO_NO").value;

                trT_ME_PERSON2.KeyValue = "SVL(I:dsT_ME_PERSON=dsT_ME_PERSON, I:dsT_ME_ARMY=dsT_ME_ARMY)";
                trT_ME_PERSON2.action = "/servlet/GauceChannelSVL?cmd=hr.mem.a.mema012.cmd.MEMA012CMD&S_MODE=SAV";
                trT_ME_PERSON2.post();

            } else {

                return false;

            }

            return true;
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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_ME_PERSON.ClearData();
			dsT_ME_ARMY.ClearData();
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

            // �����ȣ �������ϰ�, �ּ� �Է��� ���
            if (document.getElementById("txtRZI_NO").value == "" && document.getElementById("txtRADR").value != "") {
                alert("�����ȣ�� �Է����� �����̽��ϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtRADR").focus();
                return false;
            }

            // �̸��� CHECK
            if (!fnc_ChgEmail()) {
                document.getElementById("txtE_MAIL").focus();
                return false;
            }

            // �ǽ��� CHECK
            if (!fnc_CheckDate(document.getElementById("txtPRO_YMD"), "�ǽ���") && document.getElementById("txtPRO_YMD").value != "") {
                document.getElementById("txtPRO_YMD").focus();
                return false;
            }

            // ����
            if (document.getElementById("txtCBLD_CD").value != "" &&
                document.getElementById("txtCBLD_NM").value == "") {
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtCBLD_CD").focus();
                return false;
            }
            
            // Ư��
            if (document.getElementById("txtSPEC_CD").value != "" &&
                document.getElementById("txtSPEC_NM").value == "") {
                alert("Ư���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtSPEC_CD").focus();
                return false;
            }

            // ��ȥ�� CHECK
            if (!fnc_CheckDate(document.getElementById("txtWED_YMD"), "��ȥ��") && document.getElementById("txtWED_YMD").value != "") {
                document.getElementById("txtWED_YMD").focus();
                return false;
            }
            
            // ����
            if (document.getElementById("txtREL_CD").value != "" &&
                document.getElementById("txtREL_NM").value == "") {
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                document.getElementById("txtREL_CD").focus();
                return false;
            }
            
            for ( i = 1; i <= dsT_ME_ARMY.CountRow; i++ ) {
                if ( dsT_ME_ARMY.RowStatus(i) == 1 ||
                     dsT_ME_ARMY.RowStatus(i) == 3 ) {
                     
                    // ��������
                    if( dsT_ME_ARMY.NameValue(i, "GUB_CD") == '' ) {
                        alert("���������� �ʼ� �Է»����Դϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return false;
                    }
                    
                    // ��������
                    if (dsT_ME_ARMY.NameValue(i, "GUB_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GUB_NM") == "") {
                        alert("���������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGUB_CD").focus();
                        return;
                    }
                    
                    // �����Ⱓ�� �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "ENL_YMD"), "������������") && dsT_ME_ARMY.NameValue(i, "ENL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtENL_YMD").focus();
                        return false;
                    }
                    
                    // �����Ⱓ�� �������� CHECK
                    if (!fnc_CheckDate2(dsT_ME_ARMY.NameValue(i, "MIL_YMD"), "������������") && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != "") {
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_YMD").focus();
                        return false;
                    }

                    // �����Ⱓ�� �������ڿ� �������� ��
                    if( dsT_ME_ARMY.NameValue(i, "ENL_YMD") != '' && dsT_ME_ARMY.NameValue(i, "MIL_YMD") != '' ) {
                        if( cfDateDiff(dsT_ME_ARMY.NameValue(i, "ENL_YMD").replace(/\-/g,''),dsT_ME_ARMY.NameValue(i, "MIL_YMD").replace(/\-/g,'')) < 0 ) {
                            alert("�������ڰ� �������ں��� Ů�ϴ�.");
                            dsT_ME_ARMY.RowPosition = i;
                            document.getElementById("txtENL_YMD").focus();
                            return false;
                        }
                    }

                    // ����
                    if (dsT_ME_ARMY.NameValue(i, "MIL_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MIL_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMIL_CD").focus();
                        return;
                    }

                    // ����
                    if (dsT_ME_ARMY.NameValue(i, "MBK_CD") != "" &&
                        dsT_ME_ARMY.NameValue(i, "MBK_NM") == "") {
                        alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtMBK_CD").focus();
                        return;
                    }

                    // ���
                    if (dsT_ME_ARMY.NameValue(i, "GRADE") != "" &&
                        dsT_ME_ARMY.NameValue(i, "GRADE_NM") == "") {
                        alert("����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                        dsT_ME_ARMY.RowPosition = i;
                        document.getElementById("txtGRADE").focus();
                        return;
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
            document.getElementById("txtENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

                document.getElementById("txtRADR").disabled      = false;
                document.getElementById("txtPHN_NO").disabled    = false;
                document.getElementById("txtEM_PHN_NO").disabled = false;
                document.getElementById("txtE_MAIL").disabled    = false;
                document.getElementById("txtPRO_YMD").disabled   = false;
                document.getElementById("txtEYE_LEF").disabled   = false;
                document.getElementById("txtEYE_RHT").disabled   = false;
                document.getElementById("txtHEIGHT").disabled    = false;
                document.getElementById("txtWEIGHT").disabled    = false;
                document.getElementById("txtAB_HGT").disabled    = false;
                document.getElementById("txtCBLD_CD").disabled   = false;
                document.getElementById("txtCBLD_NM").disabled   = false;
                document.getElementById("txtBLD_TYP").disabled   = false;
                
                document.getElementById("txtHOBBY").disabled       = false;
                document.getElementById("txtSPEC_CD").disabled     = false;
                document.getElementById("txtWED_YMD").disabled     = false;
                document.getElementById("txtREL_CD").disabled      = false;
                
                document.getElementById("txtGUB_CD").disabled   = false;
                document.getElementById("txtENL_YMD").disabled  = false;
                document.getElementById("txtMIL_YMD").disabled  = false;
                document.getElementById("txtMIL_CD").disabled   = false;
                document.getElementById("txtMBK_CD").disabled   = false;
                document.getElementById("txtGRADE").disabled    = false;
                
                document.getElementById("ImgRziNo").disabled     = false;
                document.getElementById("ImgProYmd").disabled    = false;
                document.getElementById("ImgCbldCd").disabled    = false;
                
                document.getElementById("ImgSpecCd").disabled      = false;
                document.getElementById("ImgWedYmd").disabled      = false;
                document.getElementById("ImgRelCd").disabled       = false;
                
                document.getElementById("ImgGubCd").disabled    = false;
                document.getElementById("ImgEnlYmd").disabled   = false;
                document.getElementById("ImgMilYmd").disabled   = false;
                document.getElementById("ImgMilCd").disabled    = false;
                document.getElementById("ImgMbkCd").disabled    = false;
                document.getElementById("ImgGrade").disabled    = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtRADR").disabled      = true;
                document.getElementById("txtPHN_NO").disabled    = true;
                document.getElementById("txtEM_PHN_NO").disabled = true;
                document.getElementById("txtE_MAIL").disabled    = true;
                document.getElementById("txtPRO_YMD").disabled   = true;
                document.getElementById("txtEYE_LEF").disabled   = true;
                document.getElementById("txtEYE_RHT").disabled   = true;
                document.getElementById("txtHEIGHT").disabled    = true;
                document.getElementById("txtWEIGHT").disabled    = true;
                document.getElementById("txtAB_HGT").disabled    = true;
                document.getElementById("txtCBLD_CD").disabled   = true;
                document.getElementById("txtCBLD_NM").disabled   = true;
                document.getElementById("txtBLD_TYP").disabled   = true;
                
                document.getElementById("txtHOBBY").disabled       = true;
                document.getElementById("txtSPEC_CD").disabled     = true;
                document.getElementById("txtWED_YMD").disabled     = true;
                document.getElementById("txtREL_CD").disabled      = true;
                
                document.getElementById("txtGUB_CD").disabled   = true;
                document.getElementById("txtENL_YMD").disabled  = true;
                document.getElementById("txtMIL_YMD").disabled  = true;
                document.getElementById("txtMIL_CD").disabled   = true;
                document.getElementById("txtMBK_CD").disabled   = true;
                document.getElementById("txtGRADE").disabled    = true;

                document.getElementById("ImgRziNo").disabled     = true;
                document.getElementById("ImgProYmd").disabled    = true;
                document.getElementById("ImgCbldCd").disabled    = true;
                
                document.getElementById("ImgSpecCd").disabled      = true;
                document.getElementById("ImgWedYmd").disabled      = true;
                document.getElementById("ImgRelCd").disabled       = true;
                
                document.getElementById("ImgGubCd").disabled    = true;
                document.getElementById("ImgEnlYmd").disabled   = true;
                document.getElementById("ImgMilYmd").disabled   = true;
                document.getElementById("ImgMilCd").disabled    = true;
                document.getElementById("ImgMbkCd").disabled    = true;
                document.getElementById("ImgGrade").disabled    = true;

            }
        }

        function fnc_UsrpostPopup(zip_no, addr, addr2) {
            var no = document.getElementById(zip_no).value;

            fnc_postPopup(zip_no, addr);

            if (document.getElementById(zip_no).value != "") {
                if (document.getElementById(zip_no).value.substr(3,1) != '-') {
                    document.getElementById(zip_no).value = document.getElementById(zip_no).value.substr(0,3) + '-' + document.getElementById(zip_no).value.substr(3,3);
                }

                if (no != document.getElementById(zip_no).value) {
                    document.getElementById(addr2).value = '';
                }
            }
        }

        function fnc_ChgEmail() {
            var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;

            if (document.getElementById("txtE_MAIL").value == "") {
                return true;
            }

            if (document.getElementById("txtE_MAIL").value.search(format) == -1) {
                alert("��ȿ�� �̸��� �ּҰ� �ƴմϴ�.");
                document.getElementById("txtE_MAIL").focus();

                return false;
            }

            return true;
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
    | 2. �̸� : dsT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_ME_ARMY                       |
    | 3. Table List : T_ME_ARMY                   |
    +----------------------------------------------->
    <Object ID="dsT_ME_ARMY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_PERSON                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>
    
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_ME_PERSON2                       |
    | 3. Table List : T_ME_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_ME_PERSON2" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_ME_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ME_PERSON.CountRow);
            document.getElementById("resultMessage").innerText = '';

        }

    </Script>
    
    <Script For=dsT_ME_ARMY Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {
        
            if (dsT_ME_ARMY.CountColumn == 0) {
                dsT_ME_ARMY.setDataHeader("ENO_NO:STRING:KEYVALUETYPE, GUB_CD:STRING, GUB_NM:STRING, MIC_CD:STRING, MIC_NM:STRING, LOC_CD:STRING, LOC_NM:STRING, MIL_CD:STRING, MIL_NM:STRING, ENL_YMD:STRING, MIL_YMD:STRING, YSE_CD:STRING, YSE_NM:STRING, GRADE:STRING, GRADE_NM:STRING, MIL_NO:STRING, MBK_CD:STRING, MBK_NM:STRING, MIL_DES:STRING, REMARK:STRING");
            }

            if (dsT_ME_ARMY.CountRow > 0) {
                return;
            }
            
            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_ME_ARMY.AddRow();
            dsT_ME_ARMY.NameValue(dsT_ME_ARMY.RowPosition,"ENO_NO") = document.getElementById("ENO_NO").value;

        } else {

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_ME_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_ME_ARMY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ME_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>
    
    <Script For=dsT_ME_ARMY Event="OnDataError()">

        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_ME_PERSON event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>
    
    <script for=trT_ME_PERSON2 event="OnSuccess()">

//        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        if (parent.savflag != '1') {
            parent.savflag = 1;
        }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_ME_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>
    
    <script for=trT_ME_PERSON2 event="OnFail()">

        cfErrorMsg(this);

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
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�⺻3</strong>
        </td>
        <td height="20" align="right">
            <input type=hidden id="ENO_NO" size="10">
            <!--a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>-->
            <!--<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>-->
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="72 "></col>
                    <col width="64 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">�ǰ�����</td>
                    <td align="center" class="creamBold">�����ȣ</td>                    
                    <td class="padding2423">
                        <input id="txtRZI_NO" size="7" maxlength="7" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRziNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRziNo" name="ImgRziNo" width="21" height="20" border="0" align="absmiddle" onClick="fnc_UsrpostPopup('txtRZI_NO','txtRADR_CT','txtRADR')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtRADR_CT" style="width:53%" class="input_ReadOnly" readonly> <input id="txtRADR" maxlength="60" style="width:46%"></td>
                </tr>                
            </table>
            
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="78 "></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                    <col width="65 "></col>
                    <col width="115"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >������ȣ</td>
                    <td align="center" class="creamBold">��ȭ��ȣ</td>
                    <td class="padding2423">
                        <input id="txtPHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtEM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="15" onKeyPress="JavaScript: cfCheckNumber();">
                    </td>
                    <td align="center" class="creamBold">E-mail</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtE_MAIL" maxlength="40" style="width:100%" onChange="fnc_ChgEmail();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">��ü����</td>
                    <input type=hidden id="txtENO_NO">
                    <input type=hidden id="txtOCC_CD" size="1">
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtPRO_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�ǽ���');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgProYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgProYmd" name="ImgProYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPRO_YMD','','10','52');"></a>
                    </td>
                    <td align="center" class="creamBold">�÷�(��)</td>
                    <td class="padding2423" >
                        <input id="txtEYE_LEF" maxlength="4" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">�÷�(��)</td>
                    <td class="padding2423" >
                        <input id="txtEYE_RHT" maxlength="4" style="width:100%;text-align:right;"onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtHEIGHT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">ü&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtWEIGHT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
                        <input id="txtAB_HGT" maxlength="5" style="width:100%;text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfCheckNumber3();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtCBLD_CD" style="width:17%" maxlength="2"  onChange="fnc_GetCommNm('D4', 'txtCBLD_CD','txtCBLD_NM');"> <input id="txtCBLD_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgCbldCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgCbldCd" name="ImgCbldCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtCBLD_CD','txtCBLD_NM','����','D4')"></a>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtBLD_TYP" maxlength="5" style="width:100%">
                    </td>
                </tr>
            </table>

            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="72"></col>
                    <col width="64"></col>
                    <col width="165"></col>
                    <col width="64"></col>
                    <col width="165"></col>
                    <col width="64"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">��������</td>
                    <td align="center" class="creamBold">��������</td>                    
                    <td class="padding2423">
                        <input id="txtGUB_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F1', 'txtGUB_CD','txtGUB_NM');"> <input id="txtGUB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGubCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGubCd" name="ImgGubCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGUB_CD','txtGUB_NM','��������','F1')"></a>
                    </td>
                    <td align="center" class="creamBold">�����Ⱓ</td>                    
                    <td class="padding2423" colspan="3">
                        <input id="txtENL_YMD" style="width:20%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnlYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnlYmd" name="ImgEnlYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtENL_YMD','','420','0');"></a>
                        ~
                        <input id="txtMIL_YMD" style="width:20%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilYmd" name="ImgMilYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMIL_YMD','','535','0');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>                    
                    <td class="padding2423">
                        <input id="txtMIL_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F4', 'txtMIL_CD','txtMIL_NM');"> <input id="txtMIL_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMilCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMilCd" name="ImgMilCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMIL_CD','txtMIL_NM','����','F4')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>                    
                    <td class="padding2423">
                        <input id="txtMBK_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F7', 'txtMBK_CD','txtMBK_NM');"> <input id="txtMBK_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMbkCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgMbkCd" name="ImgMbkCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtMBK_CD','txtMBK_NM','����','F7')"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>                    
                    <td class="padding2423">
                        <input id="txtGRADE" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('F6', 'txtGRADE','txtGRADE_NM');"> <input id="txtGRADE_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGrade','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgGrade" name="ImgGrade" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtGRADE','txtGRADE_NM','���','F6')"></a>
                    </td>
                </tr>
            </table>
                
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="72 "></col>
                    <col width="64 "></col>
                    <col width="106"></col>
                    <col width="64 "></col>
                    <col width="105"></col>
                    <col width="64 "></col>
                    <col width="106"></col>
                    <col width="64 "></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��Ÿ����</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"><input id="txtHOBBY" maxlength="20" style="width:100%"></td>
                    <td align="center" class="creamBold">Ư&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtSPEC_CD" style="width:18%" maxlength="3" onChange="fnc_GetCommNm('D1', 'txtSPEC_CD','txtSPEC_NM');"> <input id="txtSPEC_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSpecCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgSpecCd" name="ImgSpecCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSPEC_CD','txtSPEC_NM','Ư��','D1')"></a>
                    </td>
                    <td align="center" class="creamBold">�� ȥ ��</td>
                    <td class="padding2423">
                        <input id="txtWED_YMD" style="width:72%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��ȥ��');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgWedYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgWedYmd" name="ImgWedYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtWED_YMD','','120','80');"></a>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:18%" maxlength="2" onChange="fnc_GetCommNm('D2', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','����','D2')"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO          Param=value Disable=disabled</C>
        <C> Col=RZI_NO        Ctrl=txtRZI_NO       Param=value </C>
        <C> Col=RADR          Ctrl=txtRADR         Param=value </C>
        <C> Col=RADR_CT       Ctrl=txtRADR_CT      Param=value </C>
        <C> Col=PHN_NO        Ctrl=txtPHN_NO       Param=value </C>
        <C> Col=EM_PHN_NO     Ctrl=txtEM_PHN_NO    Param=value </C>
        <C> Col=E_MAIL        Ctrl=txtE_MAIL       Param=value </C>
        <C> Col=PRO_YMD       Ctrl=txtPRO_YMD      Param=value </C>
        <C> Col=EYE_LEF       Ctrl=txtEYE_LEF      Param=value </C>
        <C> Col=EYE_RHT       Ctrl=txtEYE_RHT      Param=value </C>
        <C> Col=HEIGHT        Ctrl=txtHEIGHT       Param=value </C>
        <C> Col=WEIGHT        Ctrl=txtWEIGHT       Param=value </C>
        <C> Col=AB_HGT        Ctrl=txtAB_HGT       Param=value </C>
        <C> Col=CBLD_CD       Ctrl=txtCBLD_CD      Param=value </C>
        <C> Col=CBLD_NM       Ctrl=txtCBLD_NM      Param=value </C>
        <C> Col=BLD_TYP       Ctrl=txtBLD_TYP      Param=value </C>
        
        <C> Col=HOBBY         Ctrl=txtHOBBY          Param=value </C>
        <C> Col=SPEC_CD       Ctrl=txtSPEC_CD        Param=value </C>
        <C> Col=SPEC_NM       Ctrl=txtSPEC_NM        Param=value </C>
        <C> Col=WED_YMD       Ctrl=txtWED_YMD        Param=value </C>
        <C> Col=REL_CD        Ctrl=txtREL_CD         Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM         Param=value </C>
    '>
</object>

<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ME_ARMY">
    <Param Name="BindInfo", Value='
        <C> Col=GUB_CD        Ctrl=txtGUB_CD       Param=value </C>
        <C> Col=GUB_NM        Ctrl=txtGUB_NM       Param=value </C>
        <C> Col=ENL_YMD       Ctrl=txtENL_YMD      Param=value </C>
        <C> Col=MIL_YMD       Ctrl=txtMIL_YMD      Param=value </C>        
        <C> Col=MIL_CD        Ctrl=txtMIL_CD       Param=value </C>
        <C> Col=MIL_NM        Ctrl=txtMIL_NM       Param=value </C>
        <C> Col=MBK_CD        Ctrl=txtMBK_CD       Param=value </C>
        <C> Col=MBK_NM        Ctrl=txtMBK_NM       Param=value </C>
        <C> Col=GRADE         Ctrl=txtGRADE        Param=value </C>
        <C> Col=GRADE_NM      Ctrl=txtGRADE_NM     Param=value </C>
    '>
</object>