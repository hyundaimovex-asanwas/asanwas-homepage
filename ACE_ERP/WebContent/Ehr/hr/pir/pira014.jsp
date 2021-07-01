<!--
    ************************************************************************************
    * @Source         : pira014.jsp                                                    		*
    * @Description    : �λ�⺻4 PAGE                                                 		*
    * @Developer Desc :                                                                		*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�											*
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>�λ�⺻4</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    String ENO_NO = request.getParameter("ENO_NO");         //���
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            if (form1.ENO_NO.value == "" || (parent.dsT_CM_PERSON.CountRow < 1 && parent.dsT_CM_PERSON.RowStatus(1) != 1)) {

                dsT_CM_PERSON.ClearData();
                fnc_ColEnabled('D');

                document.getElementById("resultMessage").innerText = '';
                if (parent.document.getElementById("txtENO_NO").disabled == false) {
                    parent.document.getElementById("txtENO_NM").focus();
                }

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira014.cmd.PIRA014CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
            dsT_CM_PERSON.Reset();

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

            //DataSet�� ���� ���� Ȯ��
            if (!dsT_CM_PERSON.IsUpdated ) {
//                document.getElementById("resultMessage").innerText = "* ������ ������ �����ϴ�.";
                return true;
            }

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira014.cmd.PIRA014CMD&S_MODE=SAV&ENO_NO="+parent.document.getElementById("txtENO_NO").value+"&HEAD_CD="+parent.document.getElementById("txtHEAD_CD").value+"&DPT_CD="+parent.document.getElementById("txtDPT_CD").value;
                trT_CM_PERSON.post();

            } else {

                return false;

            }

            return true;

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

        	//����ӽ�����
			var ENO_NO = document.getElementById("ENO_NO").value;

			dsT_CM_PERSON.ClearData();
			
			document.getElementById("ENO_NO").value = ENO_NO;
			
			document.getElementById("resultMessage").innerText = ' ';

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

            var f = document.form1;


            // �ι�
            if (document.getElementById("txtPART_CD").value != "" && document.getElementById("txtPART_NM").value == "") {
            	
                alert("�ι��ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtPART_CD").focus();
                
                return false;
                
            }

            // ��ȥ�� CHECK
            if (!fnc_CheckDate(document.getElementById("txtWED_YMD"), "��ȥ��") && document.getElementById("txtWED_YMD").value != "") {
            	
                document.getElementById("txtWED_YMD").focus();
                
                return false;
                
            }

            // ����
            if (document.getElementById("txtREL_CD").value != "" && document.getElementById("txtREL_NM").value == "") {
            	
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtREL_CD").focus();
                
                return false;
                
            }

            // ��������
            if (document.getElementById("txtRET_CD").value != "" && document.getElementById("txtRET_NM").value == "") {
            	
                alert("�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtRET_CD").focus();
                
                return false;
            }

            // ����� CHECK
            if (!fnc_CheckDate(document.getElementById("txtRET_YMD"), "�����") && document.getElementById("txtRET_YMD").value != "") {
            	
                document.getElementById("txtRET_YMD").focus();
                
                return false;
                
            }

            // ����ó�������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtRETP_YMD"), "����ó��������") && document.getElementById("txtRETP_YMD").value != "") {
            	
                document.getElementById("txtRETP_YMD").focus();
                
                return false;
                
            }

            // ������ġ
            if (document.getElementById("txtRETM_CD").value != "" && document.getElementById("txtRETM_NM").value == "") {
            	
                alert("��ġ�ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtRETM_CD").focus();
                
                return false;
                
            }

            // ��ġ�ڻ��
            if (document.getElementById("txtRETM_REM").value != "" && document.getElementById("txtRETM_RNM").value == "") {
            	
                alert("��ġ�ڻ���� �Է��Ͻ� ���� �������� �ʴ� ����Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtRETM_REM").focus();
                
                return false;
                
            }

            // ��ġ�� CHECK
            if (!fnc_CheckDate(document.getElementById("txtRETM_YMD"), "��ġ��") && document.getElementById("txtRETM_YMD").value != "") {
            	
                document.getElementById("txtRETM_YMD").focus();
                
                return false;
                
            }

            // �����ݱ����� CHECK
            if (!fnc_CheckDate(document.getElementById("txtHIRR_YMD"), "�����ݱ�����") && document.getElementById("txtHIRR_YMD").value != "") {
            	
                document.getElementById("txtHIRR_YMD").focus();
                
                return false;
                
            }

            // ������1 CHECK
            if (!fnc_CheckDate(document.getElementById("txtMID_YMD1"), "������1") && document.getElementById("txtMID_YMD1").value != "") {
            	
                document.getElementById("txtMID_YMD1").focus();
                
                return false;
                
            }

            // �������ߵ�������1 CHECK
            if (!fnc_CheckDate(document.getElementById("txtRAM_YMD"), "�������ߵ�������1") && document.getElementById("txtRAM_YMD").value != "") {
            	
                document.getElementById("txtRAM_YMD").focus();
                
                return false;
                
            }

            // ������2 CHECK
            if (!fnc_CheckDate(document.getElementById("txtMID_YMD2"), "������2") && document.getElementById("txtMID_YMD2").value != "") {
            	
                document.getElementById("txtMID_YMD2").focus();
                
                return false;
                
            }

            // �������ߵ�������2 CHECK
            if (!fnc_CheckDate(document.getElementById("txtRAM_YMD2"), "�������ߵ�������2") && document.getElementById("txtRAM_YMD2").value != "") {
            	
                document.getElementById("txtRAM_YMD2").focus();
                
                return false;
                
            }

            // ������3 CHECK
            if (!fnc_CheckDate(document.getElementById("txtMID_YMD3"), "������3") && document.getElementById("txtMID_YMD3").value != "") {
            	
                document.getElementById("txtMID_YMD3").focus();
                
                return false;
                
            }

            // �������ߵ�������3 CHECK
            if (!fnc_CheckDate(document.getElementById("txtRAM_YMD3"), "�������ߵ�������3") && document.getElementById("txtRAM_YMD3").value != "") {
            	
                document.getElementById("txtRAM_YMD3").focus();
                
                return false;
                
            }

            return true;

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("ENO_NO").value = "<%=ENO_NO%>";

            fnc_ColEnabled('D');

            fnc_SearchList();

        }

        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/
        function fnc_ChangeDate() {
            var elementName = new Array( "txtRAM_YMD"
                                        ,"txtRAM_YMD2"
                                        ,"txtRAM_YMD3");
            var element = null;
            var ram_ymd = "";

            for(i=0; i<3; i++) {
               element = document.getElementById(elementName[i]);
               if(element.value != "") {
                  ram_ymd = element.value;
               } else {
                       break;
                      }
            }

             if(addDate("D",ram_ymd,1) != "")
                document.getElementById("txtHIRR_YMD").value = addDate("D",ram_ymd,1);
        }

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtHOBBY").disabled       = false;
                document.getElementById("txtSPEC_CD").disabled     = false;
                document.getElementById("txtPART_CD").disabled     = false;
                document.getElementById("txtWED_YMD").disabled     = false;
                document.getElementById("txtREL_CD").disabled      = false;
                document.getElementById("txtCOM_PHN_NO").disabled  = false;
                document.getElementById("txtREG_CD").disabled      = false;
                document.getElementById("txtRET_CD").disabled      = false;
                document.getElementById("txtRET_YMD").disabled     = false;
                document.getElementById("txtRETP_YMD").disabled    = false;
                document.getElementById("txtRETM_CD").disabled     = false;
                document.getElementById("txtRETM_YMD").disabled    = false;
                document.getElementById("txtRETM_REM").disabled    = false;
                document.getElementById("txtRETM_RNM").disabled    = false;
                document.getElementById("txtLSE_YY").disabled      = false;
                document.getElementById("txtLSE_MM").disabled      = false;
                document.getElementById("txtHIRR_YMD").disabled    = false;
                document.getElementById("txtMID_YMD1").disabled    = false;
                form1.medMRE_AMT.enable                            = true;
                document.getElementById("txtRAM_YMD").disabled     = false;
                document.getElementById("txtMID_YMD2").disabled    = false;
                form1.medMRE_AMT2.enable                           = true;
                document.getElementById("txtRAM_YMD2").disabled    = false;
                document.getElementById("txtMID_YMD3").disabled    = false;
                form1.medMRE_AMT3.enable                           = true;
                document.getElementById("txtRAM_YMD3").disabled    = false;
                document.getElementById("txtCOC_NAM").disabled     = false;
                document.getElementById("txtREMARK").disabled      = false;

                document.getElementById("ImgSpecCd").disabled      = false;
                document.getElementById("ImgWedYmd").disabled      = false;
                document.getElementById("ImgRelCd").disabled       = false;
                document.getElementById("ImgRetCd").disabled       = false;
                document.getElementById("ImgRetpYmd").disabled     = false;
                document.getElementById("ImgRetmCd").disabled      = false;
                document.getElementById("ImgRetmYmd").disabled     = false;
                document.getElementById("ImgRetmRem").disabled     = false;
                document.getElementById("ImgHirrYmd").disabled     = false;
                document.getElementById("ImgMidYmd1").disabled     = false;
                document.getElementById("ImgRamYmd").disabled      = false;
                document.getElementById("ImgMidYmd2").disabled     = false;
                document.getElementById("ImgRamYmd2").disabled     = false;
                document.getElementById("ImgMidYmd3").disabled     = false;
                document.getElementById("ImgRamYmd3").disabled     = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtHOBBY").disabled       = true;
                document.getElementById("txtSPEC_CD").disabled     = true;
                document.getElementById("txtPART_CD").disabled     = true;
                document.getElementById("txtWED_YMD").disabled     = true;
                document.getElementById("txtREL_CD").disabled      = true;
                document.getElementById("txtCOM_PHN_NO").disabled  = true;
                document.getElementById("txtREG_CD").disabled      = true;
                document.getElementById("txtRET_CD").disabled      = true;
                document.getElementById("txtRET_YMD").disabled     = true;
                document.getElementById("txtRETP_YMD").disabled    = true;
                document.getElementById("txtRETM_CD").disabled     = true;
                document.getElementById("txtRETM_YMD").disabled    = true;
                document.getElementById("txtRETM_REM").disabled    = true;
                document.getElementById("txtRETM_RNM").disabled    = true;
                document.getElementById("txtLSE_YY").disabled      = true;
                document.getElementById("txtLSE_MM").disabled      = true;
                document.getElementById("txtHIRR_YMD").disabled    = true;
                document.getElementById("txtMID_YMD1").disabled    = true;
                form1.medMRE_AMT.enable                            = false;
                document.getElementById("txtRAM_YMD").disabled     = true;
                document.getElementById("txtMID_YMD2").disabled    = true;
                form1.medMRE_AMT2.enable                           = false;
                document.getElementById("txtRAM_YMD2").disabled    = true;
                document.getElementById("txtMID_YMD3").disabled    = true;
                form1.medMRE_AMT3.enable                           = false;
                document.getElementById("txtRAM_YMD3").disabled    = true;
                document.getElementById("txtCOC_NAM").disabled     = true;
                document.getElementById("txtREMARK").disabled      = true;

                document.getElementById("ImgSpecCd").disabled      = true;
                document.getElementById("ImgWedYmd").disabled      = true;
                document.getElementById("ImgRelCd").disabled       = true;
                document.getElementById("ImgRetCd").disabled       = true;
                document.getElementById("ImgRetpYmd").disabled     = true;
                document.getElementById("ImgRetmCd").disabled      = true;
                document.getElementById("ImgRetmYmd").disabled     = true;
                document.getElementById("ImgRetmRem").disabled     = true;
                document.getElementById("ImgHirrYmd").disabled     = true;
                document.getElementById("ImgMidYmd1").disabled     = true;
                document.getElementById("ImgRamYmd").disabled      = true;
                document.getElementById("ImgMidYmd2").disabled     = true;
                document.getElementById("ImgRamYmd2").disabled     = true;
                document.getElementById("ImgMidYmd3").disabled     = true;
                document.getElementById("ImgRamYmd3").disabled     = true;

            }
        }

    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            document.getElementById("resultMessage").innerText = '';

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

          if (parent.savflag != '1') {
              parent.savflag = 1;
          }

    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<body onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�λ�⺻4</strong>
        </td>
        <td height="25" align="right">
            <input type=hidden id="ENO_NO" size="10">
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="74 "></col>
                    <col width="60 "></col>
                    <col width="120"></col>
                    <col width="60 "></col>
                    <col width="120"></col>
                    <col width="60 "></col>
                    <col width="120"></col>
                    <col width="60 "></col>
                    <col width="115"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">��Ÿ����</td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"><input id="txtHOBBY" maxlength="20" style="width:100%"></td>
                    <td align="center" class="blueBold">Ư&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423"> <input id="txtSPEC_CD"maxlength="20"  style="width:100%" >
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtPART_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('B1', 'txtPART_CD','txtPART_NM');" class="input_ReadOnly"  readonly> <input id="txtPART_NM" style="width:50%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�� ȥ ��</td>
                    <td class="padding2423">
                        <input id="txtWED_YMD" style="width:70%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��ȥ��');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgWedYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgWedYmd" name="ImgWedYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtWED_YMD','','600','55');"></a>
                    </td>

                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREL_CD" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('D2', 'txtREL_CD','txtREL_NM');"> <input id="txtREL_NM" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRelCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRelCd" name="ImgRelCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREL_CD','txtREL_NM','����','D2')"></a>
                    </td>
                    <td align="center" class="blueBold">ȸ����ȭ</td>
                    <td class="padding2423" ><input id="txtCOM_PHN_NO" style="width:100%;ime-mode:disabled"  maxlength="20" onKeyPress="JavaScript: cfCheckNumber();">  <!-- &nbsp;&nbsp;������ȣ <input id="txtCOM_PHN_IN" style="width:15%;ime-mode:disabled" maxlength="4" onKeyPress="JavaScript: cfNumberCheck();"> -->
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtREG_CD" size="3" maxlength="3" > <input id="txtREG_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSpecCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSpecCd" name="ImgReGCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtREG_CD','txtREG_NM','�ٹ�����','B3')"></a>
                    </td>
                </tr>
            </table>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="74 "></col>
                    <col width="91 "></col>
                    <col width="149"></col>
                    <col width="91 "></col>
                    <col width="149"></col>
                    <col width="91 "></col>
                    <col width="148"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" rowspan="7">�������</td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtRET_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '�����');"  onkeypress="cfDateHyphen(this);cfCheckNumber();" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">����������</td>
                    <td class="padding2423" >
                        <input id="txtRETP_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����ó��������');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetpYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRetpYmd" name="ImgRetpYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRETP_YMD','','370','103');"></a>
                    </td>
                    <td align="center" class="blueBold">�ټӱⰣ</td>
                    <td class="padding2423">
                        <input id="txtLSE_YY" size="4" maxlength="4" style="text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfNumberCheck();">�� <input id="txtLSE_MM" size="4" maxlength="4" style="text-align:right;ime-mode:disabled;" onKeyPress="JavaScript: cfNumberCheck();">����
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" colspan="5">
                        <input id="txtRET_CD" style="width:42" maxlength="5" onChange="fnc_GetCommNm('C2', 'txtRET_CD','txtRET_NM');"> <input id="txtRET_NM" style="width:120" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRetCd" name="ImgRetCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtRET_CD','txtRET_NM','��������','C2')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ġ</td>
                    <td class="padding2423">
                        <input id="txtRETM_CD" style="width:30%" maxlength="5" onChange="fnc_GetCommNm('CB', 'txtRETM_CD','txtRETM_NM');"> <input id="txtRETM_NM" style="width:45%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetmCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRetmCd" name="ImgRetmCd"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtRETM_CD','txtRETM_NM','�����ġ','CB')"></a>
                    </td>
                    <td align="center" class="blueBold">��ġ�ڻ��</td>
                    <td class="padding2423">
                        <input id="txtRETM_REM" maxlength="8" style="width:39%;ime-mode:disabled" onKeyPress="JavaScript: cfNumberCheck();"  onChange="fnc_GetEnoNm('txtRETM_REM','txtRETM_RNM','1');"> <input id="txtRETM_RNM" style="width:35%" onChange="fnc_GetEnoNo('txtRETM_RNM','txtRETM_REM')">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetmRem','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRetmRem" name="ImgRetmRem" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtRETM_REM','txtRETM_RNM', '1')"></a>
                    </td>
                    <td align="center" class="blueBold">�� ġ ��</td>
                    <td class="padding2423" >
                        <input id="txtRETM_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '��ġ��');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetmYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRetmYmd" name="ImgRetmYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRETM_YMD','','575','0');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="3">�������ߵ�<br>������</td>
                    <td class="padding2423" >
                        <input id="txtRAM_YMD" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '�������ߵ�������1');"  onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="fnc_ChangeDate();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRamYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRamYmd" name="ImgRamYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAM_YMD','','95','0');"></a>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="87%"">
                                    <comment id="__NSID__"><object id="medMRE_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            	value=2>
                                        <param name=Border               		value=true>
                                        <param name=ClipMode             	value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               		value=true>
                                        <param name=IsComma              	value=true>
                                        <param name=Language             	value=0>
                                        <param name=MaxLength            	value=12>
                                        <param name=Numeric              	value=true>
                                        <param name=ShowLiteral          	value="false">
                                        <param name=Visible              		value="true">
                                        <param name=SelectAll            		value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> ��
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtMID_YMD1" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '������1');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMidYmd1','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMidYmd1" name="ImgMidYmd1"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMID_YMD1','','575','0');"></a>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" >
                        <input id="txtRAM_YMD2" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '�������ߵ�������2');"  onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="fnc_ChangeDate();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRamYmd2','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRamYmd2" name="ImgRamYmd2"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAM_YMD2','','95','25');"></a>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="87%"">
                                    <comment id="__NSID__"><object id="medMRE_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            value=2>
                                        <param name=Border               value=true>
                                        <param name=ClipMode             value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=12>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                        <param name=SelectAll            value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> ��
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtMID_YMD2" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '������2');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMidYmd2','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMidYmd2" name="ImgMidYmd2"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMID_YMD2','','575','25');"></a>
                    </td>
                </tr>
                <tr>
                    <td class="padding2423" >
                        <input id="txtRAM_YMD3" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '�������ߵ�������3');"  onkeypress="cfDateHyphen(this);cfCheckNumber();" onblur="fnc_ChangeDate();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRamYmd3','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgRamYmd3" name="ImgRamYmd3"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtRAM_YMD3','','95','50');"></a>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td >
                        <table width="100%" border="0">
                            <tr>
                                <td align="left" width="87%"">
                                    <comment id="__NSID__"><object id="medMRE_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
                                        <param name=Alignment            value=2>
                                        <param name=Border               value=true>
                                        <param name=ClipMode             value=true>
                                        <param name=DisabledBackColor    value="#EEEEEE">
                                        <param name=Enable               value=true>
                                        <param name=IsComma              value=true>
                                        <param name=Language             value=0>
                                        <param name=MaxLength            value=12>
                                        <param name=Numeric              value=true>
                                        <param name=ShowLiteral          value="false">
                                        <param name=Visible              value="true">
                                        <param name=SelectAll            value="true">
                                    </object></comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                                <td align="left"> ��
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423" >
                        <input id="txtMID_YMD3" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '������3');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMidYmd3','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMidYmd3" name="ImgMidYmd3"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtMID_YMD3','','575','50');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ݱ�����</td>
                    <td class="padding2423" >
                        <input id="txtHIRR_YMD" style="width:78%;ime-mode:disabled" maxlength="10"  onChange="fnc_CheckDate(this, '�����ݱ�����');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirrYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHirrYmd" name="ImgHirrYmd"  width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRR_YMD','','335','105');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ó</td>
                    <td class="padding2423" >
                        <input id="txtCOC_NAM" style="width:100%">
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtREMARK" style="width:100%">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="988" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
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
<!-- �λ���ǥ ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C> Col=ENO_NO        Ctrl=ENO_NO            Param=value Disable=disabled</C>
        <C> Col=HOBBY         Ctrl=txtHOBBY          Param=value </C>
        <C> Col=SPEC_CD       Ctrl=txtSPEC_CD        Param=value </C>
        <C> Col=PART_CD       Ctrl=txtPART_CD        Param=value </C>
        <C> Col=PART_NM       Ctrl=txtPART_NM        Param=value </C>
        <C> Col=WED_YMD       Ctrl=txtWED_YMD        Param=value </C>
        <C> Col=REL_CD        Ctrl=txtREL_CD         Param=value </C>
        <C> Col=REL_NM        Ctrl=txtREL_NM         Param=value </C>
        <C> Col=COM_PHN_NO    Ctrl=txtCOM_PHN_NO     Param=value </C>
        <C> Col=RET_CD        Ctrl=txtRET_CD         Param=value </C>
        <C> Col=RET_NM        Ctrl=txtRET_NM         Param=value </C>
        <C> Col=REG_CD        Ctrl=txtREG_CD         Param=value </C>
        <C> Col=REG_NM        Ctrl=txtREG_NM         Param=value </C>
        <C> Col=RET_YMD       Ctrl=txtRET_YMD        Param=value </C>
        <C> Col=RETP_YMD      Ctrl=txtRETP_YMD       Param=value </C>
        <C> Col=LSE_YY        Ctrl=txtLSE_YY         Param=value </C>
        <C> Col=LSE_MM        Ctrl=txtLSE_MM         Param=value </C>
        <C> Col=RETM_CD       Ctrl=txtRETM_CD        Param=value </C>
        <C> Col=RETM_NM       Ctrl=txtRETM_NM        Param=value </C>
        <C> Col=RETM_REM      Ctrl=txtRETM_REM       Param=value </C>
        <C> Col=RETM_RNM      Ctrl=txtRETM_RNM       Param=value </C>
        <C> Col=RETM_YMD      Ctrl=txtRETM_YMD       Param=value </C>
        <C> Col=HIRR_YMD      Ctrl=txtHIRR_YMD       Param=value </C>
        <C> Col=MID_YMD1      Ctrl=txtMID_YMD1       Param=value </C>
        <C> Col=MRE_AMT       Ctrl=medMRE_AMT        Param=text  </C>
        <C> Col=RAM_YMD       Ctrl=txtRAM_YMD        Param=value </C>
        <C> Col=MID_YMD2      Ctrl=txtMID_YMD2       Param=value </C>
        <C> Col=MRE_AMT2      Ctrl=medMRE_AMT2       Param=text  </C>
        <C> Col=RAM_YMD2      Ctrl=txtRAM_YMD2       Param=value </C>
        <C> Col=MID_YMD3      Ctrl=txtMID_YMD3       Param=value </C>
        <C> Col=MRE_AMT3      Ctrl=medMRE_AMT3       Param=text  </C>
        <C> Col=RAM_YMD3      Ctrl=txtRAM_YMD3       Param=value </C>
        <C> Col=COC_NAM       Ctrl=txtCOC_NAM        Param=value </C>
        <C> Col=REMARK        Ctrl=txtREMARK         Param=value </C>
    '>
</object>
