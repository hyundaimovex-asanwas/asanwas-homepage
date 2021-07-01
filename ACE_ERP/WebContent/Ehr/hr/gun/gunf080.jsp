<!--
*****************************************************
* @source      : gunf080.jsp
* @description : �ٹ� ������ ���� PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/12/20      �̵���        ���� �ۼ�
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>

<html>
<head>
<title> �ٹ� ������ ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<jsp:include page="/Security/common/include/head.jsp"/>
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


    	var icnt = 0;
    	var today = gcurdate;
    
    	
    	var morning_sy_before  = 0;
    	var morning_bun_before = 0;
    	var after_sy_before    = 0;
    	var after_bun_before   = 0;   	
    	
    	
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			//�˻�����
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//�Ҽ�				
			var eno_no = document.form1.txtENO_NO_SHR.value;	//���

			dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
			dsT_DI_WORKSTYLE.reset();
		
        }

        
        
        /***************************
         *    �ٹ�  ������  ��ȸ   *
         ***************************/
        function fnc_SearchList2(eno_no) {

        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;        	

        	dsT_DI_WORKSCHEDULE.ClearData();
        	dsT_DI_WORKSCHEDULE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_01&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","");
        	dsT_DI_WORKSCHEDULE.Reset();
        	
        	
        	
    	    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
    	    	
    	    	//���°��� �����̰ų� ����̰ų� �Ϸᰡ �Ǹ� �ϰ� �ݿ� ��ư�� ���� 2021.01.28 �׳� ���δϱ� ������� �����Ѵ�. ���� �迬�� ����
    	        if (dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'A' || dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'Y' || dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'S') {	    	
    	    	
    		    	document.getElementById("btn_Batch").style.display = "none";
    		    	
    		    	break;
    		    	
    	        }else{
    	        	
    	        	document.getElementById("btn_Batch").style.display = "";
    	        	
    	        }
    	        
    	    }
        	

        }        
        
        
        /***************************
         *    �ٹ�  ������  ��ȸ   *
         ***************************/
        function fnc_SearchList3(eno_no, tra_week) {

        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;           	
        	
        	dsT_DI_WORKSCHEDULE_DETAIL.ClearData();
        	dsT_DI_WORKSCHEDULE_DETAIL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","")+"&WEEK_NO="+tra_week;
        	dsT_DI_WORKSCHEDULE_DETAIL.Reset();

        }           
        

        
        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

        	
			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			
			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");		

			//����Ŭ�� �Է������� ���°� ��������� ��쿡�� ms sql �ʿ� �ݿ����ֱ� ���ؼ�
			cfCopyDataSet(dsT_DI_WORKSCHEDULE, dsT_DI_WORKSCHEDULE_CP, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_DI_WORKSCHEDULE.CountRow);

			//ds copy�� Status�� ������ �����Ƿ� tr���� �Ѱ����� insert�� update�� ���� ���Ѵ�.
            for(var i=1; i<=dsT_DI_WORKSCHEDULE_CP.CountRow; i++) {

            	dsT_DI_WORKSCHEDULE_CP.UserStatus(i) = 1;

            }			
			
			trT_DI_WORKSTYLE.KeyValue = "tr01(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE)";
			trT_DI_WORKSTYLE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SAV&ENO_NO="+ENO_NO;
			trT_DI_WORKSTYLE.post();


			// Oracle ������ �ڿ� Ms-Sql ������ �������ֱ�
			var param = "proType=A";   	
			ln_TRSetting(tr1, "../../../servlet/security.menu.li.MSSQL010",  "JSP(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE_CP)",  param);
			tr_post(tr1);	 		     
			
			fnc_SearchList2(ENO_NO);      

        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {
        	

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
            if (dsT_DI_WORKSCHEDULE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_WORKSCHEDULE.GridToExcel("�ٹ� ������ ��Ȳ", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {


        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {


        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {


        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

        	window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {
        	

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���
            if (!dsT_DI_WORKSCHEDULE.IsUpdated ) {
            	
				alert("������ �ڷᰡ �����ϴ�.");
				
				fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
				
		        return false;
		        
			}
			
			var temp_week = 0;
			var week_work_time = 0;
			var month_temp_time = 0;
			
            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {

            	month_temp_time = month_temp_time + parseFloat(dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME"));

            }
            

			
			if(month_temp_time > 208){
				
				alert("�Ѵ� �ִ� �ٹ� �ð��� 208�ð��� �ʰ��Ǿ����ϴ�.");
				
				return false;
			}               
            
            
			
            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {

            	temp_week = dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO");
            	
                	for(var j=1; j<=7; j++) {

                		if(dsT_DI_WORKSCHEDULE.NameValue(i-1,"WEEK_NO") != dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO")){
                		
                			week_work_time = parseFloat(dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME"));
                			
                			break;                			
                			
                		}else if(temp_week == dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO")){
                			
                			week_work_time = week_work_time + parseFloat(dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME"));
                			 
                			//alert("WEEK_NO = " + dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO") + " i = " + i +" temp_week = " + temp_week + " " + dsT_DI_WORKSCHEDULE.NameValue(i,"REG_YMD") + " week_work_time === " + week_work_time);
                    		
                			if(week_work_time > 64){
                				
                				alert(dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO") + "�������� 64�ð� �ʰ��Ǿ����ϴ�.");
                				
                				return false;
                			}
                			
							break;
							
                		}else{

                			week_work_time = 0;
                			
                			break;
                			
                		}

                	}
                
            }

            return true;	
        	
        }

        
        
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {


			cfStyleGrid_New(form1.grdT_DI_WORKSTYLE,0,"true","true");
			cfStyleGrid_New(form1.grdT_DI_WORKSCHEDULE,0,"true","false");
			
            document.getElementById("txtPIS_YM_SHR").value = gcurdate.substring(0,7);


            
            
    		//�����Ͱ� �ƴϸ� �Ҽ� �μ��� ��ȸ �ϰ�
    	    if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070019" || gusrid == "2070020") {

                document.getElementById("txtDPT_CD_SHR").value = '';
                document.getElementById("txtDPT_NM_SHR").value = '';
                
                document.getElementById("txtENO_NO_SHR").value = ''; 
                document.getElementById("txtENO_NM_SHR").value = '';    

    		}else{          
            
	            document.getElementById("txtDPT_CD_SHR").value = gdeptcd;
	            document.getElementById("txtDPT_NM_SHR").value = gdeptnm;
	            
	            document.getElementById("txtENO_NO_SHR").value = gusrid;  
	            document.getElementById("txtENO_NM_SHR").value = gusrnm;            
            
	            
	            document.getElementById("txtDPT_CD_SHR").readOnly = true;
	            document.getElementById("txtDPT_CD_SHR").className = "input_ReadOnly";
  			
	            document.getElementById("txtDPT_NM_SHR").readOnly = true;
	            document.getElementById("txtDPT_NM_SHR").className = "input_ReadOnly";
	            
	         	fnc_ChangeStateElement(false, "Image30");
	            
	            
	            document.getElementById("txtENO_NO_SHR").readOnly = true;
	            document.getElementById("txtENO_NO_SHR").className = "input_ReadOnly";
  			
	            document.getElementById("txtENO_NM_SHR").readOnly = true;
	            document.getElementById("txtENO_NM_SHR").className = "input_ReadOnly";	            
	            
	         	fnc_ChangeStateElement(false, "ImgEnoNoShr");
	         	
    		}  

			fnc_SearchList();
			
			
			
			
			//document.getElementById("imgSearch").style.display = "none";			
			
			
        }

        
		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

	    function fnc_GetNm() {
	    	
               fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','0','0');
               //fnc_SearchList();
        }

	    
        function fnc_Getcd() {
        	
               fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');
               //fnc_SearchList();
        }


		/********************
         * 16. �ϰ� �ݿ�    *
         *******************/
		function fnc_Batch() {

			
			var morning_sy  = 0;
			var morning_bun = 0;
			var after_sy    = 0;				
			var after_bun   = 0;	
			var work_time = 0;
			
			
			if (confirm("���۽ð��� ����ð��� �ϰ� �ݿ��Ͻðڽ��ϱ�?\n\n�ٹ�ǥ �ۼ��� ���� ��ư�� �����ñ� �ٶ��ϴ�.") == false) return;

			
			//�ٹ����°� ��/�����/��õ�� ���			
			if(dsT_DI_WORKSCHEDULE.NameValue(i,"JOB_OCC") == "3"){
			
		            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
		            	
		            
		            	if(dsT_DI_WORKSCHEDULE.NameValue(i,"DILIGENCE") == ""){ // ���� ���°� ���� ��쿡�� �ϰ� �ݿ��ǵ���
		            		
		            	
			                if(dsT_DI_WORKSCHEDULE.NameValue(i,"HOL_YN") == "N"){
			
				            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME")   = document.getElementById("cmbSTR_TIME").value;
				            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE") = document.getElementById("cmbSTR_MINUTE").value;
				                dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME")   = document.getElementById("cmbEND_TIME").value;	            	
				                dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE") = document.getElementById("cmbEND_MINUTE").value;	  
				                
				                morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME");
				                morning_bun = dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE");
				                after_sy    = dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME");	
				                after_bun   = dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE");	
			
								if(after_sy == 24 && after_bun == 30 ) {
									alert("�Ұ����� �ð��Դϴ�.\n\n�ٽ� �������ֽʽÿ�.");
					            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME")   = '';
					            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE") = '';
					                dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME")   = '';	            	
					                dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE") = '';
					                dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME") = '';
					                document.getElementById("cmbEND_MINUTE").value = '00';
									break;   				
								}
								
								var morning_hour = 0;
								var morning_minute = 0;
								var after_hour = Number(after_sy) - 13;
								var after_minute = Number(after_bun);					
								var work_minute = 0;
			
								if(morning_sy <= 12 ) {
									morning_hour = 11 - Number(morning_sy);
									if(document.getElementById("cmbSTR_MINUTE").value == 00 ) {
										morning_minute = 30 + Number(morning_bun);
									}else{
										morning_minute = 00 ;
									}
								}else{
									morning_hour = Number(morning_sy) - 13;
									morning_minute = Number(morning_bun);
								}						

								if(morning_minute + after_minute == 30 ) {
									work_minute = 0.5;
								}else if(morning_minute + after_minute == 60 ) {
									work_minute = 1;						
								}else{
									work_minute = 0;
								}				
			
								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME") = morning_hour + after_hour + work_minute;
			
								var inputData = morning_hour + after_hour + "�ð�"; 

				                if (work_minute == '0.5' ){   		//�Ҽ��� �ڰ� �����ϸ�
				                	inputData = inputData + " 30��";
				                }else if(work_minute == '1' ){   		//�Ҽ��� �ڰ� �����ϸ�
				                	inputData = morning_hour + after_hour + 1 + "�ð�";
				                }

								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;
								
			                }
			                
		            	}
		            			dsT_DI_WORKSCHEDULE.UserStatus(i) = 1;
		            }
            
		            
			//�ٹ����°� �Ϲ������� ���		            
			}else if(dsT_DI_WORKSCHEDULE.NameValue(i,"JOB_OCC") == "5"){

		            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
		        		
		            	if(dsT_DI_WORKSCHEDULE.NameValue(i,"DILIGENCE") == ""){ // ���� ���°� ���� ��쿡�� �ϰ� �ݿ��ǵ���		            	
		            	
			                if(dsT_DI_WORKSCHEDULE.NameValue(i,"HOL_YN") == "N"){
			
				            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME")   = document.getElementById("cmbSTR_TIME").value;
				            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE") = document.getElementById("cmbSTR_MINUTE").value;
				                dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME")   = document.getElementById("cmbEND_TIME").value;	            	
				                dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE") = document.getElementById("cmbEND_MINUTE").value;	  
				                
				                morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME");
				                morning_bun = dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE");
				                after_sy    = dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME");	
				                after_bun   = dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE");	
			
								if(after_sy == 24 && after_bun == 30 ) {
									alert("�Ұ����� �ð��Դϴ�.\n\n�ٽ� �������ֽʽÿ�.");
					            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME")   = '';
					            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE") = '';
					                dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME")   = '';	            	
					                dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE") = '';
					                dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME") = '';
					                document.getElementById("cmbEND_MINUTE").value = '00';
									break;   				
								}
								
								var morning_hour = 0;
								var morning_minute = 0;
								var after_hour = Number(after_sy) - 13;
								var after_minute = Number(after_bun);					
								var work_minute = 0;
			
								if(morning_sy <= 12 ) {
									morning_hour = 11 - Number(morning_sy);
									morning_minute = 00 - Number(morning_bun);
								}else{
									morning_hour = Number(morning_sy) - 13;
									morning_minute = Number(morning_bun);
								}						
								
								if(morning_minute + after_minute == 30 ) {
									work_minute = 0.5;
								}else if(morning_minute + after_minute == -30 ) {
									work_minute = -0.5;						
								}else{
									work_minute = 0;
								}				
			
								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME") = morning_hour + after_hour + work_minute;
			
								var inputData = morning_hour + after_hour + "�ð�"; 

				                if (work_minute == '0.5' ){   		//�Ҽ��� �ڰ� �����ϸ�
				                	inputData = inputData + " 30��";
				                }else if(work_minute == '1' ){   		//�Ҽ��� �ڰ� �����ϸ�
				                	inputData = morning_hour + after_hour + 1 + "�ð�";
				                }

								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;
								
			                }
		            	
		            	}
		            	
            					dsT_DI_WORKSCHEDULE.UserStatus(i) = 1;
            					
	            	}				
				

				
			//�ٹ����°� �Ϲ�����/��/�����/��õ�� �ƴ� ���
			}else{
				
				alert("����ڿ��� �����ٶ��ϴ�.");
				return false;
				
			}

		}        
        
		

		/*************************
         * 17. ���� ��� ó��    *
         ************************/
		function fnc_Conduct() {
			
			
			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
			var TEAM_CD = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "TEAM_CD");
			
			
			dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&TEAM_CD="+TEAM_CD;	
			dsT_DI_APPROVAL.Reset();			

			
			// �ڵ� ���缱 üũ
			if(dsT_DI_APPROVAL.CountRow < 1) {
				alert("�ڵ����缱 ������ �����ϴ�.\n\n�����ڿ��� �����ϼ���.");
				return;
			}
			

			if(!confirm("��û������ ������� �Ͻðڽ��ϱ�?")) return;

			
        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;   
			
			dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_MAX";
			dsT_DI_REQNO.reset();

			var REQ_NO = dsT_DI_REQNO.NameValue(1, "REQ_NO");
				    
		    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {				    
	    		
		    	dsT_DI_WORKSCHEDULE.UserStatus(i) = 1;
	    	
		    }
		    
		    for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {				    
	    		
		    	dsT_DI_APPROVAL.UserStatus(i) = 1;
	    	
		    }		    
		    
		    
			trT_DI_WORKSCHEDULE.KeyValue = "tr01(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			trT_DI_WORKSCHEDULE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=UPT_APP&REQ_NO="+REQ_NO+"&GUN_YMD="+PIS_YM;
			trT_DI_WORKSCHEDULE.post();			
			
		}		
		

		
		/*************************
         * 18. ���� ��� ó��    *
         ************************/
		function fnc_Conduct_Each() {
			

			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
			var TEAM_CD = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "TEAM_CD");
			
			
			dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&TEAM_CD="+TEAM_CD;	
			dsT_DI_APPROVAL.Reset();			
			
			
			// �ڵ� ���缱 üũ
			if(dsT_DI_APPROVAL.CountRow < 1) {
				alert("�ڵ����缱 ������ �����ϴ�.\n\n�����ڿ��� �����ϼ���.");
				return;
			}
			

			//���� ���°��� ������ ��쿡�� ���� ����� �����ϴ�. ����/���/�ΰ�/�Ϸ� ��� ���� ��� �Ұ���
			if(!confirm("��û������ ������� �Ͻðڽ��ϱ�?")) return;

			
			dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_MAX2";
			dsT_DI_REQNO.reset();

			var req_no = dsT_DI_REQNO.NameValue(1, "REQ_NO");

		    for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {				    
	    		
		    	dsT_DI_APPROVAL.UserStatus(i) = 1;
	    	
		    }		
		    
			//alert(req_no);
			
			trT_DI_WORKSCHEDULE.KeyValue = "tr01(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			
			trT_DI_WORKSCHEDULE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD"
																			+ "&S_MODE=UPT_APP_EACH" // ���� ��� ���
																			+ "&GUN_YMD=" +today.replace("-","").replace("-","") // ���ó�¥
																			+ "&REQ_NO=" +req_no //
																			;
			
			//prompt(this, dsT_DI_APPROVAL.text);
			
			trT_DI_WORKSCHEDULE.post();
			

		}				
		

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_WORKSTYLE                    |
    | 3. Table List : T_DI_WORKSTYLE                |
    +----------------------------------------------->
    <Object ID="dsT_DI_WORKSTYLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <Object ID="dsT_DI_WORKSCHEDULE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <Object ID="dsT_DI_WORKSCHEDULE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    
    
    <Object ID="dsT_DI_WORKSCHEDULE_DETAIL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    
    

    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>    


    <Object ID="dsT_DI_REQNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(dsT_DI_WORKSTYLE)   |
    | 3. ���Ǵ� Table List(T_DI_WORKSTYLE)	        |
    +--------------------------------------------------->
    <Object ID ="trT_DI_WORKSTYLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>


    <Object ID ="trT_DI_WORKSCHEDULE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="toinb_dataid4">
        <param name=TimeOut     value=2000000>
    </Object>
    
    
    
	<!-----------------------------------------------------------------------------
		  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
	------------------------------------------------------------------------------>
	

	<object  id="tr1" classid="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>

    
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            //alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_WORKSTYLE.focus();
        }

    </Script>


    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSCHEDULE_DETAIL Event="OnLoadCompleted(iCount)">

		    var inputData;
		    var buf  = "";
		    var buf2  = "";
		    var splitData = new Array();
		    
		    splitData = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"WEEK_TOTAL_TIME").toString().split("."); // "." ���� ������.

		    buf = splitData[0];	
		    buf2 = splitData[1];
		    
		    if (buf == '0' ){   		
		    	inputData = ''; 
		    }else{
		    	inputData = buf + "�ð�"; 
		    }

		    if (buf2 == '25' ){   			
		    	inputData = inputData + " 15��";
		    }else if (buf2 == '5' ){   		
		    	inputData = inputData + " 30��";
		    }else if (buf2 == '75' ){   	
		    	inputData = inputData + " 45��";                
		    }
		    
		    
		    
		    
		    
		    
		    var inputData2;
		    var bbuf  = "";
		    var bbuf2  = "";
		    var splitData2 = new Array();
		    
		    splitData2 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME").toString().split("."); // "." ���� ������.

		    bbuf = splitData2[0];	
		    bbuf2 = splitData2[1];
		    
		    if (bbuf == '0' ){   		
		    	inputData2 = ''; 
		    }else if (bbuf == '' ){
		    	inputData2 = ''; 			    	
		    }else{
		    	inputData2 = bbuf + "�ð�"; 
		    }

		    if (bbuf2 == '25' ){   			
		    	inputData2 = inputData2 + " 15��";
		    }else if (bbuf2 == '5' ){   		
		    	inputData2 = inputData2 + " 30��";
		    }else if (bbuf2 == '75' ){   	
		    	inputData2= inputData2 + " 45��";                
		    }		    
		    
            if (inputData2 == '' ){   			//0�ð��̸� ��ĭ���� �����°� ����
            	inputData2 = '0�ð�'; 
            }  		    
		    
            
            
		    var inputData3;
		    var bbuf3  = "";
		    var bbuf33  = "";
		    var splitData3 = new Array();
		    
		    splitData3 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"MONTH_TOTAL_TIME").toString().split("."); // "." ���� ������.

		    bbuf3 = splitData3[0];	
		    bbuf33 = splitData3[1];
		    
		    if (bbuf3 == '0' ){   		
		    	inputData3 = ''; 
		    }else{
		    	inputData3 = bbuf3 + "�ð�"; 
		    }

		    if (bbuf33 == '25' ){   			
		    	inputData3 = inputData3 + " 15��";
		    }else if (bbuf33 == '5' ){   		
		    	inputData3 = inputData3 + " 30��";
		    }else if (bbuf33 == '75' ){   	
		    	inputData3= inputData3 + " 45��";                
		    }		    
		    
            if (inputData3 == '' ){   			//0�ð��̸� ��ĭ���� �����°� ����
            	inputData3 = '0�ð�'; 
            }  		    
		    
            
            
		    var inputData4;
		    var bbuf4  = "";
		    var bbuf44  = "";
		    var splitData4 = new Array();
		    
		    splitData4 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME2").toString().split("."); // "." ���� ������.

		    bbuf4 = splitData4[0];	
		    bbuf44 = splitData4[1];
		    
		    if (bbuf4 == '0' ){   		
		    	inputData4 = ''; 
		    }else if (bbuf4 == '' ){
		    	inputData4 = ''; 		    	
		    }else{
		    	inputData4 = bbuf4 + "�ð�"; 
		    }

		    if (bbuf44 == '25' ){   			
		    	inputData4 = inputData4 + " 15��";
		    }else if (bbuf44 == '5' ){   		
		    	inputData4 = inputData4 + " 30��";
		    }else if (bbuf44 == '75' ){   	
		    	inputData4= inputData4 + " 45��";                
		    }		    
		    
            if (inputData4 == '' ){   			//0�ð��̸� ��ĭ���� �����°� ����
            	inputData4 = '0�ð�'; 
            }  		 
            
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD") = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(0,4) + "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(4,2)+ "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(6,2);
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD") = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(0,4) + "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(4,2)+ "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(6,2);
		    dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"WEEK_TOTAL_TIME") = inputData;    
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME") = inputData2;
		    dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"MONTH_TOTAL_TIME") = inputData3;    
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME2") = inputData4;
        	
        	
        	
        	
        	
    </Script>



    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSCHEDULE Event="OnLoadCompleted(iCount)">

	    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {

	        if (dsT_DI_WORKSCHEDULE.NameValue(i, "DILIGENCE") != '') {

            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_TIME")   = '';
            	dsT_DI_WORKSCHEDULE.NameValue(i,"STR_MINUTE") = '';
                dsT_DI_WORKSCHEDULE.NameValue(i,"END_TIME")   = '';	            	
                dsT_DI_WORKSCHEDULE.NameValue(i,"END_MINUTE") = '';
                dsT_DI_WORKSCHEDULE.NameValue(i,"STATUS") = '';                

	        }
	        
	       
	        //if (dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'S') {
            //	dsT_DI_WORKSCHEDULE.NameValue(i,"CHK")   = 'T';
	        //}	        
	        
	        
                var inputData;

                var buf  = "";
                var buf2  = "";
    	        
                var splitData = new Array();
                
                splitData = dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME").toString().split("."); // "." ���� ������.
                
                buf = splitData[0];	
                buf2 = splitData[1];

                if (buf == '0' ){   			
                	inputData = ''; 
                }else{
                	inputData = buf + "�ð�"; 
                }

                if (buf2 == '25' ){   			//�������� ���Ͽ� 0.25�� 15��
                	inputData = inputData + " 15��";
                }else if (buf2 == '5' ){   		//�������� ���Ͽ� 0.5�� 30��
                	inputData = inputData + " 30��";
                }else if (buf2 == '75' ){   	//�������� ���Ͽ� 0.75�� 45��
                	inputData = inputData + " 45��";                
                }
                
                dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;

	    }

	    
	    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
	    	
	    	//���°��� ����̰ų� ���� ��� ��ư�� ����... ������ ���� ����� ���ؼ� �ϵ��� + Grid Disable ���·� ����
	        if (dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'A' ) {	    	
	    	
		    	document.getElementById("btn_apply").style.display = "none";
		    	
		    	break;
		    	
		    //���°��� �Ϸ��̸� ���� ��� ��ư�� ����... ������ ���� ����� ���ؼ� �ϵ���	
	        }else if(dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'Y'){
	        	
		    	document.getElementById("btn_apply").style.display = "none";
		    	
		    	break;
		    	
	        }else{
	        	
	        	document.getElementById("btn_apply").style.display = "";
	        	
	        }
	        
	    }
	    
	    //Data Set �� Normal�� Update~
	    dsT_DI_WORKSCHEDULE.ResetStatus();
	    	
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | header�� Ŭ�������� �̹ݿ� ����Ÿ ��� üũ
    +------------------------------------------------------>
    <script language="javascript" for=grdT_DI_WORKSCHEDULE event=OnHeadCheckClick(Col,Colid,bCheck)>

        if(Colid == "CHK" && dsT_DI_WORKSCHEDULE.CountRow > 0) {
        	
	            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
	
	                if(bCheck == "1") {
	                	
	                	dsT_DI_WORKSCHEDULE.NameString(i, "CHK") = "T";
	                    
	                } else {
	                	
	                	dsT_DI_WORKSCHEDULE.NameString(i, "CHK") = "F";
	                    
	                }
	                
	            }
	            
        }
    </script>


    <!------------------------------+
    | �׸����� ROW�� Ŭ�� �Ҷ�      |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSTYLE Event="OnClick(row, col)">
    
    //Header Ŭ���� �� ��������
	if(row != "0"){    
    
        eno_no   = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");

        fnc_SearchList2(eno_no);
        
	}
	

    </Script>


	<script language=JavaScript for=grdT_DI_WORKSCHEDULE event=OnListSelect(index)>
	

		//�ٹ����°� ��/�����/��õ�� ���			
		if(dsT_DI_WORKSCHEDULE.NameValue(1,"JOB_OCC") == "3"){

		        morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
		        morning_bun = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
		        after_sy    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
		        after_bun   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");	
	
				if(after_sy == 24 && after_bun == 30 ) {
					alert("�Ұ����� �ð��Դϴ�.\n\n�ٽ� �������ֽʽÿ�.");          	
		            dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") = '00';	
		            return false;
				}
				
				//'S','����','A','���','C','����','N','�ΰ�','Y','�Ϸ�'
                if (dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'A' ){   		//���°� ����̸� ���� �Ұ���
					alert("�̹� ��ŵǾ����ϴ�.\n\n����Ϸ� �� �����ϼž� �մϴ�.");          	
		            return false;
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'S'){   	//���°� �����̸� �Ȱ��� ������·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "S";
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'N'){   	//���°� �ΰ��̸� �Ȱ��� �ΰ���·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "N";                
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'Y'){   	//���°� �Ϸ��̸� �Ȱ��� �ΰ���·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "Y";  
                }						
				
				
				
				var morning_hour = 0;
				var morning_minute = 0;
				var after_hour = Number(after_sy) - 13;
				var after_minute = Number(after_bun);					
				var work_minute = 0;

				if(morning_sy <= 12 ) {
					morning_hour = 11 - Number(morning_sy);
					if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE") == 00 ) {
						morning_minute = 30 + Number(morning_bun);
					}else{
						morning_minute = 00 ;
					}
				}else{
					morning_hour = Number(morning_sy) - 13;
					morning_minute = Number(morning_bun);
				}						

				if(morning_minute + after_minute == 30 ) {
					work_minute = 0.5;
				}else if(morning_minute + after_minute == 60 ) {
					work_minute = 1;						
				}else{
					work_minute = 0;
				}				


				dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME") = morning_hour + after_hour + work_minute;

				var inputData = morning_hour + after_hour + "�ð�"; 

                if (work_minute == '0.5' ){   		//�Ҽ��� �ڰ� �����ϸ�
                	
                	//alert(inputData);
                	
                	if(inputData == '0'){ 
                		inputData = "30��"
                	}else{
                		inputData = inputData + " 30��";
                	}
                
                }else if(work_minute == '1' ){   		//�Ҽ��� �ڰ� �����ϸ�
                	inputData = morning_hour + after_hour + 1 + "�ð�";
                }

				dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = inputData;
				
				
		
							
				
		//�ٹ����°� �Ϲ������� ���			
		}else if(dsT_DI_WORKSCHEDULE.NameValue(1,"JOB_OCC") == "5"){	
		
		        morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
		        morning_bun = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
		        after_sy    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
		        after_bun   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");	
		
				if(after_sy == 24 && after_bun == 30 ) {
					alert("�Ұ����� �ð��Դϴ�.\n\n�ٽ� �������ֽʽÿ�.");          	
		            dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") = '00';	
		            return false;
				}
				
				
				//4ĭ�� ��� ä���� ������ ��굵 ���� ����. �����.
				if(morning_sy == "" || morning_bun == "" || after_sy == "" || after_bun == ""){

					return;
					
				}
				
				//����ð��� ���۽ð����� ���� �� ����
				if(morning_sy > after_sy ){

					alert("����ð��� ���۽ð����� ���� �� �����ϴ�.");
					
					morning_sy = "";
					morning_bun = "";
					after_sy = "";
					after_bun = "";
					inputData = "";
					
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") = "";					
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = "";
	                
					return false;
					
				}
				
				//alert(morning_sy);
				
				//���۽ð��� 9�� ����
				/* 2020.12.01 �̷� ���� ���� ������ �� Ǯ����� ��������
				if(morning_sy > 9 ){
					
					alert("���۽ð��� 9�� �������� �����ٶ��ϴ�.");
					dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = "";					
					return false;
					
				}
				
				//����ð��� 17�� ����
				if(after_sy < 17 ){
					
					alert("����ð��� 17�� ���ķ� �����ٶ��ϴ�.");
					dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = "";					
					return false;
					
				}
				*/
				
				
				//'S','����','A','���','C','����','N','�ΰ�','Y','�Ϸ�'
                if (dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'A' ){   		//���°� ����̸� ���� �Ұ���
					alert("�̹� ��ŵǾ����ϴ�.\n\n����Ϸ� �� �����ϼž� �մϴ�.");          	
		            return false;
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'S'){   	//���°� �����̸� �Ȱ��� ������·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "S";
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'N'){   	//���°� �ΰ��̸� �Ȱ��� �ΰ���·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "N";                
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'Y'){   	//���°� �Ϸ��̸� �Ȱ��� �ΰ���·� ����
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "Y";  
                }						
				
				var morning_hour = 0;
				var morning_minute = 0;
				var after_hour = 0;
				var after_minute = Number(after_bun);					
				var work_minute = 0;
		
				
				//������ �ƴ� ���
				if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"HOL_YN") == 'N' ) {
				
						after_hour = Number(after_sy) - 13;					
					
						if(morning_sy < 12 ) {
							morning_hour = 11 - Number(morning_sy);
							morning_minute = 00 - Number(morning_bun);
						}else if(morning_sy = 12){
							morning_hour = Number(morning_sy) - 12;
							morning_minute = 00 - Number(morning_bun);							
						}else{
							morning_hour = Number(morning_sy) - 13;
							morning_minute = Number(morning_bun);
						}						
						
						if(morning_minute + after_minute == 30 ) {
							work_minute = 0.5;
						}else if(morning_minute + after_minute == -30 ) {
								work_minute = -0.5;
						}else{
							work_minute = 0;
						}				

						
				//������ ���		
				}else{		

						after_hour = Number(after_sy) - 12;					
						
						morning_hour = 12 - Number(morning_sy);
						morning_minute = 00 - Number(morning_bun);
						/*
						if(morning_sy <= 12 ) {
							morning_hour = 12 - Number(morning_sy);
							morning_minute = 00 - Number(morning_bun);
						}else{
							morning_hour = Number(morning_sy) - 12;
							morning_minute = Number(morning_bun);
						}						
						*/
						
						if(morning_minute + after_minute == 30 ) {
							work_minute = 0.5;
						}else if(morning_minute + after_minute == -30 ) {
								work_minute = -0.5;
						}else{
							work_minute = 0;
						}		

					
				}
				
				
				
				//alert("morning_sy ===" + morning_sy);
				//alert("morning_minute ===" + morning_minute);		
				//alert("after_sy ===" + after_sy);
				//alert("after_minute ===" + after_minute);
				//alert("morning_hour ===" + morning_hour);
				//alert("after_hour ===" + after_hour);
				//alert("work_minute ===" + work_minute);				
				
				
				
				dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME") = morning_hour + after_hour + work_minute;
				

				var inputData = morning_hour + after_hour + "�ð�"; 

                if (work_minute == '0.5' ){   		//�Ҽ��� �ڰ� �����ϸ�
                	
                	if(inputData == '0'){ 
                		inputData = "30��"
                	}else{
                		inputData = inputData + " 30��";
                	}

                }else if(work_minute == '1' ){   		//
                	inputData = morning_hour + after_hour + 1 + "�ð�";

                }else if(work_minute == '-0.5' ){   		//
                	inputData = morning_hour + after_hour - 1 + "�ð� 30��";                

                }

				dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = inputData;

		}
				
				


        
        //alert(morning_sy_before);
        
        //alert(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME"));
        /*
        if (morning_sy_before != dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME") || 
        	morning_bun_before != dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE") ||		
        	after_sy_before    != dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME") ||	
        	after_bun_before   != dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") 	) {
        	

			dsT_DI_WORKSCHEDULE.UserStatus(dsT_DI_WORKSCHEDULE.RowPosition) = 1;
			
			
		}		
		*/
		
		
	</script>
	

    <!------------------------------+
    | �׸����� ROW�� Ŭ�� �Ҷ�      |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSCHEDULE Event="OnClick(row, col)">

    
	    morning_sy_before  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
	    morning_bun_before = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
	    after_sy_before    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
	    after_bun_before   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");		     
    
    
        var eno_no     = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition, "ENO_NO");
        
        var tra_week   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition, "WEEK_NO");
        

        if (col == 'CHK')    {

        	//'S','����','A','���','C','����','N','�ΰ�','Y','�Ϸ�'
        	//���°� ����, �ΰ��̸� üũ �ȵǵ���
            if (dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'S' || dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'N')    {        	
        	
            	alert("�ٹ� �ð��� �����Ͻð� ������� �Ͻñ� �ٶ��ϴ�.\n\n���°��� �������� Ȯ���Ͻð� üũ�Ͻñ� �ٶ��ϴ�.");
            	dsT_DI_WORKSCHEDULE.NameString(row, "CHK") = "F";
            	
            //���°� �Ϸ��̸� üũ �ǵ���	
            }else if(dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'Y'){	            
            
            	alert("�ٹ� �ð��� �����Ͻð� ������� �Ͻñ� �ٶ��ϴ�.\n\n���°��� �������� Ȯ���Ͻð� üũ�Ͻñ� �ٶ��ϴ�.");
            	dsT_DI_WORKSCHEDULE.NameString(row, "CHK") = "F";            	
            
            }else{	
            	
            	
	            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {

		            	if(icnt != 0) {
				                if(dsT_DI_WORKSCHEDULE.NameString(i, "CHK") == "T") {
				                	document.getElementById("btn_applyeach").style.display = "";
				                	icnt = 1;
				                	break;
				                } else {
				                	document.getElementById("btn_applyeach").style.display = "none";
				                	icnt = 0;				                
				                }
		                
		            	}else{
				                if(dsT_DI_WORKSCHEDULE.NameString(i, "CHK") == "T") {
				                	document.getElementById("btn_applyeach").style.display = "";
				                	icnt = 1;
				                	break;
				                } else {
				                	document.getElementById("btn_applyeach").style.display = "none";
				                	icnt = 0;
				                }
		            	}
	            }
	            
	            
            }

        }


        fnc_SearchList3(eno_no, tra_week);

    </Script>


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSCHEDULE Event="OnDblClick(row, col)">

        if (dsT_DI_WORKSCHEDULE.NameValue(row, "EDIT") == 'N')    {

            if(dsT_DI_WORKSCHEDULE.NameValue(row, "DILIGENCE") != '')    {
            	
            	alert("���� ���� �ڷᰡ �����մϴ�.");
            	
            }else{
            	
            	var click = today.replace("-","").replace("-","");
          	
                if (dsT_DI_WORKSCHEDULE.NameValue(row, "REG_YMD") < click)    {            	
            	
            		alert("���� �ڷ�� �����Ͻ� �� �����ϴ�");
                
                }else{

                    if (dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'A')    {
                    	
                    	alert("������̹Ƿ� ������ �� �����ϴ�.\n\n�����ڿ��� �����ϼ���.");

                        return false;
                        
                    }
                    
                }
            	
            }

        }

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_DI_WORKSCHEDULE event="OnSuccess()">
    
    	alert("���������� ó���Ǿ����ϴ�.");
    
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        
		var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
		
		fnc_SearchList2(ENO_NO);        	
        
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_DI_WORKSCHEDULE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

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
            <span id="btn_apply" style="display:none">
	   			<img src="../../images/button/ApplyOver.gif" name="imgApply" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();">
            </span>				
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>	        
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="50"></col>
                                <col width="100"></col>
                                <col width="80"></col>      
                                <col width="150"></col>
                                <col width="100"></col>                                
                                <col width="150"></col>
                                <col width="100"></col>                     
                                <col width="*"></col>
                            </colgroup>
                            <tr>
			                    <td align="center" class="blueBold">�ش��</td>
								<td class="padding2423" align="left">
									<input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								</td>                            
					            <td align="right" class="blueBold">�� ��&nbsp;</td>
								<td class="padding2423">
									<input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									<input id=txtDPT_NM_SHR size="10">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="Image30" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
									</a>
								</td>
                                <td align="right" class="searchState">���&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="if(event.keyCode==13){fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9" onkeypress="if(event.keyCode==13){fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','3', '1', '', '');"></a>
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




