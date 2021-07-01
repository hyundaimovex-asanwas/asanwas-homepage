	<!--*************************************************************************
	* @source      : guna011.jsp												*
	* @description : ���κ����µ�ϸ�� PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2009/10/16            ������                      ���κ� ���½�û�����ۼ�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
	String eno_nm = box.getString("SESSION_ENONM");         //ǰ���ڻ��
	String dep_cd = box.getString("SESSION_DPTCD");         //ǰ���ڻ��

%>


<html>
<head>
	<title>���½�û(guna011)</title>
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

			//�����µ�� ���� ��ȸ
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var GUN_CD_SHR  = document.getElementById("cmbGUN_CD_SHR").value;
			//var GUN_STS_SHR = document.getElementById("cmbGUN_STS_SHR").value;
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;


			//����� ������ ��ȸ����.
			if(ENO_NO_SHR.trim().length == 0){
				alert("����� �Է��ϼ���.");
				document.getElementById("txtENO_NO_SHR").focus();
				return false;
			}

			//�������ڰ� ������ ��ȸ����.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� ������ ��ȸ����.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �������ں��� ũ�� �ʵȴ�.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("�������ڰ� �������ں��� �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}
			trT_DI_DILIGENCE.KeyValue = "tr05(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)";
			trT_DI_DILIGENCE.action = "/servlet/GauceChannelSVL?cmd=hr.gun.a.guna012.cmd.GUNA012CMD"
                                   + "&S_MODE=SHR_LST"
                                   + "&ENO_NO_SHR="+ENO_NO_SHR
                                   + "&STR_YMD_SHR="+STR_YMD_SHR
                                   + "&END_YMD_SHR="+END_YMD_SHR
                                   + "&GUN_CD_SHR="+GUN_CD_SHR
                                  // + "&GUN_STS_SHR="+GUN_STS_SHR
                                   + "&EMPL_DPT_CD="+EMPL_DPT_CD;
			trT_DI_DILIGENCE.post();
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
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
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
        }



		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_DI_DILIGENCE.ClearData();
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
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        	        dsT_DI_DILIGENCE.SetDataHeader(
								"DPT_CD:STRING(10),"+			// ��������
	        					"REG_NO:STRING(10),"+			// ��Ϲ�ȣ
	                            "DPT_NM:STRING(20),"+			// �Ҽ�
								"JOB_NM:STRING(20),"+			// ����
								"ENO_NO:STRING(10),"+			// ���
								"ENO_NM:STRING(10),"+			// ����
								"CNT:STRING(10),"			// ���࿩��
								);

			document.getElementById("txtENO_NO_SHR").value="<%=eno_no%>";
			document.getElementById("txtENO_NM_SHR").value="<%=eno_nm%>";

			cfStyleGrid2(form1.grdT_DI_DILIGENCE,0,"false","false");      // Grid Style ����
            //cfStyleGrid(form1.grdT_DI_DILIGENCE,15,"true","false");      // Grid Style ����

        	// ����(�Է�)
        	var h4_cd = "";
        	// ����(��ȸ)
			for( var i = 1; i <= dsT_CM_COMMON_H4.CountRow; i++ ) {

                h4_cd = dsT_CM_COMMON_H4.NameValue(i,"CODE")
                /* 2009.09.16 ������ ����*/
                if(h4_cd == "A" || h4_cd == "B" || h4_cd == "C" || h4_cd == "D" || h4_cd == "Y" ||
                   h4_cd == "W" || h4_cd == "M" || h4_cd == "N" || h4_cd == "O" || h4_cd == "X" || h4_cd == "9"){
                    continue;
                }

				oOption       = document.createElement("OPTION");
           	 	oOption.value = dsT_CM_COMMON_H4.NameValue(i,"CODE");
        	    oOption.text  = dsT_CM_COMMON_H4.NameValue(i,"CODE_NAME");
				document.getElementById("cmbGUN_CD_SHR").add(oOption);
			}

			document.getElementById("txtSTR_YMD_SHR").value = getToday();
			document.getElementById("txtEND_YMD_SHR").value = next_month(getToday())+"-"+getToday().substring(8);


<%
    //�����ʹ� ���μ� ����
    if(box.getString("SESSION_DIL_AUTHO").equals("M")) {
%>
	    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");


<%//A �� �ڱ�μ��� ����
	}else if(box.getString("SESSION_DIL_AUTHO").equals("A")) {
%>
	    document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
	    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");
<%
    }else{
%>
            document.getElementById('hidEMPL_DPT_CD').value = "<%=box.getString("SESSION_DPTCD") %>";
            fnc_ChangeStateElement(false, "ImgEnoNoSHR");
            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
            fnc_ChangeStateElement(false, "txtENO_NM_SHR");


<%
	}
