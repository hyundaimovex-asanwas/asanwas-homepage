<!--
***********************************************************************
* @source      : pirc030.jsp
* @description : ���κ�������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/20      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>���κ�������Ȳ(pirc030)</title>
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

		var btnList = 'TFFTFFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var eno_no = document.getElementById('txtENO_NO_SHR').value;
            var pis_yy = document.getElementById('txtPIS_YY_SHR').value;
            var pis_mm_str = document.getElementById('cmbPIS_MM_STR').value;
            var pis_mm_end = document.getElementById('cmbPIS_MM_END').value;

            if(!fnc_SearchItemCheck()) return;  //��ȸ ��ȿ�� �˻�

			trT_DI_DILIGENCE.KeyValue = "tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE, O:dsT_DI_YEARLY=dsT_DI_YEARLY)";
			trT_DI_DILIGENCE.action ="/servlet/GauceChannelSVL?cmd=hr.pir.c.pirc030.cmd.PIRC030CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PIS_YY="+pis_yy+"&PIS_MM_STR="+pis_mm_str+"&PIS_MM_END="+pis_mm_end;
			trT_DI_DILIGENCE.post();

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

				//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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
			document.getElementById("resultMessage").innerText = ' ';

			dsT_DI_DILIGENCE.ClearData();

            document.getElementById('txtPIS_YY_SHR').focus();

        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            var pis_yy = document.getElementById("txtPIS_YY_SHR");
            var pis_mm_str = document.getElementById("cmbPIS_MM_STR");
            var pis_mm_end = document.getElementById("cmbPIS_MM_END");
            var eno_no = document.getElementById("txtENO_NO_SHR");

            if(eno_no.value == ""){
                alert("����� �Է��ϼ���!");
                eno_no.focus();
                return false;
            }

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4�ڸ����� �⵵�� �Է��ϼ���!");
                pis_yy.focus();
                return false;
            }

            if(pis_mm_str.value > pis_mm_end.value){
                alert("������� ���ۿ����� �ݵ�� Ŀ���մϴ�!");
                pis_mm_end.focus();
                return false;
            }

            return true;

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //��¥���� �ʱ�ȭ
            document.getElementById('txtPIS_YY_SHR').value = getTodayArray()[0];
            document.getElementById('cmbPIS_MM_STR').value = "01";
            document.getElementById('cmbPIS_MM_END').value = "12";//getTodayArray()[1];

<%
    //�����ڳ� �ѹ� ������ �̸� ������� �˻��ϰ� �Ϲ������̸� ������� �˻����ϰ� ����
    if(!box.getString("SESSION_ROLE_CD").equals("1002")
            && !box.getString("SESSION_ROLE_CD").equals("1001")) {
%>
            fnc_ChangeStateElement(false, "ImgEnoNoShr");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

            document.getElementById('txtENO_NO_SHR').value = "<%=box.get("SESSION_ENONO") %>";
            document.getElementById('txtENO_NM_SHR').value = "<%=box.get("SESSION_ENONM") %>";
<%
    }
%>

			cfStyleGrid2(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style ����

            document.getElementById('txtPIS_YY_SHR').focus();

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
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE,O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_DILIGENCE)|
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)		 |
    +------------------------------------------------>
    <Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_YEARLY)   |
    | 3. ���Ǵ� Table List(T_DI_YEARLY)		     |
    +------------------------------------------------>
    <Object ID="dsT_DI_YEARLY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_DILIGENCE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_DILIGENCE event="OnFail()">
        cfErrorMsg(this);
    </script>

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���κ�������Ȳ</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">���κ�������Ȳ</font></td>
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
                                    <col width="70"></col>
                                    <col width="190"></col>
                                    <col width="70"></col>
                                    <col width=""></col>
								</colgroup>
                            <tr>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="cfNumberCheck();" style="ime-mode:disabled">��&nbsp;

                                    <select id="cmbPIS_MM_STR">
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>�� ~

                                    <select id="cmbPIS_MM_END">
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>��

                                </td>
                                <td align="right" class="searchState">�� ��&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_STR').value), (document.getElementById('txtPIS_YY_SHR').value+document.getElementById('cmbPIS_MM_END').value) );"></a>
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

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>��������</strong>
        </td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width="110"></col>
                    <col width="80"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtOCC_NM name=txtOCC_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtDPT_NM name=txtDPT_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id=txtJOB_NM name=txtJOB_NM size="16" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�Ի�����</td>
                    <td class="padding2423">
                        <input id=txtHIR_YMD name=txtHIR_YMD size="16" class="input_ReadOnly" readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>



