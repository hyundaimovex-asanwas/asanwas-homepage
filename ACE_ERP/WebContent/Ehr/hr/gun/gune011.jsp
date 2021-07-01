<!--
***********************************************************************
* @source      : gune011.jsp
* @description : ����ٹ�������Ȳ PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2019/11/18      MOON           �����ۼ�
***********************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>
<head>
<title>����ٹ�����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>


<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;
        
        var dsTemp = window.dialogArguments;
        
        var curRowPosition = 0;

        
        
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {


            var f = document.form1;

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

            var gbn = document.getElementById("cmbGBN_SHR").value;
            var eno_no = document.getElementById("txtENO_NO_SHR").value;
            var our_man = document.getElementById("txtOUR_MAN_SHR").value;

            
            if(!fnc_SearchItemCheck()) return;//�˻����� ��ȿ�� �˻�

            
            //�����ڴ� ��� ��ȸ�� ����
			dsT_DI_OVERTIMEWORK_STATE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune011.cmd.GUNE011CMD&S_MODE=SHR&STR_YMD="+str_ymd+"&END_YMD="+end_ymd+"&GBN="+gbn
												+"&ENO_NO="+eno_no+"&OUR_MAN="+our_man;

			dsT_DI_OVERTIMEWORK_STATE.reset();
			dsT_DI_OVERTIMEWORK_STATE.RowPosition = curRowPosition;

			
        }
		
		
		

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }
		
		
		
		

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }
		
		
		
		

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

			
			
            if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
				alert("������ �ڷᰡ �����ϴ�.");
				
				fnc_Message(document.getElementById("resultMessage"), "MSG_05");
				
				return;
				
			}

            
            
            
            //ó����Ȳ�� ��û�� �ƴѰ��� ���� �� �� ����
            if(!(dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,'APP_STATUS') == 'SV')){
            	
                alert("���� ������ �����ʹ� ������ �� �����ϴ�!");
                
                return;
                
            }
            
            
            

			if(confirm("[��û��ȣ:"+dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,'REQ_NO')+"]�� ������ �����Ͻðڽ��ϱ�?")){
				
				dsT_DI_OVERTIMEWORK_STATE.DeleteRow(dsT_DI_OVERTIMEWORK_STATE.RowPosition);
				
				trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
				
				trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune011.cmd.GUNE011CMD&S_MODE=DEL";
				
				trT_DI_BUSINESSTRIP_STATE.post();
				
			}
			

        }

		
		
		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }
		
		

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
            
            if (dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                
                return;
                
            }
            

            form1.grdT_DI_BUSINESSTRIP_STATE.GridToExcel("����ٹ�", '', 225);            

            
        }

		
		
		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }
		
		

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {



        }

		
		
		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			
			if(dsTemp != "Modal"){
				
	            if (dsT_DI_OVERTIMEWORK_STATE.IsUpdated)  {
	            	
	                if (!fnc_ExitQuestion())  return;
	                
	            }

	            
                window.close();

            }else{
            	
                window.close();
                
            }

			
        }
		
		
		
		

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
			
			

			var str_ymd = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd = document.getElementById("txtEND_YMD_SHR").value;

			
			
 			//���۳���� ������ ��ȸ����.
			if(str_ymd.trim().length == 0){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("���۳���� �Է��ϼ���.");
					
					document.getElementById("txtSTR_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
 			
 			
			//���۳���� �߸��Ǿ����� ��ȸ����.
			if(str_ymd.trim().length != 10){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("���۳���� �߸��Ǿ����ϴ�.");
					
					document.getElementById("txtSTR_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
			
			

			//�������� ������ ��ȸ����.
			if(end_ymd.trim().length == 0){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("�������� �Է��ϼ���.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
					
				}
				
			}
			
			
			//�������� �߸��Ǿ����� ��ȸ����.
			if(end_ymd.trim().length != 10){
				
				if(event.type == "change"){
					
					return false;
					
				}else{
					
					alert("�������� �߸��Ǿ����ϴ�.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
					
					
				}
				
			}
			
			
			

			//�������� ���۳������ ũ�� �ʵȴ�.
			if(parseInt(end_ymd.replaceStr("-","")) < parseInt(str_ymd.replaceStr("-",""))){
				
				
					alert("�������� ���۳������ �����ϴ�.");
					
					document.getElementById("txtEND_YMD_SHR").focus();
					
					return false;
			}
			

            return true;

        }

		
		
		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

         	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		
		
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {
        	
        	        dsT_DI_COST_CP.SetDataHeader(
								"GUBUN:STRING(10),"+			// ����(�ڽ�Ʈ����, ������Ʈ)
	        					"CCTR_CD:STRING(10),"+			// CCR�ڵ�
	                            "CCTR_NM:STRING(20),"+			// CCR��
								"STR_YMD:STRING(20),"+			// ������
								"END_YMD:STRING(10)"			// ������
								);


            document.getElementById("txtSTR_YMD_SHR").value = addDate("D", today, -5);
            document.getElementById("txtEND_YMD_SHR").value = addDate("D", today, +5);

            
			document.getElementById("txtENO_NO_SHR").value=gusrid;
			document.getElementById("txtENO_NM_SHR").value=gusrnm;               
            
            
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070019" || gusrid == "2070020"){ 
				
				document.getElementById("txtENO_NO_SHR").value="";
				document.getElementById("txtENO_NM_SHR").value="";   				
				
				
			    fnc_ChangeStateElement(true, "imgENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
		    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");

	    	}else{

	            fnc_ChangeStateElement(false, "imgENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}					
			
			
			
			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_DI_BUSINESSTRIP_STATE,0,"false","true");      // Grid Style ����


			fnc_SearchList();

            document.getElementById("txtSTR_YMD_SHR").focus();
            
            

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
			
		}

		
		
        /********************************************
         * 16. ����ٹ� ���� �˾�					*
         ********************************************/
		function fnc_DeciPop() {

        	
        	
            if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
            	
				alert("������ �ڷᰡ �����ϴ�.");
				
				return;
				
			}


           
            var url = "../../../Ehr/hr/gun/gune015.jsp?REQ_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"REQ_NO") + "&ENO_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"ENO_NO") + "&APP_STATUS=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(dsT_DI_OVERTIMEWORK_STATE.RowPosition,"APP_STATUS");

			
            window.showModalDialog(url, "Modal", "dialogWidth:1080px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");

            
            fnc_SearchList();
            
            

		}

        
        
    </script>
    
    
    
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!----------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							        |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_OVERTIMEWORK_STATE)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. ī�ǿ� DataSet							                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_OVERTIMEWORK_STATE)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_OVERTIMEWORK_STATE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. ī�ǿ� DataSet							                |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_COST_CP)
    | 3. ���Ǵ� Table List(SAP �ͼ�����) 			|
    +----------------------------------------------------------->
	<Object ID="dsT_DI_COST_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_BUSINESSTRIP_STATE)	|
    | 3. ���Ǵ� Table List(T_DI_BUSINESSTRIP_STATE)	        |
    +----------------------------------------------------------->
    <Object ID ="trT_DI_BUSINESSTRIP_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
    </Object>



    <!-- ��ǥó���� ���� -->
    <object id=dsPROC classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
        <param name=Syncload	value="true">
    </object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERTIMEWORK_STATE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>




	<Script For=dsPROC Event="OnLoadCompleted(iCount)">
	
		alert("��ǥó���� �Ϸ� �Ǿ����ϴ�.");

        //��ǥó�� �� �ٽ� ����Ʈ ��ȸ
        fnc_SearchList();
        
    </Script>



	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsPROC Event="OnLoadError()">
	
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>



	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_OVERTIMEWORK_STATE Event="OnLoadError()">
	
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
        
    </Script>



    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnSuccess()">
    
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
        
    </script>



    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_BUSINESSTRIP_STATE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>




    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_DI_BUSINESSTRIP_STATE event="OnDblClick(row,colid)">

		curRowPosition = dsT_DI_OVERTIMEWORK_STATE.RowPosition;
		
		if(row < 1) {
			
			return;
			
		} else {

			
			if(dsT_DI_OVERTIMEWORK_STATE.CountRow < 1) {
				
				alert("������ �ڷᰡ �����ϴ�.");
				
				return;
				
			}
			
			
			if(dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_STATUS") == "SV" && dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"PENO_NO") != gusrid && gusrid != '6060002') {
				
				alert("��������Դϴ�. ��� �� ���� �� ���ֽ��ϴ�.");
				
				return;
				
			}
			
			
			
			var url = "../../../Ehr/hr/gun/gune015.jsp?REQ_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"REQ_NO") + "&ENO_NO=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"ENO_NO")  + "&APP_YN=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_YN")+ "&APP_STATUS=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_STATUS") + "&APP_CMT=" + dsT_DI_OVERTIMEWORK_STATE.NameValue(row,"APP_CMT");			
			
			
			window.showModalDialog(url, "Modal", "dialogWidth:1080px; dialogHeight:750px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            
			
			fnc_SearchList();

		}
		
		
		
	</script>




	<script language=JavaScript for=dsT_DI_OVERTIMEWORK_STATE event=OnRowPosChanged(row)>

	</script>





