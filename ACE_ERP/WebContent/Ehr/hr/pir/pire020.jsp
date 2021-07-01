<!--
***********************************************************************
* @source      : pire020.jsp
* @description : ��ȸ����Ȱ����Ȳ PAGE
***********************************************************************
*----------------------------------------------------------------------
* 2008/03/04      �����        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
<title>��ȸ����Ȱ����Ȳ(pire020)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var str_ymd  = document.getElementById('txtSTR_YMD_SHR').value;
            var end_ymd  = document.getElementById('txtEND_YMD_SHR').value;
            var eno_no   = document.getElementById('txtENO_NO_SHR').value;
            var dpt_cd   = document.getElementById('txtDPT_CD_SHR').value;
            var head_cd  = document.getElementById('txtHEAD_CD_SHR').value;

            dpt_cd  = (dpt_cd == "")  ? "%" : dpt_cd;
            head_cd = (head_cd == "") ? "%" : head_cd;
            eno_no  = (eno_no == "")  ? "%" : eno_no;

            if(!fnc_SearchItemCheck()) return;

            dsT_CM_SERVICE.dataid = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire020.cmd.PIRE020CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&ENO_NO="+eno_no+"&DPT_CD="+dpt_cd+"&HEAD_CD="+head_cd;

            dsT_CM_SERVICE.reset();



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

            if(fnc_SaveItemCheck()) {
                trT_CM_SERVICE.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=SAV";
                trT_CM_SERVICE.post();
            } else {

                return;

            }

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {


            var status = 0;

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_CM_SERVICE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            status = dsT_CM_SERVICE.RowStatus(dsT_CM_SERVICE.RowPosition);

            //DataSet�� ���� ���� Ȯ��
            if (dsT_CM_SERVICE.IsUpdated && status != 1) {
                alert("ȭ�鿡 ��������� �����մϴ�.\n���� ȭ�� ������ �����Ͻ� ���� �۾��Ͽ� �ֽʽÿ�.");
                return false;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����[" + dsT_CM_SERVICE.NameValue(dsT_CM_SERVICE.RowPosition,"STR_YMD") + "] ��系��[" + dsT_CM_SERVICE.NameValue(dsT_CM_SERVICE.RowPosition,"ATT_SBJ") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_CM_SERVICE.DeleteRow(dsT_CM_SERVICE.RowPosition);

            if (status != 1) {
                trT_CM_SERVICE.action = "/servlet/GauceChannelSVL?cmd=hr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=DEL";
                trT_CM_SERVICE.post();
            }

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

           if (dsT_CM_SERVICE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_SERVICE.GridToExcel("��ȸ����Ȱ����Ȳ", '', 225);

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

            //document.getElementById('txtSTR_YMD_SHR').value = '';
            //document.getElementById('txtEND_YMD_SHR').value = '';
            document.getElementById('txtDPT_CD_SHR').value = '';
            document.getElementById('txtDPT_NM_SHR').value = '';
            document.getElementById('txtHEAD_CD_SHR').value = '';
            document.getElementById('txtHEAD_NM_SHR').value = '';
            document.getElementById('txtENO_NO_SHR').value = '';
            document.getElementById('txtENO_NM_SHR').value = '';
            document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_SERVICE.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            frame = window.external.GetFrame(window);

            frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var str_ymd = document.getElementById('txtSTR_YMD_SHR');
            var end_ymd = document.getElementById('txtEND_YMD_SHR');

            if(str_ymd.value=="" && end_ymd.value==""){
                alert("�Ⱓ�� �Է��ϼ���!");
                str_ymd.focus();
                return false;
            }
            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

             return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid(form1.grdT_CM_SERVICE,15,"true","false");      // Grid Style ����

            //��¥���� ���ε�
            var svc_ymd     = getToday();

            svc_ymd     = addDate("M", getToday(), -12);
            document.getElementById("txtSTR_YMD_SHR").value = svc_ymd; // �ش��� From
            svc_ymd     = addDate("M", getToday(), 1);
            document.getElementById("txtEND_YMD_SHR").value = svc_ymd; // �ش��� To

            document.getElementById('txtSTR_YMD_SHR').focus();


        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }

        /*****************************
         * 17. �������� ���ε� ó��  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);


			// �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn < 1) {
	            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_CM_SERVICE=dsT_CM_SERVICE, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "/servlet/GauceChannelSVL?cmd=hr.pir.e.pire020.cmd.PIRE020CMD&S_MODE=ULD";
                trFILE_UPLOAD.post();

            }

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet                                 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_SERVICE)|
    | 3. ���Ǵ� Table List(T_CM_ACCESSLOG)         |
    +------------------------------------------------>
    <Object ID="dsT_CM_SERVICE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=200000>
    </Object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>
   <!----------------------------------------------+
    | 1. �ڷ� ���ε�� Data Transacton              |
    | 2. �̸� : trFILE_UPLOAD_06                    |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>
    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_SERVICE                      |
    | 3. Table List : T_CM_SERVICE                  |
    +----------------------------------------------->
    <Object ID ="trT_CM_SERVICE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:SAV=dsT_CM_SERVICE)">
    </Object>
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_SERVICE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_SERVICE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_SERVICE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>
    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_SERVICE event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_SERVICE event="OnFail()">

        cfErrorMsg(this);

    </script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trFILE_UPLOAD event="OnSuccess()">
        for(var i=1; i<=dsT_CM_SERVICE.CountRow; i++) {
            dsT_CM_SERVICE.UserStatus(i) = "1";
        }
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-------------------------------------------------+
    | �׸��带�� ����Ŭ��     ó�� �� ����             |
    +-------------------------------------------------->
    <Script For=grdT_CM_SERVICE Event="OnDblClick(row, col)">

         // alert(dsT_CM_SERVICE.NameString(row, "STR_YMD"));

    </Script>
<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ȸ����Ȱ����Ȳ</td>
                    <td align="right" class="navigator">HOME/�λ����/�λ���Ȳ������/<font color="#000000">��ȸ����Ȱ����Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">   <img src="/images/button/btn_SaveOn.gif"    name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                    <col width="35"></col>
                                    <col width="215"></col>
                                    <col width="35"></col>
                                    <col width="140"></col>
                                    <col width="35"></col>
                                    <col width="130"></col>
                                    <col width="35"></col>
                                    <col width="*"></col>
                                </colgroup>
                            <tr>
                                <td align="right" class="searchState">�Ⱓ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtSTR_YMD_SHR" size="10" maxlength="10"  style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','10','115');"></a> ~
                                    <input id="txtEND_YMD_SHR" size="10" maxlength="10"  style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','115');"></a>
                                </td>
                                <td align="right" class="searchState">����&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtHEAD_CD_SHR name=txtHEAD_CD_SHR size="2" maxlength="2" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR')">
                                    <input id=txtHEAD_NM_SHR name=txtHEAD_NM_SHR size="10" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtHEAD_CD_SHR','txtHEAD_NM_SHR','����','HEAD')"></a>
                                </td>
                                <td align="right" class="searchState">�μ�&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtDPT_CD_SHR name=txtDPT_CD_SHR size="2" maxlength="2" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
                                    <input id=txtDPT_NM_SHR name=txtDPT_NM_SHR size="10" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                </td>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtENO_NO_SHR size="6" maxlength="6" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input name=txtENO_NM_SHR size="6" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
                    <td width="80" style="padding-right:5px; padding-top:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('pire020.xls', '<%=FILEURL %>/pire020.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
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
                        <object id="grdT_CM_SERVICE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
                            <param name="DataID"                    value="dsT_CM_SERVICE">
                            <param name="Format"                    value='
                                <C> id={currow}      width=30   name="No"       align=center value={String(Currow)} </C>
                                <C> id="DPT_NM"      width=90	name="�� ��"    align=center  suppress=1</C>
                                <C> id="JOB_NM"      width=60   name="�� ��"    align=center  suppress=2</C>
                                <C> id="ENO_NO"      width=65   name="�� ��"    align=center  suppress=3</C>
                                <C> id="ENO_NM"      width=75   name="�� ��"    align=center  suppress=4</C>
                                <C> id="STR_YMD"     width=75   name="�� ��"    align=center  </C>
                                <C> id="ATT_OFFICE"  width=120  name="�� ��"    align=center  </C>
                                <C> id="ATT_SBJ"     width=200  name="��系��" align=center  </C>
                                <C> id="ATT_HOUR"    width=50   name="�� ��"    align=center  </C>
                            '>
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </object>
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