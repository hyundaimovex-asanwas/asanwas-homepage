<!--
    ************************************************************************************
    * @Source         : eduh031.jsp                                                    *
    * @Description    : ���������������� PAGE                                          *
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
    <title>����������������(eduh031)</title>
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

        var btnList = 'FFTFFFFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh031.cmd.EDUH031CMD&S_MODE=SHR&EDU_CD="+opener.edu_cd;
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

            if (!fnc_SaveItemCheck()) {
                return;
            }

            trT_ED_COURSELIST.KeyValue = "tr01(I:SAV=dsT_ED_COURSELIST)";
            trT_ED_COURSELIST.action = "/servlet/GauceChannelSVL?cmd=hr.edu.h.eduh031.cmd.EDUH031CMD&S_MODE=SAV";
            trT_ED_COURSELIST.post();



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

            if (!dsT_ED_COURSELIST.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_COURSELIST.isUpdated) {
                for( i = 1; i <= dsT_ED_COURSELIST.CountRow; i++ ) {
                    if( dsT_ED_COURSELIST.RowStatus(i) == 1 ||
                        dsT_ED_COURSELIST.RowStatus(i) == 3 ) {

                        // ���
                        if( dsT_ED_COURSELIST.NameValue(i, "ENO_NO") == '' ) {
                            alert("����ڻ���� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // ��� CHECK
                        if (dsT_ED_COURSELIST.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_COURSELIST.NameValue(i, "ENO_NM") == "") {
                            alert("�Է��Ͻ� ����� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }
/*
                        // �����ڵ�
                        if( dsT_ED_COURSELIST.NameValue(i, "EDU_CD") == '' ) {
                            alert("�����ڵ�� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtEDU_CD").focus();
                            return false;
                        }

                        // �����ڵ� CHECK
                        if (dsT_ED_COURSELIST.NameValue(i, "EDU_CD") != "" &&
                            dsT_ED_COURSELIST.NameValue(i, "EDU_NM") == "") {
                            alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtEDU_CD").focus();
                            return;
                        }

                        // ��������
                        if( dsT_ED_COURSELIST.NameValue(i, "EDU_GBN_CD") == '' ) {
                            alert("���������� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbEDU_GBN_CD").focus();
                            return false;
                        }

                        // �����ְ�
                        if( dsT_ED_COURSELIST.NameValue(i, "MNGER_CD") == '' ) {
                            alert("�����ְ��� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbMNGER_CD").focus();
                            return false;
                        }

                        // �����о�
                        if( dsT_ED_COURSELIST.NameValue(i, "FIELD_CD") == '' ) {
                            alert("�����оߴ� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbFIELD_CD").focus();
                            return false;
                        }

                        // ��������
                        if( dsT_ED_COURSELIST.NameValue(i, "SHAPE_CD") == '' ) {
                            alert("�������´� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbSHAPE_CD").focus();
                            return false;
                        }
*/

                        // ���δ�
                        /*if( dsT_ED_COURSELIST.NameValue(i, "COST_CD") == '' ) {
                            alert("���δ��� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbCOST_CD").focus();
                            return false;
                        }*/

                        // �������
                        /*if( dsT_ED_COURSELIST.NameValue(i, "PLACE_CD") == '' ) {
                            alert("������Ҵ� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("cmbPLACE_CD").focus();
                            return false;
                        }*/

                        // ������� CHECK
                        if (!fnc_CheckDate2(dsT_ED_COURSELIST.NameValue(i, "STR_YMD"), "�������") && dsT_ED_COURSELIST.NameValue(i, "STR_YMD") != "") {
                            dsT_ED_COURSELIST.RowPosition = i;
                            document.getElementById("txtSTR_YMD").focus();
                            return false;
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

            fnc_ComboSet();
            fnc_DisableElementAll(elementList);


            // ������ �����̸�
            if (opener.gbn == "2") {

                document.getElementById('txtEDU_CD').value = opener.edu_cd;

                document.getElementById('txtENO_NO').value = opener.eno_no;
                document.getElementById('txtENO_NM').value = opener.eno_nm;

                fnc_ChangeStateElement(false, "txtEDU_CD");

                fnc_ChangeStateElement(false, "cmbEDU_GBN_CD");     //��������
                fnc_ChangeStateElement(false, "cmbPLACE_CD");       //�������


                // ������ ��ȸ
                fnc_SearchList();
            }
            else {

                fnc_EnableElementAll(elementList);

                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_ED_COURSELIST.CountColumn == 0) {
                    dsT_ED_COURSELIST.setDataHeader("EDU_CD:STRING:NULL, EDU_NM:STRING, STR_YMD:STRING, END_YMD:STRING, ENO_NO:STRING, ENO_NM:STRING, EDU_GBN_CD:STRING, MNGER_CD:STRING, FIELD_CD:STRING, SHAPE_CD:STRING, GOAL_TAG:STRING , CONTENT_TXT:STRING, EFFECT_TAG:STRING, OBJ_TAG:STRING, CPT_TAG:STRING, USE_YN:STRING");
                }

                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_ED_COURSELIST.AddRow();

                dsT_ED_COURSELIST.NameValue(1, "ENO_NO")  = opener.eno_no;
                dsT_ED_COURSELIST.NameValue(1, "ENO_NM")  = opener.eno_nm;
                dsT_ED_COURSELIST.NameValue(1, "STR_YMD") = getToday();

                document.getElementById('txtENO_NO').focus();
            }

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_COURSELIST.IsUpdated)
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


        /********************
         * �޺��ڽ� �� SET  *
         ********************/
        function fnc_ComboSet() {
            var oOption = null;

            //��������
            for( var i = 1; i <= dsCOMMON_Q6.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q6.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q6.NameValue(i,"CODE_NAME");
                document.getElementById("cmbEDU_GBN_CD").add(oOption);

            }

            //�����ְ�
            for( var i = 1; i <= dsCOMMON_Q7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbMNGER_CD").add(oOption);

            }

            //�����о�
           for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD").add(oOption);

            }

            //��������
           for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD").add(oOption);

            }

            //���δ�
            /*for( var i = 1; i <= dsCOMMON_QB.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_QB.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_QB.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCOST_CD").add(oOption);

            }*/

            //�������
            /*for( var i = 1; i <= dsCOMMON_Q9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbPLACE_CD").add(oOption);

            }*/
        }


        var elementList = new Array(      "txtEDU_NM"

                                        , "txtSTR_YMD"
                                        , "txtENO_NO"
                                        , "txtENO_NM"
                                        , "ImgEnoNo"
                                        , "txtCONTENT_TXT"
                                        , "txtEFFECT_TAG"
                                        , "txtOBJ_TAG"
                                        , "txtCPT_TAG"
                                        , "ImgStrYmd"
                                        , "cmbEDU_GBN_CD"
                                        , "cmbMNGER_CD"
                                        , "cmbFIELD_CD"
                                        , "cmbSHAPE_CD"
                                        , "txtGOAL_TAG"
                                        );



        var exceptionList = new Array(    "txtSTR_YMD"
                                        );
                                        //, "cmbEDU_GBN_CD"
                                        //, "cmbPLACE_CD"
                                        
		function fnc_UsrGetEnoNm() {

            var obj = new String();


                obj = fnc_GetEnoNm("txtENO_NO");

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;
        }
        function fnc_UsrGetEnoNo() {
        		fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');

        	//fnc_UsrGetEnoNm(gbn);

        }
        function fnc_Popup() {
            var obj = new String();

                obj = fnc_emplPopup('txtENO_NO','txtENO_NM');

                if (obj.eno_no == "") {
                    return;
                }

                document.getElementById("txtENO_NO").value = obj.eno_no;
                document.getElementById("txtENO_NM").value = obj.eno_nm;

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
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_COURSELIST)">
    </Object>


    <!-- ���� �޺��� ���� DataSet -->
    <!-- �������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q6"/>
       <jsp:param name="CODE_GUBUN"    value="Q6"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

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


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            // ��ư�� ������ ����.
            document.getElementById("view_1").style.display='none';
            fnc_DisableElementAll(elementList);

        } else {

<%
    if(box.get("SESSION_ROLE_CD").equals("1001")
            || box.get("SESSION_ROLE_CD").equals("1002")) {
%>
                document.getElementById("view_1").style.display='inline';
                fnc_EnableElementAll(elementList, exceptionList);
<%
    } else {
%>
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

            if (dsT_ED_COURSELIST.NameValue(1, "ENO_NO") == '<%=box.get("SESSION_ENONO")%>') {

                // ��ư�� ����
                document.getElementById("view_1").style.display='inline';
                fnc_EnableElementAll(elementList, exceptionList);
            }
            else {

                // ��ư�� ������ ����.
                document.getElementById("view_1").style.display='none';
                fnc_DisableElementAll(elementList);
            }
<%
    }
%>
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

        cfErrorMsg(this);

    </Script>



    <!-- Ʈ������ ����. -->
    <script for=trT_ED_COURSELIST event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        opener.fnc_SearchList();

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������������</td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)"><img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            </div>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                    <col width="200"></col>
                    <col width="100"></col>
                    <col width="200"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����ڵ�</td>
                    <td class="padding2423">
                        <input id="txtEDU_CD" name="txtEDU_CD" size="10"  maxlength="10" class="input_ReadOnly" readOnly>
                    </td>
                    <td align="center" class="creamBold">������</td>
                    <td class="padding2423">
						<input id="txtEDU_NM" name="txtEDU_NM" size="30">
                    </td>
                    <td align="center" class="creamBold">��뿩��</td>
                    <td class="padding2423">
						<comment id="__NSID__"><object id="cmbUSE_YN" classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 style="width:80%">
							<param name=CBData        value="Y^���,N^�̻��">
		                    <param name=CBDataColumns     value="USE_YN,USE_DESC">
		                    <param name=BindColumn        value="USE_YN">
		                    <param name=ListExprFormat    value="USE_YN^1^20,USE_DESC^0^50">
		                    <param name=EditExprFormat    value="%;USE_DESC">
		                    <param name=ComboStyle        value=2>
		                    <param name=InheritColor      value="true">   
		                    <param name=Enable            value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���������</td>
                    <td class="padding2423" >
                        <input id="txtENO_NO"  name="txtENO_NO" size="6"  maxlength="6" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNm();" onChange="fnc_UsrGetEnoNm();">
                        <input id="txtENO_NM" name="txtENO_NM" size="16" onkeypress="if(event.keyCode==13) fnc_UsrGetEnoNo();" onchange="fnc_UsrGetEnoNo();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_Popup()"></a>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD"  name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '�������');"onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','470','100');"></a>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <select id="cmbEDU_GBN_CD" style="width:100" >
                        </select>
                    </td>
                </tr>

                <tr>
                    <td align="center" class="creamBold">�����ְ�</td>
                    <td class="padding2423" >
                        <select id="cmbMNGER_CD" style="width:80" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">�����о�</td>
                    <td class="padding2423" >
                        <select id="cmbFIELD_CD" style="width:100" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <select id="cmbSHAPE_CD" style="width:100" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">������ǥ</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtGOAL_TAG"  name="txtGOAL_TAG" style="width:100%" maxlength="100" >
                    </td>
                </tr>


                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="112" rows="5" onkeyup="fc_chk_byte(this,300);"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCPT_TAG"  name="txtCPT_TAG" cols="112" rows="3" onkeyup="fc_chk_byte(this,150);"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���ȿ��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtEFFECT_TAG"  name="txtEFFECT_TAG" style="width:100%" maxlength="100" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtOBJ_TAG"  name="txtOBJ_TAG" style="width:100%" maxlength="50" >
                    </td>
                </tr>

                <!--
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtINT_NAM"  name="txtINT_NAM" style="width:100%" maxlength="22" >
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" >
                        <input id="txtFIX_NO"  name="txtFIX_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > ��
                    </td>
                    <td align="center" class="creamBold">�����ð�</td>
                    <td class="padding2423" >
                        <input id="txtTIME_NO"  name="txtTIME_NO" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="3" > �ð�
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�����ϼ�</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtDAY_NO"  name="txtDAY_NO" style="width:34%;ime-mode:disabled;text-align:right;" maxlength="3" > ��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">���δ�</td>
                    <td class="padding2423" >
                        <select id="cmbCOST_CD" style="width:100%" >
                        </select>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <select id="cmbPLACE_CD" style="width:100%" >
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  ��
                    </td>
                    <td align="center" class="creamBold">ȯ�ޱݾ�</td>
                    <td class="padding2423" >
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80%">
                            <param name=Alignment            value=2>
                            <param name=Border               value=true>
                            <param name=ClipMode             value=true>
                            <param name=DisabledBackColor    value="#EEEEEE">
                            <param name=Enable               value=true>
                            <param name=IsComma              value=true>
                            <param name=Language             value=0>
                            <param name=MaxLength            value=9>
                            <param name=Numeric              value=true>
                            <param name=ShowLiteral          value="false">
                            <param name=Visible              value="true">
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>  ��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�̼�����</td>
                    <td class="padding2423" >
                        <input id="txtCPT_PNT"  name="txtCPT_PNT" style="width:80%;ime-mode:disabled;text-align:right;" maxlength="2" > ��
                    </td>
                    <td align="center" class="creamBold">�������Ʈ</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" style="width:80%" maxlength="30" >
                    </td>
                </tr>
                -->

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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �򰡴���ڼ��� ���̺� -->

<object id="bndT_ED_COURSELIST"" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_COURSELIST">
    <Param Name="BindInfo", Value='
        <C>Col=EDU_CD       Ctrl=txtEDU_CD       Param=value </C>
        <C>Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD      Param=value </C>
        <C>Col=ENO_NO       Ctrl=txtENO_NO       Param=value </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM       Param=value </C>
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>

        <C>Col=CONTENT_TXT  Ctrl=txtCONTENT_TXT  Param=value </C>
        <C>Col=EFFECT_TAG   Ctrl=txtEFFECT_TAG   Param=value </C>
        <C>Col=OBJ_TAG      Ctrl=txtOBJ_TAG      Param=value </C>
        <C>Col=CPT_TAG      Ctrl=txtCPT_TAG      Param=value </C>
        <C>Col=USE_YN      Ctrl=cmbUSE_YN      Param=BindColVal </C>
    '>
</object>

<!-- �ٸ����̺�� �̵��� �ʵ�
        <C>Col=EDU_GBN_CD   Ctrl=cmbEDU_GBN_CD   Param=value </C>
        <C>Col=MNGER_CD     Ctrl=cmbMNGER_CD     Param=value </C>
        <C>Col=FIELD_CD     Ctrl=cmbFIELD_CD     Param=value </C>
        <C>Col=SHAPE_CD     Ctrl=cmbSHAPE_CD     Param=value </C>
        <C>Col=GOAL_TAG     Ctrl=txtGOAL_TAG     Param=value </C>

        <C>Col=INT_NAM      Ctrl=txtINT_NAM      Param=value </C>
        <C>Col=FIX_NO       Ctrl=txtFIX_NO       Param=value </C>
        <C>Col=DAY_NO       Ctrl=txtDAY_NO       Param=value </C>
        <C>Col=TIME_NO      Ctrl=txtTIME_NO      Param=value </C>
        <C>Col=COST_AMT     Ctrl=medCOST_AMT     Param=text  </C>
        <C>Col=COST_CD      Ctrl=cmbCOST_CD      Param=value </C>
        <C>Col=RTN_AMT      Ctrl=medRTN_AMT      Param=text  </C>
        <C>Col=PLACE_CD     Ctrl=cmbPLACE_CD     Param=value </C>
        <C>Col=CPT_PNT      Ctrl=txtCPT_PNT      Param=value </C>
        <C>Col=SITE_TAG     Ctrl=txtSITE_TAG     Param=value </C>
 -->