	<!--*************************************************************************
	* @source      : proa020.jsp												*
	* @description : ������������ PAGE	 								  		*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/29            ä����            	�����ۼ�						*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>������������(proa020)</title>
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

		var btnList = 'TTTTFFTT';
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	if( document.form1.txtPMT_YMD_SHR.value=="" ){
        		alert("�����⵵�� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	if( document.form1.txtPMT_YMD_SHR.value.length != 4 ){
        		alert("�����⵵�� �ٸ��� �Է��Ͻʽÿ�. ��)"+next_yy);
        		return;
        	}
        	
			var PMT_YMD_SHR = document.form1.txtPMT_YMD_SHR.value;
			var OCC_CD_SHR  = document.form1.cmbOCC_CD_SHR.value;
			var JOB_CD_SHR  = document.form1.txtJOB_CD_SHR.value;
			
			dsT_PM_PMTALLOT.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=SHR&PMT_YMD_SHR="+PMT_YMD_SHR+"&OCC_CD_SHR="+OCC_CD_SHR+"&JOB_CD_SHR="+JOB_CD_SHR;
			dsT_PM_PMTALLOT.reset();
			
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
			trT_PM_PMTALLOT.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=SAV";
			trT_PM_PMTALLOT.post();
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
			if (dsT_PM_PMTALLOT.CountColumn == 0) {
				dsT_PM_PMTALLOT.setDataHeader("OCC_CD:STRING, PJOB_CD:STRING, PJOB_NM:STRING, STR_YMD:STRING, END_YMD:STRING, FJOB_CD:STRING, FJOB_NM:STRING, GOG_PNT:STRING, JPT_PNT:STRING, EDU_PNT:STRING, GUN_PNT:STRING, CEN_PNT:STRING, SUM_PNT:STRING, SAN_PNT:STRING");
			}

            enableInput();            
			dsT_PM_PMTALLOT.AddRow();
			document.form1.cmbOCC_CD.selectedIndex = 0;
			document.form1.cmbOCC_CD.focus();
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
	        if (dsT_PM_PMTALLOT.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "�ٷα���        = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "OCC_NM")+"\n";
            	tmpMSG += "������     = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "PJOB_NM")+"\n";
            	tmpMSG += "�������� = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "FJOB_NM")+"\n";
            	tmpMSG += "������    = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "STR_YMD")+"\n";
            	tmpMSG += "������    = "+dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "END_YMD");
            	
	            if( confirm(tmpMSG) ){
					var OCC_CD  = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "OCC_CD");
					var PJOB_CD = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "PJOB_CD");
					var STR_YMD = dsT_PM_PMTALLOT.nameValue(dsT_PM_PMTALLOT.RowPosition, "STR_YMD");
				
					dsT_PM_PMTALLOT.DeleteRow(dsT_PM_PMTALLOT.RowPosition);
					// �Ķ���� �߰�
					trT_PM_PMTALLOT.Parameters = "OCC_CD="+OCC_CD+",PJOB_CD="+PJOB_CD+",STR_YMD="+STR_YMD;
				
					trT_PM_PMTALLOT.KeyValue = "tr02(I:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT)";
					trT_PM_PMTALLOT.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa020.cmd.PROA020CMD&S_MODE=DEL";
					trT_PM_PMTALLOT.post();
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
  			
			document.form1.cmbOCC_CD_SHR.selectedIndex  = 0;
			
        	disableInput();
        	
        	document.getElementById("resultMessage").innerText = ' ';
        	//document.form1.txtPMT_YMD_SHR.value = next_yy;
        	dsT_PM_PMTALLOT.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PMTALLOT.IsUpdated)  {
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
         	if (!dsT_PM_PMTALLOT.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			
			return true;
        }
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        
            // �ٷα��� ���� �˻� �޺��ڽ� ����(�˻�)
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD_SHR").add(oOption);
			}
			
            // �ٷα��� ���� �˻� �޺��ڽ� ����(�Է�)
			for( var i = 1; i <= dsT_CM_COMMON_A1.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_A1.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_A1.NameValue(i,"CODE_NAME");
				document.getElementById("cmbOCC_CD").add(oOption);
			}
			
			disableInput();
			document.form1.txtPMT_YMD_SHR.value = next_yy;
			cfStyleGrid(form1.grdT_PM_PMTALLOT,15,"true","false");      // Grid Style ����
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
  		  	for(var i=5; i<19; i++){
  		  		if( i== 5 ) continue; // �������ڵ�
  		  		if( i== 6 ) continue; // ��������
  		  		if( i== 8 ) continue; // ����������
  		  		if( i== 9 ) continue; // ������
  		  		if( i== 16 ) continue; // ����
  		  		
				document.form1.elements[i].readOnly = false;
	 			document.form1.elements[i].className = ""; 
  			}
  			//document.getElementById("cmbOCC_CD").disabled   = false;
  			//document.getElementById("img_HelpOn2").disabled = false;  // ������ �˻�
  			document.getElementById("img_HelpOn3").disabled = false;  // �������� �˻�
  			//document.getElementById("imgSTR_YMD").disabled  = false;  // ������
  			document.getElementById("imgEND_YMD").disabled  = false;  // ������
  		}
  		
        /********************************************
         * �Է��ʵ� ��� �Ұ����ϰ�(Disable)         		*
         ********************************************/
  		function disableInput(){
  		  	for(var i=5; i<19; i++){
				document.form1.elements[i].readOnly = true;
	 			document.form1.elements[i].className = "input_ReadOnly"; 
  			}
  			document.getElementById("cmbOCC_CD").disabled   = true;
  			document.getElementById("img_HelpOn2").disabled = true;  // ������ �˻�
  			document.getElementById("img_HelpOn3").disabled = true;  // �������� �˻�
  			document.getElementById("imgSTR_YMD").disabled  = true;  // ������
  			document.getElementById("imgEND_YMD").disabled  = true;  // ������
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
         * �������ڿ��� ��Ŀ�� ������ ��û���ڿ� ��       		*
         ********************************************/       
		function cfCheckDateTermPROA020(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�������ڰ� �������ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
			}
		}
		
  		/********************************************
         * ���հ� ���	                       			*
         ********************************************/
        function setTotal() {
        	var GOG_PNT = document.form1.txtGOG_PNT.value;
        	var JPT_PNT = document.form1.txtJPT_PNT.value;
        	var EDU_PNT = document.form1.txtEDU_PNT.value;
        	var GUN_PNT = document.form1.txtGUN_PNT.value;
        	var CEN_PNT = document.form1.txtCEN_PNT.value;
        	
        	if(GOG_PNT=="") GOG_PNT = "0";
        	if(JPT_PNT=="") JPT_PNT = "0";
        	if(EDU_PNT=="") EDU_PNT = "0";
        	if(GUN_PNT=="") GUN_PNT = "0";
        	if(CEN_PNT=="") CEN_PNT = "0";
        	
        	if(GOG_PNT != "" && JPT_PNT != "" && EDU_PNT != "" && GUN_PNT != "" && CEN_PNT != ""){
	        	document.form1.txtSUM_PNT.value = eval(GOG_PNT+"+"+JPT_PNT+"+"+EDU_PNT+"+"+GUN_PNT+"+"+CEN_PNT);
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_PM_PMTALLOT)			   |
    | 3. ���Ǵ� Table List(T_PM_PMTALLOT) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PMTALLOT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_PM_PMTALLOT)			   |
    | 3. ���Ǵ� Table List(T_PM_PMTALLOT)				   |
    +------------------------------------------------------>
	<Object ID="trT_PM_PMTALLOT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT,I:dsT_PM_PMTALLOT=dsT_PM_PMTALLOT)">
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
	<Script For=dsT_PM_PMTALLOT Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PMTALLOT.CountRow);
			enableInput();
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PMTALLOT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PMTALLOT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PMTALLOT event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PMTALLOT event="OnFail()">
        alert(trT_PM_PMTALLOT.ErrorMsg);
    </script>
     
	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_PM_PMTALLOT event=CanRowPosChange(row)>
		if ( dsT_PM_PMTALLOT.NameValue(row,"OCC_CD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','OCC_CD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_PM_PMTALLOT.NameValue(row,"PJOB_CD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','PJOB_CD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if ( dsT_PM_PMTALLOT.NameValue(row,"STR_YMD") == "" ) {
			alert("[ " + grdT_PM_PMTALLOT.GetHdrDispName('-3','STR_YMD') + " ]�� �ʼ� �Է»����Դϴ�");
			return false;
		}
		if( document.form1.txtSUM_PNT.value != "100" ){
			alert("������ 100���� �ƴմϴ�.");
			return false;
		}
		
	</script>
	
	
<script language=JavaScript for=dsT_PM_PMTALLOT event=OnRowPosChanged(row)>

        if(dsT_PM_PMTALLOT.SysStatus(row) == "1"){
            document.getElementById("txtPJOB_CD").readOnly = false;//�������ڵ�
            document.getElementById("txtPJOB_CD").className = "";  //�������ڵ�
            document.getElementById("txtSTR_YMD").readOnly = false;//������
            document.getElementById("txtSTR_YMD").className = "";//������
                            
            document.getElementById("cmbOCC_CD").disabled   = false;
            document.getElementById("img_HelpOn2").disabled = false;  // ������ �˻�
            document.getElementById("imgSTR_YMD").disabled  = false;  // ������
            
        }else{
            document.getElementById("txtPJOB_CD").readOnly = true;//�������ڵ�
            document.getElementById("txtPJOB_CD").className = "input_ReadOnly";  //�������ڵ�
            document.getElementById("txtSTR_YMD").readOnly = true;//������
            document.getElementById("txtSTR_YMD").className = "input_ReadOnly";//������
                            
            document.getElementById("cmbOCC_CD").disabled   = true;
            document.getElementById("img_HelpOn2").disabled = true;  // ������ �˻�
            document.getElementById("imgSTR_YMD").disabled  = true;  // ������
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������������</td>
					<td align="right" class="navigator">HOME/�λ����/����/<font color="#000000">������������</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
					<col width="100"></col>
					<col width="100"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�����⵵&nbsp;</td>
					<td class="padding2423" align="left">
	                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
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
					<td class="searchState" align="right">�ٷα���&nbsp;</td>
					<td class="padding2423" align="left">
						<select id="cmbOCC_CD_SHR" style="width:80;">
							<option value="0">���</option>
						</select>
					</td>
					<td class="searchState" align="right">����&nbsp;</td>
					<td class="padding2423" align="left">
					    <input id=txtJOB_CD_SHR size="3" maxlength="3" onkeypress="javascript:if(event.keyCode==13) fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');" onChange="fnc_GetCommNm('A2','txtJOB_CD_SHR','txtJOB_NM_SHR');">
						<input id=txtJOB_NM_SHR size="10" class="input_ReadOnly"  readOnly>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn1','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn1" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtJOB_CD_SHR','txtJOB_NM_SHR','����','A2')"></a>
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
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="85"></col>
			<col width="60"></col>
			<col width="85"></col>
			<col width="60"></col>
			<col width=""></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">�ٷα���</td>
			<td class="padding2423">
				<select id="cmbOCC_CD" style="width:80;"></select>
			</td>
			<td align="center" class="creamBold">������</td>
			<td class="padding2423" colspan="3">
			    <input id="txtPJOB_CD" name="txtPJOB_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A2', 'txtPJOB_CD','txtPJOB_NM')">
				<input type="text" id="txtPJOB_NM" size="10" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtPJOB_CD','txtPJOB_NM','����','A2')"></a>
			</td>
			<td align="center" class="creamBold">��������</td>
			<td class="padding2423" colspan="3">
			    <input id="txtFJOB_CD" name="txtFJOB_CD" size="3" maxlength="2" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A2', 'txtFJOB_CD','txtFJOB_NM')">
				<input type="text" id="txtFJOB_NM" size="10" class="input_ReadOnly"  readOnly>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_HelpOn3','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="img_HelpOn3" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commonCodePopup('txtFJOB_CD','txtFJOB_NM','����','A2')"></a>
			</td>
		</tr>
		<tr>
            <td align="center" class="creamBold">������</td>
            <td class="padding2423">
                <input type="text" id="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA020('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSTR_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgSTR_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtSTR_YMD','','30','176');"></a>
            </td>
            <td align="center" class="creamBold">������</td>
            <td class="padding2423">
                <input type="text" id="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);cfCheckDateTermPROA020('txtEND_YMD', 'txtSTR_YMD', 'txtEND_YMD');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgEND_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgEND_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtEND_YMD','','200','176');"></a>
            </td>
			<td align="center" class="creamBold">�λ���</td>
			<td class="padding2423"><input id="txtGOG_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">�ټӱⰣ</td>
			<td class="padding2423"><input id="txtJPT_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtEDU_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
		</tr>
		<tr>
            <td align="center" class="creamBold">����</td>
            <td class="padding2423"><input id="txtGUN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
            <td align="center" class="creamBold">��õ</td>
            <td class="padding2423"><input id="txtCEN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
			<td align="center" class="creamBold">����</td>
			<td class="padding2423"><input id="txtSUM_PNT" size="8" maxlength="3" style="text-align:right"></td>
			<td align="center" class="creamBold">���</td>
			<td class="padding2423"><input id="txtSAN_PNT" size="8" maxlength="3" onblur="setTotal();" onchange="setTotal();" style="text-align:right"></td>
            <td align="center" class="creamBold">�������</td>
            <td class="padding2423"><input id="txtBAS_YY" size="8" maxlength="3" style="text-align:right"></td>
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
					<object id="grdT_PM_PMTALLOT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
						<param name="DataID" value="dsT_PM_PMTALLOT">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=34	name="NO"		align=center	value={String(Currow)}      </C>
							<C> id="OCC_CD"			width=50	name="�ٷα���"		align=center	Edit=none	 EditStyle=Lookup  Data="dsT_CM_COMMON_A1:CODE:CODE_NAME" </C>
							<C> id="PJOB_CD"		width=50	name="������"	align=center	Edit=none	 show="false"   </C>
							<C> id="PJOB_NM"		width=50	name="������"	align=center	Edit=none	                </C>
							<C> id="FJOB_CD"		width=50	name="��������"	align=center	Edit=none	 show="false"   </C>
							<C> id="FJOB_NM"		width=50	name="��������"	align=center	Edit=none	                </C>
							<C> id="STR_YMD"		width=70	name="������"	align=center	Edit=none                   </C>
							<C> id="END_YMD"		width=70	name="������"	align=center	Edit=none                   </C>
							<C> id="GOG_PNT"		width=55	name="�λ���"	align=right		Edit=none	             	</C>
							<C> id="JPT_PNT"		width=55	name="�ټӱⰣ"	align=right		Edit=none	             	</C>
							<C> id="EDU_PNT"		width=55	name="����"		align=right		Edit=none	             	</C>
							<C> id="GUN_PNT"		width=55	name="����"		align=right		Edit=none	             	</C>
							<C> id="CEN_PNT"		width=55	name="��õ"		align=right		Edit=none	             	</C>
							<C> id="SUM_PNT"		width=55	name="�Ѱ�"		align=right		Edit=none	             	</C>
							<C> id="SAN_PNT"		width=55	name="���(��)"	align=right		Edit=none	 	            </C>
							<C> id="BAS_YY" 		width=55	name="���س��"	align=right		Edit=none	 	            </C>
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

	<!-- T_PM_PMTALLOT ���� ���̺� -->
	<object id="bndT_PM_PMTALLOT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_PM_PMTALLOT">
		<Param Name="BindInfo", Value="
			<C>Col=OCC_CD		Ctrl=cmbOCC_CD		Param=value</C>
			<C>Col=PJOB_CD		Ctrl=txtPJOB_CD		Param=value</C>
			<C>Col=PJOB_NM		Ctrl=txtPJOB_NM		Param=value</C>
			<C>Col=FJOB_CD		Ctrl=txtFJOB_CD		Param=value</C>
			<C>Col=FJOB_NM		Ctrl=txtFJOB_NM		Param=value</C>
			<C>Col=STR_YMD		Ctrl=txtSTR_YMD		Param=value</C>
			<C>Col=END_YMD		Ctrl=txtEND_YMD		Param=value</C>
			<C>Col=GOG_PNT		Ctrl=txtGOG_PNT		Param=value</C>
			<C>Col=JPT_PNT		Ctrl=txtJPT_PNT		Param=value</C>
			<C>Col=EDU_PNT		Ctrl=txtEDU_PNT		Param=value</C>
			<C>Col=GUN_PNT		Ctrl=txtGUN_PNT		Param=value</C>
			<C>Col=CEN_PNT		Ctrl=txtCEN_PNT		Param=value</C>
			<C>Col=SUM_PNT		Ctrl=txtSUM_PNT		Param=value</C>
			<C>Col=SAN_PNT		Ctrl=txtSAN_PNT		Param=value</C>
			<C>Col=BAS_YY 		Ctrl=txtBAS_YY		Param=value</C>
		">
	</object>