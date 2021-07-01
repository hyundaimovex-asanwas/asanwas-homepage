	<!--*******************************************************
	* @source      : idtb002.jsp							  *
	* @description : ������༭ �ۼ� ����Ʈ PAGE 		      *
	***********************************************************
	* DATE            AUTHOR        DESCRIPTION				  *
	*----------------------------------------------------------
	* 2019/03/13            �̵���            	         	  *
	*******************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>������༭ �ۼ� ����Ʈ</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>

	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
		
        var trTypeMsg = "";

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			var STR_YMD_SHR = document.form1.txtSTR_YMD_SHR.value;
			var END_YMD_SHR = document.form1.txtEND_YMD_SHR.value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;

			dsT_CM_CONTRACT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&ENO_NM_SHR="+ENO_NM_SHR;
			//prompt(this,dsT_CM_CONTRACT.DataId);
			dsT_CM_CONTRACT.reset();

        }

		
		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


		/********************************************
         * 03. ���� �Լ�						    *
         ********************************************/
        function fnc_Save() {

			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_CM_CONTRACT.KeyValue = "tr01(I:dsT_CM_CONTRACT=dsT_CM_CONTRACT)";
			
			trT_CM_CONTRACT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=SAV";

			trT_CM_CONTRACT.post();

        }

		

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {
			
			if (dsT_CM_CONTRACT.CountRow < 1) {
				
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("���� �� �ڷᰡ �����ϴ�!");
                
                return;
                
            }else{
            	
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
           		
            	tmpMSG += "��Ϲ�ȣ = "+dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "SID")+"\n";
            	tmpMSG += "����     = "+dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "ENO_NM")+"\n";


	            if( confirm(tmpMSG) ){
	            	
					var SID = dsT_CM_CONTRACT.nameValue(dsT_CM_CONTRACT.RowPosition, "SID");

					dsT_CM_CONTRACT.DeleteRow(dsT_CM_CONTRACT.RowPosition);

                    //��� �޼����� �Ѹ��� ����
                    trTypeMsg = "����";

					// �Ķ���� �߰�
					trT_CM_CONTRACT_DEL.Parameters = "SID="+SID;

					trT_CM_CONTRACT_DEL.KeyValue = "tr01(I:dsT_CM_CONTRACT=dsT_CM_CONTRACT)";
					trT_CM_CONTRACT_DEL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb002.cmd.IDTB002CMD&S_MODE=DEL";
					trT_CM_CONTRACT_DEL.post();
					
				}
	            
			}
			
        }


		/********************************************
         * 05. �μ� �Լ�  						    *
         ********************************************/
         
         function fnc_Print() {         

 			//A:�⺻ B:���� C:����
   			var doc_kind = dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'CD_GBN');			
			
				var Y01_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P01_AMT')) * 12
				var Y02_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P02_AMT')) * 12
				var Y03_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P03_AMT')) * 12
				var Y04_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P04_AMT')) * 12				
				var Y05_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P05_AMT')) * 12				
				var YSUM_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'SUM_AMT')) * 12				
 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y01_AMT") = Y01_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y02_AMT") = Y02_AMT;
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y03_AMT") = Y03_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y04_AMT") = Y04_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y05_AMT") = Y05_AMT; 				
 				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "YSUM_AMT") = YSUM_AMT; 		
		
				//prompt(this, dsT_CM_CONTRACT.text);
		
  			if(doc_kind == "A"){ 			
 			
 				alert("�⺻ ������༭ ȭ������ �̵��մϴ�.");
 				

 				
 				//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print1.Preview();

  			}else if(doc_kind == "B"){
  				
  				alert("���� ������༭ ȭ������ �̵��մϴ�.");

 				//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print2.Preview();
  				
  			}else if(doc_kind == "C"){
  				
  				alert("���� ������༭ ȭ������ �̵��մϴ�.");

 				//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
 				cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

 				gcrp_print3.Preview();
 				
  			}
  			
  			
		}



		/********************************************
         * 06. ���� ���� �Լ�  					    *
         ********************************************/
        function fnc_ToExcel() {


        }

		
		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

			// �� �߰�
			dsT_CM_CONTRACT.AddRow();


        }

		
		
		
		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
			
        }
		
		

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {
			
			
        }

		
		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

        	document.getElementById("resultMessage").innerText = ' ';
        	
        	dsT_CM_CONTRACT.ClearData();

        }

		
		
		/********************************************
         * 11. ȭ�� ����(�ݱ�)  				    *
         ********************************************/
        function fnc_Exit() {
			
        	window.close();
        	
        }

		
		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  			    *
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
	        
        }

		
		/********************************************
         * 13. ���� ��ȿ�� üũ  				    *
         ********************************************/
        function fnc_SaveItemCheck() {
			
  			if ( !dsT_CM_CONTRACT.isUpdated ) {
  				
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
			}

			return true;
        }

		
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
        	
            cfStyleGrid_New(form1.grdT_CM_CONTRACT,15,"false","false");      // Grid Style ����
        	
            document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = gcurdate;            

			fnc_SearchList();
            
        }
        
        
        
        /**
         * �ѿ����� ���
         */
        function cal_Sum(P01_AMT, P02_AMT, P03_AMT, P04_AMT, P05_AMT){
        	
            var P1_AMT = document.getElementById(P01_AMT);
            var P2_AMT = document.getElementById(P02_AMT);
            var P3_AMT = document.getElementById(P03_AMT);
            var P4_AMT = document.getElementById(P04_AMT);
            var P5_AMT = document.getElementById(P05_AMT);

			var Sum_amt = parseInt(P1_AMT.text) + parseInt(P2_AMT.text) + parseInt(P3_AMT.text) + parseInt(P4_AMT.text) + parseInt(P5_AMT.text);

            document.getElementById("txtSum_amt").text = Sum_amt;

        }
        
    </script>
    
