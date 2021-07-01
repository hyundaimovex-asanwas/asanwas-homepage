<!--
*****************************************************
* @source       : gunc020.jsp
* @description : ���ϱٹ�����ó�� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/06      ���뼺        �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ϱٹ�����ó��(gunc020)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTFFFT';

        var today = getToday();

        var dsTemp = window.dialogArguments;
        var curRowPosition = 0;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����(�Ⱓ)
			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value;
			var HOL_YME_SHR = document.getElementById("txtHOL_YME_SHR").value;
			var GUN_GBN_SHR = document.getElementById("cmbGUN_GBN_SHR").value;
            var app_yn = document.getElementById("cmbAPP_YN").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;


            if(!fnc_SearchItemCheck()) return;


            //��ȸ �ش����� �����Ѵ�.
            document.getElementById("hidTAG_YM").value = HOL_YMD_SHR;

			dsT_DI_APPROVAL.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.c.gunc020.cmd.GUNC020CMD"
                                   + "&S_MODE=SHR"
                                   + "&HOL_YMD_SHR="+HOL_YMD_SHR
                                   + "&HOL_YME_SHR="+HOL_YME_SHR
                                   + "&GUN_GBN_SHR="+GUN_GBN_SHR
                                   + "&APP_YN_SHR="+app_yn+"&DPT_CD="+DPT_CD+"&OUR_MAN="+our_man;
			dsT_DI_APPROVAL.reset();
			dsT_DI_APPROVAL.RowPosition = curRowPosition;

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

            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("cmbAPP_YN").value ='';
            document.getElementById("txtDPT_CD_SHR").value = '';
            document.getElementById("txtDPT_NM_SHR").value = '';
            document.getElementById("txtOUR_MAN_SHR").value = '';
            document.getElementById("txtOUR_MAN_NM_SHR").value = '';
			dsT_DI_APPROVAL.ClearData();

			document.getElementById("txtHOL_YMD_SHR").focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
				if (dsT_DI_APPROVAL.IsUpdated)  {
					if (!fnc_ExitQuestion()) return;
				}

				frame = window.external.GetFrame(window);
				frame.CloseFrame();

            }else{
                window.close();
            }

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

			var HOL_YMD_SHR = document.getElementById("txtHOL_YMD_SHR").value; // ���۳��

            if(HOL_YMD_SHR == ""){
                alert("�˻� �Ⱓ�� �Է��ϼ���!");
                document.getElementById("txtHOL_YMD_SHR").focus();
                return false;
            }

            return true;
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			if (!dsT_DI_APPROVAL.IsUpdated) {
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


			cfStyleGrid(form1.grdT_DI_APPROVAL,0,"false","false")      // Grid Style ����

            //CHECK_DATE!!!
            //â�� ������ ���糯¥�� ���� 15�� �� / ���� ������ �´�.
            var todayList   = getTodayArray();
            var hol_ymd     = getToday();

            hol_ymd     = addDate("D", getToday(), -15);
            document.getElementById("txtHOL_YMD_SHR").value = hol_ymd; // �ش��� From
            hol_ymd     = addDate("D", getToday(), 15);
            document.getElementById("txtHOL_YME_SHR").value = hol_ymd; // �ش��� To

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

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_DI_APPROVAL                                      |
    | 3. Table List : T_DI_APPROVAL                                 |
    +----------------------------------------------->
    <Object ID="dataSet" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_APPROVAL)		   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>



    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_APPROVAL event="OnDblClick(row,colid)">
        var param = new String();
		curRowPosition = dsT_DI_APPROVAL.RowPosition;
        if(row < 1) {
            return;
        } else {
			//���ϱٹ� param �� Setting
            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7" || dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                      //������ ����
	            param.gun_ymd   = dsT_DI_APPROVAL.NameValue(row, "GUN_YMD");
          		param.gun_dpt   = dsT_DI_APPROVAL.NameValue(row, "GUN_DPT");
          		param.req_no    = dsT_DI_APPROVAL.NameValue(row, "REQ_NO");
            }

            if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "6"){
                window.showModalDialog("/hr/gun/gunc071.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //���ϱٹ� ������û
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "7"){
                window.showModalDialog("/hr/gun/gunc091.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            //���ϱٹ� �������
            }else if(dsT_DI_APPROVAL.NameValue(row,"APP_GBN") == "8"){
                window.showModalDialog("/hr/gun/gunc012.jsp", param, "dialogWidth:860px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ϱٹ�����ó��</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/<font color="#000000">���ϱٹ�����ó��</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
       <td height="35" class="paddingTop5">
           &nbsp;&nbsp;�� �ش� ���������� ����Ŭ���ϸ� ���γ����� ��ȸ�� �� �ֽ��ϴ�.
       </td>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
                                <col width="230"></col>
                                <col width="80"></col>
                                <col width="200"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
								<td align="right" class="searchState">��û���&nbsp;</td>
                                <td class="padding2423">
									<input id="txtHOL_YMD_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHOL_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHOL_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YMD_SHR','','70','110');"></a> ~
									<input id="txtHOL_YME_SHR" size="10" maxlength="10" onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value=''; } cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgHOL_YME_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgHOL_YME_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHOL_YME_SHR','','70','110');"></a>
                                    <input type="hidden" id="hidTAG_YM">
								</td>
								<td class="searchState" align="right">��������&nbsp;</td>
						    	<td class="padding2423" align="left">
								<select id="cmbGUN_GBN_SHR" style="WIDTH: 100px" onChange="fnc_SearchList()">
									<option value="A">���</option>
									<option value="R">��������</option>
									<option value="H">�������</option>
									<option value="J">��������</option>
								</select>
								</td>
								<td class="searchState" align="right">�������</td>
                                <td class="padding2423" align="left">
			                        <select id="cmbAPP_YN" style="width:100" onChange="fnc_SearchList();">
			                            <option value="" >��ü</option>
			                            <option value="Y" >����</option>
			                            <option value="N" >�ΰ�</option>
			                            <option value="A" >�̰�</option>
			                        </select>
                                </td>
                            </tr>
				<tr class="paddingTop5" >
					<td align="right" class="searchState">��&nbsp;&nbsp;��&nbsp;</td>
                    <td class="padding2423">
						<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" class="input_ReadOnly"  readonly maxlength="3" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" class="input_ReadOnly"  readonly>
	                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
                    </td>
					<td class="searchState" align="right">������&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
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
        <td style="padding-top:2px;">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                        <comment id="__NSID__">
                        <object id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:320px;">
                            <param name="DataID"                value="dsT_DI_APPROVAL">
                            <param name="Format"                value="
                                <FC> id='{CUROW}'    width=39    name='NO'           align=center    value={String(Currow)}</C>
                                <FC> id='APP_GBN_NM' width=100   name='���籸��'     align=center </FC>
                                <FC> id='APP_TITLE'  width=440   name='����'         align=left   </FC>
                                <FC> id='APP_YMD'    width=110   name='�������'     align=center </FC>
                                <C> id='PENO_NM'    width=90    name='�����'       align=center  </C>
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