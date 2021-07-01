	<!--*************************************************************************
	* @source      : taxa170.jsp												*
	* @description : �����ҵ��õ¡��������
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/04/11          �漮ȣ             	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�����ҵ��õ¡�������� (taxa170)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTTFT';
        var year = getToday().substring(0,7);
        var bal_date = getToday().substring(0,10);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {


        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
			var PIS_YM   = document.getElementById("txtPIS_YY_SHR").value;
			var ENO_NO   = document.getElementById("txtENO_NO_SHR").value;
            var STR_YMD  = document.getElementById("txtSTR_YMD_SHR").value;
            var SEQ      = document.getElementById("cmbSEQ").value;
            var STP_GBN  = fnc_GetCheckedValue("rdoSTP_GBN");
            var PRT_GBN  = fnc_GetCheckedValue("rdoPRT_GBN");

			if(!fnc_SearchItemCheck()) return;//�ʼ� ��ȸ���� üũ

			var url = "taxa170_PV.jsp"
                    + "?PIS_YM="+PIS_YM
                    + "&ENO_NO="+ENO_NO
                    + "&STR_YMD="+STR_YMD
                    + "&SEQ="+SEQ
                    + "&STP_GBN="+STP_GBN
                    + "&PRT_GBN="+PRT_GBN;

			window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;


        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {

        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			document.getElementById("txtPIS_YY_SHR").value      = year;
			document.getElementById("txtENO_NO_SHR").value      = "";
            document.getElementById("txtENO_NM_SHR").value      = "";
            document.getElementById("txtSTR_YMD_SHR").value     = bal_date;
       		document.getElementById("cmbSEQ").value = "0";//�Ϸù�ȣ

            document.getElementsByName("rdoSTP_GBN")[0].checked = true;
            document.getElementsByName("rdoPRT_GBN")[0].checked = true;

        	document.getElementById("resultMessage").innerText = ' ';
       }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
       		if( document.form1.txtPIS_YY_SHR.value=="" ){
       			alert("���س⵵�� �Է��Ͻʽÿ�.");
       			document.form1.txtPIS_YY_SHR.focus();
        		return false;
        	}
       		if( document.form1.txtENO_NO_SHR.value=="" ){
       			alert("�����ȣ�� �Է��Ͻʽÿ�.");
       			document.form1.txtENO_NO_SHR.focus();
        		return false;
        	}
        	return true;
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {
  			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	document.form1.txtPIS_YY_SHR.value = year;
		    document.form1.txtSTR_YMD_SHR.value = bal_date;
	     }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

    /********************************************
    * ��¥ ���� ��ȿ�� üũ                     *
    ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

        function fnc_RetState() {
  			var pro_ym = document.getElementById('txtPIS_YY_SHR').value;
            var eno_no = document.getElementById('txtENO_NO_SHR').value;

			dsT_CM_RETSTATE.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa170.cmd.TAXA170CMD&S_MODE=SHR&ENO_NO="+eno_no+"&PRO_YM="+pro_ym.replace("-","");
    		dsT_CM_RETSTATE.reset();
         }


    </script>
</head>

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_CM_UPRQST)   |
    | 3. ���Ǵ� Table List(T_CM_UPRQST)		     |
    +------------------------------------------------>
    <Object ID="dsT_CM_RETSTATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>




	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->
   <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_RETSTATE Event="OnLoadCompleted(iCount)">
       document.getElementById("cmbSEQ").value = dsT_CM_RETSTATE.NameValue(1,'SEQ');

    </Script>

   <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_RETSTATE Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=For=dsT_CM_RETSTATE Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';

		//Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>




	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ҵ��õ¡�������� </td>
					<td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�ҵ��������� - �����ҵ��õ¡��������
</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)">  <img src="/images/button/btn_PrintOn.gif"  name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">    <img src="/images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
	        </td>
	    </tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
                    <td class="searchState" align="right">������&nbsp;</td>
                    <td class="padding2423" align="left" colspan="0">
                        <table height="19" cellspacing="0" cellpadding="0" width="30%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfNumberCheck();">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyymm', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPIS_YY_SHR', 'yyyymm', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </tr>
                        </table>
                    </td>
                    <td align="center" class="searchState">�� ��</td>
					<td>
						<select id="cmbSEQ" style="width:100">
							<option value="0" >����</option>
							<option value="1" >�߰�����1��</option>
	                        <option value="2" >�߰�����2��</option>
	                        <option value="3" >�߰�����3��</option>
				    	</select>
					</td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">�����ȣ&nbsp;</td>
                    <td class="padding2423" align="left" colspan="3">
                        <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) {fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();}" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
                        <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');fnc_RetState();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');"></a>
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">�߱�����&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onChange="fnc_CheckDate(this, '������');" onkeypress="cfDateHyphen(this);cfCheckNumber(); if (event.keyCode == 13) fnc_SearchList();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgStrYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgStrYmd" name="ImgStrYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','100','185');"></a>
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">���౸��&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="1" checked>&nbsp;�ҵ��ں�����
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="2">&nbsp;�����ں����
                        <input type="radio" class="noview" name="rdoPRT_GBN" value="3">&nbsp;�����ں�����
                    </td>
                </tr>

                <tr><td height="15" colspan="4"></td></tr>

                <tr>
                    <td align="right" class="searchState">���ο���&nbsp;</td>
                    <td class="padding2423" colspan="3">
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="1" checked>&nbsp;�������
                        <input type="radio" class="noview" name="rdoSTP_GBN" value="2">&nbsp;���λ���
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



	</form>
	<!-- form �� -->

</body>
</html>

<!-- �������� ������û ���̺� -->
<object id="bndT_CM_RETSTATET" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_RETSTATE">
    <Param Name="BindInfo", Value='
        <C> Col=SEQ       Ctrl=txtSEQ       Param=value   Disable=disabled </C>
    '>
</object>

