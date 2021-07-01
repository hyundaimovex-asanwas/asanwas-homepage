	<!--*************************************************************************
	* @source      : insb050.jsp												*
	* @description : �ǰ��������̺����� PAGE 									    *
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/06            ä����          	        �����ۼ�									    *
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>�ǰ��������̺�����(insb050)</title>
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

		var btnList = 'TFTTTFTT';
        var isAddNew = false;
        var isConduct = false;
		
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			var APY_YMD = document.form1.txtAPY_YMD_SHR.value;
			
			dsT_IS_GRADETABLE.dataid = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa010.cmd.INSA010CMD&S_MODE=SHR&APY_YMD="+APY_YMD+"&GBN_TAG=I";
			dsT_IS_GRADETABLE.reset();
			
            isAddNew = false;
            isConduct = false;
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
            //�ű��� ��� 
            var type;
            if(isAddNew) {
                type= "INS";
            }

			trT_IS_GRADETABLE.KeyValue = "tr01(I:dsT_IS_GRADETABLE=dsT_IS_GRADETABLE)";
			trT_IS_GRADETABLE.action = "/servlet/GauceChannelSVL?cmd=hr.ins.a.insa010.cmd.INSA010CMD&S_MODE=SAV&TYPE="+type+"&GBN_TAG=I";
			trT_IS_GRADETABLE.post();
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
          if (dsT_IS_GRADETABLE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            
            form1.grdT_IS_GRADETABLE.GridToExcel("�ǰ��������̺�����", '', 225)
        }
        
        //�ҵ����
        var maft_amtList = new Array(    "0"
                                        ,"300000"
                                        ,"350000"
                                        ,"400000"
                                        ,"450000"
                                        ,"500000"
                                        ,"550000"
                                        ,"600000"
                                        ,"650000"
                                        ,"700000"
                                        ,"750000"
                                        ,"850000"
                                        ,"950000"
                                        ,"1050000"
                                        ,"1150000"
                                        ,"1250000"
                                        ,"1350000"
                                        ,"1450000"
                                        ,"1550000"
                                        ,"1650000"
                                        ,"1750000"
                                        ,"1900000"
                                        ,"2050000"
                                        ,"2200000"
                                        ,"2350000"
                                        ,"2500000"
                                        ,"2650000"
                                        ,"2800000"
                                        ,"2950000"
                                        ,"3100000"
                                        ,"3250000"
                                        ,"3450000"
                                        ,"3650000"
                                        ,"3850000"
                                        ,"4050000"
                                        ,"4250000"
                                        ,"4450000"
                                        ,"4650000"
                                        ,"4850000"
                                        ,"5050000"
                                        ,"5250000"
                                        ,"5500000"
                                        ,"5750000"
                                        ,"6000000"
                                        ,"6250000"
                                        ,"6500000"
                                        ,"6750000"
                                        ,"7000000"
                                        ,"7250000"
                                        ,"7500000"
                                        ,"7750000"
                                        ,"8050000"
                                        ,"8350000"
                                        ,"8650000"
                                        ,"8950000"
                                        ,"9250000"
                                        ,"9550000"
                                        ,"9850000"
                                        ,"10150000"
                                        ,"10450000"
                                        ,"10750000"
                                        ,"11200000"
                                        ,"11600000"
                                        ,"12100000"
                                        ,"12600000"
                                        ,"13100000"
                                        ,"13600000"
                                        ,"14200000"
                                        ,"14700000"
                                        ,"15300000"
                                        ,"15900000"
                                        ,"16600000"
                                        ,"17200000"
                                        ,"17900000"
                                        ,"18600000"
                                        ,"19400000"
                                        ,"20200000"
                                        ,"21000000"
                                        ,"21800000"
                                        ,"22700000"
                                        ,"23600000"
                                        ,"24500000"
                                        ,"25500000"
                                        ,"26600000"
                                        ,"27600000"
                                        ,"28700000"
                                        ,"29900000"
                                        ,"31100000"
                                        ,"32300000"
                                        ,"33600000"
                                        ,"35000000"
                                        ,"36400000"
                                        ,"37800000"
                                        ,"39300000"
                                        ,"40900000"
                                        ,"42600000"
                                        ,"44300000"
                                        ,"46000000"
                                        ,"47900000"
                                        ,"49800000"
                                        ,"99999999"
                                        );

        //ǥ�غ�������
        var stdb_amtList = new Array(    "280000"
                                        ,"330000"
                                        ,"380000"
                                        ,"430000"
                                        ,"480000"
                                        ,"530000"
                                        ,"580000"
                                        ,"630000"
                                        ,"680000"
                                        ,"730000"
                                        ,"800000"
                                        ,"900000"
                                        ,"1000000"
                                        ,"1100000"
                                        ,"1200000"
                                        ,"1300000"
                                        ,"1400000"
                                        ,"1500000"
                                        ,"1600000"
                                        ,"1700000"
                                        ,"1830000"
                                        ,"1980000"
                                        ,"2130000"
                                        ,"2280000"
                                        ,"2430000"
                                        ,"2580000"
                                        ,"2730000"
                                        ,"2880000"
                                        ,"3030000"
                                        ,"3180000"
                                        ,"3350000"
                                        ,"3550000"
                                        ,"3750000"
                                        ,"3950000"
                                        ,"4150000"
                                        ,"4350000"
                                        ,"4550000"
                                        ,"4750000"
                                        ,"4950000"
                                        ,"5150000"
                                        ,"5380000"
                                        ,"5630000"
                                        ,"5880000"
                                        ,"6130000"
                                        ,"6380000"
                                        ,"6630000"
                                        ,"6880000"
                                        ,"7130000"
                                        ,"7380000"
                                        ,"7630000"
                                        ,"7900000"
                                        ,"8200000"
                                        ,"8500000"
                                        ,"8800000"
                                        ,"9100000"
                                        ,"9400000"
                                        ,"9700000"
                                        ,"10000000"
                                        ,"10300000"
                                        ,"10600000"
                                        ,"10980000"
                                        ,"11400000"
                                        ,"11850000"
                                        ,"12350000"
                                        ,"12850000"
                                        ,"13350000"
                                        ,"13900000"
                                        ,"14450000"
                                        ,"15000000"
                                        ,"15600000"
                                        ,"16250000"
                                        ,"16900000"
                                        ,"17550000"
                                        ,"18250000"
                                        ,"19000000"
                                        ,"19800000"
                                        ,"20600000"
                                        ,"21400000"
                                        ,"22250000"
                                        ,"23150000"
                                        ,"24050000"
                                        ,"25000000"
                                        ,"26050000"
                                        ,"27100000"
                                        ,"28150000"
                                        ,"29300000"
                                        ,"30500000"
                                        ,"31700000"
                                        ,"32950000"
                                        ,"34300000"
                                        ,"35700000"
                                        ,"37100000"
                                        ,"38550000"
                                        ,"40100000"
                                        ,"41750000"
                                        ,"43450000"
                                        ,"45150000"
                                        ,"46950000"
                                        ,"48850000"
                                        ,"50800000"
                                        );                                       

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_IS_GRADETABLE.CountColumn == 0) {
				dsT_IS_GRADETABLE.setDataHeader("APY_YMD:STRING, GBN_TAG:STRING, GRD_CD:STRING, APY_TAG:STRING, MAFF_AMT:INT, MAFT_AMT:INT, STDB_AMT:INT, CAMT_AMT:INT, GRD_PCT:DECIMAL");
			}
            
            dsT_IS_GRADETABLE.ClearData();
            
            for(var i=1; i<=100; i++) {
                dsT_IS_GRADETABLE.AddRow();
                
                dsT_IS_GRADETABLE.NameValue(i, "GBN_TAG")   = "I";
                dsT_IS_GRADETABLE.NameValue(i, "GRD_CD")    = lpad(i, 2, "0");
                dsT_IS_GRADETABLE.NameValue(i, "APY_TAG")   = "Y";
                dsT_IS_GRADETABLE.NameValue(i, "MAFF_AMT")  = maft_amtList[i-1];
                dsT_IS_GRADETABLE.NameValue(i, "MAFT_AMT")  = maft_amtList[i];
                dsT_IS_GRADETABLE.NameValue(i, "STDB_AMT")  = stdb_amtList[i-1];
            }
            
            document.getElementById("resultMessage").innerText = ' ';
            document.getElementById("txtAPY_YMD").value = getToday();
            document.getElementById("txtAPY_RAT").value = "";            
            
            isAddNew = true;
            isConduct = false;
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

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_IS_GRADETABLE.ClearData();
            
			document.getElementById("resultMessage").innerText = ' ';
			document.getElementById("txtAPY_RAT").value = "";
			document.getElementById("txtAPY_YMD").value = "";
            
            isAddNew = false;
            isConduct = false;
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
         	if ( !dsT_IS_GRADETABLE.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
            
            //�ű��� ��� ó���� �ȵǾ� ������ 
            if(isAddNew && !isConduct) {
                alert("ó�� ��ư�� Ŭ���� �ּ���.!");
                return false;
            }
            
            if(isAddNew && !confirm("�ǰ����� ���̺��� ���� ����ϸ� ���� ������ ��ü�˴ϴ�.\n����Ͻðڽ��ϱ�?")) {
                return false;
            }
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
			cfStyleGrid(form1.grdT_IS_GRADETABLE,15,"true","false");      // Grid Style ����
            
            document.getElementById("txtAPY_YMD_SHR").value = getToday();
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
         * 17. ó���Լ� (ó����ư)  				 	*
         ********************************************/
        function fnc_Conduct() {
	         if (dsT_IS_GRADETABLE.CountRow < 1) {
                alert("ó�� �� �ڷᰡ �����ϴ�!");
                return;
            }
            
            var APY_YMD = document.getElementById("txtAPY_YMD").value;
        	var APY_RAT = document.getElementById("txtAPY_RAT").value;
            if( APY_YMD == "") {
                alert("ó���Ϸ��� å�����ڸ� �Է��ϼ���.");
                document.getElementById("txtAPY_YMD").focus();
                return;
            }            
        	if( APY_RAT == ""){
        		alert("ó���Ϸ��� ������ �Է��ϼ���. ��)4.50");
                document.getElementById("txtAPY_RAT").focus();
        		return;
        	}

			
			// ������ ���� ��ü ���� ������� ����
            var STDB;
			for(var i=1; i<=100; i++){
				STDB = dsT_IS_GRADETABLE.NameValue(i, "STDB_AMT");
				dsT_IS_GRADETABLE.NameValue(i, "CAMT_AMT") = Math.round(((parseInt(STDB)/100) * APY_RAT) / 10) * 10 ;
                
				
				// ���� ����
				dsT_IS_GRADETABLE.NameValue(i, "APY_YMD") = APY_YMD;
				dsT_IS_GRADETABLE.NameValue(i, "GRD_PCT") = APY_RAT;
			}
            
            isConduct = true;
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
    | 2. �̸��� ds_ + �ֿ� ���̺���(T_IS_GRADETABLE)			   |
    | 3. ���Ǵ� Table List(T_IS_GRADETABLE) 			   |
    +------------------------------------------------------>
	<Object ID="dsT_IS_GRADETABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺���(T_IS_GRADETABLE)		  	   |
    | 3. ���Ǵ� Table List(T_IS_GRADETABLE)		     	   |
    +------------------------------------------------------>
	<Object ID="trT_IS_GRADETABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:T_IS_GRADETABLE=T_IS_GRADETABLE,O:T_IS_GRADETABLE_01=T_IS_GRADETABLE_01,I:T_IS_GRADETABLE=T_IS_GRADETABLE)">
	</Object>
	
    
	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_IS_GRADETABLE.CountRow);
            
			document.getElementById("txtAPY_YMD").value = dsT_IS_GRADETABLE.NameString(1, "APY_YMD");
			document.getElementById("txtAPY_RAT").value = dsT_IS_GRADETABLE.NameString(1, "GRD_PCT");
        }
    </Script>
    
	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_IS_GRADETABLE Event="OnDataError()">
	    //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_IS_GRADETABLE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        
        isAddNew = false;
        isConduct = false;
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_IS_GRADETABLE event="OnFail()">
        alert(trT_IS_GRADETABLE.ErrorMsg);
        
        isAddNew = false;
        isConduct = false;
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ǰ��������̺�����</td>
					<td align="right" class="navigator">HOME/�����Ļ�/�ǰ�����/<font color="#000000">�ǰ��������̺�����</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','/images/button/btn_ConductOver.gif',1)"><img src="/images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="right" class="searchState">å������</td>
					<td class="padding2423">
						<input type="text" id="txtAPY_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtAPY_YMD_SHR','','114','108');"></a>
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
		<td class="paddingTop5">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="60"></col>
			<col width="100"></col>
			<col width="60"></col>
			<col width="90"></col>
			<col width="60"></col>
			<col width="90"></col>
			<col width="60"></col>
			<col width="90"></col>
			<col width="60"></col>
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="creamBold">å������</td>
			<td class="padding2423">
				<input type="text" id="txtAPY_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtAPY_YMD','','114','108');"></a>
			</td>
			<td align="center" class="creamBold">�������</td>
			<td class="padding2423">
				<input type="text" id="txtAPY_RAT" style="ime-mode:disabled" size="6" maxlength="4" onkeypress="cfCheckNumber3()">&nbsp;%
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
					<object id="grdT_IS_GRADETABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_IS_GRADETABLE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width=65	name="NO"				align=center	value={String(Currow)}</C>
							<C> id="GRD_CD"			width=100	name="���"				align=center	Edit=none</C>
							<C> id="APY_YMD"		width=60	name="��������"			align=center	Edit=none	 show="false"</C>
							<C> id="GBN_TAG"		width=50	name="����"				align=center	Edit=none	 show="false"</C>
							<C> id="APY_TAG"		width=60	name="�����±�"			align=center	Edit=none	 show="false"</C>
							<C> id="MAFF_AMT"		width=150	name="�ҵ����(�̻�)"		align=right		Edit=none	 RightMargin="10"</C>
							<C> id="MAFT_AMT"		width=150	name="�ҵ����(�̸�)"		align=right		Edit=none	 RightMargin="10"</C>
							<C> id="STDB_AMT"		width=150	name="ǥ�غ�������"		align=right		Edit=none	 RightMargin="10"</C>
							<C> id="CAMT_AMT"		width=150	name="�������"			align=right		Edit=none	 RightMargin="10"</C>
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