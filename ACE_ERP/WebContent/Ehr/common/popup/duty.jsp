<!--
***********************************************************************
* @source      : duty.jsp
* @description : �������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
***********************************************************************
-->


<%@ page contentType="text/html;charset=euc-kr"%>

<html>

    <head>
	<title>��������(duty)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <link href="../../css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="../../common/common.js"></script>
    <script language=javascript src="../../common/mdi_common.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>
	<base target="_self">

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		 var reObj = window.dialogArguments;

		reObj.duty_cd = "";
		reObj.duty_nm = "";
		reObj.sec_nm = "";
		reObj.thr_nm = "";
		

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

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

            // �ش� Dataset�� Header�� ������ Header ����

            // AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            // �ƹ��͵� ���� ���¿��� �߰� �ϰ� �Ǹ� ó���� AddNew�ϰ� ���� ���� InsertRow��

            // Pow Append �� Grid�� Append�� Row�� Ư�� Column���� �̵��ϴ°�

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)

            // ���� �� �ش� �׸���� Focus �̵�

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//Ʈ�� ��ȸ�� ���� VLUF010CMD�� ���
			dsT_CM_DUTYMST.DataId="../../../servlet/GauceChannelSVL?cmd=Ehr.cod.f.codf010.cmd.CODF010CMD&S_MODE=SHR";
			dsT_CM_DUTYMST.Reset();

        }
        
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
    | 1. Ʈ�������� DataSet                                               |
    | 2. �̸� : dsT_CM_DUTYMST                                            |
    | 3. Table List : T_CM_DUTYMST                                       |
    +----------------------------------------------->
    <Object ID="dsT_CM_DUTYMST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


	<!-----------------------------------------+
    | TreeView�� �ִ� Item�� Double Click�Ҷ�  |
    +------------------------------------------>
	<script language=JavaScript for=tvT_CM_DUTYMST event=OnDblClick()>

		var downduty_cd = dsT_CM_DUTYMST.NameValue(dsT_CM_DUTYMST.RowPosition,"DOWNDUTY_CD");
		if (downduty_cd != 1) return false;

		var row = dsT_CM_DUTYMST.NameValueRow("DUTY_NM",tvT_CM_DUTYMST.ItemText);
		var reObj = window.dialogArguments;

		reObj.duty_cd = dsT_CM_DUTYMST.NameValue(row,"DUTY_CD");
		reObj.duty_nm = dsT_CM_DUTYMST.NameValue(row,"DUTY_NM");
		reObj.sec_nm = dsT_CM_DUTYMST.NameValue(row,"UPDUTY_NM");
		reObj.thr_nm = dsT_CM_DUTYMST.NameValue(row,"HIGHDUTY_NM");
		window.close();

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
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="25" background="../../images/common/barBg.gif">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
	                    <td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">���� ����</td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>&nbsp;&nbsp;&nbsp;&nbsp;
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<!-- power Search���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table border="0" cellspacing="0" cellpadding="0">
					<tr align="center">
						<td>
							<comment id="__NSID__">
							<object id="tvT_CM_DUTYMST" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
								<param name=DataID		value="dsT_CM_DUTYMST">
								<param name=TextColumn	value="DUTY_NM">
								<param name=LevelColumn	value="DUTY_LBL">
								<param name=ExpandLevel	value="1">
								<param name=BorderStyle  value="4">
								<param name=UseImage      value="false">
								<param name=ExpandOneClick      value="true">

								<!-- <param name=UseImage		value="true">
								<param name=ImgDataID		value="idsT_CM_DUTYMST">
								<param name=ImgCColumn	value="ImgC">
								<param name=ImgDColumn	value="ImgD">
								<param name=ImgOColumn	value="ImgO"> -->
							</object>
							</comment><script> __ShowEmbedObject(__NSID__); </script>
						</td>
					</tr>
				</table>
	        </td>
	    </tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="320" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState">* �ش� ������ ����Ŭ�� �Ͻø� ���õ˴ϴ�.</span></td>
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