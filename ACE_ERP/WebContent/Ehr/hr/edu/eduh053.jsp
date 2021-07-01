<!--
    ************************************************************************************
    * @Source         : eduh053.jsp                                                    *
    * @Description    : �������_������Ȳ���� PAGE                                 *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/03/07  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<html>

    <head>
    <title>�������_������Ȳ����(eduh053)</title>
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

        var btnList = 'TTFTFFFT';

        var opener = window.dialogArguments;
        var flag   = '';                       // 0: ��ȸ, 1: ����

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var JOB_CD  = document.getElementById("txtJOB_CD_SHR").value;


            dsT_CM_EDUCATION.ClearData();
            dsT_ED_CHASULIST.ClearData();

            trT_CM_EDUCATION_SHR.KeyValue = "SVL(O:SHR=dsT_ED_CHASULIST, O:SHR2=dsT_CM_EDUCATION)";
            trT_CM_EDUCATION_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD"
                                        + "&S_MODE=SHR"
                                        + "&EDU_CD="+opener.edu_cd
                                        + "&SEQ_NO="+opener.seq_no
                                        + "&ENO_NO="+ENO_NO
                                        + "&DPT_CD="+DPT_CD
                                        + "&JOB_CD="+JOB_CD
                                        + "&COMM_NO="+opener.comm_no;
            trT_CM_EDUCATION_SHR.post();

            form1.grdT_CM_EDUCATION.Focus();

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
                dsT_CM_EDUCATION.UseChangeInfo = false;

                trT_CM_EDUCATION.KeyValue = "SVL(I:dsT_CM_EDUCATION=dsT_CM_EDUCATION)";
                trT_CM_EDUCATION.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD&S_MODE=SAV"+"&COMM_NO="+opener.comm_no;
                trT_CM_EDUCATION.post();

                dsT_CM_EDUCATION.UseChangeInfo = true;

            } else {

                return;
            }
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

            if (dsT_CM_EDUCATION.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_EDUCATION.GridToExcel("������Ȳ����", '', 225);

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
            if (dsT_CM_EDUCATION.IsUpdated) {
                if (!fnc_ClearQuestion()) return;
            }

            document.getElementById("txtEDU_CD").value      = "";
            document.getElementById("txtEDU_NM").value      = "";
            document.getElementById("txtSEQ_NO").value   = "";
            document.getElementById("txtPLACE_NM").value    = "";
            document.getElementById("txtEDU_STR_YMD").value = "";
            document.getElementById("txtEDU_END_YMD").value = "";
            document.getElementById("txtINT_NAM").value     = "";
            form1.medCOST_AMT.text                          = "";
            document.getElementById("txtFIX_NO").value      = "";
            document.getElementById("txtINS_NM").value      = "";
            form1.medSUM_AMT.text                           = "";
            document.getElementById("txtCONTENT_TXT").value = "";

            dsT_CM_EDUCATION.ClearData();
            dsT_ED_CHASULIST.ClearData();

            document.getElementById("txtENO_NO_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("txtJOB_CD_SHR").value = "";
            document.getElementById("txtJOB_NM_SHR").value = "";

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

   /*         if (!dsT_CM_EDUCATION.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }
   */

            if ( dsT_CM_EDUCATION.isUpdated) {
                for( i = 1; i <= dsT_CM_EDUCATION.CountRow; i++ ) {
                    if( dsT_CM_EDUCATION.RowStatus(i) == 1 ||
                        dsT_CM_EDUCATION.RowStatus(i) == 3 ) {

                        // ����
                        /*
                        if( dsT_CM_EDUCATION.NameValue(i, "APP_VAL") == ''  && dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == 'Y') {
                            alert("������ �ʼ� �Է»����Դϴ�.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("APP_VAL");
                            return false;
                        }
                        */

                        // ���Ῡ��
                        if( dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == '' ) {
                            alert("���Ῡ�δ� �ʼ� �Է»����Դϴ�.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("EDU_TAG");
                            return false;
                        }

                        // �̼������
                        /*
                        if( dsT_CM_EDUCATION.NameValue(i, "EDU_TAG") == 'N' && dsT_CM_EDUCATION.NameValue(i, "REASON_TAG") == '' ) {
                            alert("���Ῡ�ΰ� �̼����̸� �̼�������� �ʼ��Է��׸��Դϴ�.");
                            dsT_CM_EDUCATION.RowPosition = i;
                            form1.grdT_CM_EDUCATION.setColumn("REASON_TAG");
                            return false;
                        }
                        */

                        if (dsT_CM_EDUCATION.NameValue(i, 'EDU_TAG') == 'Y') {
                            dsT_CM_EDUCATION.NameValue(i, 'REASON_TAG') = '';
                        }
                    }
                }
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style ����
            cfStyleGrid(form1.grdT_CM_EDUCATION,0,"true","false");

            form1.grdT_CM_EDUCATION.DragDropEnable  = "false";


            fnc_SearchList();

        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_CM_EDUCATION.IsUpdated)
            {
                if (!fnc_ExitQuestion()) return;
            }

            window.close();

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

        /**
         * EXCEL ���� ���ε�
         */
        function fnc_FileUpload() {
            var ENO_NO  = document.getElementById("txtENO_NO_SHR").value;
            var DPT_CD  = document.getElementById("txtDPT_CD_SHR").value;
            var JOB_CD  = document.getElementById("txtJOB_CD_SHR").value;

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
                dsT_CM_EDUCATION.ClearData();

                trFILE_UPLOAD.KeyValue  = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_CM_EDUCATION=dsT_CM_EDUCATION, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action    = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh053.cmd.EDUH053CMD"
                                        + "&S_MODE=ULD"
                                        + "&EDU_CD="+opener.edu_cd
                                        + "&SEQ_NO="+opener.seq_no
                                        + "&COMM_NO="+opener.comm_no
                                        + "&ENO_NO="+ENO_NO
                                        + "&DPT_CD="+DPT_CD
                                        + "&JOB_CD="+JOB_CD;
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

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EDUCATION) |
    | 3. ���Ǵ� Table List(T_CM_EDUCATION)        |
    +----------------------------------------------->
    <Object ID="dsT_CM_EDUCATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_COURSELIST)|
    | 3. ���Ǵ� Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_CHASULIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ��� DS -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EDUCATION                    |
    | 3. Table List : T_ED_CHASULIST                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_CM_EDUCATION_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!-------------------------------------------------+
    | ���Ῡ�� �� ����� �̼������ �� SET             |
    +-------------------------------------------------->
    <script language=JavaScript for=dsT_CM_EDUCATION event=onColumnChanged(row,colid)>

        if (colid == 'EDU_TAG') {

            dsT_CM_EDUCATION.NameValue(row, 'REASON_TAG') = '';

        }

    </script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_EDUCATION Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_EDUCATION.CountRow );

        }

    </Script>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EDUCATION Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_CHASULIST Event="OnLoadCompleted(iCount)">
        if (iCount > 0) {
            document.getElementById("txtEDU_CD").value      = dsT_ED_CHASULIST.NameValue(1, "EDU_CD");
            document.getElementById("txtEDU_NM").value      = dsT_ED_CHASULIST.NameValue(1, "EDU_NM");
            document.getElementById("txtSEQ_NO").value      = dsT_ED_CHASULIST.NameValue(1, "SEQ_NO");
            document.getElementById("txtPLACE_NM").value    = dsT_ED_CHASULIST.NameValue(1, "PLACE_NM");
            document.getElementById("txtEDU_STR_YMD").value = dsT_ED_CHASULIST.NameValue(1, "EDU_STR_YMD");
            document.getElementById("txtEDU_END_YMD").value = dsT_ED_CHASULIST.NameValue(1, "EDU_END_YMD");
            document.getElementById("txtINT_NAM").value     = dsT_ED_CHASULIST.NameValue(1, "INT_NAM");
            form1.medCOST_AMT.text                          = dsT_ED_CHASULIST.NameValue(1, "COST_AMT");
            document.getElementById("txtFIX_NO").value      = dsT_ED_CHASULIST.NameValue(1, "FIX_NO");
            document.getElementById("txtINS_NM").value      = dsT_ED_CHASULIST.NameValue(1, "INS_NM");
            form1.medSUM_AMT.text                           = dsT_ED_CHASULIST.NameValue(1, "SUM_AMT");
            document.getElementById("txtCONTENT_TXT").value = dsT_ED_CHASULIST.NameValue(1, "CONTENT_TXT");
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_CHASULIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_EDUCATION event="OnSuccess()">

        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_EDUCATION event="OnFail()">

        cfErrorMsg(this);

    </script>


    <!-------------------------+
    | Grid �� CheckBox Ŭ����  |
    +-------------------------->
	<script language="javascript"  for=grdT_CM_EDUCATION event=OnClick(row,colid)>

		if(colid == 'CONFIRM' && row != '0'){
            if(!(dsT_CM_EDUCATION.NameValue(row,colid) == "T" && dsT_CM_EDUCATION.RowStatus(row) == "1")) {
    			if(dsT_CM_EDUCATION.NameValue(row,colid) == "T") {
    				dsT_CM_EDUCATION.NameValue(row,'EDU_TAG') = 'Y';
    	    	} else if(dsT_CM_EDUCATION.NameValue(row,colid) == "F") {
    				dsT_CM_EDUCATION.NameValue(row,'EDU_TAG') = 'N';
    	    	}
            }
    	}
	</script>

    <!-----------------------------------------------------+
    | Grid Head Check event ó��                           |
    +------------------------------------------------------>
    <script language="javascript" for=grdT_CM_EDUCATION event=OnHeadCheckClick(Col,Colid,bCheck)>

        var bCheckValue = "";
        if(bCheck == 1){
            bCheckValue = "T";
        }else{
            bCheckValue = "F";
        }

        for(var i=1; i<=dsT_CM_EDUCATION.CountRow; i++) {
            if(!(dsT_CM_EDUCATION.NameValue(i, "CONFIRM") == "T"
                    && dsT_CM_EDUCATION.RowStatus(i) == "1")) {

                dsT_CM_EDUCATION.NameValue(i, "CONFIRM") = bCheckValue;

                if(dsT_CM_EDUCATION.NameValue(i, "CONFIRM") == "T") {
                    dsT_CM_EDUCATION.NameValue(i,'EDU_TAG') = 'Y';
                } else if(dsT_CM_EDUCATION.NameValue(i,"CONFIRM") == "F") {
                    dsT_CM_EDUCATION.NameValue(i,'EDU_TAG') = 'N';
                }

                    dsT_CM_EDUCATION.NameValue(i, "CONFIRM") = bCheckValue;
            }
        }

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������_������Ȳ����</td>
                    <td align="right" class="navigator"></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="ImgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)">  <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel();"></a>
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
                                <col width="80"></col>
                                <col width="180"></col>
                                <col width="80"></col>
                                <col width="140"></col>
                                <col width="80"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
                                </td>
                                <td class="searchState" align="right">�ҼӺ�&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtDPT_CD_SHR" size="3" maxlength="2"> <input id="txtDPT_NM_SHR" size="10" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')"></a>
                                </td>
                                <td class="searchState" align="right">������&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <input id="txtJOB_CD_SHR" size="3" maxlength="2"> <input id="txtJOB_NM_SHR" size="10" class="input_ReadOnly"  readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgJobCd" name="ImgJobCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
                                </td>
                            </tr>
                            <input type=hidden id="txtCHK" name="txtCHK">
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
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    <td width="80" style="padding-right:5px; padding-top:1px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('eduh053.xls', '<%=FILEURL %>/eduh053.xls');"></a>
                    </td>
                    <td width="80" align="right" style="padding-right:5px; padding-bottom:1px;">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<!-- ��ȸ ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <col width="80 "></col>
                    <col width="188"></col>
                    <col width="80 "></col>
                    <col width="186"></col>
                    <col width="80 "></col>
                    <col width="186"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold" >��������</td>
                    <td class="padding2423" align="left">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="5"  class="input_ReadOnly" readonly> <input id="txtEDU_NM" name="txtEDU_NM" size="21" class="input_ReadOnly"  readOnly>
                        <input type=hidden id="hidCOMM_NO">
                    </td>
                    <td align="center" class="creamBold" >��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <input id="txtSEQ_NO" name="txtSEQ_NO" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_NM" name="txtPLACE_NM" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtINT_NAM" name="txtINT_NAM" maxlength="60" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="60" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <input id="txtINS_NM" name="txtINS_NM" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=false>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="115" rows="5" maxlength="300" readonly></textarea>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object  id="grdT_CM_EDUCATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
                            <param name="DataID"                  value="dsT_CM_EDUCATION">
                            <param name="EdiTABLE"                value="true">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=40    name='����'           align=center Edit='None' </C>
                                <C> id='ENO_NO'       width=70    name='���'           align=center Edit='None' </C>
                                <C> id='ENO_NM'       width=65    name='����'           align=center Edit='None' </C>
                                <C> id='DPT_NM'       width=90    name='�Ҽ�'           align=left   Edit='None' </C>
                                <C> id='JOB_NM'       width=50    name='����'           align=center Edit='None' </C>
                                <C> id='CET_NO'       width=100   name='�ֹι�ȣ'       align=center Edit='None' </C>
                                <C> id='APP_VAL'      width=60    name='����'           align=center   </C>
                                <C> id='CONFIRM'      width=50    name='����;Ȯ��'      align=center HeadCheckShow=true EditStyle=CheckBox Pointer=Hand </C>
                                <C> id='EDU_TAG'      width=70    name='���Ῡ��'       align=center Value={DECODE(EDU_TAG,'Y','����','�̼���')}  </C>
                                <C> id='REASON_TAG'   width=180   name='�̼������'     align=left   </C>
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