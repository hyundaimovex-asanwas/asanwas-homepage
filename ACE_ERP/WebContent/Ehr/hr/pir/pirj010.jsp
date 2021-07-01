	<!--*************************************************************************
	* @source      : pirj010.jsp												*
	* @description : �����ο���Ȳ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/09            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�����ο���Ȳ(pirj010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value;
			var OCC_CD_SHR = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR = document.getElementById("cmbGBN_CD_SHR").value;

			DPT_CD_SHR = (DPT_CD_SHR == null) ? "%" : DPT_CD_SHR;

			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.j.pirj010.cmd.PIRJ010CMD&S_MODE=SHR&DPT_CD_SHR="+DPT_CD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
			trVI_T_CM_PERSON.KeyValue = "SHR"
                                      + "(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON"
                                      + ",O:dsT_CM_COMMON=dsT_CM_COMMON)";
			trVI_T_CM_PERSON.post();

            document.getElementById("txtTOT_INFO").style.backgroundColor = "#F2FDD1";

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
        	alert("���� �غ����Դϴ�.");
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("�����ο���Ȳ", '', 225)
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

        	document.form1.txtDPT_CD_SHR.value = "";
        	document.form1.txtDPT_NM_SHR.value = "";
        	document.getElementById("txtTOT_CNT").innerText   = ' ';
        	document.form1.txtTOT_INFO.value   = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.getElementById("resultMessage").innerText = ' ';

        	dsVI_T_CM_PERSON.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsVI_T_CM_PERSON.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
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

            // �ٷα��� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}

			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style ����
            document.getElementById("txtTOT_INFO").style.display = "none";

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
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<Object ID="dsT_CM_COMMON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsO=dsVI_T_CM_PERSON)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
        }

            //   alert(dsVI_T_CM_PERSON.ExportData(1,dsVI_T_CM_PERSON.CountRow,true));
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
		if(dsVI_T_CM_PERSON.CountRow >= 1){
       //     document.getElementById("txtTOT_CNT").innerText = dsT_CM_COMMON.NameSum("CNT", 0, 0)+" ��";

          document.getElementById("txtTOT_CNT").innerText = dsT_CM_COMMON.NameSum("CNT", 0, 0)+" ��"
                               + '  ( ��: ' +  dsT_CM_COMMON.NameSum("MF_CNT", 0, 0) + ' ��'
                               + ' / ��: '  +  (dsT_CM_COMMON.NameSum("CNT", 0, 0)-dsT_CM_COMMON.NameSum("MF_CNT", 0, 0)) + ' �� )';

            var info = "";
            for(var i=1; i<=dsT_CM_COMMON.CountRow; i++) {
                info += "     " + dsT_CM_COMMON.NameValue(i, "INFO")+"\t";
                if(i%6 == 0) info += "\n";

            }
	        document.getElementById("txtTOT_INFO").style.display = "";
            document.getElementById("txtTOT_INFO").rows = Math.ceil(i/6);
    		document.form1.txtTOT_INFO.value = info; // �ѿ� ��

		}

		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
    </script>


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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�����ο���Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�ο�����/<font color="#000000">�����ο���Ȳ</font></td>
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
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
					<col width="80"></col>
					<col width="200"></col>
					<col width="80"></col>
					<col width="150"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�Ҽ�</td>
					<td class="padding2423">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onfocusout="fnc_GetCommNm('A4', 'txtDPT_CD_SHR', 'txtDPT_NM_SHR')" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
						<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
							<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
						</a>
					</td>
					<td class="searchState" align="right">�ٷα��к�</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH: 75%">
							<option value="0">���</option>
						</select>
					</td>
					<td class="searchState" align="right">�ٹ�����</td>
					<td class="padding2423" align="left">
						<select id="cmbGBN_CD_SHR" style="WIDTH: 60%">
							<option value="0">���</option>
							<option value="1">����</option>
							<option value="2">IT��</option>
							<option value="3">��ܻ��</option>
							<option value="4">�ؿ�</option>
						</select>
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{curow}"	width=29	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="DPT_NM"		width=110	name="�Ҽ�"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="JOB_NM"		width=70	name="����"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HOB_NM"		width=60	name="ȣ��"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NO"		width=70	name="���"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NM"		width=60	name="����"		align=center	Edit=none	 </C>
							<C> id="CET_NO"		width=100	name="�ֹι�ȣ"	align=center	Edit=none	 </C>
							<C> id="HIR_YMD"	width=90	name="�Ի���"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="JPR_YMD"	width=90	name="������"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE"		width=60	name="����"			align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE_GG"		width=60	name="����"			align=center	Edit=none	 RightMargin="10"</C>
							<C> id="EM_PHN_NO"	width=100	name="�ڵ���"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_CD"	width=60	name="�з��ڵ�"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_NM"	width=100	name="�з±���"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_CD"		width=60	name="�б��ڵ�"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_NM"		width=100	name="�б���"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_CD"		width=60	name="�а��ڵ�"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_NM"		width=100	name="�а���"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_CD"		width=60	name="�����ڵ�"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_NM"		width=60	name="��������"	   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SEX"		width=60	name="����"		   align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HIRG_YMD"	width=90	name="�׷��Ի���"		   align=left		Edit=none	 RightMargin="10"</C>
							<C> id="REMARK"		width=120	name="������"		   align=left		Edit=none	 RightMargin="10"</C>
							<C> id="REG_NM"		width=120	name="�ٹ�����"		   align=left		Edit=none	 RightMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="paddingTop8">
    			<table border="0" cellspacing="0" cellpadding="0" width="100%">
        			<tr>
        				<td align="left" width="80"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">&nbsp;��&nbsp;&nbsp;��&nbsp;:&nbsp;&nbsp;</td>
        				<td align="left" width="720" id="txtTOT_CNT"></td>
        			</tr>
                    <tr>
                        <td colspan="2"><textarea rows="1" id="txtTOT_INFO" class="input_ReadOnly" readonly style="width:100%;"></textarea></td>

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

