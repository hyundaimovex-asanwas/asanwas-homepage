<!--
    ************************************************************************************
    * @Source         : vlud050.jsp                                                    *
    * @Description    : �򰡹ݿ���Ȳ PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/03  |  ������   | �����ۼ�                                               *
    * 2007/03/19  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�򰡹ݿ���Ȳ(vlud050)</title>
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

        var EVL_YY = new Array();
        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var APPLY_GBN = form1.cmbAPPLY_GBN_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var DPT_CD    = form1.txtDPT_CD_SHR.value;
            var CountRow = 0;

            // ���۳⵵�� ����⵵ üũ
            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY2_SHR)) {
                    return;
                }
            }
            else {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY1_SHR)) {
                    return;
                }
            }

            EVL_YY1 = EVL_YY[0];
            EVL_YY2 = EVL_YY[1];
            EVL_YY3 = EVL_YY[2];
            EVL_YY4 = EVL_YY[3];
            EVL_YY5 = EVL_YY[4];

            dsT_EV_EVLAPPLY.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud050.cmd.VLUD050CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY1="+EVL_YY1+"&EVL_YY2="+EVL_YY2+"&EVL_YY3="+EVL_YY3+"&EVL_YY4="+EVL_YY4+"&EVL_YY5="+EVL_YY5+"&APPLY_GBN="+APPLY_GBN+"&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
            dsT_EV_EVLAPPLY.Reset();

            CountRow = dsGT_EV_EVLAPPLY.CountRow;

            // GroupExpr�� DATASET Load
            if (CountRow == 0)    {

                fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            } else {

                fnc_Message(document.getElementById("resultMessage"), "MSG_03", CountRow);

            }

            form1.grdGT_EV_EVLAPPLY.Focus();

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
 			var APPLY_GBN = form1.cmbAPPLY_GBN_SHR.value;
            var ENO_NO    = form1.txtENO_NO_SHR.value;
            var DPT_CD    = form1.txtDPT_CD_SHR.value;

            // ���۳⵵�� ����⵵ üũ
            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY2_SHR)) {
                    return;
                }
            }
            else {
                if (!fnc_ChkEvlyy(form1.cmbEVL_YY1_SHR)) {
                    return;
                }
            }

            EVL_YY1 = EVL_YY[0];
            EVL_YY2 = EVL_YY[1];
            EVL_YY3 = EVL_YY[2];
            EVL_YY4 = EVL_YY[3];
            EVL_YY5 = EVL_YY[4];

            params = "APPLY_GBN="+APPLY_GBN
                   + "&ENO_NO="+ENO_NO
                   + "&DPT_CD="+DPT_CD
                   + "&EVL_YY1="+EVL_YY1
                   + "&EVL_YY2="+EVL_YY2
                   + "&EVL_YY3="+EVL_YY3
                   + "&EVL_YY4="+EVL_YY4
                   + "&EVL_YY5="+EVL_YY5
                   ;

			var url = "vlud050_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsGT_EV_EVLAPPLY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdGT_EV_EVLAPPLY.GridToExcel("�򰡹ݿ���Ȳ", '', 225)

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

            document.getElementById("txtENO_NO_SHR").value = '';
            document.getElementById("txtENO_NM_SHR").value = '';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';

            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EV_EVLAPPLY.ClearData();
            dsGT_EV_EVLAPPLY.ClearData();

            document.form1.txtDPT_CD_SHR.focus();

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
            cfStyleGrid(form1.grdGT_EV_EVLAPPLY,0,"false","false");

            getSelYy2('cmbEVL_YY1_SHR');
            getSelYy2('cmbEVL_YY2_SHR');

            // ��������
            if (frameid == "vlud050") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            // �ʱ�ȭ
            for (var i = 0; i < 5; i++) {

                EVL_YY[i] = '';

            }

            EVL_YY[0] = form1.cmbEVL_YY1_SHR.value;

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
         * �⵵�ʵ� �� ����� ���۳⵵�� ����⵵ check      *
         ****************************************************/
        function fnc_ChkEvlyy(target) {

            var CNT = new Number(form1.cmbEVL_YY2_SHR.value) -  new Number(form1.cmbEVL_YY1_SHR.value);

            if (form1.cmbEVL_YY1_SHR.value > form1.cmbEVL_YY2_SHR.value) {
                alert("���۳⵵�� ����⵵���� Ů�ϴ�.");
                target.focus();
                return false;
            }

            if (CNT >= 5) {
                alert("�ִ� 5�Ⱓ �����͸� ��ȸ�� �� �ֽ��ϴ�.");
                target.focus();
                return false;
            }

            // �ʱ�ȭ
            for (var i = 0; i < 5; i++) {

                EVL_YY[i] = '';

            }

            for (i = 0; i <= CNT; i++) {

                EVL_YY[i] = Number(form1.cmbEVL_YY1_SHR.value) + i;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_EVLAPPLY)  |
    | 3. ���Ǵ� Table List(T_EV_EVLAPPLY)         |
    +----------------------------------------------->
    <Object ID="dsT_EV_EVLAPPLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. GroupExpr�� DataSet                        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_QSTANS)    |
    | 3. ���Ǵ� Table List(T_EV_QSTANS)           |
    +----------------------------------------------->
    <Object ID="dsGT_EV_EVLAPPLY" Classid="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Logical"        Value="true">
        <Param Name="DataID"         Value="dsT_EV_EVLAPPLY">
        <Param Name="GroupExpr"      Value="HEAD_SEQ:DPT_SEQ:JOB_SEQ:ENO_NO:HEAD_NM:DPT_NM:JOB_NM:ENO_NM:TOT_APPLY_RATE,EVL_YY,APPLY_RATE">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_EVLAPPLY Event="OnDataError()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�򰡹ݿ���Ȳ</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�򰡹ݿ���Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                                <col width="50"></col>
                                <col width="130"></col>
                                <col width="25"></col>
                                <col width="30"></col>
                                <col width="25"></col>
                                <col width="160"></col>
                                <col width="25"></col>
                                <col width="160"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">��ȸ�Ⱓ</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY1_SHR" name="cmbEVL_YY1_SHR" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="javascript:if (fnc_ChkEvlyy(this)) { fnc_SearchList(); }"></select>�� ~
                                    <select id="cmbEVL_YY2_SHR" name="cmbEVL_YY2_SHR" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="javascript:if (fnc_ChkEvlyy(this)) { fnc_SearchList(); }"></select>��
                                </td>
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <select id="cmbAPPLY_GBN_SHR" name="cmbAPPLY_GBN_SHR" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()"  onChange="fnc_SearchList()">
                                        <option value="1">������</option>
                                        <option value="2">�󿩱�</option>
                                        <!--option>��������</option-->
                                    </select> </td>
                                </td>
                                <td align="right" class="searchState">�Ҽ�</td>
                                <td class="padding2423"><input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="10"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="12" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���</td>
                                <td class="padding2423"><input id=txtENO_NO_SHR name=txtENO_NO_SHR size="10"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');"> <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="10" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image20','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image20" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                        <object    id="grdGT_EV_EVLAPPLY" classid="CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"            value="dsGT_EV_EVLAPPLY">
                            <param name="EdiTABLE"          value="false">
                            <param name="DragDropEnable"    value="true">
                            <param name="SortView"          value="Left">
                            <param name="GTitleHeight"      value=0>
                            <param name="VIEWSUMMARY"       value=0>
                            <param name="Format"            value="
                                <C> id='{currow}'           width=60    name='����'    align=center HeadBgColor='#F7DCBB' </C>
                                <C> id='HEAD_NM'            width=100   name='����'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='DPT_NM'             width=100   name='�Ҽ�'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='JOB_NM'             width=100   name='����'    align=left   HeadBgColor='#F7DCBB' </C>
                                <C> id='ENO_NO'             width=100   name='���'    align=center HeadBgColor='#F7DCBB' </C>
                                <C> id='ENO_NM'             width=100   name='����'    align=center HeadBgColor='#F7DCBB' </C>
                                <R>
                                    <G> name=$xkeyname_$$  HeadBgColor='#F7DCBB'
                                        <C> id='APPLY_RATE_$$'  width=50  name='������'  align=right HeadBgColor='#F7DCBB' </C>
                                    </G>
                                </R>
                                <C> id='TOT_APPLY_RATE'     width=50    name='�հ�'    align=right  HeadBgColor='#F7DCBB' </C>
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