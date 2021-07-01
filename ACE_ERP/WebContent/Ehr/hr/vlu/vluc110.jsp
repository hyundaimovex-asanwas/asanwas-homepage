<!--
    ************************************************************************************
    * @Source         : vluc110.jsp                                                    *
    * @Description    : ������ǥ����.                                                  *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/10/23  |  ���ؼ�   | �����ۼ�                                               *
    * 2007/03/17  |  ������   | ����. (�����򰡾������� �߰�)                          *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

    <head>
    <title>������ǥ����(vluc110)</title>
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

            //�����ͼ� ����(������ǥ���� ��ȸ)
            dsT_EV_AIMLST.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.c.vluc110.cmd.VLUC110CMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_YY_SHR="+document.getElementById("txtEVL_YY_SHR").value+"&txtEVL_FRQ_SHR="+document.getElementById("txtEVL_FRQ_SHR").value+"&&txtEVLENO_NO_SHR="+document.getElementById("txtEVLENO_NO_SHR").value;
            dsT_EV_AIMLST.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�⵵�� ��ȸ������ ��ȸ
            dsT_EV_ESTINFO.DataID = "/servlet/GauceChannelSVL?cmd=common.yearmonth.cmd.YEARMONTHCMD&S_MODE=SHR&GUBUN="+GUBUN+"&txtEVL_GBN_SHR=2";
            dsT_EV_ESTINFO.Reset();

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

            dsT_EV_AIMLST.ClearAll();

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

            // ��������
            if (frameid == "vluc110") {
                // �λ���
                GUBUN = "01";

                document.getElementById("loctitle").innerText = "HOME/�λ���/������/";

            }
            else {
                // ������
                GUBUN = "02";

                document.getElementById("loctitle").innerText = "HOME/��������/������/������/";
            }

            //�⵵�� ��ȸ������ ��ȸ
            fnc_SearchItem();

        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************************************
         * 15. ���ǿ� ���� ,        *
         *        ��ǥ������ �Է� disable,                            *
         *******************************************/
        function fnc_DisableSet(disableDiv) {

            if( disableDiv == 'true' ) {

            } else {

            }

        }

        /********************************************
         * 16. ������ǥ����ó�� �˾�        *
         *******************************************/
        function openPopupWin()
        {
            var EVL_YY     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_YY");
            var EVL_FRQ    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"EVL_FRQ");
            var AIM_YMD    = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"AIM_YMD");
            var ENO_NO     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NO");
            var EVLENO_NO  = document.getElementById("txtEVLENO_NO_SHR").value;
            var ENO_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"ENO_NM");
            var DPT_NM     = dsT_EV_AIMLST.NameValue(dsT_EV_AIMLST.RowPosition,"DPT_NM");

            var revck    = null;

            url = "/hr/" + "vlu" + "/" + "vluc111.jsp?GUBUN="+GUBUN+"&EVL_YY="+EVL_YY+"&EVL_FRQ="+EVL_FRQ+"&AIM_YMD="+AIM_YMD+"&ENO_NO="+ENO_NO+"&EVLENO_NO="+EVLENO_NO+"&ENO_NM="+ENO_NM+"&DPT_NM="+DPT_NM;

            // ��ǥ���� ȭ�� ȣ��
            revck = window.showModalDialog(url, self, "dialogHeight:550px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            if (revck == -1 || revck == null)
                return;

        }

        /********************
         * 17. ����Ű ó��  *
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

    <script language=JavaScript for=grdT_EV_AIMLST event=OnDblClick(row,colid)>

        if (row < 1) return;
        openPopupWin();        //������ǥ����ó�� �˾�

    </script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_AIMLST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("���ϴ� ������ǥ�� ���� �� ����� �����ϴ�.");

        } else {

        }

           grdT_EV_AIMLST.SetColumn("ENO_NO");//set focus

    </Script>

    <Script For=dsT_EV_ESTINFO Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            alert("������Ⱓ�� �ƴմϴ�.");

        } else {

            document.getElementById("txtEVL_YY_SHR").value    = dsT_EV_ESTINFO.NameValue(1,"EVL_YY");
            document.getElementById("txtEVL_FRQ_SHR").value   = dsT_EV_ESTINFO.NameValue(1,"EVL_FRQ");
            document.getElementById("txtEVLENO_NO_SHR").value = '<%=box.get("SESSION_ENONO")%>';
            document.getElementById("txtENO_NM_SHR").value    = '<%=box.get("SESSION_ENONM")%>';
            document.getElementById("txtDPT_NM_SHR").value    = '<%=box.get("SESSION_DPTNM")%>';

             fnc_SearchList();
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_AIMLST Event="OnLoadError()">

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
<!-- �׸��� Ŭ���� -->

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
                        <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ǥ����</td>
                        <td align="right" class="navigator"><span id="loctitle">&nbsp;</span><font color="#000000">������ǥ����</font></td>
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
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="70"></col>
                                    <col width="60"></col>
                                    <col width="75"></col>
                                    <col width="120"></col>
                                    <col width="75"></col>
                                    <col width="65"></col>
                                    <col width="75"></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">�ش�⵵</td>
                                    <td class="padding2423"><input id=txtEVL_YY_SHR size="10" maxlength="4" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">ȸ��</td>
                                    <td class="padding2423"><input id=txtEVL_FRQ_SHR size="10" maxlength="3" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">�Ҽ�</td>
                                    <td class="padding2423"><input id=txtDPT_NM_SHR size="15" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">���� ���</td>
                                    <td class="padding2423"><input id=txtEVLENO_NO_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
                                    </td>
                                    <td align="right" class="searchState">����</td>
                                    <td class="padding2423"><input id=txtENO_NM_SHR size="15" style="text-align:center;" class="input_ReadOnly" readonly>
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

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8"><img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                <strong>������ List</strong></td>
        </tr>
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EV_AIMLST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                                <param name="DataID"                  value="dsT_EV_AIMLST">
                                <param name="Editable"                value="false">
                                <param name="DragDropEnable"          value="true">
                                <param name="SortView"                value="Left">
                                <param name="VIEWSUMMARY"             value=0>
                                <param name="Format"                  value="
                                    <C> id=''       width=50        name='����'     align=center        value={(String(Currow))} </C>
                                    <C> id='GROUP_NM'       width=82        name='�򰡱׷�'     align=left </C>
                                    <C> id='HEAD_NM'       width=100        name='����'     align=left </C>
                                    <C> id='DPT_NM'       width=81        name='�Ҽ�'     align=left </C>
                                    <C> id='JOB_NM'       width=81        name='����'     align=left </C>
                                    <C> id='ENO_NO'       width=80        name='���'     align=center </C>
                                    <C> id='ENO_NM'       width=80        name='����'     align=center </C>
                                    <C> id='AIM_YMD'       width=70        name='��������'     align=center </C>
                                    <C> id='AIM_INPUT_GBN'       width=80        name='��ǥ�Է¿���'     align=center    value={'�Է�'} </C>
                                    <C> id='ACCEPT_GBN'       width=60        name='���ο���'     align=center        editstyle=combo data='0:�̽���,1:����,2:�ݷ�,3:�������' </C>
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