</head>


<!-- �⺻���翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP01_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- �ð��ܼ��翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP02_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- ���ϼ��翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP03_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- Ư�����翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP04_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>

<!-- �������翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP05_AMT event="onKillFocus()">

	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');
	
</script>


<!--**************************************************************************************
   *                                                                                        *
   * Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
   *                                                                                        *
   ***************************************************************************************-->

<!-----------------------------------------------------+
   | 1. ��ȸ�� DataSet									   |
   | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_CONTRACT)		   |
   | 3. ���Ǵ� Table List(T_CM_CONTRACT) 			 	   |
   +------------------------------------------------------>
<Object ID="dsT_CM_CONTRACT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" 				Value="True">
	<Param Name="UDOChangeInfo"			Value="True">
	<Param Name="ViewDeletedRow"		Value="False">
</Object>


<Object ID="dsT_CM_CONTRACT_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
	<Param Name="Syncload" 				Value="True">
	<Param Name="UDOChangeInfo"			Value="True">
	<Param Name="ViewDeletedRow"		Value="False">
</Object>



<!-----------------------------------------------------+
   | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			   |
   | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_CONTRACT)		   |
   | 3. ���Ǵ� Table List(T_CM_CONTRACT)				   |
   +------------------------------------------------------>
<Object ID="trT_CM_CONTRACT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>

<Object ID="trT_CM_CONTRACT_DEL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
	<Param Name=KeyName Value="toinb_dataid4">
</Object>


<!--**************************************************************************************
   *                                       												 *
   *	Component���� �߻��ϴ� Event ó����													 *
   *                                       												 *
   ***************************************************************************************-->

<!-----------------------------------------------------+
   | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnLoadCompleted(iCount)">

	if (iCount == 0)    {
		fnc_Message(document.getElementById("resultMessage"),"MSG_02");
	} else {
		// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
		fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_CM_CONTRACT.CountRow);
       }
	
</Script>



<!-----------------------------------------------------+
   | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnLoadError()">
       //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
       cfErrorMsg(this);
       // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
</Script>

<!-----------------------------------------------------+
   | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��|
   +------------------------------------------------------>
