<!--*************************************************************************
* @source      : insa070.jsp                                                *
* @description : ���ο��������ü PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/02/28            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
    <title>���ο��������ü(insa070)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var today = getToday();
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa070.cmd.INSA070CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻�����
            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(oFIXED_DATE.value.trim() == "") {
                alert("�������� ������ �ּ���.");
                oFIXED_DATE.focus();
                return;
            }

            params = "&S_MODE=SHR"
                   + "&FIXED_DATE="+oFIXED_DATE.value;

            dsT_CP_PAYMASTER.dataid = dataClassName+params;
            dsT_CP_PAYMASTER.reset();
        }

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {

        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {

        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_CP_PAYMASTER_CP.GridToExcel("���ο��������ü", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';
            dsT_CP_PAYMASTER.ClearData();

        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_PAYMASTER.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style ����

            document.getElementById("txtFIXED_DATE_SHR").value  = (getTodayArray()[0]-1)+"-10-01";
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/

        /**
         * ���Ϸ� ����
         */
        function fnc_ToFile() {
            var isFirst = true;
            var keys = "";
            var Noname = "";

            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(oFIXED_DATE.value.trim() == "") {
                alert("�������� ������ �ּ���.");
                oFIXED_DATE.focus();
                return;
            }
            if (dsT_CP_PAYMASTER.CountColumn == 0) {
                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
                return;
            }
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ����Ÿ�� �����ϴ�.");
                return;
            }

            //�˻��� ����Ʈ ��ŭ ���鼭 ���õ��� ���� key ���� ã�� �´�.
            for(i=1; i<=dsT_CP_PAYMASTER.CountRow; i++) {
                if(dsT_CP_PAYMASTER.NameString(i, "STATUS") == "0") {
                    if(isFirst) {
                 //       keys = i;
                        Noname = "'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                        isFirst = false;
                    } else {
                 //       keys += ","+i;
                        Noname += ","+"'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                    }
                }
            }

            params = "&S_MODE=FILE"
                   + "&FILE_NAME=����ƻ�(���ο���).txt"
                   + "&FIXED_DATE="+oFIXED_DATE.value
                   + "&KEYS="+keys
                   + "&NONAME="+Noname;

            var form = document.form1;
            form.method = "post";
            form.target = "file_down";
            form.action = "/servlet/JspChannelSVL?cmd=hr.ins.a.insa070.cmd.INSA070CMD_FILE"+params;
            form.submit();
        }
    </script>
</head>


    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_PAYMASTER)                |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_PAYMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_PAYMASTER)                |
    | 3. ���Ǵ� Table List(T_CP_PAYMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_PAYMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CP_PAYMASTER.CountRow);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CP_PAYMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnSuccess()">
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��������ü</td>
                    <td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��������ü</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" class="greenTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">������</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtFIXED_DATE_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIXED_DATE_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
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
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="3" cellpadding="0">
                    <tr>
                        <td valign="top" align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnCREATE','','/images/button/btn_FilecreateOver.gif',1)"><img src="/images/button/btn_FilecreateOn.gif" name="btnCREATE" width="80" height="20" border="0" align="absmiddle" onclick="fnc_ToFile()"></a>
                        </td>
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
                    <object id="grdT_CP_PAYMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                        <param name="DataID" value="dsT_CP_PAYMASTER">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"   width=50        align=center        name="NO"            Edit=none     SubBgColor="#99FFCC"</C>
                            <C> id=STATUS       width=120       align=center        name=���            EditStyle=CheckBox  CheckBoxText=ENO_NO    Pointer=Hand</C>
                            <C> id=ENO_NO       show=false      Edit=none</C>
                            <C> id=DPT_NM       width=90        align=center        name=�Ҽ�            Edit=none</C>
                            <C> id=JOB_NM       width=90        align=center        name=����            Edit=none</C>
                            <C> id=ENO_NM       width=90        align=center        name=����            Edit=none</C>
                            <C> id=PIS_MM_CNT   width=80        align=center        name=�ٹ�����        Edit=none</C>
                            <C> id=TMP_SUM_AMT  width=120       align=right         name=�ҵ��Ѿ�        Edit=none</C>
                            <C> id=CET_NO       width=140       align=center        name=���ο��ݹ�ȣ    Edit=none</C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                    <div style="visibility:hidden; position:absolute; display:none;">
                    <object id="grdT_CP_PAYMASTER_CP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
                        <param name="DataID" value="dsT_CP_PAYMASTER">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{currow}"   width=50        align=center        name="NO"            Edit=none   SubBgColor="#99FFCC"</C>
                            <C> id=ENO_NO       width=90        align=center        name=���            Edit=none</C>
                            <C> id=DPT_NM       width=90        align=center        name=�Ҽ�            Edit=none</C>
                            <C> id=JOB_NM       width=90        align=center        name=����            Edit=none</C>
                            <C> id=ENO_NM       width=90        align=center        name=����            Edit=none</C>
                            <C> id=PIS_MM_CNT   width=80        align=center        name=�ٹ�����        Edit=none</C>
                            <C> id=TMP_SUM_AMT  width=120       align=right         name=�ҵ��Ѿ�        Edit=none</C>
                            <C> id=CET_NO       width=140       align=center        name=���ο��ݹ�ȣ    Edit=none</C>
                        '>
                    </object>
                    </div>
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

