	<!--*************************************************************************
	* @source      : proa040.jsp												*
	* @description : ��������õ������ PAGE	 								 			*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/22            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>��������õ������</title>
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
		var CMD = "SHR";
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
   
        	if( document.form1.txtPMT_YY_SHR.value=="" ){
        		alert("���س⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( document.form1.txtPMT_YY_SHR.value.length != 4 ){
        		alert("���س⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	
        	CMD = "SHR";
        	
        	changeInput();
        	
			var PMT_YY_SHR  = document.form1.txtPMT_YY_SHR.value;
			var PMT_TAG_SHR = document.form1.cmbPMT_TAG_SHR.value;
			var PENO_GBN = "2";//���������� ��ȸ
			
			// Ʈ����� ������ ���� dataset ���Ǻ���
			// �ش� Dataset�� Header�� ������ Header ����
            if (dsT_PM_RECOMMAND_CP.CountColumn == 0) {
                dsT_PM_RECOMMAND_CP.setDataHeader("ENO_NO:STRING");
            }
			dsT_PM_RECOMMAND_CP.AddRow();
			
			trT_PM_RECOMMAND.KeyValue = "tr01(I:dsT_PM_RECOMMAND_CP=dsT_PM_RECOMMAND_CP, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG, O:dsT_PM_RECOMMAND=dsT_PM_RECOMMAND)";
			trT_PM_RECOMMAND.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa040.cmd.PROA040CMD&S_MODE=SHR&PENO_GBN="+PENO_GBN+"&PMT_YY_SHR="+PMT_YY_SHR+"&PMT_TAG_SHR="+PMT_TAG_SHR;
			trT_PM_RECOMMAND.post();
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
			
			var PENO_GBN = "2";//���������� ��ȸ
			CMD = "SAV";
			
			// save
			trT_PM_RECOMMAND.KeyValue = "tr01(I:dsT_PM_RECOMMAND=dsT_PM_RECOMMAND)";
			trT_PM_RECOMMAND.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa040.cmd.PROA040CMD&S_MODE=SAV&PENO_GBN="+PENO_GBN;
			trT_PM_RECOMMAND.post();
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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
        
	        CMD = "DEL";
	        setDefault();
	        
	        if (dsT_PM_RECOMMAND.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�����⵵  = "+dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "PMT_YY")+"\n";
            	var str = "����";
            	if( dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "PMT_GBN") == "2") str = "Ư��";
            	tmpMSG += "��������  = "+str+"\n";
            	tmpMSG += "���       = "+ dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "ENO_NO")+"\n";
            	
	            if( confirm(tmpMSG) ){
					var PMT_YY  = dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "PMT_YY");
					var PMT_GBN = dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "PMT_GBN");
					var ENO_NO  = dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "ENO_NO");
					var PENO_NO = dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, "PENO_NO");
				
					dsT_PM_RECOMMAND.DeleteRow(dsT_PM_RECOMMAND.RowPosition);
					// �Ķ���� �߰�
					trT_PM_RECOMMAND.Parameters = "PMT_YY="+PMT_YY+",PMT_GBN="+PMT_GBN+",ENO_NO="+ENO_NO+",PENO_NO="+PENO_NO;
				
					trT_PM_RECOMMAND.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa040.cmd.PROA040CMD&S_MODE=DEL";
					trT_PM_RECOMMAND.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			
        	document.form1.cmbPMT_TAG_SHR.value = "1";
        	//document.form1.txtPMT_YY_SHR.value = next_yy;
        	document.getElementById("resultMessage").innerText = ' ';
        	
        	dsT_PM_RECOMMAND.ClearData();
        	
        	changeInput();
        	disableInput();
        	
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_RECOMMAND.IsUpdated)  {
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
         	if (!dsT_PM_RECOMMAND.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			
			return true;
        }
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {

			document.form1.txtPMT_YY_SHR.value = next_yy;
			changeInput();
			disableInput();
			
			cfStyleGrid(form1.grdT_PM_RECOMMAND,15,"true","false");      // Grid Style ����
			
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
         * [����(�����̻�/�븮����)] ���ý� �Է� ����		*
         ********************************************/
        function changeInput() {
			if( document.form1.cmbPMT_TAG_SHR.value == "1" ){
        		document.getElementById("txtPMT_TAG").innerText = "�����̻�";
        		document.getElementById("txtGBN_NM").innerText = "������\n��������";
        		document.getElementById("GWAJANG").style.display = "inline";
        		document.getElementById("DAELI").style.display = "none";
        	}else{
				document.getElementById("txtPMT_TAG").innerText = "�븮����";
        		document.getElementById("txtGBN_NM").innerText = "�ǰ�����";
        		document.getElementById("GWAJANG").style.display = "none";
        		document.getElementById("DAELI").style.display = "inline";
        	}
       		setFieldEnable();
        }
        
		/********************************************
         * �븮���� �ǰ����� ���ý� �Է� ����				*
         ********************************************/
        function fnc_Health() {
			if( document.form1.rdoHEALTH_GBN[0].checked ){
        		dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') = "1"; // �ſ�ǰ�
        	}else if( document.form1.rdoHEALTH_GBN[1].checked ){
        		dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') = "2"; // �ǰ�
        	}else if( document.form1.rdoHEALTH_GBN[2].checked ){
        		dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') = "3"; // �ǰ�����
        	}else if( document.form1.rdoHEALTH_GBN[3].checked ){
        		dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') = "4"; // �ټ�����
        	}else if( document.form1.rdoHEALTH_GBN[4].checked ){
        		dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') = "5"; // �ſ�����
        	}
        	
        	setFieldEnable();
        }
		/********************************************
         * �븮���� �ǰ����� ���ý� �Է� ����(�󼼳���)		*
         ********************************************/
        function setFieldEnable() {
          	// 4,5�� �ش�� ��ü�� ���� �ʵ� Ȱ��ȭ ó��
        	if( dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'HEALTH_GBN') >=4 ){
        		document.form1.txtHEALTH_TAG.readOnly  = false;
        		document.form1.txtHEALTH_TAG.className = ""; 
        	}else{
        		document.form1.txtHEALTH_TAG.value = ""; 
        		document.form1.txtHEALTH_TAG.readOnly  = true;
        		document.form1.txtHEALTH_TAG.className = "input_ReadOnly"; 
        	}
        }
		
         /********************************************
         * �Է��ʵ� ��� �����ϰ�(Enable)          		 *
         ********************************************/
  		function enableInput(){
  		  	for(var i=3; i<6; i++){    // rdoPMT_LBL_TAG_01 ~ 03
  				document.form1.elements[i].disabled = false;
  			}
  			for(var i=15; i<33; i++){  // rdoITEM1_TAG01 ~ 0601
  				document.form1.elements[i].disabled = false;
  			}
  			for(var i=37; i<42; i++){  // rdoHEALTH_GBN_01 ~ 05
  				document.form1.elements[i].disabled = false;
  			}
			
			document.form1.txtRECOMM_TAG.disabled = false;  // textarea
			//document.form1.txtPMT_JOB_CD.readOnly = false;
 			//document.form1.txtPMT_JOB_CD.className = ""; 
			document.form1.txtASGN1_TAG.readOnly = false;
			document.form1.txtASGN1_TAG.className = ""; 
			document.form1.txtASGN2_TAG.readOnly = false;
			document.form1.txtASGN2_TAG.className = ""; 
			document.form1.txtASGN3_TAG.readOnly = false;
			document.form1.txtASGN3_TAG.className = ""; 
			document.form1.txtASGN4_TAG.readOnly = false;
			document.form1.txtASGN4_TAG.className = ""; 
  		}
  		
        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){

  			for(var i=3; i<6; i++){    // rdoPMT_LBL_TAG_01 ~ 03
  				document.form1.elements[i].disabled = true;
  			}
  			for(var i=15; i<33; i++){  // rdoITEM1_TAG01 ~ 0601
  				document.form1.elements[i].disabled = true;
  			}
  			for(var i=37; i<42; i++){  // rdoHEALTH_GBN_01 ~ 05
  				document.form1.elements[i].disabled = true;
  			}

  			//document.form1.txtRECOMM_TAG.innerText = "";
			document.form1.txtRECOMM_TAG.disabled = true;  // textarea
			document.form1.txtPMT_JOB_CD.readOnly = true;
			document.form1.txtPMT_JOB_CD.className = "input_ReadOnly"; 
			document.form1.txtPMT_LBL_CNT.readOnly = true;
			document.form1.txtPMT_LBL_CNT.className = "input_ReadOnly"; 
			document.form1.txtASGN1_TAG.readOnly = true;
			document.form1.txtASGN1_TAG.className = "input_ReadOnly"; 
			document.form1.txtASGN2_TAG.readOnly = true;
			document.form1.txtASGN2_TAG.className = "input_ReadOnly"; 
			document.form1.txtASGN3_TAG.readOnly = true;
			document.form1.txtASGN3_TAG.className = "input_ReadOnly"; 
			document.form1.txtASGN4_TAG.readOnly = true;
			document.form1.txtASGN4_TAG.className = "input_ReadOnly"; 
  		}
  		
        /********************************************
         * �׸��� Ŭ���� ������ư ���� 	        		*
         ********************************************/
  		function checkRdoStatus(){
  		
	  		setDefault();
	  		
  			var PMT_LBL_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "PMT_LBL_TAG");
  			if( PMT_LBL_TAG == "A" ){       // ��õ��� - A
  				document.form1.rdoPMT_LBL_TAG[0].checked = true;
  			}else if( PMT_LBL_TAG == "B" ){ // ��õ��� - B
  				document.form1.rdoPMT_LBL_TAG[1].checked = true;
  			}else if( PMT_LBL_TAG == "C" ){ // ��õ��� - C
  				document.form1.rdoPMT_LBL_TAG[2].checked = true;
  			}
  			
  			var HEALTH_GBN = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "HEALTH_GBN");
  			if( HEALTH_GBN == "1" ){       // �ǰ����� - 1
  				document.form1.rdoHEALTH_GBN[0].checked = true;
  			}else if( HEALTH_GBN == "2" ){ // �ǰ����� - 2
  				document.form1.rdoHEALTH_GBN[1].checked = true;
  			}else if( HEALTH_GBN == "3" ){ // �ǰ����� - 3
  				document.form1.rdoHEALTH_GBN[2].checked = true;
  			}else if( HEALTH_GBN == "4" ){ // �ǰ����� - 4
  				document.form1.rdoHEALTH_GBN[3].checked = true;
  			}else if( HEALTH_GBN == "5" ){ // �ǰ����� - 5
  				document.form1.rdoHEALTH_GBN[4].checked = true;
  			}
  			
  			var ITEM1_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM1_TAG");
  			if( ITEM1_TAG == "A" ){       // �������� - A
  				document.form1.rdoITEM1_TAG[0].checked = true;
  			}else if( ITEM1_TAG == "B" ){ // �������� - B
  				document.form1.rdoITEM1_TAG[1].checked = true;
  			}else if( ITEM1_TAG == "C" ){ // �������� - C
  				document.form1.rdoITEM1_TAG[2].checked = true;
  			}
  			
  			var ITEM2_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM2_TAG");
  			if( ITEM2_TAG == "A" ){       // �ٸ鼺 - A
  				document.form1.rdoITEM2_TAG[0].checked = true;
  			}else if( ITEM2_TAG == "B" ){ // �ٸ鼺 - B
  				document.form1.rdoITEM2_TAG[1].checked = true;
  			}else if( ITEM2_TAG == "C" ){ // �ٸ鼺 - C
  				document.form1.rdoITEM2_TAG[2].checked = true;
  			}
  			
  			var ITEM3_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM3_TAG");
  			if( ITEM3_TAG == "A" ){       // å�Ӱ� - A
  				document.form1.rdoITEM3_TAG[0].checked = true;
  			}else if( ITEM3_TAG == "B" ){ // å�Ӱ� - B
  				document.form1.rdoITEM3_TAG[1].checked = true;
  			}else if( ITEM3_TAG == "C" ){ // å�Ӱ� - C
  				document.form1.rdoITEM3_TAG[2].checked = true;
  			}
  			
  			var ITEM4_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM4_TAG");
  			if( ITEM4_TAG == "A" ){       // ���ؼ� - A
  				document.form1.rdoITEM4_TAG[0].checked = true;
  			}else if( ITEM4_TAG == "B" ){ // ���ؼ� - B
  				document.form1.rdoITEM4_TAG[1].checked = true;
  			}else if( ITEM4_TAG == "C" ){ // ���ؼ� - C
  				document.form1.rdoITEM4_TAG[2].checked = true;
  			}
  			 			
  			var ITEM5_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM5_TAG");
  			if( ITEM5_TAG == "A" ){       // �����ǿ� - A
  				document.form1.rdoITEM5_TAG[0].checked = true;
  			}else if( ITEM5_TAG == "B" ){ // �����ǿ� - B
  				document.form1.rdoITEM5_TAG[1].checked = true;
  			}else if( ITEM5_TAG == "C" ){ // �����ǿ� - C
  				document.form1.rdoITEM5_TAG[2].checked = true;
  			}
  			
  			var ITEM6_TAG = dsT_PM_RECOMMAND.NameValue(dsT_PM_RECOMMAND.RowPosition, "ITEM6_TAG");
  			if( ITEM6_TAG == "A" ){       // ������ - A
  				document.form1.rdoITEM6_TAG[0].checked = true;
  			}else if( ITEM6_TAG == "B" ){ // ������ - B
  				document.form1.rdoITEM6_TAG[1].checked = true;
  			}else if( ITEM6_TAG == "C" ){ // ������ - C
  				document.form1.rdoITEM6_TAG[2].checked = true;
  			}
  		}
  		
        /********************************************
         * �׸��� Ŭ���� ������ư ���� 	        		*
         ********************************************/  
         function setDefault(){
  			document.form1.rdoPMT_LBL_TAG[0].checked = false;
 			document.form1.rdoPMT_LBL_TAG[1].checked = false;
  			document.form1.rdoPMT_LBL_TAG[2].checked = false;     
   			document.form1.rdoHEALTH_GBN[0].checked = false;
  			document.form1.rdoHEALTH_GBN[1].checked = false;
  			document.form1.rdoHEALTH_GBN[2].checked = false;
  			document.form1.rdoHEALTH_GBN[3].checked = false;        
			document.form1.rdoITEM1_TAG[0].checked = false;
			document.form1.rdoITEM1_TAG[1].checked = false;
			document.form1.rdoITEM1_TAG[2].checked = false;
   			document.form1.rdoITEM2_TAG[0].checked = false;
  			document.form1.rdoITEM2_TAG[1].checked = false;
  			document.form1.rdoITEM2_TAG[2].checked = false;        
     		document.form1.rdoITEM3_TAG[0].checked = false;
  			document.form1.rdoITEM3_TAG[1].checked = false;
  			document.form1.rdoITEM3_TAG[2].checked = false;      
  			document.form1.rdoITEM4_TAG[0].checked = false;
  			document.form1.rdoITEM4_TAG[1].checked = false;
  			document.form1.rdoITEM4_TAG[2].checked = false;         
            document.form1.rdoITEM5_TAG[0].checked = false;
  			document.form1.rdoITEM5_TAG[1].checked = false;
  			document.form1.rdoITEM5_TAG[2].checked = false;    	
			document.form1.rdoITEM6_TAG[0].checked = false;
			document.form1.rdoITEM6_TAG[1].checked = false;
			document.form1.rdoITEM6_TAG[2].checked = false;
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_RECOMMAND)			   |
    | 3. ���Ǵ� Table List(T_PM_RECOMMAND) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_RECOMMAND" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>
	
    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)             |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                   |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>	

	<!-----------------------------------------------------+
    | 1. ����� DataSet									   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_RECOMMAND)			   |
    | 3. ���Ǵ� Table List(T_PM_RECOMMAND) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_RECOMMAND_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_RECOMMAND)			   |
    | 3. ���Ǵ� Table List(T_PM_RECOMMAND)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_RECOMMAND" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
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
	<Script For=dsT_PM_RECOMMAND Event="OnLoadCompleted(iCount)">
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        if(dsT_CP_WORKLOG.CountRow == 1){ // ����
            if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                disableInput();
                alert("�������õ�ڰ����� �Ϸ���� �ʾҽ��ϴ�.");
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2") {
                enableInput();
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
                disableInput();
                alert("�̹� �������װ��� ó���� �Ǿ����ϴ�.");
            }
        }else{       
            disableInput();
            alert("��������ڼ����� �Ϸ���� �ʾҽ��ϴ�.");
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_RECOMMAND Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>    

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_RECOMMAND Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>    

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_RECOMMAND event="OnSuccess()">
		if( CMD == "SHR" ){
			if(dsT_PM_RECOMMAND.CountRow != 0){
				fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_RECOMMAND.CountRow);
				//checkRdoStatus();
				//enableInput();
			}else{
				disableInput();
				fnc_Message(document.getElementById("resultMessage"),"MSG_02");
				//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
			}
		}
		if( CMD == "DEL" ||  CMD == "SAV" ){
			if(dsT_PM_RECOMMAND.CountRow != 0){
				//checkRdoStatus();
			}
			fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		}
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_RECOMMAND event="OnFail()">
        alert(trT_PM_RECOMMAND.ErrorMsg);
    </script>
    

    <script language=JavaScript for=dsT_PM_RECOMMAND event=OnRowPosChanged(row)>
    
        //������ư ����
		checkRdoStatus();
		
        if(document.getElementById("txtPMT_TAG").innerText == "�븮����"){
		  setFieldEnable();
        }
		
		enableInput();
		
        if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
            disableInput();
            
            if(document.getElementById("txtPMT_TAG").innerText == "�븮����"){
             document.form1.txtHEALTH_TAG.readOnly  = true;
             document.form1.txtHEALTH_TAG.className = "input_ReadOnly";
            }
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��������õ������</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">��������õ������</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
					<col width="100"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">���س⵵&nbsp;</td>
					<td class="padding2423" align="left">
                        <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                    <input type="text" id="txtPMT_YY_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                </td>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtPMT_YY_SHR', 'yyyy', 'next');" src="/images/common/arrowup.gif"></TD>
                            </tr>
                            <tr>
                                <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtPMT_YY_SHR', 'yyyy', 'prev');" src="/images/common/arrowdown.gif"></TD>
                            </tr>
                        </table>
					</td>
					<td class="searchState" align="right">��������&nbsp;</td>
					<td class="padding2423" align="left">
                        <select id="cmbPMT_TAG_SHR" style="width='80';" onChange="fnc_SearchList()">
                            <option value="1">�����̻�</option>
                            <option value="2">�븮����</option>
                        </select>					
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
            <col width="80"></col>
            <col width="110"></col>
            <col width="80"></col>
            <col width="110"></col>
            <col width="80"></col>
            <col width="110"></col>
            <col width="80"></col>
            <col width=""></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">��������</td>
            <td class="padding2423"><span id="txtPMT_TAG"></span></td>
			<td align="center" class="creamBold">�����޼�</td>
			<td class="padding2423"><input id="txtPMT_JOB_CD" size="15" maxlength="2"></td>
			<td align="center" class="creamBold">��õ���</td>
			<td class="padding2423">
				<input type="radio" name="rdoPMT_LBL_TAG" id="rdoPMT_LBL_TAG_01" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'PMT_LBL_TAG')='A'; document.form1.txtPMT_LBL_CNT.value='10';">A
				<input type="radio" name="rdoPMT_LBL_TAG" id="rdoPMT_LBL_TAG_02" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'PMT_LBL_TAG')='B'; document.form1.txtPMT_LBL_CNT.value='8';">B
                <input type="radio" name="rdoPMT_LBL_TAG" id="rdoPMT_LBL_TAG_03" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'PMT_LBL_TAG')='C'; document.form1.txtPMT_LBL_CNT.value='6';">C
			</td>
			<td align="center" class="creamBold">Ȯ������</td>
			<td class="padding2423"><input id="txtPMT_LBL_CNT" size="15" maxlength="3"></td>
		</tr>
		<tr>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423"><input id="txtENO_NO" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtENO_NM" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">�Ҽ�</td>
			<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtJOB_NM" size="15" class="input_ReadOnly" readonly></td>
		</tr>
		<tr>
			<td align="center" class="creamBold">��ű�</td>
			<td class="padding2423"><input id="txtSCH_NM" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">�������</td>
			<td class="padding2423"><input id="txtBIR_YMD" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">�Ի���</td>
			<td class="padding2423"><input id="txtHIR_YMD" size="15" class="input_ReadOnly" readonly></td>
			<td align="center" class="creamBold">����������</td>
			<td class="padding2423"><input id="txtJPR_YMD" size="15" class="input_ReadOnly" readonly></td>
		</tr>
        </table>    
    </tr>
    </table>
    
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame=VSIDES>
        <colgroup>
            <col width="397"></col>
            <col width="80"></col>
            <col width=""></col>
        </colgroup>
		<tr height="190px">
			<td align="center">
				<table width="97%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999">
                <colgroup>
                    <col width="10%"></col>
                    <col width="30%"></col>
                    <col width="20%"></col>
                    <col width="20%"></col>
                    <col width=""></col>
                </colgroup>
				<tr>
					<td rowspan="7" align="center" class="creamBold">��<br>��<br>��<br>��</td>
					<td align="center" class="creamBold">�׸�</td>
					<td align="center" class="creamBold">A</td>
					<td align="center" class="creamBold">B</td>
					<td align="center" class="creamBold">C</td>
				</tr>
				<tr>
					<td align="center" class="creamBold">��������</td>
					<td align="center"><input type="radio" name="rdoITEM1_TAG" id="rdoITEM1_TAG01" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM1_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM1_TAG" id="rdoITEM1_TAG02" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM1_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM1_TAG" id="rdoITEM1_TAG03" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM1_TAG')='C'"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�ٸ鼺</td>
					<td align="center"><input type="radio" name="rdoITEM2_TAG" id="rdoITEM2_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM2_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM2_TAG" id="rdoITEM2_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM2_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM2_TAG" id="rdoITEM2_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM2_TAG')='C'"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">å�Ӱ�</td>
					<td align="center"><input type="radio" name="rdoITEM3_TAG" id="rdoITEM3_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM3_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM3_TAG" id="rdoITEM3_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM3_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM3_TAG" id="rdoITEM3_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM3_TAG')='C'"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">���ؼ�</td>
					<td align="center"><input type="radio" name="rdoITEM4_TAG" id="rdoITEM4_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM4_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM4_TAG" id="rdoITEM4_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM4_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM4_TAG" id="rdoITEM4_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM4_TAG')='C'"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">�����ǿ�</td>
					<td align="center"><input type="radio" name="rdoITEM5_TAG" id="rdoITEM5_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM5_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM5_TAG" id="rdoITEM5_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM5_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM5_TAG" id="rdoITEM5_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM5_TAG')='C'"></td>
				</tr>
				<tr>
					<td align="center" class="creamBold">������</td>
					<td align="center"><input type="radio" name="rdoITEM6_TAG" id="rdoITEM6_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM6_TAG')='A'"></td>
					<td align="center"><input type="radio" name="rdoITEM6_TAG" id="rdoITEM6_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM6_TAG')='B'"></td>
					<td align="center"><input type="radio" name="rdoITEM6_TAG" id="rdoITEM6_TAG" style="margin-bottom:-2px;border:0;" onClick="dsT_PM_RECOMMAND.nameValue(dsT_PM_RECOMMAND.RowPosition, 'ITEM6_TAG')='C'"></td>
				</tr>
				</table>
			</td>
			<td align="center" class="creamBold"><span id="txtGBN_NM"></span></td>
			<td valign="top">
				<div id="GWAJANG">
                    <table>
                        <tr height="30"><td>
							&nbsp;1.&nbsp;<input id="txtASGN1_TAG" size="44" maxlength="40"><br>
                        </td></tr>
                        <tr height="30"><td>
							&nbsp;2.&nbsp;<input id="txtASGN2_TAG" size="44" maxlength="40"><br>
                        </td></tr>
                        <tr height="30"><td>
							&nbsp;3.&nbsp;<input id="txtASGN3_TAG" size="44" maxlength="40"><br>
                        </td></tr>
                        <tr height="30"><td>
							&nbsp;4.&nbsp;<input id="txtASGN4_TAG" size="44" maxlength="40">
                        </td></tr>
                    </table>
				</div>
				<div id="DAELI">
                    <table>
                        <tr height="25"><td>
							&nbsp;<input type="radio" name="rdoHEALTH_GBN" id="rdoHEALTH_GBN_01" style="margin-bottom:-2px;border:0;" onClick="fnc_Health()" checked>1. �ſ� �ǰ��ϴ�.<br>
                        </td></tr>
                        <tr height="25"><td>
							&nbsp;<input type="radio" name="rdoHEALTH_GBN" id="rdoHEALTH_GBN_02" style="margin-bottom:-2px;border:0;" onClick="fnc_Health()">2. �ǰ��ϴ�.<br>
                        </td></tr>
                        <tr height="25"><td>
							&nbsp;<input type="radio" name="rdoHEALTH_GBN" id="rdoHEALTH_GBN_03" style="margin-bottom:-2px;border:0;" onClick="fnc_Health()">3. �ǰ��� ���̳� ������ ���Ѵ�.<br>
                        </td></tr>
                        <tr height="25"><td>
							&nbsp;<input type="radio" name="rdoHEALTH_GBN" id="rdoHEALTH_GBN_04" style="margin-bottom:-2px;border:0;" onClick="fnc_Health()">4. �������࿡ �ټ� ������ �ִ�.<br>
                        </td></tr>
                        <tr height="25"><td>
							&nbsp;<input type="radio" name="rdoHEALTH_GBN" id="rdoHEALTH_GBN_05" style="margin-bottom:-2px;border:0;" onClick="fnc_Health()">5. �������࿡ ������ ����.<br>
                        </td></tr>
                        <tr height="25"><td>
							&nbsp;&nbsp;&nbsp;&nbsp;<input id="txtHEALTH_TAG" size="44" maxlength="40">
							&nbsp;&nbsp;&nbsp;&nbsp;��4,5�� �ش�� ��ü������ ������ �������ּ���.
                        </td></tr>
                    </table>
				</div>
			</td>
		</tr>
        </table>    
    </tr>
    </table>
    
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
        <colgroup>
            <col width="70"></col>
            <col width=""></col>
        </colgroup>
		<tr>
			<td align="center" class="creamBold">��õ����</td>
			<td align="center">
				<textarea id="txtRECOMM_TAG" rows="5" cols="115" onkeyup="fc_chk_byte(this,300);"></textarea>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	</table>
	
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top">
                            &nbsp;�� ������� �ο��� 3�ܰ�� �պ�(1/3)�Ͽ� ����� �����Ͽ� �ֽʽÿ�.(��õ 10�� ������ A:10��, B:8��, C:6��)<br>
                            &nbsp;�� ��õ������ 6�Ͽ�Ģ�� �ǰ� ��ü������ �ۼ����ּ���.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
	
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
					<object id="grdT_PM_RECOMMAND" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:200px;">
						<param name="DataID" value="dsT_PM_RECOMMAND">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=29	name="NO"		    align=center	value={String(Currow)}</C>
							<C> id="DPT_NM"			width=100	name="�Ҽ�"		    align=center	Edit=none	</C>
							<C> id="JOB_NM"			width=50	name="����"			align=center	Edit=none   </C>
							<C> id="ENO_NO"			width=70	name="���"			align=center	Edit=none   </C>
							<C> id="ENO_NM"			width=70	name="����"			align=center	Edit=none   </C>
							<C> id="BIR_YMD"		width=70	name="�������"		align=center	Edit=none   </C>
							<C> id="SCH_NM"			width=80	name="��ű�"		align=left		Edit=none	</C>
							<C> id="HIR_YMD"		width=70	name="�Ի���"		align=center	Edit=none   </C>
							<C> id="JPR_YMD"		width=70	name="��������"		align=center	Edit=none   </C>
							<C> id="PMT_GBN"		width=50	name="����"			align=center	Edit=none	value={decode(PMT_GBN,"1","����","2","Ư��")}</C>
							<C> id="PMT_TAG"		width=50	name="��õ������"	align=center	Edit=none	show="false"</C>
							<C> id="PMT_JOB_CD"		width=50	name="�����޼�"		align=center	Edit=none   </C>
							<C> id="PMT_LBL_TAG"	width=40	name="��õ;���"	align=center	Edit=none   </C>
							<C> id="PMT_LBL_CNT"	width=40	name="��õ;����"	align=center	Edit=none   </C>
							<C> id="ITEM1_TAG"		width=40	name="����;����"	align=center	Edit=none   </C>
							<C> id="ITEM2_TAG"		width=40	name="�ٸ鼺"		align=center	Edit=none   </C>
							<C> id="ITEM3_TAG"		width=40	name="å�Ӱ�"		align=center	Edit=none   </C>
							<C> id="ITEM4_TAG"		width=40	name="���ؼ�"		align=center	Edit=none   </C>
							<C> id="ITEM5_TAG"		width=40	name="����;�ǿ�"	align=center	Edit=none   </C>
							<C> id="ITEM6_TAG"		width=40	name="������"		align=center	Edit=none   </C>
							<C> id="ASGN1_TAG"		width=70	name="����1"		align=center	Edit=none   </C>
							<C> id="ASGN2_TAG"		width=70	name="����2"		align=center	Edit=none   </C>
							<C> id="ASGN3_TAG"		width=70	name="����3"		align=center	Edit=none   </C>
							<C> id="ASGN4_TAG"		width=70	name="����4"		align=center	Edit=none   </C>
							<C> id="HEALTH_GBN"		width=40	name="�ǰ�;����"	align=center	Edit=none   </C>
							<C> id="HEALTH_TAG"		width=80	name="����"			align=left      Edit=none   </C>
							<C> id="RECOMM_TAG"		width=120	name="��õ����"		align=left      Edit=none   </C>
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

	<!-- T_PM_RECOMMAND ���� ���̺� -->
	<object id="bndT_PM_RECOMMAND" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_RECOMMAND">
		<Param Name="BindInfo", Value="
			<C>Col=PMT_JOB_CD		Ctrl=txtPMT_JOB_CD		Param=value</C>
			<C>Col=PMT_LBL_CNT		Ctrl=txtPMT_LBL_CNT		Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO			Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM			Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM			Param=value</C>
			<C>Col=BIR_YMD			Ctrl=txtBIR_YMD			Param=value</C>
			<C>Col=HIR_YMD			Ctrl=txtHIR_YMD			Param=value</C>
			<C>Col=JPR_YMD			Ctrl=txtJPR_YMD			Param=value</C>
			<C>Col=SCH_NM			Ctrl=txtSCH_NM			Param=value</C>
			<C>Col=ITEM1_TAG		Ctrl=rdoITEM1_TAG		Param=value</C>
			<C>Col=ITEM2_TAG		Ctrl=rdoITEM2_TAG		Param=value</C>
			<C>Col=ITEM3_TAG		Ctrl=rdoITEM3_TAG		Param=value</C>
			<C>Col=ITEM4_TAG		Ctrl=rdoITEM4_TAG		Param=value</C>
			<C>Col=ITEM5_TAG		Ctrl=rdoITEM5_TAG		Param=value</C>
			<C>Col=ITEM6_TAG		Ctrl=rdoITEM6_TAG		Param=value</C>
			<C>Col=ASGN1_TAG		Ctrl=txtASGN1_TAG		Param=value</C>
			<C>Col=ASGN2_TAG		Ctrl=txtASGN2_TAG		Param=value</C>
			<C>Col=ASGN3_TAG		Ctrl=txtASGN3_TAG		Param=value</C>
			<C>Col=ASGN4_TAG		Ctrl=txtASGN4_TAG		Param=value</C>
			<C>Col=HEALTH_TAG		Ctrl=txtHEALTH_TAG		Param=value</C>
			<C>Col=RECOMM_TAG		Ctrl=txtRECOMM_TAG		Param=value</C>
		">
	</object>