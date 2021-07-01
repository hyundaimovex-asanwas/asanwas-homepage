<!--
    ************************************************************************************
    * @source        : code061.jsp 				                                                                                *
    * @description   : ��Ÿ���� PAGE.                                                                    						*
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                 *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/01/22      �̵���        �����ۼ�.
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>��Ÿ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
 <link href="../../common/css/style.css" rel="stylesheet" type="text/css">
 <link href="../../common/css/general.css" rel="stylesheet" type="text/css">

 <script language=javascript src="../../common/common.js"></script>
 <script language=javascript src="../../common/result.js"></script>
 <script language=javascript src="../../common/input.js"></script>
 <script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

        var dsT_CP_PAYMASTER = window.dialogArguments;//opener���� �޾ƿ´�.

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {
        	
			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");
			
			var PIS_YY = dsT_CP_PAYMASTER.NameValue(1,"PIS_YY");
			
			var PIS_MM = dsT_CP_PAYMASTER.NameValue(1,"PIS_MM");
			
			var ENO_NO = dsT_CP_PAYMASTER.NameValue(1,"ENO_NO");
			
			var SAL_GBN = dsT_CP_PAYMASTER.NameValue(1,"SAL_GBN");
			
			var SEQ = dsT_CP_PAYMASTER.NameValue(1,"SEQ");

			if(kind == "1"){
				
				dsT_CP_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code061.cmd.CODE061CMD&S_MODE=SHR_01&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&ENO_NO="+ENO_NO+"&SAL_GBN="+SAL_GBN+"&SEQ="+SEQ;
    			dsT_CP_CHANGE.reset();

			}else{
				
				dsT_CP_CHANGE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code061.cmd.CODE061CMD&S_MODE=SHR_02&PIS_YY="+PIS_YY+"&PIS_MM="+PIS_MM+"&ENO_NO="+ENO_NO+"&SAL_GBN="+SAL_GBN+"&SEQ="+SEQ;
    			dsT_CP_CHANGE.reset();

			}

        }

   		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

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

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

        }

         /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

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

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_CP_CHANGE.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

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

            fnc_ChangeGrid();

            fnc_ChangeTitle();

			fnc_SearchList();

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}


        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid() {

			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");


			if(kind == "1"){
                form1.grdT_CP_CHANGE.format = "<C> id='{CUROW}'	     width=39	name='NO'		  	    align=center  value={String(Currow)}  </C>" +
                                              "<C> id='SD_GBN'		 width=90	name='���籸��'			align=left </C>" +
                                              "<C> id='SD_NAM'		 width=100	name='�޿��׸�'			align=left </C>" +
                                              "<C> id='SD_REMARK'	 width=129	name='����'				align=right </C>" +
                                              "<C> id='SD_AMT'		 width=80	name='�ݾ�'				align=right </C>";


            }else{
                form1.grdT_CP_CHANGE.format = "<C> id='{CUROW}'	     width=39	name='NO'		  	    align=center  value={String(Currow)}  </C>" +
                                              "<C> id='COMM_NM'		 width=130	name='�����׸�'			align=left </C>" +
                                              "<C> id='REMARK'		 width=160	name='����'				align=right </C>" +
                                              "<C> id='AMOUNT'		 width=110	name='�ݾ�'				align=right </C>";
            }

            cfStyleGrid_New(form1.grdT_CP_CHANGE,0,"false","false");      // Grid Style ����

		}

        function fnc_ChangeTitle() {

			var kind = dsT_CP_PAYMASTER.NameValue(1,"KIND");

			if(kind == "1"){
				document.getElementById('title1').innerText = "��Ÿ���系��";
				document.getElementById('title2').innerText = "��Ÿ���系��";
            }else{
				document.getElementById('title1').innerText = "��Ÿ��������";
				document.getElementById('title2').innerText = "��Ÿ��������";
            }

        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CP_CHANGE                                 |
    | 3. Table List : T_CP_CHANGE                             |
    +----------------------------------------------->
    <Object ID="dsT_CP_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CP_CHANGE Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("����� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- Ÿ��Ʋ �� ���̺� ���� -->
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="../../images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle"><span id="title1"></span></td>
					<td align="right" class="navigator">HOME/��������/��������/�޿����޾���ȸ/<font color="#000000"><span id="title2"></span></font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CP_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:460px;height:230px;">
							<param name="DataID"							value="dsT_CP_CHANGE">
							<param name="EdiTABLE"						value="false">
							<param name="DragDropEnable"				value="true">
							<param name="SortView"						value="Left">
							<param name="VIEWSUMMARY"			    value=0>
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
<table width="460" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
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