<!--
***********************************************************************
* @source      : gunb040.jsp
* @description : �ް���ȹ�������ȸ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/02      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>�ް���ȹ�������ȸ(gunb040)</title>
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

		var btnList = 'TFFTTFFT';

        var today = getToday();

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			//�ް���ȹ����� ��ȸ
			var pis_yy = document.getElementById("txtPIS_YY_SHR").value;
			var pis_mm_str = document.getElementById("txtPIS_MM_STR").value;
            var pis_mm_end = document.getElementById("txtPIS_MM_END").value;
            var dpt_cd = document.getElementById("txtDPT_CD_SHR").value;
            var att_kind = document.getElementById("cmbATT_KIND_SHR").value;

            if(!fnc_SearchItemCheck()) return;  //��ȸ ��ȿ�� �˻�

			dsT_DI_PLAN.dataid = "/servlet/GauceChannelSVL?cmd=hr.gun.b.gunb040.cmd.GUNB040CMD&S_MODE=SHR&PIS_YY="+pis_yy+"&PIS_MM_STR="+pis_mm_str+"&PIS_MM_END="+pis_mm_end+"&DPT_CD="+dpt_cd+"&ATT_KIND="+att_kind;
			dsT_DI_PLAN.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            if (dsT_DI_PLAN.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_PLAN.GridToExcel("�ް���ȹ�����", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//document.getElementById("txtPIS_YY_SHR").value = "";
			//document.getElementById("txtPIS_MM_STR").value = "";
            //document.getElementById("txtPIS_MM_END").value = "";
            document.getElementById("txtDPT_CD_SHR").value = "";
            document.getElementById("txtDPT_NM_SHR").value = "";
            document.getElementById("cmbATT_KIND_SHR").value = "";
            document.getElementById("resultMessage").innerText = ' ';

        	dsT_DI_PLAN.ClearData();

            document.getElementById("txtPIS_YY_SHR").focus();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			frame = window.external.GetFrame(window);

			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {

	        var pis_yy = document.getElementById("txtPIS_YY_SHR");
			var pis_mm_str = document.getElementById("txtPIS_MM_STR");
            var pis_mm_end = document.getElementById("txtPIS_MM_END");
            var dpt_cd = document.getElementById("txtDPT_CD_SHR");

            if(pis_yy.value == "" || pis_yy.value.length < 4){
                alert("4�ڸ��� ��ȸ�⵵�� �Է��ϼ���!");
                pis_yy.focus();
                return false;
            }
            if(pis_mm_str.value == "" || pis_mm_str.value.length < 2 || pis_mm_str.value > 12){
                alert("2�ڸ��� ���ۿ��� �Է��ϼ���!");
                pis_mm_str.focus();
                return false;
            }
            if(pis_mm_end.value == "" || pis_mm_end.value.length < 2 || pis_mm_end.value > 12){
                alert("2�ڸ��� ������� �Է��ϼ���!");
                pis_mm_end.focus();
                return false;
            }
            if(pis_mm_str > pis_mm_end){
                alert("���ۿ��� ��������� �۾ƾ��մϴ�!");
                pis_mm_str.focus();
                return false;
            }
            if(dpt_cd.value == "" || pis_yy.value.length < 2){
                alert("�Ҽ��ڵ带 �Է��ϼ���!");
                dpt_cd.focus();
                return false;
            }

            return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
            cfStyleGrid(form1.grdT_DI_PLAN,0,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YY_SHR").value = today.substring(0,4);
            document.getElementById("txtPIS_MM_STR").value = "01";
            document.getElementById("txtPIS_MM_END").value = today.substring(5,7);
            
            document.getElementById("txtPIS_YY_SHR").focus();


            document.getElementById("txtDPT_CD_SHR").value = "<%=box.getString("SESSION_DPTCD") %>";
            document.getElementById("txtDPT_NM_SHR").value = "<%=box.getString("SESSION_DPTNM") %>";
<%
    if(!box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
			fnc_ChangeStateElement(false, "txtDPT_CD_SHR");       
			fnc_ChangeStateElement(false, "ImgDptCd");       
<%
    }
%>
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet						   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_PLAN)		   |
    | 3. ���Ǵ� Table List(T_DI_PLAN) 			   |
    +-------------------------------------------------->
	<Object ID="dsT_DI_PLAN" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_PLAN Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_PLAN Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ް���ȹ�������ȸ</td>
					<td align="right" class="navigator">HOME/���°���/�ް���ȹ����/<font color="#000000">�ް���ȹ�������ȸ</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image4','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="Image4" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="100"></col>
							<col width="160"></col>
                            <col width="60"></col>
							<col width="220"></col>
                            <col width="60"></col>
							<col width="80"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">�ش�Ⱓ&nbsp;</td>
								<td class="padding2423"><input id="txtPIS_YY_SHR" size="4" maxlength="4" onkeypress="cfNumberCheck();" style="ime-mode:disabled">��<input id="txtPIS_MM_STR" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">�� ~ <input id="txtPIS_MM_END" size="2" maxlength="2" onkeypress="cfNumberCheck();" style="ime-mode:disabled">��</td>
                            <td class="searchState" align="right">�Ҽ�&nbsp;</td>
					        <td class="padding2423" align="left">
						        <input id="txtDPT_CD_SHR" size="3" maxlength="2" onChange="fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');"> <input id="txtDPT_NM_SHR" size="14" class="input_ReadOnly"  readonly> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')"></a>
					        </td>
                            <td class="searchState" align="right">�ް��׸�&nbsp;</td>
					        <td class="padding2423" align="left">
						        <select id="cmbATT_KIND_SHR"  style="width='100%';" onChange="fnc_SearchList()">
									<option value="">�� ü</option>
									<option value="H">�� ��</option>
									<option value="Q">�����</option>
									<option value="Z">Refresh</option>
                                    <option value="S">�� ��</option>
								</select>
					        </td>
                            <td>&nbsp;</td>
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
						<td width="360" valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_DI_PLAN" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:380px;">
						<param name="DataID" value="dsT_DI_PLAN">
						<param name="Format" value='
			                <C> id="{CUROW}"	width=29	name=NO				align=center	value={String(Currow)}</C>
                            <C> id="DPT_NM"		width=100	name="�Ҽ�"         align=left      suppress=1 </C>
                            <C> id="JOB_NM"		width=60	name="����"         align=center    suppress=1 </C>
                            <C> id="ENO_NO"		width=70	name="���"         align=center    suppress=1 </C>
                            <C> id="ENO_NM"		width=70	name="����"	        align=center    suppress=1 </C>
                            <C> id="YRP_CNT"    width=70	name="�̻�뿬��"   align=center    suppress=1 </C>
                            <C> id="ATT_KIND"   width=80	name="�ް��׸�"     align=left      suppress=1 LeftMargin="10" Value={Decode(ATT_KIND,"H","�� ��","Q","������ް�","Z","Refresh","S","�����ް�")}</C>
                            <C> id="PLAN_CNT"	width=60	name="��ȹ�ϼ�"     align=right     RightMargin="10" </C>
                            <C> id="PLAN_YMD"	width=180	name="��ȹ����"     align=left      LeftMargin="20" </C>
                            <C> id="USE_YN"	    width=60	name="�������"     align=center    Value={Decode(USE_YN,"Y","���","�̻��")}</C>
						'>
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