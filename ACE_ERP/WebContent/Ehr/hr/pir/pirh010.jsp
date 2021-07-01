	<!--*************************************************************************
	* @source      : pirh010.jsp												*
	* @description : ���ɺ��ο���Ȳ PAGE 										*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/04            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>���ɺ��ο���Ȳ(pirh010)</title>
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

		var btnList = 'TFFTTTFT';
		var today = getToday();

		// default grid ID & NAME
		var arrId   = new Array("AGE_01","AGE_02","AGE_03","AGE_04","AGE_05","AGE_06","AGE_07","AGE_08","AGE_09","AGE_10");

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	// �������� �Է� �ʼ�
        	if( document.form1.txtBIR_YMD_SHR.value=="" ){
        		alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
        		return;
        	}

        	for( var i=5; i<16; i++){
        		if(i==11){continue;}  // �Է��ʵ� �ƴ�
	   	    	// �����ʵ��� �߰��� �����ʵ尡 �����ϴ��� üũ
	   	    	if(document.form1.elements[i].value == ""){
			       	for( var j=i+1; j<16; j++){
		        		if(j==11){continue;} // �Է��ʵ� �ƴ�
		    	   		if(document.form1.elements[j].value != ""){
		       				document.form1.elements[j-1].focus();
		       				alert("��ȸ�ϰ��� �ϴ� ������ �ùٸ��� �Է��Ͻʽÿ�.\n(*�����ʵ尡 �����մϴ�.)");
	        				return;
		       			}
		       		}
        		}
        	}

		   	// �����ʵ��� �߰����� ���Ŀ� ���� ���麸�� ū�� üũ
        	for( var k=5; k<15; k++){
        		var a = k;
        		var b = k+1;
        		if(k==10){	b = k+2; } // �����ʵ尪�� ��
        		if(j==11){continue;} // �Է��ʵ� �ƴ�
		       	if( parseInt(document.form1.elements[a].value) >= parseInt(document.form1.elements[b].value) ){
		       		document.form1.elements[b].focus();
		       		alert("��ȸ�ϰ��� �ϴ� ������ �ùٸ��� �Է��Ͻʽÿ�.\n(*���� ������ �ùٸ��� �ʽ��ϴ�.)");
	       			return;
		       	}
        	}
        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "JOB";  // ������
        	}
        	if( document.form1.rdoGBN_SHR[1].checked ){
        		FLAG_SHR = "BCT";  // ��ŵ�
        	}
        	if( document.form1.rdoGBN_SHR[2].checked ){
        		FLAG_SHR = "ADR";  // ��������
        	}

        	// ���� ���ǿ� �°� �׸��� Ÿ��Ʋ ����
			setGridTitle();

        	var AGE_SHR  = document.form1.txtAGE_SHR_01.value
        	              	+"|"+ document.form1.txtAGE_SHR_02.value
        					+"|"+ document.form1.txtAGE_SHR_03.value
							+"|"+ document.form1.txtAGE_SHR_04.value
							+"|"+ document.form1.txtAGE_SHR_05.value
							+"|"+ document.form1.txtAGE_SHR_06.value
							+"|"+ document.form1.txtAGE_SHR_07.value
							+"|"+ document.form1.txtAGE_SHR_08.value
							+"|"+ document.form1.txtAGE_SHR_09.value
							+"|"+ document.form1.txtAGE_SHR_10.value;

			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;


			trVI_T_CM_PERSON.action = "/servlet/GauceChannelSVL?cmd=hr.pir.h.pirh010.cmd.PIRH010CMD&S_MODE=SHR&BIR_YMD_SHR="+BIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&AGE_SHR="+AGE_SHR;
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
        	// �������� �Է� �ʼ�
        	if( document.form1.txtBIR_YMD_SHR.value=="" ){
        		alert("�������ڸ� �Է��Ͻʽÿ�. ��)"+today);
        		return;
        	}

        	for( var i=5; i<16; i++){
        		if(i==11){continue;}  // �Է��ʵ� �ƴ�
	   	    	// �����ʵ��� �߰��� �����ʵ尡 �����ϴ��� üũ
	   	    	if(document.form1.elements[i].value == ""){
			       	for( var j=i+1; j<16; j++){
		        		if(j==11){continue;} // �Է��ʵ� �ƴ�
		    	   		if(document.form1.elements[j].value != ""){
		       				document.form1.elements[j-1].focus();
		       				alert("��ȸ�ϰ��� �ϴ� ������ �ùٸ��� �Է��Ͻʽÿ�.\n(*�����ʵ尡 �����մϴ�.)");
	        				return;
		       			}
		       		}
        		}
        	}

		   	// �����ʵ��� �߰����� ���Ŀ� ���� ���麸�� ū�� üũ
        	for( var k=5; k<15; k++){
        		var a = k;
        		var b = k+1;
        		if(k==10){	b = k+2; } // �����ʵ尪�� ��
        		if(j==11){continue;} // �Է��ʵ� �ƴ�
		       	if( parseInt(document.form1.elements[a].value) >= parseInt(document.form1.elements[b].value) ){
		       		document.form1.elements[b].focus();
		       		alert("��ȸ�ϰ��� �ϴ� ������ �ùٸ��� �Է��Ͻʽÿ�.\n(*���� ������ �ùٸ��� �ʽ��ϴ�.)");
	       			return;
		       	}
        	}
        	var FLAG_SHR = "";
         	if( document.form1.rdoGBN_SHR[0].checked ){
        		FLAG_SHR = "JOB";  // ������
        	}
        	if( document.form1.rdoGBN_SHR[1].checked ){
        		FLAG_SHR = "BCT";  // ��ŵ�
        	}
        	if( document.form1.rdoGBN_SHR[2].checked ){
        		FLAG_SHR = "ADR";  // ��������
        	}

         	var AGE_SHR  = document.form1.txtAGE_SHR_01.value
        	              	+","+ document.form1.txtAGE_SHR_02.value
        					+","+ document.form1.txtAGE_SHR_03.value
							+","+ document.form1.txtAGE_SHR_04.value
							+","+ document.form1.txtAGE_SHR_05.value
							+","+ document.form1.txtAGE_SHR_06.value
							+","+ document.form1.txtAGE_SHR_07.value
							+","+ document.form1.txtAGE_SHR_08.value
							+","+ document.form1.txtAGE_SHR_09.value
							+","+ document.form1.txtAGE_SHR_10.value;

			var BIR_YMD_SHR = document.getElementById("txtBIR_YMD_SHR").value;
			var OCC_CD_SHR  = document.getElementById("cmbOCC_CD_SHR").value;
			var GBN_CD_SHR  = document.getElementById("cmbGBN_CD_SHR").value;

			var url = "pirh010_PV.jsp?BIR_YMD_SHR="+BIR_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&GBN_CD_SHR="+GBN_CD_SHR+"&FLAG_SHR="+FLAG_SHR+"&AGE_SHR="+AGE_SHR;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
            if (dsVI_T_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdVI_T_CM_PERSON.GridToExcel("���޺�,���ɺ��ο���Ȳ", '', 225)
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
        	// �ʱ�ȭ
        	document.form1.txtBIR_YMD_SHR.value  = "";
        	document.form1.cmbGBN_CD_SHR.selectedIndex  = 0;
        	//document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
        	document.form1.rdoGBN_SHR[0].checked = true;
        	document.getElementById("resultMessage").innerText = ' ';
        	document.form1.txtBIR_YMD_SHR.value = today;

        	dsVI_T_CM_PERSON.ClearData();
        	setDefaultAge();
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
			/*
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			*/
			document.form1.txtBIR_YMD_SHR.value = today;
			cfStyleGrid(form1.grdVI_T_CM_PERSON,0,"true","false");      // Grid Style ����

			setDefaultAge();
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
         * Default ���� ��ȸ�� �Է�                         			*
         ********************************************/
        function setDefaultAge(){
        	document.form1.txtAGE_SHR_01.value = "20";
        	document.form1.txtAGE_SHR_02.value = "21";
        	document.form1.txtAGE_SHR_03.value = "26";
        	document.form1.txtAGE_SHR_04.value = "31";
        	document.form1.txtAGE_SHR_05.value = "36";
        	document.form1.txtAGE_SHR_06.value = "41";
        	document.form1.txtAGE_SHR_07.value = "46";
        	document.form1.txtAGE_SHR_08.value = "51";
        	document.form1.txtAGE_SHR_09.value = "56";
        	document.form1.txtAGE_SHR_10.value = "61";

        	setGridTitle();
        }

		/********************************************
         * ���ǿ� ���� �׸��� Ÿ��Ʋ ����                   			*
         ********************************************/
        function setGridTitle(){
	        var arrVal = new Array("","","","","","","","","","");
	        for(var i=0; i<arrVal.length; i++){
	       		var a = i+6;
	       		//var a = i+5;
	        	//if(i>=6){a = a+1;} // ������Ʈ �߰��� '������' ����־ ������ �ϳ��� ������Ŵ
	        	arrVal[i] = document.form1.elements[a].value;
	        }

			// Į�� ��� ����
        	for(var i=0; i<arrId.length ; i++){
	        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show") = "false";
        	}

			for(var i=0; i<arrVal.length; i++){
				if( arrVal[i] != "" ){
        	 		document.grdVI_T_CM_PERSON.ColumnProp(arrId[i], "Show") = "true";
        	 		if( i==0 ){ // ù Į��
			        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"����";
			        }else if( i == (arrVal.length-1) ){// ������ Į��
			        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"�̻�";
        	 		}else{ // �׿�
        	 			if( arrVal[i+1] != "" ){
				        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"~"+eval(arrVal[i+1]+"-"+1);
				        }else{
				        	document.grdVI_T_CM_PERSON.ColumnProp(arrId[i],'Name') = arrVal[i]+"�̻�";
				        }
        	 		}
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
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 			   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ ��3434�ᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow);
        }
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
		// Ʈ�������� �̿��� ��ȸ�̹Ƿ�  "**���� �ڷᰡ ��ȸ�Ǿ����ϴ�."  ǥ��
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsVI_T_CM_PERSON.CountRow/2-1);
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���ɺ��ο���Ȳ</td>
					<td align="right" class="navigator">HOME/�λ����/�������ο���Ȳ/<font color="#000000">���ɺ��ο���Ȳ</font></td>
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
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td align="center" class="greenTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="70"></col>
					<col width="110"></col>
					<col width="70"></col>
					<col width="185"></col>
					<col width="60"></col>
					<col width="90"></col>
					<col width="60"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">��������</td>
					<td class="padding2423" align="left">
						<input type="text" id="txtBIR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this); " onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBIR_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgBIR_YMD_SHR" name="imgBIR_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBIR_YMD_SHR','','134','108');"></a>
					</td>
					<td class="searchState" align="right">�������</td>
					<td class="padding2423" align="left">
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" checked style="margin-bottom:-2px;border:0;">������
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">��ŵ�
						<input type="radio" name="rdoGBN_SHR" id="rdoGBN_SHR" style="margin-bottom:-2px;border:0;">������
					</td>
					<input type="hidden" id="cmbOCC_CD_SHR" value="0">
					<!--
					<td class="searchState" align="right">�ٷα��к�</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
							<option value="0">���</option>
						</select>
					</td>
					-->
                    <td class="searchState" align="right">������</td>
                    <td class="padding2423" align="left">
                        <select id="cmbGBN_CD_SHR" style="WIDTH:80" onChange="fnc_SearchList()">
                            <option value="0">���</option>
                            <option value="1">����</option>
                            <option value="2">����</option>
                        </select>
                    </td>
				</tr>
				<tr>
					<td align="right" class="searchState">���ɱ���</td>
					<td class="padding2423" align="left" colspan="5">
						<input id="txtAGE_SHR_01" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()"  onFocusout="document.form1.txtAGE_SHR_02.value=eval(this.value+'+'+1)">
						����&nbsp;
						<input id="txtAGE_SHR_02" size="4" maxLength="2" class="input_ReadOnly" readonly onKeypress="cfCheckNumber()">
						�̻�&nbsp;
						<input id="txtAGE_SHR_03" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_04" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_05" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_06" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_07" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_08" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_09" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						&nbsp;
						<input id="txtAGE_SHR_10" size="4" maxLength="2" style="ime-mode:disabled" onKeypress="cfCheckNumber()">
						�̻�
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
					<object id="grdVI_T_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:315px;">
						<param name="DataID" value="dsVI_T_CM_PERSON">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name=Numeric					value=true>
						<param name=SuppressOption 		value="1">
						<param name=MaxDecimalPlace     value=2>
						<param name="Format" value='
							<C> id="RN"			width=29	name="NO"			align=center	value="{decode(RN,0,"",RN)}"	suppress=2	BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="GBN_NM"		width=75	name="����"			align=left		LeftMargin="10"	Edit=none	 	suppress=1	BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_TOT"	width=55	name="�ѿ�"			align=center	Edit=none	Value={Decode(AGE_TOT,0,"",AGE_TOT)}					BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_AVG"	width=60	name="��տ���"		align=center	Edit=none	 Value={Decode(AGE_AVG,0,"",AGE_AVG)}					BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}	</C>
							<C> id="AGE_01"		width=56	name="20����"		align=center	Edit=none	 Value={Decode(AGE_01,0,"",AGE_01)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_02"		width=56	name="21-25"		align=center	Edit=none	 Value={Decode(AGE_02,0,"",AGE_02)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_03"		width=56	name="26-30"		align=center	Edit=none	 Value={Decode(AGE_03,0,"",AGE_03)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_04"		width=56	name="31-35"		align=center	Edit=none	 Value={Decode(AGE_04,0,"",AGE_04)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_05"		width=56	name="36-40"		align=center	Edit=none	 Value={Decode(AGE_05,0,"",AGE_05)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_06"		width=56	name="41-45"		align=center	Edit=none	 Value={Decode(AGE_06,0,"",AGE_06)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_07"		width=56	name="46-50"		align=center	Edit=none	 Value={Decode(AGE_07,0,"",AGE_07)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_08"		width=56	name="51-55"		align=center	Edit=none	 Value={Decode(AGE_08,0,"",AGE_08)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_09"		width=56	name="56-60"		align=center	Edit=none	 Value={Decode(AGE_09,0,"",AGE_09)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
							<C> id="AGE_10"		width=56	name="61�̻�"		align=center	Edit=none	 Value={Decode(AGE_10,0,"",AGE_10)}		BgColor={decode(CurRow, LastRow, "#99FFCC", LastRow-1, "#99FFCC")}</C>
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

