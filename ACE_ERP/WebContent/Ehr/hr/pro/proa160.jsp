 	<!--*************************************************************************
	* @source      : proa160.jsp												*
	* @description : �������������ó�� PAGE									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/04/18	  ���м�	    �����ۼ�									*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>����� ��������� ó��(proa160)</title>
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
    //��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFTTFFFT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var ENO_NO_SHR = document.form1.txtENO_NO_SHR.value;
			var PMT_YY_SHR = document.form1.txtPMT_YY_SHR.value;

			if( PMT_YY_SHR == "" ){
				alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
				return;
			}

			dsT_PM_PROMOTION.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa160.cmd.PROA160CMD&S_MODE=SHR&ENO_NO_SHR="+ENO_NO_SHR+"&PMT_YY_SHR="+PMT_YY_SHR;
			dsT_PM_PROMOTION.reset();
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
			trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
			trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa160.cmd.PROA160CMD&S_MODE=SAV";
			trT_PM_PROMOTION.post();
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
  			document.getElementById("resultMessage").innerText = ' ';
//  			document.form1.txtCEN_ENO.value = "";
//  			document.form1.txtCEN_ENM.value = "";
//  			document.form1.txtCEN_CNT.value = "";
  			document.form1.txtPMT_YY_SHR.value = next_yy;
  			disableInput();

        	dsT_PM_RECOMMAND.ClearData();
        	dsT_PM_PROMOTION.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROMOTION.IsUpdated)  {
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
         	if (!dsT_PM_PROMOTION.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

	        cfStyleGrid(form1.grdT_PM_PROMOTION,12,"true","false");
	        disableInput();
	        document.form1.txtPMT_YY_SHR.value = next_yy;
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
         * ���հ� ���	                       			*
         ********************************************/
        function setTotal() {
        	var GOG_HTT = document.form1.txtGOG_HTT.value;
        	var EDU_SCR = document.form1.txtEDU_SCR.value;
        	var GUN_GTT = document.form1.txtGUN_GTT.value;
        	var SAN_SCR = document.form1.txtSAN_SCR.value;
        	//var EXM_TIC = document.form1.txtEXM_TIC.value;
        	var CEN_SCR = document.form1.txtCEN_SCR.value;
        	var GOG_TOT = document.form1.txtGOG_TOT.value;

        	if(GOG_HTT=="") GOG_HTT = "0";
        	if(EDU_SCR=="") EDU_SCR = "0";
        	if(GUN_GTT=="") GUN_GTT = "0";
        	if(SAN_SCR=="") SAN_SCR = "0";
        	//if(EXM_TIC=="") EXM_TIC = "0";
        	if(CEN_SCR=="") CEN_SCR = "0";
        	if(GOG_TOT=="") GOG_TOT = "0";

        	// && EXM_TIC != ""                   +EXM_TIC+"+"
        	if(GOG_HTT != "" && EDU_SCR != "" && GUN_GTT != "" && SAN_SCR != "" && CEN_SCR != "" && GOG_TOT != ""){
	        	document.form1.txtSPC_TOT.value = eval(GOG_HTT+"+"+EDU_SCR+"+"+GUN_GTT+"+"+SAN_SCR+"+"+CEN_SCR+"+"+GOG_TOT);
        	}
        }

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	for(var i=18; i<42; i++){
//  		 		if( i==45 || i==46 ||i==57 || i==58 || i==59 || i==60 ) continue;   // ����(40), ����(41), ��õ�� ���(51), ��õ�μ���(52), ��õ����(53), ����(54)
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.form1.rdoEST_CD[0].disabled  = false;   // �������� radioButton
  			document.form1.rdoEST_CD[1].disabled  = false;   // �������� radioButton
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	for(var i=14; i<42; i++){
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.form1.rdoEST_CD[0].disabled  = true;   // �������� radioButton
  			document.form1.rdoEST_CD[1].disabled  = true;   // �������� radioButton
  		}

  		/********************************************
         * �׸��� Ŭ���� ������ư ���� 	        		*
         ********************************************/
  		function checkPmtStatus(row, colid){
  			var EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
  			if(EST_CD == "Y" || EST_CD == "T"){
  				document.form1.rdoEST_CD[0].checked = true;
  			} else{
  				document.form1.rdoEST_CD[1].checked = true;
  			}
  		}

  		/********************************************
         * �׸��� Ŭ���� ó���ϷῩ�� Ȯ�� �Է¿��� ���� 	*
         ********************************************/
  		function checkPmtEndStatus(row, colid){
  			var EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
  			if(EST_CD == "T" || EST_CD == "F"){
  				disableInput();
  			} else{
  				enableInput();
  			}
  		}


  		/********************************************
         * �������� üũ�ڽ�(on Grid) üũ���ΰ���       		*
         ********************************************/
  		function fnc_chgEST_CD(){
  			if( document.form1.rdoEST_CD[0].checked ){
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'Y';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'T';
  			}else{
	  			dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD') = 'N';
  				dsT_PM_PROMOTION.NameValue(dsT_PM_PROMOTION.RowPosition,'EST_CD_CK') = 'F';
  			}
  		}

  		/********************************************
         * ���� �۾� �Ϸ� 							       		*
         ********************************************/
        function fnc_SaveEnd(row, colid) {
//alert("1");

        	var RowCnt = dsT_PM_PROMOTION.CountRow;
//alert(RowCnt);
			if(RowCnt>0) {
				var EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
				var RowNo = dsT_PM_PROMOTION.RowPosition;

				if(EST_CD == "Y" || EST_CD == "N") {
//					if ( !fnc_SaveItemCheck() ) {
//						return;
//					}
//alert("save");
//alert(RowNo);
//alert(EST_CD);
					// save
  			if(EST_CD == "Y" ){
	  			dsT_PM_PROMOTION.NameValue(RowNo,"EST_CD") = "T";
  			}else{
	  			dsT_PM_PROMOTION.NameValue(RowNo,"EST_CD") = "F";
  			}

//alert(dsT_PM_PROMOTION.NameValue(RowNo,"EST_CD"));
//      		      	dsT_PM_PROMOTION.UseChangeInfo = "false";
					trT_PM_PROMOTION.KeyValue = "tr01(I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)";
					trT_PM_PROMOTION.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa160.cmd.PROA160CMD&S_MODE=SAV_01";
					trT_PM_PROMOTION.post();

				} else if(EST_CD == "T" || EST_CD == "F") {
					alert("ó�� �Ϸ�� �������Դϴ�.")
				}
			}
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PROMOTION)		 	   |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PROMOTION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_RECOMMAND)		 	   |
    | 3. ���Ǵ� Table List(T_PM_RECOMMAND) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_RECOMMAND" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_PROMOTION)			   |
    | 3. ���Ǵ� Table List(T_PM_PROMOTION)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_PROMOTION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_PROMOTION=dsT_PM_PROMOTION,I:dsT_PM_PROMOTION=dsT_PM_PROMOTION)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PROMOTION.CountRow);
