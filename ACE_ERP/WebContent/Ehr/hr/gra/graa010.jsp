<!--
***********************************************************************
* @source      : graa010.jsp
* @description : �±������ڰ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/01/11      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�±������ڰ���(graa010)</title>
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
        var rai_ymd = getToday().substring(0,5)+"03-01";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var rai_yy = document.getElementById('txtRAI_YY_SHR').value;
			var eno_no = document.getElementById('txtENO_NO_SHR').value;

            //�ڵ尡 �������� �ʾ���
            //var reject_cd = document.getElementById('cmbREJECT_CD_SHR').value;

            if(!fnc_SearchItemCheck()) return;

			dsT_PM_NOGRADE.dataid = "/servlet/GauceChannelSVL?cmd=hr.gra.a.graa010.cmd.GRAA010CMD&S_MODE=SHR&RAI_YY="+rai_yy+"&ENO_NO="+eno_no+"&REJECT_CD=";
    		dsT_PM_NOGRADE.reset();

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_PM_NOGRADE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_PM_NOGRADE.GridToExcel("�±������ڰ���", '', 225);

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

			document.getElementById('txtRAI_YY_SHR').value = getTodayArray()[0];
			document.getElementById('txtENO_NO_SHR').value = "";
            document.getElementById('txtENO_NM_SHR').value = "";
			document.getElementById("resultMessage").innerText = ' ';

			dsT_PM_NOGRADE.ClearData();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_PM_NOGRADE.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);
			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			if(document.getElementById('txtRAI_YY_SHR').value == ""){
                alert("�±޿������� �Է��ϼ���!");
                document.getElementById('txtRAI_YY_SHR').focus();
                return false;
            }
            return true;

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
			cfStyleGrid(form1.grdT_PM_NOGRADE,0,"false","false");      // Grid Style ����

            document.getElementById('txtRAI_YY_SHR').value = getTodayArray()[0];
            document.getElementById('txtRAI_YY_SHR').focus();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_PM_NOGRADE)  |
    | 3. ���Ǵ� Table List(T_PM_NOGRADE)		     |
    +------------------------------------------------>
    <Object ID="dsT_PM_NOGRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_PM_NOGRADE)	|
    | 3. ���Ǵ� Table List(T_PM_NOGRADE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_PM_NOGRADE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    <!-- ���� �޺��� ���� DataSet -->
    <!-- ���ܱ��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_P2"/>
       <jsp:param name="CODE_GUBUN"    value="P2"/>
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
    <Script For=dsT_PM_NOGRADE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_PM_NOGRADE.CountRow);
        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_PM_NOGRADE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_PM_NOGRADE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
	        alert("�ش� �ʼ��Է��׸�[�±ޱ�����, ���]\n\n�Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
	        if(confirm("����� ���� �ߺ����� �����մϴ�.\n�ߺ��� �����͸� ���� �Ͻðڽ��ϱ�?")){
                dsT_PM_NOGRADE.DeleteRow(dsT_PM_NOGRADE.RowPosition);
            }
        }
        else {
		    cfErrorMsg(this);
	    }

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_PM_NOGRADE event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_PM_NOGRADE event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�±������ڰ���</td>
					<td align="right" class="navigator">HOME/�λ����/�±�/<font color="#000000">�±������ڰ���</font></td>
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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
									<col width="100"></col>
									<col width="60"></col>
									<col width=""></col>
								</colgroup>
							<tr>
								<td align="right" class="searchState">���س⵵&nbsp;</td>
								<td align="left" class="padding2423">
	                                <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
	                                    <tr>
	                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
	                                            <input type="text" id="txtRAI_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
	                                        </td>
	                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtRAI_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
	                                    </tr>
	                                    <tr>
	                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtRAI_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
	                                    </tr>
	                                </table>
								</td>
								<td align="right" class="searchState">���&nbsp;</td>
                                <td align="left" class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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
						<object	id="grdT_PM_NOGRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
							<param name="DataID"					value="dsT_PM_NOGRADE">
							<param name="Format"					value="
                                <C> id={currow}		width=29    name='NO'			align=center                     </C>
                                <C> id='REJECT_NM'  width=160   name='���ܱ���'     align=center  suppress=1         </C>
                                <C> id='DPT_NM'     width=100   name='�Ҽ�'         align=center                     </C>
                                <C> id='JOB_NM'     width=40    name='����'         align=center                     </C>
                                <C> id='ENO_NO'		width=70	name='���'			align=center                     </C>
                                <C> id='ENO_NM'		width=60	name='����'			align=center                     </C>
                                <C> id='RAI_YMD'    width=70    name='�±ޱ�����'   align=center   </C>
                                <C> id='HOB'		width=40	name='ȣ��'			align=center   </C>
                                <C> id='HIR_YMD'	width=70	name='�Ի���'	    align=center   </C>
                                <C> id='HBA_YMD'	width=70	name='�±���'	    align=center   </C>
                                <C> id='FPRO_YMD'	width=70	name='������'		align=center   </C>
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
<!-- ***** ���� ���̺� -->
<object id="bndT_PM_NOGRADE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_PM_NOGRADE">
    <Param Name="BindInfo", Value='
        <C>Col=RAI_YMD		Ctrl=txtRAI_YMD	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NO		Ctrl=txtENO_NO	      	Param=value		Disable=disabled</C>
        <C>Col=ENO_NM    	Ctrl=txtENO_NM	     	Param=value		</C>
        <C>Col=DPT_CD		Ctrl=hidDPT_CD      	Param=value		</C>
        <C>Col=DPT_NM		Ctrl=txtDPT_NM	      	Param=value		</C>
        <C>Col=PJOB_CD		Ctrl=hidPJOB_CD	     	Param=value		</C>
        <C>Col=JOB_NM		Ctrl=txtJOB_NM	     	Param=value		</C>
        <C>Col=HOB_CD		Ctrl=hidHOB_CD	     	Param=value		</C>
        <C>Col=HOB_NM		Ctrl=txtHOB_NM     	    Param=value		</C>
        <C>Col=YRP_CNT		Ctrl=txtYRP_CNT     	Param=value		</C>
        <C>Col=FINJ_CD		Ctrl=hidFINJ_CD     	Param=value		</C>
        <C>Col=FINJ_NM		Ctrl=txtFINJ_NM     	Param=value		</C>
        <C>Col=HIR_YMD		Ctrl=txtHIR_YMD   	    Param=value		</C>
        <C>Col=GHI_YMD		Ctrl=txtGHI_YMD    	    Param=value		</C>
        <C>Col=GRP_NAM		Ctrl=txtGRP_NAM    	    Param=value		</C>
        <C>Col=HBA_YMD		Ctrl=txtHBA_YMD    	    Param=value		</C>
        <C>Col=FPRO_YMD		Ctrl=txtFPRO_YMD   	    Param=value		</C>
        <C>Col=REPU_YMD		Ctrl=txtREPU_YMD   	    Param=value		</C>
        <C>Col=REJECT_CD	Ctrl=cmbREJECT_CD  	    Param=value		</C>
        <C>Col=OCC_CD	    Ctrl=hidOCC_CD  	    Param=value		</C>
        <C>Col=STTJ_CD	    Ctrl=hidSTTJ_CD  	    Param=value		</C>
    '>
</object>