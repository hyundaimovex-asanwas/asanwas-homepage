	<!--*************************************************************************
	* @source      : proa030.jsp												*
	* @description : ��������ڼ��� PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/17            ä����         	        �����ۼ�
    * 2007/04/15            ���м�         	        �����ۼ�			*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>��������ڼ���(proa030)</title>
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

		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var isSave = false;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // �����⵵

            if( PMT_YMD_SHR == "" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	//if( PMT_YMD_SHR != next_yy ){
        	//	alert("����⵵�� ����ڸ� ó�� �����մϴ�. ��)"+next_yy);
        	//	return;
        	//}

			isSave = false;

			var GBN_CD_SHR     = document.form1.hidGBN_CD_SHR.value;     // ����/Ư������ ����

            /*
			var JOB_CD_SHR     = document.form1.txtJOB_CD_SHR.value;     // �����ڵ�
			var DPT_CD_SHR     = document.form1.txtDPT_CD_SHR.value;     // �Ҽ��ڵ�
			var JOBDPT_CD_SHR  = document.form1.hidJOBDPT_CD_SHR.value;  // ����/�Ҽ� ����
			var TOE_CD_SHR     = document.form1.hidTOE_CD_SHR.value;     // ���� ����
			var REC_CD_SHR     = document.form1.hidREC_CD_SHR.value;     // ��õ ����
			var LAN_CD_SHR     = document.form1.hidLAN_CD_SHR.value;     // ����/���� ����
            */

            trVI_T_CM_PERSON.KeyValue = "SHR(O:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa030.cmd.PROA030CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;//+"&JOB_CD_SHR="+JOB_CD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&JOBDPT_CD_SHR="+JOBDPT_CD_SHR+"&TOE_CD_SHR="+TOE_CD_SHR+"&REC_CD_SHR="+REC_CD_SHR+"&LAN_CD_SHR="+LAN_CD_SHR;
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
            var PMT_YMD_SHR     = document.form1.txtPMT_YMD_SHR.value;      // �����⵵
            var GBN_CD_SHR      = document.form1.hidGBN_CD_SHR.value;       // ����/Ư������ ����

			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			
			if(!confirm("��������� ������ �Ͻðڽ��ϱ�?")){
                return false;
            }
            
			dsVI_T_CM_PERSON.UseChangeInfo = "false";

            trVI_T_CM_PERSON_SAV.KeyValue = "SAV(I:dsVI_T_CM_PERSON=dsVI_T_CM_PERSON, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
			trVI_T_CM_PERSON_SAV.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa030.cmd.PROA030CMD&S_MODE=SAV&PMT_YMD_SHR="+PMT_YMD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR;
			trVI_T_CM_PERSON_SAV.post();
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

			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;   // �����⵵

            if( PMT_YMD_SHR == "" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( PMT_YMD_SHR.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}

            var gbn_cd     = document.form1.hidGBN_CD_SHR.value;     // ����/Ư������ ����

			//var job_cd     = document.form1.txtJOB_CD_SHR.value;     // �����ڵ�
			//var dpt_cd     = document.form1.txtDPT_CD_SHR.value;     // �Ҽ��ڵ�
			//var jobdpt_cd  = document.form1.hidJOBDPT_CD_SHR.value;  // ����/�Ҽ� ����
			//var toe_cd     = document.form1.hidTOE_CD_SHR.value;     // ���� ����
			//var rec_cd     = document.form1.hidREC_CD_SHR.value;     // ��õ ����
			//var lan_cd     = document.form1.hidLAN_CD_SHR.value;     // ����/���� ����

            var url = "proa030_PV.jsp?pmt_ymd="+PMT_YMD_SHR+"&gbn_cd="+gbn_cd;//+"&job_cd="+job_cd+"&dpt_cd="+dpt_cd+"&jobdpt_cd="+jobdpt_cd+"&toe_cd="+toe_cd+"&rec_cd="+rec_cd+"&lan_cd="+lan_cd;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
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
  			//document.form1.txtPMT_YMD_SHR.value = next_yy;
  			
  			//document.form1.txtJOB_CD_SHR.value  = "";
  			//document.form1.txtDPT_CD_SHR.value  = "";
  			//document.form1.txtJOB_NM_SHR.value  = "";
  			//document.form1.txtDPT_NM_SHR.value  = "";
  			document.form1.txtPRO_CNT.value     = "";
  			document.form1.txtTRG_CNT.value     = "";
  			document.form1.txtERR_CNT.value     = "";
  			document.form1.txtPRO_STS_MSG.value = "";


			//document.form1.rdoGBN_CD_SHR.item(0).checked = true;
			//document.form1.rdoJOBDPT_SHR.item(0).checked = true;
			//document.form1.rdoTOE_CD_SHR.item(0).checked = true;
			//document.form1.rdoREC_CD_SHR.item(0).checked = true;
			//document.form1.rdoLAN_CD_SHR.item(0).checked = true;

			document.form1.hidGBN_CD_SHR.value  = "1";
			//document.form1.hidJOBDPT_CD_SHR.value = "1";
			//document.form1.hidTOE_CD_SHR.value  = "1";
			//document.form1.hidREC_CD_SHR.value  = "1";
			//document.form1.hidLAN_CD_SHR.value  = "1";

            document.getElementById("resultMessage").innerText = ' ';
            
			changeInput();
			
        	dsVI_T_CM_PERSON.ClearData();
        	dsT_CP_WORKLOG.ClearData();
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
        
            if(document.form1.txtPMT_YMD_SHR.value == '') {
                alert("�����⵵�� �ʼ��Է»����Դϴ�.");
                document.form1.txtPMT_YMD_SHR.focus();
                return false;
            }
                    
         	if(dsVI_T_CM_PERSON.CountRow == 0) {
				alert("������ ���� ����ڰ� �����ϴ�.");
                return false;
			}

            if(dsT_CP_WORKLOG.CountRow == 1) {
                alert("�ش�⵵�� ��������� ó���� �̹� �̷�������ϴ�.");
                return false;
            }

			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
	        changeInput();
	        document.form1.txtPMT_YMD_SHR.value = next_yy;
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
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return;
            if(!cfDateExpr(obj.value)) {
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
            }
        }

  		/********************************************
         * ����/�Ҽ� ���ÿ� ���� �Է� ����                 			*
         ********************************************/
        function changeInput() {
            /*
        	if( document.form1.rdoJOBDPT_SHR[0].checked ){
        		document.form1.txtJOB_CD_SHR.readOnly = false;
        		document.form1.txtJOB_CD_SHR.className = "";
        		document.form1.txtDPT_CD_SHR.readOnly = true;
        		document.form1.txtDPT_CD_SHR.className = "input_ReadOnly";

        		document.form1.txtDPT_CD_SHR.value = "";
        		document.form1.txtDPT_NM_SHR.value = "";
        		document.form1.hidJOBDPT_CD_SHR.value = "1";
        		document.getElementById("imgJOB_CD_SHR").disabled = false;
        		document.getElementById("Image21").disabled = true;
        	}else{
        		document.form1.txtJOB_CD_SHR.readOnly = true;
        		document.form1.txtJOB_CD_SHR.className = "input_ReadOnly";
        		document.form1.txtDPT_CD_SHR.readOnly = false;
        		document.form1.txtDPT_CD_SHR.className = "";

        		document.form1.txtJOB_CD_SHR.value = "";
        		document.form1.txtJOB_NM_SHR.value = "";
        		document.form1.hidJOBDPT_CD_SHR.value = "2";
        		document.getElementById("imgJOB_CD_SHR").disabled = true;
        		document.getElementById("Image21").disabled = false;
        	}
        	*/
        }

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet						 		   	   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)		 	   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
		<param name=TimeOut           value=200000>
	</Object>

    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name=TimeOut           value=200000>
    </Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trVI_T_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<param name=TimeOut value=2000000>
	</Object>

	<Object ID="trVI_T_CM_PERSON_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<param name=TimeOut value=2000000>
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_CM_PERSON Event="OnLoadCompleted(iCount)">

    </Script>

	<Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
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
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnSuccess()">
        if (dsVI_T_CM_PERSON.CountRow == 0) {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� ��������ڰ� �����ϴ�.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_02");
            
            document.getElementById("txtTRG_CNT").value = dsVI_T_CM_PERSON.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
            
        } else if(dsT_CP_WORKLOG.CountRow == 1) {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� ��������� ������ �Ϸ��Ͽ����ϴ�..';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsVI_T_CM_PERSON.CountRow);

            document.getElementById("txtTRG_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT") + dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");
            
        } else {
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� ��������� ������ �����մϴ�.';
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsVI_T_CM_PERSON.CountRow);
            
            document.getElementById("txtTRG_CNT").value = dsVI_T_CM_PERSON.CountRow;
            document.getElementById("txtPRO_CNT").value = "";
            document.getElementById("txtERR_CNT").value = "";
        }

    </script>

	<script for=trVI_T_CM_PERSON_SAV event="OnSuccess()">
		if(dsT_CP_WORKLOG.CountRow == 1){ // ����
            fnc_Message(document.getElementById("resultMessage"), "MSG_01");
            
            document.getElementById("txtPRO_STS_MSG").value = '�ش�⵵�� ��������� ������ �Ϸ��Ͽ����ϴ�..';
            document.getElementById("txtPRO_CNT").value = dsT_CP_WORKLOG.NameValue(1, "PRO_CNT");
            document.getElementById("txtERR_CNT").value = dsT_CP_WORKLOG.NameValue(1, "ERR_CNT");

		}else{// ��ȸ
			alert("��������� ������ �����Ͽ����ϴ�.");
			document.getElementById("resultMessage").innerText = ' ';
		}
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trVI_T_CM_PERSON event="OnFail()">
        alert(trVI_T_CM_PERSON.ErrorMsg);
    </script>

	<script for=trVI_T_CM_PERSON_SAV event="OnFail()">
        alert(trVI_T_CM_PERSON_SAV.ErrorMsg);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������ڼ���</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">��������ڼ���</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)">  <img src="/images/button/btn_ConductOn.gif"   name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
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
							<!-- <col width="100"></col> -->
							<col width="80"></col>
							<col width="95"></col>
							<col width="80"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<!-- <td align="right" class="searchState">����ڼ���&nbsp;</td>  -->
							<td class="searchState"align="right">�����⵵</td>
							<td class="padding2423" align="left">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                            <input type="text" id="txtPMT_YMD_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                        </td>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                                    </tr>
                                    <tr>
                                        <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPMT_YMD_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                                    </tr>
                                </table>
							</td>
							<td class="searchState"align="right"><!-- �������� --></td>
							<td class="padding2423" align="left">
							    <!-- 
								<input type="radio" name="rdoGBN_CD_SHR" id="rdoGBN_CD_SHR" checked style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_CD_SHR.value = '1' ">�������
								&nbsp;
								<input type="radio" name="rdoGBN_CD_SHR" id="rdoGBN_CD_SHR" style="margin-bottom:-2px;border:0;" onClick="document.form1.hidGBN_CD_SHR.value = '2' ">Ư������
								 -->
							</td>
						</tr>
						
						
						<!-- 
						<tr>
						    <td colspan="5" height="5"></td>
						</tr>
						<tr>
						    <td align="right" class="searchState">�μ⹰���&nbsp;</td>
						    <td align="right" >��ȸ����</td>
							<td class="padding2423" align="left" colspan="3">
							    <input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" checked style="margin-bottom:-2px;border:0;"  onClick="changeInput()">
							    ����
							    <input id="txtJOB_CD_SHR" name="txtJOB_CD_SHR" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
								<input id="txtJOB_NM_SHR" name="txtJOB_NM_SHR" size="10" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgJOB_CD_SHR','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgJOB_CD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
                                &nbsp;&nbsp;
							    <input type="radio" id="rdoJOBDPT_SHR" name="rdoJOBDPT_SHR" style="margin-bottom:-2px;border:0;"   onClick="changeInput()">
							    �Ҽ�
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="2" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A4','txtDPT_CD_SHR','txtDPT_NM_SHR');" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image21','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image21" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
								</a>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">TOEIC����</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '1' " checked>
								��ü&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '2' ">
								550�̸�&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoTOE_CD_SHR" name="rdoTOE_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidTOE_CD_SHR.value = '3' ">
								550�̻�
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">��õ����</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '1' " checked>
								��ü&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '2' ">
								��õ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" id="rdoREC_CD_SHR" name="rdoREC_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidREC_CD_SHR.value = '3' ">
								����õ��
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">����/��������</td>
							<td class="padding2423" align="left" colspan="3">
								<input type="radio" id="rdoLAN_CD_SHR" name="rdoLAN_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidLAN_CD_SHR.value = '1' " checked>
								���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    							<input type="radio" id="rdoLAN_CD_SHR" name="rdoLAN_CD_SHR" style="margin-bottom:-2px;border:0;"   onClick="document.form1.hidLAN_CD_SHR.value = '2' ">
    							�����
							</td>
						</tr>
						-->
					</table>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<col width="70"></col>
				<col width=""></col>
				<tr>
					<td align="center" class="creamBold">����ο�</td>
					<td class="padding2423" align="left">
					    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						ó������ο�&nbsp;<input id="txtTRG_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						ó���ο�&nbsp;<input id="txtPRO_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						��ó���ο�&nbsp;<input id="txtERR_CNT" size="4" class="input_ReadOnly" readonly>&nbsp;��
					</td>
				</tr>
                <tr>
                    <td align="center" class="creamBold">�۾���Ȳ</td>
                    <td  class="padding2423" colspan="2">
                        <input id="txtPRO_STS_MSG" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>
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

	<input type="hidden" id="hidGBN_CD_SHR"    value="1">
	<input type="hidden" id="hidJOBDPT_CD_SHR" value="1">
	<input type="hidden" id="hidTOE_CD_SHR"    value="1">
	<input type="hidden" id="hidREC_CD_SHR"    value="1">
	<input type="hidden" id="hidLAN_CD_SHR"    value="1">
	</form>
	<!-- form �� -->

</body>
</html>