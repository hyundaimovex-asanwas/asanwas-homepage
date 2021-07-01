<!--
*****************************************************
* @source      : anna020.jsp
* @description : �����Ļ�/���ο���/���ο��ݰ�������
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ο��ݰ�������</title>
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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna020.cmd.ANNA020CMD";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            //�˻�����
            var oCON_YMD_SHR    = document.getElementById("txtCON_YMD_SHR").value;
            var oOCC_CD_SHR     = document.getElementById("cmbOCC_CD_SHR").value;
            var oSAV_CD2_SHR    = document.getElementById("cmbSAV_CD2_SHR").value;
            var oTYPE_SHR       = document.getElementById("cmbTYPE_SHR").value;

            /*
            if(oCON_YMD_SHR=="" ){
                alert("������� �Է��Ͻʽÿ�. ��)"+today.substr(0,7));
                return;
            } */

            var params = "&S_MODE=SHR"
                       + "&CON_YMD="+oCON_YMD_SHR
                       + "&OCC_CD="+oOCC_CD_SHR
                       + "&SAV_CD2="+oSAV_CD2_SHR
                       + "&TYPE="+oTYPE_SHR;

            dsT_SV_SAVELIST.dataid = dataClassName+params;
            dsT_SV_SAVELIST.reset();
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

            if (dsT_SV_SAVELIST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SV_SAVELIST.GridToExcel("���ο��ݰ�������", '', 225);
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
			dsT_SV_SAVELIST.ClearData();
	        fnc_OnLoadProcess();
			document.getElementById("resultMessage").innerText = ' ';
            fncClearSearch();
        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			if (dsT_SV_SAVELIST.IsUpdated)  {

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

            // �ٷα��� ���� �˻� �޺��ڽ� ����
            oSelect = document.getElementById("cmbSAV_CD2_SHR");
            //ù��° ������ ������ ��� option ����
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            for(i = 1; i <= dsT_CM_COMMON_V2.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_V2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_V2.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

            // �ٷα��� ���� �˻� �޺��ڽ� ����
            oSelect = document.getElementById("cmbOCC_CD_SHR");
            //ù��° ������ ������ ��� option ����
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }
            for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }

			cfStyleGrid(form1.grdT_SV_SAVELIST,15,"true","true")      // Grid Style ����
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
            var inputFields = new Array( "cmbOCC_CD_SHR"
                                        ,"cmbSAV_CD2_SHR"
                                        ,"cmbTYPE_SHR");
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
    | 1. ��ȸ �� ����� DataSet                         |
    | 2. �̸� : dsT_SV_SAVELIST                       |
    | 3. Table List : T_SV_SAVELIST                 |
    +----------------------------------------------->
    <Object ID="dsT_SV_SAVELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
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
    <Script For=dsT_SV_SAVELIST Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_SV_SAVELIST Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_SV_SAVELIST event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_SV_SAVELIST event="OnFail()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��ݰ�������</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��ݰ�������</font></td>
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                                <col width="70"></col>
                                <col width="90"></col>
                                <col width="70"></col>
                                <col width="150"></col>
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�����</td>
                                <td class="padding2423">
                                    <input type="text" id="txtCON_YMD_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype2','txtCON_YMD_SHR','','80','108');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                </td>
                                <td align="right" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
                                <td class="padding2423">
                                    <select id="cmbOCC_CD_SHR" name="cmbOCC_CD_SHR" style="width:80;">
                                        <option value="">���</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��������</td>
                                <td class="padding2423">
                                    <select id="cmbSAV_CD2_SHR" name="cmbSAV_CD2_SHR" style="width:140;">
                                        <option value="">���</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">��ȸ����</td>
                                <td class="padding2423">
                                    <select id="cmbTYPE_SHR" name="cmbTYPE_SHR" style="width:100;">
                                        <option value="">���</option>
                                        <option value="1">�ű��Ի���</option>
                                        <option value="2">�����</option>
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
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id='{currow}'       width=39    name='NO'           align=center    Edit=none   SubBgColor='#99FFCC'</C>
                                <C> id=SAV_NM2      width=130       align=center        name=��������         </C>
                                <C> id=ENO_NM       width=80        align=center        name=����             </C>
                                <C> id=OCC_NM       width=80        align=center        name=�ٷα���             </C>
                                <C> id=DPT_NM       width=80        align=center        name=�Ҽ�             </C>
                                <C> id=JOB_NM       width=80        align=center        name=����             </C>
                                <C> id=CONM_AMT     width=80        align=right         name=���Ծ�           </C>
                                <C> id=SUM_SAV      width=80        align=right         name=������           </C>
                                <C> id=OTHP_AMT     width=80        align=right         name=��Ÿ���Ҿ�       </C>
                                <C> id=CON_CNT      width=39        align=center        name=Ƚ��             </C>
                                <C> id=CON_YMD      width=80        align=center        name=�����           </C>
                                <C> id=DUE_YMD      width=80        align=center        name=������           </C>
                                <C> id=CAN_YMD      width=80        align=center        name=�ؾ���           </C>
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

