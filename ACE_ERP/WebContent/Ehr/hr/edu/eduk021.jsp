<!--
    ************************************************************************************
    * @Source         : eduk021.jsp                                                    *
    * @Description    : ����������û PAGE                                          *
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
    <title>����������û(eduk021)</title>
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

			var YEAR      = opener.pis_yy;
            var DPT_CD    = opener.dpt_cd;
            var ORD_NO    = opener.ord_cd;
            
            dsT_ED_YEARPLAN.ClearData();
            dsT_ED_YEARPLAN.DataId = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk021.cmd.EDUK021CMD&S_MODE=SHR&YEAR="+YEAR+"&DPT_CD"+DPT_CD+"&ORD_CD"+ORD_CD;
            dsT_ED_YEARPLAN.Reset();

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

            trT_ED_YEARPLAN.KeyValue = "tr01(I:SAV=dsT_ED_YEARPLAN)";
            trT_ED_YEARPLAN.action = "/servlet/GauceChannelSVL?cmd=hr.edu.k.eduk021.cmd.EDUK021CMD&S_MODE=SAV";
            trT_ED_YEARPLAN.post();



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

            if (!dsT_ED_YEARPLAN.IsUpdated) {

                // DataSet�� ���� ���� Ȯ��
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;

            }

            if ( dsT_ED_YEARPLAN.isUpdated) {
                for( i = 1; i <= dsT_ED_YEARPLAN.CountRow; i++ ) {
                    if( dsT_ED_YEARPLAN.RowStatus(i) == 1 ||
                        dsT_ED_YEARPLAN.RowStatus(i) == 3 ) {

                        // ���
                        if( dsT_ED_YEARPLAN.NameValue(i, "ENO_NO") == '' ) {
                            alert("����ڻ���� �ʼ� �Է»����Դϴ�.");
                            document.getElementById("txtENO_NO").focus();
                            return false;
                        }

                        // ��� CHECK
                        if (dsT_ED_YEARPLAN.NameValue(i, "ENO_NO") != "" &&
                            dsT_ED_YEARPLAN.NameValue(i, "ENO_NM") == "") {
                            alert("�Է��Ͻ� ����� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                            dsT_ED_YEARPLAN.RowPosition = i;
                            document.getElementById("txtENO_NO").focus();
                            return;
                        }

                        // ������� CHECK
                        if (!fnc_CheckDate2(dsT_ED_YEARPLAN.NameValue(i, "STR_YMD"), "�������") && dsT_ED_YEARPLAN.NameValue(i, "STR_YMD") != "") {
                            dsT_ED_YEARPLAN.RowPosition = i;
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

                document.getElementById('txtYEAR').value = opener.edu_cd;

                fnc_ChangeStateElement(false, "txtEDU_CD");
                fnc_ChangeStateElement(false, "cmbEDU_GBN_CD");     //��������
                fnc_ChangeStateElement(false, "cmbPLACE_CD");       //�������


                // ������ ��ȸ
                fnc_SearchList();
            }
            else {

                fnc_EnableElementAll(elementList);

                // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��
                if (dsT_ED_YEARPLAN.CountColumn == 0) {
                    dsT_ED_YEARPLAN.setDataHeader("PIS_YY:STRING, DPT_CD:STRING, ORD_NO:STRING, ENO_NO:STRING, JOB_CD:STRING, EDU_CD:STRING, EDU_NM:STRING, INT_NAM:STRING, STR_YMD:STRING, END_YMD:STRING, TIME_NO:NUMBER, COST_AMT:NUMBER, DUTY_REL:STRING, DUTY_TXT:STRING, EFFECT_TAG:STRING, INS_YN:STRING, SHAPE_CD:STRING, GOAL_TAG:STRING, NOTE_TAG:STRING");
                }

                // Row Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�
                dsT_ED_YEARPLAN.AddRow();

                dsT_ED_YEARPLAN.NameValue(1, "PIS_YY")  = getToday().substr(0,4);
                dsT_ED_YEARPLAN.NameValue(1, "DPT_CD")  = opener.dpt_cd;
                document.getElementById("txtENO_NO").value = '<%=box.get("SESSION_ENONO")%>';
            	document.getElementById("txtENO_NM").value = '<%=box.get("SESSION_ENONM")%>';

            }

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            if (dsT_ED_YEARPLAN.IsUpdated)
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
    <Object ID="dsT_ED_YEARPLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_ED_COURSELIST)|
    | 3. ���Ǵ� Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID ="trT_ED_YEARPLAN" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="SVL(I:SAV=dsT_ED_YEARPLAN)">
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
    <Script For=dsT_ED_YEARPLAN Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");


        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03");

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_ED_YEARPLAN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_YEARPLAN Event="OnDataError()">

        cfErrorMsg(this);

    </Script>



    <!-- Ʈ������ ����. -->
    <script for=trT_ED_YEARPLAN event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        opener.fnc_SearchList();

    </script>

    <!--Ʈ������ ���� -->
    <script for=trT_ED_YEARPLAN event="OnFail()">

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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����������û</td>
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
        <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80 "></col>
                    <col width="215"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                    <col width="70 "></col>
                    <col width="182"></col>
                </colgroup>
                <tr>
                    <input type=hidden id="txtORD_NO">
                    <td align="center" class="creamBold">�� û ��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtENO_NO" name="txtENO_NO" size="9" maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "9"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_EmplPop();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                        <b>
                        &nbsp;&nbsp;�μ�
                        <input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtDPT_CD">
                        &nbsp;&nbsp;����
                        <input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly>
                        <input type="hidden" id="txtJOB_CD">
                        </b>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold" >��������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');" >
                        <input id="txtEDU_NM_SHR" size="20" maxlength= "200" class="input_ReadOnly" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
                        <input id="txtEDU_TXT" name="txtEDU_TXT"  maxlength="200" style="width:100%" >
                    </td>

                </tr>
                <tr>
                    <td align="center" class="creamBold" >��������</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtGOAL_TXT" name="txtGOAL_TXT" maxlength="60" style="width:100%">
                    </td>
                    <td align="center" class="creamBold" >��������</td>
                    <td class="padding2423" align="left" colspan="5">
                        <select id="cmbEDU_GBN_CD" style="width:100px" >
                        </select>
                    </td>
                </tr>
           <!-- <tr>
                    <td align="center" class="creamBold" >�������</td>
                    <td class="padding2423" colspan="5">
                        <input type="checkbox" name="chkOBJ_TYPE" value="T"> ������
                        <input type="checkbox" name="chkOBJ_TYPE" value="A"> �繫��
                        <input type="checkbox" name="chkOBJ_TYPE" value="M"> �ù���
                        <input type="checkbox" name="chkOBJ_TYPE" value="E"> �İ���
                        <input type="checkbox" name="chkOBJ_TYPE" value="O"> ��Ÿ
                        <input id="txtOBJ_TXT" name="txtOBJ_TXT" maxlength="50" style="width:100px">
                    </td>
                </tr>    -->
                <tr>
                    <td align="center" class="creamBold">�����Ͻ�</td>
                    <td class="padding2423">
                        <input id="txtEDU_STR_YMD" name="txtEDU_STR_YMD" style="ime-mode:disabled" size="10" maxlength="10"  onblur="fnc_CheckDate(this);" onChange="fnc_CheckDate(this, '������������');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduStrYmd" name="ImgEduStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_STR_YMD','','0','252');"></a> ~
                        <input id="txtEDU_END_YMD" name="txtEDU_END_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate1(this);" onChange="fnc_CheckDate(this, '������������');" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_compareFromTo('txtEDU_STR_YMD', 'txtEDU_END_YMD');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduEndYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEduEndYmd" name="ImgEduEndYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEDU_END_YMD','','112','252');"></a>
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtEDU_GBN_TXT" name="txtEDU_GBN_TXT" maxlength="28" style="width:100%">
                    </td>
                    <td align="center" class="creamBold">�������</td>
                    <td class="padding2423" >
                        <input id="txtPLACE_TXT" name="txtPLACE_TXT" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423" colspan="5">
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="117" rows="4" onKeyUp="fc_chk_byte(this,300)"></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�ҿ���</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medCOST_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtFIX_NO" name="txtFIX_NO" maxlength="5" style="width:100%;text-align:right;" onchange="fnc_BindTOT();">
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" >
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
                    <td align="center" class="creamBold">ȯ�޿���</td>
                    <td class="padding2423">
                        <select id="cmbINS_YN" style="width:100%" onchange="fnc_BindTOT()">
                            <option value="N">������</option>
                            <option value="Y">����</option>
                        </select>
                    </td>
                    <td align="center" class="creamBold">ȯ�޿����</td>
                    <td class="padding2423">
                        <comment id="__NSID__"><object id="medRTN_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
                        </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                    <td align="center" class="creamBold">ó����Ȳ</td>
                    <td class="padding2423">
                        <select id="cmbSTS_GBN" style="width:100%" >
                            <option value="1">��û</option>
                            <option value="2">����</option>
                            <option value="3">�ΰ�</option>
                            <option value="4">����</option>
                        </select>
                    </td>
                </tr>
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
, JOB_CD, EDU_CD, EDU_NM, INT_NAM, STR_YMD, END_YMD, TIME_NO, COST_AMT, DUTY_REL, DUTY_TXT, EFFECT_TAG, INS_YN, SHAPE_CD, GOAL_TAG, NOTE_TAG
-->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_ED_YEARPLAN">
    <Param Name="BindInfo", Value='
        <C> Col=PIS_YY        Ctrl=txtPIS_YY        Param=value </C>
        <C> Col=DPT_CD   Ctrl=txtDPT_CD   Param=value </C>
        <C> Col=DPT_NM        Ctrl=txtDPT_NM        Param=value </C>
        <C> Col=ORD_NO   Ctrl=txtORD_NO   Param=value </C>
        <C> Col=ENO_NO        Ctrl=txtENO_NO        Param=value </C>
        <C> Col=ENO_NM        Ctrl=txtENO_NM        Param=value </C>
        <C> Col=JOB_NM        Ctrl=txtJOB_NM        Param=value </C>
        <C> Col=CET_NO        Ctrl=txtCET_NO        Param=value </C>
        <C> Col=EDU_TXT       Ctrl=txtEDU_TXT       Param=value </C>
        <C> Col=EDU_NM       Ctrl=txtEDU_NM       Param=value </C>
        <C> Col=EDU_NM        Ctrl=txtEDU_NM        Param=value </C>
        <C> Col=EDU_GBN_CD    Ctrl=cmbEDU_GBN_CD    Param=value </C>
        <C> Col=GOAL_TXT      Ctrl=txtGOAL_TXT      Param=value </C>
        <C> Col=EDU_GBN_TXT   Ctrl=txtEDU_GBN_TXT   Param=value </C>
        <C> Col=PLACE_TXT     Ctrl=txtPLACE_TXT     Param=value </C>
        <C> Col=CONTENT_TXT   Ctrl=txtCONTENT_TXT   Param=value </C>
        <C> Col=COST_AMT      Ctrl=medCOST_AMT      Param=text  </C>
        <C> Col=FIX_NO        Ctrl=txtFIX_NO        Param=value </C>
        <C> Col=INS_YN        Ctrl=cmbINS_YN        Param=value </C>
        <C> Col=SUM_AMT       Ctrl=medSUM_AMT       Param=text  </C>
        <C> Col=RTN_AMT       Ctrl=medRTN_AMT       Param=text  </C>
        <C> Col=STS_GBN       Ctrl=cmbSTS_GBN       Param=value </C>
    '>
</object>