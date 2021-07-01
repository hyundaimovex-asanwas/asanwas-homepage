	<!--*************************************************************************
	* @source      : piri020.jsp												*
	* @description : ���庰�ο���Ȳ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2013/04/09            �̵���            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>���庰�ο���Ȳ(piri020)</title>
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

		var btnList = 'TFFTTFFT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var TEAM_CD_SHR = document.getElementById("txtTEAM_CD_SHR").value;

			//DPT_CD_SHR = (DPT_CD_SHR == null) ? "%" : DPT_CD_SHR;

			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.i.piri020.cmd.PIRI020CMD&S_MODE=SHR&TEAM_CD_SHR="+TEAM_CD_SHR;
			trVI_T_CM_PERSON.KeyValue = "SHR"
                                      + "(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON)";

			trVI_T_CM_PERSON.post();


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

        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("���庰�ο���Ȳ", '', 225)
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


			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","true");      // Grid Style ����

		<%
		    //�����ڰ� �ƴϸ�  ���� �˻��� ���� ���Ѵ�.
		    if(!(box.getString("SESSION_ENONO").equals("6060002") 
		    		|| box.getString("SESSION_ENONO").equals("2050046") 
		    		|| box.getString("SESSION_ENONO").equals("2080028"))) {
		%>
		            fnc_ChangeStateElement(false, "txtTEAM_CD_SHR");
		            fnc_ChangeStateElement(false, "txtTEAM_NM_SHR");
		            fnc_HiddenElement(  "ImageTeam" );  
		<%
		    }
		%>

	        document.getElementById("txtTEAM_CD_SHR").value = "<%=box.get("SESSION_TEAMCD") %>";
	        document.getElementById("txtTEAM_NM_SHR").value = "<%=box.get("SESSION_TEAMNM") %>";
	        document.getElementById("txtENO_NO_SHR").value = "<%=box.get("SESSION_ENONO") %>";
	        document.getElementById("txtENO_NM_SHR").value = "<%=box.get("SESSION_ENONM") %>";
	        
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 									*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

		/********************************************
         * 17. Form�� Active �� �� ó�� �� �� 									*
         ********************************************/
        /**
         * �Ҽ�, KPI, ����, ��, ������ �ڵ带 ��ȸ�Ѵ�.
         * @param - ctrl_01 : ���Ϲ��� �ڵ��
         * @param - ctrl_02 : ���Ϲ��� �ڵ���Ӹ�
         * @param - ctrl_03 : Ÿ��Ʋ��
         * @param - ctrl_04 : cd_gbn �ڵ��
         * @param - ctrl_05 : ���� �μ� �ڵ�
         */
		function fnc_commnmPopup222(ctrl_01,ctrl_02,ctrl_03,ctrl_04) {

			var obj = new String();

            obj.comm_cd = document.getElementById(ctrl_01).value;
            obj.comm_nm = document.getElementById(ctrl_02).value;
			obj.title = ctrl_03;
			obj.gbn = document.getElementById(ctrl_04).value;

			window.showModalDialog("/common/popup/codenm_sel.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(obj.comm_cd != '' && obj.comm_nm != ''){
				document.getElementById(ctrl_01).value = obj.comm_cd;
				document.getElementById(ctrl_02).value = obj.comm_nm;
			}
		
		}
		
    </script>
</head>



    <!------------------------------+
    | grid���� row�� ����Ŭ�������� |
    +------ ------------------------>
	<script for=grdVI_T_CM_PERSON event=OnDblClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
		var url = "";
		var data = new String();

		if(Row < 1) {
			return;
		} else {
			data.eno_no = dsVI_T_CM_PERSON.NameValue(Row,'ENO_NO');
			data.mode       = "read";
			url = "/hr/pir/pirc010.jsp";
			window.showModalDialog(url, data, "dialogWidth:870px; dialogHeight:615px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		}
		
	</script>


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
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadError()">
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���庰�ο���Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�ο�����/<font color="#000000">���庰�ο���Ȳ</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
					<col width="150"></col>
					<col width="80"></col>
					<col width="150"></col>					
					<col width="*"></col>					
				</colgroup>
				<tr>
					<td class="searchState" align="right">�Ҽ�&nbsp;</td>
					<td class="padding2423">
                        <input id="txtTEAM_CD_SHR" name="txtTEAM_CD_SHR" size="6" class="input_ReadOnly" readonly>
						<input id="txtTEAM_NM_SHR" name="txtTEAM_NM_SHR" size="30" class="input_ReadOnly" readonly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageTeam','','/images/button/btn_HelpOver.gif',1)">
							<img src="/images/button/btn_HelpOn.gif" name="ImageTeam" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup222('txtTEAM_CD_SHR','txtTEAM_NM_SHR','����','txtENO_NO_SHR')">
						</a>
					</td>

                    <td align="right" class="searchState">�� ��&nbsp;</td>
                    <td class="padding2423">
                        <input id=txtENO_NO_SHR name=txtENO_NO_SHR size="7"  class="input_ReadOnly" readonly>
                        <input id=txtENO_NM_SHR name=txtENO_NM_SHR size="8" class="input_ReadOnly" readonly>
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
							<C> id="{curow}"			width=29	name="NO"			align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="DPT_NM"			width=110	name="�Ҽ�"		align=left		Edit=none	 LeftMargin="10" show=false</C>
							<C> id="JOB_NM"			width=70	name="����"		align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="HOB_NM"			width=60	name="ȣ��"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NO"			width=70	name="���"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="ENO_NM"			width=60	name="����"		align=center	Edit=none	 </C>
							<C> id="CET_NO"			width=100	name="�ֹι�ȣ"	align=center	Edit=none	 </C>
							<C> id="HIR_YMD"		width=90	name="�Ի���"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="HIRG_YMD"		width=90	name="�׷��Ի���"	align=center	Edit=none	 RightMargin="10"</C>							
							<C> id="JPR_YMD"		width=90	name="������"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="AGE"				width=60	name="����"		align=center	Edit=none	 RightMargin="10"</C>
							<C> id="EM_PHN_NO"	width=100	name="�ڵ���"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="EDGR_NM"		width=100	name="�з±���"	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="SCH_NM"			width=100	name="�б���"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="MAJ_NM"			width=100	name="�а���"	   	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="GRD_NM"			width=100	name="��������"	align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="REMARK"			width=120	name="������"   align=left		Edit=none	 RightMargin="10"</C>

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

