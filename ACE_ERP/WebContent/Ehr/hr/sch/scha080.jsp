	<!--*************************************************************************
	* @source      : scha080.jsp												*
	* @description : �Ⱓ�� ���ڱ�������Ȳ PAGE	 								*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27      ���뼺          �����ۼ�									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�Ⱓ�� ���ڱ�������Ȳ(scha080)</title>
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

		var btnList = 'TFFTFFFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			*
         ********************************************/
        function fnc_SearchList() {

			if(!fnc_SearchItemCheck()) return;

			//���ڱ� ��û�� ó�� ��ȸ
			var occ_cd = document.getElementById("cmbOCC_CD_SHR").value;
			var sort_gbn = document.getElementById("cmbSORT_GBN_SHR").value;

            var oGRD    = document.getElementById("grdT_SC_SCHLBOOK");

            if      (sort_gbn == "1") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:JOB_NM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "1";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "";
            }
            else if (sort_gbn == "2") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:GUBUN_NM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "1";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "";
            }
            else if (sort_gbn == "3") {
                dsT_SC_SCHLBOOK.SubsumExpr = 'Total,1:PIS_YM';
                oGRD.ColumnProp("JOB_NM", "Suppress") = "";
                oGRD.ColumnProp("GUBUN_NM", "Suppress") = "";
                oGRD.ColumnProp("PIS_YM", "Suppress") = "1";
            }

            var STR_YMD = document.getElementById("txtSTR_YMD_SHR").value;
            var END_YMD = document.getElementById("txtEND_YMD_SHR").value;

            var STR_YMD2 = document.getElementById("txtSTR_YMD_SHR2").value;
            var END_YMD2 = document.getElementById("txtEND_YMD_SHR2").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha080.cmd.SCHA080CMD"
                                   + "&S_MODE=SHR"
                                   + "&OCC_CD="+occ_cd
                                   + "&SORT_GBN="+sort_gbn
                                   + "&STR_YMD="+STR_YMD
                                   + "&END_YMD="+END_YMD
                                   + "&STR_YMD2="+STR_YMD2
                                   + "&END_YMD2="+END_YMD2;
			dsT_SC_SCHLBOOK.reset();
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
			if(!fnc_SearchItemCheck()) return;

			//���ڱ� ��û�� ó�� ��ȸ
			var occ_cd = document.getElementById("cmbOCC_CD_SHR").value;
			var sort_gbn = document.getElementById("cmbSORT_GBN_SHR").value;

	        var url = "scha080_PV.jsp?OCC_CD="+occ_cd+"&STR_YM="+str_ym+"&END_YM="+end_ym+"&SORTGBN="+sort_gbn;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_SC_SCHLBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_SC_SCHLBOOK.GridToExcel("�Ⱓ�����ڱ�������Ȳ", '', 225);
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
        	// �ʱ�ȭ
			document.getElementById("cmbOCC_CD_SHR").value = "A";
            document.getElementById("cmbSORT_GBN_SHR").value = "1";
        	document.getElementById("resultMessage").innerText = ' ';

        	dsT_SC_SCHLBOOK.ClearData();
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


			return true;

        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   *
         ********************************************/
        function fnc_OnLoadProcess() {

			//�ٷα���
            for( var i = 1; i <= dsCOMMON_A1.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_A1.NameValue(i,"CODE_NAME");
                document.getElementById("cmbOCC_CD_SHR").add(oOption);

            }

            document.getElementById("txtSTR_YMD_SHR").value = getStrDate();
            document.getElementById("txtEND_YMD_SHR").value = getToday();

			cfStyleGrid(form1.grdT_SC_SCHLBOOK,0,"false","false");      // Grid Style ����
			document.getElementById('cmbOCC_CD_SHR').focus();

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK)		   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload"        Value="True">
		<Param Name="UseChangeInfo"   Value="True">
		<Param Name="ViewDeletedRow"  Value="False">
	</Object>

	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.RealCount(1, dsT_SC_SCHLBOOK.CountRow));
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!---------------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +---------------------------------------------------------------------->
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�Ⱓ�� ���ڱ�������Ȳ</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ڱ�����/<font color="#000000">�Ⱓ�� ���ڱ�������Ȳ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
							<col width="60"></col>
							<col width="220"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
                        <tr>
                            <td class="searchState" align="right">��û����</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR','','103','110');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR','','218','110');"></a>
                            </td>
                            <td class="searchState" align="right">��������</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtSTR_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD_SHR2','','103','110');"></a>
                                ~
                                <input type="text" id="txtEND_YMD_SHR2" style="ime-mode:disabled" size="10" maxlength="10" onblur= "fnc_CheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD_SHR2','','218','110');"></a>
                            </td>
                        </tr>
						<tr>
							<td align="center" class="searchState">�ٷα���&nbsp;</td>
							<td class="padding2423">
								<select id="cmbOCC_CD_SHR" style="WIDTH:80px" onChange="fnc_SearchList();">
								                        <option value="">��ü</option>
								</select>
							</td>
                            <td align="center" class="searchState">���ı���&nbsp;</td>
							<td class="padding2423">
                                <select id="cmbSORT_GBN_SHR" style="width:80px" onChange="fnc_SearchList();">
                                    <option value="1">���޺�</option>
                                    <option value="2">�б���</option>
                                    <option value="3">�Ⱓ��</option>
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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:390px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="PIS_QQ"	    width="40"	name="�б�"			align="center"	Edit=none subsumtext=""</C>
                            <C> id="IPT_YMD"	width="80"	name="��û����"		align="center"	Edit=none</C>
                            <C> id="PAY_YMD"	width="80"	name="��������"		align="center"	Edit=none</C>

							<C> id="ENO_NO"		width="60"	name="���"			align="center" </C>
							<C> id="ENO_NM"		width="60"	name="����"			align="left" </C>
							<C> id="DPT_NM"		width="110"	name="�Ҽ�"			align="left"   </C>
							<C> id="JOB_NM"		width="70"	name="����"			align="center"   </C>
							<C> id="HIR_YMD"	width="70"	name="�Ի���"	    align="center" </C>
							<C> id="SEL_NM"		width="50"	name="�����"	    align="left" </C>
							<C> id="GUBUN_NM"	width="65"	name="�з±���"		align="center" </C>
							<C> id="FSCH_NM"	width="65"	name="�гⱸ��"		align="center" </C>
							<C> id="RET_AMT"	width="65"	name="���б�"	    align="right" </C>
							<C> id="EDU_AMT"	width="65"	name="������"	    align="right" </C>
							<C> id="END_AMT"	width="65"	name="�л�ȸ��"		align="right" </C>
							<C> id="OTH_AMT"	width="65"	name="��Ÿ"			align="right" </C>
							<C> id="TOT_AMT"	width="65"	name="�հ�"			align="right" </C>
							<C> id="PAY_AMT"	width="65"	name="���ޱݾ�"		align="right" </C>
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
