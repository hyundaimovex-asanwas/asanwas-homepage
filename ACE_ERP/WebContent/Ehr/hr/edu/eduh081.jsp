<!--
    ************************************************************************************
    * @Source         : eduh081.jsp                                                    *
    * @Description    : �����ڰ���_�űԵ�� PAGE                                       *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>�����ڰ���_�űԵ��(eduh081)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_EXCEPTER.ClearData();

            dsT_ED_EXCEPTER.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh081.cmd.EDUH081CMD&S_MODE=SHR&STR_YMD="+opener.str_ymd+"&ENO_NO="+opener.eno_no;
            dsT_ED_EXCEPTER.Reset();

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

            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_ED_EXCEPTER.KeyValue = "tr01(I:SAV=dsT_ED_EXCEPTER)";
            trT_ED_EXCEPTER.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh081.cmd.EDUH081CMD&S_MODE=SAV";
            trT_ED_EXCEPTER.post();


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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            if (!dsT_ED_EXCEPTER.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_EXCEPTER.isUpdated) {
                for( i = 1; i <= dsT_ED_EXCEPTER.CountRow; i++ ) {
                    if( dsT_ED_EXCEPTER.RowStatus(i) == 1 ||
                        dsT_ED_EXCEPTER.RowStatus(i) == 3 ) {

                        // ������
                        if( dsT_ED_EXCEPTER.NameValue(i, "STR_YMD") == '' ) {
                            alert("�������� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // ���ܱ���
                        if( dsT_ED_EXCEPTER.NameValue(i, "EXC_CD") == '' ) {
                            alert("���ܱ��д� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbEXC_CD").focus();
                            return false;
                        }

                        // ���
                        if( dsT_ED_EXCEPTER.NameValue(i, "ENO_NO") == '' ) {
                            alert("����� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // ��� CHECK
                        if (dsT_ED_EXCEPTER.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_EXCEPTER.NameValue(i, "ENO_NM") == "") {
                            alert("����� �Է��Ͻ� ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                            dsT_ED_EXCEPTER.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }

                        // �̼�����
                        if( dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") == ''  ||
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") == 0) {
                            alert("�̼������� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtCPT_PNT").focus();
                            return false;
                        }

                        // �̼�����
                        // �̼������� 4�� �����̸� ���� �Է� ���ɰ��� 4������ ���
                        if (dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") < 4) {
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") = 4;
                        }
                        // �̼������� 6������ ũ�� �ֻ� �Է� ���ɰ��� 6������ ���
                        else if (dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") > 6) {
                            dsT_ED_EXCEPTER.NameValue(i, "CPT_PNT") = 6;
                        }

                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            var oOption = null;

            //���ܱ���
            for( var i = 1; i <= dsCOMMON_QD.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QD.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QD.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEXC_CD").add(oOption);

            }

            // ������ �����̸�
            if (opener.gbn == "2") {

                document.getElementById('txtSTR_YMD').value = opener.str_ymd;
                document.getElementById('txtEND_YMD').value = opener.end_ymd;
                document.getElementById('cmbEXC_CD').value = opener.exc_cd;

                document.getElementById('txtENO_NO').value = opener.eno_no;
                document.getElementById('txtENO_NM').value = opener.eno_nm;

                document.getElementById('txtREMARK').value = opener.remark;

                // �������� ������ ��ȸ
                fnc_SearchList();
            }
            else {

                fnc_ColEnabled('E');

                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_ED_EXCEPTER.CountColumn == 0) {
                    dsT_ED_EXCEPTER.setDataHeader("STR_YMD:STRING:KEYVALUETYPE, ENO_NO:STRING:KEYVALUETYPE, ENO_NM:STRING, EXC_CD:STRING, CPT_PNT:INT, END_YMD:STRING, REMARK:STRING");
                }

                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_ED_EXCEPTER.AddRow();

                //dsT_ED_EXCEPTER.NameValue(1, "STR_YMD")  = getToday();

                ///////////////////////////////////////////////////////////////
                // �ش�⵵ �����ڿ� ���� �̼������� ���� 4���� �������� �Է�
                // �ִ� 6������ �Է� ������...
                ///////////////////////////////////////////////////////////////
                dsT_ED_EXCEPTER.NameValue(1, "CPT_PNT") = 4;

                document.getElementById('txtSTR_YMD').focus();
            }

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_EXCEPTER.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();
        }

        /********************
         * 15. ����Ű ó��  *
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

                document.getElementById("txtSTR_YMD").disabled  = false;
                document.getElementById("txtEND_YMD").disabled  = false;
                document.getElementById("cmbEXC_CD").disabled  = false;
                document.getElementById("txtENO_NO").disabled  = false;
                document.getElementById("txtENO_NM").disabled  = false;
                document.getElementById("txtCPT_PNT").disabled = false;
                document.getElementById("txtREMARK").disabled = false;

                document.getElementById("ImgEnoNo").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtSTR_YMD").disabled  = true;
                document.getElementById("txtEND_YMD").disabled  = true;
                document.getElementById("cmbEXC_CD").disabled  = true;
                document.getElementById("txtENO_NO").disabled  = true;
                document.getElementById("txtENO_NM").disabled  = true;
                document.getElementById("txtCPT_PNT").disabled = true;
                document.getElementById("txtREMARK").disabled = true;

                document.getElementById("ImgEnoNo").disabled   = true;

            }
        }

        //������ ��¥���� üũ
        function fnc_ChkDate() {

            var STR_YMD = document.getElementById("txtSTR_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(STR_YMD != ""){
                if(STR_YMD <= today){
                    alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
                    document.getElementById("txtSTR_YMD").value = "";
                    document.getElementById("txtSTR_YMD").focus();
                    return false;
                }
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_EXCEPTER)|
    | 3. ���Ǵ� Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_EXCEPTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_EXCEPTER)|
    | 3. ���Ǵ� Table List(T_ED_EXCEPTER)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_EXCEPTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_EXCEPTER)">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ���ܱ��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_QD"/>
       <jsp:param name="CODE_GUBUN"    value="QD"/>
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
    <Script For=dsT_ED_EXCEPTER Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_EXCEPTER.CountRow );

            fnc_ColEnabled('E');

            document.getElementById("txtSTR_YMD").disabled  = true;
            document.getElementById("txtENO_NO").disabled  = true;

            document.getElementById("ImgEnoNo").disabled   = true;
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_EXCEPTER Event="OnDataError()">

        cfErrorMsg(this);

    </Script>



    <!-- Ʈ������ ����. -->
    <script for=trT_ED_EXCEPTER event="OnSuccess()">
        fnc_Exit();
    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_EXCEPTER event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ڰ���_�űԵ��</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="110"></col>
                    <col width="240"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�ش�Ⱓ</td>
                    <td class="padding2423" >
                        <input id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','20','100');"></a> ~
                        <input id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();" onfocusout="fnc_compareFromTo('txtSTR_YMD', 'txtEND_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEndYmd" name="ImgEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','160','100');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���ܱ���</td>
                    <td class="padding2423" >
                        <select id="cmbEXC_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423" >
                        <input id="txtREMARK"  name="txtREMARK" style="ime-mode:disabled;text-align:left;" size="39" maxlength="100">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO"  name="txtENO_NO" style="ime-mode:disabled;" size="10"  maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO','txtENO_NM','1');"  onChange="fnc_GetEnoNm('txtENO_NO','txtENO_NM','1','1');">
                        <input id="txtENO_NM" name="txtENO_NM" size="20" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM','txtENO_NO','1');" onchange="fnc_GetEnoNo('txtENO_NM','txtENO_NO','1');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�̼�����</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="ime-mode:disabled;text-align:right;" size="5" maxlength="2" onKeyPress="cfNumberCheck();" > ��
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="350" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
<!-- �򰡴���ڼ��� ���̺� -->
<object id="bndT_ED_EXCEPTER"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_EXCEPTER">
    <Param Name="BindInfo", Value='
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value </C>
        <C>Col=END_YMD      Ctrl=txtEND_YMD      Param=value </C>
        <C>Col=EXC_CD       Ctrl=cmbEXC_CD       Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=REMARK       Ctrl=txtREMARK       Param=value </C>
    '>
</object>