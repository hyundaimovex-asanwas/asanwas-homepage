<!--
*****************************************************
* @source      : gunf080.jsp
* @description : 근무 스케줄 관리 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/12/20      이동훈        최초 작성
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>

<html>
<head>
<title> 근무 스케줄 관리</title>
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
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


    	var icnt = 0;
    	var today = gcurdate;
    
    	
    	var morning_sy_before  = 0;
    	var morning_bun_before = 0;
    	var after_sy_before    = 0;
    	var after_bun_before   = 0;   	
    	
    	
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			//검색조건
			var dpt_cd = document.form1.txtDPT_CD_SHR.value;	//소속				
			var eno_no = document.form1.txtENO_NO_SHR.value;	//사번

			dsT_DI_WORKSTYLE.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR&DPT_CD="+dpt_cd+"&ENO_NO="+eno_no;
			dsT_DI_WORKSTYLE.reset();
		
        }

        
        
        /***************************
         *    근무  스케줄  조회   *
         ***************************/
        function fnc_SearchList2(eno_no) {

        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;        	

        	dsT_DI_WORKSCHEDULE.ClearData();
        	dsT_DI_WORKSCHEDULE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_01&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","");
        	dsT_DI_WORKSCHEDULE.Reset();
        	
        	
        	
    	    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
    	    	
    	    	//상태값이 저장이거나 상신이거나 완료가 되면 일괄 반영 버튼을 숨김 2021.01.28 그냥 놔두니깐 마음대로 수정한다. 포항 김연수 차장
    	        if (dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'A' || dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'Y' || dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'S') {	    	
    	    	
    		    	document.getElementById("btn_Batch").style.display = "none";
    		    	
    		    	break;
    		    	
    	        }else{
    	        	
    	        	document.getElementById("btn_Batch").style.display = "";
    	        	
    	        }
    	        
    	    }
        	

        }        
        
        
        /***************************
         *    근무  스케줄  조회   *
         ***************************/
        function fnc_SearchList3(eno_no, tra_week) {

        	var PIS_YM = document.getElementById("txtPIS_YM_SHR").value;           	
        	
        	dsT_DI_WORKSCHEDULE_DETAIL.ClearData();
        	dsT_DI_WORKSCHEDULE_DETAIL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_DTL&ENO_NO="+eno_no+"&PIS_YM="+PIS_YM.replace("-","")+"&WEEK_NO="+tra_week;
        	dsT_DI_WORKSCHEDULE_DETAIL.Reset();

        }           
        

        
        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

        	
			if(!fnc_SaveItemCheck()) return;	//유효성 체크

			
			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");		

			//오라클쪽 입력했을때 상태가 변경상태일 경우에도 ms sql 쪽에 반영해주기 위해서
			cfCopyDataSet(dsT_DI_WORKSCHEDULE, dsT_DI_WORKSCHEDULE_CP, "copyHeader=yes,rowFrom=1,rowCnt="+dsT_DI_WORKSCHEDULE.CountRow);

			//ds copy시 Status가 변하지 않으므로 tr에서 넘겨져도 insert나 update로 보지 못한다.
            for(var i=1; i<=dsT_DI_WORKSCHEDULE_CP.CountRow; i++) {

            	dsT_DI_WORKSCHEDULE_CP.UserStatus(i) = 1;

            }			
			
			trT_DI_WORKSTYLE.KeyValue = "tr01(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE)";
			trT_DI_WORKSTYLE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SAV&ENO_NO="+ENO_NO;
			trT_DI_WORKSTYLE.post();


			// Oracle 저장한 뒤에 Ms-Sql 쪽으로 전송해주기
			var param = "proType=A";   	
			ln_TRSetting(tr1, "../../../servlet/security.menu.li.MSSQL010",  "JSP(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE_CP)",  param);
			tr_post(tr1);	 		     
			
			fnc_SearchList2(ENO_NO);      

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {
        	

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {


        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

			// 엑셀로 변환 할 자료가 있는지 체크하고
			// 자료를 엑셀로 저장(시트 명만 바꿔 주세요)
            if (dsT_DI_WORKSCHEDULE.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_DI_WORKSCHEDULE.GridToExcel("근무 스케줄 현황", '', 225);

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {


        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {


        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {
        	

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

			//이곳에 해당 코딩을 입력 하세요
            if (!dsT_DI_WORKSCHEDULE.IsUpdated ) {
            	
				alert("저장할 자료가 없습니다.");
				
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
				
				alert("한달 최대 근무 시간인 208시간을 초과되었습니다.");
				
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
                				
                				alert(dsT_DI_WORKSCHEDULE.NameValue(i,"WEEK_NO") + "주차에서 64시간 초과되었습니다.");
                				
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
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {


			cfStyleGrid_New(form1.grdT_DI_WORKSTYLE,0,"true","true");
			cfStyleGrid_New(form1.grdT_DI_WORKSCHEDULE,0,"true","false");
			
            document.getElementById("txtPIS_YM_SHR").value = gcurdate.substring(0,7);


            
            
    		//마스터가 아니면 소속 부서만 조회 하게
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
         * 15. 단축키 처리  *
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
         * 16. 일괄 반영    *
         *******************/
		function fnc_Batch() {

			
			var morning_sy  = 0;
			var morning_bun = 0;
			var after_sy    = 0;				
			var after_bun   = 0;	
			var work_time = 0;
			
			
			if (confirm("시작시간과 종료시간을 일괄 반영하시겠습니까?\n\n근무표 작성후 저장 버튼을 누르시기 바랍니다.") == false) return;

			
			//근무형태가 고성/도라산/인천인 경우			
			if(dsT_DI_WORKSCHEDULE.NameValue(i,"JOB_OCC") == "3"){
			
		            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
		            	
		            
		            	if(dsT_DI_WORKSCHEDULE.NameValue(i,"DILIGENCE") == ""){ // 기존 근태가 없을 경우에만 일괄 반영되도록
		            		
		            	
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
									alert("불가능한 시간입니다.\n\n다시 설정해주십시요.");
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
			
								var inputData = morning_hour + after_hour + "시간"; 

				                if (work_minute == '0.5' ){   		//소수점 뒤가 존재하면
				                	inputData = inputData + " 30분";
				                }else if(work_minute == '1' ){   		//소수점 뒤가 존재하면
				                	inputData = morning_hour + after_hour + 1 + "시간";
				                }

								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;
								
			                }
			                
		            	}
		            			dsT_DI_WORKSCHEDULE.UserStatus(i) = 1;
		            }
            
		            
			//근무형태가 일반현장인 경우		            
			}else if(dsT_DI_WORKSCHEDULE.NameValue(i,"JOB_OCC") == "5"){

		            for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
		        		
		            	if(dsT_DI_WORKSCHEDULE.NameValue(i,"DILIGENCE") == ""){ // 기존 근태가 없을 경우에만 일괄 반영되도록		            	
		            	
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
									alert("불가능한 시간입니다.\n\n다시 설정해주십시요.");
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
			
								var inputData = morning_hour + after_hour + "시간"; 

				                if (work_minute == '0.5' ){   		//소수점 뒤가 존재하면
				                	inputData = inputData + " 30분";
				                }else if(work_minute == '1' ){   		//소수점 뒤가 존재하면
				                	inputData = morning_hour + after_hour + 1 + "시간";
				                }

								dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;
								
			                }
		            	
		            	}
		            	
            					dsT_DI_WORKSCHEDULE.UserStatus(i) = 1;
            					
	            	}				
				

				
			//근무형태가 일반현장/고성/도라산/인천이 아닌 경우
			}else{
				
				alert("담당자에게 연락바랍니다.");
				return false;
				
			}

		}        
        
		

		/*************************
         * 17. 월별 상신 처리    *
         ************************/
		function fnc_Conduct() {
			
			
			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
			var TEAM_CD = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "TEAM_CD");
			
			
			dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&TEAM_CD="+TEAM_CD;	
			dsT_DI_APPROVAL.Reset();			

			
			// 자동 결재선 체크
			if(dsT_DI_APPROVAL.CountRow < 1) {
				alert("자동결재선 정보가 없습니다.\n\n관리자에게 문의하세요.");
				return;
			}
			

			if(!confirm("신청정보를 월별상신 하시겠습니까?")) return;

			
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
         * 18. 개별 상신 처리    *
         ************************/
		function fnc_Conduct_Each() {
			

			var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
			var TEAM_CD = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "TEAM_CD");
			
			
			dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&TEAM_CD="+TEAM_CD;	
			dsT_DI_APPROVAL.Reset();			
			
			
			// 자동 결재선 체크
			if(dsT_DI_APPROVAL.CountRow < 1) {
				alert("자동결재선 정보가 없습니다.\n\n관리자에게 문의하세요.");
				return;
			}
			

			//오직 상태값이 변경일 경우에만 개별 상신이 가능하다. 저장/상신/부결/완료 모두 개별 상신 불가능
			if(!confirm("신청정보를 개별상신 하시겠습니까?")) return;

			
			dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD&S_MODE=SHR_MAX2";
			dsT_DI_REQNO.reset();

			var req_no = dsT_DI_REQNO.NameValue(1, "REQ_NO");

		    for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++) {				    
	    		
		    	dsT_DI_APPROVAL.UserStatus(i) = 1;
	    	
		    }		
		    
			//alert(req_no);
			
			trT_DI_WORKSCHEDULE.KeyValue = "tr01(I:dsT_DI_WORKSCHEDULE=dsT_DI_WORKSCHEDULE, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
			
			trT_DI_WORKSCHEDULE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf080.cmd.GUNF080CMD"
																			+ "&S_MODE=UPT_APP_EACH" // 개별 상신 모드
																			+ "&GUN_YMD=" +today.replace("-","").replace("-","") // 오늘날짜
																			+ "&REQ_NO=" +req_no //
																			;
			
			//prompt(this, dsT_DI_APPROVAL.text);
			
			trT_DI_WORKSCHEDULE.post();
			

		}				
		

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_DI_WORKSTYLE                    |
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
    | 1. 자료 저장 및 조회용 Data Transacton			|
    | 2. 이름은 tr_ + 주요 테이블명(dsT_DI_WORKSTYLE)   |
    | 3. 사용되는 Table List(T_DI_WORKSTYLE)	        |
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
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {
            //alert("검색하신 조건의 자료가 없습니다.");
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
			document.form1.txtPIS_YY_SHR.focus();

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
			document.form1.grdT_DI_WORKSTYLE.focus();
        }

    </Script>


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_DI_WORKSCHEDULE_DETAIL Event="OnLoadCompleted(iCount)">

		    var inputData;
		    var buf  = "";
		    var buf2  = "";
		    var splitData = new Array();
		    
		    splitData = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"WEEK_TOTAL_TIME").toString().split("."); // "." 으로 나눈다.

		    buf = splitData[0];	
		    buf2 = splitData[1];
		    
		    if (buf == '0' ){   		
		    	inputData = ''; 
		    }else{
		    	inputData = buf + "시간"; 
		    }

		    if (buf2 == '25' ){   			
		    	inputData = inputData + " 15분";
		    }else if (buf2 == '5' ){   		
		    	inputData = inputData + " 30분";
		    }else if (buf2 == '75' ){   	
		    	inputData = inputData + " 45분";                
		    }
		    
		    
		    
		    
		    
		    
		    var inputData2;
		    var bbuf  = "";
		    var bbuf2  = "";
		    var splitData2 = new Array();
		    
		    splitData2 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME").toString().split("."); // "." 으로 나눈다.

		    bbuf = splitData2[0];	
		    bbuf2 = splitData2[1];
		    
		    if (bbuf == '0' ){   		
		    	inputData2 = ''; 
		    }else if (bbuf == '' ){
		    	inputData2 = ''; 			    	
		    }else{
		    	inputData2 = bbuf + "시간"; 
		    }

		    if (bbuf2 == '25' ){   			
		    	inputData2 = inputData2 + " 15분";
		    }else if (bbuf2 == '5' ){   		
		    	inputData2 = inputData2 + " 30분";
		    }else if (bbuf2 == '75' ){   	
		    	inputData2= inputData2 + " 45분";                
		    }		    
		    
            if (inputData2 == '' ){   			//0시간이면 빈칸으로 나오는거 방지
            	inputData2 = '0시간'; 
            }  		    
		    
            
            
		    var inputData3;
		    var bbuf3  = "";
		    var bbuf33  = "";
		    var splitData3 = new Array();
		    
		    splitData3 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"MONTH_TOTAL_TIME").toString().split("."); // "." 으로 나눈다.

		    bbuf3 = splitData3[0];	
		    bbuf33 = splitData3[1];
		    
		    if (bbuf3 == '0' ){   		
		    	inputData3 = ''; 
		    }else{
		    	inputData3 = bbuf3 + "시간"; 
		    }

		    if (bbuf33 == '25' ){   			
		    	inputData3 = inputData3 + " 15분";
		    }else if (bbuf33 == '5' ){   		
		    	inputData3 = inputData3 + " 30분";
		    }else if (bbuf33 == '75' ){   	
		    	inputData3= inputData3 + " 45분";                
		    }		    
		    
            if (inputData3 == '' ){   			//0시간이면 빈칸으로 나오는거 방지
            	inputData3 = '0시간'; 
            }  		    
		    
            
            
		    var inputData4;
		    var bbuf4  = "";
		    var bbuf44  = "";
		    var splitData4 = new Array();
		    
		    splitData4 = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME2").toString().split("."); // "." 으로 나눈다.

		    bbuf4 = splitData4[0];	
		    bbuf44 = splitData4[1];
		    
		    if (bbuf4 == '0' ){   		
		    	inputData4 = ''; 
		    }else if (bbuf4 == '' ){
		    	inputData4 = ''; 		    	
		    }else{
		    	inputData4 = bbuf4 + "시간"; 
		    }

		    if (bbuf44 == '25' ){   			
		    	inputData4 = inputData4 + " 15분";
		    }else if (bbuf44 == '5' ){   		
		    	inputData4 = inputData4 + " 30분";
		    }else if (bbuf44 == '75' ){   	
		    	inputData4= inputData4 + " 45분";                
		    }		    
		    
            if (inputData4 == '' ){   			//0시간이면 빈칸으로 나오는거 방지
            	inputData4 = '0시간'; 
            }  		 
            
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD") = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(0,4) + "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(4,2)+ "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"STR_YMD").substr(6,2);
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD") = dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(0,4) + "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(4,2)+ "/" + dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"END_YMD").substr(6,2);
		    dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"WEEK_TOTAL_TIME") = inputData;    
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME") = inputData2;
		    dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"MONTH_TOTAL_TIME") = inputData3;    
        	dsT_DI_WORKSCHEDULE_DETAIL.NameValue(1,"POSIBLE_TIME2") = inputData4;
        	
        	
        	
        	
        	
    </Script>



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
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
                
                splitData = dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME").toString().split("."); // "." 으로 나눈다.
                
                buf = splitData[0];	
                buf2 = splitData[1];

                if (buf == '0' ){   			
                	inputData = ''; 
                }else{
                	inputData = buf + "시간"; 
                }

                if (buf2 == '25' ){   			//쿼터제로 인하여 0.25면 15분
                	inputData = inputData + " 15분";
                }else if (buf2 == '5' ){   		//쿼터제로 인하여 0.5면 30분
                	inputData = inputData + " 30분";
                }else if (buf2 == '75' ){   	//쿼터제로 인하여 0.75면 45분
                	inputData = inputData + " 45분";                
                }
                
                dsT_DI_WORKSCHEDULE.NameValue(i,"DAY_TOTAL_TIME2") = inputData;

	    }

	    
	    for(var i=1; i<=dsT_DI_WORKSCHEDULE.CountRow; i++) {
	    	
	    	//상태값이 상신이거나 월별 상신 버튼은 숨김... 변경은 개별 상신을 통해서 하도록 + Grid Disable 상태로 만듦
	        if (dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'A' ) {	    	
	    	
		    	document.getElementById("btn_apply").style.display = "none";
		    	
		    	break;
		    	
		    //상태값이 완료이면 월별 상신 버튼은 숨김... 변경은 개별 상신을 통해서 하도록	
	        }else if(dsT_DI_WORKSCHEDULE.NameValue(i, "STATUS_NOW") == 'Y'){
	        	
		    	document.getElementById("btn_apply").style.display = "none";
		    	
		    	break;
		    	
	        }else{
	        	
	        	document.getElementById("btn_apply").style.display = "";
	        	
	        }
	        
	    }
	    
	    //Data Set 을 Normal로 Update~
	    dsT_DI_WORKSCHEDULE.ResetStatus();
	    	
    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>



    <!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
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
    | 그리드의 ROW를 클릭 할때      |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSTYLE Event="OnClick(row, col)">
    
    //Header 클릭은 좀 제외하자
	if(row != "0"){    
    
        eno_no   = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");

        fnc_SearchList2(eno_no);
        
	}
	

    </Script>


	<script language=JavaScript for=grdT_DI_WORKSCHEDULE event=OnListSelect(index)>
	

		//근무형태가 고성/도라산/인천인 경우			
		if(dsT_DI_WORKSCHEDULE.NameValue(1,"JOB_OCC") == "3"){

		        morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
		        morning_bun = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
		        after_sy    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
		        after_bun   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");	
	
				if(after_sy == 24 && after_bun == 30 ) {
					alert("불가능한 시간입니다.\n\n다시 설정해주십시요.");          	
		            dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") = '00';	
		            return false;
				}
				
				//'S','저장','A','상신','C','변경','N','부결','Y','완료'
                if (dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'A' ){   		//상태가 상신이면 변경 불가능
					alert("이미 상신되었습니다.\n\n결재완료 후 변경하셔야 합니다.");          	
		            return false;
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'S'){   	//상태가 저장이면 똑같이 저장상태로 만듦
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "S";
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'N'){   	//상태가 부결이면 똑같이 부결상태로 만듦
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "N";                
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'Y'){   	//상태가 완료이면 똑같이 부결상태로 만듦
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

				var inputData = morning_hour + after_hour + "시간"; 

                if (work_minute == '0.5' ){   		//소수점 뒤가 존재하면
                	
                	//alert(inputData);
                	
                	if(inputData == '0'){ 
                		inputData = "30분"
                	}else{
                		inputData = inputData + " 30분";
                	}
                
                }else if(work_minute == '1' ){   		//소수점 뒤가 존재하면
                	inputData = morning_hour + after_hour + 1 + "시간";
                }

				dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = inputData;
				
				
		
							
				
		//근무형태가 일반현장인 경우			
		}else if(dsT_DI_WORKSCHEDULE.NameValue(1,"JOB_OCC") == "5"){	
		
		        morning_sy  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
		        morning_bun = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
		        after_sy    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
		        after_bun   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");	
		
				if(after_sy == 24 && after_bun == 30 ) {
					alert("불가능한 시간입니다.\n\n다시 설정해주십시요.");          	
		            dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE") = '00';	
		            return false;
				}
				
				
				//4칸을 모두 채우지 않으면 계산도 하지 마라. 힘들다.
				if(morning_sy == "" || morning_bun == "" || after_sy == "" || after_bun == ""){

					return;
					
				}
				
				//종료시간이 시작시간보다 빠를 수 없음
				if(morning_sy > after_sy ){

					alert("종료시간이 시작시간보다 빠를 수 없습니다.");
					
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
				
				//시작시간은 9시 이전
				/* 2020.12.01 이런 저런 제약 사항을 좀 풀어놓고 시작하자
				if(morning_sy > 9 ){
					
					alert("시작시간은 9시 이전으로 설정바랍니다.");
					dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = "";					
					return false;
					
				}
				
				//종료시간은 17시 이후
				if(after_sy < 17 ){
					
					alert("종료시간은 17시 이후로 설정바랍니다.");
					dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME") = "";
			        dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"DAY_TOTAL_TIME2") = "";					
					return false;
					
				}
				*/
				
				
				//'S','저장','A','상신','C','변경','N','부결','Y','완료'
                if (dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'A' ){   		//상태가 상신이면 변경 불가능
					alert("이미 상신되었습니다.\n\n결재완료 후 변경하셔야 합니다.");          	
		            return false;
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'S'){   	//상태가 저장이면 똑같이 저장상태로 만듦
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "S";
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'N'){   	//상태가 부결이면 똑같이 부결상태로 만듦
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "N";                
                }else if(dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") == 'Y'){   	//상태가 완료이면 똑같이 부결상태로 만듦
                	dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STATUS_NOW") = "Y";  
                }						
				
				var morning_hour = 0;
				var morning_minute = 0;
				var after_hour = 0;
				var after_minute = Number(after_bun);					
				var work_minute = 0;
		
				
				//휴일이 아닌 경우
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

						
				//휴일인 경우		
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
				

				var inputData = morning_hour + after_hour + "시간"; 

                if (work_minute == '0.5' ){   		//소수점 뒤가 존재하면
                	
                	if(inputData == '0'){ 
                		inputData = "30분"
                	}else{
                		inputData = inputData + " 30분";
                	}

                }else if(work_minute == '1' ){   		//
                	inputData = morning_hour + after_hour + 1 + "시간";

                }else if(work_minute == '-0.5' ){   		//
                	inputData = morning_hour + after_hour - 1 + "시간 30분";                

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
    | 그리드의 ROW를 클릭 할때      |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSCHEDULE Event="OnClick(row, col)">

    
	    morning_sy_before  = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_TIME");
	    morning_bun_before = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"STR_MINUTE");
	    after_sy_before    = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_TIME");	
	    after_bun_before   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition,"END_MINUTE");		     
    
    
        var eno_no     = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition, "ENO_NO");
        
        var tra_week   = dsT_DI_WORKSCHEDULE.NameValue(dsT_DI_WORKSCHEDULE.RowPosition, "WEEK_NO");
        

        if (col == 'CHK')    {

        	//'S','저장','A','상신','C','변경','N','부결','Y','완료'
        	//상태가 저장, 부결이면 체크 안되도록
            if (dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'S' || dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'N')    {        	
        	
            	alert("근무 시간을 수정하시고 저장부터 하시기 바랍니다.\n\n상태값이 변경인지 확인하시고 체크하시기 바랍니다.");
            	dsT_DI_WORKSCHEDULE.NameString(row, "CHK") = "F";
            	
            //상태가 완료이면 체크 되도록	
            }else if(dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'Y'){	            
            
            	alert("근무 시간을 수정하시고 저장부터 하시기 바랍니다.\n\n상태값이 변경인지 확인하시고 체크하시기 바랍니다.");
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
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
    <Script language=JavaScript For=grdT_DI_WORKSCHEDULE Event="OnDblClick(row, col)">

        if (dsT_DI_WORKSCHEDULE.NameValue(row, "EDIT") == 'N')    {

            if(dsT_DI_WORKSCHEDULE.NameValue(row, "DILIGENCE") != '')    {
            	
            	alert("기존 근태 자료가 존재합니다.");
            	
            }else{
            	
            	var click = today.replace("-","").replace("-","");
          	
                if (dsT_DI_WORKSCHEDULE.NameValue(row, "REG_YMD") < click)    {            	
            	
            		alert("이전 자료는 수정하실 수 없습니다");
                
                }else{

                    if (dsT_DI_WORKSCHEDULE.NameValue(row, "STATUS_NOW") == 'A')    {
                    	
                    	alert("상신중이므로 수정할 수 없습니다.\n\n관리자에게 문의하세요.");

                        return false;
                        
                    }
                    
                }
            	
            }

        }

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_WORKSTYLE Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_DI_WORKSCHEDULE event="OnSuccess()">
    
    	alert("정상적으로 처리되었습니다.");
    
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        
		var ENO_NO = dsT_DI_WORKSTYLE.NameValue(dsT_DI_WORKSTYLE.RowPosition, "ENO_NO");
		
		fnc_SearchList2(ENO_NO);        	
        
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
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


<!-- 캘린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
   	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
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
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
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
			                    <td align="center" class="blueBold">해당월</td>
								<td class="padding2423" align="left">
									<input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								</td>                            
					            <td align="right" class="blueBold">소 속&nbsp;</td>
								<td class="padding2423">
									<input name=txtDPT_CD_SHR size="6"  maxlength="6" onKeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
									<input id=txtDPT_NM_SHR size="10">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','../../images/button/btn_HelpOver.gif',1)">
									<img src="../../images/button/btn_HelpOn.gif" name="Image30" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','부서','DEPT')">
									</a>
								</td>
                                <td align="right" class="searchState">사번&nbsp;</td>
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
<!-- power Search테이블 끝 -->




<!-- 조회 상태 테이블 시작 -->
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
<!-- 조회 상태 테이블 끝 -->



<!-- 내용 조회 그리드 테이블 시작-->
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
								<C> id='HEAD_NM'		width=80			name='본부'				Edit=None	align=left				show=false</C>								
								<C> id='DPT_NM'			width=65			name='소속'				Edit=None	align=left				</C>
								<C> id='DPT_CD'			width=70			name='소속'				Edit=None	align=left				show=false</C>								
								<C> id='JOB_OCC'		width=70			name='근무형태'			Edit=None	align=left				show=false</C>								
								<C> id='TEAM_NM'		width=100			name='파트/현장'			Edit=None	align=left				</C>								
								<C> id='JOB_NM'			width=80			name='직위'				Edit=None	align=center			</C>
								<C> id='ENO_NO'			width=50			name='사번'				Edit=None	align=center			</C>
								<C> id='ENO_NM'			width=55			name='성명'				Edit=None	align=center			</C>
								<C> id='GBN_NM'			width=70			name='근무지'				Edit=None	align=center			show=false</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td>	
						<!-- 시작시간 종료시간 일괄반영-->
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
						                    <td align="center" class="blueBold">시작</td>
						                    <td class="padding2423">
						                        <select id="cmbSTR_TIME" name="cmbSTR_TIME" style="WIDTH: 35%">
						                           <option value='07'>07</option>
						                           <option value='08'>08</option>
						                           <option value='09'>09</option>
						                           <!--  이렇게 다양한 출근 시간을 아직 허용하지 않음. 2020.05.20 
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
						                        시
						                        <select id="cmbSTR_MINUTE" name="cmbSTR_MINUTE" style="WIDTH: 35%">
						                           <option value='00'>00</option>
						                           <option value='30'>30</option>
						                        </select>						                        
						                        분
						                    </td>
						                    <td align="center" class="blueBold">종료</td>
						                    <td class="padding2423">
						                        <select id="cmbEND_TIME" name="cmbEND_TIME" style="WIDTH: 35%">
						                        	<!--  이렇게 다양한 퇴근 시간을 아직 허용하지 않음. 2020.05.20 
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
						                        시
						                        <select id="cmbEND_MINUTE" name="cmbEND_MINUTE" style="WIDTH: 35%">
						                           <option value='00'>00</option>
						                           <option value='30'>30</option>                    
						                        </select>						                        
						                        분						                        
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
						<!-- 중간 테이블 끝 -->					
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
								<C> id='EDIT'			width=55			name='수정'					align=center			show=false edit={IF(EDIT='N','false','true')}</C>								
								<C> id='JOB_OCC'		width=70			name='근무형태'				Edit=None				show=false</C>									
								<C> id='REQ_NO'			width=70			name='REQ_NO'				Edit=None				show=false</C>									
								<C> id='DPT_NM'			width=120			name='소속'					align=center			show=false BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
								<C> id='ENO_NO'			width=50			name='사번'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None show=false</C>								
								<C> id='ENO_NM'			width=40			name='성명'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C>
								<C> id='HOL_YN'			width=30			name='휴일'					align=center			show=false</C>
								<C> id='DILIGENCE'		width=60			name='근태'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None Value={decode(DILIGENCE,'E','출장','F','교육','G','훈련','H','연차','M','월차','P','오전반차','R','오후반차','I','경조휴가','T','대체휴가','Z','포상휴가','')}</C>
								<C> id='REG_YMD'		width=70			name='일자'					align=center			MASK='XXXX-XX-XX' BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<C> id='REMARK'			width=35			name='요일'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<C> id='WEEK_NO'		width=35			name='주차'					align=center			BgColor={Decode(HOL_YN,'Y','#FFEAEA')} edit=None</C> 
								<G> name='근무시작'  HeadBgColor='#dae0ee'
								<C> id='STR_TIME'		width=45			name='시'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='07:07,08:08,09:09,10:10,11:11,12:12,13:13,14:14'</C>
								<C> id='STR_MINUTE'		width=45			name='분'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='00:00,30:30'</C>
								</G>
								<G> name='근무종료'  HeadBgColor='#dae0ee'
								<C> id='END_TIME'		width=45			name='시'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='12:12,13:13,14:14,15:15,16:16,17:17,18:18,19:19,20:20,21:21,22:22,23:23'</C>		
								<C> id='END_MINUTE'		width=45			name='분'					align=center			edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} EditStyle=Combo Data='00:00,30:30'</C>		
								</G>
								<C> id='DAY_TOTAL_TIME'	width=40			name='시간'					align=center			show=false edit=None edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} DEC=2 Value={decode(DAY_TOTAL_TIME, 0, '',DAY_TOTAL_TIME)} </C>		
								<C> id='DAY_TOTAL_TIME2' width=70			name='시간'					align=center			edit=None edit={IF(EDIT='N','false','true')} BgColor={Decode(HOL_YN,'Y','#FFEAEA')} </C>									
								<C> id='STATUS_NOW'		width=40			name='상태'					align=center			Value={decode(STATUS_NOW,'S','저장','A','상신','C','변경','N','부결','Y','완료',STATUS_NOW)} edit=None BgColor={Decode(HOL_YN,'Y','#FFEAEA')}</C>
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
<font size=2 color=blue face = "돋움" bold=10>* 리스트에 명단이 없다면 근무형태가 탄력근무제인지 먼저 확인하세요.&nbsp;&nbsp;&nbsp;4주동안 최대 208시간을 초과하실 수 없습니다.</font>
<BR>
<BR>
<font size=2 color=blue face = "돋움" bold=10>* 월별 상신은 최초에 한번만 하시면 됩니다. 변경되는 근무표는 개별 상신을 통해 결재 받으시기 바랍니다.</font>



<!-- 내용 조회 그리드 데이블 끝-->



<!-- 조회 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop15">
        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
            <strong>근무 시간 정보</strong></td>
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
                    <td align="center" class="blueBold" >해당 주 일자</td>
                    <td class="padding2423" align="left">
                        <input id="txtSTR_YMD" name="txtSTR_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly > ~
                        <input id="txtEND_YMD" name="txtEND_YMD" style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly >
                    </td>
                    <td align="center" class="blueBold">주누적시간</td>
                    <td class="padding2423" >
                        <input id="txtWEEK_TOTAL_TIME" name="txtWEEK_TOTAL_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">주신청가능시간</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME" name="txtPOSIBLE_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>      
                    
                    <td align="center" class="blueBold">월누적시간</td>
                    <td class="padding2423" >
                        <input id="txtMONTH_TOTAL_TIME" name="txtMONTH_TOTAL_TIME" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">월신청가능시간</td>
                    <td class="padding2423" >
                        <input id="txtPOSIBLE_TIME2" name="txtPOSIBLE_TIME2" maxlength="20" style="width:100%" class="input_ReadOnly" readonly>
                    </td>                        
                                  
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 테이블 끝 -->


</form>
<!-- form 끝 -->

</body>
</html>

<!--**************************************************************************************
   *                                       												 *
*	바인딩 컴포넌트																		 *
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
