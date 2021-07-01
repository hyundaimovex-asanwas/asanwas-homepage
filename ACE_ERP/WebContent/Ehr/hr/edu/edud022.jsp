<!--
    ************************************************************************************
    * @Source         : edud022.jsp                                                    *
    * @Description    : ������ϱ� ���� PAGE                                           *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/14  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>

    <head>
    <title>������ϱ� ����(edud022)</title>
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

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;

        var gbn     = '';
        var title   = '';
        var bbs_gbn = '';
        var seq_no  = '';
        var ref_no  = '';
        var step_no = '';
        var dept_no = '';
        var eno_no  = '';
        var eno_no  = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var BBS_GBN = document.getElementById('txtBBS_GBN').value;
            var SEQ_NO  = document.getElementById('txtSEQ_NO').value;

            dsT_ED_BOARD.ClearData();

            dsT_ED_BOARD.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.d.edud022.cmd.EDUD022CMD&S_MODE=SHR&BBS_GBN="+BBS_GBN+"&SEQ_NO="+SEQ_NO;
            dsT_ED_BOARD.Reset();

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

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_ED_BOARD.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            //����� �޷� ������ ���� ���ϰ� ����
            if(dsT_ED_BOARD.NameValue(1, "IS_RE") != "0") {
                alert("�Խõ� �ۿ� ����� �޷� �ֽ��ϴ�.\n�����Ͻ� �� �����ϴ�.");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����[" + dsT_ED_BOARD.NameValue(1,"SUBJECT_TAG") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ED_BOARD.DeleteRow(dsT_ED_BOARD.RowPosition);

            trT_ED_BOARD.action = "/servlet/GauceChannelSVL?cmd=hr.edu.d.edud022.cmd.EDUD022CMD&S_MODE=DEL";
            trT_ED_BOARD.post();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //document.getElementById("txtENO_NO").innerText = opener.eno_no;
            document.getElementById('txtENO_NM').innerText = opener.eno_nm;
            document.getElementById('txtBBS_GBN').value = opener.bbs_gbn;
            document.getElementById('txtSEQ_NO').value  = opener.seq_no;
            document.getElementById('txtREF_NO').value  = opener.ref_no;
            document.getElementById('txtSTEP_NO').value = opener.step_no;
            document.getElementById('txtDEPT_NO').value = opener.dept_no;


            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_BOARD.IsUpdated)
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

        /************************************
         * ������ư Ŭ���� ����ȭ�� ȣ��    *
         ************************************/
        function fnc_Modify() {

            var obj = new String();

            gbn     = "2";                // 1: ���, 2: ����, 3: �亯
            title   = "����";
            bbs_gbn = opener.bbs_gbn;
            seq_no  = opener.seq_no;
            ref_no  = opener.ref_no;
            step_no = opener.step_no;
            dept_no = opener.dept_no;
            eno_no  = opener.eno_no;
            eno_no  = opener.eno_nm;

            window.showModalDialog("/hr/edu/edud021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            opener.fnc_SearchList();

        }

        /************************************
         * �亯��ư Ŭ���� �亯ȭ�� ȣ��    *
         ************************************/
        function fnc_Reply() {

            var obj = new String();

            gbn     = "3";                // 1: ���, 2: ����, 3: �亯
            title   = "�亯";
            bbs_gbn = opener.bbs_gbn;
            seq_no  = opener.seq_no;
            ref_no  = opener.ref_no;
            step_no = opener.step_no;
            dept_no = opener.dept_no;
            eno_no  = opener.eno_no;
            eno_no  = opener.eno_nm;

            window.showModalDialog("/hr/edu/edud021.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

            opener.fnc_SearchList();

            window.close();
        }

        function fnc_link(val1, val2) {

            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            //alert(val1+",     "+val2);
            cfDownload(val1, val2);

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID="dsT_ED_BOARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_BOARD)     |
    | 3. ���Ǵ� Table List(T_ED_BOARD)            |
    +----------------------------------------------->
    <Object ID ="trT_ED_BOARD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_BOARD)">
    </Object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_BOARD Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            // ��ư�� ������ ����.
            document.getElementById("view_1").style.display='none';
            document.getElementById("view_2").style.display='none';

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_BOARD.CountRow );

            //document.getElementById("txtENO_NO").innerText      = 'hlc'+dsT_ED_BOARD.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_BOARD.NameValue(1, "ENO_NM");
            document.getElementById("txtSUBJECT_TAG").innerText = dsT_ED_BOARD.NameValue(1, "SUBJECT_TAG");
            document.getElementById("txtCONTENT_TXT").innerText = dsT_ED_BOARD.NameValue(1, "CONTENT_TXT");
            document.getElementById("txtUPT_YMD").innerText     = dsT_ED_BOARD.NameValue(1, "UPT_YMD");

            document.getElementById("txtSRCFILE1_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE1_NM");
            document.getElementById("txtTGTFILE1_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE1_NM");
            document.getElementById("txtSRCFILE2_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE2_NM");
            document.getElementById("txtTGTFILE2_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE2_NM");
            document.getElementById("txtSRCFILE3_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE3_NM");
            document.getElementById("txtTGTFILE3_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE3_NM");
            document.getElementById("txtSRCFILE4_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE4_NM");
            document.getElementById("txtTGTFILE4_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE4_NM");
            document.getElementById("txtSRCFILE5_NM").innerText = dsT_ED_BOARD.NameValue(1, "SRCFILE5_NM");
            document.getElementById("txtTGTFILE5_NM").innerText = dsT_ED_BOARD.NameValue(1, "TGTFILE5_NM");

            // ���� �� ���������� ������� ��츸 �ش�
            if (dsT_ED_BOARD.NameValue(1, "ENO_NO") == '<%=box.get("SESSION_ENONO")%>') {
                // ��ư�� ����
                document.getElementById("view_1").style.display='inline';
                document.getElementById("view_2").style.display='inline';
            }
            else {
                // ��ư�� ������ ����
                document.getElementById("view_1").style.display='none';
                document.getElementById("view_2").style.display='none';
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_BOARD Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-- Ʈ������ ����. -->
    <script for=trT_ED_BOARD event="OnSuccess()">

        alert("�ش� �����Ͱ� �����Ǿ����ϴ�.");

        opener.fnc_SearchList();

        window.close();

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_BOARD event="OnFail()">

        cfErrorMsg(this);

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ϱ� ����</td>
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
            <div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAdjust','','/images/button/btn_AdjustOver.gif',1)">    <img src="/images/button/btn_AdjustOn.gif"   name="imgAdjust"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Modify()"></a>
            </div>
            <div id="view_2" style="border-style:solid;border-color:#999999;border-width:0;display:inline">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)" onClick="fnc_Delete();"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReply','','/images/button/btn_ReplyOver.gif',1)">    <img src="/images/button/btn_ReplyOn.gif"   name="imgReply"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Reply()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="300"></col>
                    <col width="100"></col>
                    <col width="300"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� �� ��</td>
                    <td class="padding2423" >
                        <span id="txtENO_NM" name="txtENO_NM" ></span>
                    </td>
                    <td align="center" class="creamBold">����Ͻ�</td>
                    <td class="padding2423" >
                        <span id="txtUPT_YMD" name="txtUPT_YMD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">÷������</td>
                    <td class="padding2423" colspan="3">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE1_NM').innerText, document.getElementById('txtTGTFILE1_NM').value);"><span id="txtSRCFILE1_NM"  name="txtSRCFILE1_NM"></span></a>
                            <input type=hidden id="txtTGTFILE1_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE2_NM').innerText, document.getElementById('txtTGTFILE2_NM').value);"><span id="txtSRCFILE2_NM"  name="txtSRCFILE2_NM"></span></a>
                            <input type=hidden id="txtTGTFILE2_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE3_NM').innerText, document.getElementById('txtTGTFILE3_NM').value);"><span id="txtSRCFILE3_NM"  name="txtSRCFILE3_NM"></span></a>
                            <input type=hidden id="txtTGTFILE3_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE4_NM').innerText, document.getElementById('txtTGTFILE4_NM').value);"><span id="txtSRCFILE4_NM"  name="txtSRCFILE4_NM"></span></a>
                            <input type=hidden id="txtTGTFILE4_NM">
                        <a href=# onClick="fnc_link(document.getElementById('txtSRCFILE5_NM').innerText, document.getElementById('txtTGTFILE5_NM').value);"><span id="txtSRCFILE5_NM"  name="txtSRCFILE5_NM"></span></a>
                            <input type=hidden id="txtTGTFILE5_NM">
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtSUBJECT_TAG"  name="txtSUBJECT_TAG"></span>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" colspan="4" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="130" rows="26" readonly></textarea>
                    </td>
                </tr>
                <input type=hidden id="txtBBS_GBN">
                <input type=hidden id="txtSEQ_NO">
                <input type=hidden id="txtREF_NO">
                <input type=hidden id="txtSTEP_NO">
                <input type=hidden id="txtDEPT_NO">
            </table>
        </td>
    </tr>
</table>

<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

</form>
<!-- form �� -->

</body>
</html>