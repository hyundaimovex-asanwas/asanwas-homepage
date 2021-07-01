	<!--*************************************************************************
	* @source      : crua010.jsp												*
	* @description : �Ի������� ��� PAGE	 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/02      ���뼺          �����ۼ�									*
	* 2007/05/19      �̽¿�          ����۾�									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�Ի������� ���(crua010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFTFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			var f = document.form1;

			if(!fnc_SearchItemCheck()) return;

			//���ڱ� ��û�� ó�� ��ȸ
			var regyy = f.txtREGYY_SHR.value;
			var regch = f.txtREGCH_SHR.value;
			var reg_str = f.txtREG_NO_STR.value;
			var reg_end = f.txtREG_NO_END.value;
			var school = f.cmbSCHOOL_SHR.value;
			var split_flag = f.rdoSPLIT_FLAG_SHR.CodeValue;
			var passtag = f.cmbPASSTAG_SHR.value;

			var remove = "";
			if(f.chkREMOVE.checked == true){
				var remove = "Y";
			}else{
				var remove = "N";
			}

			dsT_RC_MASTER.dataid = "/servlet/GauceChannelSVL?cmd=hr.cru.a.crua010.cmd.CRUA010CMD&S_MODE=SHR&REGYY="+regyy+"&REGCH="+regch+"&REG_STR="+reg_str+"&REG_END="+reg_end+"&SCHOOL="+school+"&SPLIT_FLAG="+split_flag+"&PASSTAG="+passtag+"&REMOVE="+remove;
			document.form1.txtHNW_PARM.value = "[:REGYY]=" + regyy + "[:REGCH]=" + regch + "[:REG_STR]=" + reg_str + "[:REG_END]=" + reg_end + "[:SCHOOL]=" + school + "[:SPLIT_FLAG]=" + split_flag + "[:PASSTAG]=" + passtag + "[:REMOVE]=" + remove;
			dsT_RC_MASTER.reset();
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 *
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
            var hnw_parm = document.form1.txtHNW_PARM.value;
            document.form1.rptObject.SetValues=hnw_parm;
            document.form1.rptObject.RunButton("CommandPrint");
        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

			var f = document.form1;
			//f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";
			f.txtREG_NO_STR.value = "";
			f.txtREG_NO_END.value = "";
			f.cmbSCHOOL_SHR.value = "1";
			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";
			f.cmbPASSTAG_SHR.value = "1";
			f.chkREMOVE.checked = false;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_RC_MASTER.ClearData();
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

			var regyy = document.getElementById('txtREGYY_SHR');
			var regch = document.getElementById('txtREGCH_SHR');
			var reg_str = document.getElementById('txtREG_NO_STR');
			var reg_end = document.getElementById('txtREG_NO_END');

			if(regyy.value == '') {
				alert("�⵵�� �ʼ� �Է»����Դϴ�!");
				regyy.focus();
				return false;
			} else if(regyy.value.length < 4) {
				alert("4�ڸ����� �⵵�� �Է��ϼ���!");
				regyy.focus();
				return false;
			}
			if(regch.value == '') {
				alert("ȸ���� �ʼ� �Է»����Դϴ�!");
				regch.focus();
				return false;
			} else if(regch.value.length < 2) {
				alert("2�ڸ����� ȸ���� �Է��ϼ���!");
				regch.focus();
				return false;
			}

			if(reg_str.value != '' && reg_str.value.length < 11) {
				alert("11�ڸ����� �����ȣ�� �Է��ϼ���!");
				reg_str.focus();
				return false;
			}
			if(reg_end.value != '' && reg_end.value.length < 11) {
				alert("11�ڸ����� �����ȣ�� �Է��ϼ���!");
				reg_end.focus();
				return false;
			}

			return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   *
         ********************************************/
        function fnc_OnLoadProcess() {
			var f = document.form1;

			f.rdoSPLIT_FLAG_SHR.CodeValue = "A";

			f.txtREGYY_SHR.value = getToday().substring(0,4);
			f.txtREGCH_SHR.value = "01";

			cfStyleGrid(form1.grdT_RC_MASTER,0,"false","false");      // Grid Style ����
			f.txtREGYY_SHR.focus();

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

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_RC_MASTER)		   |
    | 3. ���Ǵ� Table List(T_RC_MASTER) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_RC_MASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
	<Script For=dsT_RC_MASTER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);

        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_RC_MASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_RC_MASTER Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ի������� ���</td>
					<td align="right" class="navigator">HOME/��Ÿ/ä�����/<font color="#000000">�Ի������� ���</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_PrintOver.gif',1)"><img src="/images/button/btn_PrintOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="40"></col>
							<col width="70"></col>
							<col width="100"></col>
							<col width="170"></col>
							<col width="40"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="searchState">�⵵&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGYY_SHR"  size="4" maxLength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPIS_YY_SHR" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtREGYY_SHR','','5','115');"></a>
							</td>
							<td align="right" class="searchState">�����ȣ&nbsp;</td>
							<td class="padding2423">
								<input id="txtREG_NO_STR"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled"> - <input id="txtREG_NO_END"  size="11" maxLength="11" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" style="ime-mode:disabled">
							</td>
							<td align="right" class="searchState">�з�</td>
							<td class="padding2423">
                                <select id="cmbSCHOOL_SHR">
                                    <option value="">�� ü</option>
                                    <option value="Y">�����̻�</option>
                                    <option value="N">�����̸�</option>
                                </select>
							</td>
							<td align="right" class="searchState">�հݿ���</td>
							<td class="padding2423">
                                <select id="cmbPASSTAG_SHR">
                                    <option value="">��������</option>
                                    <option value="1">�����հ�</option>
                                    <option value="2">1�������հ�</option>
                                    <option value="3">2�������հ�</option>
                                    <option value="4">3�������հ�</option>
                                    <option value="5">��ü�˻��հ�</option>
                                </select>
							</td>
						</tr>
						<tr>
							<td align="center" class="searchState">����&nbsp;</td>
							<td class="padding2423">
								<input id="txtREGCH_SHR"  size="4" maxLength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfCheckNumber2();" style="ime-mode:disabled">
							</td>
							<td align="center" class="searchState">����/��±���&nbsp;</td>
							<td class="padding2423"><comment id="__NSID__">
								<object id=rdoSPLIT_FLAG_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
											style="height:20; width:140">
									<param name=AutoMargin	value="true">
									<param name=Cols		value="2">
									<param name=Format		value="A^���Ի��,B^��»��">
								</object>
								</comment><script> __ShowEmbedObject(__NSID__); </script>
							</td>
							<td class="searchState" colspan="2">
								&nbsp;&nbsp;������ ����
								<input type="checkbox" id="chkREMOVE" style="border:0" align="absmiddle" ></td>
							<td></td>
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
					<object id="grdT_RC_MASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:360px;">
						<param name="DataID" value="dsT_RC_MASTER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=30    name="NO"			align=center  value={String(currow)} </C>
							<C> id="REG_NO"		width="75"	name="�����ȣ"		align="center" </C>
							<C> id="ENO_NM"		width="50"	name="����"			align="center" </C>
							<C> id="BIRYMD"		width="70"	name="�������"		align="center" Mask="XXXX-XX-XX"</C>
							<C> id="SEXGU"		width="30"	name="����"			align="center" Value={Decode(SEXGU,"M","��","F","��")}</C>
							<C> id="SCH_YMD"	width="55"	name="�����⵵"		align="center" </C>
							<C> id="SCH_NM"		width="100"	name="��ű�"		align="left" </C>
							<C> id="SCH_MAJOR"	width="100"	name="����"			align="left" </C>
							<C> id="SCH_GRDYN"	width="100"	name="����/����"	align="left" </C>
							<C> id="AVE"		width="59"	name="����"			align="center" </C>
							<C> id="TOEIC"		width="40"	name="TOEIC"		align="center" </C>
							<C> id="TOEFL"		width="40"	name="TOEFL"		align="center" </C>
							<C> id="ACPSTAT"	width="30"	name="�μ�"			align="center" </C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
    <comment id="__NSID__">
        <object id="rptObject" classid="clsid:2E68BEE5-A640-11D2-AEA4-00AA006E5B34" width="800" height="400" codebase="<%=hnwcodebase%>">
        <param name="hnwsrc"    VALUE="crua010_pr.hnw">
        <param name="initvalue" VALUE="">
        <param name="hidewnd"   VALUE="N">
        <param name="initdns"   VALUE="[LocationDNS]=<%=LocationDNS%>">
        </object>
    </comment>
	<script> __ShowEmbedObject(__NSID__); </script>

	<!-- ���� ��ȸ �׸��� ���̺� ��-->
	<input type="hidden" id="txtHNW_PARM">
	</form>
	<!-- form �� -->

</body>
</html>
