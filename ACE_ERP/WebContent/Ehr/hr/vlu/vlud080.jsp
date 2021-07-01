<!--
    ************************************************************************************
    * @Source         : vlud080.jsp                                                    *
    * @Description    : �������(���) PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/11/22  |  ������   | �����ۼ�                                               *
    * 2007/03/19  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�������(���)(vlud080)</title>
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

        var btnList = 'TFFTFFFT';

        var frameid = window.external.GetFrame(window).FrameId;
        var GUBUN   = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud080.cmd.VLUD080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            var EVL_YY  = form1.cmbEVL_YY_SHR.value;

            // �׸��� ������ ��ȸ ��
            form1.txtFLAG.value = "1";

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud080.cmd.VLUD080CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

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


        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

  			var EVL_YY  = form1.cmbEVL_YY_SHR.value;
            var EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            var EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;

			params = "GUBUN=" + GUBUN + "&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ;

			var url = "vlud080_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_EV_ABLRST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ABLRST.GridToExcel("�������(���)", '', 225)

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
            dsT_EV_ABLRST.ClearData();

            document.form1.cmbEVL_YY_SHR.focus();

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

            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_ABLRST,0,"false","false");

            getSelYy2('cmbEVL_YY_SHR');

            EVL_YY = form1.cmbEVL_YY_SHR.value;

            // Form Load ��
            form1.txtFLAG.value = "0";

            // ��������
            if (frameid == "vlud080") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            dsT_EV_TYPE.ClearData();

            dsT_EV_TYPE.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud080.cmd.VLUD080CMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY;
            dsT_EV_TYPE.Reset();

            form1.cmbEVL_YY_SHR.focus();

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



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ABLRST)    |
    | 3. ���Ǵ� Table List(T_EV_ABLRST)           |
    +----------------------------------------------->
    <Object ID="dsT_EV_ABLRST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <Param Name="SortExpr"        Value="+OCC_CD+HEAD_SEQ+HEAD_CD">
        <Param Name="SubsumExpr"      Value="total,2:OCC_CD,1:HEAD_CD">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_TYPE)      |
    | 3. ���Ǵ� Table List(T_EV_TYPE)             |
    +----------------------------------------------->
    <Object ID="dsT_EV_TYPE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EV_ABLRST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_ABLRST.CountRow );

            var szSubSumText = "{decode(curlevel,1,'',2,'',9999,'��  ��')}";
            form1.grdT_EV_ABLRST.ColumnProp("OCC_NM", "SubSumText") = szSubSumText;

            var szSubSumText = "{decode(curlevel,1,'�Ұ�',2,'��',9999,'')}";
            form1.grdT_EV_ABLRST.ColumnProp("HEAD_NM", "SubSumText") = szSubSumText;

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_ABLRST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_TYPE Event="OnLoadCompleted(iCount)">
        var EVL_YY  = '';
        var EVL_GBN = '';
        var EVL_FRQ = '';

        var oOption;
        var Index = document.getElementById("cmbEVL_FRQ_SHR").length;

        if (iCount == 0)    {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            oOption = document.createElement("OPTION");
            oOption.value = 1;
            oOption.text  = '1ȸ';
            document.getElementById("cmbEVL_FRQ_SHR").add(oOption);

        }
        else {

            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            //ȸ��
            //������ ȸ���޺� ������ ��λ���
            for( var i = Index; i >= 0; i--){

                form1.cmbEVL_FRQ_SHR.options.remove(i);

            }

            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '1' ) {

                //������ȸ��
                for( i = 1; i<= Number(dsT_EV_TYPE.NameValue(1,"ABL_CNT")); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }

            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '2' ) {

                //������ȸ��
                for( i=1; i<=dsT_EV_TYPE.NameValue(1,"ACH_CNT"); i++ ) {
                    oOption = document.createElement("OPTION");
                    oOption.value = i;
                    oOption.text  = i+'ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);
                }

            }
            //����
            if( document.getElementById("cmbEVL_GBN_SHR").value == '3' ) {

                //������ȸ��

                    oOption = document.createElement("OPTION");
                    oOption.value = 1;
                    oOption.text  = '1 ȸ';
                    document.getElementById("cmbEVL_FRQ_SHR").add(oOption);


            }
        }

        if (form1.txtFLAG.value == "1") {

            EVL_YY  = form1.cmbEVL_YY_SHR.value;
            EVL_GBN = form1.cmbEVL_GBN_SHR.value;
            EVL_FRQ = form1.cmbEVL_FRQ_SHR.value;

            dsT_EV_ABLRST.ClearData();

            dsT_EV_ABLRST.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.d.vlud080.cmd.VLUD080CMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_GBN="+EVL_GBN+"&EVL_FRQ="+EVL_FRQ;
            dsT_EV_ABLRST.Reset();

            form1.grdT_EV_ABLRST.Focus();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_TYPE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������(���)</td>
                    <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">�������(���)</font></td>
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
                                <col width="100"></col>
                                <col width="80"></col>
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">
                                    <select id="cmbEVL_YY_SHR" name="cmbEVL_YY_SHR" onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                    </select>
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_GBN_SHR onChange="JavaScript: fnc_SearchItem();" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">����</option>
                                        <option value="2">����</option>
                                        <option value="3">����</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">ȸ��&nbsp;</td>
                                <td class="padding2423">
                                    <select id=cmbEVL_FRQ_SHR onChange="fnc_SearchList()" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()">
                                        <option value="1">1ȸ</option>
                                        <option value="2">2ȸ</option>
                                        <option value="3">3ȸ</option>
                                        <option value="4">4ȸ</option>
                                    </select> </td>
                                </td>
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
                        <object    id="grdT_EV_ABLRST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                            <param name="DataID"                  value="dsT_EV_ABLRST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <X> name='��    ��' HeadBgColor='#F7DCBB'
                                    <C> id='OCC_NM'       width=55    name='�ٷα���'        align=left   SubBgColor=#99FFCC subsumtext='' suppress=2 </C>
                                    <C> id='HEAD_NM'      width=90    name='����'        align=left   SubBgColor=#99FFCC subsumtext='' suppress=1 </C>
                                    <C> id='GRD_GBN'      width=40    name='�ο�'        align=center SubBgColor=#99FFCC subsumtext={subsum(S_CNT) + subsum(A_CNT) + subsum(B_CNT) + subsum(C_CNT) + subsum(D_CNT)}</C>
                                </X>
                                <X> name='�� �� �� �� ��    �� ��' HeadBgColor='#F7DCBB'
                                    <G> name='S;(5%)' HeadBgColor='#F7DCBB'
                                        <C> id='S_DPT'    width=100    name='�Ҽ�'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='S_JOB'    width=60    name='����'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='S_ENO'    width=80    name='����'        align=center SubBgColor=#99FFCC subsumtext={IF(subsum(S_CNT)=0,' ',subsum(S_CNT))}</C>
                                    </G>
                                    <G> name='A;(10%)' HeadBgColor='#F7DCBB'
                                        <C> id='A_DPT'    width=100    name='�Ҽ�'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='A_JOB'    width=60    name='����'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='A_ENO'    width=80    name='����'        align=center SubBgColor=#99FFCC subsumtext={IF(subsum(A_CNT)=0,' ',subsum(A_CNT))}</C>
                                    </G>
                                    <G> name='B;(70%)' HeadBgColor='#F7DCBB'
                                        <C> id='B_CNT'    width=40    name='�ο�'        align=center SubBgColor=#99FFCC subsumtext={IF(subsum(B_CNT)=0,' ',subsum(B_CNT))} value={decode(B_CNT,'0','',B_CNT)}</C>
                                    </G>
                                    <G> name='C;(10%)' HeadBgColor='#F7DCBB'
                                        <C> id='C_DPT'    width=100    name='�Ҽ�'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='C_JOB'    width=60    name='����'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='C_ENO'    width=80    name='����'        align=center SubBgColor=#99FFCC subsumtext={IF(subsum(C_CNT)=0,' ',subsum(C_CNT))}</C>
                                    </G>
                                    <G> name='D;(5%)' HeadBgColor='#F7DCBB'
                                        <C> id='D_DPT'    width=100    name='�Ҽ�'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='D_JOB'    width=60    name='����'        align=left   SubBgColor=#99FFCC </C>
                                        <C> id='D_ENO'    width=80    name='����'        align=center SubBgColor=#99FFCC subsumtext={IF(subsum(D_CNT)=0,' ',subsum(D_CNT))}</C>
                                    </G>
                                </X>
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