<Script For=dsT_CM_CONTRACT Event="OnDataError()">
       //Dataset���� Error ó��
       cfErrorMsg(this);
   </Script>

<!-----------------------------------------------------+
   | Transaction Successful ó��     						   |
   +------------------------------------------------------>
<script for=trT_CM_CONTRACT event="OnSuccess()">

       //�޼��� �Ѹ���
       fnc_Message(document.getElementById("resultMessage"), 'MSG_01');

      	alert("���������� ����Ǿ����ϴ�.");
      	
      	fnc_SearchList();
      	
</script>

<script for=trT_CM_CONTRACT_DEL event="OnSuccess()">

       fnc_SearchList();

       //�޼��� �Ѹ���
       fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
       
       alert("* "+trTypeMsg+" �۾��� �Ϸ� �Ͽ����ϴ�!");
       
</script>

<!-----------------------------------------------------+
   | Transaction Failure ó��    	   					   |
   +------------------------------------------------------>
<script for=trT_CM_CONTRACT event="OnFail()">
       alert(trT_CM_CONTRACT.ErrorMsg);
</script>

<script for=trT_CM_CONTRACT_DEL event="OnFail()">
       alert(trT_CM_CONTRACT.ErrorMsg);
</script>




<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->


<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- Ķ���� ������ -->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
   	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
           	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSAVE','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)">  <img src="../../images/button/btn_PrintOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="60"></col>
				<col width="200"></col>
				<col width="60"></col>
				<col width="*"></col>
			</colgroup>
			<tr>
				<td class="searchState" align="right">�Ի�Ⱓ</td>
				<td class="padding2423" align="left">
					<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
					~
					<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
				</td>

                <td align="right" class="searchState">����</td>
                <td class="padding2423">
                    <input id="txtENO_NM_SHR" size="15" maxlength= "9"  onkeypress="if (event.keyCode == 13) fnc_SearchList();">
                </td>
             </tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->

<br>
	
<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
		<colgroup>
			<col width="80"></col>
			<col width="80"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="100"></col>
			<col width="80"></col>
			<col width="120"></col>
			<col width="80"></col>
			<col width="150"></col>			
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">����</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14" >
            </td>
			<td align="center" class="blueBold">��������</td>
			<td class="padding2423" align="left">
				<select id="cmbCD_GBN" style="width:90%">
                   <option value="" ></option>
                   <option value="A">�⺻</option>
                   <option value="B">����</option>	
                   <option value="C">����</option>	               
				</select>	
			</td>   
			<td align="center" class="blueBold">�ٷαⰣ</td>
			<td class="padding2423" align="left" colspan=3>
				<input id="txtFROM_YMD" size="10" maxlength="10" >  ~
				<input id="txtTO_YMD" size="10" maxlength="10" >                
				<input id="txtMONTH" name="txtMONTH" size="5" maxlength= "5" >
			</td>	
			<td align="center" class="blueBold">�ѿ���</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtSUM_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=false>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>     
            </td>	
		</tr>
		<tr>
			<td align="center" class="blueBold">�⺻��</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP01_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>            
            </td>				
			<td align="center" class="blueBold">�ð��ܼ���</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP02_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	
			<td align="center" class="blueBold">���ϱٷμ���</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP03_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>				
			<td align="center" class="blueBold">Ư��������</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP04_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	            
			<td align="center" class="blueBold">��������</td>
            <td class="padding2423">
                <comment id="__NSID__">
                <object id="txtP05_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                    <param name=Alignment               value=2>
                    <param name=Border                  value=true>
                    <param name=ClipMode                value=true>
                    <param name=DisabledBackColor       value="#EEEEEE">
                    <param name=Enable                  value=true>
                    <param name=IsComma                 value=true>
                    <param name=Language                value=0>
                    <param name=MaxLength               value=8>
                    <param name=Numeric                 value=true>
                    <param name=NumericRange            value=0~+:0>
                    <param name=ShowLiteral             value=false>
                    <param name=Visible                 value=true>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>    
            </td>	 
		</tr>

