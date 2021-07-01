<!--
    ************************************************************************************
    * @Source         : edue051.jsp                                                    *
    * @Description    : �������� PAGE                                                  *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
     *-------------+-----------+--------------------------------------------------------+
    * 2016/05/20  |  ������   | �ҽ�����                                               *                         *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>��������</title>
    <jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'FFFFFFFT';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_ED_COURSELIST.ClearData();
            dsT_ED_COURSELIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue051.cmd.EDUE051CMD&S_MODE=SHR&EDU_CD="+opener.edu_cd+"&SEQ_NO="+opener.seq_no;
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

            document.getElementById("txtEDU_CD").innerText = opener.edu_cd;

            // �׸��忡 ���κ������򰡴���ڼ��� ������ ��ȸ
            fnc_SearchList();

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

		// Link
		function fnc_SiteTag(){
			var siteTag = document.getElementById("txtSITE_TAG").value;
			if(siteTag == "" || siteTag == "��� �ȵ�"){
				return;
			}
			window.open('http://'+siteTag,'imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
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

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

//            document.getElementById("txtENO_NO").innerText      = 'hlc'+dsT_ED_COURSELIST.NameValue(1, "ENO_NO");
            document.getElementById("txtENO_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "ENO_NM");
            document.getElementById("txtEDU_CD").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_CD");
            document.getElementById("txtEDU_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "EDU_NM");
            document.getElementById("txtEDU_GBN_NM").innerText  = dsT_ED_COURSELIST.NameValue(1, "EDU_GBN_NM");
            document.getElementById("txtMNGER_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "MNGER_NM");
            document.getElementById("txtFIELD_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "FIELD_NM");
            document.getElementById("txtSHAPE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "SHAPE_NM");
            document.getElementById("txtGOAL_TAG").innerText    = dsT_ED_COURSELIST.NameValue(1, "GOAL_TAG");
            document.getElementById("txtCONTENT_TXT").innerText = dsT_ED_COURSELIST.NameValue(1, "CONTENT_TXT");
            document.getElementById("txtEFFECT_TAG").innerText  = dsT_ED_COURSELIST.NameValue(1, "EFFECT_TAG");
            document.getElementById("txtOBJ_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "OBJ_TAG");
            document.getElementById("txtCPT_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_TAG");
            document.getElementById("txtINT_NAM").innerText     = dsT_ED_COURSELIST.NameValue(1, "INT_NAM");
            document.getElementById("txtFIX_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "FIX_NO");
            document.getElementById("txtDAY_NO").innerText      = dsT_ED_COURSELIST.NameValue(1, "DAY_NO");
            document.getElementById("txtTIME_NO").innerText     = dsT_ED_COURSELIST.NameValue(1, "TIME_NO");
            document.getElementById("txtCOST_AMT").innerText    = dsT_ED_COURSELIST.NameValue(1, "COST_AMT");
            document.getElementById("txtCOST_NM").innerText     = dsT_ED_COURSELIST.NameValue(1, "COST_NM");
            document.getElementById("txtINS_NM").innerText      = dsT_ED_COURSELIST.NameValue(1, "INS_NM");
            document.getElementById("txtRTN_AMT").innerText     = dsT_ED_COURSELIST.NameValue(1, "RTN_AMT");
            document.getElementById("txtPLACE_NM").innerText    = dsT_ED_COURSELIST.NameValue(1, "PLACE_NM");
            document.getElementById("txtCPT_PNT").innerText     = dsT_ED_COURSELIST.NameValue(1, "CPT_PNT");
            document.getElementById("txtSITE_TAG").innerText     = dsT_ED_COURSELIST.NameValue(1, "SITE_TAG");
            document.getElementById("txtENT_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "ENT_TERM");
            document.getElementById("txtEDU_TERM").innerText    = dsT_ED_COURSELIST.NameValue(1, "EDU_TERM");

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

        opener.fnc_SearchList();
        window.close();

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
        <td height="25" background="../../images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">��������</td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->



<!-- ��ȸ ���� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

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
                    <td align="center" class="blueBold">���������</td>
                    <td class="padding2423" >
                        <span id="txtENO_NM" name="txtENO_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">�����ڵ�</td>
                    <td class="padding2423" >
                        <span id="txtEDU_CD" name="txtEDU_CD" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">������</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtEDU_NM" name="txtEDU_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <span id="txtEDU_GBN_NM" name="txtEDU_GBN_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">�����ְ�</td>
                    <td class="padding2423" >
                        <span id="txtMNGER_NM" name="txtMNGER_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����о�</td>
                    <td class="padding2423" >
                        <span id="txtFIELD_NM" name="txtFIELD_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <span id="txtSHAPE_NM" name="txtSHAPE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">������ǥ</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtGOAL_TAG" name="txtGOAL_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��û�Ⱓ</td>
                    <td class="padding2423" >
                        <span id="txtENT_TERM" name="txtENT_TERM" ></span>
                    </td>
                    <td align="center" class="blueBold">�����Ⱓ</td>
                    <td class="padding2423" >
                        <span id="txtEDU_TERM" name="txtEDU_TERM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" colspan="3" >
                        <textarea id="txtCONTENT_TXT"  name="txtCONTENT_TXT" cols="112" rows="10" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">���ȿ��</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtEFFECT_TAG" name="txtEFFECT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtOBJ_TAG" name="txtOBJ_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtCPT_TAG" name="txtCPT_TAG" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" colspan="3">
                        <span id="txtINT_NAM" name="txtINT_NAM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423" >
                        <span id="txtFIX_NO" name="txtFIX_NO" ></span>&nbsp;��
                    </td>
                    <td align="center" class="blueBold">�����ð�</td>
                    <td class="padding2423" >
                        <span id="txtTIME_NO" name="txtTIME_NO" ></span>&nbsp;�ð�
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�����ϼ�</td>
                    <td class="padding2423" >
                        <span id="txtDAY_NO" name="txtDAY_NO" ></span>&nbsp;��
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <span id="txtCOST_AMT" name="txtCOST_AMT" ></span>&nbsp;��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">���δ�</td>
                    <td class="padding2423" >
                        <span id="txtCOST_NM" name="txtCOST_NM" ></span>
                    </td>
                    <td align="center" class="blueBold">��뺸��</td>
                    <td class="padding2423" >
                        <span id="txtINS_NM" name="txtINS_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">ȯ�ޱݾ�</td>
                    <td class="padding2423" >
                        <span id="txtRTN_AMT" name="txtRTN_AMT" ></span>&nbsp;��
                    </td>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423" >
                        <span id="txtPLACE_NM" name="txtPLACE_NM" ></span>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�̼�����</td>
                    <td class="padding2423" >
                        <span id="txtCPT_PNT" name="txtCPT_PNT" ></span>&nbsp;��
                    </td>
                    <td align="center" class="blueBold">�������Ʈ</td>
                    <td class="padding2423" >
                        http://<input id="txtSITE_TAG"  name="txtSITE_TAG" size="28" maxlength="300" >&nbsp;<input type="button" value="����" size="6" align="right" onClick="fnc_SiteTag()">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form �� -->

</body>
</html>