<!--
***********************************************************************
* @source      : weld070.jsp
* @description : ������ ��û�� ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/15      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>������ ��û�� ���(weld070)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;

            if(ord_no == "") {
                document.getElementById("btnLOTTERY").style.visibility = "hidden";
            } else {
                document.getElementById("btnLOTTERY").style.visibility = "visible";
            }

			dsT_WL_CONDOLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld070.cmd.WELD070CMD&S_MODE=SHR&ORD_NO="+ord_no;
    		dsT_WL_CONDOLOT.reset();

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

      		if(!fnc_SearchItemCheck()) return;

			var ord_no = document.getElementById('cmbORD_NO_SHR').value;

			var url = "weld070_PV.jsp?ORD_NO="+ord_no;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

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

			document.getElementById("cmbORD_NO_SHR")[0].selected = true;
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOLOT.ClearData();

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

			return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_WL_CONDOLOT,15,"false","false");      // Grid Style ����

			//�ܵ� ������ ������ȣ (weld050 ���)
			dsT_WL_CONDOSSN.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld050.cmd.WELD050CMD&S_MODE=SHR_01";
			dsT_WL_CONDOSSN.Reset();

            document.getElementById('cmbORD_NO_SHR').focus();


            if(document.getElementById("cmbORD_NO_SHR").value == "") {
                document.getElementById("btnLOTTERY").style.visibility = "hidden";
            }
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/*************************
         * 16. �ܵ� ��÷ �ǽ�    *
         ************************/
		function fnc_lottery() {

			if(dsT_WL_CONDOLOT.CountRow<1){
				alert("��÷ ����ڰ� �����ϴ�.");
				return;
			}

            var msg;
			if(dsT_WL_CONDOLOT.NameValue(1,'LOTTERY') > 0)
                msg = "�����������ȣ:["+dsT_WL_CONDOLOT.NameValue(1,'ORD_NO')+"]�� �̹� ��÷�� �Ϸ�Ǿ����ϴ�!\n�ٽ� �ʱ�ȭ �� ��÷ �Ͻðڽ��ϱ�?";
			else
                msg = "�����������ȣ:["+dsT_WL_CONDOLOT.NameValue(1,'ORD_NO')+"]�� ��÷�� �Ͻðڽ��ϱ�?";

            if(!confirm(msg))
                return;



            //������ insert
            dsT_WL_CONDOLOT.UseChangeInfo = false;

			trT_WL_CONDOLOT.KeyValue = "tr01(I:dsT_WL_CONDOLOT=dsT_WL_CONDOLOT)";
			trT_WL_CONDOLOT.action   = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld070.cmd.WELD070CMD&S_MODE=SAV";
			trT_WL_CONDOLOT.post();
		}


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOLOT) |
    | 3. ���Ǵ� Table List(T_WL_CONDOLOT)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOLOT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOSSN) |
    | 3. ���Ǵ� Table List(T_WL_CONDOSSN)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOSSN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------+
    | 1. ī�ǿ� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOLOT) |
    | 3. ���Ǵ� Table List(T_WL_CONDOLOT)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOLOT_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_CONDOLOT)	|
    | 3. ���Ǵ� Table List(T_WL_CONDOLOT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_WL_CONDOLOT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <Script For=dsT_WL_CONDOSSN Event="OnLoadCompleted(iCount)">

        if (iCount > 0) {
			var oOption;
			for(var i=1 ; i<=iCount ; i++) {

				oOption         = document.createElement("OPTION");
				oOption.text    = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");
				oOption.value   = dsT_WL_CONDOSSN.NameValue(i,"ORD_NO");

				document.getElementById("cmbORD_NO_SHR").add(oOption);
			}
			document.getElementById("cmbORD_NO_SHR").selectedIndex = 0;
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOLOT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_WL_CONDOSSN Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOLOT Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <Script For=dsT_WL_CONDOSSN Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_CONDOLOT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_CONDOLOT event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_WL_CONDOLOT event="OnDblClick(row,colid)">

		if(row < 1) {

			return;

		} else {

			var cnt = dsT_WL_CONDOLOT.NameValue(row,"APP_CNT");

			if(cnt < 1){
				alert("���� ��û�ڰ� �����ϴ�.");
				return false;
			}

			url = "/hr/wel/weld071.jsp";

			//���õ� ROW�� dsT_WL_CONDOLOT_CP�� �����Ͽ� Modalâ�� dsT_WL_CONDOLOT_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_WL_CONDOLOT, dsT_WL_CONDOLOT_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");

			window.showModalDialog(url, dsT_WL_CONDOLOT_CP, "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

		}

	</script>


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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������ ��û�� ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ܵ�/<font color="#000000">������ ��û�� ���</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
									<col width="120"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">�����������ȣ</td>
								<td class="padding2423">
                                    <select id="cmbORD_NO_SHR" name="cmbORD_NO_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
                                    </select>
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
					<td align="right">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnLOTTERY','','/images/button/btn_LotteryOver.gif',1)"><img src="/images/button/btn_LotteryOn.gif" name="btnLOTTERY" width="60" height="20" border="0" align="absmiddle" onClick="fnc_lottery()"></a>
                    </td>
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
						<object	id="grdT_WL_CONDOLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_WL_CONDOLOT">
							<param name="Format"					value="
								<C> id={currow}	   width=39   name='NO'				align=center </C>
								<C> id='ORD_NO'	   width=90   name='�����������ȣ'	align=center </C>
								<C> id='STR_YMD'   width=90   name='�̿������'		align=center </C>
								<C> id='CN_NM'	   width=90	  name='�ܵ�'			align=left </C>
								<C> id='CO_NM'	   width=235  name='����'			align=left </C>
								<C> id='ROOM_CNT'  width=70	  name='���Ǽ�'			align=right </C>
								<C> id='STAY_CNT'  width=70	  name='�̿��ϼ�'		align=right </C>
								<C> id='APP_CNT'   width=80	  name='�����û�ڼ�'	align=right </C>
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