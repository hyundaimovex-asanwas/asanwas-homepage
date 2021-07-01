<!--
*****************************************************
* @source       : buta070.jsp
* @description : �������ޱ��� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2016/06/01      �̵���        ERP �̻�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�������ޱ���</title>
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


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			dsT_DI_BUSINESSTRIP_BASIS.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=SHR&BASIC_YMD";
			dsT_DI_BUSINESSTRIP_BASIS.reset();

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

			if(!fnc_SaveItemCheck()) return;

			trT_DI_BUSINESSTRIP_BASIS.KeyValue = "tr01(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=SAV";
			trT_DI_BUSINESSTRIP_BASIS.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_DI_BUSINESSTRIP_BASIS.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                return;
            }

            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_DI_BUSINESSTRIP_BASIS.ColumnString(dsT_DI_BUSINESSTRIP_BASIS.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_DI_BUSINESSTRIP_BASIS.DeleteRow(dsT_DI_BUSINESSTRIP_BASIS.RowPosition);

			trT_DI_BUSINESSTRIP_BASIS.KeyValue = "SVL(I:dsT_DI_BUSINESSTRIP_BASIS=dsT_DI_BUSINESSTRIP_BASIS)";
			trT_DI_BUSINESSTRIP_BASIS.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.but.a.buta070.cmd.BUTA070CMD&S_MODE=DEL";
			trT_DI_BUSINESSTRIP_BASIS.post();

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
            if (dsT_DI_BUSINESSTRIP_BASIS.CountColumn == 0) {
                dsT_DI_BUSINESSTRIP_BASIS.setDataHeader("GBN_CD:STRING:KEYVALUETYPE,GBN_NAME:STRING,EXP_AMT1:DECIMAL,EXP_AMT2:DECIMAL,EXP_AMT3:DECIMAL,EXP_AMT4:DECIMAL,EXP_AMT5:DECIMAL,EXP_AMT6:DECIMAL");
            }

			enableInput();// �Է��ʵ� Ȱ��ȭ
            dsT_DI_BUSINESSTRIP_BASIS.AddRow();
            document.form1.txtGBN_CD.focus();

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

	        fnc_OnLoadProcess();
			dsT_DI_BUSINESSTRIP_BASIS.ClearData();
			document.getElementById("resultMessage").innerText = ' ';

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_DI_BUSINESSTRIP_BASIS.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

            window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_BUSINESSTRIP_BASIS.IsUpdated) {
				
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

			cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_BASIS,15,"false","false")      // Grid Style ����

			disableInput();//�Է��ʵ� ��Ȱ��ȭ

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){

			document.form1.txtGBN_NAME.readOnly = false;
  			document.form1.txtGBN_NAME.className = "";

  			form1.medEXP_AMT1.Enable = "true";
  			form1.medEXP_AMT2.Enable = "true";
  			form1.medEXP_AMT3.Enable = "true";
  			form1.medEXP_AMT4.Enable = "true";
  			form1.medEXP_AMT5.Enable = "true";
  			form1.medEXP_AMT6.Enable = "true";

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

			document.form1.txtGBN_NAME.readOnly = true;
  			document.form1.txtGBN_NAME.className = "input_ReadOnly";

  			form1.medEXP_AMT1.Enable = "false";
  			form1.medEXP_AMT2.Enable = "false";
  			form1.medEXP_AMT3.Enable = "false";
  			form1.medEXP_AMT4.Enable = "false";
  			form1.medEXP_AMT5.Enable = "false";
  			form1.medEXP_AMT6.Enable = "false";
  		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_BUSINESSTRIP_BASIS                      |
    | 3. Table List : T_DI_BUSINESSTRIP_BASIS                  |
    +----------------------------------------------->
    <Object ID="dsT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_BUSINESSTRIP_BASIS)		|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_BASIS)	            |
    +--------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_BASIS" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
	        enableInput();//�Է��ʵ� Ȱ��ȭ
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_BUSINESSTRIP_BASIS Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[������/�ټӳ��] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("������/�ټӳ���� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_BASIS event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | row��ġ �����            |
    +--------------------------->
	<script language=JavaScript for=dsT_DI_BUSINESSTRIP_BASIS event=OnRowPosChanged(row)>
		var SysStatus = dsT_DI_BUSINESSTRIP_BASIS.SysStatus(row);

		if(SysStatus == "1"){
			document.form1.txtGBN_CD.readOnly = false;
  			document.form1.txtGBN_CD.className = "";
		}else{
			document.form1.txtGBN_CD.readOnly = true;
  			document.form1.txtGBN_CD.className = "input_ReadOnly";
		}

	</script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)"><img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width="130"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423">
						<input id="txtGBN_CD" style="width:100%" maxLength="2">
					</td>
					<td align="center" class="blueBold">��&nbsp;��&nbsp;��</td>
					<td class="padding2423">
						<input id="txtGBN_NAME" style="width:100%" maxLength="12">
					</td>
					<td align="center" class="blueBold">�ӿ��ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT1" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">����ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT2" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">����ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT3" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">����ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT4" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">�븮�ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT5" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" class="blueBold">����ޱݾ�</td>
					<td class="padding2423">
						<comment id="__NSID__"><object id="medEXP_AMT6" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
							<param name=Alignment					value=2>
							<param name=Border						value=true>
							<param name=ClipMode					value=true>
							<param name=DisabledBackColor	value="#EEEEEE">
							<param name=Enable						value=false>
							<param name=IsComma					value=true>
							<param name=Language					value=0>
							<param name=MaxLength				value=12>
							<param name=Numeric					value=true>
							<param name=ShowLiteral				value="false">
							<param name=Visible						value="true">
							<param name=SelectAll					value="true">
						</object></comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_BUSINESSTRIP_BASIS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"				value="dsT_DI_BUSINESSTRIP_BASIS">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'			width=50			name='����'						align=center			value={String(Currow)}					</C>
								<C> id='GBN_CD'				width=90			name='�ڵ�'						align=center													</C>
								<C> id='GBN_NAME'			width=150			name='�ڵ��'					align=center													</C>
								<C> id='EXP_AMT1'			width=110			name='�ӿ��ޱݾ�'				align=right														</C>
								<C> id='EXP_AMT2'			width=110			name='����ޱݾ�'				align=right														</C>
								<C> id='EXP_AMT3'			width=110			name='����ޱݾ�'				align=right														</C>
								<C> id='EXP_AMT4'			width=110			name='����ޱݾ�'				align=right														</C>
								<C> id='EXP_AMT5'			width=110			name='�븮�ޱݾ�'				align=right														</C>
								<C> id='EXP_AMT6'			width=110			name='����ޱݾ�'				align=right														</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_DI_BUSINESSTRIP_BASIS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_BUSINESSTRIP_BASIS">
	<Param Name="BindInfo", Value='
		<C>Col=GBN_CD		   		Ctrl=txtGBN_CD      				Param=value 		</C>
		<C>Col=GBN_NAME			Ctrl=txtGBN_NAME	  	  		Param=value			</C>
		<C>Col=EXP_AMT1   	 		Ctrl=medEXP_AMT1		 		Param=text			</C>
		<C>Col=EXP_AMT2			Ctrl=medEXP_AMT2		 		Param=text			</C>
		<C>Col=EXP_AMT3			Ctrl=medEXP_AMT3				Param=text			</C>
		<C>Col=EXP_AMT4			Ctrl=medEXP_AMT4				Param=text			</C>
		<C>Col=EXP_AMT5			Ctrl=medEXP_AMT5				Param=text			</C>
		<C>Col=EXP_AMT6			Ctrl=medEXP_AMT6				Param=text			</C>
    '>
</object>