<!--
    ************************************************************************************
    * @Source         : vluc120.jsp                                                    *
    * @Description    : ��ǥ��Ȳ.                                                      *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/23  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/18  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

<head>
<title>��ǥ��Ȳ(vluc120)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript">

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

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

            if( searchDiv == '1' || searchDiv == undefined ) {
                //�ۼ�����,�������� �ʱ�ȭ
                dsT_EV_AIMLST_01.ClearAll();
                //�����ͼ� ����(��ǥ��Ȳ ��ȸ)
                dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc120.cmd.VLUC120CMD&S_MODE=SHR&GUBUN="+GUBUN+"&cmbEVL_YY_SHR="+document.getElementById("cmbEVL_YY_SHR").value+"&cmbEVL_FRQ_SHR="+document.getElementById("cmbEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtDPT_CD_SHR="+document.getElementById("txtDPT_CD_SHR").value+"&txtCOMM_CD_SHR="+document.getElementById("txtCOMM_CD_SHR").value+"&cmbGROUP_CD_SHR="+document.getElementById("cmbGROUP_CD_SHR").value;
                dsT_EV_AIMLST.Reset();
            }
            if( searchDiv == '2' ) {
                //�����ͼ� ����(�ۼ�����,�������� ��ȸ)
                dsT_EV_AIMLST_01.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc120.cmd.VLUC120CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY")+"&txtEVL_FRQ_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ")+"&txtENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO")+"&txtEVLENO_NO_SHR="+dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
                dsT_EV_AIMLST_01.Reset();
            }

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

                //�����ͼ� ����(�򰡱����������� ��ȸ)
                dsT_EV_TYPE.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.a.vlua060.cmd.VLUA060CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+document.getElementById("cmbEVL_YY_SHR").value;
                dsT_EV_TYPE.Reset();

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

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

            document.getElementById("cmbEVL_YY_SHR")[4].selected = true;
            fnc_SearchItem();
            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("cmbGROUP_CD_SHR").value = '';

            dsT_EV_AIMLST.ClearAll();
            dsT_EV_AIMLST_01.ClearAll();

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_AIMLST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            frame = window.external.GetFrame(window);
            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_AIMLST, 15, "false", "false");
            cfStyleGrid(form1.grdT_EV_AIMLST_01, 15, "false", "false");

            getSelYy('cmbEVL_YY_SHR');                 //SelectBox�⵵ Setting

            // ��������
            if (frameid == "vluc120") {
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

            //�򰡱����������� ��ȸ
            fnc_SearchItem();

<%
    //�����Ͱ� �ƴϸ� �ٸ� ������� �˻� ����
    if(!box.getString("SESSION_ROLE_CD").equals("1001")
            && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>
            document.getElementById("txtENO_NO_SHR").value   = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value   = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_CD_SHR").value   = '<%=box.get("SESSION_DPTCD")%>';
            document.getElementById("txtDPT_NM_SHR").value   = '<%=box.get("SESSION_DPTNM")%>';

            document.getElementById("txtENO_NO_SHR").readOnly  = true;
            document.getElementById("txtDPT_CD_SHR").readOnly  = true;
            document.getElementById("txtENO_NO_SHR").className     = "input_ReadOnly";
            document.getElementById("txtDPT_CD_SHR").className     = "input_ReadOnly";
            document.getElementById("imgDPT_CD_SHR").style.display = "none";
            document.getElementById("imgENO_NO_SHR").style.display = "none";
<%
    }
%>


        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ���󼼰��� �˾�        *
         *******************************************/
        function openPopupWin()
        {

            var EVL_YY = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
            var EVL_FRQ = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
            var ENO_NO = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
            var ENO_NM = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NM");
            var DPT_NM = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"DPT_NM");
            var EVLENO_NO = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVLENO_NO");
            var AIM_YMD = dsT_EV_AIMLST_01.NameValue(dsT_EV_AIMLST_01.RowPosition,"AIM_YMD");
            var ACCEPT_YMD = dsT_EV_AIMLST_01.NameValue(dsT_EV_AIMLST_01.RowPosition,"ACCEPT_YMD");

            var revck    = null;

            url = "/hr/" + "vlu" + "/" + "vluc121.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&ENO_NO="+ENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM+"&EVLENO_NO="+EVLENO_NO+"&AIM_YMD="+AIM_YMD+"&ACCEPT_YMD="+ACCEPT_YMD;

            // ���󼼰��� ȭ�� ȣ��
            revck = window.showModalDialog(url, "AIMLST_01", "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null)
                return;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsT_EV_AIMLST_01"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <Object ID="dsT_EV_TYPE"
        ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->

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

    <script language=JavaScript for=grdT_EV_AIMLST event=OnClick(row,colid)>
        if( row > 0 )
            fnc_SearchList('2');        //�ۼ�����,�������� ��ȸ
    </script>

    <script language=JavaScript for=grdT_EV_AIMLST_01    event=OnDblClick(row,colid)>
        if( row > 0 )
            openPopupWin('S');        //���󼼰��� �˾�
    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {

            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_AIMLST.CountRow);

        }

           grdT_EV_AIMLST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_AIMLST_01 Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�

        }

           grdT_EV_AIMLST_01.SetColumn("AIM_YMD_VIEW");//set focus

    </Script>

    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            //ȸ���޺� ��λ���
            for( i=0; i<=document.getElementById("cmbEVL_FRQ_SHR").length; i++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
            }

        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            var oOption;
            //ȸ���޺� ��λ���
            for( j=0; j<=document.getElementById("cmbEVL_FRQ_SHR").length; j++ ) {
                document.getElementById("cmbEVL_FRQ_SHR").remove(0);
                document.getElementById("cmbEVL_FRQ_SHR").remove(1);
            }
            for( k=1; k<=Number(dsT_EV_TYPE.NameValue(1,"ACH_CNT")); k++ ) {        //������ȸ��
                oOption = document.createElement("OPTION");
                oOption.value = k;
                oOption.text = k;
                document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

         document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_AIMLST_01 Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadError()">

        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

         document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_AIMLST_01 Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->


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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ǥ��Ȳ</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">��ǥ��Ȳ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('1');"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image0','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image0" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="60 "></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="40 "></col>
                                    <col width="60 "></col>
                                    <col width="100"></col>
                                    <col width="45 "></col>
                                    <col width="170"></col>
                                    <col width="45 "></col>
                                    <col width="170"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵</td>
                                    <td class="padding2423"><select id=cmbEVL_YY_SHR onChange="fnc_SearchItem();"><select></td>
                                    <td align="right" class="searchState">ȸ��</td>
                                    <td class="padding2423">
                                        <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList('1');" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">�򰡱׷�</td>
                                    <td class="padding2423">
                                        <input type="hidden" id="txtCOMM_CD_SHR" name="txtCOMM_CD_SHR">
                                        <select id=cmbGROUP_CD_SHR style="WIDTH: 100%" onChange="fnc_SearchList('1');" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                            <option value='' selected>�� ü</option>
                                        </select>
                                    </td>
                                    <td align="right" class="searchState">�Ҽ�</td>
                                    <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="8"  maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1');">
                                    <input name=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly>&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                    </td>
                                    <td align="right" class="searchState">���</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="8" maxlength="10" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList('1'); cfNumberCheck();">
                                    <input name=txtENO_NM_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly>&nbsp;<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:619px;height:340px;">
                                <param name="DataID"                    value="dsT_EV_AIMLST">
                                <param name="EdiTABLE"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                    value="Left">
                                <param name="IndWidth"                    value=0>
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="Format"                    value="
                                    <C> id={String(currow)}        width=50        name='����'         align=center </C>
                                    <C> id='GROUP_NM'        width=80        name='�򰡱׷�'        align=left </C>
                                    <C> id='HEAD_NM'        width=83        name='����'        align=left </C>
                                    <C> id='DPT_NM'        width=80        name='�Ҽ�'            align=left </C>
                                    <C> id='JOB_NM'        width=80        name='����'            align=left </C>
                                    <C> id='ENO_NO'        width=70        name='���'            align=center </C>
                                    <C> id='ENO_NM'        width=70        name='����'            align=center </C>
                                    <C> id='EVLENO_NM'        width=70        name='����'        align=center </C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                        <td width="30"></td>
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_AIMLST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:176px;height:340px;">
                                <param name="DataID"                    value="dsT_EV_AIMLST_01">
                                <param name="Editable"                    value="true">
                                <param name="DragDropEnable"            value="true">
                                <param name="SortView"                    value="Left">
                                <param name="IndWidth"                    value=0>
                                <param name="VIEWSUMMARY"                value=0>
                                <param name="Format"                    value="
                                    <C> id='AIM_YMD_VIEW'        width=70        name='�ۼ�����',        align=center         </C>
                                    <C> id='ACCEPT_YMD'        width=70        name='��������'            align=center </C>
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