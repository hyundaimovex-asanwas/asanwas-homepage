<!--
    ************************************************************************************
    * @Source         : jobb020.jsp                                                    *
    * @Description    : �ڱ�Ű�������Ȳ PAGE                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/11  |  ���뼺   | �����ۼ�                                               *
    * 2006/10/30  |  ������   | ����                                                   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�ڱ�Ű�������Ȳ(jobb020)</title>
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

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var PIS_YYMM = form1.txtPIS_YYMM_SHR.value;
            var OCC_CD   = form1.cmbOCC_CD_SHR.value;
            var CountRow = 0;

            if (!fncCheckDate()) {
                dsT_EV_QSTANS.ClearData();
                return;
            }

            dsT_EV_QSTANS.DataId = "/servlet/GauceChannelSVL?cmd=hr.job.b.jobb020.cmd.JOBB020CMD&S_MODE=SHR&PIS_YYMM="+PIS_YYMM+"&OCC_CD="+OCC_CD;
            dsT_EV_QSTANS.Reset();

            CountRow = dsGT_EV_QSTANS.CountRow;

            // GroupExpr�� DATASET Load
            if (dsGT_EV_QSTANS.CountRow == 0)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", CountRow - 1);

            }

            form1.grdT_EV_QSTANS.Focus();

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

            if (dsGT_EV_QSTANS.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdGT_EV_QSTANS.GridToExcel("�ڱ�Ű�������Ȳ", '', 225)

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
            form1.cmbOCC_CD_SHR.value = '';

            // DataSet Clear
            dsT_EV_QSTANS.ClearData();
            dsGT_EV_QSTANS.ClearData();

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
            var oOption = null;

            // ������
            form1.txtPIS_YYMM_SHR.value = getToday().substring(0,7);

            //Grid Style ����
            cfStyleGrid(form1.grdGT_EV_QSTANS,0,"false","false");

            form1.txtPIS_YYMM_SHR.focus();

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

        /*****************************************************
         * ��¥ ���� ��ȿ�� üũ                             *
         ****************************************************/
        function fncCheckDate() {
            if (form1.txtPIS_YYMM_SHR.value == '') {
                alert('��¥�� �Է��Ͻñ� �ٶ��ϴ�.');
                form1.txtPIS_YYMM_SHR.focus();
                return false;
            }

            if(!cfDateExpr(form1.txtPIS_YYMM_SHR.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                form1.txtPIS_YYMM_SHR.focus();
                return false;
            }

            return true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_QSTANS)    |
    | 3. ���Ǵ� Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_QSTANS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. GroupExpr�� DataSet                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_QSTANS)    |
    | 3. ���Ǵ� Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsGT_EV_QSTANS" Classid="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Logical"        Value="true">
        <Param Name="DataID"         Value="dsT_EV_QSTANS">
        <Param Name="GroupExpr"      Value="DPT_NM:TOT_CNT:DPT_CNT,QST_ITEM_SNM,ANS_PER1:ANS_PER2">
    </Object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_QSTANS Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_QSTANS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_QSTANS Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsGT_EV_QSTANS Event="OnLoadCompleted(iCount)">

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
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ڱ�Ű�������Ȳ</td>
                    <td align="right" class="navigator">HOME/�����̵�/�����̵���Ȳ/<font color="#000000">�ڱ�Ű�������Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
       <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle"></a>  -->
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image8','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image8" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<!-- ���� �Է� ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="greenTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="80"></col>
                                <col width="560"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">������&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YYMM_SHR" size="7" maxlength="7" onblur="cfCheckDate(this);" style="ime-mode:disabled"  onChange="fnc_SearchList()" onKeyPress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList()">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtPIS_YYMM_SHR','','150','138');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">�ٷα���&nbsp;</td>
                                <td class="">
                                    <select name="cmbOCC_CD_SHR" style="WIDTH: 15%" onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="">�� ü</option>
                                        <option value="A">�繫��</option>
                                        <option value="M">�ù���</option>
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
        <td class="paddingTop3">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdGT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"              value="dsGT_EV_QSTANS">
                            <param name="IndWidth"            value=0>
                            <param name="Format"              value="
                                <FC> id='DPT_NM'              width=120   name='����'      align=left  HeadBgColor='#F7DCBB' </FC>
                                <FC> id='TOT_CNT'             width=60    name='����ο�'    align=right HeadBgColor='#F7DCBB' Value={Decode(TOT_CNT,'0','',TOT_CNT)} </FC>
                                <FC> id='DPT_CNT'             width=60    name='�����ο�'  align=right HeadBgColor='#F7DCBB' Value={Decode(DPT_CNT,'0','',DPT_CNT)} </FC>
                                <R>
                                    <G> name=$xkeyname_$$  HeadBgColor='#F7DCBB'
                                        <C> id='ANS_PER1_$$'  width=55    name='����'      align=right HeadBgColor='#F7DCBB' Value={Decode(ANS_PER1_$$,'0','',ANS_PER1_$$)} </C>
                                        <C> id='ANS_PER2_$$'  width=55    name='������'    align=right HeadBgColor='#F7DCBB' Value={Decode(ANS_PER2_$$,'0','',ANS_PER2_$$)} </C>
                                    </G>
                                </R>
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

<!-- ���� ��ȸ �׸��� ���̺� ���� (��������)-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_EV_QSTANS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:0px;">
                            <param name="DataID"           value="dsT_EV_QSTANS">
                            <param name="EdiTABLE"         value="true">
                            <param name="DragDropEnable"   value="true">
                            <param name="SortView"         value="Left">
                            <param name="VIEWSUMMARY"      value="0">
                            <param name="Format"           value="
                                <FC> id='DPT_NM'           width=120   name='����'      align=left  </FC>
                                <FC> id='TOT_CNT'          width=60    name='����ο�'    align=right </FC>
                                <FC> id='DPT_CNT'          width=60    name='�����ο�'  align=right </FC>
                                <G> name='�����(%)'  HeadBgColor='#F7DCBB'
                                    <C> id='QST_ITEM_SNM'   width=70    name='A'        align=left  </C>
                                    <C> id='ANS_PER1'      width=70     name='B'        align=right </C>
                                    <C> id='ANS_PER2'      width=70     name='C'        align=right </C>
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