<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�����߻�</strong>
        </td>
    </tr>
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="100"></col>
                    <col width="160"></col>
                    <col width="100"></col>
                    <col width=""></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�����߻��ϼ�</td>
                    <td class="padding2423">
                        <input id="txtYRP_CNT" style="width:50;text-align:right;" class="input_ReadOnly" readonly>��
                    </td>
                    <td align="center" class="creamBold">��������ϼ�</td>
                    <td class="padding2423">
                        <input id="txtYRP_ATT_H" style="width:50;text-align:right;" class="input_ReadOnly" readonly>��
                    </td>
                    <td align="center" class="creamBold">�̻�뿬��</td>
                    <td class="padding2423">
                        <input id="txtREM_YRP" style="width:50;text-align:right;" class="input_ReadOnly"  readonly>��
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>







<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <img src="/images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>������Ȳ</strong>
        </td>
    </tr>
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:220px;">
							<param name="DataID"					value="dsT_DI_DILIGENCE">
                            <param name=ColSelect  value=true>
                            <param name="Format"					value="
                                <C> id='PIS_YYMM'	width=50	name='��/��'	align=center </C>
								<C> id='YRP_CNT'	width=30	name='����'	    align=right </C>
                                <C> id='AT1_CD'		width=22	name='1'		align=center    Value={AT1_CD} BgColor={Decode(AT1_CD,'Y','#FEB293',Decode(HOL_YN1,'Y','#FEB293'))} </C>
                                <C> id='AT2_CD'	    width=22	name='2'		align=center    Value={AT2_CD} BgColor={Decode(AT2_CD,'Y','#FEB293',Decode(HOL_YN2,'Y','#FEB293'))} </C>
                                <C> id='AT3_CD'	    width=22	name='3'	    align=center    Value={AT3_CD} BgColor={Decode(AT3_CD,'Y','#FEB293',Decode(HOL_YN3,'Y','#FEB293'))} </C>
                                <C> id='AT4_CD'	    width=22	name='4'		align=center    Value={AT4_CD} BgColor={Decode(AT4_CD,'Y','#FEB293',Decode(HOL_YN4,'Y','#FEB293'))} </C>
                                <C> id='AT5_CD'	    width=22	name='5'	    align=center    Value={AT5_CD} BgColor={Decode(AT5_CD,'Y','#FEB293',Decode(HOL_YN5,'Y','#FEB293'))} </C>
                                <C> id='AT6_CD'     width=22	name='6'		align=center    Value={AT6_CD} BgColor={Decode(AT6_CD,'Y','#FEB293',Decode(HOL_YN6,'Y','#FEB293'))} </C>
                                <C> id='AT7_CD'     width=22	name='7'		align=center    Value={AT7_CD} BgColor={Decode(AT7_CD,'Y','#FEB293',Decode(HOL_YN7,'Y','#FEB293'))} </C>
                                <C> id='AT8_CD'     width=22	name='8'		align=center    Value={AT8_CD} BgColor={Decode(AT8_CD,'Y','#FEB293',Decode(HOL_YN8,'Y','#FEB293'))} </C>
                                <C> id='AT9_CD'     width=22	name='9'		align=center    Value={AT9_CD} BgColor={Decode(AT9_CD,'Y','#FEB293',Decode(HOL_YN9,'Y','#FEB293'))} </C>
                                <C> id='AT10_CD'    width=22	name='10'		align=center    Value={AT10_CD} BgColor={Decode(AT10_CD,'Y','#FEB293',Decode(HOL_YN10,'Y','#FEB293'))} </C>
                                <C> id='AT11_CD'    width=22	name='11'		align=center    Value={AT11_CD} BgColor={Decode(AT11_CD,'Y','#FEB293',Decode(HOL_YN11,'Y','#FEB293'))} </C>
                                <C> id='AT12_CD'    width=22	name='12'		align=center    Value={AT12_CD} BgColor={Decode(AT12_CD,'Y','#FEB293',Decode(HOL_YN12,'Y','#FEB293'))} </C>
                                <C> id='AT13_CD'    width=22	name='13'		align=center    Value={AT13_CD} BgColor={Decode(AT13_CD,'Y','#FEB293',Decode(HOL_YN13,'Y','#FEB293'))} </C>
                                <C> id='AT14_CD'    width=22	name='14'		align=center    Value={AT14_CD} BgColor={Decode(AT14_CD,'Y','#FEB293',Decode(HOL_YN14,'Y','#FEB293'))} </C>
                                <C> id='AT15_CD'    width=22	name='15'		align=center    Value={AT15_CD} BgColor={Decode(AT15_CD,'Y','#FEB293',Decode(HOL_YN15,'Y','#FEB293'))} </C>
                                <C> id='AT16_CD'    width=22	name='16'		align=center    Value={AT16_CD} BgColor={Decode(AT16_CD,'Y','#FEB293',Decode(HOL_YN16,'Y','#FEB293'))} </C>
                                <C> id='AT17_CD'    width=22	name='17'		align=center    Value={AT17_CD} BgColor={Decode(AT17_CD,'Y','#FEB293',Decode(HOL_YN17,'Y','#FEB293'))} </C>
                                <C> id='AT18_CD'    width=22	name='18'		align=center    Value={AT18_CD} BgColor={Decode(AT18_CD,'Y','#FEB293',Decode(HOL_YN18,'Y','#FEB293'))} </C>
                                <C> id='AT19_CD'    width=22	name='19'		align=center    Value={AT19_CD} BgColor={Decode(AT19_CD,'Y','#FEB293',Decode(HOL_YN19,'Y','#FEB293'))} </C>
                                <C> id='AT20_CD'    width=22	name='20'		align=center    Value={AT20_CD} BgColor={Decode(AT20_CD,'Y','#FEB293',Decode(HOL_YN20,'Y','#FEB293'))} </C>
                                <C> id='AT21_CD'    width=22	name='21'		align=center    Value={AT21_CD} BgColor={Decode(AT21_CD,'Y','#FEB293',Decode(HOL_YN21,'Y','#FEB293'))} </C>
                                <C> id='AT22_CD'    width=22	name='22'		align=center    Value={AT22_CD} BgColor={Decode(AT22_CD,'Y','#FEB293',Decode(HOL_YN22,'Y','#FEB293'))} </C>
                                <C> id='AT23_CD'    width=22	name='23'		align=center    Value={AT23_CD} BgColor={Decode(AT23_CD,'Y','#FEB293',Decode(HOL_YN23,'Y','#FEB293'))} </C>
                                <C> id='AT24_CD'    width=22	name='24'		align=center    Value={AT24_CD} BgColor={Decode(AT24_CD,'Y','#FEB293',Decode(HOL_YN24,'Y','#FEB293'))} </C>
                                <C> id='AT25_CD'    width=22	name='25'		align=center    Value={AT25_CD} BgColor={Decode(AT25_CD,'Y','#FEB293',Decode(HOL_YN25,'Y','#FEB293'))} </C>
                                <C> id='AT26_CD'    width=22	name='26'		align=center    Value={AT26_CD} BgColor={Decode(AT26_CD,'Y','#FEB293',Decode(HOL_YN26,'Y','#FEB293'))} </C>
                                <C> id='AT27_CD'    width=22	name='27'		align=center    Value={AT27_CD} BgColor={Decode(AT27_CD,'Y','#FEB293',Decode(HOL_YN27,'Y','#FEB293'))} </C>
                                <C> id='AT28_CD'    width=22	name='28'		align=center    Value={AT28_CD} BgColor={Decode(AT28_CD,'Y','#FEB293',Decode(HOL_YN28,'Y','#FEB293'))} </C>
                                <C> id='AT29_CD'    width=22	name='29'		align=center    Value={AT29_CD} BgColor={Decode(AT29_CD,'Y','#FEB293',Decode(HOL_YN29,'Y','#FEB293'))} </C>
                                <C> id='AT30_CD'    width=22	name='30'		align=center    Value={AT30_CD} BgColor={Decode(AT30_CD,'Y','#FEB293',Decode(HOL_YN30,'Y','#FEB293'))} </C>
                                <C> id='AT31_CD'    width=22	name='31'		align=center    Value={AT31_CD} BgColor={Decode(AT31_CD,'Y','#FEB293',Decode(HOL_YN31,'Y','#FEB293'))} </C>


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

