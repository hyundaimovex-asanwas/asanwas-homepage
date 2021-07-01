<!--
    ************************************************************************************
    * @Source         : vlub090.jsp                                                    *
    * @Description    : ���ǽ�û(����)_����.                                                *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/25  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/16  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>���ǽ�û(����)_����(vlug090)</title>
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

            if( !fnc_SearchItemCheck() ) return;

            //�����ͼ� ����(���ǽ�û(����)_����)
            dsT_EV_PROTEST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub090.cmd.VLUB090CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=3&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value+"&cmbHEAD_CD_SHR="+document.getElementById("cmbHEAD_CD_SHR").value;
            dsT_EV_PROTEST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�⵵�� ��ȸ������ ��ȸ
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=3";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck('1') )    return;

            for( i=1; i<=dsT_EV_PROTEST.CountRow; i++ ) {
                if( dsT_EV_PROTEST.RowStatus(i) == '3' ) {        //�������½�
                    if( dsT_EV_PROTEST.NameValue(i,"ACCEPT_GBN") == 'T' ) {        //üũ�Ȱ�
                        if( dsT_EV_PROTEST.NameValue(i, "ANSWER_YMD") == '' )        //�亯�� �ȵȰ�
                            dsT_EV_PROTEST.NameValue(i, "ACCEPT_DEC") = document.getElementById("txtACCEPT_DEC").value;
                    } else
                        dsT_EV_PROTEST.NameValue(i, "ACCEPT_DEC") = '';
                }
            }

            //Ʈ����� ����
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub090.cmd.VLUB090CMD&S_MODE=SAV";
            trT_EV_PROTEST.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

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

            if (dsT_EV_PROTEST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_PROTEST.GridToExcel("���ǽ�û(����)_����", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

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

            document.getElementById("txtACCEPT_DEC").value = '';
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbHEAD_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_PROTEST.ClearAll();

            document.getElementById("txtACCEPT_YMD").value = getToday();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if (dsT_EV_PROTEST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( form1.txtEVL_YY_SHR.value == '') {
                alert("�ش�⵵�� �ʼ� �Է»����Դϴ�.");
                form1.txtEVL_YY_SHR.focus();
                return false;
            }
            if( form1.txtEVL_FRQ_SHR.value == '') {
                alert("ȸ���� �ʼ� �Է»����Դϴ�.");
                form1.txtEVL_FRQ_SHR.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck(saveDiv) {

            if ( dsT_EV_PROTEST.isUpdated ) {
                if( document.getElementById("txtACCEPT_YMD").value == '' ) {
                    alert("�������ڸ� �Է��� �ּ���.");
                    document.getElementById("txtACCEPT_YMD").focus();
                    return false;
                }
                for( i=1; i<=dsT_EV_PROTEST.CountRow; i++ ) {
                    if( dsT_EV_PROTEST.NameValue(i,"ACCEPT_YMD") != '' && cfDateExpr(dsT_EV_PROTEST.NameValue(i,"ACCEPT_YMD")) == false ) {
                        alert("�������ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ACCEPT_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ACCEPT_GBN") == 'T' && dsT_EV_PROTEST.NameValue(i,"ACCEPT_YMD")=='' ) {
                        alert("�������ڸ� �Է��� �ּ���.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ACCEPT_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ACCEPT_GBN") == 'F' && dsT_EV_PROTEST.NameValue(i,"ACCEPT_YMD")!='' ) {
                        alert("�������θ� üũ�� �ּ���.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ACCEPT_GBN");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
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
            cfStyleGrid(form1.grdT_EV_PROTEST, 15, "true", "false");

            document.getElementById("txtACCEPT_YMD").value = getToday();

            // ��������
            if (frameid == "vlug090") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }


            //���� �޺�
            var oOption;
            for( i=1; i<=dsCOMMON_EG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsCOMMON_EG.NameValue(i,"CODE");
                oOption.text = dsCOMMON_EG.NameValue(i,"CODE_NAME");
                document.getElementById("cmbHEAD_CD_SHR").add(oOption);
            }

            form1.grdT_EV_PROTEST.ColumnProp('FILE_GBN','Cursor')="hand";

            //���κ� �� ���� ���� ���� Ȥ�� ��ȸ������   (��ȸ)
            fnc_SearchItem();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ���� �ϰ��ݿ�  ó�� �κ�  *
         *******************************************/
        function fnc_AcceptGbnSet() {

            if( dsT_EV_PROTEST.CountRow < 1 ) {
                alert("�ϰ��ݿ��� �ڷᰡ �����ϴ�.");
                return;
            }
            if( document.getElementById("txtACCEPT_YMD").value == '' ) {
                alert("�������ڸ� �Է��� �ּ���.");
                return;
            }
            if( document.getElementById("txtACCEPT_YMD").value.length != 10 ) {
                alert("�������ڰ� ��¥���Ŀ� ���Ŀ� �����ʽ��ϴ�.");
                return;
            }
            if( document.getElementById("txtACCEPT_DEC").value == '' ) {
                alert("���������� �Է��� �ּ���.");
                return;
            }
            if( !cfCheckLength('txtACCEPT_DEC','��������','4000') ) {
                return;
            }
            for( i=1; i<=dsT_EV_PROTEST.CountRow; i++ ) {
                if( dsT_EV_PROTEST.NameValue(i, "ANSWER_YMD") == '' && dsT_EV_PROTEST.NameValue(i, "ACCEPT_GBN") == 'F' )    {    //�亯�� �ȵȰͰ� �����ȵȰ�
                    dsT_EV_PROTEST.NameValue(i, "ACCEPT_YMD") = document.getElementById("txtACCEPT_YMD").value.replace(/\-/g,'');
                    dsT_EV_PROTEST.NameValue(i, "ACCEPT_DEC") = document.getElementById("txtACCEPT_DEC").value;
                    dsT_EV_PROTEST.NameValue(i, "ACCEPT_GBN") = 'T';
                }
            }

        }

        /********************
         * 16. ����Ű ó��  *
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
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_PROTEST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_EV_PROTEST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_EV_PROTEST)">
    </Object>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_EG"/>
       <jsp:param name="CODE_GUBUN"  value="B2"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script language=JavaScript for=grdT_EV_PROTEST event=OnClick(row,colid)>

        if( colid == 'ACCEPT_GBN' ) {

            if( dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,'ANSWER_YMD') != '' ) {
                alert('�̹� �亯 �Ϸ�� �ڷ�� ���� ��Ұ� �Ұ� �մϴ�.');
                return false;
            }

            if( dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,colid) == 'T' )
                dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,"ACCEPT_YMD") = getToday().replace(/\-/g,'');
            if( dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,colid) == 'F' )
                dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,"ACCEPT_YMD") = '';

        }
        else if( colid == 'FILE_GBN' ) {
            if (dsT_EV_PROTEST.NameValue(row, "FILE_NAME") != "") {    // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
                cfDownload(dsT_EV_PROTEST.NameValue(row, "FILE_NAME"), dsT_EV_PROTEST.NameValue(row, "FILE_URL"));
            }
        }

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_PROTEST.CountRow);

        }

           form1.txtACCEPT_YMD.focus();//set focus

    </Script>

   <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';
            alert("������Ⱓ�� �ƴմϴ�.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnLoadError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_PROTEST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_PROTEST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"),"MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_PROTEST event="OnFail()">

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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SaveOver.gif',2)">  <img src="/images/button/btn_SaveOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',3)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="65"></col>
                                <col width="40"></col>
                                <col width="40"></col>
                                <col width="40"></col>
                                <col width="40"></col>
                                <col width="115"></col>
                                <col width="45"></col>
                                <col width="155"></col>
                                <col width="45"></col>
                                <col width="160"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                    <td class="padding2423"><input id="txtEVL_YY_SHR" name="txtEVL_YY_SHR" size="4" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchState">ȸ��&nbsp;</td>
                                    <td class="padding2423"><input id="txtEVL_FRQ_SHR" name="txtEVL_FRQ_SHR" size="2" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchState">����&nbsp;</td>
                                    <td class="padding2423">
                                        <select name="cmbHEAD_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>�� ü</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">�Ҽ�&nbsp;</td>
                                    <td class="padding2423"><input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <input id=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image30" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                    </td>
                                    <td align="right" class="searchState"> ���&nbsp;</td>
                                    <td class="padding2423"><input name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();">
                                        <input id=txtENO_NM_SHR size="8" class="input_ReadOnly" style="text-align:center" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image31','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image31" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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

    <!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="150"></col>
                        <col width="150"></col>
                        <col width="150"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">��������</td>
                        <td class="padding2423"><input id=txtACCEPT_YMD name=txtACCEPT_YMD style="ime-mode:disabled;text-align:center;" size="12" maxlength=10 onblur="cfCheckDate(this);cfDateExpr(this.value);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtACCEPT_YMD','','300','50');"></a>
                        </td>
                        <td align="center" class="creamBold">��������</td>
                        <td class="padding2423"><input id=txtACCEPT_DEC name=txtACCEPT_DEC size="50">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� �Է� ���̺� �� 1 -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                        <td align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btn','','/images/button/BatchAdjustOver.gif',1)"><img src="/images/button/BatchAdjustOn.gif" id="btn" name="btn" width="80" height="20" border="0" align="absmiddle" onClick="fnc_AcceptGbnSet()"></a>
                        </td>
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
                            <object    id="grdT_EV_PROTEST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
                                <param name="DataID"                            value="dsT_EV_PROTEST">
                                <param name="EdiTABLE"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                    value="Left">
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="UsingOneClick"             value="1">
                                <param name="AutoReSizing"              value="true">
                                <param name="ColSizing"                 value="true">
                                <param name="Format"                    value="
                                    <C> id='EVL_YY'           width=40        name='�⵵'         align=center  show=false </C>
                                    <C> id='EVL_GBN'          width=40        name='����'         align=center  show=false </C>
                                    <C> id='EVL_FRQ'          width=40        name='ȸ��'         align=center  show=false </C>
                                    <C> id='HEAD_NM'          width=100       name='����'         align=left    edit=none </C>
                                    <C> id='DPT_NM'           width=100       name='�Ҽ�'         align=left    edit=none </C>
                                    <C> id='JOB_NM'           width=80        name='����'         align=left    edit=none </C>
                                    <C> id='ENO_NO'           width=80        name='���'         align=center  edit=none </C>
                                    <C> id='ENO_NAME'         width=80        name='����'         align=center  edit=none </C>
                                    <C> id='CHIEP_GRD'        width=80        name='�򰡵��'     align=center  edit=none </C>
                                    <C> id='PROTEST_YMD'      width=80        name='��û����'     align=center  edit=none </C>
                                    <C> id='ACCEPT_YMD'       width=80        name='��������'     align=center  edit=none mask='XXXX-XX-XX' </C>
                                    <C> id='FILE_GBN'         width=40        name='÷��'         align=center  edit=none value={IF(FILE_NAME='','F','T')} editstyle=checkbox </C>
                                    <C> id='ACCEPT_GBN'       width=40        name='����'         align=center  edit={decode(ANSWER_YMD,'','',none)} editstyle=checkbox </C>
                                    <C> id='ACCEPT_DEC'       width=80        name='��������'     align=center  show=false </C>
                                    <C> id='ANSWER_YMD'       width=80        name='�亯����'     align=center  show=false </C>
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
