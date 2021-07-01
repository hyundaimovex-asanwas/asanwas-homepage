<!--
*****************************************************
* @source       : lawa030.jsp
* @description : HRMS PAGE :: ��������_ä��ȸ��������Ȳ����
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
<title>ä��ȸ��������Ȳ����</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
	        var oSTR_YMD = document.getElementById("txtORD_YMD_STR_SHR").value;
	        var oEND_YMD = document.getElementById("txtORD_YMD_END_SHR").value;

        	if(oSTR_YMD.trim() == '' || oEND_YMD.trim() == ''){
				alert("�ǷڱⰣ�� �Էµ��� �ʾҽ��ϴ�.");
				return false;
        	}

            //�����ͼ� ����
            dsT_LW_BONDLIST.DataID  = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa030.cmd.LAWA030CMD&S_MODE=SHR"
                                    + "&HEAD_CD_SHR="+document.getElementById("txtHEAD_CD_SHR").value
                    				+ "&BOND_GBN_SHR="+document.getElementById("txtBOND_GBN_SHR").value
                    				+ "&EVENT_NM_SHR="+document.getElementById("txtEVENT_NM_SHR").value
                    				+ "&ORD_YMD_STR_SHR="+oSTR_YMD
                    				+ "&ORD_YMD_END_SHR="+oEND_YMD;
            dsT_LW_BONDLIST.Reset();
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
            if(dsT_LW_BONDLIST.CountRow == 0) {
                alert("�μ��� ����Ÿ�� ��ȸ �� ����Ͻʽÿ�.");
                return;
            }
        
			var HEAD_CD_SHR      = document.getElementById("txtHEAD_CD_SHR").value;
			var BOND_GBN_SHR     = document.getElementById("txtBOND_GBN_SHR").value;
			var EVENT_NM_SHR   	 = document.getElementById("txtEVENT_NM_SHR").value;
            var ORD_YMD_STR_SHR  = document.getElementById("txtORD_YMD_STR_SHR").value;
            var ORD_YMD_END_SHR  = document.getElementById("txtORD_YMD_END_SHR").value;
            
            //�μ⸦ ���� �ʿ��� ������ �����Ѵ�.
            dsT_LW_BONDLIST_PRT.DataID  = "/servlet/GauceChannelSVL?cmd=hr.law.a.lawa030.cmd.LAWA030CMD"
                                        + "&S_MODE=PROC"
                                        + "&HEAD_CD_SHR="+HEAD_CD_SHR 
                                        + "&BOND_GBN_SHR="+BOND_GBN_SHR
                                        + "&EVENT_NM_SHR="+EVENT_NM_SHR
                                        + "&ORD_YMD_STR_SHR="+ORD_YMD_STR_SHR
                                        + "&ORD_YMD_END_SHR="+ORD_YMD_END_SHR;
            dsT_LW_BONDLIST_PRT.Reset();

		    var url = "lawa030_PV.jsp?HEAD_CD_SHR="+HEAD_CD_SHR+"&BOND_GBN_SHR="+BOND_GBN_SHR+"&EVENT_NM_SHR="+EVENT_NM_SHR + "&ORD_YMD_STR_SHR="+ORD_YMD_STR_SHR+"&ORD_YMD_END_SHR="+ORD_YMD_END_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {
            if (dsT_LW_BONDLIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_LW_BONDLIST.GridToExcel("ä��ȸ��������Ȳ����", '', 225);
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
            cfStyleGrid(form1.grdT_LW_BONDLIST,15,"false","false");

<%
    //������ �������� ������ �̰ų� IT �� �ƴϸ� �Ҽ� ���θ� ��ȸ ���� - M ������, A ���μ�, S �ҼӺμ�
    if(box.get("SESSION_LAW_AUTHO").equals("S")) {
%>
            //�ҼӺμ��� �����ڵ带 ��ȸ
            fnc_GetHeadCd();
            
            fnc_ChangeStateElement(false, "txtHEAD_CD_SHR");
            fnc_ChangeStateElement(false, "img_HelpOn1");
<%
    }
%>

			//�ǷڱⰣ �⺻��
   	        document.getElementById("txtORD_YMD_STR_SHR").value = getStrDate();
	        document.getElementById("txtORD_YMD_END_SHR").value = getEndDate();
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
        <param name="SubsumExpr"	value="total,2:HEAD_NM">
    </Object>
    
    <Object ID="dsT_LW_BONDLIST_PRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"	value="total,2:HEAD_NM">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">ä��ȸ��������Ȳ����</td>
					<td align="right" class="navigator">HOME/�ѹ�(��Ÿ)/��������/<font color="#000000">ä��ȸ��������Ȳ����</font></td>
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
			&nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
 			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>                
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
								<col width="10"></col>
								<col width="70"></col>
								<col width="190"></col>
								<col width="70"></col>
								<col width="190"></col>
								<col width="70"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�������</td>
                                <td>
                                    <input name=txtHEAD_CD_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('B2', 'txtHEAD_CD_SHR','txtHEAD_NM_SHR');fnc_FldChange()">
                                    <input name=txtHEAD_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtHEAD_CD_SHR','txtHEAD_NM_SHR','�������','HEAD');"></a>
                                </td>
                                <td align="center" class="searchState">ä�Ǳ���</td>
                                <td colspan="3">
                                    <input name=txtBOND_GBN_SHR size="6"  onKeyPress="JavaScript: if (event.keyCode == 13) fnc_SearchList()" onChange="fnc_GetCommNm('H3', 'txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR');fnc_FldChange()">
                                    <input name=txtBOND_GBN_NM_SHR size="14" class="input_ReadOnly"  readOnly>
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtBOND_GBN_SHR','txtBOND_GBN_NM_SHR','ä�ǳ���','H3');"></a>
                                </td>
								<td align="center" class="searchState">��Ǹ�</td>
								<td>
									<input name="txtEVENT_NM_SHR" class="divInput" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList()" size="23">
								</td>
							</tr>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">�ǷڱⰣ</td>
								<td colspan="5">
					        		<input id="txtORD_YMD_STR_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_STR_SHR','','60','134');"></a>
									~
					        		<input id="txtORD_YMD_END_SHR" size="10" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn4','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn4" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtORD_YMD_END_SHR','','170','134');"></a>
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
						<object	id="grdT_LW_BONDLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
							<param name="DataID"					value="dsT_LW_BONDLIST">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"					value="
                                <FC>    id='HEAD_NM'        width=90        name='�������'         align=center            Suppress='3'        SubSumText={decode(curlevel,2,'�Ұ�',9999,'�Ѱ�')}                  </FC>
                                <FC>    id='ORD_NO'         name='������ȣ'           align=left              Suppress='2'       show=false                                         </FC>
                                <FC>    id='EVENT_NM'       width=200       name='��Ǹ�'           align=left              Suppress='1'       SubSumText={SubSum(CNT)}                                         </FC>
                                <C>     id='BOND_GBN_NM'    width=80        name='ä�Ǳ���'         align=center                                                                                        </C>
                                <C>     id='BOND_AMT'       width=90        name='ä�Ǳݾ�'         align=right             value={IF(BOND_AMT=0,'',BOND_AMT)}                                          </C>
                                <C>     id='SEC_LAND'       width=150       name='������'           align=left                                                                                          </C>
                                <C>     id='SEC_PLED'       width=150       name='����'             align=left                                                                                          </C>
                                <C>     id='SEC_GUAR'       width=150       name='��������'         align=left                                                                                          </C>
                                <C>     id='SEC_CASH'       width=150       name='���ݿ�ġ'         align=left                                                                                          </C>
                                <C>     id='SEC_GUOR1'      width=100       name='���뺸����1'      align=center                                                                                        </C>
                                <C>     id='SEC_GUOR2'      width=100       name='���뺸����2'      align=center                                                                                        </C>
                                <C>     id='SEC_SO'         width=150       name='��Ÿ�㺸'         align=left                                                                                          </C>
                                <C>     id='DPT_NM'         width=100       name='�Ƿںμ�'         align=center                                                                                        </C>
                                <C>     id='HIS_CONT1'      width=200       name='�������'         align=left                                                                                                      </C>
                                <C>     id='HIS_AMT1'       width=90        name='����ݾ�'         align=right             value={IF(HIS_AMT1=0,'',HIS_AMT1)}                                                      </C>
                                <C>     id='HIS_CONT2'      width=200       name='��������'         align=left                                                                                                      </C>
                                <C>     id='HIS_AMT2'       width=90        name='�����ݾ�'         align=right             value={IF(HIS_AMT2=0,'',HIS_AMT2)}                                                      </C>
                                <C>     id='BOND_AC_AMT'    width=90        name='��ȸ����'         align=right             value={IF(BOND_AC_AMT=0,'',BOND_AC_AMT)}                                                </C>
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