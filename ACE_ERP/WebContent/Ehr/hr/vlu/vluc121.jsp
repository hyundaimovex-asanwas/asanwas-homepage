<!--
    ************************************************************************************
    * @Source         : vluc121.jsp                                                    *
    * @Description    : ��ǥ��Ȳ��.                                                  *
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
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>��ǥ��Ȳ��(vluc121)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

<%
    String GUBUN       = request.getParameter("GUBUN");          //��������
    String EVL_YY      = request.getParameter("EVL_YY");         //�ش�⵵
    String EVL_FRQ     = request.getParameter("EVL_FRQ");        //ȸ��
    String ENO_NO      = request.getParameter("ENO_NO");         //�����ڻ��
    String ENO_NM      = request.getParameter("ENO_NM");         //�����ڼ���
    String DPT_NM      = request.getParameter("DPT_NM");         //�ҼӸ�
    String EVLENO_NO   = request.getParameter("EVLENO_NO");      //���ڻ��
    String AIM_YMD     = request.getParameter("AIM_YMD");        //��ǥ��������
    String ACCEPT_YMD  = request.getParameter("ACCEPT_YMD");     //��ǥ��������
%>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';

        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList(searchDiv) {

            if( searchDiv == '1' ) {
                if( !fnc_SearchItemCheck() ) return;

                //�����ͼ� ����
                dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc121.cmd.VLUC121CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&txtENO_NO_SHR="+document.getElementById("txtENO_NO_SHR").value+"&txtEVLENO_NO_SHR=<%=EVLENO_NO%>"+"&txtAIM_YMD_SHR=<%=AIM_YMD%>"+"&txtACCEPT_YMD_SHR=<%=ACCEPT_YMD%>";
                dsT_EV_AIMLST.Reset();
            }

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

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


           if (dsT_EV_AIMLST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_AIMLST.GridToExcel("��ǥ��Ȳ", '', 225);

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

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (dsT_EV_AIMLST.IsUpdated)  {

                if (!fnc_ExitQuestion()) return;

            }

            window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            if( !valid(form1) )
                return false;
            else
                return true;

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
            cfStyleGrid2(form1.grdT_EV_AIMLST);

            form1.txtEVL_YY_SHR.value     = "<%=EVL_YY%>";
            form1.txtEVL_FRQ_SHR.value    = "<%=EVL_FRQ%>";
            form1.txtENO_NO_SHR.value     = "<%=ENO_NO%>";
            form1.txtENO_NM_SHR.value     = "<%=ENO_NM%>";
            form1.txtDPT_NM_SHR.value     = "<%=DPT_NM%>";

            // ��������
            if ("<%=GUBUN%>" == "01") {
                // �λ���
                GUBUN = "01";

            }
            else {
                // ������
                GUBUN = "02";

            }

            // �⵵ �� ȸ���� ��ȸ�ϱ� ���� COMMON�� YEARMONTHCMD�� ���
            dsT_EV_ESTINFO.dataid = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.reset();

            fnc_SearchList('1');

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ��ǥ���� ���ο� ����,        *
         *        ��ǥ����ó���� �Է� disable,                            *
         *******************************************/
        function fnc_DisableSet(disableDiv) {

            if( disableDiv == '1' ) {    //�Է°���
                document.getElementById("cmbACCEPT_GBN_SHR").disabled=false;
            }
            if( disableDiv == '2' ) {    //�ԷºҰ�
                document.getElementById("cmbACCEPT_GBN_SHR").disabled=true;
            }

        }

        /********************
         * 16. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }

        function fnc_Disp_RefColumn() {

            var str_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_STDT");
            var end_ymd = dsT_EV_ESTINFO.NameValue(1, "EVL_ENDT");
            var str_mm = Number(str_ymd.substring(5,7));
            var end_mm = Number(end_ymd.substring(5,7));


            if("<%=EVL_FRQ%>" == "1"){
               str_mm = 01;
               end_mm = 06;
            }else{
               str_mm = 07;
               end_mm = 12;
            }

            for(var i=str_mm; i<=end_mm; i++){

                if(i == 1) {
                  form1.grdT_EV_AIMLST.ColumnProp("JAN_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JAN_DN_1", "Show") = "true";
                }

                if(i == 2) {
                  form1.grdT_EV_AIMLST.ColumnProp("FEB_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("FEB_DN_1", "Show") = "true";
                }

                if(i == 3) {
                  form1.grdT_EV_AIMLST.ColumnProp("MAR_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("MAR_DN_1", "Show") = "true";
                }

                if(i == 4) {
                  form1.grdT_EV_AIMLST.ColumnProp("APR_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("APR_DN_1", "Show") = "true";
                }

                if(i == 5) {
                  form1.grdT_EV_AIMLST.ColumnProp("MAY_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("MAY_DN_1", "Show") = "true";
                }

                if(i == 6) {
                  form1.grdT_EV_AIMLST.ColumnProp("JUN_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JUN_DN_1", "Show") = "true";
                }

                if(i == 7) {
                  form1.grdT_EV_AIMLST.ColumnProp("JUL_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("JUL_DN_1", "Show") = "true";
                }

                if(i == 8) {
                  form1.grdT_EV_AIMLST.ColumnProp("AUG_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("AUG_DN_1", "Show") = "true";
                }

                if(i == 9) {
                  form1.grdT_EV_AIMLST.ColumnProp("SEP_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("SEP_DN_1", "Show") = "true";
                }

                if(i == 10) {
                  form1.grdT_EV_AIMLST.ColumnProp("OCT_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("OCT_DN_1", "Show") = "true";
                }

                if(i == 11) {
                  form1.grdT_EV_AIMLST.ColumnProp("NOV_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("NOV_DN_1", "Show") = "true";
                }

                if(i == 12) {
                  form1.grdT_EV_AIMLST.ColumnProp("DEC_UP_1", "Show") = "true";
                  form1.grdT_EV_AIMLST.ColumnProp("DEC_DN_1", "Show") = "true";
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->
    <Object ID="dsT_EV_AIMLST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)   |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)          |
    +----------------------------------------------->


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = ' ';

            fnc_DisableSet('2');        //�ԷºҰ� ó��
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�..");


        } else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            document.getElementById("resultMessage").innerText = '* ' + dsT_EV_AIMLST.CountRow + ' ���� �ڷᰡ ��ȸ�Ǿ����ϴ�.';

               document.getElementById("cmbACCEPT_GBN_SHR").value = dsT_EV_AIMLST.NameValue(1,"ACCEPT_GBN");
            fnc_DisableSet('2');        //�ԷºҰ� ó��
        }

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {

            //������Ⱓ�� ���� �׸��� ����
            fnc_Disp_RefColumn();

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

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
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
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ǥ��Ȳ��</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit();"></a>
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
                                    <col width="85"></col>
                                    <col width="65"></col>
                                    <col width="55"></col>
                                    <col width="60"></col>
                                    <col width="45"></col>
                                    <col width="65"></col>
                                    <col width="160"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="65"></col>
                                    <col width="55"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵</td>
                                    <td class="padding2423"><input id=txtEVL_YY_SHR size="4" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='�ش�⵵'>
                                    </td>
                                    <td align="right" class="searchState">ȸ��</td>
                                    <td class="padding2423"><input id=txtEVL_FRQ_SHR size="2" maxlength="3" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='ȸ��'>
                                    </td>
                                    <td align="right" class="searchState">�Ҽ�</td>
                                    <td class="padding2423"><input id=txtDPT_NM_SHR size="14" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">������ ���</td>
                                    <td class="padding2423"><input id=txtENO_NO_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly valid='key=true' field='������ ���'>
                                    </td>
                                    <td align="right" class="searchState">����</td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR size="10" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">����</td>
                                    <td class="padding2423">
                                        <select id=cmbACCEPT_GBN_SHR style="width:100">
                                            <option value="0"> �̽���</option>
                                            <option value="1">����</option>
                                            <option value="2">�ݷ�</option>
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
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:329px;">
                                <param name="DataID"                  value="dsT_EV_AIMLST">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="AutoReSizing"            value="true">
                                <param name=ColSizing                 value="true">
                                <param name=ColSelect                 value="true">
                                <param name=SuppressOption            value="1">
                                <param name="Format"                  value="
                                <FC> id='AIM_SEQ'         width=50        name='����'             	  align=center    show=false        value={String(AIM_SEQ)} </FC>
                                <FC> id='TASK_AIM'        width=130       name='�ֿ� �ٽɰ���(����)'  align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 5       editlimit=200    </FC>
                                <FC> id='TASK_CSF'        width=130       name='�ٽɼ��� ���(CSF)'   align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 4       editlimit=200    </FC>
                                <FC> id='BASIC_PAR'       width=130       name='KPI (�������)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 3       editlimit=200 editStyle=Popup   </FC>
                                <FC> id='AIM_LEVEL'        width=100       name='��ǥ (Target)'       align=left      color='#087F01'   BgColor='#EEFBEE'       suppress= 2       editlimit=100    </FC>
                                <C> id='GAUGE_GB'         width=55        name='�跮;����'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       suppress= 1       editstyle=combo  data='1:�跮,2:��跮'   </C>
                                <C> id='ACCEPT_GBN'       width=80        name='��ǥ���ο���'         align=center    show=false        </C>
                                <C> id='ITEM_SEQ'         width=40        name='����'                 align=center    show=false        edit=none        value={String(ITEM_SEQ)} </C>
                                <C> id='ITEM_DEC'        width=100       name='�ֿ������׸�'     align=Left show=false     color='#EC4A0D'   BgColor='#FEEFEF'       editlimit=200      </C>
                                  <G> name='����ǥ(KPI)' HeadBgColor='#F7DCBB'
                                        <C> id='CRITR_S'    width=130        name='S - (110%�̻�)'      align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_A'    width=130        name='A - (100%~110%�̸�)' align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_B'    width=130        name='B - (95%~100%�̸�)'  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_C'    width=130        name='C - (85%~95%�̸�)'   align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
                                        <C> id='CRITR_D'    width=130        name='D - (85%�̸�)'       align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
    							   </G>
                                <C> id='ACT_TIM'          width=100       name='����ñ�'        	  align=center    color='#087F01'   BgColor='#EEFBEE'       editlimit=50     </C>
                                <C> id='ADDING_PCT'       width=40        name='����ġ;(100%)'           	  align=right     color='#087F01'   BgColor='#EEFBEE'           </C>
                                <C> id='HLP_REQ'          width=100       name='������û����'     	  align=Left      color='#087F01'   BgColor='#FEEFEF'       editlimit=200   </C>
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