</table>
		
		
<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<comment id="__NSID__">
			<object id="grdT_CM_CONTRACT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:350px;">
				<param name="DataID" 			value="dsT_CM_CONTRACT">
				<param name="Editable" 			value="false">
				<param name="DragDropEnable" 	value="true">
				<param name="SortView" 			value="Left">
				<param name="Format" 			value='
					<C> id={currow}		width=30	name="NO"			align=center	Edit=none	 </C>
					<C> id="SID"		width=100	name="������ȣ"		align=center	Edit=none	 show=false</C>
					<C> id="CD_GBN"		width=80	name="��������"		align=center	Edit=none	 value={decode(CD_GBN, "A", "�⺻", "B", "����", "C", "����")}</C>					
					<C> id="ENO_NM"		width=80	name="����"			align=center	Edit=none	 </C>			
					<C> id="FROM_YMD"	width=80	name="������"		align=center	Edit=none	 </C>										
					<C> id="TO_YMD"		width=80	name="������"		align=center	Edit=none	 </C>
					<C> id="MONTH"		width=50	name="������"		align=center	Edit=none	 </C>
					<C> id="P01_AMT"	width=90	name="�⺻����"		align=right		Edit=none	 </C>	
					<C> id="P02_AMT"	width=90	name="�ð��ܼ���"	align=right		Edit=none	 </C>					
					<C> id="P03_AMT"	width=90	name="���ϼ���"		align=right		Edit=none	 </C>
					<C> id="P04_AMT"	width=90	name="Ư��������"	align=right		Edit=none	 </C>					
					<C> id="P05_AMT"	width=90	name="��������"		align=right		Edit=none	 </C>						
					<C> id="SUM_AMT"	width=90	name="�ѿ���"		align=right		Edit=none	 </C>			
				'>
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
	</tr>
</table>
<!-- ���� ��ȸ �׸��� ���̺� ��-->

</form>
<!-- form �� -->

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �⺻ ������༭ ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print1  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='������༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȸ �� �� :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ǥ �� :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ü���� �ٷΰ�༭, �����Ģ �� ���ù��ɿ� ���Ѵ�. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ؿ� ������.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���޴����� ������ ��� �� ����)�� �ٷ��� ���� ������ ���� ���¿� �Ա��ϴ� ������� �����Ѵ�.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��� 1�Ϻ��� ���ϱ����� �޿������Ⱓ���� �ϸ�, �� ������ 12���� 1�� �ش��ϴ� �ݾ��� �ſ� 25��' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �����Ѵ�.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��, �ٹ������� � ���� ���� ���������� ���� ��쿡�� �����Ģ �� ȸ�� �λ������ ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����̴�.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǰ���� ��ձ޿��� ���Կ��� �����Ѵ�. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ͽ� �����ϴ� �����ӱݻ������� �ϸ�, �� �޿��� ������ �Ʒ��� ����. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. ���� ������ ������ ������ �����ϴ� ��� ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������޹����' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������   �롽' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ ȸ�簡 ���� ���� ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ������ ��� ���� ����Ⱓ�� ���Ͽ� ����Ǹ�, ��Ÿ �źа� ���õ� ���ݻ����� �Ի� �� ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��༭�� �� ü���� ������༭���� �ӱݰ��� ������ ��ü�Ѵ�. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. �⺻���� �����ٷνð�(209�ð�/��)�� ���� �޿��̴�.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. �ð��ܼ����� �� 52�ð��� ���塤�߰��ٷο� ���� �޿��̴�.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. ���ϱٷμ����� �� 18�ð��� ���ϱٷο� ���� �޿��̴�. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. Ư���������� ���������� �ٹ��� ��� �߻��� �� �ִ� �߰��� ����� �����ϱ� ���Ͽ� �����ϴ� ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. ���������� �޿�ü�� �������� �߻��� �� �ִ� ������ �����ϱ� ���Ͽ� �����ϴ� �ѽ��� ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� å���� �ӱ��� �� ������ ������ �� ���̸�, ���¼����� ���� ���� ������ �� �ִ�.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ߵ� �ԡ�������� ��� �ش� ���� �ٹ��ϼ��� ���� ���� ����Ͽ� �����Ѵ�. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��⿡ ���Ե��� ���� ��Ÿ����(�ڰݼ���, ��å����, �������� ��)�� ȸ�簡 ���� �������ؿ� ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ���� �����ݾ��� ��1���� ���� ����Ⱓ ���̶� ����, ���� �� �źл��� �����̳� �λ���,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4�������������' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ͽ� �����Ѵ�. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �Ѵ�.' ,left=1445 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1249, top=452, right=1416, bottom=489 ,mask='(XX����)', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������ ���� ����Ⱓ��' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� �����ϸ� �����ǻ翡 ���� ������ ���� ��������� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�������� ����Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2���������ݾס�' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='����' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϱٷμ���' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='����' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='���޿�' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����ƻ�(��)(���� �������̶� ��)�� �ٷ���' ,left=69 ,top=278 ,right=894 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� ��������' ,left=1230 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=955, top=278, right=1204, bottom=315, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����Ư���� ���α� ����� 194' ,left=463 ,top=2418 ,right=992 ,bottom=2455 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ȯ' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>