//			EST_CD = dsT_PM_PROMOTION.NameValue(row, "EST_CD");
//			alert(EST_CD);
//			enableInput();
			checkPmtStatus(1, "EST_CD");
			checkPmtEndStatus(1, "EST_CD")
//			fnc_SearchRecommander(1);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_RECOMMAND Event="OnLoadCompleted(iCount)">
		//��� ����Ʈ ����
		for(var i=0; i<6; i++){
  			if( document.getElementById("cmbCEN_LIST").hasChildNodes() ){
	  			document.getElementById("cmbCEN_LIST").remove(0);
  			}
  		}

		if (iCount == 0)    {
			// ������ �ƴ�(�߰� ��õ�� ����)
			document.form1.cmbCEN_LIST.disabled = true;
		} else {
			for( var j = 1; j <= dsT_PM_RECOMMAND.CountRow; j++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = j;
                oOption.text  = "��õ��-"+j;
				document.getElementById("cmbCEN_LIST").add(oOption);
			}
		document.form1.cmbCEN_LIST.disabled = false;
        fnc_viewCen_Scr();

        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROMOTION Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROMOTION event="OnFail()">
        alert(trT_PM_PROMOTION.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Grid Ŭ���� �������ο� ���� ������ư ����				   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_PM_PROMOTION event=OnClick(row,colid)>
		checkPmtStatus(row, colid);
		checkPmtEndStatus(row, colid);
//		fnc_SearchRecommander(row);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����� ��������� ó��</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">����� ��������� ó��</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
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
							<col width="100"></col>
							<col width="70"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="right" class="searchState">�����⵵</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPMT_YY_SHR" name="txtPMT_YY_SHR" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YY_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YY_SHR" name="imgPMT_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YY_SHR','','102','108');"></a>
							</td>
							<td align="right" class="searchState">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8"  maxlength="10" style="ime-mode:disabled" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck();">
								<input id="txtENO_NM_SHR" size="8" style="text-align:center" class="input_ReadOnly" readonly>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
									<img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR')">
								</a>
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
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<tr>
					<td class="paddingTop8" colspan="10"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> �λ�����</td>
				</tr>
				<tr>
					<td>
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="90"></col>
							<col width="100"></col>
							<col width="90"></col>
							<col width="100"></col>
							<col width="90"></col>
							<col width="100"></col>
							<col width="90"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">�ٷα��б���</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidOCC_CD">
								<input id="txtOCC_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidJOB_CD">
								<input id="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�Ի�����</td>
							<td class="padding2423" align="left">
								<input id="txtHIR_YMD" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input id="txtRET_YMD" size="14" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">�ι��ڵ�</td>
							<td class="padding2423" align="left">
								<input id="txtHEAD_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�μ�</td>
							<td class="padding2423" align="left">
								<input type="hidden" id="hidDPT_CD">
								<input id="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�������</td>
							<td class="padding2423" align="left">
								<input id="txtBIR_YMD" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input id="txtJPR_YMD" size="14" class="input_ReadOnly" readonly>
							</td>
						</tr>
						<tr>
							<td align="center" class="creamBold">���������Ⱓ</td>
							<td class="padding2423" align="left">
								<input id="txtJPR_CON" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�б�</td>
							<td class="padding2423" align="left">
								<input id="txtSCH_NM" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">����</td>
							<td class="padding2423" align="left">
								<input id="txtMAJ_NM1" size="14" class="input_ReadOnly" readonly>
							</td>
							<td align="center" class="creamBold">�����⵵</td>
							<td class="padding2423" align="left">
								<input id="txtGUR_YY" size="14" class="input_ReadOnly" readonly>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td class="paddingTop8" colspan="10"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> �������</td>
				</tr>
				<tr>
					<td colspan="10">
					<table width="100%" border="1" cellspacing="2" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
					<tr>
						<td>
						<table align="center" width="98%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="80"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td><input id="txtGOG_YY5" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;:&nbsp;</td>
							<td><input id="txtGOG_Y51" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY4" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;:&nbsp;</td>
							<td><input id="txtGOG_Y41" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY3" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;:&nbsp;</td>
							<td><input id="txtGOG_Y31" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY2" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;:&nbsp;</td>
							<td><input id="txtGOG_Y21" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td><input id="txtGOG_YY1" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();">&nbsp;:&nbsp;</td>
							<td><input id="txtGOG_Y11" size="7" maxLength="1" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y52" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y42" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y32" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y22" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y12" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y53" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y43" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y33" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y23" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
							<td>&nbsp;</td>
							<td><input id="txtGOG_Y13" size="7" maxLength="4" style="ime-mode:disabled" onKeypress="cfNumberCheck();"></td>
						</tr>
						</table>
						</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="10" class="paddingTop5">
					<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						<colgroup>
							<col width="100"></col>
							<col width="200"></col>
							<col width="100"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td align="center" class="creamBold">��������</td>
							<td class="padding2423" align="left">
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" checked style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">����
								<input type="radio" name="rdoEST_CD" id="rdoEST_CD" style="margin-bottom:-2px;border:0;background-color:#ffffff;" onClick="fnc_chgEST_CD()">�̽���
							</td>
							<td align="center" class="creamBold">���</td>
							<td class="padding2423" align="left" colspan="2"><input id="txtREMARK" size="20" maxLength="22"></td>
							<td align="center" class="creamBold">����ó��</td>
							<td class="padding2423" align="left"><img src="/images/button/btn_ConductOn.gif" name="Image3" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SaveEnd();"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','/images/button/btn_ConductOver.gif',1)">
							</td>
						</tr>
					</table>
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
					<object id="grdT_PM_PROMOTION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:280px;">
						<param name="DataID" value="dsT_PM_PROMOTION">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
							<C> id="PMT_GBN"	width=40	name="����"			align=center	Edit=none	 value={decode(PMT_GBN, 1, "����", 2, "Ư��")}</C>
							<C> id="OCC_NM"		width=50	name="�ٷα���"			align=center	Edit=none	 </C>
							<C> id="DPT_NM"		width=110	name="�μ�"			align=left		Edit=none	 LeftMargin="10"</C>
							<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none	 </C>
							<C> id="ENO_NO"		width=60	name="���"			align=center	Edit=none	 </C>
							<C> id="BIR_YMD"	width=80	name="�������"		align=center	Edit=none	 </C>
							<C> id="HIR_YMD"	width=80	name="�Ի���"			align=center	Edit=none	 </C>
							<C> id="JPR_CON"	width=60	name="����;�����Ⱓ"	align=center	Edit=none	 </C>
							<C> id="SCH_NM"	width=60	name="�б�"		align=center	Edit=none	 </C>
							<C> id="REMARK"		width=50	name="���"			align=center	Edit=none	 </C>
							<C> id="EXP_CD"		width=30	name="����"			align=center	Edit=none	 </C>
							<C> id="EST_CD"		width="50"	name="����;����"		align="center"	Edit=none	EditStyle=CheckBox	show="false"</C>
							<C> id="EST_CD_CK"		width="50"	name="����;����"		align="center"	Edit=none	EditStyle=CheckBox</C>
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
	<!-- T_PM_PROMOTION ���� ���̺� -->
	<object id="bndT_PM_PROMOTION" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PROMOTION">
		<Param Name="BindInfo", Value="
			<C>Col=ENO_NO		Ctrl=txtENO_NO_SHR	Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM_SHR	Param=value</C>
			<C>Col=HEAD_NM		Ctrl=txtHEAD_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=OCC_NM		Ctrl=txtOCC_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD		Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=PR_SEQ		Ctrl=hidPR_SEQ		Param=value</C>

			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=HIRG_YMD		Ctrl=txtHIRG_YMD	Param=value</C>

			<C>Col=JPR_CON		Ctrl=txtJPR_CON	Param=value</C>
			<C>Col=SCH_NM		Ctrl=txtSCH_NM		Param=value</C>
			<C>Col=MAJ_NM1		Ctrl=txtMAJ_NM1	Param=value</C>
			<C>Col=GUR_YY		Ctrl=txtGUR_YY			Param=value</C>

			<C>Col=JPR_YMD		Ctrl=txtJPR_YMD		Param=value</C>
			<C>Col=GOG_YY5		Ctrl=txtGOG_YY5		Param=value</C>
			<C>Col=GOG_Y51		Ctrl=txtGOG_Y51		Param=value</C>
			<C>Col=GOG_Y52		Ctrl=txtGOG_Y52		Param=value</C>
			<C>Col=GOG_Y53		Ctrl=txtGOG_Y53		Param=value</C>
			<C>Col=GOG_YY4		Ctrl=txtGOG_YY4		Param=value</C>
			<C>Col=GOG_Y41		Ctrl=txtGOG_Y41		Param=value</C>
			<C>Col=GOG_Y42		Ctrl=txtGOG_Y42		Param=value</C>
			<C>Col=GOG_Y43		Ctrl=txtGOG_Y43		Param=value</C>

			<C>Col=GOG_YY3		Ctrl=txtGOG_YY3		Param=value</C>
			<C>Col=GOG_Y31		Ctrl=txtGOG_Y31		Param=value</C>
			<C>Col=GOG_Y32		Ctrl=txtGOG_Y32		Param=value</C>
			<C>Col=GOG_Y33		Ctrl=txtGOG_Y33		Param=value</C>
			<C>Col=GOG_YY2		Ctrl=txtGOG_YY2		Param=value</C>
			<C>Col=GOG_Y21		Ctrl=txtGOG_Y21		Param=value</C>
			<C>Col=GOG_Y22		Ctrl=txtGOG_Y22		Param=value</C>
			<C>Col=GOG_Y23		Ctrl=txtGOG_Y23		Param=value</C>
			<C>Col=GOG_YY1		Ctrl=txtGOG_YY1		Param=value</C>
			<C>Col=GOG_Y11		Ctrl=txtGOG_Y11		Param=value</C>
			<C>Col=GOG_Y12		Ctrl=txtGOG_Y12		Param=value</C>
			<C>Col=GOG_Y13		Ctrl=txtGOG_Y13		Param=value</C>
			<C>Col=GOG_CNT		Ctrl=txtGOG_CNT		Param=value</C>

			<C>Col=GOG_TOT		Ctrl=txtGOG_TOT		Param=value</C>
			<C>Col=GOG_GAV		Ctrl=txtGOG_GAV		Param=value</C>
			<C>Col=GOG_HTT		Ctrl=txtGOG_HTT		Param=value</C>
			<C>Col=GUN_GTB		Ctrl=txtGUN_GTB		Param=value</C>
			<C>Col=GUN_GTC		Ctrl=txtGUN_GTC		Param=value</C>
			<C>Col=GUN_GTT		Ctrl=txtGUN_GTT		Param=value</C>
			<C>Col=EDU_YY1		Ctrl=txtEDU_YY1		Param=value</C>
			<C>Col=EDU_KN1		Ctrl=txtEDU_KN1		Param=value</C>
			<C>Col=EDU_YY2		Ctrl=txtEDU_YY2		Param=value</C>
			<C>Col=EDU_KN2		Ctrl=txtEDU_KN2		Param=value</C>

			<C>Col=EDU_YY3		Ctrl=txtEDU_YY3		Param=value</C>
			<C>Col=EDU_KN3		Ctrl=txtEDU_KN3		Param=value</C>
			<C>Col=EDU_SCR		Ctrl=txtEDU_SCR		Param=value</C>
			<C>Col=SAN_YY1		Ctrl=txtSAN_YY1		Param=value</C>
			<C>Col=SAN_RM1		Ctrl=txtSAN_RM1		Param=value</C>
			<C>Col=SAN_YY2		Ctrl=txtSAN_YY2		Param=value</C>
			<C>Col=SAN_RM2		Ctrl=txtSAN_RM2		Param=value</C>
			<C>Col=SAN_YY3		Ctrl=txtSAN_YY3		Param=value</C>
			<C>Col=SAN_RM3		Ctrl=txtSAN_RM3		Param=value</C>
			<C>Col=SAN_SCR		Ctrl=txtSAN_SCR		Param=value</C>

			<C>Col=CEN_SCR		Ctrl=txtCEN_SCR		Param=value</C>
			<C>Col=EXM_SC1		Ctrl=txtEXM_SC1		Param=value</C>
			<C>Col=EXM_SC2		Ctrl=txtEXM_SC2		Param=value</C>
			<C>Col=EXM_TIC		Ctrl=txtEXM_TIC		Param=value</C>
			<C>Col=SPC_TOT		Ctrl=txtSPC_TOT		Param=value</C>
			<C>Col=EXP_CD		Ctrl=txtEXP_CD		Param=value</C>
			<C>Col=EST_CD		Ctrl=txtEST_CD		Param=value</C>
			<C>Col=REMARK		Ctrl=txtREMARK		Param=value</C>

			<C>Col=EXM_CMP		Ctrl=txtEXM_CMP		Param=value</C>

		">
	</object>