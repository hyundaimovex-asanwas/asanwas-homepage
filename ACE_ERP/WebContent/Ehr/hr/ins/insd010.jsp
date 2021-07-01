<!--*************************************************************************
* @source      : insd010.jsp                                                *
* @description : ��뺸��Ű����� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/02/28            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>��뺸��Ű�����(insd010)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.d.insd010.cmd.INSD010CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            // �������� �Է� �ʼ�
            if( document.form1.txtSTR_YMD_SHR.value=="" ){
                alert("���� �������ڸ� �Է��Ͻʽÿ�. ��)"+today.substr(0,8)+"01");
                return;
            }
            if( document.form1.txtEND_YMD_SHR.value=="" ){
                alert("���� �������Ḧ �Է��Ͻʽÿ�. ��)"+today);
                return;
            }

            var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;

            if(OCC_CD_SHR == "0") OCC_CD_SHR = "";

            params = "&STR_YMD_SHR="+STR_YMD_SHR
                   + "&END_YMD_SHR="+END_YMD_SHR
                   + "&OCC_CD_SHR="+OCC_CD_SHR;

            if(document.tabINSD010.ActiveIndex==1){
                dsT_CM_PERSON_01.dataid = dataClassName+"&S_MODE=SHR_01"+params;
                dsT_CM_PERSON_01.reset();
            } else if(document.tabINSD010.ActiveIndex==2){
                dsT_CM_PERSON_02.dataid = dataClassName+"&S_MODE=SHR_02"+params;
                dsT_CM_PERSON_02.reset();
            } else if(document.tabINSD010.ActiveIndex==3){
                dsT_CM_PERSON_03.dataid = dataClassName+"&S_MODE=SHR_03"+params;
                dsT_CM_PERSON_03.reset();
            }


        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {
           // �������� �Է� �ʼ�
            if( document.form1.txtSTR_YMD_SHR.value=="" ){
                alert("���� �������ڸ� �Է��Ͻʽÿ�. ��)"+today.substr(0,8)+"01");
                return;
            }
            if( document.form1.txtEND_YMD_SHR.value=="" ){
                alert("���� �������Ḧ �Է��Ͻʽÿ�. ��)"+today);
                return;
            }
            var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
            var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
            var occ_cd  = document.getElementById("cmbOCC_CD_SHR").value;

            var str_ymd = str_ymd_shr.substr(0,4) + str_ymd_shr.substr(5,2) + str_ymd_shr.substr(8,2);
            var end_ymd = end_ymd_shr.substr(0,4) + end_ymd_shr.substr(5,2) + end_ymd_shr.substr(8,2);
            var ymd_val = "( " + str_ymd_shr.substr(0,4) + "/" + str_ymd_shr.substr(5,2) + "/" + str_ymd_shr.substr(8,2) + " - ";
            var ymd_val = ymd_val + end_ymd_shr.substr(0,4) + "/" + end_ymd_shr.substr(5,2) + "/" + end_ymd_shr.substr(8,2) + " )";
			if(document.tabINSD010.ActiveIndex==1){
	            var url = "insd010_PV.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	} else if(document.tabINSD010.ActiveIndex==2){
        		var url = "insd010_PV_1.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	} else if(document.tabINSD010.ActiveIndex==3){
        		var url = "insd010_PV_2.jsp?str_ymd="+str_ymd_shr+"&end_ymd="+end_ymd_shr+"&occ_cd="+occ_cd+"&ymd_val="+ymd_val;
    	        window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        	    return;
        	}

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {

            if(document.tabINSD010.ActiveIndex==1){
                if (dsT_CM_PERSON_01.CountRow < 1) {
                    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                    return;
                }
                form1.grdT_CM_PERSON_01.GridToExcel("��뺸��Ű�����(�����)", '', 225)
            } else if (document.tabINSD010.ActiveIndex==2){
                if (dsT_CM_PERSON_02.CountRow < 1) {
                    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                    return;
                }
                form1.grdT_CM_PERSON_02.GridToExcel("��뺸��Ű�����(�����)", '', 225)
            } else {
                if (dsT_CM_PERSON_03.CountRow < 1) {
                    alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                    return;
                }
                form1.grdT_CM_PERSON_03.GridToExcel("��뺸��Ű�����(����������)", '', 225)
            }
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {

            document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
            document.form1.txtEND_YMD_SHR.value = today;
            document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON_01.ClearData();
            dsT_CM_PERSON_02.ClearData();
            dsT_CM_PERSON_03.ClearData();
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CM_PERSON_01.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            if (dsT_CM_PERSON_02.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            if (dsT_CM_PERSON_03.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

            // �ٷα��� ���� �˻� �޺��ڽ� ����
            for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);
            }

            //ȭ���ħ���� �ӽ� �ذ�
            document.tabINSD010.ActiveIndex=2;
            document.tabINSD010.ActiveIndex=1;

            document.form1.txtSTR_YMD_SHR.value = today.substr(0,8)+"01";
            document.form1.txtEND_YMD_SHR.value = today;

            cfStyleGrid(form1.grdT_CM_PERSON_01,0,"false","false");      // Grid Style ����
            cfStyleGrid(form1.grdT_CM_PERSON_02,0,"false","false");      // Grid Style ����
            cfStyleGrid(form1.grdT_CM_PERSON_03,0,"false","false");      // Grid Style ����
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {
            //if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
        }

        /********************************************
         * ��¥ ���� ��ȿ�� üũ                                     *
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

        /********************************************
         * �������ڿ��� ��Ŀ�� ������ �������ڿ� ��              *
         ********************************************/
        function cfCheckDateTerm2(p_obj,p_stdt,p_endt) {
            if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
                if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
                    alert("�������ڰ� �������ں��� Ů�ϴ�.");
                    document.getElementById(p_obj).value = '';
                }
            }
        }
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ����� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON_01_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>
    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
        <Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON_01=dsT_CM_PERSON_01,O:dsT_CM_PERSON_02=dsT_CM_PERSON_02,O:dsT_CM_PERSON_03=dsT_CM_PERSON_03)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_01.CountRow);

            //ds copy�� Status�� ������ �����Ƿ� tr���� �Ѱ����� insert�� update�� ���� ���Ѵ�.
            cfCopyDataSet(dsT_CM_PERSON_01, dsT_CM_PERSON_01_CP, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_CM_PERSON_01.CountRow);

            //�� �÷��� status�� �ٲپ� �־� cmd�� ���� �Ѿ�� �ְ� �Ѵ�.
            for(var i=1;i<=dsT_CM_PERSON_01.CountRow; i++){
                dsT_CM_PERSON_01_CP.UserStatus(i)=1;
            }
        }
    </Script>

    <Script For=dsT_CM_PERSON_02 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_02.CountRow);
        }
    </Script>

    <Script For=dsT_CM_PERSON_03 Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_PERSON_03.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    <Script For=dsT_CM_PERSON_02 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    <Script For=dsT_CM_PERSON_03 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON_01 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_CM_PERSON_02 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    <Script For=dsT_CM_PERSON_03 Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CM_PERSON event="OnFail()">
        alert(trT_CM_PERSON.ErrorMsg);
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

    <!-- Ķ���� ������-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��뺸��Ű�����</td>
                    <td align="right" class="navigator">HOME/�����Ļ�/��뺸��/<font color="#000000">��뺸��Ű�����</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" class="greenTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="60"></col>
                    <col width="230"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">�Ⱓ</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                         ~
                        <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTerm2('txtEND_YMD_SHR', 'txtSTR_YMD_SHR', 'txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','208','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td class="searchState" align="right">�ٷα���</td>
                    <td class="padding2423" align="left">
                        <select id="cmbOCC_CD_SHR" onChange="fnc_SearchList()">
                            <option value="0">���</option>
                        </select>
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

    <!-- �� ��� ���۳�Ʈ ���� -->
    <comment id="__NSID__">
    <object id=tabINSD010 classid=CLSID:6BA6E0F6-E3A1-45ED-9E03-CBFC682EC63C
            style="position:absolute; left:20; top:155; width:600; height:20;font-size: 12px;font-weight: bolder">
        <param name="BackColor"             value="#F8B97B">
        <param name="DisableBackColor"  value="#EEEEEE">
        <param name="TextColor"             value="#000000">
        <param name="DisableTextColor"      value="#878787">
        <param name="ActiveIndex"               value="1">

        <param  name="Format"
                value='
                    <T>divid="tabINSD010_01"    title="�����"</T>
                    <T>divid="tabINSD010_02"    title="�����"</T>
                    <T>divid="tabINSD010_03"    title="�ٷα��к�����"</T>
                    '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>

    <!-- ��1 ���� �Է� ���̺� ���� -->
    <div class=page id="tabINSD010_01" style="position:absolute; left:20; top:175; width:800; height:300; z-index:3;" >

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_01">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50    name="NO"           align=center    Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM       width=80        align=center        name=�Ҽ�               </C>
                            <C> id=JOB_NM       width=80        align=center        name=����               </C>
                            <C> id=ENO_NO       width=80        align=center        name=���               </C>
                            <C> id=ENO_NM       width=60        align=center        name=����               </C>
                            <C> id=CET_NO       width=120       align=center        name=�ֹι�ȣ           </C>
                            <C> id=ZIP_NO       width=60        align=center        name=�����ȣ           </C>
                            <C> id=ADDRESS      width=280       align=left          name=�ּ�             RightMargin=10  </C>
                            <C> id=PHN_NO       width=80        align=center        name=��ȭ��ȣ           </C>
                            <C> id=HIR_YMD      width=80        align=center        name=�����             </C>
                            <C> id=GET_RSN      width=80        align=center        name=������           </C>
                            <C> id=LAST_YMD     width=80        align=center        name=������             </C>
                            <C> id=EDGR_NM      width=80        align=center        name=�з�               </C>
                            <C> id=OCC_NM       width=80        align=center        name=�ٷα���               </C>
                            <C> id=STDB_AMT     width=80        align=center        name=������ӱ�         </C>
                            <C> id=WRK_HOUR     width=80        align=center        name=�ֱٷνð�         </C>
                            <C> id=HIR_PATH     width=80        align=center        name=ä����           </C>
                            <C> id=HDC_NM       width=80        align=center        name=��������           </C>
                            <C> id=HDC_GRA      width=80        align=center        name=���ص��           </C>
                            <C> id=REG_YMD      width=80        align=center        name=�Ű���             </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- ��1 ���� �Է� ���̺� �� -->

    <!-- ��2 ���� �Է� ���̺� ���� -->
    <div class=page id="tabINSD010_02" style="position:absolute; left:20; top:175; width:800; height:300; z-index:2; visibility:hidden">

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_02">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50    name="NO"           align=center    Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM       width=80        align=center        name=�Ҽ�               </C>
                            <C> id=JOB_NM       width=80        align=center        name=����               </C>
                            <C> id=ENO_NO       width=80        align=center        name=���               </C>
                            <C> id=ENO_NM       width=60        align=center        name=����               </C>
                            <C> id=CET_NO       width=120       align=center        name=�ֹι�ȣ           </C>
                            <C> id=ZIP_NO       width=60        align=center        name=�����ȣ           </C>
                            <C> id=ADDRESS      width=280       align=left          name=�ּ�             LeftMargin=10  </C>
                            <C> id=PHN_NO       width=80        align=center        name=��ȭ��ȣ           </C>
                            <C> id=RET_YMD      width=80        align=center        name=�ڰݻ����         </C>
                            <C> id=OCC_NM       width=80        align=center        name=�ٷα���               </C>
                            <C> id=RET_NM       width=80        align=center        name=��Ǳ�ü����       </C>
                            <C> id=RET_CD       width=80        align=center        name=��ǻ���           </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- ��2 ���� �Է� ���̺� �� -->

    <!-- ��3 ���� �Է� ���̺� ���� -->
    <div class=page id="tabINSD010_03" style="position:absolute; left:20; top:175; width:800; height:300; z-index:2; visibility:hidden">

        <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_CM_PERSON_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_CM_PERSON_03">
                        <param name="Editable" value="false">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"       width=50        align=center        name="NO"       Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=DPT_NM           width=80        align=center        name=�Ҽ�           </C>
                            <C> id=JOB_NM           width=80        align=center        name=����           </C>
                            <C> id=ENO_NO           width=80        align=center        name=���           </C>
                            <C> id=ENO_NM           width=60        align=center        name=����           </C>
                            <C> id=CET_NO           width=120       align=center        name=�ֹι�ȣ       </C>
                            <C> id=ZIP_NO           width=60        align=center        name=�����ȣ       </C>
                            <C> id=ADDRESS          width=280       align=left          name=�ּ�                 LeftMargin=10  </C>
                            <C> id=PHN_NO           width=80        align=center        name=��ȭ��ȣ       </C>
                            <C> id=CHANGE_YMD       width=80        align=center        name=������         </C>
                            <C> id=CHANGE_DPT_NM    width=80        align=center        name=�������μ�     </C>
                            <C> id=CHANGE_JOB_NM    width=80        align=center        name=����������     </C>
                            <C> id=CHANGE_AMT       width=80        align=center        name=�������ݾ�     </C>
                            <C> id=BEFORE_DPT_NM    width=80        align=center        name=�����ĺμ�     </C>
                            <C> id=BEFORE_JOB_NM    width=80        align=center        name=����������     </C>
                            <C> id=BEFORE_AMT       width=80        align=center        name=�����ıݾ�     </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>

    </div>
    <!-- ��3 ���� �Է� ���̺� �� -->

    </form>
    <!-- form �� -->

</body>
</html>
