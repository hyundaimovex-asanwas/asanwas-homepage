	<!--*************************************************************************
	* @source      : adva010.jsp												*
	* @description : �系���𳻿��Է� PAGE 										    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/27            ä����          	        �����ۼ�									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�系���𳻿��Է�(adva010)</title>
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

		var today = getToday();
		var btnList = 'TTTTTFTT';

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
			var DPT_CD_SHR  = document.getElementById("txtDPT_CD_SHR").value;
			var END_YN_SHR  = document.getElementById("cmbEND_YN_SHR").value;

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

			dsT_EV_ADVTBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&END_YN_SHR="+END_YN_SHR;
			dsT_EV_ADVTBOOK.reset();
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
			trT_EV_ADVTBOOK.KeyValue = "tr01(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
			trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=SAV";
			trT_EV_ADVTBOOK.post();
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
            if (dsT_EV_ADVTBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EV_ADVTBOOK.GridToExcel("�系���𳻿��Է�", '', 225)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_EV_ADVTBOOK.CountColumn == 0) {
				dsT_EV_ADVTBOOK.setDataHeader("ORD_NO:STRING, DPT_CD:STRING, DPT_NM:STRING, STR_YMD:STRING, END_YMD:STRING, FROM_JOB_CD:STRING, TO_JOB_CD:STRING, REMARK:STRING    ,FIELD_DIS:STRING   ,JOB_DIS:STRING ,CONDITION_DIS:STRING   ,AREA_DIS:STRING");
			}

			dsT_EV_ADVTBOOK.AddRow();

			fnc_EnableElementAll(oAllElementList)

			document.form1.cmbFROM_JOB_CD.selectedIndex      = 0;
			document.form1.cmbTO_JOB_CD.selectedIndex      = 0;
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
	        if (dsT_EV_ADVTBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "���� �系���� �׸��� �����Ͻðڽ��ϱ�?\n"+
                             "������ ���κ� ��û�׸� ���ÿ� �����˴ϴ�.\n\n";
            	tmpMSG += "������ȣ  = "+dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "ORD_NO")+"\n";
            	tmpMSG += "����μ�  = "+dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "DPT_NM")+"\n";

	            if( confirm(tmpMSG) ){
					var ORD_NO = dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "ORD_NO");
					var DPT_CD = dsT_EV_ADVTBOOK.nameValue(dsT_EV_ADVTBOOK.RowPosition, "DPT_CD");

					dsT_EV_ADVTBOOK.DeleteRow(dsT_EV_ADVTBOOK.RowPosition);

					// �Ķ���� �߰�
					trT_EV_ADVTBOOK.Parameters = "ORD_NO="+ORD_NO+",DPT_CD="+DPT_CD;

					trT_EV_ADVTBOOK.KeyValue = "tr02(I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)";
					trT_EV_ADVTBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.adv.a.adva010.cmd.ADVA010CMD&S_MODE=DEL";
					trT_EV_ADVTBOOK.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			for(var i=2; i<=3; i++){
  				document.form1.elements[i].value = "";
  			}

  			disableInput();
	        document.getElementById("resultMessage").innerText = ' ';

			// �޺��ڽ� �⺻ ����
			document.form1.cmbFROM_JOB_CD.selectedIndex      = 0;
			document.form1.cmbTO_JOB_CD.selectedIndex      = 0;
			document.form1.cmbEND_YN_SHR.selectedIndex  = 0;

        	dsT_EV_ADVTBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_EV_ADVTBOOK.IsUpdated)  {
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
         	if ( !dsT_EV_ADVTBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.getElementById("txtSTR_YMD_SHR").value = getToday().substring(0,8)+"01";
			document.getElementById("txtEND_YMD_SHR").value = getToday();

            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFROM_JOB_CD").add(oOption);
			}

			// ���� ���� �˻� �޺��ڽ�2 ����
			for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE")+" "+dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbTO_JOB_CD").add(oOption);
			}


			cfStyleGrid(form1.grdT_EV_ADVTBOOK,15,"false","false");      // Grid Style ����
			disableInput();
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

        //�Է��ʵ�� ����
        var oElementList    = new Array("txtSTR_YMD"
                                       ,"txtEND_YMD"
                                       ,"imgSTR_YMD"
                                       ,"imgEND_YMD"
                                       ,"cmbFROM_JOB_CD"
                                       ,"cmbTO_JOB_CD"
                                       ,"txtFIELD_DIS"
                                       ,"txtJOB_DIS"
                                       ,"txtREMARK"
                                       ,"txtCONDITION_DIS"
                                       ,"txtAREA_DIS");

        var oAllElementList = new Array("txtSTR_YMD"
                                       ,"txtEND_YMD"
                                       ,"imgSTR_YMD"
                                       ,"imgEND_YMD"
                                       ,"imgDPT_CD"
                                       ,"txtDPT_CD"
                                       ,"cmbFROM_JOB_CD"
                                       ,"cmbTO_JOB_CD"
                                       ,"txtFIELD_DIS"
                                       ,"txtJOB_DIS"
                                       ,"txtREMARK"
                                       ,"txtCONDITION_DIS"
                                       ,"txtAREA_DIS");

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	fnc_EnableElementAll(oElementList);

  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	fnc_DisableElementAll(oAllElementList);
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
         * �����������ڿ��� ��Ŀ�� ������ �������ڿ� ��  	 *
         ********************************************/
		function cfCheckDateTermADVA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�����������ڰ� �����������ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
				if( cfDateDiff(getToday().replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�������ڰ� �����������ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
			}
		}

		/********************************************
         * �������� ���ο� ���� �ʵ� Ȱ��ȭ ó�� 	   		*
         ********************************************/
		function checkAdvtStatus(row){
			var status = dsT_EV_ADVTBOOK.NameValue(row, "END_YN");
			if( status == "T" ){  // ������
				enableInput();
			}else{                // ��������
				disableInput();
			}
		}

		/********************************************
         * ������ ���� �ش��ϴ� ��û�� �����ȸ(popup-adva030.jsp)*
         ********************************************/
		function fnc_viewList(){
			// ��û�� ��
			var ADV_CNT = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"ADV_CNT");

			if (dsT_EV_ADVTBOOK.CountRow < 1) {
				alert("��ȸ�� ��û���� �����ϴ�.");
				return;
			}
			if( ADV_CNT == "0"){
				alert("��ȸ�� ��û�ڰ� �����ϴ�.");
				return;
			}

			var ORD_NO = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"ORD_NO"); // ������ȣ
			var DPT_CD = dsT_EV_ADVTBOOK.NameValue(dsT_EV_ADVTBOOK.RowPosition,"DPT_CD"); // �Ҽ�

			var url = "/hr/adv/adva030.jsp?&ORD_NO="+ORD_NO+"&DPT_CD="+DPT_CD;
			window.showModalDialog(url, new Object(), "dialogWidth:870px; dialogHeight:480px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			//fnc_SearchList();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_ADVTBOOK)			   |
    | 3. ���Ǵ� Table List(T_EV_ADVTBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_ADVTBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_ADVTBOOK)		       |
    | 3. ���Ǵ� Table List(T_EV_ADVTBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_EV_ADVTBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK,I:dsT_EV_ADVTBOOK=dsT_EV_ADVTBOOK)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->

    <!-- ���� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="TA2"/>
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
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_ADVTBOOK.CountRow);

        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


	<Script For=dsT_TACCCOD_BK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_EV_ADVTBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();

    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_EV_ADVTBOOK event="OnFail()">
        alert(trT_EV_ADVTBOOK.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EV_ADVTBOOK event=CanRowPosChange(row)>
		if ( dsT_EV_ADVTBOOK.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','STR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			document.getElementById("txtSTR_YMD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"END_YMD") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','END_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			document.getElementById("txtEND_YMD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"DPT_CD") == "" ) {
			alert("[ ����μ� ]�� �ʼ� �Է»����Դϴ�");
			document.getElementById("txtDPT_CD").focus();
			return false;
		}
		if ( dsT_EV_ADVTBOOK.NameValue(row,"DPT_NM") == "" ) {
			alert("[ " + grdT_EV_ADVTBOOK.GetHdrDispName('-3','DPT_CD') + " ]�� ���� �߸��Ǿ����ϴ�. Ȯ���� �ּ���.");
			return false;
		}

	</script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
	<script language="javascript"  for=dsT_EV_ADVTBOOK event=OnRowPosChanged(row)>
		checkAdvtStatus(row);
        if (document.getElementById("txtADV_CNT").value == "0") {
            fnc_HiddenElement("imgListView");
        }
        else{
            fnc_ShowElement("imgListView");
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

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�系���𳻿��Է�</td>
					<td align="right" class="navigator">HOME/�λ���/�系����/<font color="#000000">�系���𳻿��Է�</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
							<col width="70"></col>
							<col width="230"></col>
							<col width="70"></col>
							<col width="170"></col>
							<col width="70"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�����Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','60','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','170','110');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td class="searchState" align="right">����μ�</td>
							<td class="padding2423" align="left">
								<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
								<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�Ҽ�','DEPT')">
								</a>
							</td>
							<td class="searchState" align="right">���Ῡ��</td>
							<td class="padding2423" align="left">
								<select id="cmbEND_YN_SHR" style="width:100" onChange="fnc_SearchList()">
									<option value="0">��ü</option>
									<option value="1">����</option>
									<option value="2">����</option>
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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="75"></col>
			<col width="165"></col>
			<col width="75"></col>
			<col width="165"></col>
			<col width="75"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">�����Ⱓ</td>
			<td class="padding2423" colspan="3">
				<input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','58','152');"></a>
				 ~
				<input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermADVA010('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','168','152');"></a>
			</td>

            <td align="center" class="creamBold">�����ڼ�</td>
            <td class="padding2423">
                <input id="txtADV_CNT" size="6" class="input_ReadOnly" readonly">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgListView','','/images/button/btn_ListViewOver.gif',1)"><img src="/images/button/btn_ListViewOn.gif" name="imgListView" width="80" height="20" border="0" align="absmiddle" onClick="fnc_viewList();"></a>
            </td>

		</tr>
		<tr>
            <td align="center" class="creamBold">������ȣ</td>
            <td class="padding2423" align="left"><input id="txtORD_NO" size="15" class="input_ReadOnly" readonly></td>

            <td align="center" class="creamBold">����μ�</td>
            <td class="padding2423">
                <input id="txtDPT_CD" size="3" maxlength="2" onChange="fnc_GetCommNm('A4', 'txtDPT_CD','txtDPT_NM')">
                <input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD','','/images/button/btn_HelpOver.gif',1)">
                    <img src="/images/button/btn_HelpOn.gif" name="imgDPT_CD" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD','txtDPT_NM','�Ҽ�','DEPT')">
                </a>
            </td>
			<td align="center" class="creamBold">�������</td>
			<td class="padding2423">
				<select id="cmbFROM_JOB_CD" style="width:45%">
				<option value=""></option>
				</select>
				~
				<select id="cmbTO_JOB_CD" style="width:45%">
				<option value=""></option>
				</select>
			</td>
		</tr>
        <tr>
            <td align="center" class="creamBold">�����о�</td>
            <td class="padding2423"><input id="txtFIELD_DIS" style="22" maxLength="10"></td>
            <td align="center" class="creamBold">�ֿ����</td>
            <td class="padding2423"><input id="txtJOB_DIS" size="22" maxLength="10"></td>
            <td align="center" class="creamBold">�ڰݿ��</td>
            <td class="padding2423"><input id="txtREMARK" size="22" maxLength="10"></td>
        </tr>
        <tr>
            <td align="center" class="creamBold">����ڰ�</td>
            <td class="padding2423"><input id="txtCONDITION_DIS" size="22" maxLength="10"></td>
            <td align="center" class="creamBold">�ٹ���</td>
            <td class="padding2423" colspan="3"><input id="txtAREA_DIS" size="22" maxLength="10"></td>
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
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
					<object id="grdT_EV_ADVTBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_EV_ADVTBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width="40"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="ORD_NO"		width="70"		name="������ȣ"			align="center"	Edit=none</C>
							<C> id="STR_YMD"	width="70"		name="����������"		align="center"	Edit=none</C>
							<C> id="END_YMD"	width="70"		name="����������"		align="center"	Edit=none</C>
							<C> id="DPT_NM"		width="110"		name="����μ�"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_NM"		width="130"		name="�������"			align="center"	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
							<C> id="FIELD_DIS"  width="140"		name="�����о�"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="JOB_DIS"	width="140"		name="�ֿ����"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="REMARK"		width="140"		name="�ڰݿ��"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="CONDITION_DIS"	width="140"	name="����ڰ�"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="AREA_DIS"	width="100"		name="�ٹ���"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="ADV_CNT"	width="55"		name="�����ڼ�"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="END_YN"		width="60"		name="���࿩��"			align="center"	Edit=none	value={decode(END_YN, "T", "������", "����")}</C>
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
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_EV_ADVTBOOK ���� ���̺� -->
	<object id="bndT_EV_ADVTBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_ADVTBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=ORD_NO			Ctrl=txtORD_NO			Param=value</C>
			<C>Col=DPT_CD			Ctrl=txtDPT_CD			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=STR_YMD			Ctrl=txtSTR_YMD			Param=value</C>
			<C>Col=END_YMD			Ctrl=txtEND_YMD			Param=value</C>
			<C>Col=FROM_JOB_CD	    Ctrl=cmbFROM_JOB_CD		Param=value</C>
			<C>Col=TO_JOB_CD	    Ctrl=cmbTO_JOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=cmbJOB_CD			Param=value</C>
            <C>Col=FIELD_DIS        Ctrl=txtFIELD_DIS       Param=value</C>
            <C>Col=JOB_DIS          Ctrl=txtJOB_DIS         Param=value</C>
            <C>Col=REMARK           Ctrl=txtREMARK          Param=value</C>
            <C>Col=CONDITION_DIS    Ctrl=txtCONDITION_DIS   Param=value</C>
            <C>Col=AREA_DIS         Ctrl=txtAREA_DIS        Param=value</C>
			<C>Col=ADV_CNT			Ctrl=txtADV_CNT			Param=value</C>
		">
	</object>