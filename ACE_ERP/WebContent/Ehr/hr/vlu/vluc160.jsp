<!--
***********************************************************************
* @source      : vluc160.jsp
* @description : ���κ�������Է� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/10/11      ���뼺        �����ۼ�.
* 2007/03/18      ������        ����. (�����򰡾������� �߰�)
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<html>
<head>
<title>���κ�������Է�(vluc160)</title>
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

        var btnList = 'TTTTFFTT';
        var year = getToday().substring(0,4);

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻����� 3����
            var evl_yy = document.getElementById('cmbEVL_YY_SHR').value;          //�ش�⵵
            var evl_frq = document.getElementById('cmbEVL_FRQ_SHR').value;        //��ȸ��
            var head_cd = document.getElementById('cmbHEAD_CD_SHR').value;        //�Ҽ��ڵ�

            //�� ���� ���� ���� ��ȸ
            dsT_EV_DEPTRATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc160.cmd.VLUC160CMD&S_MODE=SHR&GUBUN="+GUBUN+"&EVL_YY="+evl_yy+"&EVL_FRQ="+evl_frq+"&HEAD_CD="+head_cd;
            dsT_EV_DEPTRATE.reset();

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

                trT_EV_DEPTRATE.KeyValue = "tr01(I:dsT_EV_DEPTRATE=dsT_EV_DEPTRATE)";
                trT_EV_DEPTRATE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc160.cmd.VLUC160CMD&S_MODE=SAV";
                trT_EV_DEPTRATE.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            if(dsT_EV_DEPTRATE.CountRow < 1) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            if (document.form1.txtEVL_YY.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� ���� �� �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_08');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }
            if(confirm("["+dsT_EV_DEPTRATE.NameValue(dsT_EV_DEPTRATE.RowPosition,'HEAD_NM')+"]�� ���κ������������ �����Ͻðڽ��ϱ�?")){
                dsT_EV_DEPTRATE.DeleteRow(dsT_EV_DEPTRATE.RowPosition);
                trT_EV_DEPTRATE.KeyValue = "tr01(I:dsT_EV_DEPTRATE=dsT_EV_DEPTRATE)";
                trT_EV_DEPTRATE.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc160.cmd.VLUC160CMD&S_MODE=DEL";
                trT_EV_DEPTRATE.post();
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

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            if (document.form1.cmbEVL_YY_SHR.value != year) {
                alert("�ش�⵵ �̿��� �ڷ�� �ű� ���� �� �� �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_07');
                document.form1.cmbEVL_YY_SHR.focus();
                return;
            }

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_DEPTRATE.CountColumn == 0) {
                dsT_EV_DEPTRATE.setDataHeader("GUBUN:STRING, EVL_YY:STRING:KEYVALUETYPE, EVL_FRQ:INT:KEYVALUETYPE, HEAD_CD:STRING:KEYVALUETYPE, HEAD_NM:STRING, RATE_S:DEC, RATE_A:DEC, RATE_B:DEC, RATE_C:DEC, RATE_D:DEC, RATE_RST:DEC, OTH_DEC:STRING");
            }
            dsT_EV_DEPTRATE.AddRow();

            fnc_ColEnabled('E');

            dsT_EV_DEPTRATE.NameValue(dsT_EV_DEPTRATE.RowPosition, "GUBUN") = GUBUN;
            document.getElementById('txtEVL_YY').value = year;

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

            dsT_EV_DEPTRATE.ClearData();
            document.getElementById("resultMessage").innerText = ' ';

            fnc_ColEnabled('D');

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_DEPTRATE.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if (!dsT_EV_DEPTRATE.IsUpdated) {
                alert("������ �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
            }

            //�Է� �������� ��ȿ�� üũ
            for(i=0;i<dsT_EV_DEPTRATE.CountRow;i++){
                var tot_rate = 0;

                if (dsT_EV_DEPTRATE.NameValue(i+1,'EVL_FRQ') == '') {
                    alert("ȸ���� ������ �ּ���.");
                    document.getElementById('cmbEVL_FRQ').focus();
                    return false;
                }

                if (dsT_EV_DEPTRATE.NameValue(i+1,'HEAD_CD') == '') {
                    alert("���θ� ������ �ּ���.");
                    document.getElementById('cmbHEAD_CD').focus();
                    return false;
                }

                tot_rate = dsT_EV_DEPTRATE.ColumnValue(i+1,6)+dsT_EV_DEPTRATE.ColumnValue(i+1,7)+dsT_EV_DEPTRATE.ColumnValue(i+1,8)+dsT_EV_DEPTRATE.ColumnValue(i+1,9)+dsT_EV_DEPTRATE.ColumnValue(i+1,10);

                if(tot_rate != 100){
                    alert("��к����� ���� 100�� �Ǿ�� �մϴ�.");
                    document.getElementById("resultMessage").innerText = ' ';
                    dsT_EV_DEPTRATE.RowPosition = i+1;
                    document.getElementById('txtRATE_S').focus();
                    return false;
                }

            }//for

            return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_EV_DEPTRATE,15,"false","false");      // Grid Style ����

            //�򰡱׷�
            for( var i = 1; i <= dsCOMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B2.NameValue(i,"CODE_NAME");

                document.getElementById('cmbHEAD_CD').add(oOption);
            }

            //�򰡱׷�
            for( var i = 1; i <= dsCOMMON_B2.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_B2.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_B2.NameValue(i,"CODE_NAME");

                document.getElementById('cmbHEAD_CD_SHR').add(oOption);
            }

            // ��������
            if (frameid == "vluc160") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";

            }

            //SelectBox�⵵ Setting
            getSelYy2('cmbEVL_YY_SHR');

            fnc_ColEnabled('D');

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /*************************************************************
         * 16. Grid�� �����׸� ������ ���θ��� �����ֱ� ���� �Լ�  *
         ************************************************************/
        function fnc_ShowGridCol(val) {

            for(i=1;i<dsCOMMON_B2.CountRow+1;i++){
                if(dsCOMMON_B2.NameValue(i,'CODE') == val){
                    dsT_EV_DEPTRATE.NameValue(dsT_EV_DEPTRATE.RowPosition,'HEAD_NM') = dsCOMMON_B2.NameValue(i,'CODE_NAME');
                }
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
                form1.txtEVL_YY.disabled   = false;
                form1.cmbEVL_FRQ.disabled  = false;
                form1.cmbHEAD_CD.disabled  = false;
                form1.txtRATE_S.disabled   = false;
                form1.txtRATE_A.disabled   = false;
                form1.txtRATE_B.disabled   = false;
                form1.txtRATE_C.disabled   = false;
                form1.txtRATE_D.disabled   = false;
                form1.txtRATE_RST.disabled = false;
                form1.txtOTH_DEC.disabled  = false;
            }
            // �ش� �÷��� �Ӽ��� Disabled�� ����
            else if (prop == 'D') {
                form1.txtEVL_YY.disabled   = true;
                form1.cmbEVL_FRQ.disabled  = true;
                form1.cmbHEAD_CD.disabled  = true;
                form1.txtRATE_S.disabled   = true;
                form1.txtRATE_A.disabled   = true;
                form1.txtRATE_B.disabled   = true;
                form1.txtRATE_C.disabled   = true;
                form1.txtRATE_D.disabled   = true;
                form1.txtRATE_RST.disabled = true;
                form1.txtOTH_DEC.disabled  = true;
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
    | 1. ��ȸ�� DataSet                                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_DEPTRATE)    |
    | 3. ���Ǵ� Table List(T_EV_DEPTRATE)            |
    +----------------------------------------------->
    <Object ID="dsT_EV_DEPTRATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton            |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_DEPTRATE)        |
    | 3. ���Ǵ� Table List(T_EV_DEPTRATE)                |
    +--------------------------------------------------->
    <Object ID ="trT_EV_DEPTRATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �򰡱׷� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_B2"/>
       <jsp:param name="CODE_GUBUN"    value="B2"/>
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
    <Script For=dsT_EV_DEPTRATE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
            fnc_ColEnabled('E');
            document.getElementById('txtRATE_S').focus();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DEPTRATE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DEPTRATE Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�ش�⵵/ȸ��/���θ�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            alert("�ش�⵵/ȸ��/���θ� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
            cfErrorMsg(this);
        }

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_DEPTRATE event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_DEPTRATE event="OnFail()">
        document.getElementById("resultMessage").innerText = ' ';
        cfErrorMsg(this);
    </script>
</head>


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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ�������Է�</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">���κ�������Է�</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)">  <img src="/images/button/btn_DeleteOn.gif"   name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <td align="right" class="searchState">�ش�⵵</td>
                                <td class="padding2423"><select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();"></select></td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_FRQ_SHR" name="cmbEVL_FRQ_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value="1">1��</option>
                                        <option value="2">2��</option>
                                        <option value="3">3��</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">���θ�</td>
                                <td class="padding2423">
                                    <select id="cmbHEAD_CD_SHR" name="cmbHEAD_CD_SHR" onChange="fnc_SearchList();" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                                        <option value="">�� ü</option>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="100"></col>
                    <col width="100"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�ش�⵵</td>
                    <td class="padding2423"><input id="txtEVL_YY" name="txtEVL_YY" size="16" readOnly class="input_ReadOnly">
                    </td>
                    <td align="center" class="creamBold">ȸ��</td>
                    <td class="padding2423">
                        <select id="cmbEVL_FRQ" name="cmbEVL_FRQ" style="WIDTH: 100%">
                            <option value="1">1ȸ��</option>
                            <option value="2">2ȸ��</option>
                            <option value="3">3ȸ��</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">���θ�</td>
                    <td class="padding2423">
                        <select id="cmbHEAD_CD" name="cmbHEAD_CD" style="WIDTH: 100%" onChange="fnc_ShowGridCol(this.value);">
                            <option value=""></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" rowspan="2">��к���</td>
                    <td align="center" class="creamBold">S</td>
                    <td align="center" class="creamBold">A</td>
                    <td align="center" class="creamBold">B</td>
                    <td align="center" class="creamBold">C</td>
                    <td align="center" class="creamBold">D</td>
                </tr>
                <tr>
                    <td class="padding2423"><input id="txtRATE_S" name=txtRATE_S size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfNumberCheck();" maxlength="3">
                    </td>
                    <td class="padding2423"><input id="txtRATE_A" name=txtRATE_A size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfNumberCheck();" maxlength="3">
                    </td>
                    <td class="padding2423"><input id="txtRATE_B" name=txtRATE_B size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfNumberCheck();" maxlength="3">
                    </td>
                    <td class="padding2423"><input id="txtRATE_C" name=txtRATE_C size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfNumberCheck();" maxlength="3">
                    </td>
                    <td class="padding2423"><input id="txtRATE_D" name=txtRATE_D size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfNumberCheck();" maxlength="3">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������<br>������(%)</td>
                    <td class="padding2423"><input id="txtRATE_RST" name=txtRATE_RST size="16" style="ime-mode:disabled;text-align:right;" onkeypress="cfCheckNumber();" maxlength="4">
                    </td>
                    <td align="center" class="creamBold">���</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtOTH_DEC" name=txtOTH_DEC size="56" onkeyup="fc_chk_byte(this,100);">
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
                        <object    id="grdT_EV_DEPTRATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:230px;">
                            <param name="DataID"                  value="dsT_EV_DEPTRATE">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="false">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id={currow}         width=50    name='����'         align=center </C>
                                <C> id='HEAD_NM'         width=130   name='����'         align=left </C>
                                <C> id='RATE_S'         width=40    name='S'            align=right </C>
                                <C> id='RATE_A'         width=40    name='A'            align=right </C>
                                <C> id='RATE_B'         width=40    name='B'            align=right </C>
                                <C> id='RATE_C'         width=40    name='C'            align=right </C>
                                <C> id='RATE_D'         width=40    name='D'            align=right </C>
                                <C> id='RATE_RST'       width=90   name='������������' align=right </C>
                                <C> id='OTH_DEC'        width=294   name='���'         align=left </C>
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

    <!--
    **************************************************************
    * ���ε� ������Ʈ
    **************************************************************
    -->
    <!-- KPI Pool ���� ���̺� -->
    <comment id="__NSID__">
    <object id="bndT_EV_ESTINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
        <Param Name="DataID",        Value="dsT_EV_DEPTRATE">
        <Param Name="ActiveBind"    Value=true>
        <Param Name="BindInfo",        Value='
            <C>Col=EVL_YY       Ctrl=txtEVL_YY      Param=value</C>
            <C>Col=EVL_FRQ      Ctrl=cmbEVL_FRQ     Param=value Disable=disabled</C>
            <C>Col=HEAD_CD      Ctrl=cmbHEAD_CD      Param=value Disable=disabled</C>
            <C>Col=RATE_S       Ctrl=txtRATE_S      Param=value</C>
            <C>Col=RATE_A       Ctrl=txtRATE_A      Param=value</C>
            <C>Col=RATE_B       Ctrl=txtRATE_B      Param=value</C>
            <C>Col=RATE_C       Ctrl=txtRATE_C      Param=value</C>
            <C>Col=RATE_D       Ctrl=txtRATE_D      Param=value</C>
            <C>Col=RATE_RST     Ctrl=txtRATE_RST    Param=value</C>
            <C>Col=OTH_DEC      Ctrl=txtOTH_DEC     Param=value</C>
        '>
    </object>
    </comment><script> __ShowEmbedObject(__NSID__); </script>