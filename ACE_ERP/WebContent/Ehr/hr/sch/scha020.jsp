	<!--*************************************************************************
	* @source      : scha020.jsp												*
	* @description : �ؿ� ����� ���ڱݽ�û�� PAGE 								    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/19            ä����          	        �����ۼ�									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>�ؿ� ����� ���ڱݽ�û��(scha020)</title>
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

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
		var file_flag = "0";    // ÷������ ������

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	var tmpST = document.form1.txtPIS_YY_SHR.value;
        	if( tmpST.length != 0 ){
        		if( tmpST.substr(4,1) != "/" || tmpST.length < 6 ){
	        		alert("�˻��Ϸ��� �����⵵/�б� �� �ٸ��� �Է��Ͻʽÿ�. \n��)2007/1");
	        		return;
        		}
        		if( tmpST.substr(5,1) > 4 || tmpST.substr(5,1) < 1){
	        		alert("�˻��Ϸ��� �б⸦ �ٸ��� �Է��Ͻʽÿ�. \n��)1-4");
	        		return;
        		}
        	}

			//�ؿ������ ���ڱݽ�û�� ��ȸ
			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value;

			dsT_SC_SCHLBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SHR&PIS_YY_SHR="+PIS_YY_SHR;
			dsT_SC_SCHLBOOK.reset();

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
			trT_SC_SCHLBOOK.KeyValue = "tr01(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK, I:FILE=oFileListGDS)";
			trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SAV";
			trT_SC_SCHLBOOK.post();
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
			if (dsT_SC_SCHLBOOK.CountColumn == 0) {
				dsT_SC_SCHLBOOK.setDataHeader("IOC_GBN:STRING, PIS_YY:STRING, PIS_MM:STRING, ENO_NO:STRING, ENO_NM:STRING, OCC_CD:STRING, DPT_CD:STRING, DPT_NM:STRING, JOB_CD:STRING, JOB_NM:STRING, HIR_YMD:STRING, CHI_AMT:STRING, TEL_NO:STRING, BIR_YMD:STRING, SEL_NM:STRING, MF_TAG:STRING, OLD_AGE:STRING, FSCH_CD:STRING, SCH_CD:STRING, SCH_NM:STRING, MAJ_NM:STRING, RET_AMT:INT, EDU_AMT:INT, END_AMT:INT, SCO_AMT:INT, OTH_AMT:INT, TOT_AMT:INT, PAY_AMT:INT, IMG_YN:STRING, OFILE_NM:STRING, UFILE_NM:STRING");
			}

			enableInput();

			dsT_SC_SCHLBOOK.AddRow();

            //�α����� ������� ��������� ��ȸ
            fnc_SearchInfo();

			// EMEdit default ��
			document.medRET_AMT.Text = "";
			document.medEDU_AMT.Text = "";
			document.medEND_AMT.Text = "";
			document.medTOT_AMT.Text = "";
			document.form1.cmbFSCH_CD.selectedIndex = 0;

			// ����/�� ���� ����
			document.form1.hidIOC_GBN.value = "2"; // ����
			spnSSN.innerText  = "�ֹι�ȣ";          // �ű��ϰ�� "�������" -> "�ֹι�ȣ"

			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","width") = "120";
			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","name")  = "�ֹι�ȣ";
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
	        if (dsT_SC_SCHLBOOK.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "�������  = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YY")+"/ "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_MM")+"\n";
            	tmpMSG += "�����     = "+dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM")+"\n";

	            if( confirm(tmpMSG) ){
					var IOC_GBN = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "IOC_GBN");
					var ENO_NO  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "ENO_NO");
					var PIS_YY  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_YY");
					var PIS_MM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "PIS_MM");
					var BIR_YMD = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "BIR_YMD");
					var SEL_NM  = dsT_SC_SCHLBOOK.nameValue(dsT_SC_SCHLBOOK.RowPosition, "SEL_NM");

					dsT_SC_SCHLBOOK.DeleteRow(dsT_SC_SCHLBOOK.RowPosition);
					// �Ķ���� �߰�
					trT_SC_SCHLBOOK.Parameters = "IOC_GBN="+IOC_GBN+",ENO_NO="+ENO_NO+",PIS_YY="+PIS_YY+",PIS_MM="+PIS_MM+",BIR_YMD="+BIR_YMD+",SEL_NM="+SEL_NM;

					trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)";
					trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=DEL";
					trT_SC_SCHLBOOK.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			document.form1.txtPIS_YY_SHR.value = "";

  			disableInput();
	        document.getElementById("resultMessage").innerText = ' ';
	        spnSSN.innerText  = "�������";

			// �޺��ڽ� �⺻ ����
			document.form1.cmbFSCH_CD.selectedIndex = 0;

        	dsT_SC_SCHLBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_SC_SCHLBOOK.IsUpdated)  {
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
         	if ( !dsT_SC_SCHLBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			if( document.form1.txtBIR_YMD.value.length < 14){
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	// �г� ���� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_E9.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_E9.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_E9.NameValue(i,"CODE_NAME");
				document.getElementById("cmbFSCH_CD").add(oOption);
			}

			// ���� ÷�ο� �����ͼ��� ��� ���� ����.
	        oFileListGDS.setDataHeader("ENO_NO:STRING, FILE_URL:URL, FILE_NAME:STRING");

			cfStyleGrid(form1.grdT_SC_SCHLBOOK,15,"false","false");      // Grid Style ����
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

         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		 	for(var i=10; i<24; i++){
	  		 	if(i==17){continue;}  // �̹���÷�� �ʵ� ���� �Ұ�
  		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = true;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}

  			document.getElementById("cmbFSCH_CD").disabled  = false;   // �г� �޺�
 			document.form1.FileAdd.disabled  = false;                  // ÷������
  			document.form1.FileDel.disabled  = false;                  // ���ϻ���
  		}

        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		 	for(var i=0; i<24; i++){
 		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = false;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = true;
	  			document.form1.elements[i].className = "input_ReadOnly";
  			}
  			document.getElementById("cmbFSCH_CD").disabled  = true;   // �г� �޺�
  			document.form1.FileAdd.disabled  = true;                  // ÷������
  			document.form1.FileDel.disabled  = true;                  // ���ϻ���
  		}

		/********************************************
         * ��� �˻� �� �ʵ尪 ����(extends common.js - �迭�� ���ڷ�)*
         ********************************************/
        function fnc_emplPopupArr1(arr){
        	var obj = new String();

        	obj.eno_nm = "";

			window.showModalDialog("/common/popup/empl.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			if(arr[0] != "" && obj.eno_no.trim() != ""){
	  			document.getElementById(arr[0]).value = obj.eno_no;
 			}
			if(arr[1] != "" && obj.eno_nm.trim() != ""){
 				document.getElementById(arr[1]).value = obj.eno_nm;
			}
			if(arr[2] != "" && obj.dpt_cd.trim() != ""){
 				document.getElementById(arr[2]).value = obj.dpt_cd;
			}
			if(arr[3] != ""  && obj.dpt_nm.trim() != ""){
 	 			document.getElementById(arr[3]).value = obj.dpt_nm;
 			}
			if(arr[4] != "" && obj.job_cd.trim() != ""){
 				document.getElementById(arr[4]).value = obj.job_cd;
			}
			if(arr[5] != "" && obj.job_nm.trim() != ""){
  				document.getElementById(arr[5]).value = obj.job_nm;
 			}
			if(arr[6] != ""){
				// [6]�� ������ �Լ������� ��ũ��Ʈ �Լ� ����
				var fn = "document.Script."+arr[6];
				eval(fn);
			}
        }

 		/********************************************
         * ���õ� ����� �ش��ϴ� ������� ��ȸ          		*
         ********************************************/
        function fnc_SearchInfo(){
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=SHR_01";
			dsVI_T_PERSON.reset();
        }

  		/********************************************
         * �ֹε�Ϲ�ȣ �Է½� �ڵ� ������(-) �ֱ� 			*
         ********************************************/
		function cfCheckNumber5(){
			if((event.keyCode < 48)||(event.keyCode > 57)){
				if(event.keyCode != 45){
					event.returnValue=false;
				}
			}
			if( document.form1.txtBIR_YMD.value.length == 6 ){
				document.form1.txtBIR_YMD.value += "-";
			}
		}

  		/********************************************
         * �˻����� �Է½� �ڵ� ������(/) �ֱ� 				*
         ********************************************/
		function cfCheckNumber6(){
			if((event.keyCode < 48)||(event.keyCode > 57)){
				if(event.keyCode != 47){
					event.returnValue=false;
				}
			}
			if( document.form1.txtPIS_YY_SHR.value.length == 4 ){
				document.form1.txtPIS_YY_SHR.value += "/";
			}
		}

  		/********************************************
         * �ֹε�Ϲ�ȣ �ʵ忡�� ��Ŀ�� ������ ��ȿ���� �˻�      *
         ********************************************/
		function checkSSN(){
			// ������ ����
			var ssn = removeChar( document.form1.txtBIR_YMD.value, "-" ) ;
			if( document.form1.txtBIR_YMD.value.length != 10 && ssn != "" && ! covSsnValidator_validate(ssn) ){
				alert("�߸��� �ֹι�ȣ�Դϴ�.");
				document.form1.txtBIR_YMD.value = "";
				document.form1.txtBIR_YMD.focus();
			}
		}

		/********************************************
         * �����⵵ �ʵ忡�� ��Ŀ�� ������ ó��                          *
         ********************************************/
		function checkPISYY(){
			var pisYY = document.form1.txtPIS_YY.value;
			if( pisYY != "" && pisYY.length < 3){
				alert("�����⵵�� �ùٸ��� �Է��Ͻʽÿ�. \n��)2007");
				document.form1.txtPIS_YY.focus();
				return false;
			}
		}

		/********************************************
         * �� �ʵ忡�� ��Ŀ�� ������ ó��                                    *
         ********************************************/
		function checkPISMM(){
			var pisMM = document.form1.txtPIS_MM.value;
			if( pisMM != "" && ( pisMM < 1 || pisMM > 12) ){
				alert("�������� �ùٸ��� �Է��Ͻʽÿ�. \n��)1");
				document.form1.txtPIS_MM.focus();
				return false;
			}
		}

		/********************************************
         * �׸��� Ŭ���� �ش� ���� ���޿��ο� ���� Ȱ��ȭ ó��   *
         ********************************************/
        function checkPayStatus(row, colid){

            // ���� ��
        	if( dsT_SC_SCHLBOOK.NameValue(row, "PAY_YN") == "T" ){
        		for(var i=12; i<15; i++){
		  			document.form1.elements[i].readOnly  = true;                // �б���, �а�, �г��޺�
		  			document.form1.elements[i].className = "input_ReadOnly";
        		}
        		for(var i=20; i<24; i++){
		  			document.form1.elements[i].Enable = false;                 // ���б�, ������, �⼺ȸ��
        		}
	  			document.getElementById("cmbFSCH_CD").disabled  = true;        // �г� �޺�
  				document.form1.FileAdd.disabled  = true;                       // ÷������
	  			document.form1.FileDel.disabled  = true;                       // ���ϻ���

	  		// ���� �ȵ�
        	}else{
        		for(var i=12; i<15; i++){
		  			document.form1.elements[i].readOnly  = false;               // �б���, �а�, �г��޺�
		  			document.form1.elements[i].className = "";
        		}
        		for(var i=20; i<24; i++){
		  			document.form1.elements[i].Enable = true;                  // ���б�, ������, �⼺ȸ��
        		}
	  			document.getElementById("cmbFSCH_CD").disabled  = false;       // �г� �޺�
  				document.form1.FileAdd.disabled  = false;                      // ÷������
		  		document.form1.FileDel.disabled  = false;                      // ���ϻ���
        	}
		}

		/********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload() {
			if( document.form1.txtENO_NO.value == "" ){
				alert("����� ���� �Է� �Ͻʽÿ�.");
				return;
			}

            oFileListGDS.addrow();
	        oFileListGDS.NameValue(oFileListGDS.RowPosition, "ENO_NO") = form1.txtENO_NO.value;

	        oFileGF.OpenFileName = form1.txtFILE_NAME.value;

	        oFileGF.open();

	        if(oFileGF.SelectState == true){
				form1.txtFILE_NAME.value = oFileGF.value;
			} else {
				oFileListGDS.deleterow(oFileListGDS.RowPosition);
			}
		}

		/********************************************
         * ÷������ ����								*
         ********************************************/
		function fnc_FileDelete() {
			// ��ϵǾ��ִ� ÷�������� �����Ѵ�.
			if ( form1.hidFILE_URL.value != "" && form1.txtFILE_NAME.value != "" ) {
				if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){

					// ��������(FLAG÷�� ����)
					file_flag = "1";
					var FILE_URL = form1.hidFILE_URL.value;

					trT_SC_SCHLBOOK.Parameters = "FILE_URL="+FILE_URL+",FLAG="+file_flag;

					trT_SC_SCHLBOOK.KeyValue = "tr02(I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK, I:FILE=oFileListGDS)";
					trT_SC_SCHLBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.sch.a.scha020.cmd.SCHA020CMD&S_MODE=DEL";
					trT_SC_SCHLBOOK.post();

					// �ʱ�ȭ
					file_flag = "0";
					form1.txtFILE_NAME.value = "";
					form1.hidFILE_URL.value  = "";
				}
			}
			else {
				alert("������ ������ �������� �ʽ��ϴ�.");
			}
		}

		/********************************************
         * �հ豸�ؼ� �ֱ�	 							*
         ********************************************/
		function fnc_sum(){
			var ret_amt = form1.medRET_AMT.Text;
			var edu_amt = form1.medEDU_AMT.Text;
			var end_amt = form1.medEND_AMT.Text;

			if( ret_amt == "" ){ ret_amt = 0; }
			if( edu_amt == "" ){ edu_amt = 0; }
			if( end_amt == "" ){ end_amt = 0; }
			var sum = eval( ret_amt+"+"+edu_amt+"+"+end_amt )+"";

			form1.medTOT_AMT.Text = sum;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_SC_SCHLBOOK)			   |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_SC_SCHLBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet								       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(VI_T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_SC_SCHLBOOK)		       |
    | 3. ���Ǵ� Table List(T_SC_SCHLBOOK)			       |
    +------------------------------------------------------>
	<Object ID="trT_SC_SCHLBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK,I:dsT_SC_SCHLBOOK=dsT_SC_SCHLBOOK)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- �г� ���� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_E9"/>
       <jsp:param name="CODE_GUBUN"    value="E9"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

	<!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
	<object id="oFileListGDS" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<param name="Syncload" value="true">
	</object>

 	<!-- ���콺 ���� ������Ʈ -->
	<object id=oFileGF classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
		<param name="Text"		value='÷������'>
		<param name="Enable"	value="true">
	</object>
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_SC_SCHLBOOK.CountRow);

			disableInput();
			for(var i=12; i<24; i++){  // �б��� ~ ��
				//  ����,    �ֹι�ȣ, ÷�����ϸ� ���� �Ұ�
				if( i==15 || i==16 || i==17 ){ continue; }
                //  ���б�,   ������,  �⼺ȸ��,    �� ���� ����
  		 		if( i==20 || i==21 || i==22 || i==23 ){
  		 			document.form1.elements[i].Enable  = true;
  		 			continue;
  		 		}
  				document.form1.elements[i].readOnly = false;
	  			document.form1.elements[i].className = "";
  			}
  			document.getElementById("cmbFSCH_CD").disabled  = false;   // �г� �޺�
  			spnSSN.innerText  = "�������";                              // ��ȸ�ϰ�� "�ֹι�ȣ" -> "�������"

			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","width") = "70";
			//grdT_SC_SCHLBOOK.ColumnProp("BIR_YMD","name")  = "�������";

			// ù���� ���޿��ο� ���� �ʵ� Ȱ��ȭ
			checkPayStatus(0, "PAY_YN");
        }
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("�ش����� ������ �����ϴ�.");
		} else {
			// ��� ���� ����
            document.form1.txtENO_NO.value   = dsVI_T_PERSON.NameValue(0,"ENO_NO");
            document.form1.txtENO_NM.value   = dsVI_T_PERSON.NameValue(0,"ENO_NM");
            document.form1.txtDPT_NM.value   = dsVI_T_PERSON.NameValue(0,"DPT_NM");
            document.form1.txtJOB_NM.value   = dsVI_T_PERSON.NameValue(0,"JOB_NM");
			document.form1.txtHIR_YMD.value   = dsVI_T_PERSON.NameValue(0,"HIR_YMD");
			document.form1.txtEM_PHN_NO.value = dsVI_T_PERSON.NameValue(0,"EM_PHN_NO");
			document.form1.hidOCC_CD.value    = dsVI_T_PERSON.NameValue(0,"OCC_CD");
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsVI_T_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_SC_SCHLBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnSuccess()">
		//÷������ ������
		if( file_flag == "1" ){
			fnc_Message(document.getElementById("resultMessage"), '* ÷�������� �����Ǿ����ϴ�.');
	    	file_flag == "0";
		}else{
			fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
			fnc_SearchList();
		}
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_SC_SCHLBOOK event="OnFail()">
        cfErrorMsg(this);
    </script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_SC_SCHLBOOK event=OnClick(row,colid)>
		checkPayStatus(row, colid);
	</script>

	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_SC_SCHLBOOK event=CanRowPosChange(row)>
		if( dsT_SC_SCHLBOOK.RowStatus(row) == 1 && document.form1.txtBIR_YMD.value.length < 14){
			alert("�߸��� �ֹι�ȣ�Դϴ�.");
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"ENO_NO") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"PIS_YY") == "" ) {
			alert("[ �����⵵ ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"PIS_MM") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','PIS_MM') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"SEL_NM") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','SEL_NM') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_SC_SCHLBOOK.NameValue(row,"BIR_YMD") == "" ) {
			alert("[ " + grdT_SC_SCHLBOOK.GetHdrDispName('-3','BIR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ؿ� ����� ���ڱ� ��û��</td>
					<td align="right" class="navigator">HOME/�����Ļ�/���ڱ�����/<font color="#000000">�ؿ� ����� ���ڱ� ��û��</font></td>
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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- ���� �Է� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="70"></col>
			<col width="25"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423"><input id="txtENO_NO" name="txtENO_NO" size="15" maxlength="8" style="ime-mode:disabled" onKeypress="cfNumberCheck()">
			</td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtENO_NM" size="12"></td>
			<td align="center" class="creamBold">�Ҽ�</td>
			<td class="padding2423">
				<input id="txtDPT_NM" size="15">
				<input type="hidden" id="hidDPT_CD" size="10">
				<input type="hidden" id="hidIOC_GBN" size="10">
			</td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423" colspan="3">
				<input id="txtJOB_NM" size="7">
				<input type="hidden" id="hidOCC_CD" size="10">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">�Ի���</td>
			<td class="padding2423"><input id="txtHIR_YMD" size="15" maxLength="3"></td>
			<td align="center" class="creamBold">�ڳ��</td>
			<td class="padding2423"><input id="txtCHI_AMT" size="12" maxLength="3" style="ime-mode:disabled" onKeypress="cfCheckNumber2()"></td>
			<td align="center" class="creamBold">��ȭ��ȣ</td>
			<td class="padding2423"><input id="txtEM_PHN_NO" size="15" maxLength="13" style="ime-mode:disabled" onKeypress="cfCheckNumber()"></td>
			<td align="center" class="creamBold">�����⵵</td>
			<td class="padding2423"><input id="txtPIS_YY" size="7" maxLength="4" style="ime-mode:disabled" onFocusOut="checkPISYY()" onKeypress="cfCheckNumber2()"></td>
			<td align="center" class="creamBold">��</td>
			<td class="padding2423"><input id="txtPIS_MM" size="5" maxLength="2" style="ime-mode:disabled" onFocusOut="checkPISMM()" onKeypress="cfCheckNumber2()"></td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="paddingTop8"><img src="/images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle"> �����ڳ࿡ ���� �����Է�</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="80"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">�б���</td>
			<td class="padding2423"><input id="txtSCH_NM" size="12" maxLength="10"></td>
			<td align="center" class="creamBold">�а�</td>
			<td class="padding2423"><input id="txtMAJ_NM" size="14" maxLength="10"></td>
			<td align="center" class="creamBold">�г�</td>
			<td class="padding2423" colspan="3">
				<select id="cmbFSCH_CD" style="width:20%"></select>
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtSEL_NM" size="12" maxLength="12"></td>
			<td align="center" class="creamBold"><span id="spnSSN">�ֹι�ȣ</span></td>
			<td class="padding2423"><input id="txtBIR_YMD" size="14" maxLength="14" style="ime-mode:disabled" onblur="checkSSN();" onKeypress="cfCheckNumber5();"></td>
			<td align="center" class="creamBold">�̹���÷��</td>
			<td class="padding2423" colspan="3">
				<input id=txtFILE_NAME name=txtFILE_NAME size="18" valid='maxlength=255' readonly>&nbsp;
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
				<input type=hidden id=hidFILE_URL name=hidFILE_URL length="255" size="60">
				<input type=hidden id=hidFILE_URL2 name=hidFILE_URL2 size="60" length="255">
			</td>
		</tr>
		<tr>
			<td align="center" class="creamBold">���б�</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medRET_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEDU_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">�б��������</td>
			<td class="padding2423">
			<table width="100%" border="0" >
				<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medEND_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%" onFocusout="fnc_sum()">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=8>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
				</tr>
			</table>
			</td>
			<td align="center" class="creamBold">��</td>
			<td class="padding2423">
			<table width="100%" border="0" >
			<tr>
				<td width="90%">
					<comment id="__NSID__"><object id="medTOT_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
						<param name=Alignment				value=2>
						<param name=Border					value=true>
						<param name=ClipMode				value=true>
						<param name=DisabledBackColor		value="#EEEEEE">
						<param name=Enable					value=true>
						<param name=IsComma					value=true>
						<param name=Language				value=0>
						<param name=MaxLength				value=9>
						<param name=Numeric					value=true>
						<param name=NumericRange			value=0~+:0>
						<param name=ShowLiteral				value=false>
						<param name=Visible					value=true>
						<param name=ReadOnly 				value=true>
					</object></comment><script> __ShowEmbedObject(__NSID__); </script>
				</td>
				<td align="left">��</td>
			</tr>
			</table>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="greenTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="90"></col>
							<col width="600"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�����⵵/�б�</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtPIS_YY_SHR" style="ime-mode:disabled" size="10" maxlength="6" onkeypress="if(event.keyCode == 13)fnc_SearchList(); cfCheckNumber6();">
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
					<object id="grdT_SC_SCHLBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_SC_SCHLBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width="30"		name="NO"				align="center"	value={String(Currow)}</C>
							<C> id="IOC_GBN"	width="100"		name="�����ܱ���"			align="center"	Edit=none	Show="false"</C>
							<C> id="PIS_YY"		width="50"		name="����;�⵵"			align="center"	Edit=none</C>
							<C> id="PIS_MM"		width="25"		name="��"				align="center"	Edit=none</C>
							<C> id="ENO_NO"		width="60"		name="���"				align="center"	Edit=none</C>
							<C> id="ENO_NM"		width="50"		name="����"				align="center"	Edit=none</C>
							<C> id="DPT_CD"		width="80"		name="�μ��ڵ�"			align="left"	Edit=none	Show="false"</C>
							<C> id="DPT_NM"		width="100"		name="�Ҽ�"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="OCC_CD"		width="70"		name="�ٷα��б���"			align="center"	Edit=none	Show="false"</C>
							<C> id="JOB_NM"		width="40"		name="����"				align="center"	Edit=none</C>
							<C> id="HIR_YMD"	width="70"		name="�Ի���"				align="center"	Edit=none</C>
							<C> id="CHI_AMT"	width="30"		name="�ڳ�;��"			align="center"	Edit=none</C>
							<C> id="EM_PHN_NO"	width="100"		name="��ȭ��ȣ"			align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="BIR_YMD"	width="90"		name="�������"			align="center"	Edit=none</C>
							<C> id="SEL_NM"		width="50"		name="����"				align="center"	Edit=none</C>
							<C> id="MF_TAG"		width="30"		name="����"				align="center"	Edit=none	EditStyle=Combo		Data="F:����,M:����"</C>
							<C> id="OLD_AGE"	width="30"		name="����"				align="center"	Edit=none</C>
							<C> id="FSCH_CD"	width="40"		name="�з±���"			align="center"	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_E9:CODE:CODE_NAME"	Show="false"</C>
							<C> id="SCH_CD"		width="40"		name="�б�����"			align="center"	Edit=none	Show="false"</C>
							<C> id="SCH_NM"		width="100"		name="�б���"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="MAJ_NM"		width="100"		name="�а���"				align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="RET_AMT"	width="90"		name="���б�"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="EDU_AMT"	width="90"		name="������"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="END_AMT"	width="90"		name="�б��������"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="SCO_AMT"	width="90"		name="���б�"				align="right"	Edit=none	RightMargin="10"	Show="false"</C>
							<C> id="OTH_AMT"	width="90"		name="��Ÿ"				align="right"	Edit=none	RightMargin="10"	Show="false"</C>
							<C> id="TOT_AMT"	width="90"		name="�հ�"				align="right"	Edit=none	RightMargin="10"</C>
							<C> id="PAY_AMT"	width="90"		name="���ޱݾ�"			align="right"	Edit=none	RightMargin="10"</C>
							<C> id="IMG_YN"		width="50"		name="�̹���;����"		align="center"	Edit=none	EditStyle=CheckBox</C>
							<C> id="PAY_YN"		width="50"		name="����;����"			align="center"	Edit=none	EditStyle=CheckBox</C>
							<C> id="OFILE_NM"	width="100"		name="�����̹������ϸ�"	align="center"	Edit=none	Show="false"</C>
							<C> id="UFILE_NM"	width="100"		name="��ϵ��̹������ϸ�"	align="right"	Edit=none	Show="false"</C>
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

	<!-- T_SC_SCHLBOOK ���� ���̺� -->
	<object id="bndT_SC_SCHLBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_SC_SCHLBOOK">
		<Param Name="BindInfo", Value="
			<C>Col=IOC_GBN		Ctrl=hidIOC_GBN		Param=value</C>
			<C>Col=PIS_YY		Ctrl=txtPIS_YY		Param=value</C>
			<C>Col=PIS_MM		Ctrl=txtPIS_MM		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
			<C>Col=DPT_CD		Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM		Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=OCC_CD		Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=JOB_NM		Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=HIR_YMD		Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=CHI_AMT		Ctrl=hidCHI_AMT		Param=value</C>
			<C>Col=EM_PHN_NO	Ctrl=txtEM_PHN_NO	Param=value</C>
			<C>Col=BIR_YMD		Ctrl=txtBIR_YMD		Param=value</C>
			<C>Col=SEL_NM		Ctrl=txtSEL_NM		Param=value</C>
			<C>Col=OLD_AGE		Ctrl=txtOLD_AGE		Param=value</C>
			<C>Col=FSCH_CD		Ctrl=cmbFSCH_CD		Param=value</C>
			<C>Col=SCH_NM		Ctrl=txtSCH_NM		Param=value</C>
			<C>Col=MAJ_NM		Ctrl=txtMAJ_NM		Param=value</C>
			<C>Col=RET_AMT		Ctrl=medRET_AMT		Param=Text</C>
			<C>Col=EDU_AMT		Ctrl=medEDU_AMT		Param=text</C>
			<C>Col=END_AMT		Ctrl=medEND_AMT		Param=text</C>
			<C>Col=SCO_AMT		Ctrl=medSCO_AMT		Param=text</C>
			<C>Col=OTH_AMT		Ctrl=medOTH_AMT		Param=text</C>
			<C>Col=TOT_AMT		Ctrl=medTOT_AMT		Param=text</C>
			<C>Col=OFILE_NM		Ctrl=txtFILE_NAME	Param=value</C>
			<C>Col=UFILE_NM		Ctrl=hidFILE_URL	Param=value</C>
		">
	</object>


    <!-- ÷�����Ͽ� ���ε� ������Ʈ -->
    <object id="oFileBD" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	    <Param Name="DataID",   Value="oFileListGDS">
	    <Param Name="BindInfo", Value='
		    <C>Col=FILE_NAME		Ctrl=oFileGF            Param=Value</C>
		    <C>Col=FILE_URL			Ctrl=oFileGF            Param=Value</C>'>
    </object>