<!--**************************************************************************************
    *                                       											 *
	*	BODY START																		 *
    *                                       											 *
    **************************************************************************************-->
    
    
    
<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>



	<!-- Ķ���� ������-->
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
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
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
					<col width="220"></col>
					<col width="80"></col>
					<col width="170"></col>
					<col width="100"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">�ٹ��Ⱓ&nbsp;</td>
					<td>
						<input id="txtSTR_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','225','113');"></a> ~
					    <input id="txtEND_YMD_SHR" size="10" maxlength="10" onblur="fnc_CheckDate(this); cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR'); cfCheckDate(this);" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled"> <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="Image14" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','340','113');"></a>
					</td>
					<td class="searchState" align="right">���±���&nbsp;</td>
					<td>
						<select id="cmbGBN_SHR" style="width:100" onChange="fnc_SearchList();">
							<option value="1" >��ü</option>
							<option value="2" >���</option>
                            <option value="3" >����Ϸ�</option>
						</select>
					</td>
				</tr>
				<tr class="paddingTop5" >
					<td class="searchState" align="right">�����&nbsp;</td>
					<td >
						<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="10" maxlength="9"  onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
						<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR', 'txtENO_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR');">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
					</td>
					<td class="searchState" align="right">������&nbsp;</td>
					<td colspan="3">
						<input id="txtOUR_MAN_SHR" name="txtOUR_MAN_SHR" size="10" maxlength="9"        onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onChange="fnc_GetCommonEnoNm('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');">
						<input id="txtOUR_MAN_NM_SHR" name="txtOUR_MAN_NM_SHR" size="12" maxlength="10" onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');" onchange="fnc_GetCommonEnoNo('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR')">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgOUR_MAN_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgOUR_MAN_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtOUR_MAN_SHR','txtOUR_MAN_NM_SHR');"></a>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- power Search���̺� �� -->


	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop5">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr height="20">
						<td width="360" class="searchState"><span id="resultMessage">&nbsp;</span></td>
						<td width="320">�ذ��縦 ���Ͻø� �ش� ��û���� ����Ŭ�� �ϼ���.</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->





	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_BUSINESSTRIP_STATE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" 			value="dsT_DI_OVERTIMEWORK_STATE">
						<param name="Editable" 			value="false">
						<param name="DragDropEnable" 	value="true">
						<param name="SortView" 			value="Left">
						<param name="Format" value='
                            <C> id="REQ_NO"			width=120	name="��û��ȣ"		align=center    </C>
                            <C> id="ENO_NM"		width=120	name="�����"			align=center    </C>
							<C> id="APP_YMD"		width=120	name="�����"			align=center    </C>
							<C> id="APP_TITLE"		width=500	name="�ٹ�����"	    align=left	    </C>
                            <C> id="APP_STATUS"		width=100	name="�������"		align=center    </C>
                            <C> id="APP_YN"		width=100	name="���翩��"		align=center show=false   </C>
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



<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