<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="bottom" class="searchState" width="100%" height="20"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>	 
		<td height="35" class="paddingTop5" align="right">
            <span id="btn_applyeach" style="display:none">
				<img src="../../images/button/ApplyEachOver.gif" name="imgApplyEach" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Conduct_Each();">	
            </span>		
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
					<td rowspan="2">
						<comment id="__NSID__">
						<object	id="grdT_DI_WORKSTYLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:400px;height:445px;">
							<param name="DataID"				value="dsT_DI_WORKSTYLE">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='{CUROW}'		width=20			name=''					Edit=None	align=center			value={String(Currow)}		</C>
								<C> id='HEAD_NM'		width=80			name='����'				Edit=None	align=left				show=false</C>								
								<C> id='DPT_NM'			width=65			name='�Ҽ�'				Edit=None	align=left				</C>
								<C> id='DPT_CD'			width=70			name='�Ҽ�'				Edit=None	align=left				show=false</C>								
								<C> id='JOB_OCC'		width=70			name='�ٹ�����'			Edit=None	align=left				show=false</C>								
								<C> id='TEAM_NM'		width=100			name='��Ʈ/����'			Edit=None	align=left				</C>								
								<C> id='JOB_NM'			width=80			name='����'				Edit=None	align=center			</C>
								<C> id='ENO_NO'			width=50			name='���'				Edit=None	align=center			</C>
								<C> id='ENO_NM'			width=55			name='����'				Edit=None	align=center			</C>
								<C> id='GBN_NM'			width=70			name='�ٹ���'				Edit=None	align=center			show=false</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td>	
						<!-- ���۽ð� ����ð� �ϰ��ݿ�-->
						<table width="580" border="0" cellspacing="0" cellpadding="0">
						    <tr>
						        <td class="paddingTop8">
						            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						                <colgroup>
						                    <col width="50"></col>
						                    <col width="200"></col>
						                    <col width="50"></col>
						                    <col width="200"></col>            
						                    <col width=""></col>
						                </colgroup>
						                <tr>
						                    <td align="center" class="blueBold">����</td>
						                    <td class="padding2423">
						                        <select id="cmbSTR_TIME" name="cmbSTR_TIME" style="WIDTH: 35%">
						                           <option value='07'>07</option>
						                           <option value='08'>08</option>
						                           <option value='09'>09</option>
						                           <!--  �̷��� �پ��� ��� �ð��� ���� ������� ����. 2020.05.20 
						                           <option value='10'>10</option>
						                           <option value='11'>11</option>
						                           <option value='12'>12</option>
						                           <option value='13'>13</option>
						                           <option value='14'>14</option>       
						                           <option value='15'>15</option>
						                           <option value='16'>16</option>
						                           <option value='17'>17</option>
						                           <option value='18'>18</option>
						                           <option value='19'>19</option>
						                           <option value='20'>20</option>
						                           <option value='21'>21</option> 
						                           <option value='22'>22</option>
						                           <option value='23'>23</option>
						                           <option value='24'>24</option>
						                           -->                             
						                        </select>
						                        ��
						                        <select id="cmbSTR_MINUTE" name="cmbSTR_MINUTE" style="WIDTH: 35%">
						                           <option value='00'>00</option>
						                           <option value='30'>30</option>
						                        </select>						                        
						                        ��
						                    </td>
						                    <td align="center" class="blueBold">����</td>
						                    <td class="padding2423">
						                        <select id="cmbEND_TIME" name="cmbEND_TIME" style="WIDTH: 35%">
						                        	<!--  �̷��� �پ��� ��� �ð��� ���� ������� ����. 2020.05.20 
						                           <option value='07'>07</option>
						                           <option value='08'>08</option>
						                           <option value='09'>09</option>
						                           <option value='10'>10</option>
						                           <option value='11'>11</option>
						                           <option value='12'>12</option>
						                           <option value='13'>13</option>
						                           <option value='14'>14</option>       
						                           <option value='15'>15</option>
						                           <option value='16'>16</option>
						                           -->
						                           <option value='17'>17</option>
						                           <option value='18'  selected>18</option>
						                           <option value='19'>19</option>
						                           <!--  
						                           <option value='20'>20</option>
						                           <option value='21'>21</option> 
						                           <option value='22'>22</option>
						                           <option value='23'>23</option>
						                           <option value='24'>24</option>
						                           -->                             
						                        </select>
						                        ��
						                        <select id="cmbEND_MINUTE" name="cmbEND_MINUTE" style="WIDTH: 35%">
						                           <option value='00'>00</option>
						                           <option value='30'>30</option>                    
						                        </select>						                        
						                        ��						                        
						                    </td>
						                    
						                    <!--  
						                    <td class="padding2423">
						                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgBatch','','../../images/button/BatchAdjustOn.gif',1)">
						                    <img src="../../images/button/BatchAdjustOn.gif" name="imgSearch" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Batch()">
						                    </a>
						                    </td>-->
						                    
											<td class="padding2423">
									            <span id="btn_Batch">
													<img src="../../images/button/BatchAdjustOn.gif" name="imgBatch" width="80" height="20" border="0" align="absmiddle" onClick="fnc_Batch()">	
									            </span>		
											</td>
						                    
						                    
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- �߰� ���̺� �� -->					
					</td>
				</tr>		
				<tr>		
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_WORKSCHEDULE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:600px;height:410px;">
							<param name="DataID"				value="dsT_DI_WORKSCHEDULE">
							<param name="EdiTABLE"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="VIEWSUMMARY"			value=0>
							<param name="Format"				value="
								<C> id='CHK'			width=30			name=''						align=center			EditStyle=CheckBox		HeadCheckShow=false edit={IF(EDIT='N','false','true')} </C>
								<C> id='EDIT'			width=55			name='����'					align=center			show=false edit={IF(EDIT='N','false','true')}</C>								
								<C> id='JOB_OCC'		width=70			name='�ٹ�����'				Edit=None				show=false</C>									
								<C> id='REQ_NO'			width=70			name='REQ_NO'				Edit=None				show=false</C>									
								<C> id='DPT_NM'			width=120			name='�Ҽ�'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NO'			width=50			name='���'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None show=false</C>								
								<C> id='ENO_NM'			width=40			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C>
								<C> id='HOL_YN'			width=30			name='����'					align=center			show=false</C>
								<C> id='DILIGENCE'		width=60			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None Value={decode(DILIGENCE,'E','����','F','����','G','�Ʒ�','H','����','M','����','P','��������','R','���Ĺ���','I','�����ް�','T','��ü�ް�','Z','�����ް�','')}</C>
								<C> id='REG_YMD'		width=70			name='����'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<C> id='REMARK'			width=35			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<C> id='WEEK_NO'		width=35			name='����'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<G> name='�ٹ�����'  HeadBgColor='#dae0ee'
								<C> id='STR_TIME'		width=45			name='��'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='07:07,08:08,09:09,10:10,11:11,12:12,13:13,14:14'</C>
								<C> id='STR_MINUTE'		width=45			name='��'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='00:00,30:30'</C>
								</G>
								<G> name='�ٹ�����'  HeadBgColor='#dae0ee'
								<C> id='END_TIME'		width=45			name='��'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='12:12,13:13,14:14,15:15,16:16,17:17,18:18,19:19,20:20,21:21,22:22,23:23'</C>		
								<C> id='END_MINUTE'		width=45			name='��'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='00:00,30:30'</C>		
								</G>
								<C> id='DAY_TOTAL_TIME'	width=40			name='�ð�'					align=center			show=false edit=None edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} DEC=2 Value={decode(DAY_TOTAL_TIME, 0, '',DAY_TOTAL_TIME)} </C>		
								<C> id='DAY_TOTAL_TIME2' width=70			name='�ð�'					align=center			edit=None edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} </C>									
								<C> id='STATUS_NOW'		width=40			name='����'					align=center			Value={decode(STATUS_NOW,'S','����','A','���','C','����','N','�ΰ�','Y','�Ϸ�',STATUS_NOW)} edit=None BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<BR>
