<!--
***********************************************************************
* @source      : acqa020.jsp
* @description : ���ΰ˻� �� ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/11/29      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ΰ˻� �� ����(acqa020)</title>
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

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFTTTFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻����� 3����
			var com_gbn = document.getElementById('cmbCOM_GBN_SHR').value;	//�������
			var com_nm = document.getElementById('txtCOM_NM_SHR').value;	//�����
			var eno_nm = document.getElementById('txtENO_NM_SHR').value;	//����

			dsT_AQ_ACQAINT.dataid = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=SHR&COM_GBN="+com_gbn+"&COM_NM="+com_nm+"&ENO_NM="+eno_nm;
    		dsT_AQ_ACQAINT.reset();

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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			trT_AQ_ACQAINT.KeyValue = "tr01(I:dsT_AQ_ACQAINT=dsT_AQ_ACQAINT)";
			trT_AQ_ACQAINT.action = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=SAV";
			trT_AQ_ACQAINT.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_AQ_ACQAINT.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[���μ���:"+dsT_AQ_ACQAINT.NameValue(dsT_AQ_ACQAINT.RowPosition,'ENO_NM')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_AQ_ACQAINT.DeleteRow(dsT_AQ_ACQAINT.RowPosition);
				trT_AQ_ACQAINT.KeyValue = "tr01(I:dsT_AQ_ACQAINT=dsT_AQ_ACQAINT)";
				trT_AQ_ACQAINT.action = "/servlet/GauceChannelSVL?cmd=hr.acq.a.acqa020.cmd.ACQA020CMD&S_MODE=DEL";
				trT_AQ_ACQAINT.post();
			}


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

			if (dsT_AQ_ACQAINT.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AQ_ACQAINT.GridToExcel("���ΰ˻����", '', 225);

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

			document.getElementById('cmbCOM_GBN_SHR').value = '';	//�������
			document.getElementById('txtCOM_NM_SHR').value = '';	//�����
			document.getElementById('txtENO_NM_SHR').value = '';	//����
			document.getElementById("resultMessage").innerText = ' ';

			dsT_AQ_ACQAINT.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_AQ_ACQAINT.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

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

			if (!dsT_AQ_ACQAINT.IsUpdated ) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
		        return false;
			}

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid(form1.grdT_AQ_ACQAINT,15,"false","false");      // Grid Style ����

			//�������
            for( var i = 1; i <= dsCOMMON_W9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W9.NameValue(i,"CODE_NAME");
                document.getElementById("cmbCOM_GBN").add(oOption);

            }
			//�������
            for( var i = 1; i <= dsCOMMON_W9.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W9.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W9.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCOM_GBN_SHR").add(oOption);

            }
			//ģ�е�
            for( var i = 1; i <= dsCOMMON_W7.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_W7.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_W7.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFAM_LEVEL").add(oOption);

            }

            document.getElementById('cmbCOM_GBN_SHR').focus();

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
    | 1. ��ȸ�� DataSet								|
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_AQ_ACQAINT)	|
    | 3. ���Ǵ� Table List(T_AQ_ACQAINT)			|
    +----------------------------------------------->
    <Object ID="dsT_AQ_ACQAINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_AQ_ACQAINT)		|
    | 3. ���Ǵ� Table List(T_AQ_ACQAINT)	            |
    +--------------------------------------------------->
    <Object ID ="trT_AQ_ACQAINT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ������� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_W9"/>
       <jsp:param name="CODE_GUBUN"    value="W9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- ģ�е� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_W7"/>
       <jsp:param name="CODE_GUBUN"    value="W7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_AQ_ACQAINT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_AQ_ACQAINT Event="OnLoadError()">

		document.getElementById("resultMessage").innerText = ' ';
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AQ_ACQAINT Event="OnDataError()">

		document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_AQ_ACQAINT event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_AQ_ACQAINT event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ΰ˻� �� ����</td>
					<td align="right" class="navigator">HOME/���ΰ���/���ΰ���/<font color="#000000">���ΰ˻� �� ����</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
									<col width="60"></col>
									<col width="120"></col>
									<col width="100"></col>
									<col width="120"></col>
	                                <col width="60"></col>
									<col width="80"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchBold">�������&nbsp;</td>
								<td class="padding2423">
									<select id="cmbCOM_GBN_SHR" style="WIDTH: 100%" onChange="fnc_SearchList();">
										<option value=''>�� ü</option>
									</select>
								</td>
								<td align="right" class="searchBold">�����&nbsp;</td>
								<td class="padding2423"><input id="txtCOM_NM_SHR" size="30" maxlength="30" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
								</td>
								<td align="right" class="searchBold">���μ���&nbsp;</td>
								<td class="padding2423"><input id="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"></td>
								<td>&nbsp;</td>
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
					<col width="100"></col>
					<col width="80"></col>
					<col width="100"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423"><input id="txtENO_NM" size="12" maxlength="12" onKeyUp="fc_chk_byte(this,12)"></td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423">
						<select id="cmbCOM_GBN" style="WIDTH: 100%">
						</select>
					</td>
					<td align="center" class="creamBold">�����</td>
					<td class="padding2423"><input id="txtCOM_NM" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�μ���</td>
					<td class="padding2423"><input id="txtDPT_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">ģ�е�</td>
					<td class="padding2423">
						<select id="cmbFAM_LEVEL" style="WIDTH: 70%">
						</select>
					</td>
				</tr>
                <tr>
					<td align="center" class="creamBold">�� ��</td>
					<td class="padding2423"><input id="txtREL_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">ȸ����ȭ</td>
					<td class="padding2423"><input id="txtTEL_NO" size="20" maxlength="20" onkeypress="cfCheckNumber()"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">�ڵ���</td>
					<td class="padding2423"><input id="txtHP_NO" size="20" maxlength="20" onkeypress="cfCheckNumber()" style="ime-mode:disabled"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">E-mail</td>
					<td class="padding2423"><input id="txtE_MAIL" size="30" maxlength="30"  style="ime-mode:disabled"></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="3"><input id="txtREMARK" size="60" maxlength="60" onKeyUp="fc_chk_byte(this,60)"></td>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_AQ_ACQAINT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
							<param name="DataID"					value="dsT_AQ_ACQAINT">
							<param name="Format"					value="
								<FC> id={currow}		width=35    name='NO'			align=center </FC>
								<FC> id='ENO_NM'		width=80	name='���μ���'		align=center</FC>
								<C> id='COM_GBN'	width=120	name='�������'		align=left
								EditStyle=Lookup  Data='dsCOMMON_W9:CODE:CODE_NAME' </C>
								<C> id='COM_NM'		width=120	name='�����'		align=left </C>
								<C> id='DPT_NM'		width=120	name='�μ���'		align=left </C>
								<C> id='JOB_NM'		width=80	name='����'			align=left </C>
								<C> id='FAM_LEVEL'	width=100	name='ģ�е�'		align=left
								EditStyle=Lookup  Data='dsCOMMON_W7:CODE:CODE_NAME'</C>
								<C> id='REL_NM'		width=100	name='����'			align=left </C>
								<C> id='TEL_NO'		width=100	name='ȸ����ȭ'		align=left </C>
								<C> id='HP_NO'		width=100	name='�޴���'		align=left </C>
								<C> id='E_MAIL'		width=120	name='E-mail'		align=left </C>
								<C> id='IPT_YMD'	width=80	name='�Է���'		align=center </C>
								<C> id='REMARK'		width=120	name='���'			align=left </C>
								<C> id='ENO_DPT_NM'	width=80	name='�μ�'			align=left </C>
								<C> id='ENO_JOB_NM'	width=60	name='����'			align=left </C>
								<C> id='ENO_NO'		width=80	name='���'			align=center</C>
								<C> id='ENO_ENO_NM'	width=80	name='����'			align=center</C>
								<C> id='ENO_YN'		width=80	name='��������'		align=center</C>
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
<object id="bndT_AQ_ACQAINT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_AQ_ACQAINT">
	<Param Name="BindInfo", Value='
		<C>Col=ENO_NM      	Ctrl=txtENO_NM      	Param=value		Disable=disabled</C>
		<C>Col=COM_GBN		Ctrl=cmbCOM_GBN	      	Param=value		Disable=disabled</C>
		<C>Col=COM_NM    	Ctrl=txtCOM_NM	     	Param=value		Disable=disabled</C>
		<C>Col=DPT_NM		Ctrl=txtDPT_NM      	Param=value		Disable=disabled</C>
		<C>Col=JOB_NM		Ctrl=txtJOB_NM			Param=value		Disable=disabled</C>
		<C>Col=FAM_LEVEL	Ctrl=cmbFAM_LEVEL      	Param=value		Disable=disabled</C>
		<C>Col=REL_NM		Ctrl=txtREL_NM      	Param=value		Disable=disabled</C>
		<C>Col=TEL_NO		Ctrl=txtTEL_NO	     	Param=value		Disable=disabled</C>
		<C>Col=HP_NO		Ctrl=txtHP_NO	     	Param=value		Disable=disabled</C>
		<C>Col=E_MAIL		Ctrl=txtE_MAIL	     	Param=value		Disable=disabled</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		Disable=disabled</C>
    '>
</object>