">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ���� ������༭ ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print2  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='������༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȸ �� �� :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ǥ �� :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=466 ,top=2492 ,right=810 ,bottom=2529 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ü���� �ٷΰ�༭, �����Ģ �� ���ù��ɿ� ���Ѵ�. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ؿ� ������.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���޴����� ������ ��� �� ����)�� \'��\' ���� ������ ���� ���¿� �Ա��ϴ� ������� �����Ѵ�.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��� 1�Ϻ��� ���ϱ����� �޿������Ⱓ���� �ϸ�, �� ������ 12���� 1�� �ش��ϴ� �ݾ��� �ſ� 25��' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ͽ� �����ϴ� �����ӱݻ������� �ϸ�, �� �޿��� ������ �Ʒ��� ����. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. ���� ������ ������ ������ �����ϴ� ��� ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������޹����' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������   �롽' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ������ ��� ���� ����Ⱓ�� ���Ͽ� ����Ǹ�, ��Ÿ �źа� ���õ� ���ݻ����� �Ի� �� ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��༭�� �� ü���� ������༭���� �ӱݰ��� ������ ��ü�Ѵ�. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. �⺻���� �����ٷνð�(209�ð�/��)�� ���� �޿��̴�.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� å���� �ӱ��� �� ������ ������ �� ���̸�, ���¼����� ���� ���� ������ �� �ִ�.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ߵ� �ԡ�������� ��� �ش� ���� �ٹ��ϼ��� ���� ���� ����Ͽ� �����Ѵ�. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4�������������' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �Ѵ�.' ,left=1418 ,top=452 ,right=1704 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������ ���� ����Ⱓ��' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� �����ϸ� �����ǻ翡 ���� ������ ���� ��������� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�������� ����Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2���������ݾס�' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='����' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϱٷμ���' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='����' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='���޿�' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����ƻ�(��)(���� �������̶� ��)�� �ٷ���' ,left=69 ,top=278 ,right=826 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=828, top=278, right=1103, bottom=315, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���� �������̶� ��)(��)�� ��������' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1222, top=452, right=1405, bottom=489 ,mask='(XXXX����)', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='3. Ư���������� ���������� �ٹ��� ��� �߻��� �� �ִ� �߰��� ����� �����ϱ� ���Ͽ� �����ϴ� ' ,left=95 ,top=1011 ,right=1879 ,bottom=1048 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. �ð��ܼ����� �� �� 43�ð��� ����, ����, �߰��ٷο� ���� �޿��̴�.' ,left=95 ,top=958 ,right=1879 ,bottom=995 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǰ���� ��ձ޿��� ���Կ��� �����Ѵ�. ' ,left=135 ,top=1056 ,right=1876 ,bottom=1093 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. ���������� �޿�ü�� �������� �߻��� �� �ִ� ������ �����ϱ� ���Ͽ� �����ϴ� �ѽ��� ' ,left=93 ,top=1103 ,right=1876 ,bottom=1140 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����̴�.' ,left=138 ,top=1151 ,right=1876 ,bottom=1188 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��⿡ ���Ե��� ���� ��Ÿ����(�ڰݼ���, ��å����, �������� ��)�� ȸ�簡 ���� �������ؿ� ' ,left=66 ,top=1201 ,right=1881 ,bottom=1238 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ͽ� �����Ѵ�. ' ,left=122 ,top=1246 ,right=1881 ,bottom=1283 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ���� �����ݾ��� ��1���� ���� ����Ⱓ ���̶� ����, ���� �� �źл��� �����̳� �λ���,' ,left=61 ,top=1296 ,right=1876 ,bottom=1334 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��, �ٹ������� � ���� ���� ���������� ���� ��쿡�� �����Ģ �� ȸ�� �λ������ ' ,left=116 ,top=1344 ,right=1881 ,bottom=1381 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �����Ѵ�.' ,left=116 ,top=1389 ,right=1881 ,bottom=1426 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �������� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ �������� ���� ����' ,left=66 ,top=2024 ,right=1894 ,bottom=2061 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1630 ,top=2569 ,right=1701 ,bottom=2617 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2519 ,right=873 ,bottom=2693</I>
	<T>id='����Ư���� ���α� ����� 194 ' ,left=452 ,top=2416 ,right=1003 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ȯ' ,left=466 ,top=2569 ,right=693 ,bottom=2606 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=1066 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>


