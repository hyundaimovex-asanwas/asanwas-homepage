<!--*************************************************************************
* @source      : insb030.jsp                                                *
* @description : �ǰ����������ü PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/02/28            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�ǰ����������ü(insb030)</title>
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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ins.b.insb030.cmd.INSB030CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(!fnc_SearchItemCheck()) {
                return;
            }

            params = "&S_MODE=SHR"
                   + "&FIXED_DATE="+oFIXED_DATE.value;

            //���°��� ����
            dsFILE_UPLOAD.UserStatus(1) = "1";

            trT_CP_PAYMASTER.KeyValue = "insb030"
                                      + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"
                                      + ",O:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
            trT_CP_PAYMASTER.action   = dataClassName+params;
            trT_CP_PAYMASTER.post();
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
            if(!fnc_SaveItemCheck()) return;

            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");
            params = "&S_MODE=SAV"
                   + "&FIXED_DATE="+oFIXED_DATE.value;

            //���°��� ���� (��� insert ó��)
            dsT_CP_PAYMASTER.UseChangeInfo = false;

            trT_CP_PAYMASTER_SAV.KeyValue = "SAV(I:dsT_CP_PAYMASTER=dsT_CP_PAYMASTER)";
            trT_CP_PAYMASTER_SAV.action   = dataClassName+params;
            trT_CP_PAYMASTER_SAV.post();
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
            if(!fnc_SaveItemCheck()) return;
            form1.grdT_CP_PAYMASTER.GridToExcel("�ǰ����������ü", '', 225);
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
            dsFILE_UPLOAD.ClearData();

            document.getElementById("txtFILE_NAME").value       = "";
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
            //�˻�����
            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(oFIXED_DATE.value.trim() == "") {
                alert("�������� ������ �ּ���.");
                oFIXED_DATE.focus();
                return false;
            }
            if(dsFILE_UPLOAD.CountRow < 1) {
                alert("÷�������� ������ �ּ���.");
                return false;
            }
            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") == "") {
                alert("÷�������� ������ �ּ���.");
                return false;
            }

            return true;
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            if (dsT_CP_PAYMASTER.CountColumn == 0) {
                alert("����Ʈ�� ��ȸ���� �ʾҽ��ϴ�.");
                return false;
            }
            if (dsT_CP_PAYMASTER.CountRow < 1) {
                alert("������ ����Ÿ�� �����ϴ�.");
                return false;
            }

            return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_CP_PAYMASTER,0,"true","false");      // Grid Style ����

            // ���� ÷�ο� �����ͼ��� ��� ���� ����.
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");

            document.getElementById("txtFIXED_DATE_SHR").value  = (getTodayArray()[0]-1)+"-12-01";
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
         * ÷������ ó��
         */
        function fnc_FileUpload() {
            var txtFILE_NAME = document.getElementById("txtFILE_NAME");
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            txtFILE_NAME.value = fcFILE_UPLOAD.Value;
        }

        /**
         * ���Ϸ� ����
         */
        function fnc_ToFile() {
            var isFirst = true;
            var keys = "";
            var Noname = "";

            var oFIXED_DATE = document.getElementById("txtFIXED_DATE_SHR");

            if(!fnc_SearchItemCheck()) {
                return;
            }
            if(!fnc_SaveItemCheck()) {
                return;
            }
            //�˻��� ����Ʈ ��ŭ ���鼭 ���õ��� ���� key ���� ã�� �´�.
            for(i=1; i<=dsT_CP_PAYMASTER.CountRow; i++) {
                if(dsT_CP_PAYMASTER.NameString(i, "STATUS") == "0") {
                    if(isFirst) {
                     //   keys = i;
                        Noname = "'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                        isFirst = false;
                    } else {
                     //   keys += ","+i;
                        Noname += ","+"'"+dsT_CP_PAYMASTER.NameString(i, "ENO_NO")+"'";
                    }
                }
            }

            params = "&S_MODE=FILE"
                   + "&FILE_NAME=����UandI(�ǰ�����).txt"
                   + "&FIXED_DATE="+oFIXED_DATE.value
                   + "&KEYS="+keys
                   + "&NONAME="+Noname;

            var form = document.form1;
            form.method = "post";
            form.target = "file_down";
            form.action = "/servlet/JspChannelSVL?cmd=hr.ins.b.insb030.cmd.INSB030CMD_FILE"+params;
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

    <!-- ����� -->
    <Object ID="trT_CP_PAYMASTER_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>


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

    <script for=trT_CP_PAYMASTER_SAV event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_PAYMASTER event="OnFail()">
        alert(trT_CP_PAYMASTER.ErrorMsg);
    </script>

    <script for=trT_CP_PAYMASTER_SAV event="OnFail()">
        alert(trT_CP_PAYMASTER_SAV.ErrorMsg);
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ǰ����������ü</td>
                    <td align="right" class="navigator">HOME/�����Ļ�/�ǰ�����/<font color="#000000">�ǰ����������ü</font></td>
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
           <!--      <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>   -->
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
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">������</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtFIXED_DATE_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIXED_DATE_SHR','','94','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    <td class="searchState" align="right">���ϰ��</td>
                    <td class="padding2423" align="left">
                        <input id=txtFILE_NAME name=txtFILE_NAME size="58" valid='maxlength=255' readonly>&nbsp;
                        <a  href="#"
                            onMouseOut="MM_swapImgRestore()"
                            onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',3)"
                        ><img
                            src="/images/button/FileAddOn.gif"
                            id="btnUPLOAD"
                            name="btnUPLOAD"
                            width="80"
                            height="20"
                            border="0"
                            align="absmiddle"
                            onClick="fnc_FileUpload()"
                        ></a>
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
                            <C> id=STATUS       width=60        align=center        name=����               EditStyle=CheckBox  CheckBoxText=NUM    Pointer=Hand</C>
                            <C> id=PLA_NO       width=80        align=center        name=������ȣ             Edit=none</C>
                            <C> id=DIS_NO       width=60        align=center        name=����                   Edit=none</C>
                            <C> id=ACCOUNT      width=60        align=center        name=ȸ��                   Edit=none</C>
                            <C> id=PLA_NM       width=80        align=center        name=���������             Edit=none</C>
                            <C> id=HIU_NO       width=80        align=center        name=����ȣ                 Edit=none</C>
                            <C> id=ENO_NM       width=80        align=center        name=����                   Edit=none</C>
                            <C> id=CET_NO       width=140       align=center        name=�ֹε�Ϲ�ȣ           Edit=none</C>
                            <C> id=HIRG_YMD     width=80        align=center        name=�ڰ������             Edit=none</C>
                         <G> name="���⵵����ᳳ�ο���"  HeadBgColor=#F7DCBB
                            <C> id=PST_MM       width=80        align=center        name=�ǰ�����               Edit=none</C>
                            <C> id=PST_OLD_MM   width=80        align=center        name=�����               Edit=none</C>
                         </G>
                         <G> name="���⵵����ᳳ���Ѿ�"  HeadBgColor=#F7DCBB
                            <C> id=PST_TOT_AMT  width=80        align=right         name=�հ�                   Edit=none RightMargin="10"</C>
                            <C> id=PST_AMT      width=80        align=right         name=�ǰ�����               Edit=none RightMargin="10"</C>
                            <C> id=PST_OLD_AMT  width=80        align=right         name=�����               Edit=none RightMargin="10"</C>
                         </G>
                            <C> id=TMP_SUM_AMT  width=120       align=right         name=���⵵�����Ѿ�         Edit=none RightMargin="10"</C>
                            <C> id=PIS_MM_CNT   width=80        align=center        name=�ٹ�����               Edit=none</C>
                        '>
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

