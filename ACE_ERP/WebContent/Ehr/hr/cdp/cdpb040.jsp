<!--
    ************************************************************************************
    * @Source              : cdpb040.jsp                                               *
    * @Description        : ��å�������Ȳ                                             *
    * @Font                   :                                                        *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/01  |  ������   | �����ۼ�                                               *
    * 2006/09/29  |  ������   | ���߿Ϸ�                                               *
    * 2006/11/06  |  ������   | ��ȿ��ó�� �߰�                                        *
    * 2007/03/24  |  ���м�   | �����ڵ����� ��å�������Ȳ���� ��ȯ                 *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��å�������Ȳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

//		var btnList = 'FTTTFFTT';
		var btnList = 'FFFFFFFT';
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        }

		/***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
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
			dsT_CD_RESPCODE.ClearData();
			ds01T_CD_RESPCODE.ClearData();
			dsT_CD_RESPCODE.Reset();

		//	fnc_ColEnabled('D');
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        frame = window.external.GetFrame(window);
	        frame.CloseFrame();
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

            //Grid Style ����
            cfStyleGrid(form1.grd01T_CD_RESPCODE,15,"false","false");

//            fnc_ColEnabled('D');

			//form load�� ������ ��å�ڵ� Ʈ�����·� ��ȸ
//            var f = document.form1;
			//if (!valid(form1)) return;//Validation ����

            try {
                dsT_CD_RESPCODE.ClearData();
				dsT_CD_RESPCODE.DataId="/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb040.cmd.CDPB040CMD&S_MODE=SHR";
				dsT_CD_RESPCODE.Reset();
            } catch ( exception ) {
                fcWindowsXpSp2Notice(false);
                return;
            }
        }

		/********************
         * 16. ����Ű ó��  *
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
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. Ʈ�������� DataSet                                               |
    | 2. �̸� : dsT_CD_RESPCODE                                            |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="dsT_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : ds01T_CD_RESPCODE                                        |
    | 3. Table List : T_CD_RESPCODE                                       |
    +----------------------------------------------->
    <Object ID="ds01T_CD_RESPCODE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------+
    | treeview���� item�� Ŭ�������� |
    +------ ------------------------->
    <script language=JavaScript for=tvT_CD_RESPCODE event=OnItemClick()>
		var overId1 = "RESP_CD";
		var overId2 = "RESP_LBL";
		var overNm = tvT_CD_RESPCODE.ItemText;
		var Row = dsT_CD_RESPCODE.NameValueRow("RESP_NM",overNm);
		var overValue1 = dsT_CD_RESPCODE.NameValue(Row,overId1);
		var overValue2 = dsT_CD_RESPCODE.NameValue(Row,overId2);
//		alert("overNm : "+overNm+", Row : "+Row+", overValue2 : "+overValue2);

        // ��å������ 3�̻��� ��� ��å����� ����� ��ȸ�ؿ´�.
        if (overValue2 < "3") {
            return;
        }

		try {
		    ds01T_CD_RESPCODE.ClearData();
			ds01T_CD_RESPCODE.DataID = "/servlet/GauceChannelSVL?cmd=hr.cdp.b.cdpb040.cmd.CDPB040CMD&S_MODE=SHR_01&"+overId1+"="+overValue1+"&"+overId2+"="+overValue2;
			ds01T_CD_RESPCODE.Reset();
		} catch ( exception ) {
			fcWindowsXpSp2Notice(false);
			return;
		}
	</script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->

    <Script For=ds01T_CD_RESPCODE Event="OnLoadCompleted(iCount)">

        if (iCount < 1) {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
            fnc_Message(document.getElementById("resultMessage"), 'MSG_02');

        } else {

            fnc_Message(document.getElementById("resultMessage"), 'MSG_03', iCount);

        }

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CD_RESPCODE Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=ds01T_CD_RESPMST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

//            fnc_ColEnabled('D');

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", ds01T_CD_RESPMST.CountRow );

//            fnc_ColEnabled('E');

//            document.getElementById("txtDUTY_CD").disabled  = true;
//            document.getElementById("ImgDutyCd").disabled   = true;
//            document.getElementById("txtSDUTY_CD").disabled = true;
//            document.getElementById("ImgSDutyCd").disabled  = true;

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=ds01T_CD_RESPMST Event="OnLoadError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!--------------------------+
    | �׸����� ROW�� Ŭ�� �Ҷ�  |
    +--------------------------->

    <Script For=grd01T_CD_RESPCODE Event="OnDblClick(row, col)">

        resp_cd  = ds01T_CD_RESPCODE.NameValue(row, "RESP_CD");
        var url = "/hr/cdp/cdpb021.jsp?RESP_CD="+resp_cd+"&TITLE=��å�����_��ȸ";
        work = "2";

        window.showModalDialog(url, self, "dialogHeight=700px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


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
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��å�������Ȳ</td>
					<td align="right" class="navigator">HOME/��������/CDP/��å����/<font color="#000000">��å�������Ȳ</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->

<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ��ȸ Ʈ�� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object id="tvT_CD_RESPCODE" classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="width:300px;height:375px">
							<param name=DataID		value="dsT_CD_RESPCODE">
							<param name=TextColumn	value="RESP_NM">
							<param name=LevelColumn	value="RESP_LBL">
							<param name=ExpandLevel	value="1">
							<param name=BorderStyle  value="2">
							<param name=UseImage      value="false">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ Ʈ�� ��-->
		</td>
		<td>
			<!-- ���� ��ȸ �׸��� ���̺� ����-->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grd01T_CD_RESPCODE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:375px">
                            <param name="DataID"             value="ds01T_CD_RESPCODE">
                            <param name="EdiTABLE"           value="false">
                            <param name="DragDropEnable"     value="true">
                            <param name="SortView"           value="Left">
                            <param name="VIEWSUMMARY"        value=0>
                            <param name="Format"             value="
								<C> id='RESP_CD'			width=100	    name='�ڵ�'			sort=true		align=center	</C>
								<C> id='RESP_NM'		width=184		name='��å��'		sort=true		align=left		</C>
								<C> id='UPT_YMD'			width=90		name='���������'	sort=true		align=center 	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			<!-- ���� ��ȸ �׸��� ���̺� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- ��å�������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="ds01T_CD_RESPCODE">
    <Param Name="BindInfo", Value='
        <C> Col=RESP_CD    		Ctrl=txtRESP_CD			Param=value </C>
        <C> Col=RESP_NM         Ctrl=txtRESP_NM	        Param=value </C>
        <C> Col=UPT_YMD     	Ctrl=txtUPT_YMD			Param=value </C>
    '>
</object>