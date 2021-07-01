	<!--*************************************************************************
	* @source      : welm011.jsp												*
	* @description : �����ǽ�û PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2010/04/09            ������                     �����ǽ�û �����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="common.util.DateUtil" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //���
	String eno_nm = box.getString("SESSION_ENONM");         //����
	String dep_cd = box.getString("SESSION_DPTCD");         //�μ�
	String dep_nm = box.getString("SESSION_DPTNM");         //�μ���
	String job_nm = box.getString("SESSION_JOBNM");         //����
	String job_cd = box.getString("SESSION_JOBCD");         //����

	String SESSION_ROLE_CD = box.getString("SESSION_ROLE_CD");         //����

	// ����
	int dayOfWeek = DateUtil.getDayOfWeek(new Date());
	// ����ð�
	String CurHour = DateUtil.getCurrentHour();

	System.out.println("���� [" + dayOfWeek + "] �ð� [" + CurHour + "]");
%>
<html>
<head>
	<title>�ָ������ǽ�û(welm010)</title>
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
		//��.��û���� : ���� ������, �ݿ��� ���� 04:00
		/*
		if(4 == <%=dayOfWeek%> || 6 == <%=dayOfWeek%> ){
			if("<%=CurHour%>" >= "16"){
				alert("��û������ ���� ������, �ݿ��� ���� 4�ñ����Դϴ�");
				frame = window.external.GetFrame(window);
				frame.CloseFrame();
			}
		}else{
		}
		*/
		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_WL_PARKING_SHR.KeyValue = "tr05(O:dsT_WL_PARKING=dsT_WL_PARKING)";
			trT_WL_PARKING_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD"
                                   + "&S_MODE=SHR"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_PARKING_SHR.post();
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
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			// save
			trT_WL_PARKING.KeyValue = "tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)";
			trT_WL_PARKING.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD&S_MODE=SAV";
			trT_WL_PARKING.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			// �� �߰�
			dsT_WL_PARKING.AddRow();
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NM") = "<%=eno_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_NM") = "<%=dep_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_NM") = "<%=job_nm%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_CD") = "<%=job_cd%>";
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_CD") = "<%=dep_cd%>";

			fnc_ChangeStateElement(true, "ImgYmd");
			fnc_ChangeStateElement(true, "txtREQ_YMD");
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_PARKING.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
				var endTag = dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "END_TAG");
				if(endTag == "T"){
					alert("�߱��� �Ϸ�� �����ʹ� �����Ҽ� �����ϴ�");
					return;
				}
           		var tmpMSG = "�����Ͻðڽ��ϱ�?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_PARKING.DeleteRow(dsT_WL_PARKING.RowPosition);
					trT_WL_PARKING.KeyValue = "tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)";
					trT_WL_PARKING.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD&S_MODE=DEL";
					trT_WL_PARKING.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_PARKING.ClearData();
			dsT_WL_PARKING.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			window.close();
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
			var REQ_YMD	= document.getElementById("txtREQ_YMD").value;
			var CAR_KIND	= document.getElementById("txtCAR_KIND").value;
			var CAR_NO	= document.getElementById("txtCAR_NO").value;

			if(REQ_YMD == ""){
				alert("��û���� �Է��Ͻʽÿ�");
				document.getElementById("txtREQ_YMD").focus();
				return;
			}
			if(CAR_KIND == ""){
				alert("������ �Է��Ͻʽÿ�");
				document.getElementById("txtCAR_KIND").focus();
				return;
			}
			if(CAR_NO == ""){
				alert("������ȣ�� �Է��Ͻʽÿ�");
				document.getElementById("txtCAR_NO").focus();
				return;
			}
         	if ( !dsT_WL_PARKING.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_PARKING.SetDataHeader(
        	        			"ENO_NO:STRING(10):KEYVALUETYPE,"+	// ���
								"REQ_YMD:(20):KEYVALUETYPE,"+		// ��û��
        	        			"ENO_NM:STRING(20),"+			// ����
	                            "JOB_CD:STRING(10),"+			// ����
	                            "JOB_NM:STRING(20),"+			// ������
	                            "DPT_CD:STRING(10),"+			// �μ��ڵ�
	                            "DPT_NM:STRING(20),"+			// �μ���
	                            "CAR_KIND:STRING(20),"+			// ����
	                            "CAR_NO:STRING(20),"+			// ������ȣ
								"REMARK:STRING(100)"			// ���
								);
			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";

<%
    //�����ʹ� ���μ� ����
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>

<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

			cfStyleGrid2(form1.grdT_WL_PARKING,0,"true","false");      // Grid Style ����

			fnc_SearchList();

        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
<%
    //�����ʹ� ���μ� ����
    if("1001".equals(SESSION_ROLE_CD) || "1002".equals(SESSION_ROLE_CD)  ) {
%>
            document.getElementById('hidEMPL_DPT_CD').value = "";
<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=dep_cd%>";
			document.getElementById('ImgEnoNo').style.display = "none";

<%
	}
%>

            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
				fnc_CmPerson();
            }
        }
		function fnc_CmPerson(eno_no){
			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;
			trT_CM_PERSON.KeyValue = "tr05(O:dsT_CM_PERSON=dsT_CM_PERSON)";
			trT_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.wel.m.welm010.cmd.WELM010CMD"
                                   + "&S_MODE=SHR_01"
                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_CM_PERSON.post();
		}
        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNm() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNo();
        }

        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNo() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO").value      = obj.eno_no;
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
                document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;

            } else {
                document.getElementById("txtENO_NO").value      = "";
                document.getElementById("txtENO_NM").value      = "";
                document.getElementById("txtDPT_NM").value      = "";
                document.getElementById("txtJOB_NM").value      = "";
            }
        }


        //������ ��¥���� üũ
        function fnc_ChkDate() {

            var REQ_YMD = document.getElementById("txtREQ_YMD").value.replace("-","").replace("-","");
            var today = getToday().replace("-","").replace("-","");
            if(REQ_YMD != ""){
	            if(REQ_YMD < today){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtREQ_YMD").value = "";
	                document.getElementById("txtREQ_YMD").focus();
	                return false;
	            }
            }

        }
		function fnc_Addr(){

		}
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_PARKING)			 	   |
    | 3. ���Ǵ� Table List(T_WL_PARKING) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_PARKING" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)			 	   |
    | 3. ���Ǵ� Table List(T_CM_PERSON) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_CARD)		       |
    | 3. ���Ǵ� Table List(T_WL_CARD)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_PARKING_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_PARKING=dsT_WL_PARKING)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_PARKING)		       |
    | 3. ���Ǵ� Table List(T_WL_PARKING)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_PARKING" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_PARKING=dsT_WL_PARKING)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_PARKING)		       |
    | 3. ���Ǵ� Table List(T_WL_PARKING)			       |
    +------------------------------------------------------>
	<Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_CM_PERSON=dsT_CM_PERSON)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_PARKING.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_PARKING Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnSuccess()">

		if (dsT_CM_PERSON.CountRow > 0)    {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NO") = dsT_CM_PERSON.NameValue(1, "ENO_NO");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "ENO_NM") = dsT_CM_PERSON.NameValue(1, "ENO_NM");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_NM") = dsT_CM_PERSON.NameValue(1, "DPT_NM");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "DPT_CD") = dsT_CM_PERSON.NameValue(1, "DPT_CD");
			dsT_WL_PARKING.NameValue(dsT_WL_PARKING.RowPosition, "JOB_CD") = dsT_CM_PERSON.NameValue(1, "JOB_CD");
		} else {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=trT_CM_PERSON Event="OnFail()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
		fnc_SearchList();
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_PARKING event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for="dsT_WL_PARKING" event=OnRowPosChanged(row)>
		var endTag = dsT_WL_PARKING.NameValue(row, "END_TAG");
		if(endTag == "T"){
			fnc_ChangeStateElement(false, "txtREMARK");
		}else{
			fnc_ChangeStateElement(true, "txtREMARK");
		}

	</script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();"  onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ָ������ǽ�û</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ָ�������/<font color="#000000">�ָ������ǽ�û</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->




	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width="170"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">

                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td class="creamBold" align="center">��û��</td>
                    <td class="padding2423">
						<input id="txtREQ_YMD" name="txtREQ_YMD" size="10" maxlength="10" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgYmd" name="ImgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtREQ_YMD','','20','120');" class="input_ReadOnly"  readonly></a>                    </td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423"><input id="txtCAR_KIND" size="30" ></td>
					<td align="center" class="creamBold">������ȣ</td>
					<td class="padding2423"><input id="txtCAR_NO" size="30" ></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">����</td>
                    <td class="padding2423" colspan="5">
					  <input id="txtREMARK" name="txtREMARK" size="100" maxlength="100" >
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->
	<p>
��.������ �� �ָ� ���� ���� 2:00�� ���� ��û����!!!			<br>
��.��) 15��(������)��� 14�� ���� 2:00���� ��û����.	<br>

	</p>
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_PARKING" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_PARKING">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="���"      align=center    edit=none     show=false        </C>
							<C> id="REQ_YMD"	width=100  name="��û��"    align=center      </C>
							<C> id="CAR_KIND"   width=200  name="����"      align=center      </C>
							<C> id="CAR_NO"     width=200  name="������ȣ"  align=center      </C>
							<C> id="END_TAG"    width=100  name="�߱���Ȳ"  align=center   value={DECODE(END_TAG,"T","���οϷ�","��û")}   </C>
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																		 *
    *                                       												 *
    ***************************************************************************************-->
	<!-- T_WL_CARD ���� ���̺� -->
	<object id="bndT_WL_PARKING" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_PARKING">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=Value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=Value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=Value</C>
			<C>Col=REQ_YMD		Ctrl=txtREQ_YMD		Param=Value</C>
			<C>Col=CAR_KIND		Ctrl=txtCAR_KIND	Param=Value</C>
			<C>Col=CAR_NO		Ctrl=txtCAR_NO		Param=Value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=Value</C>
		">
	</object>
