<!--
***********************************************************************
* @source      : crua060.jsp
* @description : ���������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/12      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����������(crua060)</title>
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

			dsT_CM_SVCHARGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.a.etca020.cmd.ETCA020CMD&S_MODE=SHR";
    		dsT_CM_SVCHARGE.reset();

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

            trT_CM_SVCHARGE.KeyValue = "tr01(I:dsT_CM_SVCHARGE=dsT_CM_SVCHARGE)";
			trT_CM_SVCHARGE.action = "/servlet/GauceChannelSVL?cmd=hr.etc.a.etca020.cmd.ETCA020CMD&S_MODE=SAV";
			trT_CM_SVCHARGE.post();

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			if(dsT_CM_SVCHARGE.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				return;
			}
			if(confirm("[�Ϸù�ȣ:"+dsT_CM_SVCHARGE.NameValue(dsT_CM_SVCHARGE.RowPosition,'SEQ_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				dsT_CM_SVCHARGE.DeleteRow(dsT_CM_SVCHARGE.RowPosition);
				trT_CM_SVCHARGE.KeyValue = "tr01(I:dsT_CM_SVCHARGE=dsT_CM_SVCHARGE)";
				trT_CM_SVCHARGE.action = "/servlet/GauceChannelSVL?cmd=hr.etc.a.etca020.cmd.ETCA020CMD&S_MODE=DEL";
				trT_CM_SVCHARGE.post();
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
			if(dsT_CM_SVCHARGE.CountColumn < 1){
				// �����ͼ��� ��� ���� ����.
				dsT_CM_SVCHARGE.setDataHeader("SEQ_NO:STRING:KEYVALUE, SVC_TAG:STRING, ENO_NO:STRING, PHN_NO:STRING, REMARK:STRING");
			}

            dsT_CM_SVCHARGE.AddRow();

            document.getElementById("txtSEQ_NO").focus();



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

			document.getElementById("resultMessage").innerText = ' ';

			dsT_CM_SVCHARGE.ClearData();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_CM_SVCHARGE.IsUpdated)  {

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

			if (!dsT_CM_SVCHARGE.IsUpdated ) {
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

            cfStyleGrid(form1.grdT_CM_SVCHARGE_INS,0,"false","false");      // Grid Style ����

			//���� ��ȸ
			dsT_CM_EMPLIST.DataID = "/servlet/GauceChannelSVL?cmd=hr.etc.a.etca020.cmd.ETCA020CMD&S_MODE=SHR_01";
			dsT_CM_EMPLIST.Reset();

            fnc_SearchList();


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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_SVCHARGE) |
    | 3. ���Ǵ� Table List(T_CM_SVCHARGE)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_SVCHARGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                                                      |
    | 2. �̸� : dsT_CM_EMPLIST                                       |
    | 3. Table List : T_CM_EMPLIST                                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_EMPLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_CM_SVCHARGE)	|
    | 3. ���Ǵ� Table List(T_CM_SVCHARGE)	            |
    +--------------------------------------------------->
    <Object ID ="trT_CM_SVCHARGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CM_SVCHARGE Event="OnLoadCompleted(iCount)">

        if (iCount > 0)    {

            var row = Math.round(iCount/2);
            var contents = "";

            //CONTENTS �� ��ȸ�� �����͸� �Է��Ͽ� ���̺��� ����
            for(i=1;i<=row;i++){
                contents = contents+"<table width='90%' border='1' cellspacing='0' cellpadding='0'>";

                contents = contents+"<tr><td class='orangeBold' width='350'>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2-1,'SVC_TAG')+"</td>";
                contents = contents+"<td rowspan='3'></td>";
                if(iCount >= i*2){
                    contents = contents+"<td class='orangeBold' width='350'>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2,'SVC_TAG')+"</td></tr>";
                }else{
                    contents = contents+"<td class='orangeBold' width='350'>&nbsp;</td></tr>";
                }//end row 1

                contents = contents+"<tr><td>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2-1,'DPT_NM')+" "+dsT_CM_SVCHARGE.NameValue(i*2-1,'ENO_NM')+" "+dsT_CM_SVCHARGE.NameValue(i*2-1,'JOB_NM')+" (�� "+dsT_CM_SVCHARGE.NameValue(i*2-1,'PHN_NO')+")</td>";
                if(iCount >= i*2){
                    contents = contents+"<td>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2,'DPT_NM')+" "+dsT_CM_SVCHARGE.NameValue(i*2,'ENO_NM')+" "+dsT_CM_SVCHARGE.NameValue(i*2,'JOB_NM')+" (�� "+dsT_CM_SVCHARGE.NameValue(i*2,'PHN_NO')+")</td></tr>";
                }else{
                    contents = contents+"<td>&nbsp;</td></tr>";
                }//end row 2

                contents = contents+"<tr><td>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2-1,'REMARK')+"</td>";
                if(iCount >= i*2){
                    contents = contents+"<td>&nbsp;"+dsT_CM_SVCHARGE.NameValue(i*2,'REMARK')+"</td></tr>";
                }else{
                    contents = contents+"<td>&nbsp;</td></tr>";
                }//end row 3

                contents = contents+"<br></table>";
            }

            //document.getElementById("CONTENTS").innerHTML = contents;

        }

    </Script>

   <Script For=dsT_CM_EMPLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			//fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            var i = 1;
	        var oROLE_CD = dsT_CM_EMPLIST.NameValue(i,"ROLE_CD");

			//�����ڰ� �ƴϸ� �׸��� �� ���� �κ� �ʺ��δ�.
	        if(oROLE_CD != "1001"
                    && oROLE_CD != "1002"){
				document.getElementById("Image3").style.display = "none";
				document.getElementById("Image2").style.display = "none";
				document.getElementById("Image4").style.display = "none";
				document.getElementById("Image1").style.display = "none";
				document.getElementById("Image5").style.display = "none";
				document.getElementById("divETCA020_01").style.display = "none";
				//document.getElementById("divETCA020_02").style.display = "none";
	        }

        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_SVCHARGE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_SVCHARGE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		//Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�Ϸù�ȣ] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        alert("[�Ϸù�ȣ]�� ���� �ߺ����� �����մϴ�. Ȯ�ιٶ��ϴ�.");
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_CM_SVCHARGE event="OnSuccess()">
        fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_CM_SVCHARGE event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����������</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">�����������</font></td>
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
<div id="divETCA020_01">
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="35"></col>
                    <col width="80"></col>
                    <col width="35"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�Ϸù�ȣ</td>
                    <td class="padding2423"><input id="txtSEQ_NO" size="4" maxLength="2" style="ime-mode:disabled" onKeyPress="cfCheckNumber();"></td>
                    <td align="center" class="creamBold">��������</td>
                    <td class="padding2423"><input id="txtSVC_TAG" size="40" onkeyup="fc_chk_byte(this,50);"></td>
                    <td align="center" class="creamBold">�����</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name=txtENO_NO size="10" maxlength="10" style="ime-mode:disabled" onkeypress="cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO','txtENO_NM','1','1');">
                        <input id="txtENO_NM" name=txtENO_NM size="8" class="input_ReadOnly" readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="Image15" width="21" height="20" border="0" align="absmiddle" onclick="javascript:if(txtENO_NO.disabled == true){ return; } fnc_empl2Popup('txtENO_NO','txtENO_NM')"></a>
                     </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">��ȭ��ȣ</td>
                    <td class="padding2423"><input id="txtPHN_NO" size="15" maxLength="15" style="ime-mode:disabled" onKeyPress="cfCheckNumber();"></td>
                    <td align="center" class="creamBold">�� ��</td>
                    <td class="padding2423" colspan="3"><input id="txtREMARK" size="80" onkeyup="fc_chk_byte(this,200);"></td>
                </tr>
			</table>
		</td>
	</tr>
</table>
</div>
<!-- ���� �Է� ���̺� �� -->

<!-- TITLE ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="paddingTop8">
			<table width="30%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td align="center" class="orangeBold"><FONT SIZE="2">������ ����� ��ȭ��ȣ</FONT></td>
                </tr>
			</table>
		</td>
	</tr>
</table>
<!-- TITLE ���̺� �� -->

<!-- CONTENTS ���̺� ���� -->
<!--
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="paddingTop8">
			<span id="CONTENTS">&nbsp;</span>
		</td>
	</tr>
</table>
-->
<!-- CONTENTS ���̺� �� -->

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
<div id="divETCA020_02">
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_CM_SVCHARGE_INS" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:180px;">
							<param name="DataID"					value="dsT_CM_SVCHARGE">
							<param name="ToolTip"		value="use=true;">
							<param name="Format"					value="
								<C> id='SEQ_NO'	    width=30	name='��ȣ'	        align=center </C>
								<C> id='SVC_TAG'    width=180	name='������'	        align=left </C>
								<C> id='ENO_NM' 	width=60	name='�����'		    align=center </C>
								<C> id='PHN_NO' 	width=60	name='��ȭ��ȣ'	        align=center </C>
								<C> id='REMARK'	    width=450	name='�� ��'		tooltipshow=true     align=left </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
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
<!-- ������ ����� ��ȭ��ȣ ���̺� -->
<object id="bndT_CM_SVCHARGE_INS" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_SVCHARGE">
	<Param Name="BindInfo", Value='
        <C>Col=SEQ_NO		Ctrl=txtSEQ_NO	      	Param=value		Disable=disabled</C>
        <C>Col=SVC_TAG    	Ctrl=txtSVC_TAG	     	Param=value		Disable=disabled</C>
        <C>Col=ENO_NO		Ctrl=txtENO_NO      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NM		Ctrl=txtENO_NM      	Param=value		Disable=disabled</C>
        <C>Col=PHN_NO		Ctrl=txtPHN_NO	      	Param=value		Disable=disabled</C>
        <C>Col=REMARK		Ctrl=txtREMARK	      	Param=value		Disable=disabled</C>
    '>
</object>