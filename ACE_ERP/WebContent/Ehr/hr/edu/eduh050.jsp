<!--
    ************************************************************************************
    * @Source         : eduh050.jsp                                                    *
    * @Description    : ������� PAGE                                              *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/02/20  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

    <head>
    <title>�������(eduh050)</title>
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

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var f = document.form1;
            var MNGER_CD = document.getElementById("cmbMNGER_CD_SHR").value;
            var FIELD_CD = document.getElementById("cmbFIELD_CD_SHR").value;
            var SHAPE_CD = document.getElementById("cmbSHAPE_CD_SHR").value;
            var EDU_CD   = document.getElementById("txtEDU_CD_SHR").value;
            var EDU_STR_YMD  = document.getElementById("txtEDU_STR_YMD_SHR").value;
            var EDU_END_YMD  = document.getElementById("txtEDU_END_YMD_SHR").value;
            var SEQ_NO = document.getElementById("txtSEQ_NO_SHR").value;

            if (SEQ_NO == ''){
                SEQ_NO = '%' ;
            }

            //�����ϰ� �������� �Ѵ� �Է��� �Ǿ��ų� �Ѵ� ������� ��찡 �ƴϸ� ���ڸ� ���
            if((EDU_STR_YMD != "" && EDU_END_YMD == "")
                    || (EDU_STR_YMD == "" && EDU_END_YMD != "")) {
                if(EDU_STR_YMD == "") {
                    alert("�������� ��� �ֽ��ϴ�.");
                    document.getElementById("txtEDU_STR_YMD_SHR").focus();
                    return;
                }
                if(EDU_END_YMD == "") {
                    alert("�������� ��� �ֽ��ϴ�.");
                    document.getElementById("txtEDU_END_YMD_SHR").focus();
                    return;
                }
            }

           //������ұ��� ����
           /* var PLACE_NM1 = "";
            var PLACE_NM2 = "";
            var PLACE_NM3 = "";
            var place = document.getElementsByName("chkPLACE_NM");

            if(place[0].checked == true )
                PLACE_NM1 = "1";
            if(place[1].checked == true )
                PLACE_NM2 = "2";
            if(place[2].checked == true )
                PLACE_NM3 = "3";  */


            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh050.cmd.EDUH050CMD&S_MODE=SHR&MNGER_CD="+MNGER_CD+"&FIELD_CD="+FIELD_CD+"&SHAPE_CD="+SHAPE_CD+"&EDU_CD="+EDU_CD+"&ENO_NO="+<%=box.get("SESSION_ENONO")%>+"&EDU_STR_YMD="+EDU_STR_YMD+"&EDU_END_YMD="+EDU_END_YMD+"&SEQ_NO="+SEQ_NO;  //+"&PLACE_NM1="+PLACE_NM1+"&PLACE_NM2="+PLACE_NM2+"&PLACE_NM3="+PLACE_NM3;
            dsT_ED_COURSELIST.Reset();

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

            if (dsT_ED_COURSELIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_ED_COURSELIST.GridToExcel("�������", '', 225)

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

            document.getElementById("cmbMNGER_CD_SHR").value = "";
            document.getElementById("cmbFIELD_CD_SHR").value = "";
            document.getElementById("cmbSHAPE_CD_SHR").value = "";
            document.getElementById("txtEDU_CD_SHR").value   = "";
            document.getElementById("txtEDU_NM_SHR").value   = "";
            document.getElementById("txtEDU_STR_YMD_SHR").value = "";
            document.getElementById("txtEDU_END_YMD_SHR").value = "";
            document.getElementById("txtSEQ_NO_SHR").value = "" ;

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_COURSELIST.ClearData();

            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
            cfStyleGrid(form1.grdT_ED_COURSELIST,0,"false","false");

            //�����ְ�
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD_SHR").add(oOption);

            }

            //�����о�
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }

            //��������
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }

            document.getElementById("txtEDU_STR_YMD_SHR").focus();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_ED_COURSELIST)|
    | 3. ���Ǵ� Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_COURSELIST)|
    | 3. ���Ǵ� Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_COURSELIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <Param Name=KeyValue    Value="SVL(I:DEL=dsT_ED_COURSELIST)">
    </Object>

    <!-- �����ְ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �����о� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- �������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_COURSELIST Event="OnDblClick(row, col)">
        var obj = new String();
        obj.edu_cd = dsT_ED_COURSELIST.NameString(row, "EDU_CD");
        obj.edu_nm = dsT_ED_COURSELIST.NameString(row, "EDU_NM");
        obj.seq_no = dsT_ED_COURSELIST.NameString(row, "SEQ_NO");
        obj.comm_no = dsT_ED_COURSELIST.NameString(row, "COMM_NO");

        // �н��ڰ��� ���ý�
        if (col == 'OBJ_MAN') {
            window.showModalDialog("/hr/edu/eduh051.jsp", obj, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            fnc_SearchList();
        }
        // �ϰ���� ���ý�
        else if (col == 'BAT_INS' && dsT_ED_COURSELIST.NameString(row, col) != "") {

/*  2007�⿡�� ����� �ϰ� ����� �����Ӱ� ��� 2008�� ���ʹ� ������ �ʿ� ����
            if(!(dsT_ED_COURSELIST.NameValue(row, "EDU_STR_YMD") > getToday())) {
                alert("������ϰ������ �������� ������ ��ϰ����մϴ�.");
                return;
            }
*/

            window.showModalDialog("/hr/edu/eduh052.jsp", obj, "dialogHeight:600px; dialogWidth:670px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
            fnc_SearchList();
        }
        // ������� ���ý�
        else if (col == 'RES_INS' && dsT_ED_COURSELIST.NameString(row, col) != "") {


            //�н��� ���۵Ǿ� ������� ����
            if(dsT_ED_COURSELIST.NameString(row, "EDU_STR_YMD") >= getToday()){
                alert("�����Ⱓ ���Ŀ� ��������� �����մϴ�.");
                return;
            }

            //��û�ڰ� �Ѹ��̶� ������
            if (dsT_ED_COURSELIST.NameValue(row, "REQ_CNT")+dsT_ED_COURSELIST.NameValue(row, "PAS_CNT") > 0) {

                window.showModalDialog("/hr/edu/eduh053.jsp", obj, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                fnc_SearchList();
            }
            else {
                alert("������ϴ���� �������� �ʽ��ϴ�.");
                return;
            }
        }

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
 <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {
            //document.getElementById("hidCOMM_NO").value = dsT_ED_COURSELIST.NameValue(1,"COMM_NO");
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-- Ʈ������ ����. -->
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_COURSELIST event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������</td>
                    <td align="right" class="navigator">HOME/��������/�������/<font color="#000000">�������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"><img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                         <!--   <colgroup>
                                <col width="70"></col>
                                <col width="80"></col>
                                <col width="50"></col>
                                <col width="90"></col>
                                <col width="80"></col>
                                <col width="90"></col>
                                <col width="90"></col>
                                <col width="*"></col>
                            </colgroup>     -->
                            <tr>
                                <td align="right" class="searchState">�����Ⱓ&nbsp;</td>
                                <td class="padding2423" colspan="3">
                                    <input id="txtEDU_STR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD_SHR','','20','120');"></a>
                                    ~
                                    <input id="txtEDU_END_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd1" name="ImgEduStrYmd1" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD_SHR','','20','120');"></a>
                                </td>
		                    <!--    <td class="searchState" align="right">�������&nbsp;</td>
		                        <td class="padding2423" align="left" colspan="3">
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>�系
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>���
		                            <input type="checkbox" id="chkPLACE_NM" name="chkPLACE_NM" style="border:0" value="" checked>���ͳ�
		                        </td>    -->
		                          <td align="right" class="searchState">������ </td>
                                      <td class="padding2423" align="left">
                                    <input id=txtSEQ_NO_SHR name=txtSEQ_NO_SHR size="7" maxlength="7">
                                  </td>
                            </tr>
                            <tr>
                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbMNGER_CD_SHR style="WIDTH:70" >
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbFIELD_CD_SHR style="WIDTH:90" >
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                                <td class="padding2423" align="left">
                                    <select id=cmbSHAPE_CD_SHR style="WIDTH:90" >
                                        <option value="">��ü</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��������&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtEDU_CD_SHR size="4"  maxlength="4" onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList();" >
                                    <input id=txtEDU_NM_SHR name=txtEDU_NM_SHR size="18" class="input_ReadOnly" readOnly>
                                      <input type=hidden id="hidCOMM_NO">
                                      <!--<input id="txtCOMM_NO" name="txtCOMM_NO" size="5" > -->
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)">
                                    <img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <FC> id='{currow}'     width=40    name='NO'                align=center </FC>
                                <FC> id='EDU_NM'       width=130   name='������'            align=left   suppress = '1'</FC>
                                <FC> id='SEQ_NO'       width=55    name='����'              align=center </FC>
                                <C>  id='ENT_TERM'     width=150   name='��û�Ⱓ'          align=center </C>
                                <C>  id='EDU_TERM'     width=150   name='�����Ⱓ'          align=center </C>
                                <C>  id='SHAPE_NM'     width=70    name='����'              align=center </C>
                                <C>  id='EDU_GBN_NM'   width=50    name='����'              align=center </C>
                                <C>  id='MNGER_CD_NM'  width=50    name='�ְ�'              align=center </C>
                                <C>  id='REQ_CNT'      width=48    name='��û'              align=right  </C>
                                <C>  id='OBJ_CNT'      width=48    name='���'              align=right  show=false</C>
                                <C>  id='PAS_CNT'      width=48    name='����'              align=right  </C>
                                <C>  id='OBJ_MAN'      width=90    name='�н��ڰ���'        align=center Color='Blue' </C>
                                <C>  id='BAT_INS'      width=80    name='�� �� ��;�ϰ����' align=center Color='Blue' </C>
                                <C>  id='RES_INS'      width=80    name='�н����'          align=center Color='Blue' </C>
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