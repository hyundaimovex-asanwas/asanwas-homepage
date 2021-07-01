<!--
    ************************************************************************************
    * @Source         : vluf020.jsp 					                                                                                 *
    * @Description    : ��������.                                                                                                      *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!                         *
    * @Developer Desc :                                                                                                                 *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                                                                  *
    *-------------+-----------+--------------------------------------------------------+
    * 2006/09/29  |  ���ؼ�   | �����ۼ�                                                                                           *
    * 2006/10/12  |  ������   | �Է´� �߰�, �˻��� ����                                                                    *
    * 2006/11/06  |  ������   | ��ȿ��ó�� �߰�                                                                                *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>

	<head>
	<title>��������(vluf020)</title>
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

		var btnList = 'TTTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR&cmbDUTY_NO_SHR="+document.getElementById("cmbDUTY_NO_SHR").value;
            dsT_EV_DUTYBAS.Reset();

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

			if( !fnc_SaveItemCheck() )	return;

			//Ʈ����� ����
			trT_EV_DUTYBAS.KeyValue = "SVL(I:dsT_EV_DUTYBAS=dsT_EV_DUTYBAS)";
			trT_EV_DUTYBAS.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SAV";
			trT_EV_DUTYBAS.Post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_EV_DUTYBAS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_EV_DUTYBAS.NameValue(dsT_EV_DUTYBAS.RowPosition,'DUTY_NO') + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
			dsT_EV_DUTYBAS.DeleteRow(dsT_EV_DUTYBAS.RowPosition);
			trT_EV_DUTYBAS.KeyValue = "SVL(I:dsT_EV_DUTYBAS=dsT_EV_DUTYBAS)";
			trT_EV_DUTYBAS.Action = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=DEL";
			trT_EV_DUTYBAS.post();

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

            //�ش� Dataset�� Header�� ������ Header ����
            if (dsT_EV_DUTYBAS.CountColumn == 0) {
                dsT_EV_DUTYBAS.setDataHeader("DUTY_NO:INT:KEYVALUETYPE, DUTY_STDT:STRING:NOTNULL, DUTY_ENDT:STRING:NOTNULL, DUTY_TITLE:STRING:NOTNULL");
            }

            //AddNew �� Grid�� ���� ���� Row�� Ư�� Column���� �̵��ϴ°�
            dsT_EV_DUTYBAS.AddRow();

            fnc_ColEnabled('E');

            //�ڵ����� ���� ����
            if (dsT_EV_DUTYBAS.CountRow == 1) {
            	document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition,"DUTY_NO") = 1;
            }else{
            	document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition,"DUTY_NO") = document.dsT_EV_DUTYBAS.NameValue(document.dsT_EV_DUTYBAS.RowPosition-1,"DUTY_NO")+1;
            }

			//��������Ϸ� ��Ŀ��
            document.getElementById("txtDUTY_STDT").focus();
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

			dsT_EV_DUTYBAS.ClearData();

			fnc_ColEnabled('D');

        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_EV_DUTYBAS.IsUpdated)  {

	            if (!fnc_ExitQuestion()) return;

	        }

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

        	if (!dsT_EV_DUTYBAS.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			var i = 0;
			var oDUTY_NO, oDUTY_STDT, oDUTY_ENDT, oDUTY_TITLE;
			var RowCnt = dsT_EV_DUTYBAS.CountRow;

			for(i=1; i<=RowCnt; i++){

				oDUTY_NO = dsT_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				if(oDUTY_NO.toString().trim().length == 0 || oDUTY_NO.toString().trim() == "0") {
					alert("����ȸ���� �Է��ϼ���.");
					dsT_EV_DUTYBAS.RowPosition = i;
					document.medDUTY_NO.Focus();
					return false;
				}

				oDUTY_STDT = dsT_EV_DUTYBAS.NameValue(i,"DUTY_STDT");
				if(!cfDateExpr(oDUTY_STDT) || oDUTY_STDT.trim().length == 0){//�������� �ݵ�� �����Ѵ�.
					alert("��������  �߸��Ǿ����ϴ�." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_STDT").focus();
					return false;
				}

				oDUTY_ENDT = dsT_EV_DUTYBAS.NameValue(i,"DUTY_ENDT");
				if(!cfDateExpr(oDUTY_ENDT) || oDUTY_ENDT.trim().length == 0){//�������� �ݵ�� �����Ѵ�.
					alert("��������  �߸��Ǿ����ϴ�." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_ENDT").focus();
					return false;
				}

				oDUTY_STDT = parseInt(oDUTY_STDT.replaceStr("-",""));
				oDUTY_ENDT = parseInt(oDUTY_ENDT.replaceStr("-",""));
				if(oDUTY_STDT > oDUTY_ENDT){
					alert("�������� �����Ϻ��� �����ϴ�." );
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_ENDT").focus();
					return false;
				}

				oDUTY_TITLE = dsT_EV_DUTYBAS.NameValue(i,"DUTY_TITLE");
				if(oDUTY_TITLE.trim() == ""){
					alert("��������(����)�� �Է��ϼ���.");
					dsT_EV_DUTYBAS.RowPosition = i;
					document.getElementById("txtDUTY_TITLE").focus();
					return false;
				}

			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grdT_EV_DUTYBAS,15,"false","false");

            //���۽� ����ȸ���� �����´�.
            ds01T_EV_DUTYBAS.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.f.vluf020.cmd.VLUF020CMD&S_MODE=SHR_01";
            ds01T_EV_DUTYBAS.Reset();

            fnc_ColEnabled('D');

			//��ȸ
            //fnc_SearchList();
        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���                *
         *******************************************************/

        /***************************************
		 * �Էº��� �÷��� Disabled �Ӽ� �ٲ�  *
		 ***************************************/
		function fnc_ColEnabled(prop) {
			// �ش� �÷��� �Ӽ��� Enabled�� ����
			if (prop == 'E') {
				form1.medDUTY_NO.readonly    = false;
				form1.txtDUTY_STDT.disabled  = false;
				form1.txtDUTY_ENDT.disabled  = false;
				form1.txtDUTY_TITLE.disabled = false;
			}
			// �ش� �÷��� �Ӽ��� Disabled�� ����
			else if (prop == 'D') {
				form1.medDUTY_NO.readonly    = true;
				form1.txtDUTY_STDT.disabled  = true;
				form1.txtDUTY_ENDT.disabled  = true;
				form1.txtDUTY_TITLE.disabled = true;
			}
		}



    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                 *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_GRDRATE)         |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)                    |
    +----------------------------------------------->
    <Object ID="dsT_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_GRDRATE)           |
    | 3. ���Ǵ� Table List(T_EV_GRDRATE)                     |
    +----------------------------------------------->
    <Object ID ="trT_EV_DUTYBAS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                                      |
    | 2. �̸� : ds01T_EV_DUTYBAS                                    |
    | 3. Table List : T_EV_DUTYBAS                                  |
    +----------------------------------------------->
    <Object ID="ds01T_EV_DUTYBAS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_EV_DUTYBAS.CountRow);

            fnc_ColEnabled('E');
        }

  	 	grdT_EV_DUTYBAS.SetColumn("DUTY_NO");//set focus
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            //fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            //��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			var i;
			var oOption;

			//�˻����� �޺��ڽ��� ����ȸ���� ����
			for(i=1; i <= iCount; i++){
	        	oOption = document.createElement("OPTION");
				oOption.text = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
				oOption.value = ds01T_EV_DUTYBAS.NameValue(i,"DUTY_NO");
       			document.getElementById("cmbDUTY_NO_SHR").add(oOption);
        	}

        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_EV_DUTYBAS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds01T_EV_DUTYBAS Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EV_DUTYBAS Event="OnDataError()">
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[ȸ��/���������/����������/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("ȸ��/���������/����������/�������� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_EV_DUTYBAS event="OnSuccess()">
	    fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_EV_DUTYBAS event="OnFail()">
	    cfErrorMsg(this);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������</td>
					<td align="right" class="navigator">HOME/�λ���/��������/<font color="#000000">��������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="right" width="10"></td>
								<td align="center" class="searchState">����ȸ��</td>
								<td width="50">
									<select id="cmbDUTY_NO_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option selected>��ü</option>
									</select>
								</td>
							<td align="left" width="630"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<td>&nbsp;</td>

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width="180"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">����ȸ��</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medDUTY_NO" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:60px">
							<param name=Alignment					value=0>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=true>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=4>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">���������</td>
					<td class="padding2423">
						<input id="txtDUTY_STDT" style="width:84;padding-left:10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUTY_STDT','','300','99');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
					<td align="center" class="creamBold">����������</td>
					<td class="padding2423">
						<input id="txtDUTY_ENDT" style="width:84;padding-left:10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtDUTY_ENDT','','595','99');"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle"></a>
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��������(����)</td>
					<td class="padding2423" colspan="5"><input id="txtDUTY_TITLE" style="width:100%" maxlength="50"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- power Search���̺� �� -->

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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_EV_DUTYBAS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:250px;">
							<param name="DataID"					value="dsT_EV_DUTYBAS">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='DUTY_NO'		width=61		name='ȸ��'						sort=true		align=center												</C>
								<C> id='DUTY_STDT'	width=110		name='���������' 			sort=true		align=center												</C>
								<C> id='DUTY_ENDT'	width=110		name='����������'			sort=true		align=center												</C>
								<C> id='DUTY_TITLE'	width=483		name='��������(����)'							align=left													</C>
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

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(Bind Component)                                                                            *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ���� �� ��ȸ�� Bind                                               |
    | 2. �̸� : bndT_EV_DUTYBAS                                   |
    | 3. Table List : T_EV_DUTYBAS                                 |
    +----------------------------------------------->
	<object id="bndT_EV_DUTYBAS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_DUTYBAS">
		<Param Name="BindInfo", Value="
			<C>Col='DUTY_NO'			Ctrl='medDUTY_NO'		Param=text	</C>
			<C>Col='DUTY_STDT'		Ctrl='txtDUTY_STDT'		Param=value</C>
			<C>Col='DUTY_ENDT'		Ctrl='txtDUTY_ENDT'		Param=value</C>
			<C>Col='DUTY_TITLE'		Ctrl='txtDUTY_TITLE'		Param=value</C>
	    ">
	</object>
