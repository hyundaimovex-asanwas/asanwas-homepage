<!--
***********************************************************************
* @source      : crua060.jsp
* @description : ID, ��й�ȣ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/05      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>ID, ��й�ȣ ����(crua060)</title>
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

		var btnList = 'TFTTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			var pis_yy = document.getElementById("txtPIS_YY_SHR").value;
			var seq_no = document.getElementById("txtSEQ_NO_SHR").value;
            var id_tag = document.getElementById("txtID_TAG_SHR").value;
			var sch_tag = document.getElementById("txtSCH_TAG_SHR").value;

			dsT_RC_IDENTITY.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua070.cmd.CRUA070CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&SEQ_NO="+seq_no+"&ID_TAG="+id_tag+"&SCH_TAG="+sch_tag;
    		dsT_RC_IDENTITY.reset();

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

				trT_RC_IDENTITY.KeyValue = "tr01(I:dsT_RC_IDENTITY=dsT_RC_IDENTITY)";
				trT_RC_IDENTITY.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua070.cmd.CRUA070CMD&S_MODE=SAV";
				trT_RC_IDENTITY.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_RC_IDENTITY.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[���̵�:"+dsT_RC_IDENTITY.NameValue(dsT_RC_IDENTITY.RowPosition,'ID_TAG')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_RC_IDENTITY.DeleteRow(dsT_RC_IDENTITY.RowPosition);
				trT_RC_IDENTITY.KeyValue = "tr01(I:dsT_RC_IDENTITY=dsT_RC_IDENTITY)";
				trT_RC_IDENTITY.action = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua070.cmd.CRUA070CMD&S_MODE=DEL";
				trT_RC_IDENTITY.post();
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

            document.getElementById("txtCOUNT_NO").value = "";
            document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";
            document.getElementById("txtID_TAG_SHR").value = "";
			document.getElementById("txtSCH_TAG_SHR").value = "";

			document.getElementById("resultMessage").innerText = ' ';

			dsT_RC_IDENTITY.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_RC_IDENTITY.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var year = document.getElementById("txtPIS_YY_SHR");
			var seq = document.getElementById("txtSEQ_NO_SHR");

            if(year == "" || year.value.length < 4){
                alert("4�ڸ��� ä��⵵�� �ݵ�� �Է��ϼž� �մϴ�!");
                year.focus();
                return false;
            }
            if(seq == "" || seq.value.length < 2) {
                alert("2�ڸ��� ä�������� �ݵ�� �Է��ϼž� �մϴ�!");
                seq.focus();
                return false;
            }

			return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_RC_IDENTITY.IsUpdated ) {
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

            document.getElementById("txtPIS_YY_SHR").value = getToday().substring(0,4);
			document.getElementById("txtSEQ_NO_SHR").value = "01";

			cfStyleGrid(form1.grdT_RC_IDENTITY,15,"false","false");      // Grid Style ����

            document.getElementById('txtPIS_YY_SHR').focus();

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		/**************************
         * 16. ID, ��й�ȣ ����  *
         *************************/
		function fnc_createId() {

            var ranId;	//���̵�
			var passWd;	//�н�����
            var count = document.getElementById("txtCOUNT_NO");//��������
            var temp_year = document.getElementById("txtPIS_YY").value;
            var temp_seq = document.getElementById("txtSEQ_NO").value;

            if(document.getElementById("txtPIS_YY").value == ""){
                alert("��ȸ �� ID ������ �����մϴ�!");
                return;
            }
            if(count.value == ""){
                alert("������ ID�� ������ �Է��ϼ���!");
                count.focus();
                return;
            }

            for(k=0;k<count.value;k++){

                ranId = false;
                passWd = '';

                while(ranId == false) {
                    ranId = fnc_rand();//ID����
                }

                for(j=0;j<6;j++){//��й�ȣ����
   	                passWd = passWd + Math.floor(Math.random()*10);
                    //if( (Math.floor(Math.random()*2)) == 0 ){
                    //    passWd = passWd + String.fromCharCode(Math.random()*26+65);
                    //    passWd = passWd + String.fromCharCode(Math.random()*26+65);
                    //} else {
                    //    passWd = passWd + Math.floor(Math.random()*10);
                    //}
                }

                dsT_RC_IDENTITY.AddRow();

                dsT_RC_IDENTITY.NameValue(dsT_RC_IDENTITY.RowPosition,'PIS_YY') = temp_year;
                dsT_RC_IDENTITY.NameValue(dsT_RC_IDENTITY.RowPosition,'SEQ_NO') = temp_seq;
                dsT_RC_IDENTITY.NameValue(dsT_RC_IDENTITY.RowPosition,'ID_TAG') = ranId;
                dsT_RC_IDENTITY.NameValue(dsT_RC_IDENTITY.RowPosition,'PW_TAG') = passWd;

            }


		}

		/**************************
         * 17. ID ����(�ߺ�����)  *
         *************************/
		function fnc_rand() {

			var temp = document.getElementById("txtPIS_YY").value + document.getElementById("txtSEQ_NO").value + Math.floor(Math.random()*90001+9999);

			for(i=1;i<dsT_RC_IDENTITY.CountRow;i++){
				if(dsT_RC_IDENTITY.NameValue(i,'ID_TAG') == temp){
					return false;
				}
			}

			return temp;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_RC_IDENTITY) |
    | 3. ���Ǵ� Table List(T_RC_IDENTITY)		     |
    +------------------------------------------------>
    <Object ID="dsT_RC_IDENTITY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_RC_IDENTITY)	|
    | 3. ���Ǵ� Table List(T_RC_IDENTITY)	            |
    +--------------------------------------------------->
    <Object ID ="trT_RC_IDENTITY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_RC_IDENTITY Event="OnLoadCompleted(iCount)">

        document.getElementById("txtPIS_YY").value = document.getElementById("txtPIS_YY_SHR").value;
		document.getElementById("txtSEQ_NO").value = document.getElementById("txtSEQ_NO_SHR").value;

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_RC_IDENTITY Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_RC_IDENTITY Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[���̵�] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[ä��⵵/����/���̵�]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_RC_IDENTITY event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_RC_IDENTITY event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ID, ��й�ȣ ����</td>
					<td align="right" class="navigator">HOME/��Ÿ/ä�����/<font color="#000000">ID, ��й�ȣ ����</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="60"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="80"></col>
								<col width="*"></col>
							</colgroup>
							<tr>
								<td align="center" class="searchState">ä��⵵&nbsp;</td>
								<td class="padding2423">
									<input id="txtPIS_YY_SHR" size="4" maxLength="4" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY_SHR','','5','170');"></a>
								</td>
								<td align="center" class="searchState">ä������&nbsp;</td>
								<td class="padding2423">
									<input id="txtSEQ_NO_SHR" size="4" maxLength="2" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">
								</td>
                                <td align="center" class="searchState">���̵�&nbsp;</td>
								<td class="padding2423">
									<input id="txtID_TAG_SHR" size="11" maxLength="11" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfNumberCheck();">
								</td>
                                <td align="center" class="searchState">�б�&nbsp;</td>
								<td class="padding2423">
									<input id="txtSCH_TAG_SHR" size="20" maxLength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
								</td>
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
					<col width="35"></col>
					<col width="80"></col>
					<col width="35"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">ä��⵵</td>
					<td class="padding2423"><input id="txtPIS_YY" size="11" class="input_ReadOnly" readOnly></td>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423"><input id="txtSEQ_NO" size="4" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">��  ��</td>
					<td class="padding2423" colspan="3"><input id="txtCOUNT_NO" size="7" maxLength="4" style="ime-mode:disabled;text-align:right" onkeypress="cfNumberCheck();"> <input type="button" value="�� ��" onClick="fnc_createId();"></td>
                </tr>
                <tr>
					<td align="center" class="creamBold">�� �� ��</td>
					<td class="padding2423"><input id="txtID_TAG" size="11" class="input_ReadOnly" readOnly></td>
					<td align="center" class="creamBold">��й�ȣ</td>
					<td class="padding2423"><input id="txtPW_TAG" size="6" class="input_ReadOnly" readOnly></td>
                    <td align="center" class="creamBold">��  ��</td>
					<td class="padding2423"><input id="txtSCH_TAG" size="17" onkeyup="fc_chk_byte(this,20);"></td>
					<td align="center" class="creamBold">��  ��</td>
					<td class="padding2423"><input id="txtREMARK" size="35" onkeyup="fc_chk_byte(this,20);"></td>
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
						<object	id="grdT_RC_IDENTITY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:340px;">
							<param name="DataID"					value="dsT_RC_IDENTITY">
							<param name="Format"					value="
								<C> id={currow}		width=50    name='NO'			align=center value={String(currow)} </C>
								<C> id='PIS_YY'		width=100	name='ä��⵵'		align=center </C>
								<C> id='SEQ_NO'		width=80	name='����'			align=center </C>
								<C> id='ID_TAG'		width=120	name='���̵�'		align=center </C>
								<C> id='PW_TAG'		width=100	name='��й�ȣ'		align=center </C>
                                <C> id='SCH_TAG'	width=150	name='�б�'		    align=left </C>
								<C> id='REMARK'		width=160	name='���'			align=left </C>
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
<!-- ä�������� ���̵�� ��й�ȣ ���� ���̺� -->
<object id="bndT_RC_IDENTITY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_RC_IDENTITY">
	<Param Name="BindInfo", Value='
		<C>Col=PIS_YY		Ctrl=txtPIS_YY	      	Param=value		</C>
		<C>Col=SEQ_NO    	Ctrl=txtSEQ_NO	     	Param=value		</C>
		<C>Col=ID_TAG		Ctrl=txtID_TAG      	Param=value		</C>
		<C>Col=PW_TAG		Ctrl=txtPW_TAG	      	Param=value		</C>
        <C>Col=SCH_TAG		Ctrl=txtSCH_TAG	      	Param=value		</C>
		<C>Col=REMARK		Ctrl=txtREMARK	     	Param=value		</C>
    '>
</object>