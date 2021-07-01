<!--
***********************************************************************
* @source      : weld030.jsp
* @description : �ܵ���ûó�� PAGE
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
<title>�ܵ���ûó��(weld030)</title>
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

		var btnList = 'TFTTFTFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var cn_cd = document.getElementById('cmbCN_CD_SHR').value;
			var rsv_gbn = document.getElementById('cmbRSV_GBN_SHR').value;
			var rst_gbn = document.getElementById('cmbRST_GBN_SHR').value;
			var season_gbn = document.getElementById('cmbSEASON_GBN_SHR').value;

			dsT_WL_CONDOUSE.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld030.cmd.WELD030CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CN_CD="+cn_cd+"&RSV_GBN="+rsv_gbn+"&RST_GBN="+rst_gbn+"&SEASON_GBN="+season_gbn;
    		dsT_WL_CONDOUSE.reset();

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

			trT_WL_CONDOUSE.KeyValue = "tr01(I:dsT_WL_CONDOUSE=dsT_WL_CONDOUSE)";
			trT_WL_CONDOUSE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.d.weld030.cmd.WELD030CMD&S_MODE=SAV";
			trT_WL_CONDOUSE.post();


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

			var str_ymd = document.getElementById('txtSTR_YMD_SHR').value;
			var end_ymd = document.getElementById('txtEND_YMD_SHR').value;
			var cn_cd = document.getElementById('cmbCN_CD_SHR').value;
			var rsv_gbn = document.getElementById('cmbRSV_GBN_SHR').value;
			var rst_gbn = document.getElementById('cmbRST_GBN_SHR').value;
			var season_gbn = document.getElementById('cmbSEASON_GBN_SHR').value;


			var url = "weld030_PV.jsp?&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&CN_CD="+cn_cd+"&RSV_GBN="+rsv_gbn+"&RST_GBN="+rst_gbn+"&SEASON_GBN="+season_gbn;
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

			document.getElementById('cmbRSV_GBN_SHR').value = '13';
			document.getElementById('cmbRST_GBN_SHR').value = '';
			document.getElementById('cmbSEASON_GBN_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_CONDOUSE.ClearData();

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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_WL_CONDOUSE,15,"false","false");      // Grid Style ����

            document.getElementById('txtSTR_YMD_SHR').value = getStrDate();
            document.getElementById('txtEND_YMD_SHR').value = getEndDate();
            document.getElementById('txtSTR_YMD_SHR').focus();



            fnc_ConstructCommonCode("dsCOMMON_CN", "cmbCN_CD_SHR", "", "�� ü");
            document.getElementById('cmbRSV_GBN_SHR').value = '13';

            //â ����
            fnc_DisableElementAll(elementList);
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        //�Է�â
        var elementList = new Array(     "rdoRSV_GBN"
                                        ,"cmbRST_GBN"
                                        ,"txtRSV_NO" );

        var exceptionList = new Array(   "rdoRSV_GBN" );

        /**
         * �����ȣ�� �ִ��� ������ ���θ� ����
         */
        function chk_RSV_NO() {
            if(document.getElementById("txtRSV_NO").value == "") {
                dsT_WL_CONDOUSE.NameString(dsT_WL_CONDOUSE.RowPosition, "RSV_GBN") = "1";   //'1', '��û', '2', '���', '3', '����'
                dsT_WL_CONDOUSE.NameString(dsT_WL_CONDOUSE.RowPosition, "RST_GBN") = "1";   //1:��ȸ��,2:Ȯ��,3:�Ϲ����,4:�Ϸ����,5:NoShow,6:�̴�÷
            }
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_CONDOUSE) |
    | 3. ���Ǵ� Table List(T_WL_CONDOUSE)		     |
    +------------------------------------------------>
    <Object ID="dsT_WL_CONDOUSE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- �ܵ� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_CN"/>
       <jsp:param name="CODE_GUBUN"    value="CN"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_CONDOUSE)	|
    | 3. ���Ǵ� Table List(T_WL_CONDOUSE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_WL_CONDOUSE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_CONDOUSE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_CONDOUSE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_CONDOUSE event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_CONDOUSE event="OnFail()">
        cfErrorMsg(this);
    </script>


    <!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó�� |    -- row�� ����� �Ŀ� �Ͼ
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_WL_CONDOUSE event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        //��û���°� ����̸� ����� �����ȣ�� �������ϰ� ����
        if(dsT_WL_CONDOUSE.NameString(row, "RSV_GBN") != "2") {
            fnc_EnableElementAll(elementList, exceptionList);
        }
    </script>



    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |   -- row�� ����Ǳ� ������ �Ͼ
    +--------------------------->
    <script for=dsT_WL_CONDOUSE event=CanRowPosChange(row)>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ܵ���ûó��</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ܵ�/<font color="#000000">�ܵ���ûó��</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
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
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="90"></col>
									<col width="220"></col>
									<col width="80"></col>
									<col width="70"></col>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="center" class="searchState">��û��&nbsp;</td>
								<td class="padding2423">
									<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','15','120');"></a> ~
									<input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','125','120');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
								<td class="padding2423">
									<select id="cmbCN_CD_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
									</select>
								</td>
								<td align="center" class="searchState">��û����&nbsp;</td>
								<td class="padding2423">
									<select id="cmbRSV_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">�� ü</option>
										<option value="13">������</option>
										<option value="1">�� û</option>
										<option value="2">�� ��</option>
										<option value="3">�� ��</option>
									</select>
								</td>
							</tr>
							<tr>
								<td align="center" class="searchState">������&nbsp;</td>
								<td class="padding2423">
									<select id="cmbRST_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">�� ü</option>
										<option value="1">��ȸ��</option>
										<option value="2">Ȯ ��</option>
										<option value="3">�Ϲ����</option>
										<option value="4">�Ϸ����</option>
										<option value="5">NoShow</option>
									</select>
								</td>
								<td align="center" class="searchState">�����ⱸ��&nbsp;</td>
								<td class="padding2423">
									<select id="cmbSEASON_GBN_SHR" style="WIDTH:100" onChange="fnc_SearchList();">
										<option value="">�� ü</option>
										<option value="1">�񼺼���</option>
										<option value="2">������</option>
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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <input type="text" id="txtDPT_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <input type="text" id="txtJOB_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <input type="text" id="txtENO_NM" style="width:100" class="input_ReadOnly" readonly>
					</td>
				</tr>
				<tr>
                    <td align="center" class="creamBold">�̿������</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD" style="width:100" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
                        <input type="text" id="txtCN_NAME" style="width:100" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input type="text" id="txtCO_NM" style="width:220" class="input_ReadOnly" readonly>
        <!--                <input type="text" id="txtEXT" style="width:100" class="input_ReadOnly" readonly>    -->
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">�̿�ڼ�</td>
					<td class="padding2423">
						<input id="txtSTAY_CNT" size="5" maxLength="2" class="input_ReadOnly" readonly>
					</td>
					<td align="center" class="creamBold">���Ǽ�</td>
					<td class="padding2423">
						<input id="txtROOM_CNT" size="5" maxLength="2" class="input_ReadOnly" readonly>
					</td>
                    <td align="center" class="creamBold">����ó</td>
                    <td class="padding2423">
                        <input id="txtENO_TEL" size="20" maxLength="20" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
					<td align="center" class="creamBold">�ܵ���û</td>
					<td class="padding2423" colspan="3">
                        <comment id="__NSID__">
						<object id=rdoRSV_GBN classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
									style="height:20; width:200">
							<param name=AutoMargin	value="false">
							<param name=DataID      value="dsT_WL_CONDOUSE">
							<param name=CodeColumn  value="RSV_GBN">
							<param name=Cols		value="3">
							<param name=Format		value="1^��û,2^���,3^����">
                            <param name=Enable   value=false>
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="creamBold">������Ȯ��</td>
					<td class="padding2423">
                        <table>
                            <tr>
                                <td>
            						<select id="cmbRST_GBN" style="WIDTH:100">
            							<option value="1">��ȸ��</option>
                                        <option value="7">ó����</option>
            							<option value="2">Ȯ��</option>
            							<option value="3">�Ϲ����</option>
            							<option value="4">�Ϸ����</option>
            							<option value="5">NoShow</option>
            							<option value="6">�̴�÷</option>
            						</select>
                                </td>
								<td>
									&nbsp;
                                    <input id="txtRSV_NO" size="15" onchange="chk_RSV_NO()">
								</td>
							</tr>
						</table>
					</td>

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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_WL_CONDOUSE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_WL_CONDOUSE">
							<param name="Format"					value="
								<FC> id={currow}		width=35    name='NO'			align=center </FC>
								<FC> id='DPT_NM'		width=80	name='�Ҽ�'			align=left Edit=none </FC>
								<FC> id='JOB_NM'		width=50	name='����'			align=left Edit=none </FC>
								<FC> id='ENO_NM'		width=60	name='����'			align=center Edit=none </FC>
								<C> id='CN_NAME'		width=70	name='�ܵ�'			align=center Edit=none </C>
								<C> id='CO_NM'		width=220   name='����'			align=left leftmargin=10 Edit=none </C>
                                <C> id='IPT_YMD'    width=70    name='��û��'       align=center Edit=none </C>
							   	<C> id='STR_YMD'	width=70	name='�̿������'	align=center Edit=none </C>
								<C> id='STAY_CNT'	width=55	name='�̿�ڼ�'		align=right Edit=none </C>
								<C> id='ROOM_CNT'	width=40	name='���Ǽ�'		align=right Edit=none </C>
								<C> id='RSV_GBN'	width=60	name='��û����'		align=center Edit=none  Value={Decode(RSV_GBN, '1', '��û', '2', '���', '3', '����')}</C>
								<C> id='RSV_NO'		width=80	name='�����ȣ'		align=left </C>
								<C> id='RST_GBN'	width=80	name='������'			align=left leftmargin=10 EditStyle=Combo Data='1:��ȸ��,2:Ȯ��,3:�Ϲ����,4:�Ϸ����,5:NoShow,6:�̴�÷,7:ó����'</C>
								<C> id='USE_CNT'	width=55	name='�̿����'		align=right Edit=none </C>
								<C> id='ENO_TEL'	width=100	name='����ó'		align=left  Edit=none </C>
								<C> id='SEASON_GBN'	width=65	name='�����ⱸ��'	align=center Edit=none Value={Decode(SEASON_GBN, '1', '�񼺼���', '2', '������')} </C>
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

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- KPI Pool ���� ���̺� -->
<object id="bndT_WL_CONDOUSE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_WL_CONDOUSE">
    <Param Name="BindInfo", Value='
        <C>Col=DPT_NM       Ctrl=txtDPT_NM          Param=value     </C>
        <C>Col=JOB_NM       Ctrl=txtJOB_NM          Param=value     </C>
        <C>Col=ENO_NM       Ctrl=txtENO_NM          Param=value     </C>
        <C>Col=STR_YMD      Ctrl=txtSTR_YMD         Param=value     </C>
        <C>Col=CN_NAME      Ctrl=txtCN_NAME         Param=value     </C>
        <C>Col=CO_NM        Ctrl=txtCO_NM           Param=value     </C>
        <C>Col=STAY_CNT     Ctrl=txtSTAY_CNT        Param=value     </C>
        <C>Col=ROOM_CNT     Ctrl=txtROOM_CNT        Param=value     </C>
        <C>Col=RSV_NO       Ctrl=txtRSV_NO          Param=value     </C>
        <C>Col=RST_GBN      Ctrl=cmbRST_GBN         Param=value     </C>
        <C>Col=ENO_TEL      Ctrl=txtENO_TEL         Param=value     </C>
    '>
</object>