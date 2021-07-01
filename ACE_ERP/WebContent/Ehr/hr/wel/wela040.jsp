<!--
***********************************************************************
* @source      : wela040.jsp
* @description : �̻��� ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2006/12/05      ���뼺        �����ۼ�.        
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�̻��� ����(wela040)</title>
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
			
			var cd_nm = document.getElementById('txtCD_NM_SHR').value;
			dsT_WL_MOVEXPENS.dataid = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=SHR&CD_NM="+cd_nm;
    		dsT_WL_MOVEXPENS.reset();

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

				trT_WL_MOVEXPENS.KeyValue = "tr01(I:dsT_WL_MOVEXPENS=dsT_WL_MOVEXPENS)";
				trT_WL_MOVEXPENS.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=SAV";
				trT_WL_MOVEXPENS.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
			
			if(dsT_WL_MOVEXPENS.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[�����ڵ�:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'GBN_CD')+"/�Ϸù�ȣ:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'SEQ_NO')+"/ǰ��:"+dsT_WL_MOVEXPENS.NameValue(dsT_WL_MOVEXPENS.RowPosition,'CD_NM')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_WL_MOVEXPENS.DeleteRow(dsT_WL_MOVEXPENS.RowPosition);
				trT_WL_MOVEXPENS.KeyValue = "tr01(I:dsT_WL_MOVEXPENS=dsT_WL_MOVEXPENS)";
				trT_WL_MOVEXPENS.action = "/servlet/GauceChannelSVL?cmd=hr.wel.a.wela040.cmd.WELA040CMD&S_MODE=DEL";
				trT_WL_MOVEXPENS.post();
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {
			
			//DataSet�� Header�� ���ǵǾ� ���� �ʴ� ���
			if(dsT_WL_MOVEXPENS.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_WL_MOVEXPENS.setDataHeader("GBN_CD:STRING:KEYVALUE, SEQ_NO:STRING:KEYVALUE, CD_NM:STRING, ITEM_NM:STRING, COST1_AMT:STRING, COST2_AMT:STRING, COST3_AMT:STRING, CBM_AMT:STRING, REMARK:STRING");
			}
		
			dsT_WL_MOVEXPENS.AddRow();				
			
			document.getElementById('txtGBN_CD').focus();
			
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
			
			document.getElementById('txtCD_NM_SHR').value = '';
			document.getElementById("resultMessage").innerText = ' ';

			dsT_WL_MOVEXPENS.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_MOVEXPENS.IsUpdated)  {

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
			
			if (!dsT_WL_MOVEXPENS.IsUpdated ) {
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

			cfStyleGrid(form1.grdT_WL_MOVEXPENS,15,"false","false");      // Grid Style ����
			
            document.getElementById('txtCD_NM_SHR').focus();

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

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_WL_MOVEXPENS)|
    | 3. ���Ǵ� Table List(T_WL_MOVEXPENS)		 |
    +------------------------------------------------>
    <Object ID="dsT_WL_MOVEXPENS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_WL_MOVEXPENS)	|
    | 3. ���Ǵ� Table List(T_WL_MOVEXPENS)	        |
    +--------------------------------------------------->
    <Object ID ="trT_WL_MOVEXPENS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_WL_MOVEXPENS Event="OnLoadCompleted(iCount)">
		
        if (iCount < 1)    {

            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
			
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_MOVEXPENS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_MOVEXPENS Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�����ڵ�/�Ϸù�ȣ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("�����ڵ�/�Ϸù�ȣ�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_MOVEXPENS event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_MOVEXPENS event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�̻��� ����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ֺ�/<font color="#000000">�̻��� ����</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="90"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">�����ڵ�</td>
					<td class="padding2423"><input id="txtGBN_CD" size="5" maxlength="2" style="text-align:center;ime-mode:disabled"></td>
					<td align="center" class="creamBold">�Ϸù�ȣ</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="5" maxlength="2" style="text-align:center;ime-mode:disabled"></td>
					<td align="center" class="creamBold">ǰ&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtCD_NM" size="20" maxlength="20" onKeyUp="fc_chk_byte(this,20)"></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtITEM_NM" size="12" maxlength="10" onKeyUp="fc_chk_byte(this,10)"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">1T ����</td>
					<td class="padding2423"><input id="txtCOST1_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">2.5T ����</td>
					<td class="padding2423"><input id="txtCOST2_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">5T ����</td>
					<td class="padding2423"><input id="txtCOST3_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
					<td align="center" class="creamBold">1CBM �߰�</td>
					<td class="padding2423"><input id="txtCBM_AMT" size="12" maxlength="10" style="ime-mode:disabled; text-align:right" onkeypress="cfNumberCheck()"></td>
				</tr>
                <tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="7"><input id="txtREMARK" size="30" maxlength="30" onKeyUp="fc_chk_byte(this,30)"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
									<col width="100"></col>
									<col width="*"></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">ǰ��&nbsp;</td>
								<td class="padding2423">
									<input id="txtCD_NM_SHR" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"> 
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
						<object	id="grdT_WL_MOVEXPENS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:330px;">
							<param name="DataID"					value="dsT_WL_MOVEXPENS">
							<param name="Format"					value="
								<C> id={currow}		width=35    name='NO'			align=center </C>
								<C> id='GBN_CD'		width=60	name='�����ڵ�'		align=center </C>
								<C> id='SEQ_NO'		width=60	name='�Ϸù�ȣ'		align=center </C>
								<C> id='CD_NM'		width=110	name='ǰ��'			align=left </C>
								<C> id='ITEM_NM'	width=80	name='����'			align=left </C>
								<C> id='COST1_AMT'	width=70	name='1T ����'		align=right </C>
								<C> id='COST2_AMT'	width=70	name='2.5T ����'	align=right </C>
								<C> id='COST3_AMT'	width=70	name='5T ����'		align=right </C>
								<C> id='CBM_AMT'	width=70	name='1CBM �߰�'	align=right </C>
								<C> id='REMARK'		width=140	name='���'			align=left </C>
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
<object id="bndT_WL_MOVEXPENS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_WL_MOVEXPENS">
	<Param Name="BindInfo", Value='
		<C>Col=GBN_CD		Ctrl=txtGBN_CD	    Param=value		Disable=disabled</C>
		<C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	    Param=value		Disable=disabled</C>
		<C>Col=CD_NM		Ctrl=txtCD_NM      	Param=value		Disable=disabled</C>
		<C>Col=ITEM_NM		Ctrl=txtITEM_NM	    Param=value		Disable=disabled</C>
		<C>Col=COST1_AMT	Ctrl=txtCOST1_AMT	Param=value		Disable=disabled</C>
		<C>Col=COST2_AMT	Ctrl=txtCOST2_AMT	Param=value		Disable=disabled</C>
		<C>Col=COST3_AMT	Ctrl=txtCOST3_AMT   Param=value		Disable=disabled</C>
		<C>Col=CBM_AMT		Ctrl=txtCBM_AMT		Param=value		Disable=disabled</C>
		<C>Col=REMARK		Ctrl=txtREMARK     	Param=value		Disable=disabled</C>
    '>
</object>