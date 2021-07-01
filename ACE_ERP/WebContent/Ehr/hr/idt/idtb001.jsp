	<!--*******************************************************
	* @source      : idtb001.jsp							  *
	* @description : �ٷ�/������༭ �ۼ� ����Ʈ PAGE 		          *
	***********************************************************
	* DATE            AUTHOR        DESCRIPTION				  *
	*----------------------------------------------------------
	* 2019/03/12            �̵���            	         	                  *
	*******************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
	<title>�ٷ�/������༭ �ۼ� ����Ʈ</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>

	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 			 *
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
			var CD_GBN_SHR = document.form1.cmbCD_GBN_SHR.value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;

			dsT_CM_CONTRACT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb001.cmd.IDTB001CMD&S_MODE=SHR&STR_YMD_SHR="+STR_YMD_SHR+"&END_YMD_SHR="+END_YMD_SHR+"&CD_GBN_SHR="+CD_GBN_SHR+"&ENO_NM_SHR="+ENO_NM_SHR;
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

            if(document.getElementById("cmbWPLACE_NM").value == "A" ){
            	
                alert("�ٹ����� ������ ���\n\n���ϱٷμ���� Ư���������� ���ܵ˴ϴ�.");

  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "P03_AMT") = 0; 
  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "P04_AMT") = 0; 				
  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y03_AMT") = 0;                 
  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y04_AMT") = 0; 				               
	
            }else if(document.getElementById("cmbWPLACE_NM").value == "B" ){
            	
                alert("�ٹ����� ������ ���\n\n���ϱٷμ����� ���Եǰ� Ư���������� ���ܵ˴ϴ�.");  
            
  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "P04_AMT") = 0; 				               
  				dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y04_AMT") = 0; 	                
                
            }else if(document.getElementById("cmbWPLACE_NM").value == "C" ){
            	
                alert("�ٹ����� ������ ���\n\n���ϱٷμ���� Ư���������� ���Ե˴ϴ�.");  

            }



  				document.getElementById("txtSum_amt").value = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P01_AMT')) 
													+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P02_AMT')) 				
													+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P03_AMT'))
													+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P04_AMT')) 							
													+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P05_AMT'));  	            
            


    
  			//dsT_CM_CONTRACT.UserStatus(dsT_CM_CONTRACT.RowPosition) = 1;				

  				
			// �Ķ���� �߰�
			trT_CM_CONTRACT.Parameters = "SUM_AMT="+document.getElementById("txtSum_amt").value;			
			
			// save
			trT_CM_CONTRACT.KeyValue = "tr01(I:dsT_CM_CONTRACT=dsT_CM_CONTRACT)";
			
			trT_CM_CONTRACT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb001.cmd.IDTB001CMD&S_MODE=SAV";

			//prompt(this, dsT_CM_CONTRACT.text);
			
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
					trT_CM_CONTRACT_DEL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.b.idtb001.cmd.IDTB001CMD&S_MODE=DEL";
					trT_CM_CONTRACT_DEL.post();
					
				}
	            
			}
			
        }


		/********************************************
         * 05. �μ� �Լ�  						    *
         ********************************************/
         
         function fnc_Print() {         
         
			//A:������ B:����� C:��������� D:��������� E:�������ȸ�� F:��������

  			var doc_kind = dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'CD_GBN');

		
			var Y01_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P01_AMT')) * 12;
			var Y02_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P02_AMT')) * 12;
			var Y03_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P03_AMT')) * 12;
			var Y04_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P04_AMT')) * 12;	
			var Y05_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P05_AMT')) * 12;			
			//var YSUM_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'SUM_AMT')) * 12;			
			
					
			var YSUM_AMT = parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P01_AMT')) * 12 
						+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P02_AMT')) * 12  				
						+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P03_AMT')) * 12 
						+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P04_AMT')) * 12  							
						+ parseInt(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, 'P05_AMT')) * 12;
					
					
					
			//var YSUM_AMT = 11;
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y01_AMT") = Y01_AMT; 				
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y02_AMT") = Y02_AMT;
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y03_AMT") = Y03_AMT; 				
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y04_AMT") = Y04_AMT; 				
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "Y05_AMT") = Y05_AMT; 				
			dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "YSUM_AMT") = YSUM_AMT; 					
						
			
			
  			if(doc_kind == "A"){

  				alert("������ ��༭ ȭ������ �̵��մϴ�.");
  				
  				fnc_Print1();
  				
  			}else if(doc_kind == "B"){
  				
  				alert("����� ��༭ ȭ������ �̵��մϴ�.");

  				fnc_Print2();
  				
  			}else if(doc_kind == "C"){
  				
  				alert("��������� ��༭ ȭ������ �̵��մϴ�.");
  				
  				fnc_Print3();
  				
  			}else if(doc_kind == "D"){
  				
  				alert("��������� ��༭ ȭ������ �̵��մϴ�.");
  				
  				fnc_Print4();
  				
  			}else if(doc_kind == "E"){
  				
  				alert("�������ȸ�� ��༭ ȭ������ �̵��մϴ�.");
  				
  				fnc_Print5();
  				
  			}else if(doc_kind == "F"){
  				
  				alert("�������� ��༭ ȭ������ �̵��մϴ�."); 
  				
  				fnc_Print6();
  				
  			}else if(doc_kind == "G"){
  				
  				alert("��� ��༭ ȭ������ �̵��մϴ�."); 
  				
  				fnc_Print7();  				
  				
  				
  			}

		}

        function fnc_Print1() {

			//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 
			
            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "A" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  			
						
            }else if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "B" ){			
			
				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 	
            }
			
			gcrp_print1.Preview();

        }

        function fnc_Print2() {

			//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 
			
            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "A" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  			
						
            }else if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "B" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  
            }
			
			gcrp_print2.Preview();

        }

        function fnc_Print3() {

			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 
			
            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "A" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  			
						
            }else if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "B" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  
            }
            
			gcrp_print3.Preview();

        }

        function fnc_Print4() {

			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 

            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "A" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  			
						
            }else if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "B" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  
            }		
			
			gcrp_print4.Preview();

        }

        function fnc_Print5() {

			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 
			
			dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 		

			gcrp_print5.Preview();

        }
        
        function fnc_Print6() {

			//���õ� ROW�� dsT_EV_DUTYRSH_CP�� �����Ͽ� Modalâ�� dsT_EV_DUTYRSH_CP�� �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + " ����"; 	

			
			
            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "TO_YMD") == "���������" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "TO_YMD") = "���������";  			
						
            }else{

				dsT_CM_CONTRACT_PRINT.NameValue(1, "TO_YMD") = dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "TO_YMD").substring(0,4) + "��" + dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "TO_YMD").substring(4,6) + "��" + dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "TO_YMD").substring(6,8) + "��";
            }
			
			
			gcrp_print6.Preview();

        }
        

        
        function fnc_Print7() {

			//���õ� ROW�� �����Ͽ� dsT_CM_CONTRACT_PRINT �Ѱ��ش�.
			cfCopyDataSet(dsT_CM_CONTRACT, dsT_CM_CONTRACT_PRINT, "copyHeader=yes,rowFrom="+dsT_CM_CONTRACT.RowPosition+",rowCnt=1");

			//dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") + dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 
			
            if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "A" ){

				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM") + "����";  			
						
            }else if(dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition, "WPLACE_NM") == "B" ){			
			
				dsT_CM_CONTRACT_PRINT.NameValue(1, "WPLACE_NM") = dsT_CM_CONTRACT_PRINT.NameValue(1, "SITE_NM"); 	
            }
			
			gcrp_print7.Preview();

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
			
			
            if(document.getElementById("cmbJOB_CD").value == "" ){
            	
                alert("������ �����Ͻñ� �ٶ��ϴ�.");

                return false;
			}		
			
			
            if(document.getElementById("cmbHOB_CD").value == "" ){
            	
                alert("������ �Է��Ͻñ� �ٶ��ϴ�.");

                return false;
			}				
			
			
            if(document.getElementById("cmbWPLACE_NM").value == "" ){
            	
                alert("�ٹ���Ҹ� �����Ͻñ� �ٶ��ϴ�.");

                return false;
			}		
			
			
            
            if(document.getElementById("txtFROM_YMD").value == "" ){
            	
                alert("�ٹ��������� �Է��Ͻñ� �ٶ��ϴ�.");

                return false;
			}				
            
            

			//A:������ B:����� C:��������� D:��������� E:�������ȸ�� F:��������

  			var doc_kind = dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'CD_GBN');

  			if(doc_kind == "B" || doc_kind == "C" || doc_kind == "D" || doc_kind == "E" || doc_kind == "F"){            
            
  	            if(document.getElementById("txtTO_YMD").value == "" ){  				
  				
	                alert("�ٹ��������� �Է��Ͻñ� �ٶ��ϴ�.");
	
	                return false;
                
  				}
  	            
			}	


            var P1_AMT = document.getElementById('txtP01_AMT').value;		
            var P2_AMT = document.getElementById('txtP02_AMT').value;				
            var P3_AMT = document.getElementById('txtP03_AMT').value;	            
            var P4_AMT = document.getElementById('txtP04_AMT').value;	            
            var P5_AMT = document.getElementById('txtP05_AMT').text;

			var Sum_amt = parseInt(P1_AMT) + parseInt(P2_AMT) + parseInt(P3_AMT) + parseInt(P4_AMT) + parseInt(P5_AMT);

            document.getElementById("txtSum_amt").text = Sum_amt;
  		    
  		    
            dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'P01_AMT') = P1_AMT;
            dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'P02_AMT') = P2_AMT;
            dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'P03_AMT') = P3_AMT;
            dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'P04_AMT') = P4_AMT;
            dsT_CM_CONTRACT.NameValue(dsT_CM_CONTRACT.RowPosition,'P05_AMT') = P5_AMT;
            
  			
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
        	
            var end_ymd     = addDate("M", gcurdate, 1);            
            
            document.getElementById("txtSTR_YMD_SHR").value = gcurdate.substring(0,8)+"01";
            document.getElementById("txtEND_YMD_SHR").value = end_ymd; // �ش��� To            
            
            
            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_DA.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_DA.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_DA.NameValue(i,"CODE_NAME");
				document.getElementById("cmbCD_GBN_SHR").add(oOption);
			}

            
            // �뵵 ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_DB.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_DB.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_DB.NameValue(i,"CODE_NAME");
				document.getElementById("cmbSRV_CD").add(oOption);
			}
            
            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_A2.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_A2.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_A2.NameValue(i,"CODE_NAME");
				document.getElementById("cmbJOB_CD").add(oOption);
			}
            
            // ���� ���� �˻� �޺��ڽ� ����
			for( var i = 1; i <= dsT_CM_COMMON_DC.CountRow; i++ ) {
				oOption       = document.createElement("OPTION");
				oOption.value = dsT_CM_COMMON_DC.NameValue(i,"CODE");
				oOption.text  = dsT_CM_COMMON_DC.NameValue(i,"CODE_NAME");
				document.getElementById("cmbHOB_CD").add(oOption);
			}            
            
			fnc_SearchList();
            
	
			
        }
        
        
        
        
        
        /************************************************
         *        			���� ���� �˾�â ó��               		*
         ************************************************/
        function fnc_DocNmPopup(gbn) {

            var obj = new String();

            
            //alert(gbn);
            
            if (gbn == 'A') {
            	
                obj.title = '����ڵ�';
                obj.gbn   = 'A';
                window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");


                
                    document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                    document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                    document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                    document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                    document.getElementById('txtP05_AMT').text  = 0;                    
                    //document.getElementById(P05_AMT).text;
                    
                    //document.getElementById('cmbWPLACE_NM').value  = obj.p04_amt;                    
                    
                    alert("���������� �Է��ϼ���");

                    

            }else if (gbn == 'B') {
            	
                obj.title = '����ڵ�';
                obj.gbn   = 'C';
                window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���");
                
                
            }else if (gbn == 'C') {
        	
	            obj.title = '����ڵ�';
	            obj.gbn   = 'C';
	            window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	
                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���");
	            
            }else if (gbn == 'D') {
            	
	            obj.title = '����ڵ�';
	            obj.gbn   = 'S';
	            window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	
                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���");      
	            
            }else if (gbn == 'E') {
            	
	            obj.title = '����ڵ�';
	            obj.gbn   = 'AC';
	            window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	
                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���"); 	            
	            
            }else if (gbn == 'F') {
            	
	            obj.title = '����ڵ�';
	            obj.gbn   = 'AC';
	            window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	
                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���"); 	      
                
                
            }else if (gbn == 'G') {
            	
                obj.title = '����ڵ�';
                obj.gbn   = 'C';
                window.showModalDialog("../../hr/idt/idtb009.jsp", obj, "dialogWidth:600px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                document.getElementById('txtP01_AMT').value  = obj.p01_amt;
                document.getElementById('txtP02_AMT').value  = obj.p02_amt;
                document.getElementById('txtP03_AMT').value  = obj.p03_amt;
                document.getElementById('txtP04_AMT').value  = obj.p04_amt;
                document.getElementById('txtP05_AMT').text  = 0;    
                alert("���������� �Է��ϼ���");                

	        }
	        

        }                
        
        
        
        /************************************************
         *        		     �ٷ� ��� �˾�â ó��               		    *
         ************************************************/
        function fnc_SitePopup(gbn) {

            //����
            if (gbn == 'A' || gbn == 'C') {
                document.getElementById('txtSITE_CD').value  = "";
                document.getElementById('txtSITE_NM').value  = "";
            }
            
        }
        
        

        
        
        /**
         * �հ��� ���
         */
        function cal_Sum(P01_AMT, P02_AMT, P03_AMT, P04_AMT, P05_AMT){
        	

            var P1_AMT = document.getElementById(P01_AMT).value;		
            var P2_AMT = document.getElementById(P02_AMT).value;				
            var P3_AMT = document.getElementById(P03_AMT).value;	            
            var P4_AMT = document.getElementById(P04_AMT).value;	            
            var P5_AMT = document.getElementById(P05_AMT).text;

			var Sum_amt = parseInt(P1_AMT) + parseInt(P2_AMT) + parseInt(P3_AMT) + parseInt(P4_AMT) + parseInt(P5_AMT);

            document.getElementById("txtSum_amt").text = Sum_amt;

        }        
        
        
        
        
    </script>
    
</head>



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


<!-- ���� �޺��� ���� DataSet -->
<!-- ���� ���� -->
<jsp:include page="../../common/gauceDataSet.jsp" flush="true">
   <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
   <jsp:param name="CODE_GUBUN"    value="A2"/>
   <jsp:param name="SYNCLOAD"      value="false"/>
   <jsp:param name="USEFILTER"     value="false"/>
</jsp:include>

<!-- ���� ���� -->
<jsp:include page="../../common/gauceDataSet.jsp" flush="true">
   <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_DA"/>
   <jsp:param name="CODE_GUBUN"    value="DA"/>
   <jsp:param name="SYNCLOAD"      value="false"/>
   <jsp:param name="USEFILTER"     value="false"/>
</jsp:include>

<!-- ���� ���� -->
<jsp:include page="../../common/gauceDataSet.jsp" flush="true">
   <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_DB"/>
   <jsp:param name="CODE_GUBUN"    value="DB"/>
   <jsp:param name="SYNCLOAD"      value="false"/>
   <jsp:param name="USEFILTER"     value="false"/>
</jsp:include>

<!-- ���� ���� -->
<jsp:include page="../../common/gauceDataSet.jsp" flush="true">
   <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_DC"/>
   <jsp:param name="CODE_GUBUN"    value="DC"/>
   <jsp:param name="SYNCLOAD"      value="false"/>
   <jsp:param name="USEFILTER"     value="false"/>
</jsp:include>    

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






<!-- �������翡�� Ŀ���� ���ư� �� ��� �� -->
<script language=JavaScript for=txtP05_AMT event="onKillFocus()">


	cal_Sum('txtP01_AMT', 'txtP02_AMT', 'txtP03_AMT', 'txtP04_AMT', 'txtP05_AMT');

	
</script>



    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó�� |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_CM_CONTRACT event=OnRowPosChanged(row)>

    
    var P1_AMT = document.getElementById(P01_AMT).value;		
    var P2_AMT = document.getElementById(P02_AMT).value;				
    var P3_AMT = document.getElementById(P03_AMT).value;	            
    var P4_AMT = document.getElementById(P04_AMT).value;	            
    var P5_AMT = document.getElementById(P05_AMT).text;

	var Sum_amt = parseInt(P1_AMT) + parseInt(P2_AMT) + parseInt(P3_AMT) + parseInt(P4_AMT) + parseInt(P5_AMT);

    document.getElementById("txtSum_amt").text = Sum_amt;    


    </script>

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
				<col width="100"></col>
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
				<td class="searchState" align="right" >��������</td>
				<td class="padding2423" align="left">
					<select id="cmbCD_GBN_SHR" style="WIDTH: 120px" onChange="fnc_SearchList()">
						<option value="0">���</option>
					</select>
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
			<col width="100"></col>
			<col width="80"></col>
			<col width="120"></col>
			<col width="120"></col>
			<col width="150"></col>
			<col width="90"></col>
			<col width="150"></col>
			<col width="80"></col>	
			<col width="*"></col>
		</colgroup>
		<tr>
			<td align="center" class="blueBold">����</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" size="9" maxlength= "14" >
            </td>
			<td align="center" class="blueBold">�ٷα���</td>
			<td class="padding2423" align="left">
				<select id="cmbCD_GBN" style="width:90%" onChange="fnc_DocNmPopup(value);">
                   <option value="" ></option>
                   <option value="A">������</option>
                   <option value="B">�����</option>	
                   <option value="C">���������</option>
                   <option value="D">���������</option>	
                   <option value="E">�������ȸ��</option>
                   <option value="F">PJT</option>
                   <option value="G">���</option>	           
				</select>	
			</td>            
			<td align="center" class="blueBold">����</td>
			<td class="padding2423" align="left">
				<select id="cmbJOB_CD" style="width:90%">               
				</select>	
			</td>
			<td align="center" class="blueBold">����</td>
			<td class="padding2423" align="left">
				<select id="cmbHOB_CD" style="width:90%">                
				</select>		
			</td>
			

			<td align="center" class="blueBold" rowspan=2>�ٷ����</td>
            <td class="padding2423">
				<select id="cmbWPLACE_NM" style="width:90%" onChange="fnc_SitePopup(value);">>
                   <option value="" ></option>
                   <option value="A">����</option>
                   <option value="B">����</option>	
                   <option value="C">����</option>
				</select>	               
            </td>	

            	
		</tr>
		<tr>
			<td align="center" class="blueBold">�ٷαⰣ</td>
			<td class="padding2423" align="left" colspan=3>
				<input id="txtFROM_YMD" size="10" maxlength="10" >  ~
				<input id="txtTO_YMD" size="10" maxlength="10" >                
				<input id="txtMONTH" name="txtMONTH" size="5" maxlength= "5" >
			</td>		
			<td align="center" class="blueBold">����</td>
			<td class="padding2423" align="left">
				<select id="cmbSRV_CD" style="width:90%">
				</select>			
			</td>
			<td align="center" class="blueBold">ȣĪ</td>
            <td class="padding2423">
                <input id="txtCALL_NM" name="txtCALL_NM" size="15" maxlength= "15" >
            </td>				

			<!-- �ٷ����  -->
            <td class="padding2423">


				<input id="txtSITE_CD" name="txtSITE_CD" style="width:15%" 	maxlength="4" class="input_ReadOnly" readonly>
				<input id="txtSITE_NM" name="txtSITE_NM" size="10" maxlength="10" class="input_ReadOnly" readonly>
				<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgSITE_NM','','../../images/button/btn_HelpOver.gif',1)">
				<img src="../../images/button/btn_HelpOn.gif" id="imgSITE_NM_SHR" name="imgSITE_NM_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtSITE_CD','txtSITE_NM','�Ҽ�','AY');">
				</a>


            </td>	
		</tr>
		<tr>
			<td align="center" class="blueBold">������Ʈ</td>
			<td class="padding2423" align="left" colspan=3>
                <input id="txtPROJECT_NM" name="txtPROJECT_NM" size="50" maxlength= "50" >
			</td>	
			<td align="center" class="blueBold">������Ʈ�Ⱓ</td>
			<td class="padding2423" align="left" colspan=3>
				<input id="txtPRO_FROM" size="10" maxlength="10" >  ~
				<input id="txtPRO_TO" size="10" maxlength="10" >
			</td>
			
			<td align="center" class="blueBold">����</td>
            <td class="padding2423">
                <input id="txtWORK_NM" name="txtWORK_NM" size="20" maxlength= "50" >
            </td>	
		</tr>	
		<tr>
		<td align="center" class="blueBold">�⺻��</td>
            <td class="padding2423">


                        <input id="txtP01_AMT" style="width:90%" class="input_ReadOnly"  readonly>
        
            </td>		
            		
			<td align="center" class="blueBold">�ð��ܼ���</td>
            <td class="padding2423">
                        <input id="txtP02_AMT" style="width:90%" class="input_ReadOnly"  readonly>
            </td>	
            
			<td align="center" class="blueBold">���ϱٷμ���</td>
            <td class="padding2423">
                        <input id="txtP03_AMT" style="width:90%" > 
            </td>				
            
			<td align="center" class="blueBold">Ư��������</td>
            <td class="padding2423">
                        <input id="txtP04_AMT" style="width:90%" >
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
		
		
		<tr>
			<td class="padding2423" align="left" colspan=8>
			</td>			
			<td align="center" class="blueBold">�հ�</td>
            <td class="padding2423">
            
                 <input id="txtSUM_AMT" style="width:90%" class="input_ReadOnly"  readonly>  			
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
					<C> id="CD_GBN"		width=80	name="��������"		align=center	Edit=none    EditStyle=Lookup  Data="dsT_CM_COMMON_DA:CODE:CODE_NAME" </C>
					<C> id="ENO_NM"		width=60	name="����"			align=center	Edit=none	 </C>			
					<C> id="FROM_YMD"	width=70	name="������"			align=center	Edit=none	 </C>										
					<C> id="TO_YMD"		width=70	name="������"			align=center	Edit=none	 </C>
					<C> id="MONTH"		width=50	name="������"			align=center	Edit=none	 </C>
					<C> id="JOB_CD"		width=50	name="����"			align=center	Edit=none	 EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME" </C>
					<C> id="HOB_CD"		width=50	name="����"			align=center	Edit=none	 EditStyle=Lookup  Data="dsT_CM_COMMON_DC:CODE:CODE_NAME" </C>
					<C> id="SRV_CD"		width=60	name="����"			align=center	Edit=none	 EditStyle=Lookup  Data="dsT_CM_COMMON_DB:CODE:CODE_NAME" </C> 
					<C> id="WPLACE_NM"	width=60	name="�ٹ����"		align=center	Edit=none	 Value={Decode(WPLACE_NM,"A","����","B","����","C","����")}</C>	
					<C> id="SITE_NM"	width=180	name="�ٹ�����"		align=left		Edit=none	 </C>	
					<C> id="WORK_NM"	width=70	name="����"			align=left		Edit=none	 </C>					
					<C> id="CALL_NM"	width=70	name="ȣĪ"			align=left		Edit=none	 </C>
					<C> id="PROJECT_NM"	width=70	name="������Ʈ"		align=center	Edit=none	 </C>					
					<C> id="PRO_FROM"	width=70	name="���ν���"		align=center	Edit=none	 </C>						
					<C> id="PRO_TO"		width=70	name="��������"		align=center	Edit=none	 </C>
					
					<C> id="P01_AMT"	width=90	name="�⺻��"			align=right		Edit=none	 </C>	
					<C> id="P02_AMT"	width=90	name="�ð��ܼ���"		align=right		Edit=none	 </C>					
					<C> id="P03_AMT"	width=90	name="���ϼ���"		align=right		Edit=none	 </C>
					<C> id="P04_AMT"	width=90	name="Ư��������"		align=right		Edit=none	 </C>					
					<C> id="P05_AMT"	width=90	name="��������"		align=right		Edit=none	 </C>						
					<C> id="SUM_AMT"	width=90	name="�հ�"			align=right		Edit=none	 </C>					
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
			R E P O R T   D E F I N I T I O N   - #### ������ ####
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
	
	
	
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=278 ,right=868 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����� ������ �Ѵ�.' ,left=868 ,top=452 ,right=1677 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=69 ,top=492 ,right=1884 ,bottom=529 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ�' ,left=761 ,top=677 ,right=1910 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=108 ,top=572 ,right=1884 ,bottom=609 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=108 ,top=532 ,right=1884 ,bottom=569 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=677 ,right=370 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=69 ,top=717 ,right=370 ,bottom=754 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=632 ,right=1884 ,bottom=669 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ����:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ������' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ʿ� �� \'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1053 ,right=1881 ,bottom=1090 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=1013 ,right=1881 ,bottom=1050 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=929 ,right=1881 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=974 ,right=1884 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1360 ,right=1881 ,bottom=1397 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1320 ,right=1881 ,bottom=1357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1281 ,right=1881 ,bottom=1318 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1241 ,right=1881 ,bottom=1278 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1201 ,right=1881 ,bottom=1238 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٷνð� �� �ްԽð���' ,left=66 ,top=1117 ,right=1881 ,bottom=1154 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1162 ,right=1881 ,bottom=1199 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�������ϡ�' ,left=66 ,top=1426 ,right=1881 ,bottom=1463 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�Ͽ���) �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1471 ,right=1881 ,bottom=1508 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2252 ,right=1881 ,bottom=2289 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2297 ,right=1881 ,bottom=2334 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2336 ,right=1881 ,bottom=2373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2101 ,right=1881 ,bottom=2138 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2146 ,right=1881 ,bottom=2183 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2185 ,right=1881 ,bottom=2223 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1947 ,right=1881 ,bottom=1984 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	
	<C>id='ENO_NM', left=728, top=2185, right=937, bottom=2223, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=1992 ,right=1881 ,bottom=2029 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2032 ,right=1881 ,bottom=2069 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1797 ,right=1881 ,bottom=1834 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1842 ,right=1881 ,bottom=1879 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1881 ,right=1881 ,bottom=1918 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1728 ,right=1881 ,bottom=1765 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1683 ,right=1881 ,bottom=1720 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1535 ,right=1881 ,bottom=1572 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1580 ,right=1881 ,bottom=1617 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1619 ,right=1881 ,bottom=1656 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=974 ,right=786 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=452 ,right=466 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SRV_NM', left=302, top=826, right=558, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORK_NM', left=640, top=974, right=1250, bottom=1011, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=894, top=278, right=1103, bottom=315, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FROM_YMD', left=482, top=452, right=863, bottom=489 ,mask='XXXX�� XX�� XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=350, top=677, right=760, bottom=714, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���� �ϸ�, ������ ������ �濵���� ' ,left=1114 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='POS_NM', left=699, top=826, right=1109, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
	<T>id='~ 2021��12��31������ �Ѵ�.' ,left=881 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>



</R>
</A>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ����� ####
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
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=868, top=198, right=1109, bottom=235, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=198 ,right=1881 ,bottom=235 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=198 ,right=868 ,bottom=235 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=243 ,right=1881 ,bottom=280 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=347 ,right=553 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=971 ,top=347 ,right=1069 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1781 ,top=344 ,right=1879 ,bottom=381 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1476 ,top=347 ,right=1574 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=616, top=347, right=942, bottom=384 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=1132, top=344, right=1458, bottom=381 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='MONTH', left=1643, top=341, right=1773, bottom=378, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=302 ,right=1881 ,bottom=339 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=64 ,top=524 ,right=1879 ,bottom=561 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=103 ,top=603 ,right=1879 ,bottom=640 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=103 ,top=564 ,right=1879 ,bottom=601 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����� �翬�� ����ȴ�.' ,left=101 ,top=474 ,right=1876 ,bottom=511 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����, ���Ⱓ ���� �������� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶�' ,left=98 ,top=431 ,right=1873 ,bottom=468 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ϸ�, ���Ⱓ�� ����Ǿ� ������� �ƴ��� ��쿡 �ٷΰ���� �ڵ����� ����ȴ�.' ,left=98 ,top=389 ,right=1873 ,bottom=426 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=345, top=700, right=690, bottom=728, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=646 ,right=1884 ,bottom=683 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=69 ,top=730 ,right=370 ,bottom=767 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=691 ,right=370 ,bottom=728 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ' ,left=710 ,top=691 ,right=1881 ,bottom=728 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ������ ȣĪ�� �濵���� �ʿ� ��' ,left=968 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ȣĪ��' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SRV_NM', left=302, top=826, right=558, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALL_NM', left=699, top=826, right=955, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=958 ,right=1884 ,bottom=995 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORK_NM', left=700, top=958, right=1250, bottom=995, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1050 ,right=1881 ,bottom=1087 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=1008 ,right=1881 ,bottom=1045 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=966 ,right=786 ,bottom=1003 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=923 ,right=1881 ,bottom=960 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	
	<T>id='��6�������ϡ�' ,left=66 ,top=1400 ,right=1881 ,bottom=1437 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�Ͽ���) �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1445 ,right=1881 ,bottom=1482 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1148 ,right=1881 ,bottom=1185 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1188 ,right=1881 ,bottom=1225 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1228 ,right=1881 ,bottom=1265 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1267 ,right=1881 ,bottom=1304 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1307 ,right=1881 ,bottom=1344 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1347 ,right=1881 ,bottom=1384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٷνð� �� �ްԽð���' ,left=66 ,top=1103 ,right=1881 ,bottom=1140 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>


	
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1593 ,right=1881 ,bottom=1630 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1553 ,right=1881 ,bottom=1590 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1508 ,right=1881 ,bottom=1545 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1656 ,right=1881 ,bottom=1693 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1701 ,right=1881 ,bottom=1738 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1855 ,right=1881 ,bottom=1892 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1815 ,right=1881 ,bottom=1852 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1770 ,right=1881 ,bottom=1807 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2006 ,right=1881 ,bottom=2043 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=1966 ,right=1881 ,bottom=2003 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1921 ,right=1881 ,bottom=1958 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2159 ,right=1881 ,bottom=2196 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=728, top=2159, right=937, bottom=2196, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2119 ,right=1881 ,bottom=2156 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2074 ,right=1881 ,bottom=2111 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2310 ,right=1881 ,bottom=2347 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2270 ,right=1881 ,bottom=2307 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2225 ,right=1881 ,bottom=2262 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>
</R>
</A>
">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ��������� ####
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
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=868, top=198, right=1109, bottom=235, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=198 ,right=1881 ,bottom=235 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=198 ,right=868 ,bottom=235 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=243 ,right=1881 ,bottom=280 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=347 ,right=553 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=971 ,top=347 ,right=1069 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1781 ,top=344 ,right=1879 ,bottom=381 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1476 ,top=347 ,right=1574 ,bottom=384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=616, top=347, right=942, bottom=384 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=1132, top=344, right=1458, bottom=381 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='MONTH', left=1643, top=341, right=1773, bottom=378, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=302 ,right=1881 ,bottom=339 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=64 ,top=524 ,right=1879 ,bottom=561 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=103 ,top=603 ,right=1879 ,bottom=640 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=103 ,top=564 ,right=1879 ,bottom=601 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����� �翬�� ����ȴ�.' ,left=101 ,top=474 ,right=1876 ,bottom=511 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����, ���Ⱓ ���� �������� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶�' ,left=98 ,top=431 ,right=1873 ,bottom=468 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ϸ�, ���Ⱓ�� ����Ǿ� ������� �ƴ��� ��쿡 �ٷΰ���� �ڵ����� ����ȴ�.' ,left=98 ,top=389 ,right=1873 ,bottom=426 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=365, top=691, right=700, bottom=728, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=646 ,right=1884 ,bottom=683 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=69 ,top=730 ,right=370 ,bottom=767 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=691 ,right=370 ,bottom=728 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ' ,left=708 ,top=691 ,right=1901 ,bottom=728 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ������ ȣĪ�� �濵���� �ʿ� ��' ,left=968 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ȣĪ��' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SRV_NM', left=302, top=826, right=558, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALL_NM', left=699, top=826, right=955, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=958 ,right=1884 ,bottom=995 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORK_NM', left=700, top=958, right=1250, bottom=995, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1050 ,right=1881 ,bottom=1087 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=1008 ,right=1881 ,bottom=1045 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=966 ,right=786 ,bottom=1003 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=923 ,right=1881 ,bottom=960 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٹ��� �� ���ϡ�' ,left=66 ,top=1109 ,right=1881 ,bottom=1146 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ����� �� 5�� �ٹ��� ��Ģ���� �ϸ�, ������ �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1154 ,right=1881 ,bottom=1191 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�����ٷνð� �� �ްԽð���' ,left=66 ,top=1209 ,right=1881 ,bottom=1246 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1453 ,right=1881 ,bottom=1490 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1413 ,right=1881 ,bottom=1450 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1373 ,right=1881 ,bottom=1410 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1334 ,right=1881 ,bottom=1371 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1294 ,right=1881 ,bottom=1331 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1254 ,right=1881 ,bottom=1291 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1593 ,right=1881 ,bottom=1630 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1553 ,right=1881 ,bottom=1590 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1508 ,right=1881 ,bottom=1545 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1656 ,right=1881 ,bottom=1693 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1701 ,right=1881 ,bottom=1738 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1855 ,right=1881 ,bottom=1892 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1815 ,right=1881 ,bottom=1852 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1770 ,right=1881 ,bottom=1807 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2006 ,right=1881 ,bottom=2043 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=1966 ,right=1881 ,bottom=2003 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1921 ,right=1881 ,bottom=1958 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2159 ,right=1881 ,bottom=2196 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=728, top=2159, right=937, bottom=2196, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2119 ,right=1881 ,bottom=2156 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2074 ,right=1881 ,bottom=2111 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2310 ,right=1881 ,bottom=2347 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2270 ,right=1881 ,bottom=2307 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2225 ,right=1881 ,bottom=2262 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>
</R>
</A>


