<!--
    ************************************************************************************
    * @Source         : eduh060.jsp                                                    *
    * @Description    : �系����������� PAGE                                          *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/28  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�系�����������(eduh060)</title>
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

        var gbn     = '';
        var cet_no  = '';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            var LCT_CD     = document.getElementById("cmbLCT_CD_SHR").value;
            var LCT_Q5_GBN = document.getElementById("cmbLCT_Q5_GBN_SHR").value;
            var ENO_NM     = document.getElementById("txtENO_NM_SHR").value;

            dsT_ED_LCTRLIST.ClearData();

            dsT_ED_LCTRLIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh060.cmd.EDUH060CMD&S_MODE=SHR&LCT_CD="+LCT_CD+"&LCT_Q5_GBN="+LCT_Q5_GBN+"&ENO_NM="+ENO_NM;
            dsT_ED_LCTRLIST.Reset();

            form1.grdT_ED_LCTRLIST.Focus();

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
            if (dsT_ED_LCTRLIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.
            if (confirm("����� [" + dsT_ED_LCTRLIST.NameValue(dsT_ED_LCTRLIST.RowPosition,"ENO_NM") + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_ED_LCTRLIST.DeleteRow(dsT_ED_LCTRLIST.RowPosition);

            trT_ED_LCTRLIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh060.cmd.EDUH060CMD&S_MODE=DEL";
            trT_ED_LCTRLIST.post();


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

            if (dsT_ED_LCTRLIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ED_LCTRLIST.GridToExcel("�系�������", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            gbn     = "1";        // 1: �ű�, 2: ����
            cet_no  = '';

            window.showModalDialog("/hr/edu/eduh061.jsp", self, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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

            document.getElementById("cmbLCT_CD_SHR").value = "";
            document.getElementById("cmbLCT_Q5_GBN_SHR").value = "";
            document.getElementById("txtENO_NM_SHR").value   = "";

            document.getElementById("resultMessage").innerText = ' ';

            document.getElementById("cmbLCT_CD_SHR").focus();

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
            cfStyleGrid(form1.grdT_ED_LCTRLIST,0,"false","false");

            //���籸��
            for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_CD_SHR").add(oOption);

            }

            //���Ǻо�
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbLCT_Q5_GBN_SHR").add(oOption);

            }

            document.getElementById("cmbLCT_CD_SHR").focus();

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



    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_LCTRLIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_LCTRLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_LCTRLIST)|
    | 3. ���Ǵ� Table List(T_ED_LCTRLIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_LCTRLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_LCTRLIST)">
    </Object>

    <!-- ���籸�� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q9"/>
       <jsp:param name="CODE_GUBUN"    value="Q9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- ���Ǻо� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_LCTRLIST Event="OnDblClick(row, col)">

        // ������� Ŭ����
        if (col == 'FUNC') {
            gbn    = '';
            cet_no = dsT_ED_LCTRLIST.NameValue(row, "CET_NO");

            window.showModalDialog("/hr/edu/eduh062.jsp", self, "dialogHeight:600px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        }
        else {
            gbn     = "2";        // 1: �ű�, 2: ����
            cet_no = dsT_ED_LCTRLIST.NameValue(row, "CET_NO");

            window.showModalDialog("/hr/edu/eduh061.jsp", self, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_LCTRLIST Event="OnLoadCompleted(iCount)">
        var  LCT_Q5_NM = '';

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_LCTRLIST.CountRow );

            for (var i = 1; i <= iCount; i++) {
                dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_NM") = dsT_ED_LCTRLIST.NameValue(i, "LCT_Q5_NM").replace(/\|/gi, ", ");
            }

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_LCTRLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- Ʈ������ ����. -->
    <script for=trT_ED_LCTRLIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_LCTRLIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�系�����������</td>
                    <td align="right" class="navigator">HOME/��������/�������/<font color="#000000">�系�����������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="ImgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                            <tr>
                                <td align="right" class="searchState">���籸��&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbLCT_CD_SHR>
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">���Ǻо�&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbLCT_Q5_GBN_SHR>
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">�����&nbsp;</td>
                                <td class="padding2423">
                                    <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="20">
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
        <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object    id="grdT_ED_LCTRLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
                            <param name="DataID"                  value="dsT_ED_LCTRLIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     width=39    name='����'           align=center </C>
                                <C> id='LCT_NM'       width=75    name='���籸��'       align=center </C>
                                <C> id='LCT_Q5_NM'    width=210   name='����о�'       align=left   </C>
                                <C> id='ENO_NM'       width=90    name='�����'         align=center </C>
                                <C> id='DPT_NM'       width=90    name='�Ҽ�'           align=center </C>
                                <C> id='IPT_NM'       width=90    name='�����'         align=center </C>
                                <C> id='IPT_YMD'      width=90    name='�������'       align=center </C>
                                <C> id='FUNC'         width=95    name='������ȸ'       align=center Color='Blue' </C>
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