<!-- ���� �Է� ���̺� ���� -->
<table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="paddingTop3">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="24"></col>
                    <col width="100"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td align="center" class="creamBold">�� ��:A</td>
                    <td class="padding2423">
                        <input id="txtATT_A" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:B</td>
                    <td class="padding2423">
                        <input id="txtATT_B" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:C</td>
                    <td class="padding2423">
                        <input id="txtATT_C" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:D</td>
                    <td class="padding2423">
                        <input id="txtATT_D" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:E</td>
                    <td class="padding2423">
                        <input id="txtATT_E" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:F</td>
                    <td class="padding2423">
                        <input id="txtATT_F" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">�� ��:G</td>
                    <td class="padding2423">
                        <input id="txtATT_G" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:H</td>
                    <td class="padding2423">
                        <input id="txtATT_H" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">����������:P</td>
                    <td class="padding2423">
                        <input id="txtATT_P" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">���Ŀ�����:R</td>
                    <td class="padding2423">
                        <input id="txtATT_R" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��������:J</td>
                    <td class="padding2423">
                        <input id="txtATT_J" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:K</td>
                    <td class="padding2423">
                        <input id="txtATT_K" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="creamBold">Ư ��:I</td>
                    <td class="padding2423">
                        <input id="txtATT_I" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">��ü�ް�:T</td>
                    <td class="padding2423">
                        <input id="txtATT_T" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">����ٹ�:W</td>
                    <td class="padding2423">
                        <input id="txtATT_W" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="creamBold">�� ��:Y</td>
                    <td class="padding2423">
                        <input id="txtATT_Y" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">�� Ÿ:L</td>
                    <td class="padding2423">
                        <input id="txtATT_L" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="creamBold">��ü����:U</td>
                    <td class="padding2423">
                        <input id="txtATT_U" style="width:100%;text-align:right;" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>

                    <td align="center" class="creamBold">��ü+������:V</td>
                    <td class="padding2423">
                        <input id="txtATT_V" style="width:100%;text-align:right;" class="input_ReadOnly" readonly>
                    </td>
                    <td class="padding2423" colspan="4"> </td>
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

