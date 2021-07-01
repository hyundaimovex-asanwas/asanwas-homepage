<!--
    ************************************************************************************
    * @Source         : vlub100.jsp                                                    *
    * @Description    : ���ǽ�û(�亯)_����.                                                *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/27  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/16  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>���ǽ�û(�亯)_����(vlub100)</title>
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

        var btnList = 'TFTTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if( !fnc_SearchItemCheck() ) return;

            if( document.getElementById("cmbGROUP_CD_SHR").value != '' ) {
                if (GUBUN == "01") {
                    document.getElementById("txtCOMM_CD_SHR").value = 'EG';
                }
                else if (GUBUN == "02") {
                    document.getElementById("txtCOMM_CD_SHR").value = '4';
                }
            }
            else {
                document.getElementById("txtCOMM_CD_SHR").value = '';
            }

            //�����ͼ� ����(���ǽ�û(�亯)_����)
            dsT_EV_PROTEST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub100.cmd.VLUB100CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_GBN_SHR=1&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value;
            dsT_EV_PROTEST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�⵵�� ��ȸ������ ��ȸ
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=1";
            dsT_EV_ESTINFO.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            if( !fnc_SaveItemCheck() )    return;

            //Ʈ����� ����
            trT_EV_PROTEST.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.b.vlub100.cmd.VLUB100CMD&S_MODE=SAV";
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

            form1.grdT_EV_PROTEST.GridToExcel("���ǽ�û(�亯)_����", '', 227);

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            document.getElementById("resultMessage").innerText = '';
            dsT_EV_PROTEST.ClearAll();

            document.getElementById("txtPROTEST_YMD").value = '';
            document.getElementById("txtPROTEST_TIT").value = '';
            document.getElementById("txtPROTEST_DEC").value = '';
            document.getElementById("txtANSWER_YMD").value = '';
            document.getElementById("txtANSWER_DEC").value = '';

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
        function fnc_SaveItemCheck() {

            if ( dsT_EV_PROTEST.isUpdated ) {
                for( i=1; i<=dsT_EV_PROTEST.CountRow; i++ ) {
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD") != ''
                        && ( cfDateExpr(dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD")) == false || dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD").length !=10 ) ) {
                        alert("�亯���ڰ� ��¥���Ŀ� �����ʽ��ϴ�.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD") == '' && dsT_EV_PROTEST.NameValue(i,"ANSWER_DEC") !='' ) {
                        alert("�亯���ڸ� �Է��� �ּ���.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_YMD");
                         form1.grdT_EV_PROTEST.focus();
                        return false;
                    }
                    if( dsT_EV_PROTEST.NameValue(i,"ANSWER_DEC") == '' && dsT_EV_PROTEST.NameValue(i,"ANSWER_YMD")!='' ) {
                        alert("�亯������ �Է��� �ּ���.");
                        dsT_EV_PROTEST.RowPosition = i;
                         form1.grdT_EV_PROTEST.SetColumn("ANSWER_DEC");
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
            cfStyleGrid(form1.grdT_EV_PROTEST, 15, "false", "false");

            // ��������
            if (frameid == "vlub100") {
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

            //���κ� �� ���� ���� ���� Ȥ�� ��ȸ������   (��ȸ)
            fnc_SearchItem();

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. �������ο� ���� �亯�Ұ�����  ó�� �κ�  *
         *******************************************/

        function fnc_EnableDisableSet( ableDiv ) {

            //enableó��
            if( ableDiv == '1' ) {
                document.getElementById("txtANSWER_DEC").readOnly=false;
                document.getElementById("txtANSWER_DEC").style.backgroundColor = 'FFFFFF';
            }
            //disableó��
            if( ableDiv == '2' ) {
                alert('���� ��û ���� �� �亯�� �����մϴ�!');
                document.getElementById("txtANSWER_DEC").readOnly=true;
                document.getElementById("txtANSWER_DEC").style.backgroundColor = 'EEEEEE';
            }

        }

        /********************
         * 16. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /*********************
         * ���Ͽ���          *
         *********************/
        function fnc_FileOpen() {
            if (dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME") != "" ) {    // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
                cfDownload(dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition, "FILE_NAME"), form1.txtFILE_URL.value);
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
       <jsp:param name="CODE_GUBUN"  value="EG"/>
       <jsp:param name="SYNCLOAD"    value="false"/>
       <jsp:param name="USEFILTER"    value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <script language=JavaScript for=grdT_EV_PROTEST event=OnClick(row,colid)>

        if( dsT_EV_PROTEST.NameValue(row,"ACCEPT_GBN") == 'F' )
            fnc_EnableDisableSet('2');
        else
            fnc_EnableDisableSet('1');

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_PROTEST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {

            if( dsT_EV_PROTEST.NameValue(dsT_EV_PROTEST.RowPosition,"ACCEPT_GBN") == 'F' )
                fnc_EnableDisableSet('2');
            else {
                fnc_EnableDisableSet('1');
                   form1.txtANSWER_DEC.focus();//set focus
               }

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_PROTEST.CountRow);

        }

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ǽ�û(�亯)_����</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���ǽ�û(�亯)_����</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',0)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="40"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="25"></col>
                                    <col width="160"></col>
                                    <col width="25"></col>
                                    <col width="150"></col>
                                    <col width="25"></col>
                                    <col width="200"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchBold">�ش�⵵&nbsp;</td>
                                    <td><input id="txtEVL_YY_SHR" name="txtEVL_YY_SHR" style="width 100%;text-align: center" size="4" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">ȸ��&nbsp;</td>
                                    <td><input id="txtEVL_FRQ_SHR" name="txtEVL_FRQ_SHR" style="width 100%;text-align: center" size="2" class="input_ReadOnly" readonly></td>
                                    <td align="right" class="searchBold">�򰡱׷�&nbsp;</td>
                                    <td class="">
                                        <input type=hidden name="txtCOMM_CD_SHR" value="EG">
                                        <select name="cmbGROUP_CD_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                            <option value='' selected>�� ü</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchBold">�Ҽ�&nbsp;</td>
                                    <td class="padding2423"><input name=txtDPT_CD_SHR size="3"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <input id=txtDPT_NM_SHR size="8" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                    </td>
                                    <td align="right" class="searchBold">���&nbsp;</td>
                                    <td class="padding2423"><input name=txtENO_NO_SHR size="8"  maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();">
                                        <input id=txtENO_NM_SHR style="text-align: center" size="8" class="input_ReadOnly" readonly>
                                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                            <object    id="grdT_EV_PROTEST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:115px;">
                                <param name="DataID"                            value="dsT_EV_PROTEST">
                                <param name="EdiTABLE"                    value="false">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                        value="Left">
                                <param name="VIEWSUMMARY"            value=0>
                                <param name="AutoReSizing"              value="true">
                                <param name=ColSizing  value="true">
                                <param name="Format"                            value="
                                    <C> id='EVL_YY'       width=40        name='�⵵'     align=center     show=false </C>
                                    <C> id='EVL_GBN'       width=40        name='����'     align=center        show=false </C>
                                    <C> id='EVL_FRQ'       width=40        name='ȸ��'     align=center    show=false </C>
                                    <C> id='GROUP_NM'       width=80        name='�򰡱׷�'     align=left    edit=none </C>
                                    <C> id='HEAD_NM'       width=80        name='����'     align=left    edit=none </C>
                                    <C> id='DPT_NM'       width=70        name='�Ҽ�'     align=left    edit=none </C>
                                    <C> id='JOB_NM'       width=60        name='����'     align=left    edit=none </C>
                                    <C> id='ENO_NO'       width=60        name='���'     align=center    edit=none </C>
                                    <C> id='ENO_NAME'       width=60        name='����'     align=center    edit=none </C>
                                    <C> id='PROTEST_TIT'       width=90        name='��û����'     align=left    edit=none </C>
                                    <C> id='PROTEST_YMD'       width=70        name='��û��'     align=center    edit=none </C>
                                    <C> id='PROTEST_DEC'       width=300        name='��û����'     align=left    edit=none show=false </C>
                                    <C> id='ACCEPT_YMD'       width=70        name='��������'     align=center     edit=none </C>
                                    <C> id='ACCEPT_DEC'       width=300        name='��������'     align=left show=false </C>
                                    <C> id='ANSWER_YMD'       width=70        name='�亯����'     align=center show=false </C>
                                    <C> id='ANSWER_DEC'       width=300        name='�亯����'     align=left show=false </C>
                                    <C> id='CHIEP_GRD'       width=30        name='���'     align=center        edit=none </C>
                                    <C> id='FILE_GBN'         width=30        name='÷��'    align=center    editstyle=checkbox    edit=none value={IF(FILE_NAME='','F','T')} </C>
                                    <C> id='ACCEPT_GBN'       width=30        name='����'    align=center    editstyle=checkbox    edit=none </C>
                                    <C> id='ANSWER_GBN'       width=30        name='�亯'    align=center   editstyle=checkbox    edit=none </C>
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

    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr><td height="5"></td></tr>
    </table>

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
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
                            <input id=txtPROTEST_YMD name=txtPROTEST_YMD style="text-align:center" size="15" class="input_ReadOnly" readonly>
                            &nbsp;&nbsp;<B>÷�����ϸ�</B>&nbsp;<input id=txtFILE_NAME name=txtFILE_NAME size="74" class="input_ReadOnly" readonly>&nbsp;
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnFILEOPEN','','/images/button/FileOpenOver.gif',3)">  <img src="/images/button/FileOpenOn.gif"   id="btnDEL" name="btnFILEOPEN" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileOpen()"></a>
                            <input type=hidden id=txtFILE_URL name=txtFILE_URL size="60">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <input id=txtPROTEST_TIT name=txtPROTEST_TIT size="121" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��<BR><BR>��</td>
                        <td align="center">
                            <textarea id=txtPROTEST_DEC name=txtPROTEST_DEC rows="9" cols="120" class="input_ReadOnly" readonly></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold" rowspan="2">��<BR><BR><BR>��</td>
                        <td align="center" class="creamBold">����</td>
                        <td class="padding2423">
                            <input id=txtANSWER_YMD name=txtANSWER_YMD style="text-align:center" size="15" maxlength=10 onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��<BR><BR>��</td>
                        <td align="center">
                            <textarea id=txtANSWER_DEC name=txtANSWER_DEC rows="9" cols="120" onBlur="cfCheckLength('txtANSWER_DEC','�亯����','4000');" onChange="javascript:if( document.getElementById('txtANSWER_YMD').value == '' ) { if( this.value.length == 0 ) document.getElementById('txtANSWER_YMD').value=''; else document.getElementById('txtANSWER_YMD').value=getToday(); } else { if( this.value.length == 0 ) document.getElementById('txtANSWER_YMD').value=''; } " class="input_ReadOnly" ></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

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
    <!-- ���ǽ�û(�亯)_���� ���̺� -->
    <comment id="__NSID__">
    <object id="bndT_EV_PROTEST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",   Value="dsT_EV_PROTEST">
        <Param Name="ActiveBind"        Value=true>
        <Param Name="BindInfo", Value='
            <C>Col=PROTEST_YMD       Ctrl=txtPROTEST_YMD     Param=value</C>
            <C>Col=PROTEST_TIT       Ctrl=txtPROTEST_TIT     Param=value</C>
            <C>Col=PROTEST_DEC       Ctrl=txtPROTEST_DEC     Param=value</C>
            <C>Col=ANSWER_YMD        Ctrl=txtANSWER_YMD      Param=value</C>
            <C>Col=ANSWER_DEC        Ctrl=txtANSWER_DEC      Param=value</C>
            <C>Col=FILE_NAME         Ctrl=txtFILE_NAME       Param=value</C>
            <C>Col=FILE_URL          Ctrl=txtFILE_URL        Param=value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>