">
</OBJECT>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ���� ������༭ ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print3  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2739 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='������༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=706 ,top=2569 ,right=778 ,bottom=2617 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=79 ,top=2416 ,right=235 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ȸ �� �� :' ,left=246 ,top=2492 ,right=445 ,bottom=2529 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ǥ �� :' ,left=251 ,top=2569 ,right=450 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=246 ,top=2416 ,right=445 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=1021 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2416 ,right=1381 ,bottom=2453 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=1188 ,top=2569 ,right=1381 ,bottom=2617 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� : ' ,left=74 ,top=2302 ,right=913 ,bottom=2339 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ü���� �ٷΰ�༭, �����Ģ �� ���ù��ɿ� ���Ѵ�. ' ,left=122 ,top=2156 ,right=1889 ,bottom=2193 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ؿ� ������.' ,left=119 ,top=2066 ,right=1889 ,bottom=2103 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���޴����� ������ ��� �� ����)�� �ٷ��� ���� ������ ���� ���¿� �Ա��ϴ� ������� �����Ѵ�.' ,left=106 ,top=1561 ,right=1902 ,bottom=1598 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��� 1�Ϻ��� ���ϱ����� �޿������Ⱓ���� �ϸ�, �� ������ 12���� 1�� �ش��ϴ� �ݾ��� �ſ� 25��' ,left=69 ,top=1516 ,right=1897 ,bottom=1553 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �����Ѵ�.' ,left=116 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��, �ٹ������� � ���� ���� ���������� ���� ��쿡�� �����Ģ �� ȸ�� �λ������ ' ,left=116 ,top=1357 ,right=1881 ,bottom=1394 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����̴�.' ,left=138 ,top=1164 ,right=1876 ,bottom=1201 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǰ���� ��ձ޿��� ���Կ��� �����Ѵ�. ' ,left=135 ,top=1080 ,right=1876 ,bottom=1117 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ͽ� �����ϴ� �����ӱݻ������� �ϸ�, �� �޿��� ������ �Ʒ��� ����. ' ,left=119 ,top=852 ,right=1884 ,bottom=889 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. ���� ������ ������ ������ �����ϴ� ��� ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������޹����' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������   �롽' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ ȸ�簡 ���� ���� ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ������ ��� ���� ����Ⱓ�� ���Ͽ� ����Ǹ�, ��Ÿ �źа� ���õ� ���ݻ����� �Ի� �� ' ,left=71 ,top=2111 ,right=1886 ,bottom=2148 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��༭�� �� ü���� ������༭���� �ӱݰ��� ������ ��ü�Ѵ�. ' ,left=71 ,top=2199 ,right=1886 ,bottom=2236 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='1. �⺻���� �����ٷνð�(209�ð�/��)�� ���� �޿��̴�.' ,left=95 ,top=910 ,right=1879 ,bottom=947 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2. �ð��ܼ����� �� 52�ð��� ���塤�߰��ٷο� ���� �޿��̴�.' ,left=95 ,top=953 ,right=1879 ,bottom=990 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='3. ���ϱٷμ����� �� 27�ð��� ���ϱٷο� ���� �޿��̴�. ' ,left=95 ,top=995 ,right=1879 ,bottom=1032 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='4. Ư���������� ���������� �ٹ��� ��� �߻��� �� �ִ� �߰��� ����� �����ϱ� ���Ͽ� �����ϴ� ' ,left=95 ,top=1037 ,right=1879 ,bottom=1074 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='5. ���������� �޿�ü�� �������� �߻��� �� �ִ� ������ �����ϱ� ���Ͽ� �����ϴ� �ѽ��� ' ,left=95 ,top=1122 ,right=1879 ,bottom=1159 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� å���� �ӱ��� �� ������ ������ �� ���̸�, ���¼����� ���� ���� ������ �� �ִ�.' ,left=69 ,top=1606 ,right=1884 ,bottom=1643 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ߵ� �ԡ�������� ��� �ش� ���� �ٹ��ϼ��� ���� ���� ����Ͽ� �����Ѵ�. ' ,left=69 ,top=1651 ,right=1884 ,bottom=1688 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��⿡ ���Ե��� ���� ��Ÿ����(�ڰݼ���, ��å����, �������� ��)�� ȸ�簡 ���� �������ؿ� ' ,left=69 ,top=1220 ,right=1884 ,bottom=1257 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ���� �����ݾ��� ��1���� ���� ����Ⱓ ���̶� ����, ���� �� �źл��� �����̳� �λ���,' ,left=69 ,top=1315 ,right=1884 ,bottom=1352 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4�������������' ,left=66 ,top=1741 ,right=1881 ,bottom=1778 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ͽ� �����Ѵ�. ' ,left=119 ,top=1262 ,right=1879 ,bottom=1299 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �Ѵ�.' ,left=1445 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1249, top=452, right=1416, bottom=489 ,mask='(XX����)', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=886, top=452, right=1212, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='~' ,left=852 ,top=452 ,right=878 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=516, top=452, right=841, bottom=489 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='������ ���� ����Ⱓ��' ,left=69 ,top=452 ,right=508 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������� �����ϸ� �����ǻ翡 ���� ������ ���� ��������� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�������� ����Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2���������ݾס�' ,left=69 ,top=534 ,right=1884 ,bottom=572 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=585 ,right=177 ,bottom=646 ,border=true</X>
	<X>left=175 ,top=585 ,right=460 ,bottom=646 ,border=true</X>
	<X>left=458 ,top=585 ,right=743 ,bottom=646 ,border=true</X>
	<X>left=741 ,top=585 ,right=1027 ,bottom=646 ,border=true</X>
	<X>left=1024 ,top=585 ,right=1310 ,bottom=646 ,border=true</X>
	<X>left=1307 ,top=585 ,right=1593 ,bottom=646 ,border=true</X>
	<X>left=1590 ,top=585 ,right=1876 ,bottom=646 ,border=true</X>
	<T>id='����' ,left=74 ,top=590 ,right=172 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�⺻��' ,left=183 ,top=590 ,right=452 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ð��ܼ���' ,left=466 ,top=590 ,right=736 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ϱٷμ���' ,left=749 ,top=590 ,right=1019 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư��������' ,left=1032 ,top=590 ,right=1302 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1315 ,top=590 ,right=1585 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1601 ,top=590 ,right=1871 ,bottom=643 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=69 ,top=643 ,right=177 ,bottom=704 ,border=true</X>
	<X>left=458 ,top=643 ,right=743 ,bottom=704 ,border=true</X>
	<X>left=741 ,top=643 ,right=1027 ,bottom=704 ,border=true</X>
	<X>left=1024 ,top=643 ,right=1310 ,bottom=704 ,border=true</X>
	<X>left=1307 ,top=643 ,right=1593 ,bottom=704 ,border=true</X>
	<X>left=1590 ,top=643 ,right=1876 ,bottom=704 ,border=true</X>
	<T>id='����' ,left=74 ,top=648 ,right=172 ,bottom=701 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=643 ,right=460 ,bottom=704 ,border=true</X>
	<C>id='Y01_AMT', left=183, top=651, right=455, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y02_AMT', left=463, top=651, right=736, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y03_AMT', left=746, top=651, right=1019, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y04_AMT', left=1029, top=651, right=1302, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='Y05_AMT', left=1312, top=651, right=1585, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='YSUM_AMT', left=1598, top=651, right=1871, bottom=699, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<X>left=69 ,top=701 ,right=177 ,bottom=762 ,border=true</X>
	<X>left=458 ,top=701 ,right=743 ,bottom=762 ,border=true</X>
	<X>left=741 ,top=701 ,right=1027 ,bottom=762 ,border=true</X>
	<X>left=1024 ,top=701 ,right=1310 ,bottom=762 ,border=true</X>
	<X>left=1307 ,top=701 ,right=1593 ,bottom=762 ,border=true</X>
	<X>left=1590 ,top=701 ,right=1876 ,bottom=762 ,border=true</X>
	<T>id='���޿�' ,left=74 ,top=706 ,right=172 ,bottom=759 ,face='��ü�� ����ü' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=175 ,top=701 ,right=460 ,bottom=762 ,border=true</X>
	<C>id='P01_AMT', left=183, top=709, right=455, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P02_AMT', left=463, top=709, right=736, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P03_AMT', left=746, top=709, right=1019, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P04_AMT', left=1029, top=709, right=1302, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='P05_AMT', left=1312, top=709, right=1585, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SUM_AMT', left=1598, top=709, right=1871, bottom=757, align='right', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����ƻ�(��)(���� �������̶� ��)�� �ٷ���' ,left=69 ,top=278 ,right=894 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� ��������' ,left=1230 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=955, top=278, right=1204, bottom=315, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='����Ư���� ���α� ����� 194' ,left=463 ,top=2418 ,right=992 ,bottom=2455 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ȯ' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>

