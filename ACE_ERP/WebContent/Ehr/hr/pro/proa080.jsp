	<!--*************************************************************************
	* @source      : proa080.jsp												*
	* @description : �������õ�ڰ��� PAGE										    *
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/02            ä����          	        �����ۼ�									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�������õ�ڰ���(proa080)</title>
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
	
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var btnList = 'TFTTTFFT';
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var PMT_YY_SHR   = document.form1.txtPMT_YY_SHR.value;
			var ENO_NO_SHR   = document.form1.txtENO_NO_SHR.value;
			//var PMT_GBN_SHR  = document.form1.cmbPMT_GBN_SHR.value;
			var PMT_GBN_SHR  = "1"
			var JOB_GBN_SHR  = document.form1.cmbJOB_GBN_SHR.value;
			
			if( PMT_YY_SHR == "" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( PMT_YY_SHR.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
			
            trT_PM_PROPOSER_SHR.KeyValue = "tr01(O:dsT_PM_PROPOSER=dsT_PM_PROPOSER, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_PROPOSER_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SHR&PMT_YY_SHR="+PMT_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&PMT_GBN_SHR="+PMT_GBN_SHR+"&JOB_GBN_SHR="+JOB_GBN_SHR;
            trT_PM_PROPOSER_SHR.post();
            			
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
			trT_PM_PROPOSER.KeyValue = "tr01(I:dsT_PM_PROPOSER=dsT_PM_PROPOSER)";
			trT_PM_PROPOSER.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SAV";
			trT_PM_PROPOSER.post();
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
        
            if (dsT_PM_PROPOSER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_PM_PROPOSER.GridToExcel("�������õ�ڰ���", '', 225);

        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_PM_PROPOSER.CountColumn == 0) {
				dsT_PM_PROPOSER.setDataHeader("PMT_YY:STRING, PMT_GBN:STRING, ENO_NO:STRING, PENO_NO:STRING, PDPT_CD:STRING, PJOB_CD:STRING");
			}
			
			dsT_PM_PROPOSER.AddRow();
			
			enableInput();	
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
	        if (dsT_PM_PROPOSER.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�����⵵  = "+dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_YY")+"\n";
            	var str = "����";
            	if( dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_GBN") == "2") str = "Ư��";
            	tmpMSG += "��������   = "+str+"\n";
            	tmpMSG += "���         = "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "��õ�ڻ��= "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NO")+"\n";
            	tmpMSG += "��õ�ڸ�   = "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NM")+"\n";
            	
	            if( confirm(tmpMSG) ){
					var PMT_YY  = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_YY");
					var PMT_GBN = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_GBN");
					var ENO_NO  = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "ENO_NO");
					var PENO_NO = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NO");
				
					dsT_PM_PROPOSER.DeleteRow(dsT_PM_PROPOSER.RowPosition);
					
					// �Ķ���� �߰�
					trT_PM_PROPOSER.Parameters = "PMT_YY="+PMT_YY+",PMT_GBN="+PMT_GBN+",ENO_NO="+ENO_NO+",PENO_NO="+PENO_NO;
				
					trT_PM_PROPOSER.KeyValue = "tr01(I:dsT_PM_PROPOSER=dsT_PM_PROPOSER)";
					trT_PM_PROPOSER.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=DEL";
					trT_PM_PROPOSER.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        
			//document.form1.txtPMT_YY_SHR.value = next_yy;
			document.form1.txtENO_NO_SHR.value = "";
			document.form1.txtENO_NM_SHR.value = "";
			//document.form1.cmbPMT_GBN_SHR.selectedIndex = 0;
			document.form1.cmbJOB_GBN_SHR.selectedIndex = 0;
            document.getElementById("resultMessage").innerText = ' ';
            	        
        	disableInput();
        	dsT_PM_PROPOSER.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROPOSER.IsUpdated)  {
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
         	if ( !dsT_PM_PROPOSER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        
			cfStyleGrid(form1.grdT_PM_PROPOSER,15,"true","false");      // Grid Style ����
			document.form1.txtPMT_YY_SHR.value = next_yy;
			
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
	  		//document.form1.txtENO_NO.readOnly = false;
 			//document.form1.txtENO_NO.className = ""; 
	  		//document.form1.txtENO_NM.readOnly = false;
 			//document.form1.txtENO_NM.className = ""; 
			document.form1.txtPENO_NO.readOnly = false;
 			document.form1.txtPENO_NO.className = ""; 
			document.form1.txtPENO_NM.readOnly = false;
 			document.form1.txtPENO_NM.className = ""; 
			document.form1.txtPENO_NO2.readOnly = false;
 			document.form1.txtPENO_NO2.className = ""; 
			document.form1.txtPENO_NM2.readOnly = false;
 			document.form1.txtPENO_NM2.className = ""; 
			//document.form1.txtPMT_YY.readOnly = false;
 			//document.form1.txtPMT_YY.className = "";
 			 
  			document.getElementById("ImgPENO_NO").disabled = false;
  			document.getElementById("ImgPENO_NO2").disabled = false;
 			//document.getElementById("imgENO_NO").disabled = false;  // ��������� �Է�
			//document.getElementById("imgPMT_YY").disabled = false; // �����⵵ �Է�
  		}
  		
        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  			document.form1.txtENO_NO.readOnly = true;
	  		document.form1.txtENO_NO.className = "input_ReadOnly"; 
  			document.form1.txtENO_NM.readOnly = true;
	  		document.form1.txtENO_NM.className = "input_ReadOnly"; 
  			document.form1.txtPENO_NO.readOnly = true;
	  		document.form1.txtPENO_NO.className = "input_ReadOnly"; 
  			document.form1.txtPENO_NM.readOnly = true;
	  		document.form1.txtPENO_NM.className = "input_ReadOnly"; 
  			document.form1.txtPENO_NO2.readOnly = true;
	  		document.form1.txtPENO_NO2.className = "input_ReadOnly"; 
  			document.form1.txtPENO_NM2.readOnly = true;
	  		document.form1.txtPENO_NM2.className = "input_ReadOnly"; 
  			document.form1.txtPMT_YY.readOnly = true;
	  		document.form1.txtPMT_YY.className = "input_ReadOnly";
	  		 
  			document.getElementById("ImgPENO_NO").disabled = true;
  			document.getElementById("ImgPENO_NO2").disabled = true;
  			//document.getElementById("imgENO_NO").disabled = true;
  			//document.getElementById("imgPMT_YY").disabled = true;
  		}
  		
  		        
		/********************************************
         * ��� �˻� �� �ʵ尪 ����(extends common.js - �迭�� ���ڷ�)*
         ********************************************/
        function fnc_chkPMT_YY(){
        	
			if( document.form1.txtPMT_YY.value == ""){
				alert("�����⵵�� ���� �Է��ϼ���.");
				document.form1.txtENO_NO.value = "";
	            document.form1.txtENO_NM.value = "";
	            document.form1.txtDPT_NM.value = "";
	            document.form1.txtJOB_NM.value = "";
	            
				return false;
			}
			
			return true;

        }
        
 		/********************************************
         * ���õ� ����� �ش��ϴ� ������� ��ȸ     *
         ********************************************/
        function fnc_SearchInfo(){
			var ENO_NO = document.form1.txtENO_NO.value;
			var PMT_YY = document.form1.txtPMT_YY.value;
			//var PMT_GBN = document.form1.cmbPMT_GBN.value;  // ��������ڸ� ��ȸ
			
			if( ENO_NO == ""){
				return;
			}
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO+"&PMT_YY="+PMT_YY; //+"&PMT_GBN="+PMT_GBN;
			dsVI_T_PERSON.reset();
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
        
        function fnc_chgPENO_NO(){
        
            var OrgPENO_NO = dsT_PM_PROPOSER.OrgNameValue(dsT_PM_PROPOSER.RowPosition,"PENO_NO");
            var PENO_NO = dsT_PM_PROPOSER.NameValue(dsT_PM_PROPOSER.RowPosition,"PENO_NO");
        
            if(OrgPENO_NO != PENO_NO){
	            document.form1.txtPDPT_NM.value = "";
	            document.form1.txtPJOB_NM.value = "";
	        }
            
        }
        
        function fnc_chgPENO_NO2(){
        
            var OrgPENO_NO2 = dsT_PM_PROPOSER.OrgNameValue(dsT_PM_PROPOSER.RowPosition,"PENO_NO2");
            var PENO_NO2 = dsT_PM_PROPOSER.NameValue(dsT_PM_PROPOSER.RowPosition,"PENO_NO2");
        
            if(OrgPENO_NO2 != PENO_NO2){        
	            document.form1.txtPDPT_NM2.value = "";
	            document.form1.txtPJOB_NM2.value = "";
            }
        
        }
        
        /**
         * �������õ�ڰ��� �Ϸ� ó��
         */
        function fnc_Complete() {
            var PMT_YY_SHR  = document.form1.txtPMT_YY_SHR.value;
            
            if(dsT_CP_WORKLOG.CountRow == 1) {
                if(parseInt(dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) > 1) {
                    alert("�̹� �������õ�ڰ��� �Ϸ�ó���� �Ǿ����ϴ�.");
                    return;
                } 
            } else {
                alert("�������õ�ڰ��� �Ϸ�ó���� �� �� �����ϴ�.");
                return;
            }
            
            if(!confirm("�������õ�ڰ��� �Ϸ�ó���� �Ͻðڽ��ϱ�?")){
                return false;
            }
            
            dsT_CP_WORKLOG_SAV.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SAV_COM&PMT_YY_SHR="+PMT_YY_SHR;
            dsT_CP_WORKLOG_SAV.reset();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PROPOSER)			   |
    | 3. ���Ǵ� Table List(T_PM_PROPOSER) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PROPOSER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)             |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                   |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>       
		
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_PROPOSER)		       |
    | 3. ���Ǵ� Table List(T_PM_PROPOSER)			       |
    +------------------------------------------------------>
    <Object ID="trT_PM_PROPOSER_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>
        
	<Object ID="trT_PM_PROPOSER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
 
    
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
			disableInput();
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PROPOSER.CountRow);
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        if(dsT_CP_WORKLOG.CountRow == 1){ // ����
            if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                if(dsT_PM_PROPOSER.countrow == 0){
                    disableInput();
                }else{
                    enableInput();
		          	if(Number(dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "JOB_SEQ")) < 153 || //�븮(30) JOB_SEQ�� 153�̴�.
			           dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "1"){
			            //�����̻��� �����常
			            document.form1.txtPENO_NO.readOnly = true;
			            document.form1.txtPENO_NO.className = "input_ReadOnly"; 
			            document.form1.txtPENO_NM.readOnly = true;
			            document.form1.txtPENO_NM.className = "input_ReadOnly";
			            
			            document.getElementById("ImgPENO_NO").disabled = true;
			            
			        }else{
			            //�븮����
			            document.form1.txtPENO_NO.readOnly = false;
			            document.form1.txtPENO_NO.className = ""; 
			            document.form1.txtPENO_NM.readOnly = false;
			            document.form1.txtPENO_NM.className = "";
			            
			            document.getElementById("ImgPENO_NO").disabled = false;
			                    
			        }
                    
                }
                
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2") {
                disableInput();
                alert("�̹� �������õ�ڰ��� �Ϸ�ó���� �Ǿ����ϴ�.");
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
                disableInput();
                alert("�̹� �������װ��� ó���� �Ǿ����ϴ�.");
            }
        }else{       
            disableInput();
            alert("��������ڼ����� �Ϸ���� �ʾҽ��ϴ�.");
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnLoadCompleted(iCount)">
        alert("�������õ�ڰ��� �Ϸ�ó���� �Ǿ����ϴ�.");
        disableInput();
        dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = "2";
    </Script>    

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("�����Ͻ� ����� ��������ڰ� �ƴմϴ�.");
			document.form1.txtENO_NO.value = "";
			document.form1.txtENO_NM.value = "";
			document.form1.txtDPT_NM.value = "";
			document.form1.txtJOB_NM.value = "";
		} else {
        }
    </Script>
    
	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>    

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>    

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROPOSER event="OnSuccess()">
        fnc_SearchList();//������ ����ȸ�� �ؾ� ���� �Ҽӳ���
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROPOSER event="OnFail()">
        alert(trT_PM_PROPOSER.ErrorMsg);
    </script>
    
	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_PM_PROPOSER event=OnRowPosChanged(row)>

        if(Number(dsT_PM_PROPOSER.nameValue(row, "JOB_SEQ")) < 153 || //�븮(30) JOB_SEQ�� 153�̴�.
           dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "1"){
            //�����̻��� �����常
            document.form1.txtPENO_NO.readOnly = true;
            document.form1.txtPENO_NO.className = "input_ReadOnly"; 
            document.form1.txtPENO_NM.readOnly = true;
            document.form1.txtPENO_NM.className = "input_ReadOnly";
            
            document.getElementById("ImgPENO_NO").disabled = true;
            
        }else{
            //�븮����
            document.form1.txtPENO_NO.readOnly = false;
            document.form1.txtPENO_NO.className = ""; 
            document.form1.txtPENO_NM.readOnly = false;
            document.form1.txtPENO_NM.className = "";
            
            document.getElementById("ImgPENO_NO").disabled = false;
                    
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������õ�ڰ���</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">�������õ�ڰ���</font></td>
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
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a> -->
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>				
	            <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a> -->
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
							<col width="70"></col>
							<col width="0"></col>
							<col width="0"></col>
							<col width="70"></col>
							<col width="110"></col>
							<col width="70"></col>
							<col width=""></col>
						</colgroup>
						<tr>
						<td align="right" class="searchState">�����⵵&nbsp;</td>
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
                            <td class="searchState" align="right"><!-- �������� -->&nbsp;</td>
                            <td class="padding2423" align="left">
                                <!-- 
                                <select id="cmbPMT_GBN_SHR" style="width='80';" onChange="fnc_SearchList()">
                                    <option value="0">���</option>
                                    <option value="1">����</option>
                                    <option value="2">Ư��</option>
                                </select>
                                 -->
                            </td>
                            <td class="searchState" align="right">��������&nbsp;</td>
                            <td class="padding2423" align="left">
                                <select id="cmbJOB_GBN_SHR" style="width='80';" onChange="fnc_SearchList()">
                                    <option value="0">���</option>
                                    <option value="1">�����̻�</option>
                                    <option value="2">�븮����</option>
                                </select>
                            </td>
							<td align="right" class="searchState">���&nbsp;</td>
							<td class="padding2423" align="left">
                                <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','', '', '', '');"></a>
                                <input type="hidden" id="hidEMPL_DPT_CD">
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
					<col width="55"></col>
					<col width="40"></col>
					<col width="70"></col>
					<col width="165"></col>
					<col width="65"></col>
					<col width="105"></col>
					<col width="65"></col>
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="creamBold">�����⵵</td>
                    <td class="padding2423">
                        <input type="text" id="txtPMT_YY" style="ime-mode:disabled" size="5" class="input_ReadOnly" readonly maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YY','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YY" name="imgPMT_YY" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YY','','348','157');"></a> -->
                    </td>
				
					<td align="center" class="creamBold">���������</td>
					<td class="padding2423" align="left">
                        <input id="txtENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_SearchInfo();}" onchange="fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();" onkeyup="fnc_chkPMT_YY();">
                        <input id="txtENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_SearchInfo();}" onchange="fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();" onkeyup="fnc_chkPMT_YY();">
                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="var rtn=fnc_chkPMT_YY();if(rtn == false){return false;};fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();"></a> -->
					</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423"><input id="txtJOB_NM" size="8" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">��������</td>
                    <td class="padding2423"><input id="txtFJOB_NM" size="8" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold" colspan="2">1�� ��õ��</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left">
                        <input id="txtPENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNm('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();">
                        <input id="txtPENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNo('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPENO_NO" name="ImgPENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();"></a>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423"><input id="txtPDPT_NM" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="3"><input id="txtPJOB_NM" size="8" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold" colspan="2">2�� ��õ��</td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" align="left">
                        <input id="txtPENO_NO2" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNm('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();">
                        <input id="txtPENO_NM2" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNo('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPENO_NO2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPENO_NO2" name="ImgPENO_NO2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();"></a>
					</td>
                    <td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
                    <td class="padding2423"><input id="txtPDPT_NM2" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">��&nbsp;&nbsp;��</td>
					<td class="padding2423" colspan="3"><input id="txtPJOB_NM2" size="8" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->
		
	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td class="searchState" align="right">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgInputcomplete','','/images/button/btn_InputcompleteOver.gif',1)">  <img src="/images/button/btn_InputcompleteOn.gif"   name="imgInputcomplete" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Complete()"></a>
                        </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->
	
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_PM_PROPOSER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" value="dsT_PM_PROPOSER">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"     width=29    name="NO"         align=center    value={String(Currow)} </C>
							<C> id="PMT_YY"      width=40    name="����;�⵵"  align=center    Edit=none   </C>
							<C> id="DPT_NM"      width=100   name="�Ҽ�"       align=center    Edit=none   </C>
                            <C> id="JOB_NM"      width=50    name="����"       align=center    Edit=none   </C>
							<C> id="ENO_NO"      width=70    name="���"       align=center    Edit=none   </C>
							<C> id="ENO_NM"      width=70    name="����"       align=center    Edit=none   </C>
							<G> name="1�� ��õ��" HeadBgColor="#F7DCBB"
	                            <C> id="PDPT_NM"    width=100   name="�Ҽ�"     align=center    Edit=none    </C>
								<C> id="PJOB_NM"	width=50	name="����"		align=center	Edit=none    </C>
	                            <C> id="PENO_NO"    width=70    name="���"     align=center    Edit=none    </C>							
								<C> id="PENO_NM"	width=70	name="����"		align=center	Edit=none    </C>
							</G>
							<G> name="2�� ��õ��" HeadBgColor="#F7DCBB"
	                            <C> id="PDPT_NM2"   width=100   name="�Ҽ�"     align=center    Edit=none    </C>
								<C> id="PJOB_NM2"	width=50	name="����"		align=center	Edit=none    </C>
	                            <C> id="PENO_NO2"   width=70    name="���"     align=center    Edit=none    </C>							
								<C> id="PENO_NM2"	width=70	name="����"		align=center	Edit=none    </C>
							</G>
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

	<!-- T_PM_PROPOSER ���� ���̺� -->
	<object id="bndT_PM_PROPOSER" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PROPOSER">
		<Param Name="BindInfo", Value="
			<C>Col=PMT_YY		Ctrl=txtPMT_YY		Param=value</C>
			<C>Col=PMT_GBN		Ctrl=txtPMT_GBN		Param=value</C>
			<C>Col=ENO_NO		Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM		Ctrl=txtENO_NM		Param=value</C>
            <C>Col=DPT_NM       Ctrl=txtDPT_NM      Param=value</C>
            <C>Col=JOB_NM       Ctrl=txtJOB_NM      Param=value</C>
            <C>Col=FJOB_NM      Ctrl=txtFJOB_NM     Param=value</C>
                        			
			<C>Col=PENO_NO		Ctrl=txtPENO_NO		Param=value</C>
			<C>Col=PENO_NM		Ctrl=txtPENO_NM		Param=value</C>
			<C>Col=PDPT_NM		Ctrl=txtPDPT_NM		Param=value</C>
			<C>Col=PJOB_NM      Ctrl=txtPJOB_NM     Param=value</C>

			<C>Col=PENO_NO2		Ctrl=txtPENO_NO2	Param=value</C>
			<C>Col=PENO_NM2		Ctrl=txtPENO_NM2	Param=value</C>
			<C>Col=PDPT_NM2		Ctrl=txtPDPT_NM2	Param=value</C>
			<C>Col=PJOB_NM2     Ctrl=txtPJOB_NM2    Param=value</C>
		">
	</object>