">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ��������� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print4  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='ENO_NM', left=868, top=172, right=1109, bottom=209, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=172 ,right=1881 ,bottom=209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=172 ,right=868 ,bottom=209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=217 ,right=1881 ,bottom=254 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1643, top=315, right=1773, bottom=352, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=1132, top=318, right=1458, bottom=355 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='FROM_YMD', left=616, top=320, right=942, bottom=357 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����' ,left=1476 ,top=320 ,right=1574 ,bottom=357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1781 ,top=318 ,right=1879 ,bottom=355 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=971 ,top=320 ,right=1069 ,bottom=357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=320 ,right=553 ,bottom=357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=275 ,right=1881 ,bottom=312 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ϸ�, ���Ⱓ�� ����Ǿ� ������� �ƴ��� ��쿡 �ٷΰ���� �ڵ����� ����ȴ�.' ,left=103 ,top=357 ,right=1879 ,bottom=394 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����, ���Ⱓ ���� �������� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶�' ,left=106 ,top=394 ,right=1881 ,bottom=431 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����� �翬�� ����ȴ�.' ,left=106 ,top=434 ,right=1881 ,bottom=471 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷΰ�༭' ,left=69 ,top=56 ,right=1886 ,bottom=138 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=108 ,top=516 ,right=1884 ,bottom=553 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=108 ,top=556 ,right=1884 ,bottom=593 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=69 ,top=476 ,right=1884 ,bottom=513 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORK_NM', left=700, top=947, right=1250, bottom=984, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALL_NM', left=699, top=799, right=955, bottom=836, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SRV_NM', left=302, top=799, right=558, bottom=836, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=365, top=651, right=700, bottom=688, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1027 ,right=1881 ,bottom=1064 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=947 ,right=1884 ,bottom=984 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=947 ,right=786 ,bottom=984 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=902 ,right=1881 ,bottom=939 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=987 ,right=1881 ,bottom=1024 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ɷ� �� ���� ���� �����Ͽ� ������ �� �ִ�.' ,left=69 ,top=839 ,right=1884 ,bottom=876 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ȣĪ��' ,left=69 ,top=754 ,right=1884 ,bottom=791 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=799 ,right=304 ,bottom=836 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=561 ,top=799 ,right=704 ,bottom=836 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ������ ȣĪ�� �濵���� �ʿ� ��' ,left=968 ,top=799 ,right=1881 ,bottom=836 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=606 ,right=1884 ,bottom=643 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=69 ,top=691 ,right=370 ,bottom=728 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=651 ,right=370 ,bottom=688 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ' ,left=708 ,top=651 ,right=1901 ,bottom=688 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2437 ,right=1881 ,bottom=2474 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2511 ,right=437 ,bottom=2548 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2511 ,right=161 ,bottom=2548 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2569 ,right=434 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2696 ,right=429 ,bottom=2744 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2641 ,right=429 ,bottom=2678 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2643 ,right=167 ,bottom=2680 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2508 ,right=1299 ,bottom=2545 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�  ��  ��  ��' ,left=447 ,top=2569 ,right=831 ,bottom=2606 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2561 ,right=939 ,bottom=2609 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=870 ,top=2688 ,right=942 ,bottom=2736 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2503 ,right=1013 ,bottom=2678</I>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1646 ,right=1881 ,bottom=1683 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1606 ,right=1881 ,bottom=1643 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1561 ,right=1881 ,bottom=1598 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1709 ,right=1881 ,bottom=1746 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1754 ,right=1881 ,bottom=1791 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1908 ,right=1881 ,bottom=1945 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1868 ,right=1881 ,bottom=1905 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1823 ,right=1881 ,bottom=1860 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2058 ,right=1881 ,bottom=2096 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=2019 ,right=1881 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1974 ,right=1881 ,bottom=2011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>

	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2212 ,right=1881 ,bottom=2249 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=728, top=2212, right=937, bottom=2249, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>


	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2172 ,right=1881 ,bottom=2209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2127 ,right=1881 ,bottom=2164 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2363 ,right=1881 ,bottom=2400 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2323 ,right=1881 ,bottom=2360 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2278 ,right=1881 ,bottom=2315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=108 ,top=1500 ,right=1879 ,bottom=1537 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=64 ,top=1463 ,right=1879 ,bottom=1500 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٹ��� �� ���ϡ�' ,left=66 ,top=1082 ,right=1881 ,bottom=1119 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ����� �� 6�� �ٹ��� ��Ģ���� �ϸ�, ������ �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1127 ,right=1881 ,bottom=1164 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð����� ������.' ,left=111 ,top=1426 ,right=1881 ,bottom=1463 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷνð��� �����غ�ð� �� �����ð�, ��/�ϼ��ð����� �����ϸ� �߰��������ð���' ,left=66 ,top=1386 ,right=1881 ,bottom=1423 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1347 ,right=1881 ,bottom=1384 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1307 ,right=1881 ,bottom=1344 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1267 ,right=1881 ,bottom=1304 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�����ٷνð� �� �ްԽð���' ,left=66 ,top=1183 ,right=1881 ,bottom=1220 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1228 ,right=1881 ,bottom=1265 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=466 ,top=2569 ,right=693 ,bottom=2606 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='( �� )' ,left=1066 ,top=2416 ,right=1177 ,bottom=2453 ,align='right' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �������ȸ�� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print5  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2278 ,right=1881 ,bottom=2315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2323 ,right=1881 ,bottom=2360 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2363 ,right=1881 ,bottom=2400 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2127 ,right=1881 ,bottom=2164 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2172 ,right=1881 ,bottom=2209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	
	
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2212 ,right=1881 ,bottom=2249 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=728, top=2212, right=937, bottom=2249, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	
	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1974 ,right=1881 ,bottom=2011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=2019 ,right=1881 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2058 ,right=1881 ,bottom=2096 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1823 ,right=1881 ,bottom=1860 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1868 ,right=1881 ,bottom=1905 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1908 ,right=1881 ,bottom=1945 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=164 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=217 ,right=1881 ,bottom=254 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=172 ,right=868 ,bottom=209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=172 ,right=1881 ,bottom=209 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=868, top=172, right=1109, bottom=209, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1778 ,right=1881 ,bottom=1815 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1733 ,right=1881 ,bottom=1770 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=64 ,top=1685 ,right=1879 ,bottom=1722 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=64 ,top=1646 ,right=1879 ,bottom=1683 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=64 ,top=1601 ,right=1879 ,bottom=1638 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�����ٷνð� �� �ްԽð���' ,left=56 ,top=1312 ,right=1871 ,bottom=1349 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=101 ,top=1556 ,right=1871 ,bottom=1593 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=56 ,top=1516 ,right=1871 ,bottom=1553 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=56 ,top=1476 ,right=1871 ,bottom=1513 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=56 ,top=1437 ,right=1871 ,bottom=1474 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=56 ,top=1397 ,right=1871 ,bottom=1434 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=56 ,top=1357 ,right=1871 ,bottom=1394 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٹ��� �� ���ϡ�' ,left=58 ,top=1212 ,right=1873 ,bottom=1249 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٹ����� �� 5�� �ٹ��� ��Ģ���� �ϸ�, ������ �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=58 ,top=1257 ,right=1873 ,bottom=1294 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=58 ,top=1032 ,right=1873 ,bottom=1069 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=58 ,top=1074 ,right=778 ,bottom=1111 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=58 ,top=1117 ,right=1873 ,bottom=1154 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=58 ,top=1159 ,right=1873 ,bottom=1196 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORK_NM', left=700, top=1066, right=1250, bottom=1103, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1159 ,top=1066 ,right=1876 ,bottom=1103 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ������ ȣĪ�� �濵���� �ʿ� ��' ,left=958 ,top=937 ,right=1871 ,bottom=974 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=550 ,top=937 ,right=693 ,bottom=974 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=58 ,top=937 ,right=294 ,bottom=974 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ȣĪ��' ,left=58 ,top=892 ,right=1873 ,bottom=929 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=58 ,top=976 ,right=1873 ,bottom=1013 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SRV_NM', left=291, top=937, right=548, bottom=974, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALL_NM', left=688, top=937, right=945, bottom=974, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=355, top=796, right=690, bottom=833, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��2�����ٷ���ҡ�' ,left=58 ,top=751 ,right=1873 ,bottom=788 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=58 ,top=836 ,right=360 ,bottom=873 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=58 ,top=796 ,right=360 ,bottom=833 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ� ' ,left=697 ,top=796 ,right=1891 ,bottom=833 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ϸ�, ���Ⱓ�� ����Ǿ� ������� �ƴ��� ��쿡 �ٷΰ���� �ڵ����� ����ȴ�.' ,left=101 ,top=381 ,right=1876 ,bottom=418 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����, ���Ⱓ ���� �������� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶�' ,left=101 ,top=423 ,right=1876 ,bottom=460 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����� �翬�� ����ȴ�.' ,left=103 ,top=466 ,right=1879 ,bottom=503 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=69 ,top=294 ,right=1884 ,bottom=331 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='MONTH', left=1646, top=333, right=1775, bottom=370, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='TO_YMD', left=1135, top=336, right=1461, bottom=373 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='FROM_YMD', left=619, top=339, right=945, bottom=376 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����' ,left=1479 ,top=339 ,right=1577 ,bottom=376 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1783 ,top=336 ,right=1881 ,bottom=373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=974 ,top=339 ,right=1072 ,bottom=376 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=71 ,top=339 ,right=556 ,bottom=376 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������� �������� �������� ��ȸ��� �̰���ų �� ������, �� ��� �������� �������� ��ȸ���' ,left=103 ,top=664 ,right=1879 ,bottom=701 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ä����� �� ������ �ٿ� ����, �������� �濵�� �ʿ信 ���� ���� ���� ��ȸ�縦 �����ϰ�, ' ,left=69 ,top=627 ,right=1884 ,bottom=664 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=64 ,top=508 ,right=1879 ,bottom=545 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=103 ,top=548 ,right=1879 ,bottom=585 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=103 ,top=587 ,right=1879 ,bottom=624 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Ҽ��� �����ϵ�, ��1�� 1���� ���Ⱓ �� ��7���� �ӱ��� �����ϰ� �����ϱ�� �Ѵ�.' ,left=103 ,top=704 ,right=1879 ,bottom=741 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
