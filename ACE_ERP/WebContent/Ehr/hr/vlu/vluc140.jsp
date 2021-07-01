<!--
    ************************************************************************************
    * @Source         : vluc140.jsp                                                    *
    * @Description    : ���������� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/06  |  ���뼺   | �����ۼ�                                               *
    * 2006/10/10  |  ������   | ����                                                   *
    * 2007/03/18  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>����������(vluc140)</title>
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

        // ������
        var EVL_GBN = "2";
        var btnList = 'FFFFFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

           //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_ACHTBL.ClearData();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            var EVL_YY  = null;

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ACHTBL,0,"false","false");

            // ��������
            if (frameid == "vluc140") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.DataId = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR01&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /****************************************
         * �˻����� �ʵ� ����� DataSet �ʱ�ȭ  *
         ***************************************/
        function fnc_FldChange() {

            dsT_EV_EVLIST_HD.ClearData();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ACHTBL)    |
    | 3. ���Ǵ� Table List(T_EV_ACHTBL)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ACHTBL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ESTINFO)   |
    | 3. ���Ǵ� Table List(T_EV_ESTINFO)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_ESTINFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_SCHCHG)    |
    | 3. ���Ǵ� Table List(T_EV_SCHCHG)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_SCHCHG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EV_ACHTBL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ACHTBL.CountRow);
            form1.grdT_EV_ACHTBL.Focus();

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ACHTBL Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">
        if ( iCount == 0 )    {

            alert("������Ⱓ�� �ƴմϴ�.");
            document.getElementById("resultMessage").innerText = '* ������Ⱓ�� �ƴմϴ�.';

            dsT_EV_SCHCHG.ClearData();
            dsT_EV_ACHTBL.ClearData();

        } else {

            form1.txtEVL_YY_SHR.value    = dsT_EV_ESTINFO.NameValue(1, "EVL_YY");
            form1.txtEVL_FRQ_SHR.value   = dsT_EV_ESTINFO.NameValue(1, "EVL_FRQ");
            form1.txtREFENO_NO_SHR.value = '<%=box.get("SESSION_ENONO")%>';
            form1.txtREFENO_NM_SHR.value = '<%=box.get("SESSION_ENONM")%>';
            form1.txtREFDPT_NM_SHR.value = '<%=box.get("SESSION_DPTNM")%>';

            // ��ܺ� ������ ��ȸ
            dsT_EV_SCHCHG.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc140.cmd.VLUC140CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+form1.txtEVL_YY_SHR.value+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+form1.txtEVL_FRQ_SHR.value+"&ENO_NO="+form1.txtREFENO_NO_SHR.value;
            dsT_EV_SCHCHG.Reset();
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

        var IPT_STDT = '';
        var IPT_ENDT = '';

        if ( iCount == 0 )    {

            IPT_STDT = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
            IPT_ENDT = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

        } else {

            if (dsT_EV_SCHCHG.NameValue(1, "IPT_STDT") == "") {

                IPT_STDT = dsT_EV_ESTINFO.NameValue(1, "IPT_STDT");
                IPT_ENDT = dsT_EV_ESTINFO.NameValue(1, "IPT_ENDT");

            }
            else {

                IPT_STDT = dsT_EV_SCHCHG.NameValue(1, "IPT_STDT");
                IPT_ENDT = dsT_EV_SCHCHG.NameValue(1, "IPT_ENDT");
            }
        }

        EVL_YY  = form1.txtEVL_YY_SHR.value;
        EVL_FRQ = form1.txtEVL_FRQ_SHR.value;
        GBN     = form1.txtGBN.value;

        // DATASET �ʱ�ȭ
        fnc_Clear();

        dsT_EV_ACHTBL.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc140.cmd.VLUC140CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&GBN="+GBN;
        dsT_EV_ACHTBL.Reset();

        // �������ڰ� ���Է±Ⱓ������ ���̸� ��ǥ �˾� Ŭ�� �����ϵ��� ��
        if (IPT_STDT <= getToday() && IPT_ENDT >= getToday()) {
            ;
        }
        else {

            alert('���Է±Ⱓ�� �ƴմϴ�.');
            document.getElementById("resultMessage").innerText = '* ���Է±Ⱓ�� �ƴմϴ�.';
            form1.txtFLAG.value = "1";

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

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_SCHCHG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- �׸����� �˾��ʵ� Ŭ���� -->
    <script language="javascript" for=grdT_EV_ACHTBL event=OnDblClick(Row,Colid)>

        var EVL_YY    = dsT_EV_ACHTBL.NameValue(Row, "EVL_YY");      //�ش�⵵
        var EVL_FRQ   = dsT_EV_ACHTBL.NameValue(Row, "EVL_FRQ");     //ȸ��
        var ENO_NO    = dsT_EV_ACHTBL.NameValue(Row, "ENO_NO");      //���
        var ENO_NM    = dsT_EV_ACHTBL.NameValue(Row, "ENO_NM");      //����
        var DPT_NM    = dsT_EV_ACHTBL.NameValue(Row, "DPT_NM");      //�ҼӸ�
        var EVLENO_NO = dsT_EV_ACHTBL.NameValue(Row, "EVLENO_NO");   //���ڻ��
        var REFENO_NO = form1.txtREFENO_NO_SHR.value;                //�������ڻ��
        var REFENO_NM = form1.txtREFENO_NM_SHR.value;                //�������ڸ�
        var REF_GBN   = "0";                                         //������������

        var revck    = null;

        // �򰡱Ⱓ�� �ƴ� ��� �˾�â ���� �ʵ��� ��.
        if (form1.txtFLAG.value == "1") {
        }
        else {

            // 1�� ������������ ��
            if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO1") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "1";
            }
            // 2�� ������������ ��
            else if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO2") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "2";
            }
            // 3�� ������������ ��
            else if (dsT_EV_ACHTBL.NameValue(Row, "REFENO_NO3") == form1.txtREFENO_NO_SHR.value) {
                REF_GBN = "3";
            }

            //modal������ ���� ���� confirm�� ������ �޾� �´�.
            url = "/hr/" + "vlu" + "/" + "vluc141.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+
                                                    "&EVLENO_NO="+EVLENO_NO+"&REFENO_NO="+REFENO_NO+"&REFENO_NM="+REFENO_NM+"&REF_GBN="+REF_GBN;

            // ������ǥ ȭ�� ȣ��
            revck = window.showModalDialog(url, Colid, "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null) {
                ;
            }
            else {

                var firstList = new Array ();
                firstList = revck.split(";");

                // ������ ������ �ش� �÷��� �־���
                if (firstList[0] == 0) {

                    dsT_EV_ACHTBL.NameValue(Row,"REF_PNT") = '����';

                }
                else {

                    dsT_EV_ACHTBL.NameValue(Row,"REF_PNT") = firstList[0];

                }
            }

            dsT_EV_ACHTBL.RowPosition = Row;
            form1.grdT_EV_ACHTBL.Focus();
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">����������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="80 "></col>
                                <col width="40 "></col>
                                <col width="60 "></col>
                                <col width="40 "></col>
                                <col width="50 "></col>
                                <col width="110"></col>
                                <col width="60 "></col>
                                <col width="80 "></col>
                                <col width="80 "></col>
                                <col width=" "></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵</td>
                                <td class="padding2423">
                                    <input id=txtEVL_YY_SHR size="4" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">ȸ��</td>
                                <td class="padding2423">
                                    <input id=txtEVL_FRQ_SHR size="2" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423">
                                    <input id=txtREFDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423">
                                    <input id=txtREFENO_NO_SHR size="10" class="input_ReadOnly" readonly>
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <input id=txtREFENO_NM_SHR size="10" class="input_ReadOnly" readonly>
                                </td>
                                <!-- Hidden Filed (���� : '2'�̸� �������ڰ� ������)-->
                                <input type=hidden name=txtGBN value="2">
                                <input type=hidden name=txtFLAG>
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
                        <object    id="grdT_EV_ACHTBL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_EV_ACHTBL">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="IndWidth"                value=0>
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='GROUP_NM'     width=60    name='�򰡱׷�'      align=left   </C>
                                <C> id='HEAD_NM'      width=82    name='����'          align=left   </C>
                                <C> id='DPT_NM'       width=82    name='�Ҽ�'          align=left   </C>
                                <C> id='JOB_NM'       width=55    name='����'          align=center </C>
                                <C> id='ENO_NO'       width=55    name='���'          align=center </C>
                                <C> id='ENO_NM'       width=55    name='����'          align=center </C>
                                <C> id='HIRG_YMD'     width=70    name='�Ի���'        align=center </C>
                                <C> id='DPA_YMD'      width=70    name='�Ҽӹ߷���'    align=center </C>
                                <C> id='EVLENO_NO'    width=70    name='���ڻ��'    align=center </C>
                                <C> id='EVLENO_NM'    width=70    name='���ڼ���'    align=center </C>
                                <C> id='SELF_PNT'     width=55    name='����;������' align=right  </C>
                                <C> id='REF_PNT'      width=55    name='������'      align=right  </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td class="searchState"><br>&nbsp;�� <u>�ش� �򰡴���� �׸��� ����Ŭ���ϸ� �������Է��� �Ͻ� �� �ֽ��ϴ�.<u></td>
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
<!-- ��ȸ������ ���̺� -->
<object id="bndT_EV_ESTINFO" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_EV_ESTINFO">
    <Param Name="BindInfo", Value='
        <C>Col=EVL_YY      Ctrl=txtEVL_YY_SHR     Param=value </C>
        <C>Col=EVL_FRQ     Ctrl=txtEVL_FRQ_SHR    Param=value </C>
        <C>Col=ENO_NO      Ctrl=txtREFENO_NO_SHR  Param=value </C>
        <C>Col=ENO_NM      Ctrl=txtREFENO_NM_SHR  Param=value </C>
        <C>Col=DPT_NM      Ctrl=txtREFDPT_NM_SHR  Param=value </C>
    '>
</object>