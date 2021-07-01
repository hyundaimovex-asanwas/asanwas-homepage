<!--
*****************************************************
* @source      : weln020.jsp
* @description : ����ī�峻��
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2011/12/01      �̵���                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>����ī�峻��</title>
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
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
        var today = getToday();


        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�˻�����
            var CON_YMD_SHR    	= document.getElementById("txtCON_YMD_SHR").value;
            var ENO_NO_SHR   	= document.getElementById("txtENO_NO_SHR").value;


            //�����ͼ� ����
            dsT_WL_WELCARD.UseChangeInfo = true;
            dsT_WL_WELCARD.DataID = "/servlet/GauceChannelSVL?cmd=hr.wel.n.weln020.cmd.WELN020CMD&S_MODE=SHR&CON_YMD_SHR="+CON_YMD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_WL_WELCARD.Reset();

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

            if (dsT_WL_WELCARD.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_WL_WELCARD.GridToExcel("����ī���볻��", '', 225);
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

			dsT_WL_WELCARD.ClearData();

	        fnc_OnLoadProcess();

			//document.getElementById("resultMessage").innerText = ' ';

            fncClearSearch();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_WL_WELCARD.IsUpdated)  {

				if (!fnc_ExitQuestion()) return;

			}

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck(year) {

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

            var oSelect = null;
            var oOption = null;

			cfStyleGrid(form1.grdT_WL_WELCARD,15,"false","false")      // Grid Style ����

            document.getElementById("txtCON_YMD_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];

        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /**
         * ��¥ ���� ��ȿ�� üũ
         */
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

        /**
         * �Է�â�� ������ ����.
         */
        function fncClearSearch() {
            //�ʱ�ȭ ��ų �Է�â
            var inputFields = new Array( "txtHEAD_CD_SHR","txtHEAD_NM_SHR","txtDPT_CD_SHR","txtDPT_NM_SHR","txtENO_NO_SHR","txtENO_NM_SHR");

            for(i=0; i<inputFields.length; i++) {
                document.getElementById(inputFields[i]).value = "";
            }

        }

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_WL_WELCARD                      |
    | 3. Table List : T_WL_CARD_STS                 |
    +----------------------------------------------->
    <Object ID="dsT_WL_WELCARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
		<PARAM NAME="SubsumExpr"		VALUE="total,2:HEAD_NM,1:DPT_NM">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet - ��������                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_V2"/>
       <jsp:param name="CODE_GUBUN"    value="V2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet - �ٷα��б���                                         |
    +------------------------------------------------------>
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
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
    <Script For=dsT_WL_WELCARD Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_WL_WELCARD Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_WL_WELCARD Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_WL_WELCARD event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_WL_WELCARD event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ī�峻��</td>
					<td align="right" class="navigator">HOME/�����Ļ�/����ī��/<font color="#000000">����ī�峻��</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="70"></col>
                                <col width="90"></col>
                                <col width="60"></col>
                                <col width="140"></col>
                                <col width="60"></col>
                                <col width="140"></col>
                                <col width="60"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">������</td>
                                <td class="padding2423">
                                    <input type="text" id="txtCON_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtCON_YMD_SHR','','80','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>

                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input name=txtENO_NO_SHR size="6" maxlength="6" style="ime-mode:disabled" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();" onChange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                    <input name=txtENO_NM_SHR size="6" class="input_ReadOnly" readonly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')"></a>
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
<table width="520" border="0" cellspacing="0" cellpadding="0">
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
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_WL_WELCARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
							<param name="DataID"				value="dsT_WL_WELCARD">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <FC> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</FC>
								<FC> Name='����'			ID=HEAD_NM		HeadAlign=Center HeadBgColor=#B9D4DC width=80 	align=left,    bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true, suppress=2  Value={Decode(CurLevel,2,'���ΰ�',9999,'�Ѱ�',0,HEAD_NM)}</FC>
								<FC> Name='�μ�'			ID=DPT_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=110 	align=left,   	bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true , suppress=1 Value={Decode(CurLevel,1,'�Ұ�',0,DPT_NM)}</FC>
								<FC> Name='��'				ID=TEAM_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 	align=left,	 	bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true </FC>
								<FC> Name='����'			ID=ENO_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left,		 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, sort=true </FC>
								<C> Name='��������'			ID=APPDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center,  bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, edit=none,  Mask=XXXX-XX-XX, sort=true </C>
								<C> Name='����'			ID=REQAMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=Right,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true </C>
								<C> Name='������'			ID=MEMBER		HeadAlign=Center HeadBgColor=#B9D4DC Width=160 	align=left,   	bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true </C>
								<C> Name='����'		      	ID=TAXGB		HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left,		 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,EditStyle=Combo Data='N:����,Y:�����' sort=true </C>
								<C> Name='����Ȯ������'		ID=SALEDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=center, 	bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, Mask=XXXX-XX-XX, sort=true </C>
								<C> Name='��������'			ID=SETTDT		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=center,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none, Mask=XXXX-XX-XX, sort=true </C>
								<C> Name='�Ϸù�ȣ'			ID=SEQID		HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center,	 bgcolor={Decode(CurLevel,1,'#ffffcc',2,'#CCFFCC',9999,'#C3D0DB')}, Edit=none,sort=true, Value={String(SEQID)} </C>
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