</B>
</R>
</A>

">
</OBJECT>

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### �������� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print6  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�  ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��13������Ÿ��' ,left=66 ,top=2252 ,right=1881 ,bottom=2289 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2297 ,right=1881 ,bottom=2334 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2336 ,right=1881 ,bottom=2373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=164 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2212 ,right=1881 ,bottom=2249 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=728, top=2212, right=937, bottom=2249, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>

	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2164 ,right=1881 ,bottom=2201 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2119 ,right=1881 ,bottom=2156 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=64 ,top=2066 ,right=1879 ,bottom=2103 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=64 ,top=2027 ,right=1879 ,bottom=2064 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����Ұ��׷¡�' ,left=64 ,top=1982 ,right=1879 ,bottom=2019 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=64 ,top=1924 ,right=1879 ,bottom=1961 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=64 ,top=1884 ,right=1879 ,bottom=1921 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��10�������������' ,left=64 ,top=1839 ,right=1879 ,bottom=1876 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������ް���' ,left=64 ,top=1741 ,right=1879 ,bottom=1778 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=64 ,top=1786 ,right=1879 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1685 ,right=1881 ,bottom=1722 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1646 ,right=1881 ,bottom=1683 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�����ӱݡ�' ,left=66 ,top=1601 ,right=1881 ,bottom=1638 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�������ϡ�' ,left=64 ,top=1503 ,right=1879 ,bottom=1540 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�Ͽ���) �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=64 ,top=1548 ,right=1879 ,bottom=1585 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1257 ,right=1881 ,bottom=1294 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1296 ,right=1881 ,bottom=1334 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1336 ,right=1881 ,bottom=1373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1376 ,right=1881 ,bottom=1413 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1416 ,right=1881 ,bottom=1453 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1455 ,right=1881 ,bottom=1492 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�����ٷνð� �� �ްԽð���' ,left=66 ,top=1212 ,right=1881 ,bottom=1249 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��೻���� ������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1154 ,right=1881 ,bottom=1191 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ' ,left=66 ,top=1111 ,right=1881 ,bottom=1148 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=1069 ,right=786 ,bottom=1106 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������������' ,left=66 ,top=1027 ,right=1881 ,bottom=1064 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, ' ,left=1273 ,top=1069 ,right=1879 ,bottom=1106 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WORK_NM', left=700, top=1072, right=1267, bottom=1109, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CALL_NM', left=699, top=929, right=955, bottom=966, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SRV_NM', left=302, top=929, right=558, bottom=966, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������ �� ������ �Ϲ��� ���� �� �޿��� ������ ����.' ,left=69 ,top=968 ,right=1884 ,bottom=1005 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4�������� �� ȣĪ��' ,left=69 ,top=884 ,right=1884 ,bottom=921 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=929 ,right=304 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ȣĪ:' ,left=561 ,top=929 ,right=704 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� �ϸ�, ȣĪ�� �������Ǹ� ���� �ο��ϴ�' ,left=968 ,top=929 ,right=1881 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='WPLACE_NM', left=350, top=826, right=900, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=')(��)�� �Ѵ�.' ,left=900 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�����ٷ���ҡ�' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=826 ,right=370 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=64 ,top=643 ,right=1879 ,bottom=680 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=103 ,top=722 ,right=1879 ,bottom=759 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=103 ,top=683 ,right=1879 ,bottom=720 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������Ʈ�� �Ϸ�ǰų� �������� ����ϰ� �ִ� ������ ����� ���, ���Ⱓ ���� ���̶�' ,left=101 ,top=556 ,right=1876 ,bottom=593 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� �ƴ��� ��쿡 �ٷΰ���� �ڵ����� ����ȴ�. ����, ���Ⱓ ���� ' ,left=98 ,top=511 ,right=1873 ,bottom=548 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ����� �翬�� ����ȴ�.' ,left=98 ,top=595 ,right=1873 ,bottom=632 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ϸ�, ���Ⱓ�� ����Ǿ�' ,left=1204 ,top=471 ,right=1871 ,bottom=508 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TO_YMD', left=873, top=471, right=1199, bottom=508,  face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����' ,left=767 ,top=471 ,right=865 ,bottom=508 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='FROM_YMD', left=434, top=471, right=759, bottom=508 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=58 ,top=471 ,right=429 ,bottom=508 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2�����ٷΰ��Ⱓ��' ,left=58 ,top=429 ,right=1873 ,bottom=466 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\��\'�� ������ ������Ʈ�� �Ⱓ��' ,left=71 ,top=333 ,right=900 ,bottom=370 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�̸�, �������� ��Ȳ �� ��Ÿ ���ǿ� ���� ������ �� �ִ�.' ,left=101 ,top=376 ,right=1876 ,bottom=413 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1����������Ʈ�Ⱓ��' ,left=69 ,top=288 ,right=1884 ,bottom=325 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PRO_TO', left=1426, top=331, right=1752, bottom=368, mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='PRO_FROM', left=910, top=333, right=1236, bottom=370 ,mask='XXXX��XX��XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<T>id='����' ,left=1770 ,top=333 ,right=1868 ,bottom=370 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=1265 ,top=333 ,right=1363 ,bottom=370 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=235, top=193, right=476, bottom=230, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�ٷ��� ' ,left=71 ,top=193 ,right=228 ,bottom=230 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� ����ƻ�(��)(���� �������̶� ��)��  ' ,left=479 ,top=193 ,right=1884 ,bottom=230 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������Ʈ�� ������ �������� ���ù��� �ǰ� �ٷΰ���� ü���Ѵ�.' ,left=593 ,top=238 ,right=1884 ,bottom=275 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PROJECT_NM', left=69, top=238, right=587, bottom=275, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='\��\�� ������ ������ ���Ͽ� Ÿ�ο��� �˸��ų� Ÿ���� ������ �˷��� ���� ������, ������ ' ,left=66 ,top=1786 ,right=1881 ,bottom=1823 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ���ݻ��׿� ���� ����� ����� �������� �ʴ´�. ���� ������ ������ ������ �����ϴ� ��� ' ,left=66 ,top=1831 ,right=1881 ,bottom=1868 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡�� ������ �� �� ������, �̷� ���� �����Ϳ� ���Ǹ� �������� �ʴ´�. ' ,left=66 ,top=1876 ,right=1881 ,bottom=1913 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������޹����' ,left=66 ,top=1466 ,right=1881 ,bottom=1503 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5������   �롽' ,left=71 ,top=1976 ,right=1886 ,bottom=2013 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \��\�� ���� ���� å���� �����׿� �����ϸ�, ��⿡ ��õ��� ���� ������ ȸ�簡 ���� ���� ' ,left=71 ,top=2019 ,right=1886 ,bottom=2056 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='�� \��\�� ������ �⺻��, �ð��ܡ����ϱٷμ���, Ư�������� �� �������� �� ���� �� ������ ' ,left=69 ,top=807 ,right=1884 ,bottom=844 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
	<T>id='~ 2021��12��31������ �Ѵ�.' ,left=852 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>