</form>
<!-- form �� -->

</body>
</html>

<!-- ��/�� MASTER ���̺� -->
<object id="bndT_DI_DILIGENCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_DILIGENCE">
    <Param Name="BindInfo", Value='
        <C> Col=OCC_NM       Ctrl=txtOCC_NM       Param=value </C>
        <C> Col=DPT_NM       Ctrl=txtDPT_NM       Param=value </C>
        <C> Col=JOB_NM       Ctrl=txtJOB_NM       Param=value </C>
        <C> Col=HIR_YMD     Ctrl=txtHIR_YMD     Param=value </C>

        <C> Col=ATT_A        Ctrl=txtATT_A        Param=value </C>
        <C> Col=ATT_B        Ctrl=txtATT_B        Param=value </C>
        <C> Col=ATT_C        Ctrl=txtATT_C        Param=value </C>
        <C> Col=ATT_D        Ctrl=txtATT_D        Param=value </C>
        <C> Col=ATT_E        Ctrl=txtATT_E        Param=value </C>
        <C> Col=ATT_F        Ctrl=txtATT_F        Param=value </C>
        <C> Col=ATT_G        Ctrl=txtATT_G        Param=value </C>
        <C> Col=ATT_T        Ctrl=txtATT_T        Param=value </C>
        <C> Col=ATT_I        Ctrl=txtATT_I        Param=value </C>
        <C> Col=ATT_J        Ctrl=txtATT_J        Param=value </C>
        <C> Col=ATT_K        Ctrl=txtATT_K        Param=value </C>
        <C> Col=ATT_L        Ctrl=txtATT_L        Param=value </C>
        <C> Col=ATT_H        Ctrl=txtATT_H        Param=value </C>
        <C> Col=ATT_P        Ctrl=txtATT_P        Param=value </C>
        <C> Col=ATT_R        Ctrl=txtATT_R        Param=value </C>
        <C> Col=ATT_Y        Ctrl=txtATT_Y        Param=value </C>
        <C> Col=ATT_W        Ctrl=txtATT_W        Param=value </C>
        <C> Col=ATT_U        Ctrl=txtATT_U        Param=value </C>
        <C> Col=ATT_V        Ctrl=txtATT_V        Param=value </C>
    '>
</object>

<object id="bndT_DI_YEARLY" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_DI_YEARLY">
    <Param Name="BindInfo", Value='

        <C> Col=YRP_CNT      Ctrl=txtYRP_CNT      Param=value </C>
        <C> Col=YRP_ATT_H    Ctrl=txtYRP_ATT_H    Param=value </C>
        <C> Col=REM_YRP      Ctrl=txtREM_YRP      Param=value </C>
    '>
</object>