">
</OBJECT>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--**************************************************************************************
   *                                       												 *
   *	���ε� ������Ʈ																	 *
   *                                       												 *
   ***************************************************************************************-->
<!-- T_CM_CONTRACT ���� ���̺� -->
<object id="bndT_CM_CONTRACT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_CONTRACT">
	<Param Name="BindInfo", Value="
		<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
		<C>Col=CD_GBN			Ctrl=cmbCD_GBN			Param=value</C>
		<C>Col=FROM_YMD			Ctrl=txtFROM_YMD		Param=value</C>
		<C>Col=TO_YMD			Ctrl=txtTO_YMD			Param=value</C>
		<C>Col=MONTH			Ctrl=txtMONTH			Param=value</C>
		<C>Col=P01_AMT			Ctrl=txtP01_AMT			Param=text</C>
		<C>Col=P02_AMT			Ctrl=txtP02_AMT			Param=text</C>
		<C>Col=P03_AMT			Ctrl=txtP03_AMT			Param=text</C>
		<C>Col=P04_AMT			Ctrl=txtP04_AMT			Param=text</C>
		<C>Col=P05_AMT			Ctrl=txtP05_AMT			Param=text</C>
		<C>Col=SUM_AMT			Ctrl=txtSUM_AMT			Param=text</C>
	">
</object>
	
	
	