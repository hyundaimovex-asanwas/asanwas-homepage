<!--
***********************************************************************
* @source      : graa020.jsp
* @description : �±޴���ڼ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/15      ���뼺        �����ۼ�.
* 2007/04/26      ����ȣ        �۾��α� ó��
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>

<html>

	<head>
	<title>�±޴���ڼ���(graa020)</title>
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

        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "F"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var rai_ymd = getToday().substring(0,4)+"-03-01";
        //var pas_ymd = (getToday().substring(0,4)-1)+"-03-01";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var rai_ymd = document.getElementById("txtRAI_YMD_SHR").value;

            //Ʈ����� ����
	        trT_PM_GRADE_SHR.KeyValue = "tr(O:dsT_PM_GRADE=dsT_PM_GRADE, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_GRADE_SHR.Action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa020.cmd.GRAA020CMD&S_MODE=SHR&RAI_YMD="+rai_ymd;
            trT_PM_GRADE_SHR.Post();

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
            var oRAI_YMD = document.getElementById("txtRAI_YMD_SHR");   //�±� ������

            if(!fnc_SaveItemCheck()) return;

            if(!confirm("�±޴���� ������ �Ͻðڽ��ϱ�?")){
                return false;
            }

            dsT_PM_GRADE.UseChangeInfo = "false";

			//Ʈ����� ����
            trT_PM_GRADE_SAV.KeyValue = "tr01(I:dsT_PM_GRADE=dsT_PM_GRADE, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trT_PM_GRADE_SAV.Action = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa020.cmd.GRAA020CMD&S_MODE=SAV&RAI_YMD="+oRAI_YMD.value;
			trT_PM_GRADE_SAV.Post();
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

            // ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�

            // �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

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

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //document.getElementById("txtRAI_YMD_SHR").value = rai_ymd;
            //document.getElementById("txtPAS_YMD_SHR").value = pas_ymd;
            document.form1.txtPRO_CNT.value     = "";
            document.form1.txtTRG_CNT.value     = "";
            document.form1.txtERR_CNT.value     = "";
            document.form1.txtPRO_STS_MSG.value = "";
            document.getElementById("resultMessage").innerText = ' ';

            dsT_PM_GRADE.ClearData();
            dsT_CP_WORKLOG.ClearData();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            if( document.getElementById("txtRAI_YMD_SHR").value == '') {
				alert("�±����ڴ� �ʼ��Է»����Դϴ�.");
				document.getElementById("txtRAI_YMD_SHR").focus();
				return false;
			}

			/*
            if( document.getElementById("txtPAS_YMD_SHR").value == '') {
				alert("������������ �ʼ��Է»����Դϴ�.");
				document.getElementById("txtPAS_YMD_SHR").focus();
				return false;
			}
			*/

            if ( dsT_PM_GRADE.CountRow < 1 ) {
				alert("������ �±� ����ڰ� �����ϴ�.");
                return false;
			}

            if(dsT_CP_WORKLOG.CountRow == 1) {
                alert("�ش�⵵�� �±޴���� ó���� �̹� �̷�������ϴ�.");
                return false;
            }
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtRAI_YMD_SHR").value = rai_ymd;
            //document.getElementById("txtPAS_YMD_SHR").value = pas_ymd;

        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        /********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_GRADE)     |
    | 3. ���Ǵ� Table List(T_PM_GRADE)            |
    +----------------------------------------------->
    <Object ID="dsT_PM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)      |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)             |
    +----------------------------------------------->
    <Object ID ="trT_PM_GRADE_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <Object ID ="trT_PM_GRADE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut value=2000000>
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_PM_GRADE Event="OnLoadCompleted(iCount)">

    </Script>

    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_GRADE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_PM_GRADE_SHR event="OnSuccess()">

        if (dsT_PM_GRADE.CountRow == 0) {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� �±޴���ڰ� �����ϴ�.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            document.getElementById("txtTRG_CNT").value = dsT_PM_GRADE.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";

        } else if(dsT_CP_WORKLOG.CountRow == 1) {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� �±޴���� ������ �Ϸ��Ͽ����ϴ�.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_GRADE.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT")+dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

        } else {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� �±޴���� ������ �����մϴ�.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_GRADE.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_PM_GRADE.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
        }

    </script>

    <script for=trT_PM_GRADE_SAV event="OnSuccess()">
        if(dsT_CP_WORKLOG.CountRow == 1){ // ����
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");

            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� �±޴���� ������ �Ϸ��Ͽ����ϴ�..';
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

        }else{// ��ȸ
            alert("�±޴���� ������ �����Ͽ����ϴ�.");
            document.getElementById("resultMessage").innerText = ' ';
        }
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_PM_GRADE_SHR event="OnFail()">
        alert(trT_PM_GRADE_SHR.ErrorMsg);
    </script>

    <script for=trT_PM_GRADE_SAV event="OnFail()">
        alert(trT_PM_GRADE_SAV.ErrorMsg);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
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
						<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�±޴���ڼ���</td>
						<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">�±޴���ڼ���</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                        <colgroup>
                            <!-- <col width="100"></col> -->
                            <col width="80"></col>
                            <col width="130"></col>
                            <col width="80"></col>
                            <col width=""></col>
                        </colgroup>
                        <tr>
                            <!-- <td align="right" class="searchState">����ڼ���&nbsp;</td>  -->
                            <td class="searchState"align="right">�±�����</td>
                            <td class="padding2423" align="left">
	                            <input id=txtRAI_YMD_SHR name=txtRAI_YMD_SHR value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeyup="cfDateHyphen(this);" onkeypress="cfCheckNumber();" valid='key=true' field='��������'>
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtRAI_YMD_SHR','','60','110');"><img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle"></a>
                            </td>
                            <td class="searchState"align="right"><!-- ���������� --></td>
                            <td class="padding2423" align="left">
                                <!--
	                            <input id=txtPAS_YMD_SHR name=txtPAS_YMD_SHR value="" size="10" maxlength=10 style="ime-mode:disabled;text-align:center;" class="divInput" onblur="cfCheckDate(this);" onkeyup="cfDateHyphen(this);" onkeypress="cfCheckNumber();" valid='key=true' field='��������'>
	                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtPAS_YMD_SHR','','425','145');"><img src="/images/button/btn_HelpOn.gif" name="Image11" width="21" height="20" border="0" align="absmiddle"></a>
	                            -->
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

	<!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <col width="70"></col>
                <col width=""></col>
                <tr>
                    <td align="center" class="creamBold">����ο�</td>
                    <td class="padding2423" align="left">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        �±޴���ο�&nbsp;<input id="txtTRG_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        �±��ο�&nbsp;<input id="txtPRO_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        �±�����&nbsp;<input id="txtERR_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�۾���Ȳ</td>
                    <td  class="padding2423" colspan="2">
                        <input id="txtPRO_STS_MSG" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
	<!-- ���� �Է� ���̺� �� -->

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

	</form>
	<!-- form �� -->

</body>
</html>