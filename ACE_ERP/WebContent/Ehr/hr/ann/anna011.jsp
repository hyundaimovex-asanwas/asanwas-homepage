<!--
*****************************************************
* @source      : anna011.jsp
* @description : �����Ļ�/���ο���/���ο��ݰ���(�˾�)
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2007/03/07      ����ȣ                   �����ۼ�
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="common.util.JSPUtil" %>

<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���ο��ݰ���</title>
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
        //params
        var ENO_NO = "<%=JSPUtil.rns(request.getParameter("ENO_NO")) %>";
        var ACC_NO = "<%=JSPUtil.rns(request.getParameter("ACC_NO")) %>";
        var SAV_CD = "<%=JSPUtil.rns(request.getParameter("SAV_CD")) %>";
        var BNK_CD = "<%=JSPUtil.rns(request.getParameter("BNK_CD")) %>";

        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ann.a.anna011.cmd.ANNA011CMD";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {
            if(ENO_NO == null) {
                alert("����� �����ϴ�.");
                return;
            }
            if(ACC_NO == null) {
                alert("���¹�ȣ�� �����ϴ�.");
                return;
            }

            dsT_SV_SAVELIST.dataid = dataClassName+"&S_MODE=SHR&ENO_NO="+ENO_NO+"&ACC_NO="+ACC_NO+"&SAV_CD="+SAV_CD+"&BNK_CD="+BNK_CD;
            dsT_SV_SAVELIST.reset();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         */
        function fnc_SearchEmp() {
            dsT_CM_PERSON.dataid = dataClassName+"&S_MODE=SHR_EMP&ENO_NO="+ENO_NO+"&ACC_NO="+ACC_NO+"&SAV_CD="+SAV_CD+"&BNK_CD="+BNK_CD;
            dsT_CM_PERSON.reset();

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

            form1.grdT_SV_SAVELIST.GridToExcel("���ο��ݰ���", '', 225);

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

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {
            window.close();
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
            cfStyleGrid(form1.grdT_SV_SAVELIST,15,"false","false")      // Grid Style ����

            fnc_SearchList();
            fnc_SearchEmp()
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
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>



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
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ο��ݰ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ο���/<font color="#000000">���ο��ݰ���</font></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- Ÿ��Ʋ �� ���̺� �� -->

<!-- ��ư ���̺� ���� -->
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="630" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">

            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90"></col>
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="110"></col>
                    <col width="90"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="creamBold" align="center">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" name="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtDPT_NM" name="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtJOB_NM" name="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">�ֹε�Ϲ�ȣ</td>
                    <td class="padding2423">
                        <input id="txtCET_NO" name="txtCET_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">�Ի���</td>
                    <td class="padding2423">
                        <input id="txtHIRG_YMD" name="txtHIRG_YMD" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtOCC_NM" name="txtOCC_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">���¹�ȣ</td>
                    <td class="padding2423" colspan="3">
                        <input id="txtACC_NO" name="txtACC_NO" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
                <tr>
                    <td class="creamBold" align="center">�������</td>
                    <td class="padding2423">
                        <input id="txtBNK_NM" name="txtBNK_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">���౸��</td>
                    <td class="padding2423">
                        <input id="txtSAV_NM" name="txtSAV_NM" size="14" class="input_ReadOnly" readonly>
                    </td>
                    <td class="creamBold" align="center">��������</td>
                    <td class="padding2423">
                        <input id="txtSAV_NM2" name="txtSAV_NM2" size="14" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>

        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

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
<table width="630" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_SV_SAVELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:630px;height:260px;">
							<param name="DataID"				value="dsT_SV_SAVELIST">
							<param name="EdiTABLE"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
                                <C> id=DED_YM       width=95       align=center        name=�������      </C>
                                <C> id=PIN_MTH      width=95       align=center        name=���Թ��      </C>
                                <C> id=PIN_CNT      width=95       align=center        name=����Ƚ��      </C>
                                <C> id=TOTAL_SAV    width=95       align=center        name=���Դ����    </C>
                                <C> id=PYM_AMT      width=95       align=center        name=�����Ծ�      </C>
                                <C> id=DED_TAG      width=95       align=center        name=��������      </C>
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
<!-- T_CM_PERSON ��ȸ�ؿ� ��� ������ â�� �ѷ��� -->
<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_PERSON">
	<Param Name="BindInfo", Value='
        <C>Col=ENO_NO               Ctrl=txtENO_NO              Param=value     </C>
        <C>Col=ENO_NM               Ctrl=txtENO_NM              Param=value     </C>
        <C>Col=DPT_NM               Ctrl=txtDPT_NM              Param=value     </C>
        <C>Col=JOB_NM               Ctrl=txtJOB_NM              Param=value     </C>
        <C>Col=CET_NO               Ctrl=txtCET_NO              Param=value     </C>
        <C>Col=HIRG_YMD             Ctrl=txtHIRG_YMD            Param=value     </C>
        <C>Col=OCC_NM               Ctrl=txtOCC_NM              Param=value     </C>
        <C>Col=ACC_NO               Ctrl=txtACC_NO              Param=value     </C>
        <C>Col=BNK_NM               Ctrl=txtBNK_NM              Param=value     </C>
        <C>Col=SAV_NM               Ctrl=txtSAV_NM              Param=value     </C>
        <C>Col=SAV_NM2              Ctrl=txtSAV_NM2             Param=value     </C>
    '>
</object>