<font size=2 color=blue face = "����" bold=10>* ����Ʈ�� ����� ���ٸ� �ٹ����°� ź�±ٹ������� ���� Ȯ���ϼ���.&nbsp;&nbsp;&nbsp;4�ֵ��� �ִ� 208�ð��� �ʰ��Ͻ� �� �����ϴ�.</font>
<BR>
<BR>
<font size=2 color=blue face = "����" bold=10>* ���� ����� ���ʿ� �ѹ��� �Ͻø� �˴ϴ�. ����Ǵ� �ٹ�ǥ�� ���� ����� ���� ���� �����ñ� �ٶ��ϴ�.</font>



<!-- ���� ��ȸ �׸��� ���̺� ��-->



<!-- ��ȸ ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>�ٹ� �ð� ����</strong></td>
    </tr>
    <tr>
        <td class="paddingTop3">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                <colgroup>
                    <col width="90 "></col>
                    <col width="140"></col>
                    <col width="80 "></col>
                    <col width="70"></col>
                    <col width="80 "></col>
                    <col width="70"></col>
                    <col width="80 "></col>
                    <col width="70"></col>
                    <col width="80 "></col>
                    <col width="70"></col>                    
                </colgroup>
                <tr>
                    <td align="center" class="blueBold" >�ش� �� ����</td>
                    <td class="padding2423" align="left">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly > ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly >
                    </td>
                    <td align="center" class="blueBold">�ִ����ð�</td>
                    <td class="padding2423" >
                        <input id="txtWEEK_TOTAL_TIME" name="txtWEEK_TOTAL_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�ֽ�û���ɽð�</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME" name="txtPOSIBLE_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>      
                    
                    <td align="center" class="blueBold">�������ð�</td>
                    <td class="padding2423" >
                        <input id="txtMONTH_TOTAL_TIME" name="txtMONTH_TOTAL_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">����û���ɽð�</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME2" name="txtPOSIBLE_TIME2" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>                        
                                  
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ��ȸ ���̺� �� -->


</form>
<!-- form �� -->

</body>
</html>

<!--**************************************************************************************
   *                                       												 *
*	���ε� ������Ʈ																		 *
   *                                       												 *
   ***************************************************************************************-->

<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_DI_WORKSCHEDULE_DETAIL">
	<Param Name="BindInfo", Value="
		<C>Col=STR_YMD				Ctrl=txtSTR_YMD				Param=value</C>
		<C>Col=END_YMD				Ctrl=txtEND_YMD				Param=value</C>
		<C>Col=WEEK_TOTAL_TIME		Ctrl=txtWEEK_TOTAL_TIME		Param=value</C>
		<C>Col=POSIBLE_TIME			Ctrl=txtPOSIBLE_TIME		Param=value</C>
		<C>Col=MONTH_TOTAL_TIME		Ctrl=txtMONTH_TOTAL_TIME	Param=value</C>
		<C>Col=POSIBLE_TIME2		Ctrl=txtPOSIBLE_TIME2		Param=value</C>		
	">
</object>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
