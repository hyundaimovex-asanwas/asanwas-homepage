<!--
    ************************************************************************************
    * @Source         : pira015.jsp                                                    		*
    * @Description    : �λ�⺻5 PAGE                                                 		*
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
<title>�λ�⺻5</title>
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

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira015.cmd.PIRA015CMD&S_MODE=SHR&ENO_NO="+form1.ENO_NO.value;
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
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira015.cmd.PIRA015CMD&S_MODE=SAV";
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

            // ������
            if (document.getElementById("txtGET_RSN").value != "" && document.getElementById("txtGET_NM").value == "") {
            	
                alert("�������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtGET_RSN").focus();
                
                return false;
                
            }

            // ä����
            if (document.getElementById("txtHIR_PATH").value != "" && document.getElementById("txtHIR_NM").value == "") {
            	
                alert("ä�����ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtHIR_PATH").focus();
                
                return false;
                
            }

            // ���������� CHECK
            if (!fnc_CheckDate(document.getElementById("txtSAN_YMD"), "����") && document.getElementById("txtSAN_YMD").value != "") {
            	
                document.getElementById("txtSAN_YMD").focus();
                
                return false;
                
            }


            // �������
            if (document.getElementById("txtHDC_CD").value != "" && document.getElementById("txtHDC_NM").value == "") {
            	
                alert("��������ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtHDC_CD").focus();
                
                return false;
                
            }

            // ��ֵ��
            if (document.getElementById("txtHDC_GRA").value != "" && document.getElementById("txtHDC_GNM").value == "") {
            	
                alert("��ֵ���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtHDC_GRA").focus();
                
                return false;
                
            }

            if (document.getElementById("txtMPVA_CD").value != "" && document.getElementById("txtMPVA_NM").value == "") {
            	
                alert("ä�뱸���ڵ忡 �Է��Ͻ� ���� �������� �ʴ� �ڵ��Դϴ�. Ȯ�ιٶ��ϴ�.");
                
                document.getElementById("txtMPVA_CD").focus();
                
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

        /***************************************
         * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // �ش� �÷��� �Ӽ��� Enabled�� ����
            if (prop == 'E') {

                document.getElementById("txtGET_RSN").disabled  = false;
                document.getElementById("txtHIR_PATH").disabled = false;
                document.getElementById("txtSAN_YMD").disabled  = false;
                document.getElementById("txtSAN_NAM").disabled  = false;
                document.getElementById("txtHDC_CD").disabled   = false;
                document.getElementById("txtHDC_GRA").disabled  = false;
                document.getElementById("txtSAN_HIS").disabled  = false;
                document.getElementById("txtSAN_REM").disabled  = false;
                document.getElementById("txtJAN_YMD").disabled  = false;
                document.getElementById("txtJHDC_CD").disabled  = false;
                document.getElementById("txtJHDC_NM").disabled  = false;
                document.getElementById("txtJHDC_GRA").disabled = false;
                document.getElementById("txtJHDC_GNM").disabled = false;
                document.getElementById("txtSER_STS").disabled  = false;
                document.getElementById("txtSER_SNM").disabled  = false;
                document.getElementById("txtJOB_OCC").disabled  = false;
                document.getElementById("txtJOB_ONM").disabled  = false;
                document.getElementById("txtMPVA_CD").disabled  = false;
                document.getElementById("txtMPVA_NM").disabled  = false;

                document.getElementById("ImgGetRsn").disabled   = false;
                document.getElementById("ImgHirPath").disabled  = false;
                document.getElementById("ImgSanYmd").disabled   = false;
                document.getElementById("ImgHdcCd").disabled    = false;
                document.getElementById("ImgHdcGra").disabled   = false;
                document.getElementById("ImgJanYmd").disabled   = false;
                document.getElementById("ImgTrgCd").disabled    = false;
                document.getElementById("ImgJHdcCd").disabled   = false;
                document.getElementById("ImgJHdcGra").disabled  = false;
                document.getElementById("ImgSerSts").disabled   = false;
                document.getElementById("ImgJobOcc").disabled   = false;
                document.getElementById("ImgMpvaCd").disabled   = false;

            }
            else if (prop == 'D') {

                document.getElementById("txtGET_RSN").disabled  = true;
                document.getElementById("txtHIR_PATH").disabled = true;
                document.getElementById("txtSAN_YMD").disabled  = true;
                document.getElementById("txtSAN_NAM").disabled  = true;
                document.getElementById("txtHDC_CD").disabled   = true;
                document.getElementById("txtHDC_GRA").disabled  = true;
                document.getElementById("txtSAN_HIS").disabled  = true;
                document.getElementById("txtSAN_REM").disabled  = true;
                document.getElementById("txtJAN_YMD").disabled  = true;
                document.getElementById("txtJHDC_CD").disabled  = true;
                document.getElementById("txtJHDC_NM").disabled  = true;
                document.getElementById("txtJHDC_GRA").disabled = true;
                document.getElementById("txtJHDC_GNM").disabled = true;
                document.getElementById("txtSER_STS").disabled  = true;
                document.getElementById("txtSER_SNM").disabled  = true;
                document.getElementById("txtJOB_OCC").disabled  = true;
                document.getElementById("txtJOB_ONM").disabled  = true;
                document.getElementById("txtMPVA_CD").disabled  = true;
                document.getElementById("txtMPVA_NM").disabled  = true;

                document.getElementById("ImgGetRsn").disabled   = true;
                document.getElementById("ImgHirPath").disabled  = true;
                document.getElementById("ImgSanYmd").disabled   = true;
                document.getElementById("ImgHdcCd").disabled    = true;
                document.getElementById("ImgHdcGra").disabled   = true;
                document.getElementById("ImgJanYmd").disabled   = true;
                document.getElementById("ImgTrgCd").disabled    = true;
                document.getElementById("ImgJHdcCd").disabled   = true;
                document.getElementById("ImgJHdcGra").disabled  = true;
                document.getElementById("ImgSerSts").disabled   = true;
                document.getElementById("ImgJobOcc").disabled   = true;
                document.getElementById("ImgMpvaCd").disabled   = true;

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

            //fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);
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
            <strong>�λ�⺻5</strong>
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
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="60 "></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                    <col width="60 "></col>
                    <col width="150"></col>
                </colgroup>
                <tr>
                    <td align="center" class="blueBold">��뺸��</td>
                    <td align="center" class="blueBold">������</td>
                    <td class="padding2423">
                        <input id="txtGET_RSN" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C4', 'txtGET_RSN','txtGET_NM');"> <input id="txtGET_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgGetRsn','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgGetRsn" name="ImgGetRsn" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtGET_RSN','txtGET_NM','������','C4')"></a>
                    </td>
                    <td align="center" class="blueBold">ä����</td>
                    <td class="padding2423">
                        <input id="txtHIR_PATH" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C5', 'txtHIR_PATH','txtHIR_NM');"> <input id="txtHIR_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirPath','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHirPath" name="ImgHirPath" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtHIR_PATH','txtHIR_NM','ä����','C5')"></a>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">������</td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtSAN_YMD" style="width:65%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSanYmd" name="ImgSanYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtSAN_YMD','','155','80');"></a>
                    </td>
                    <td align="center" class="blueBold">�� �� ��</td>
                    <td class="padding2423">
                        <input id="txtSAN_NAM" style="width:100%" maxlength="30">
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtHDC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C6', 'txtHDC_CD','txtHDC_NM');"> <input id="txtHDC_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHdcCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHdcCd" name="ImgHdcCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtHDC_CD','txtHDC_NM','�������','C6')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��ֵ��</td>
                    <td class="padding2423">
                        <input id="txtHDC_GRA" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('C7', 'txtHDC_GRA','txtHDC_GNM');"> <input id="txtHDC_GNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHdcGra','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgHdcGra" name="ImgHdcGra" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHDC_GRA','txtHDC_GNM','��ֵ��','C7')"></a>
                    </td>
                    <td align="center" class="blueBold">���ź���</td>
                    <td class="padding2423" >
                        <input id="txtSAN_HIS" style="width:100%" maxlength="30">
                    </td>
                    <td align="center" class="blueBold">�߻�����</td>
                    <td class="padding2423" >
                        <input id="txtSAN_REM" style="width:100%" maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="2">��ֻ���</td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtJAN_YMD" style="width:65%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '����');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJanYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJanYmd" name="ImgJanYmd" width="21" height="20" border="0" align="absmiddle"  onclick="calendarBtn('datetype1','txtJAN_YMD','','155','80');"></a>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtTRG_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SA', 'txtTRG_CD','txtTRG_NM');"> <input id="txtTRG_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTrgCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgTrgCd" name="ImgTrgCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtTRG_CD','txtTRG_NM','�����������','SA')"></a>
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtJHDC_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SB', 'txtJHDC_CD','txtJHDC_NM');"> <input id="txtJHDC_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJHdcCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJHdcCd" name="ImgJHdcCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtJHDC_CD','txtJHDC_NM','�������','SB')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��ֵ��</td>
                    <td class="padding2423">
                        <input id="txtJHDC_GRA" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SE', 'txtJHDC_GRA','txtJHDC_GNM');"> <input id="txtJHDC_GNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJHdcGra','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJHdcGra" name="ImgJHdcGra" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJHDC_GRA','txtJHDC_GNM','��ֵ��','SE')"></a>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtSER_STS" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SC', 'txtSER_STS','txtSER_SNM');"> <input id="txtSER_SNM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSerSts','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgSerSts" name="ImgSerSts" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSER_STS','txtSER_SNM','��������','SC')"></a>
                    </td>
                    <td align="center" class="blueBold">�ٷ�����</td>
                    <td class="padding2423">
                        <input id="txtJOB_OCC" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SD', 'txtJOB_OCC','txtJOB_ONM');"> <input id="txtJOB_ONM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJobOcc','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgJobOcc" name="ImgJobOcc" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtJOB_OCC','txtJOB_ONM','�ٷ�����','SD')"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">���ƻ���</td>
                    <td align="center" class="blueBold">ä�뱸��</td>
                    <td class="padding2423">
                        <input id="txtMPVA_CD" style="width:15%" maxlength="2" onChange="fnc_GetCommNm('SH', 'txtMPVA_CD','txtMPVA_NM');"> <input id="txtMPVA_NM" style="width:65%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgMpvaCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgMpvaCd" name="imgMpvaCd" width="21" height="20" border="0" align="absmiddle"  onClick="fnc_commonCodePopup('txtMPVA_CD','txtMPVA_NM','ä�뱸��','SH')"></a>
                    </td>
                    <td colspan="2"></td>
                </tr>
                <tr>
                    <td align="center" class="blueBold" rowspan="3">�系Ȱ��</td>
                    <td align="center" class="blueBold">�系Ȱ��1</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD1" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD1','txtCLU_NM1');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM1" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�系Ȱ��2</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD2" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD2','txtCLU_NM2');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM2" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�系Ȱ��3</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD3" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD3','txtCLU_NM3');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM3" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�系Ȱ��4</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD4" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD4','txtCLU_NM4');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM4" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�系Ȱ��5</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD5" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD5','txtCLU_NM5');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM5" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">�系Ȱ��6</td>
                    <td class="padding2423">
                        <input id="txtCLU_CD6" style="width:20%" maxlength="2" onChange="fnc_GetCommNm('H6', 'txtCLU_CD6','txtCLU_NM6');" class="input_ReadOnly"  readonly> <input id="txtCLU_NM6" style="width:75%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="788" border="0" cellspacing="0" cellpadding="0">
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
        <C> Col=ENO_NO        Ctrl=ENO_NO          Param=value Disable=disabled</C>
        <C> Col=GET_RSN       Ctrl=txtGET_RSN      Param=value </C>
        <C> Col=GET_NM        Ctrl=txtGET_NM       Param=value </C>
        <C> Col=HIR_PATH      Ctrl=txtHIR_PATH     Param=value </C>
        <C> Col=HIR_NM        Ctrl=txtHIR_NM       Param=value </C>
        <C> Col=SAN_YMD       Ctrl=txtSAN_YMD      Param=value </C>
        <C> Col=SAN_NAM       Ctrl=txtSAN_NAM      Param=value </C>
        <C> Col=HDC_CD        Ctrl=txtHDC_CD       Param=value </C>
        <C> Col=HDC_NM        Ctrl=txtHDC_NM       Param=value </C>
        <C> Col=HDC_GRA       Ctrl=txtHDC_GRA      Param=value </C>
        <C> Col=HDC_GNM       Ctrl=txtHDC_GNM      Param=value </C>
        <C> Col=SAN_HIS       Ctrl=txtSAN_HIS      Param=value </C>
        <C> Col=SAN_REM       Ctrl=txtSAN_REM      Param=value </C>
        <C> Col=JAN_YMD       Ctrl=txtJAN_YMD      Param=value </C>
        <C> Col=TRG_CD        Ctrl=txtTRG_CD       Param=value </C>
        <C> Col=TRG_NM        Ctrl=txtTRG_NM       Param=value </C>
        <C> Col=JHDC_CD       Ctrl=txtJHDC_CD      Param=value </C>
        <C> Col=JHDC_NM       Ctrl=txtJHDC_NM      Param=value </C>
        <C> Col=JHDC_GRA      Ctrl=txtJHDC_GRA     Param=value </C>
        <C> Col=JHDC_GNM      Ctrl=txtJHDC_GNM     Param=value </C>
        <C> Col=SER_STS       Ctrl=txtSER_STS      Param=value </C>
        <C> Col=SER_SNM       Ctrl=txtSER_SNM      Param=value </C>
        <C> Col=JOB_OCC       Ctrl=txtJOB_OCC      Param=value </C>
        <C> Col=JOB_ONM       Ctrl=txtJOB_ONM      Param=value </C>
        <C> Col=MPVA_CD       Ctrl=txtMPVA_CD      Param=value </C>
        <C> Col=MPVA_NM       Ctrl=txtMPVA_NM      Param=value </C>
        <C> Col=CLU_CD1       Ctrl=txtCLU_CD1      Param=value </C>
        <C> Col=CLU_NM1       Ctrl=txtCLU_NM1      Param=value </C>
        <C> Col=CLU_CD2       Ctrl=txtCLU_CD2      Param=value </C>
        <C> Col=CLU_NM2       Ctrl=txtCLU_NM2      Param=value </C>
        <C> Col=CLU_CD3       Ctrl=txtCLU_CD3      Param=value </C>
        <C> Col=CLU_NM3       Ctrl=txtCLU_NM3      Param=value </C>
        <C> Col=CLU_CD4       Ctrl=txtCLU_CD4      Param=value </C>
        <C> Col=CLU_NM4       Ctrl=txtCLU_NM4      Param=value </C>
        <C> Col=CLU_CD5       Ctrl=txtCLU_CD5      Param=value </C>
        <C> Col=CLU_NM5       Ctrl=txtCLU_NM5      Param=value </C>
        <C> Col=CLU_CD6       Ctrl=txtCLU_CD6      Param=value </C>
        <C> Col=CLU_NM6       Ctrl=txtCLU_NM6      Param=value </C>
    '>
</object>