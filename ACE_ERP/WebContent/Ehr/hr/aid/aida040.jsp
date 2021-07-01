	<!--*************************************************************************
	* @source      : aida040.jsp												*
	* @description : ������� ��ΰ��� PAGE 										*
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2006/12/13            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
	<title>������� ��ΰ���(aida040)</title>
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

		var year = getToday().substring(0,4);
		var btnList = 'TTTTFFTT';
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//������� ��� ��ȸ
			var FIN_YMD_STDT_SHR = document.getElementById("txtFIN_YMD_STDT_SHR").value;
			var FIN_YMD_ENDT_SHR = document.getElementById("txtFIN_YMD_ENDT_SHR").value;
			
			dsT_AD_AIDBOOK.dataid = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SHR&FIN_YMD_STDT_SHR="+FIN_YMD_STDT_SHR+"&FIN_YMD_ENDT_SHR="+FIN_YMD_ENDT_SHR;
			dsT_AD_AIDBOOK.reset();
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
			trT_AD_AIDBOOK.KeyValue = "tr01(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
			trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SAV";
			trT_AD_AIDBOOK.post();
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
            if (dsT_AD_AIDBOOK.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_AD_AIDBOOK.GridToExcel("������� ��ΰ���", '', 225);
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_AD_AIDBOOK.CountColumn == 0) {
				dsT_AD_AIDBOOK.setDataHeader("FIN_YMD:STRING, FIN_SEQ:STRING, CD_GBN:STRING, CD_TAG:STRING, FIN_RSN:STRING, FIN_IN:INT, FIN_OUT:INT, FIN_AMT:INT");
			}
			
			// �� �߰�
			dsT_AD_AIDBOOK.AddRow();
            
            //���� �ʱ�ȭ
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_YMD")    = getToday();
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN")     = "3";          //��������� ����,������ �����Ǿ� ���� '3' ��������
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG")     = "U";          //����� �Է�
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
	        if ( dsT_AD_AIDBOOK.CountRow < 1 ) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
            }else{
                var CD_GBN = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN");
                var CD_TAG = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG");
                var fin_nm;
                if(CD_TAG != 'U') {
                    alert("�ش� �����ʹ� ������ �� �����ϴ�.");
                    return;
                }
                
                if(CD_GBN == '1') fin_nm = "����";
                else if(CD_GBN == '2') fin_nm = "����";
                else if(CD_GBN == '3') fin_nm = "����";
            
            	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
            	tmpMSG += "��¥ = "+dsT_AD_AIDBOOK.nameValue(dsT_AD_AIDBOOK.RowPosition, "FIN_YMD")+"\n";
            	tmpMSG += "SEQ = "+dsT_AD_AIDBOOK.nameValue(dsT_AD_AIDBOOK.RowPosition, "FIN_SEQ")+"\n";
                tmpMSG += fin_nm+" = "+document.getElementById("medFIN_INOUT").Text+"\n";
            	
				if(!confirm(tmpMSG) ){
                    return;
				}
                
                dsT_AD_AIDBOOK.DeleteRow(dsT_AD_AIDBOOK.RowPosition);
                
                trT_AD_AIDBOOK.KeyValue = "tr01(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
                trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=DEL";
                trT_AD_AIDBOOK.post();
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
	        document.medFIN_INOUT.Text = "";
	        document.form1.cmbCD_GBN.selectedIndex = 0;
	        document.getElementById("resultMessage").innerText = ' ';
	        
        	fnc_DisableElementAll(elementList);
        	dsT_AD_AIDBOOK.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_AD_AIDBOOK.IsUpdated)  {
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
        	if (!dsT_AD_AIDBOOK.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}

			trT_AD_AIDBOOK.KeyValue = "tr04(I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)";
			trT_AD_AIDBOOK.action = "/servlet/GauceChannelSVL?cmd=hr.aid.a.aida040.cmd.AIDA040CMD&S_MODE=SAV";
			trT_AD_AIDBOOK.post();	
        }
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
            document.getElementById("txtFIN_YMD_STDT_SHR").value = getStrDate();
            document.getElementById("txtFIN_YMD_ENDT_SHR").value = getEndDate();
        
			cfStyleGrid(form1.grdT_AD_AIDBOOK,15,"true","false");      // Grid Style ����
			fnc_DisableElementAll(elementList);
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}
        
        
        //�Է�â �̸���
        var elementList = new Array(    "txtFIN_YMD"
                                       ,"imgFIN_YMD"
                                       ,"cmbCD_GBN"
                                       ,"txtFIN_RSN"
                                       ,"medFIN_INOUT" );
                                       
        //������ �Է�â��
        var exceptionList = new Array(  "txtFIN_YMD"
                                       ,"imgFIN_YMD" );
  
        /**
         * �Էµ� �ݾ��� EMEdit Component �� ���ε� ��Ų��.
         */
        function bindFIN_INOUT() {
            var CD_GBN      = document.getElementById("cmbCD_GBN").value;
            var FIN_IN_OUT  = document.getElementById("medFIN_INOUT").Text;
            
            //�ش� row�� �ݾ� ���� ���� ���� ���ε�
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_IN") = "";
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_OUT") = "";
            
            if(CD_GBN == "2") {
                // ���� -> ���� �� ����� ���ε� ���� ����
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_OUT      Ctrl=medFIN_INOUT   Param=text  </C>"
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>"
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>"
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
                                         
                dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_OUT") = FIN_IN_OUT;
            } else {
                // ���� -> ���� ���� ����� ���ε� ���� ����
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_IN       Ctrl=medFIN_INOUT   Param=text  </C>" 
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>" 
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>" 
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
                                         
                dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "FIN_IN") = FIN_IN_OUT;
            }
            dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN") = CD_GBN;

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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDBOOK)			   |
    | 3. ���Ǵ� Table List(T_AD_AIDBOOK) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDBOOK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDBOOK)			   |
    | 3. ���Ǵ� Table List(T_AD_AIDBOOK)				   |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDBOOK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK,I:dsT_AD_AIDBOOK=dsT_AD_AIDBOOK)">
	</Object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDBOOK.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDBOOK Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDBOOK event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		//���� �� �ܾ��� ����ǹǷ� ����ȸ ��Ŵ
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDBOOK event="OnFail()">
        alert(trT_AD_AIDBOOK.ErrorMsg);
    </script>
    
	<!-----------------------------------------------------+
    | Grid Ŭ���� ����/���⿡ ���� ���ε� ���� 					   |
    +------------------------------------------------------>     
	<script language=JavaScript for=dsT_AD_AIDBOOK event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        
        if(row > 0) {
            var CD_GBN = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_GBN");
            var CD_TAG = dsT_AD_AIDBOOK.NameString(dsT_AD_AIDBOOK.RowPosition, "CD_TAG");
            

            
            //�ű��� ���        
            if(dsT_AD_AIDBOOK.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else if(CD_TAG == 'U'){
                fnc_EnableElementAll(elementList, exceptionList);
            }
            
            //������ ������� ���� ������� ��ο��� ����, ������ �����Ǿ� ����
            fnc_ChangeStateElement(false, "cmbCD_GBN");
        
            //�ݾ��� ���ε� ��Ų��.
            if(CD_GBN == "2") {
                // ���� -> ���� �� ����� ���ε� ���� ����
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_OUT      Ctrl=medFIN_INOUT   Param=text  </C>"
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>"
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>"
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
            } else {
                // ���� -> ���� ���� ����� ���ε� ���� ����
                bndT_AD_AIDBOOK.BindInfo = "<C>Col=FIN_IN       Ctrl=medFIN_INOUT   Param=text  </C>" 
                                         + "<C>Col=FIN_YMD      Ctrl=txtFIN_YMD     Param=value </C>" 
                                         + "<C>Col=CD_GBN       Ctrl=cmbCD_GBN      Param=value </C>" 
                                         + "<C>Col=FIN_RSN      Ctrl=txtFIN_RSN     Param=value </C>";
            }
            
        }
	</script>
	
	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_AD_AIDBOOK event=CanRowPosChange(row)>
        if(row > 0) {
    		if ( dsT_AD_AIDBOOK.NameValue(row, "FIN_YMD") == '' ) {
    			alert("[ " + grdT_AD_AIDBOOK.GetHdrDispName('-3','FIN_YMD')+" ] �� �Է��Ͻʽÿ�.");
    			return false;
    		}else if( dsT_AD_AIDBOOK.NameValue(row, "CD_GBN") == '' ){
    			alert("[ " + grdT_AD_AIDBOOK.GetHdrDispName('-3','CD_GBN')+" ] �� �Է��Ͻʽÿ�.");
    			return false;
    		}else if( (dsT_AD_AIDBOOK.NameValue(row,"FIN_IN") == 0 && dsT_AD_AIDBOOK.NameValue(row,"FIN_OUT") == 0) ){
    			alert("�ݾ��� �Է��Ͻʽÿ�.");
    			return false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������� ��ΰ���</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�������/<font color="#000000">������� ��ΰ���</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>                
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
                            <col width="60"></col>
                            <col width="560"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">��ȸ�Ⱓ</td>
                            <td class="padding2423" align="left">
                                <input type="text" id="txtFIN_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIN_YMD_STDT_SHR','','107','143');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
                                 ~ 
                                <input type="text" id="txtFIN_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','/images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtFIN_YMD_ENDT_SHR','','222','143');"><img src="/images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
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
			<table width="100%" height="30" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="60"></col>
					<col width="110"></col>
					<col width="60"></col>
					<col width="80"></col>
					<col width="60"></col>
					<col width="180"></col>
					<col width="60"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">��¥</td>
					<td class="padding2423">
						<input type="text" id="txtFIN_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgFIN_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgFIN_YMD" name="imgFIN_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtFIN_YMD','','95','98');"></a>
					</td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
						<select id="cmbCD_GBN" style="WIDTH:60px" onChange="bindFIN_INOUT()">
							<option value="1">����</option>
							<option value="2">����</option>
							<option value="3">����</option>
						</select>
					</td>
					<td align="center" class="creamBold">����</td>
					<td class="padding2423">
						<input type="text" id="txtFIN_RSN" size="30" maxlength="30">
					</td>
					<td align="center" class="creamBold">�ݾ�</td>
					<td>
						<table width="100%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medFIN_INOUT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
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
	
	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AD_AIDBOOK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_AD_AIDBOOK">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=60	name="����"	align=center	value={String(Currow)}</C>
							<C> id="FIN_YMD"	width=90	name="��¥"	align=center	Edit=none</C>
							<C> id="FIN_SEQ"	width=55	name="SEQ"	align=center	Edit=none</C>
							<C> id="CD_GBN"	    width=40	name="����"	align=center	Edit=none    value={decode(CD_GBN, "1", "����", "2", "����", "3", "����")}</C>
							<C> id="FIN_RSN"	width=190	name="����"	align=center	Edit=none</C>
							<C> id="FIN_IN"		width=110	name="����"	align=right		Edit=none	RightMargin=10</C>
							<C> id="FIN_OUT"	width=110	name="����"	align=right 	Edit=none	RightMargin=10</C>
							<C> id="FIN_AMT"	width=110	name="�ܾ�"	align=right		Edit=none	RightMargin=10</C>
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

	<!-- T_AD_AIDBOOK ���� ���̺� -->
	<object id="bndT_AD_AIDBOOK" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDBOOK">
		<Param Name="BindInfo", Value="
			
		">
	</object>