</R>
</A>

">
</OBJECT>



<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   - #### ��� ####
------------------------------------------------------------------------------>

<OBJECT id=gcrp_print7  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
  	<PARAM NAME="MasterDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="DetailDataID"				VALUE="dsT_CM_CONTRACT_PRINT">
  	<PARAM NAME="PrintSetupDlgFlag" 		VALUE="true">
  	<PARAM NAME="Landscape"					VALUE="0">
	<PARAM NAME="PaperSize"					VALUE="A4">
	<PARAM NAME="FixPaperSize"				VALUE="TRUE">
	<param NAME="PrintMargine"      		VALUE="false">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format"            		VALUE="
	
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='1��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2799 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�ٷΰ�༭' ,left=69 ,top=79 ,right=1886 ,bottom=191 ,face='��ü�� ����ü' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ������ ���� �ٷΰ���� ü���Ѵ�.' ,left=66 ,top=323 ,right=1881 ,bottom=360 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��1�����ٷΰ��Ⱓ��' ,left=66 ,top=407 ,right=1881 ,bottom=445 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) (���� �������̶� ��)�� �ٷ��� ' ,left=69 ,top=278 ,right=868 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(���� �������̶� ��)(��)�� �����ǻ翡 ' ,left=1114 ,top=278 ,right=1881 ,bottom=315 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ����� ������ �Ѵ�.' ,left=868 ,top=452 ,right=1677 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� \'��\'�� ���� �Ի��Ϸκ��� 3������ �ÿ�(����) �Ⱓ�� �д�. �ÿ�Ⱓ �� �Ǵ� ' ,left=69 ,top=492 ,right=1884 ,bottom=529 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=')(��)�� �ϸ�, \'��\'�� �濵�� ���� �Ǵ� �λ�� ��å�� ���Ͽ�' ,left=761 ,top=677 ,right=1910 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� �ִ�.' ,left=108 ,top=572 ,right=1884 ,bottom=609 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ÿ�Ⱓ�� ����� �ڷμ�, ��ӱٷΰ� �������ϴٰ� �����Ǵ� ��� \'��\'�� �� ����� ����' ,left=108 ,top=532 ,right=1884 ,bottom=569 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ������ (' ,left=69 ,top=677 ,right=370 ,bottom=714 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �� �ִ�.' ,left=69 ,top=717 ,right=370 ,bottom=754 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��2�����ٷ���ҡ�' ,left=69 ,top=632 ,right=1884 ,bottom=669 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=', ����:' ,left=561 ,top=826 ,right=704 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� ����:' ,left=69 ,top=826 ,right=304 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��3�������� �� ������' ,left=69 ,top=781 ,right=1884 ,bottom=818 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ʿ� �� \'��\'�� �����ɷ� �� ���� ���� �����Ͽ� �����Ģ�� ���� ������ �� �ִ�.' ,left=69 ,top=865 ,right=1884 ,bottom=902 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ ��Ż���� �ʴ� �� �̸� �ؼ��Ͽ��� �Ѵ�.' ,left=66 ,top=1053 ,right=1881 ,bottom=1090 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ʿ信 ���� �̸� ������ �� �ִ�. \'��\'�� �̿� ���Ͽ� ���ǰ� ������, ��೻����' ,left=66 ,top=1013 ,right=1881 ,bottom=1050 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��4������������' ,left=66 ,top=929 ,right=1881 ,bottom=966 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=') �� �׿� �μ��� ������ �ϸ�, \'��\'��' ,left=1167 ,top=974 ,right=1884 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷθ� ���� �� ����.' ,left=111 ,top=1360 ,right=1881 ,bottom=1397 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� \'��\'�� Ư���� ������ ���� ��� �ٹ��ð��� ������ �� ������, ���� ����, �߰�, ����' ,left=66 ,top=1320 ,right=1881 ,bottom=1357 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ްԽð� (���� - 12:00~13:00) (���� - 09:00~09:15, 11:30~13:00, 15:00~15:15)' ,left=66 ,top=1281 ,right=1881 ,bottom=1318 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �þ� �� �����ð��� ����� ������ ���Ͽ� ������.(���� 09:00~18:00) (����:07:00~18:00)' ,left=66 ,top=1241 ,right=1881 ,bottom=1278 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �����ٷνð��� ���� �������� �����Ͽ� �� 209�ð����� ��.' ,left=66 ,top=1201 ,right=1881 ,bottom=1238 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��5�����ٷνð� �� �ްԽð���' ,left=66 ,top=1117 ,right=1881 ,bottom=1154 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷνð��� �ްԽð��� �����ϰ� 1�� 8�ð����� �Ѵ�.' ,left=66 ,top=1162 ,right=1881 ,bottom=1199 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��6�������ϡ�' ,left=66 ,top=1426 ,right=1881 ,bottom=1463 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������(�Ͽ���) �� �����Ģ���� ���� ���� ���Ϸ� �Ѵ�.' ,left=66 ,top=1471 ,right=1881 ,bottom=1508 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��12������Ÿ��' ,left=66 ,top=2252 ,right=1881 ,bottom=2289 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� ��༭�� ������ ���� ������ \'��\'�� ���� �� ���� �� ���� ��ħ�� ������� �ϸ�, ' ,left=66 ,top=2297 ,right=1881 ,bottom=2334 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ܿ� ������ ���� ������ �ٷα��ع��ɿ� ���Ѵ�.' ,left=66 ,top=2336 ,right=1881 ,bottom=2373 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��11�����ٷΰ�༭�� ���Ρ�' ,left=66 ,top=2101 ,right=1881 ,bottom=2138 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷΰ���� ü���԰� ���ÿ� �� ��༭�� �纻�Ͽ� \'��\'�� ���ο䱸�� �������' ,left=66 ,top=2146 ,right=1881 ,bottom=2183 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �����Ѵ�. (���� �޾��� :                       ) (��)' ,left=66 ,top=2185 ,right=1881 ,bottom=2223 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>	<T>id='��10�����Ұ��׷¡�' ,left=66 ,top=1947 ,right=1881 ,bottom=1984 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	
	<C>id='ENO_NM', left=728, top=2185, right=937, bottom=2223, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	
	<T>id='\'��\'�� �����ϰ� �ִ� ����� Ư������ ����Ͽ�, \'��\'�� ��å���� ���� ����� �ߴܵǰų�, ' ,left=66 ,top=1992 ,right=1881 ,bottom=2029 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������ �ߴܵǾ� ����� �������� ���� ��쿡 �ٷΰ���� �ڵ� �����ȴ�.' ,left=66 ,top=2032 ,right=1881 ,bottom=2069 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��9�������������' ,left=66 ,top=1797 ,right=1881 ,bottom=1834 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �� ��� �Ǵ� �ٷα��ع� �� �����Ģ�� �����ϰų� �ǹ��� �������� �ƴ��� ��,' ,left=66 ,top=1842 ,right=1881 ,bottom=1879 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ڴ� ����� ������ �� �ִ�.' ,left=66 ,top=1881 ,right=1881 ,bottom=1918 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �ٷα��ع����� ���ϴ� �ٿ� ���� \'��\'���� ���������ް��� �ο��Ѵ�.' ,left=66 ,top=1728 ,right=1881 ,bottom=1765 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��8�������������ް���' ,left=66 ,top=1683 ,right=1881 ,bottom=1720 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��7�����ӱݡ�' ,left=66 ,top=1535 ,right=1881 ,bottom=1572 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� \'��\'�� �ٷο� ���� �밡�� ȸ�系�Կ� ���� �ٿ� ���� �ӱ��� �ſ� 25�Ͽ� �����ϸ�,' ,left=66 ,top=1580 ,right=1881 ,bottom=1617 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ӱ��� ���γ����� �޿����� �� ���� ������༭���� ���� �ٿ� ������.' ,left=66 ,top=1619 ,right=1881 ,bottom=1656 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=839 ,top=2477 ,right=1013 ,bottom=2651</I>
	<T>id='(��)' ,left=870 ,top=2662 ,right=942 ,bottom=2709 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=868 ,top=2535 ,right=939 ,bottom=2582 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ǥ�̻�   ��  ��  ��' ,left=447 ,top=2543 ,right=831 ,bottom=2580 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����Ư���� ���α� ����� 194 ����ƻ�(��)' ,left=447 ,top=2482 ,right=1299 ,bottom=2519 ,align='left' ,face='����' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=79 ,top=2617 ,right=167 ,bottom=2654 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2614 ,right=429 ,bottom=2651 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2670 ,right=429 ,bottom=2717 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :' ,left=235 ,top=2543 ,right=434 ,bottom=2580 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=77 ,top=2484 ,right=161 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��    �� :  ' ,left=238 ,top=2484 ,right=437 ,bottom=2521 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='������� :          ��     ��     ��' ,left=74 ,top=2410 ,right=1881 ,bottom=2447 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\'��\'�� �������� \'��\'�� ���� ����(' ,left=66 ,top=974 ,right=786 ,bottom=1011 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �ٷΰ��Ⱓ��' ,left=69 ,top=452 ,right=466 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='SRV_NM', left=302, top=826, right=558, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='WORK_NM', left=640, top=974, right=1250, bottom=1011, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=894, top=278, right=1103, bottom=315, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FROM_YMD', left=482, top=452, right=863, bottom=489 ,mask='XXXX�� XX�� XX��', face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='{decode(WPLACE_NM,\'A\',\'����\',\'B\',\'����\',\'C\',\'����\',WPLACE_NM)}', left=350, top=677, right=760, bottom=714, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���� �ϸ�, ������ ������ �濵���� ' ,left=1114 ,top=826 ,right=1881 ,bottom=863 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='POS_NM', left=699, top=826, right=1109, bottom=863, face='����', size=11, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>

