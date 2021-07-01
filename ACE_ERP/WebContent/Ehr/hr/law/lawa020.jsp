<!--
*****************************************************
* @source       : lawa020.jsp
* @description : HRMS PAGE :: ��������_��ü������ȸ
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/12/14      ������        �����ۼ�.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.JSPUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��ü������ȸ</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->

<script language="javascript" >

		var btnList = 'TFFTFFTT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            //�����ͼ� ����
            dsT_LW_BONDLIST.DataID  = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa020.cmd.LAWA020CMD&S_MODE=SHR"
                                    + "&txtHEAD_CD_SHR="+document.getElementById("txtHEAD_CD_SHR").value
				                    + "&txtBOND_GBN_SHR="+document.getElementById("txtBOND_GBN_SHR").value
				                    + "&txtEVENT_NM_SHR="+document.getElementById("txtEVENT_NM_SHR").value
                                    + "&txtHIS_CONT_NM_SHR="+document.getElementById("txtHIS_CONT_NM_SHR").value
				                    + "&txtORD_YMD_STR_SHR="+document.getElementById("txtORD_YMD_STR_SHR").value
				                    + "&txtORD_YMD_END_SHR="+document.getElementById("txtORD_YMD_END_SHR").value
                                    + "&cmbGBN_CD="+document.getElementById("cmbGBN_CD").value;

            dsT_LW_BONDLIST.Reset();


            document.getElementById("txtResult").innerHTML ="<u><b>"+ " �Ϸ� : " + dsT_LW_BONDLIST.NameSum("END_CNT", 0, 0) + "��"  + "&nbsp;&nbsp;&nbsp;" +
                                                             "���� : " + (dsT_LW_BONDLIST.CountRow - dsT_LW_BONDLIST.NameSum("END_CNT", 0, 0)) + "�� " +"</b></u>";


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
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_LW_BONDLIST.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");//�޼����� �����ε� ������ �������
                return;
            }
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + dsT_LW_BONDLIST.ColumnString(dsT_LW_BONDLIST.RowPosition,2) + "] �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_LW_BONDLIST.DeleteRow(dsT_LW_BONDLIST.RowPosition);
			trT_LW_BONDLIST.Action = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa020.cmd.LAWA020CMD&S_MODE=DEL";
			trT_LW_BONDLIST.post();
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

	        document.getElementById("txtHEAD_CD_SHR").value = "";
	        document.getElementById("txtHEAD_NM_SHR").value = "";
			document.getElementById("txtBOND_GBN_SHR").value = "";
			document.getElementById("txtBOND_GBN_NM_SHR").value = "";
			document.getElementById("txtEVENT_NM_SHR").value = "";
            document.getElementById("txtHIS_CONT_NM_SHR").value = "";
            document.getElementById("txtResult").innerText = "";
            document.form1.cmbGBN_CD.selectedIndex  = 0;

			dsT_LW_BONDLIST.ClearData();
			document.form1.txtHEAD_CD_SHR.focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        if (dsT_LW_BONDLIST.IsUpdated)  {

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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {
            //Grid Style ����
            cfStyleGrid(form1.grdT_LW_BONDLIST,15,"false","right");

<%
    //������ �������� ������ �̰ų� IT �� �ƴϸ� �Ҽ� ���θ� ��ȸ ���� - M ������, A ���μ�, S �ҼӺμ�
    //�λ� ������(1002)�� ������ ����
    if(box.get("SESSION_LAW_AUTHO").equals("S")) {
%>
            //�ҼӺμ��� �����ڵ带 ��ȸ
            fnc_GetHeadCd();

            fnc_ChangeStateElement(false, "txtHEAD_CD_SHR");
            fnc_ChangeStateElement(false, "img_HelpOn1");
<%
    }
%>
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

        /****************************************
         * �˻����� �ʵ� ����� �����÷� �ʱ�ȭ *
         ***************************************/
        function fnc_FldChange() {

        }

        /**
         * �ҼӺμ��� ���θ� ��ȸ�Ѵ�.
         */
        function fnc_GetHeadCd(){

            if (document.all("coCommNmGDS") == null) {
                dataSet = document.createElement("<OBJECT>");
                dataSet.classid = "CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB";
                dataSet.id = "coCommNmGDS";
                dataSet.SyncLoad = "true";

                for (var i = 0; i < document.all.length; i++) {
                    if (document.all[i].tagName == "HEAD") {
                        document.all[i].insertAdjacentElement("beforeEnd", dataSet);
                        break;
                    }
                }
            } else {
                dataSet = document.all("coCommNmGDS");
            }

            svl = "/servlet/GauceChannelSVL?cmd=common.commnm.cmd.COMMNMCMD&S_MODE=SHR" +
                  "&CD_GBN=" + "A4" +
                  "&COMM_CD=<%=box.get("SESSION_DPTCD") %>" +
                  "&UP_CD=" + "";
            dataSet.DataId = svl;
            dataSet.Reset();

            if (dataSet.countrow > 0)   {
                document.getElementById("txtHEAD_CD_SHR").value   = dataSet.NameValue(0,"UP_CD");
                fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR');
            }
        }

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_LW_BONDLIST                                     |
    | 3. Table List : T_LW_BONDLIST                                |
    +----------------------------------------------->
    <Object ID="dsT_LW_BONDLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_LW_BONDLIST                                       |
    | 3. Table List : T_LW_BONDLIST                                 |
    +----------------------------------------------->
    <Object ID ="trT_LW_BONDLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
			<Param Name=KeyValue     Value="SVL(I:dsT_LW_BONDLIST=dsT_LW_BONDLIST)">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_LW_BONDLIST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_LW_BONDLIST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_LW_BONDLIST event="OnSuccess()">
	    fnc_Message(document.getElementById("resultMessage"), "MSG_01");

    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_LW_BONDLIST event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�      |
    +------------------------------->
	<script language=JavaScript for=grdT_LW_BONDLIST event="OnDblClick(row,colid)">

		if(row < 1) {
			return;
		} else {
			var oORD_NO = dsT_LW_BONDLIST.NameValue(row, 'ORD_NO');
			url = "/hr/law/lawa010.jsp?ORD_NO="+oORD_NO+"&TITLE=�󼼳�����ȸ";

			window.showModalDialog(url, "", "dialogWidth:870px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();

		}

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ü������ȸ</td>
					<td align="right" class="navigator">HOME/�ѹ�(��Ÿ)/��������/<font color="#000000">��ü������ȸ</font></td>
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
			<a href="http://www.scourt.go.kr/" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgScourt','','/images/button/btn_ScourtOver.gif',1)">  <img src="/images/button/btn_ScourtOn.gif"   name="imgScourt" width="70" height="20" border="0" align="absmiddle"></a>
			<a href="http://www.klac.or.kr/" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgKlac','','/images/button/btn_KlacOver.gif',1)">  <img src="/images/button/btn_KlacOn.gif"   name="imgKlac" width="125" height="20" border="0" align="absmiddle"></a>
			&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
							<colgroup>
					    		<col width="70"></col>
								<col width="175"></col>
								<col width="70"></col>
								<col width="175"></col>
								<col width="70"></col>
								<col width=""></col>
							</colgroup>
							<tr>
                    			<td align="center" class="searchState">�������</td>
								<td>
									<input name=txtHEAD_CD_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR');fnc_FldChange()">
                                    <input name=txtHEAD_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtHEAD_CD_SHR','txtHEAD_NM_SHR','�������','HEAD');"></a>
								</td>
								<td align="center" class="searchState">ä�Ǳ���</td>
								<td>
									<input name=txtBOND_GBN_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('H3', 'txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR');fnc_FldChange()">
                                    <input name=txtBOND_GBN_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR','ä�ǳ���','H3');"></a>
								</td>
                                <td align="center" class="searchState">��������</td>
                                <td colspan="2">
                                    <input id="txtORD_YMD_STR_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_STR_SHR','','500','157');"></a>
                                    ~
                                    <input id="txtORD_YMD_END_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; }cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_END_SHR','','610','157');"></a>
                                </td>
 							</tr>
                            <tr><td align="center" height ="5"></td></tr>
							<tr>
                                <td align="center" class="searchState">��Ǹ�</td>
                                <td>
                                    <input name="txtEVENT_NM_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="23">
                                </td>

                                <td align="center" class="searchState">�������</td>
                                <td>
                                    <input name="txtHIS_CONT_NM_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="23">
                                </td>
    	                        <td class="searchState" align="center">�ϷῩ��</td>
                                <td class="padding2423" align="left">
                                     <select id="cmbGBN_CD" style="WIDTH: 60%">
                                       <option value="0">���</option>
                                       <option value="1">�Ϸ�</option>
                                       <option value="2">����</option>
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
						<object	id="grdT_LW_BONDLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:297px;">
							<param name="DataID"					value="dsT_LW_BONDLIST">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
								<C> id='COUNT_NUM'			width=77		name='������ȣ'			align=center		</C>
								<C> id='ORD_NO'				width=80		name='������ȣ'			align=center												</C>
								<C> id='EVENT_NM'			width=210		name='��Ǹ�' 				align=left													</C>
								<C> id='ORD_YMD'			width=80		name='��������'			align=center												</C>
								<C> id='HIS_CONT'			width=242		name='�������'			align=left													</C>
								<C> id='END_YN'				width=75		name='�ϷῩ��'			align=center		value={IF(END_YN='Y','��ǿϷ�','')}	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="30%">
    <tr>
        <td align="left" width="80" height = "30"><img src="/images/specialHr/dotGreen.gif" align="absmiddle">&nbsp;&nbsp;</td>
        <td align="left" width="720" id="txtResult"></td>
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