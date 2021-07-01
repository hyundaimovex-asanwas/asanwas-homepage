<!--
    ************************************************************************************
    * @Source         : misc280.jsp                                                    *
    * @Description    : ����������(�ι���) PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/16  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>����������(�ι���)(misc280)</title>
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

        var btnList  = 'TFFTTTFT';
        var year     = getToday().substr(0,4);
        var PlanYear = new Number(getToday().substr(0,4)) + 1;
        var ProSts   = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var PIS_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var ITEM_CD  = document.getElementById("cmbITEM_CD_SHR").value;
            var PIS_YY2  = new Number(PIS_YY) - 1;

            if (PIS_YY == "") {
                alert("����⵵�� �ʼ��Է��׸��Դϴ�.");
                document.getElementById("cmbPIS_YY_SHR").focus();
                return;
            }

            dsT_MI_BUDGETMST.ClearData();

            dsT_MI_BUDGETMST.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc280.cmd.MISC280CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&OCC_CD="+OCC_CD+"&ITEM_CD="+ITEM_CD+"&PIS_YY2="+PIS_YY2;
            dsT_MI_BUDGETMST.Reset();

            form1.grdT_MI_BUDGETMST.Focus();

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

            var ITEM_CD  = document.getElementById("cmbITEM_CD_SHR").value;
            var OCC_CD   = document.getElementById("cmbOCC_CD_SHR").value;
            var PLN_YY   = document.getElementById("cmbPIS_YY_SHR").value;
            var CUR_YY   = new Number(PLN_YY) - 1;

            var url = "misc280_PV.jsp?item_cd="+ITEM_CD+"&occ_cd="+OCC_CD+"&cur_yy="+CUR_YY+"&pln_yy="+PLN_YY;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_MI_BUDGETMST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_MI_BUDGETMST.GridToExcel("����������(�ι���)", '', 225);

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

            document.getElementById("cmbPIS_YY_SHR").selectedIndex = 0;

            document.getElementById('cmbOCC_CD_SHR').selectedIndex  = 0;
            document.getElementById('cmbITEM_CD_SHR').selectedIndex = 0;

            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value);

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_MI_BUDGETMST.ClearData();

            form1.cmbPIS_YY_SHR.value = PlanYear;
            document.getElementById("cmbPIS_YY_SHR").focus();

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

            //Grid Style ����
            cfStyleGrid(form1.grdT_MI_BUDGETMST,0,"false","false");

            // ����⵵ �� ���Ⱓ ����
            dsT_CP_WORKLOG.ClearData();

            dsT_CP_WORKLOG.DataId = "/servlet/GauceChannelSVL?cmd=hr.mis.c.misc280.cmd.MISC280CMD&S_MODE=SHR_01";
            dsT_CP_WORKLOG.Reset();


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


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

       function fnc_setHirYm(pis_yy) {

            var Row     = dsT_CP_WORKLOG.NameValueRow("PIS_YY", pis_yy);
            var PAY_YM  = dsT_CP_WORKLOG.NameValue(Row, "PAY_YMD");
            var bef_yy  = new Number(pis_yy) - 1;

            // �׸����� �÷���
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP','Name') = bef_yy + "�⵵ ����";
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP2','Name') = bef_yy + "�⵵ ��������";
            form1.grdT_MI_BUDGETMST.ColumnProp('AFT_GRP','Name') = pis_yy + "�⵵ ����";

            // ��ȹ���
            // ����⵵�� ���⵵�� ���
            if (PAY_YM.substr(0,4) != pis_yy) {

                var bef_month = new Number(PAY_YM.substr(4,2)) - 1
                form1.grdT_MI_BUDGETMST.ColumnProp('BEF1_SUM','Name') = "1�� ~ " + bef_month + "��;�� ��";

                if (PAY_YM.substr(4,2) != '12') {
                    form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = PAY_YM.substr(4,2) + "�� ~ 12��;��������";
                }
                else {
                    form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = "12�� ��������";
                }

            }

            // ����⵵�� ���س⵵�� ���
            if (PAY_YM.substr(0,4) == pis_yy) {

                form1.grdT_MI_BUDGETMST.ColumnProp('BEF1_SUM','Name') = "1�� ~ 12��;�� ��";
                form1.grdT_MI_BUDGETMST.ColumnProp('BEF2_SUM','Name') = "��������";

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_MI_BUDGETMST) |
    | 3. ���Ǵ� Table List(T_MI_BUDGETMST)        |
    +----------------------------------------------->
    <Object ID="dsT_MI_BUDGETMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param Name="SubSumExpr"      Value="total">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)   |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)          |
    +----------------------------------------------->
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_MI_BUDGETMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_MI_BUDGETMST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_MI_BUDGETMST Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_MI_BUDGETMST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

        var oOption;
        var Index  = document.getElementById("cmbPIS_YY_SHR").length;

        if (iCount == 0)    {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ����⵵ ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = getToday().substr(0,4);
            oOption.text  = getToday().substr(0,4);
            document.getElementById("cmbPIS_YY_SHR").add(oOption);
            var bef_yy = new Number(getToday().substr(0,4)) - 1;

            // �׸����� �÷���
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP','Name') = bef_yy + "�⵵ ����";
            form1.grdT_MI_BUDGETMST.ColumnProp('BEF_GRP2','Name') = bef_yy + "�⵵ ��������";
            form1.grdT_MI_BUDGETMST.ColumnProp('AFT_GRP','Name') = getToday().substr(0,4) + "�⵵ ����";

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ����⵵ ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbPIS_YY_SHR.options.remove(i);

            }

            //����⵵
            for( i = 1; i<= dsT_CP_WORKLOG.CountRow; i++ ) {
                oOption = document.createElement("OPTION");
                oOption.value = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                oOption.text  = dsT_CP_WORKLOG.NameValue(i, "PIS_YY");
                document.getElementById("cmbPIS_YY_SHR").add(oOption);

            }

            var obj    = document.getElementById("cmbPIS_YY_SHR");
            var idx    = obj.selectedIndex;
            var PIS_YY = obj.options[idx].text;

            ProSts = dsT_CP_WORKLOG.NameValue(1, "PRO_STS");

            fnc_setHirYm(document.getElementById("cmbPIS_YY_SHR").value);
        }

        document.getElementById("cmbPIS_YY_SHR").focus();

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>



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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������(�ι���)</td>
                    <td align="right" class="navigator">HOME/�濵����/�����ȹ/<font color="#000000">����������(�ι���)</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)">    <img src="/images/button/btn_PrintOn.gif"  name="Image6"    width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="90"></col>
                                <col width="100 "></col>
                                <col width="90 "></col>
                                <col width="100"></col>
                                <col width="90 "></col>
                                <col width="100"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">����⵵&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbPIS_YY_SHR" name="cmbPIS_YY_SHR"  onChange="fnc_setHirYm(this.value);" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">�ٷα���&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbOCC_CD_SHR" style="width:100%" >
                                        <option value="">��  ��</option>
                                        <option value="A">�繫��</option>
                                        <option value="M">�ù���</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�׸�&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id="cmbITEM_CD_SHR" style="width:100%" >
                                        <option value="1">�޿�</option>
                                        <option value="2">��</option>
                                        <option value="3">�߽Ĵ�</option>
                                        <option value="4">���ϱٹ�</option>
                                        <option value="5">��������</option>
                                        <option value="6">���ο���</option>
                                        <option value="7">��뺸��</option>
                                        <option value="8">�ǰ�����</option>
                                        <option value="9">�ǰ�����</option>
                                        <option value="10">���ڱ�</option>
                                    </select>
                                </td>
                                <td>&nbsp;</td>
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
                    <td valign="top" class="searchState" align="right" width="100">(���� : õ��)</span></td>
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
                        <object    id="grdT_MI_BUDGETMST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                            <param name="DataID"                  value="dsT_MI_BUDGETMST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C>  id='HEAD_NM'         width=100  name='����'                  align=center SubBgColor='#99FFCC' subsumtext='��  ��'</C>
                                <G>  id='BEF_GRP'         name='2006�⵵ ����' HeadBgColor='#F7DCBB'
                                     <C> id='BEF_AVG'     width=85   name='�������'              align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF_SUM'     width=85   name='�� ��'                 align=right  SubBgColor='#99FFCC' </C>
                                </G>
                                <G>  id='BEF_GRP2'        name='2006�⵵ ��������' HeadBgColor='#F7DCBB'
                                     <C> id='BEF1_SUM'    width=85   name='1��~9��;����'          align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF2_SUM'    width=85   name='10��~12��;��������'    align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF3_SUM'    width=85   name='��'                    align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='BEF_RATE'    width=85   name='��ȹ��;�޼���'         align=right  SubBgColor='#99FFCC' subsumtext={SubAvg(BEF_RATE)}</C>
                                </G>
                                <G>  id='AFT_GRP'         name='2007�⵵ ����' HeadBgColor='#F7DCBB'
                                     <C> id='AFT_AVG'     width=85   name='�������'              align=right  SubBgColor='#99FFCC' </C>
                                     <C> id='AFT_SUM'     width=85   name='�� ��'                 align=right  SubBgColor='#99FFCC' </C>
                                </G>
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

