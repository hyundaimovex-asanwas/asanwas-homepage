	<!--*************************************************************************
	* @source      : welj010.jsp												*
	* @description : ��ٹ�����û PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/12/17            ������                     ��ٹ�����û �����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.excel");
%>
<%
	String eno_no = box.getString("SESSION_ENONO");         //���
	String eno_nm = box.getString("SESSION_ENONM");         //����
	String dep_cd = box.getString("SESSION_DPTCD");         //�μ�
	String dep_nm = box.getString("SESSION_DPTNM");         //�μ���
	String job_nm = box.getString("SESSION_JOBNM");         //����
%>
<html>
<head>
	<title>��ٹ�����û(welj010)</title>
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

		var btnList = 'TTTTFFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ENO_NO_SHR = document.getElementById("txtENO_NO").value;

			trT_WL_BUSAPP_SHR.KeyValue = "tr05(O:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";

			trT_WL_BUSAPP_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD"
											                                   + "&S_MODE=SHR"
											                                   + "&ENO_NO="+ENO_NO_SHR;
			trT_WL_BUSAPP_SHR.post();
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
			trT_WL_BUSAPP.KeyValue = "tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";
			trT_WL_BUSAPP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SAV";
			trT_WL_BUSAPP.post();
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
			dsT_WL_BUSAPP.AddRow();
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "ENO_NO") = "<%=eno_no%>";
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") = "INS";

			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_WL_BUSAPP.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�����Ͻðڽ��ϱ�?\n";

	            if( confirm(tmpMSG) ){
					dsT_WL_BUSAPP.DeleteRow(dsT_WL_BUSAPP.RowPosition);
					trT_WL_BUSAPP.KeyValue = "tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)";
					trT_WL_BUSAPP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=DEL";
					trT_WL_BUSAPP.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_WL_BUSAPP.ClearData();
			dsT_WL_BUSAPP.ClearData();
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
			for(var i = 1; i <= dsT_WL_BUSAPP.CountRow; i++){
				if(dsT_WL_BUSAPP.NameVAlue(i, "PIS_YYMM") == ""){
					alert("����� �Է��Ͻʽÿ�");
					return false;
				}
				if(dsT_WL_BUSAPP.NameVAlue(i, "LINE_CD") == ""){
					alert("�뼱�� �����Ͻʽÿ�");
					return false;
				}
			}
         	if ( !dsT_WL_BUSAPP.isUpdated && !dsT_WL_BUSAPP.isUpdated) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			if(document.getElementById("txtFULL_GBN").value == "2" ){
				alert("�����뼱�Դϴ�. ����� ��ܿ� ���ϴ�.");
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	 dsT_WL_BUSAPP.SetDataHeader(
        	        			"ENO_NO:STRING(11):KEYVALUETYPE,"+			// ���
								"PIS_YYMM:STRING(10):KEYVALUETYPE,"+			// ���
	        					"LINE_CD:STRING(10),"+			// �뼱�ڵ�
	        					"GUBUN:STRING(10),"+			// �뼱�ڵ�
	                            "SEQ:STRING(30),"+			// ����
	                            "PHONE:STRING(20),"+			// �Ҽ�
	                            "STOP_LOC:STRING(100),"+			// �Ҽ�
	                            "STOP_TIME:STRING(100),"+			// ����
								"REMARK:STRING(100)"			// ���
								);



			document.getElementById("txtENO_NO").value = "<%=eno_no%>";
			document.getElementById("txtENO_NM").value = "<%=eno_nm%>";
			document.getElementById("hidEMPL_DPT_CD").value = "<%=dep_cd%>";
			document.getElementById("txtDPT_NM").value = "<%=dep_nm%>";
			document.getElementById("txtJOB_NM").value = "<%=job_nm%>";


			cfStyleGrid2(form1.grdT_WL_BUSAPP,0,"true","false");      // Grid Style ����

			fnc_BusLine();

			fnc_SearchList();

        }

        function fnc_BusLine() {
			trT_WL_BUSLINE.KeyValue = "tr01(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE,O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSLINE.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SHR_LINE";
			trT_WL_BUSLINE.post();
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
            fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO").value  != "") {
                fnc_SearchEmpNo();
            }
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

            var PIS_YYMM = document.getElementById("txtPIS_YYMM").value.replace("-","");
            var today = getToday().replace("-","").replace("-","");

            if(PIS_YYMM != ""){
	            if(PIS_YYMM < today.substring(0,6)){
	                alert("�̹� ������ ���ڴ� ����Ҽ� �����ϴ�.");
	                document.getElementById("txtPIS_YYMM").value = "";
	                document.getElementById("txtPIS_YYMM").focus();
	                return false;
	            }
            }

        }
        /******************
         * 08. ����/�ð�  *
         ******************/
        function fnc_StopLoc(line) {
			trT_WL_BUSSTOP.KeyValue = "tr01(O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)";
			trT_WL_BUSSTOP.action = "/servlet/GauceChannelSVL?cmd=hr.wel.j.welj010.cmd.WELJ010CMD&S_MODE=SHR_STOP&LINE_CD="+line;
			trT_WL_BUSSTOP.post();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_BUSAPP)			 	   |
    | 3. ���Ǵ� Table List(T_WL_BUSAPP) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_BUSLINE)			 	   |
    | 3. ���Ǵ� Table List(T_WL_BUSLINE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSLINE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_BUSSTOP)			 	   |
    | 3. ���Ǵ� Table List(T_WL_BUSSTOP) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_WL_BUSSTOP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_BUSAPP)		       |
    | 3. ���Ǵ� Table List(T_WL_BUSAPP)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSAPP_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSAPP=dsT_WL_BUSAPP)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_BUSAPP)		       |
    | 3. ���Ǵ� Table List(T_WL_BUSAPP)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(I:dsT_WL_BUSAPP=dsT_WL_BUSAPP)">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_BUSLINE)		       |
    | 3. ���Ǵ� Table List(T_WL_BUSLINE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSLINE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSLINE=dsT_WL_BUSLINE)">
	</Object>
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_WL_BUSLINE)		       |
    | 3. ���Ǵ� Table List(T_WL_BUSLINE)			       |
    +------------------------------------------------------>
	<Object ID="trT_WL_BUSSTOP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_WL_BUSSTOP=dsT_WL_BUSSTOP)">
	</Object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_WL_BUSAPP.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_WL_BUSAPP Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP event="OnSuccess()">
        fnc_SearchList();
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP_SHR event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_WL_BUSAPP event="OnFail()">
        cfErrorMsg(this);

		 fnc_SearchList();
    </script>

	<script for=trT_WL_BUSSTOP event="OnSuccess()">
		if(dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") == "INS"){
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");
		}
	</script>


	<script language=JavaScript for="cmbLINE_CD" event=OnSelChange()>
		if(dsT_WL_BUSLINE.NameValue(dsT_WL_BUSLINE.RowPosition, "FULL_GBN") == "2"){
			alert("�����뼱�Դϴ�");
		}
		document.getElementById("txtFULL_GBN").value = dsT_WL_BUSLINE.NameValue(dsT_WL_BUSLINE.RowPosition, "FULL_GBN");
		fnc_StopLoc(cmbLINE_CD.ValueOfIndex("LINE_CD", cmbLINE_CD.Index));

	</script>

	<script language=JavaScript for="cmbSEQ" event=OnSelChange()>
		if(dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "GUBUN") == "INS"){
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "LINE_CD") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "LINE_CD");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "SEQ") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "SEQ");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_LOC") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_LOC");
			dsT_WL_BUSAPP.NameValue(dsT_WL_BUSAPP.RowPosition, "STOP_TIME") = dsT_WL_BUSSTOP.NameValue(dsT_WL_BUSSTOP.RowPosition, "STOP_TIME");

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
	<input type="hidden" id="txtFULL_GBN">
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��ٹ�����û</td>
					<td align="right" class="navigator">HOME/�����Ļ�/��ٹ���/<font color="#000000">��ٹ�����û</font></td>
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
					<col width="110"></col>
					<col width="70"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtENO_NO" name="txtENO_NO" size="8" class="input_ReadOnly"  readonly maxlength= "8"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()">
                        <input id="txtENO_NM" name="txtENO_NM" size="10" class="input_ReadOnly"  readonly maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()">
						<!--
                        <img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
						-->
                        <input type="hidden" id="hidEMPL_DPT_CD">
                    </td>

					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly"  readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="12" class="input_ReadOnly"  readonly></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtPIS_YYMM" name="txtPIS_YYMM" size="7" maxlength="7" onblur="cfCheckDate(this);fnc_ChkDate();" onkeypress="cfDateHyphen(this);cfCheckNumber(); ">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgYmd','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgYm" name="ImgYm" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YYMM','','20','120');"></a>
                    </td>
					<td class="creamBold" align="center">������ȣ</td>
                    <td class="padding2423">
                        <input id="txtPHONE" name="txtPHONE" size="20" maxlength= "20">
                    </td>
					<td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left" >
						<input id="txtREMARK" name="txtREMARK" size="40" maxlength= "50">
					</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
				<comment id="__NSID__">
				<object id=cmbLINE_CD classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="106" width="130">
					<param name=ComboDataID		value=dsT_WL_BUSLINE>
					<param name=SearchColumn	value=LINE_CD>
					<param name=Sort			value=True>
					<param name=ListExprFormat	value="LINE_CD^0^30,LINE_NM^0^100">
					<param name=BindColumn		value="LINE_CD">
					<param name=EditExprFormat 	value="% - %;LINE_CD;LINE_NM">

					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					<!--
                        <select id="cmbLINE_CD" style="width='100';" onChange="fnc_StopLoc()" >
							<option value="">&nbsp;</option>
						</select>
					-->
                    </td>
					<td class="creamBold" align="center">����/�ð�</td>
                    <td class="padding2423" colspan="3">
					<comment id="__NSID__">
					<object id="cmbSEQ" classid="clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197" height="106" width="400">
						<param name=ComboDataID		value="dsT_WL_BUSSTOP">
						<param name=SearchColumn	value="SEQ">
						<param name=Sort			value="True">
						<param name=ListExprFormat	value="SEQ^0^20,STOP_LOC^0^250,STOP_TIME^0^100">
						<param name=BindColumn		value="SEQ">
						<param name=EditExprFormat 	value="% - % - %;SEQ;STOP_LOC;STOP_TIME">

						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					<!--
                        <select id="cmbSTOP_LOC" style="width='300';"  >
							<option value="">&nbsp;</option>
						</select>
					-->
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

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

	<p>
	�� ��ٹ����뼱 Ȯ�� �ٸ��ϴ�.[���������� ���� �� ��û���ɿ��� Ȯ�� �� ��û�ٶ��ϴ�.]
    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)">
    <img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onclick="cfDownload('welj010.xls', '<%=FILEURL %>/welj010.xls');"></a>
    <br>
	</p>
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_WL_BUSAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_WL_BUSAPP">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29   name="NO"		align=center	value={String(Currow)}</C>
                            <C> id="ENO_NO"     width=100  name="���"      align=center    edit=none     show=false        </C>
                            <C> id="PIS_YYMM"   width=100  name="���"      align=center    edit=none           </C>
							<C> id="LINE_CD"	width=100  name="�뼱"	    align=center	EditStyle=Lookup  Data="dsT_WL_BUSLINE:LINE_CD:LINE_NM"        </C>
							<C> id="SEQ"	    width=100  name="ž�����ڵ�"    align=center      show=false  </C>
							<C> id="STOP_LOC"	    width=300  name="ž����"    align=left	      </C>
							<C> id="STOP_TIME"	    width=100  name="ž�½ð�"    align=center	        </C>
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
	<!-- T_WL_BUSAPP ���� ���̺� -->
	<object id="bndT_WL_BUSAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_WL_BUSAPP">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=Value</C>
			<C>Col=PIS_YYMM	    Ctrl=txtPIS_YYMM    Param=Value</C>
			<C>Col=PHONE		Ctrl=txtPHONE		Param=Value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=Value</C>
		">
	</object>