</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
<R>id='2��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132  
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
	<T>id='��  ��  ��' ,left=468 ,top=2569 ,right=667 ,bottom=2606 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��) ' ,left=468 ,top=2490 ,right=683 ,bottom=2527 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=1585 ,top=2572 ,right=1656 ,bottom=2619 ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='../../images/common/asan_dojang.gif' ,left=699 ,top=2492 ,right=873 ,bottom=2667</I>
	<T>id='~ 2021��12��31������ �Ѵ�.' ,left=881 ,top=452 ,right=1730 ,bottom=489 ,align='left' ,face='��ü�� ����ü' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>



</R>
</A>

">
</OBJECT>




</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--**************************************************************************************
   *                                       												 *
*	���ε� ������Ʈ																			 *
   *                                       												 *
   ***************************************************************************************-->
<!-- T_CM_CONTRACT ���� ���̺� -->
<object id="bndT_CM_CONTRACT" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_CM_CONTRACT">
	<Param Name="BindInfo", Value="
		<C>Col=ENO_NM			Ctrl=txtENO_NM			Param=value</C>
		<C>Col=CD_GBN			Ctrl=cmbCD_GBN			Param=value</C>
		<C>Col=JOB_CD			Ctrl=cmbJOB_CD			Param=value</C>
		<C>Col=HOB_CD			Ctrl=cmbHOB_CD			Param=value</C>
		<C>Col=SRV_CD			Ctrl=cmbSRV_CD			Param=value</C>
		<C>Col=FROM_YMD			Ctrl=txtFROM_YMD		Param=value</C>
		<C>Col=TO_YMD			Ctrl=txtTO_YMD			Param=value</C>
		<C>Col=MONTH			Ctrl=txtMONTH			Param=value</C>
		<C>Col=WPLACE_NM		Ctrl=cmbWPLACE_NM		Param=value</C>
		
		<C>Col=SITE_CD			Ctrl=txtSITE_CD			Param=value</C>		
		<C>Col=SITE_NM			Ctrl=txtSITE_NM			Param=value</C>
		
		<C>Col=WORK_NM			Ctrl=txtWORK_NM			Param=value</C>
		<C>Col=CALL_NM			Ctrl=txtCALL_NM			Param=value</C>
		<C>Col=PROJECT_NM		Ctrl=txtPROJECT_NM		Param=value</C>
		<C>Col=PRO_FROM			Ctrl=txtPRO_FROM		Param=value</C>
		<C>Col=PRO_TO			Ctrl=txtPRO_TO			Param=value</C>
		<C>Col=AMT_GBN			Ctrl=cmbAMT_GBN			Param=value</C>

		<C>Col=P01_AMT			Ctrl=txtP01_AMT			Param=value</C>
		<C>Col=P02_AMT			Ctrl=txtP02_AMT			Param=value</C>
		<C>Col=P03_AMT			Ctrl=txtP03_AMT			Param=value</C>
		<C>Col=P04_AMT			Ctrl=txtP04_AMT			Param=value</C>
		<C>Col=P05_AMT			Ctrl=txtP05_AMT			Param=text</C>
		<C>Col=SUM_AMT			Ctrl=txtSUM_AMT			Param=value</C>
	">
</object>
	
	
	