%>
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
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNmSHR() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Application() {
                //���õ� ROW�� dsT_DI_CHANGE_CP �����Ͽ� guna061�� dsT_DI_CHANGE_CP �Ѱ��ش�.
    			cfCopyDataSet(dsT_DI_DILIGENCE, dsT_DI_DILIGENCE_CP, "copyHeader=yes,rowFrom=0,rowCnt=0");
    			var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
    			var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
				var param = "str_ymd_shr="+str_ymd_shr+"&end_ymd_shr="+end_ymd_shr;
    			window.showModalDialog("/hr/gun/guna012.jsp?MODE=INS&"+param, dsT_DI_DILIGENCE_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

                fnc_SearchList();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_DILIGENCE)			 	   |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_DILIGENCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ī�ǿ� DataSet                             |
    | 2. �̸� : dsT_DI_DILIGENCE_CP                  |
    | 3. Table List : T_DI_DILIGENCE                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_DILIGENCE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_DILIGENCE)		       |
    | 3. ���Ǵ� Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_DILIGENCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_DILIGENCE=dsT_DI_DILIGENCE)">
	</Object>


    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SG"/>
       <jsp:param name="CODE_GUBUN"    value="SG"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_SF"/>
       <jsp:param name="CODE_GUBUN"    value="SF"/>
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
	<Script For=dsT_DI_DILIGENCE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_DILIGENCE.CountRow);
        }
		/*
		for(var i=1; i<=dsT_DI_DILIGENCE.countrow; i++){
			if(dsT_DI_DILIGENCE.NameValue(i,"APP_YN_NM") == "�ΰ�"){
				grdT_DI_DILIGENCE.ColumnProp('APP_YN_NM', 'BgColor') = "Red";
			}
		}
		*/
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


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_DILIGENCE event="OnDblClick(row,colid)">
		if(row < 1) {
			return;
		} else {

			//���õ� ROW�� dsT_DI_CHANGE_CP �����Ͽ� guna061�� dsT_DI_CHANGE_CP �Ѱ��ش�.
			cfCopyDataSet(dsT_DI_DILIGENCE, dsT_DI_DILIGENCE_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");
			var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
			var param = "str_ymd_shr="+str_ymd_shr+"&end_ymd_shr="+end_ymd_shr;
			window.showModalDialog("/hr/gun/guna012.jsp?MODE=READ&"+param, dsT_DI_DILIGENCE_CP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

			fnc_SearchList();

		}
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
    <input type="hidden" id="hidEMPL_DPT_CD">
	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���½�û</td>
					<td align="right" class="navigator">HOME/��������/��������/<font color="#000000">���½�û</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApplication','','/images/button/btn_ApplicationOver.gif',1)"><img src="/images/button/btn_ApplicationOn.gif" name="imgApplication" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Application()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" ��ellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0"  cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="30"></col>
							<col width="220"></col>
							<col width="30"></col>
							<col width="170"></col>
							<col width="30"></col>
							<col width="120"></col>
							<col width="60"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>

							<td class="searchState" align="right">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="6" maxlength= "6"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
							</td>

							<td class="searchState" align="right">����</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_CD_SHR" style="width='100';" onChange="fnc_SearchList()">
									<option value="0">���</option>
								</select>
							</td>
						<!--
							<td class="searchState" align="right">���Ῡ��</td>
							<td class="padding2423" align="left">
								<select id="cmbGUN_STS_SHR"  style="width='70';" onChange="fnc_SearchList()">
									<option value="0">���</option>
									<option value="1">������</option>
									<option value="2">������</option>
									<option value="3">�Ϸ�</option>
								</select>
							</td>
						-->
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
					<object id="grdT_DI_DILIGENCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_DI_DILIGENCE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=29	name="NO"			align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=75	name="��Ϲ�ȣ"		align=center	Edit=none    </C>
							<C> id="DPT_NM"		width=100   name="�Ҽ�"			align=center	Edit=none    </C>
							<C> id="JOB_NM"		width=50	name="����"			align=center	Edit=none    </C>
                            <C> id="ENO_NO"     width=70    name="���"         align=center    Edit=none    </C>
                            <C> id="ENO_NM"     width=70    name="����"         align=center    Edit=none    </C>
                            <C> id="CNT"        width=70    name="����"         align=center    Edit=none    </C>
							<C> id="APP_YN_NM"  width=200   name="���翩��"     align=center    Edit=none  BgColor={Decode(APP_YN_NM,"�ΰ�","#FEB293")}  </C>
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

	<input type="hidden" id="txtDPT_CD">
	<input type="hidden" id="txtJOB_CD">
	</form>
	<!-- form �� -->
</body>
</html>
