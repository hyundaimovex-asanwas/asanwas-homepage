<!--
*****************************************************
* @source       : gune010.jsp
* @description : 연장근무사전신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/10/18     MOON              최초작성
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ page import="Ehr.common.*" %>
<%@ page import="security.common.*" %>
<%@ page import="Ehr.common.util.DateUtil" %>

<html>
<head>
<title>연장근무사전신청</title>
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
	

	
	var today = gcurdate;
	
	var GBN = "";
	
	// 전역변수
	
	
	
    /***********************************
     * 01. 조회 함수_List 형태의 조회                *
     ***********************************/
    function fnc_SearchList() {

    	
    }
	

    /***********************************
     * 02. 조회 함수_Item 형태의 조회                *
     ***********************************/
    function fnc_SearchItem() {
    	

    }


    
    /******************
     * 03. 저장 함수         *
     ******************/
    function fnc_Save() {
    	

    }

    
    
    
    /******************
     * 04. 삭제 함수         *
     ******************/
    function fnc_Delete() {
    	

    }

    
    
    /******************
     * 05. 인쇄 함수        *
     ******************/
    function fnc_Print() {
    	
    	
    }

    
    
    
    /***********************
     * 06. 엑셀 저장 함수            *
     ***********************/
    function fnc_ToExcel() {
    	
    	
    }

    
    
    /******************
     * 07. 신규 함수         *
     ******************/
    function fnc_AddNew() {
    	
    	
    }

    
    
    /******************
     * 08. 유효성 검사      *
     ******************/
    function fnc_Valid() {
    	
    	
    }

    
    /******************
     * 08. 추가 함수         *
     ******************/
	function fnc_Append() {
    	

    	var TOT_TIME = dsMonAccHour.NameValue(1,"ALL_TOT_TIME"); // 주 총 누적 시간(연장+휴일)
    	var REQ_TIME = document.getElementById("txtREQ_TIME").value; // 신청된 시간
    	
    	
    	
    	var catg = document.getElementById("cmbAPP_TYPE").value;
    	
    	
    	
    	var TOT_WEEK_TIME = "0";
    	var TOT_HOL_TIME = "0";
    	var CHK_WK_MON = "";
    	var CHK_WK_FRI = "";
    	var CHK_WK_FLAG = "N";
    	var APP_N_CHK = "N"; // 부결여부 확인
        
    	
    	
    	
    	// 최대신청기간 체크
		var STR_YMD = document.getElementById("txtSTR_YMD").value;
		var END_YMD = document.getElementById("txtEND_YMD").value;
		var ovr_ymd = addDate("D", STR_YMD, 30);
		
		
		
		// 입력시간체크
		var STR_TIME = "";
		var END_TIME = "";
		
		
		
		// 입력 가능시간 체크
		cfXmlHttpStatus("HH24MI"); // 시간조회
		
		
		
		//alert(GLS_SYSTEM_DATE);
		
		
		// GLS_SYSTEM_DATE는 js파일에 정의되어 있음
		/*
		if(GLS_SYSTEM_DATE.length != 4) {
			
			alert("시간설정에 예외가 발생하였습니다.\n\n시스템담당자에게 문의 바랍니다.");
			
			return;
			
		}
		*/
		
		
		
		if( today.replaceAll("-","") > STR_YMD.replaceAll("-","") ) {
			
			alert("연장근무 신청일 중 현재일 이전 일자에 대한 신청정보가 존재합니다.\n\n지난 일자에 대해서는 등록을 하실 수 없습니다.");
			
			return;
			
		}
		
		
		
		
		
		if(catg == "AM") {
			
				/* 2021.02.03 체크 부분은 좀 더 확인해야 됨 
				if( (today.replaceAll("-","") == STR_YMD.replaceAll("-","")) &&  (((Number(GLS_SYSTEM_DATE)-16)+"") > "0600") )  {
					
					alert("연장근무 신청일 중 당일 오전에 대한 신청정보가 존재합니다.\n\n입력시간이 지난 시간에는 등록하실 수 없습니다.\n\n상단 연장시간 및 입력가능시간에 대한 정보를 확인해 주시기 바랍니다.");
					
					return;
					
				}
				*/
			
		} else if(catg == "PM") {
			
				/* 2021.02.03 체크 부분은 좀 더 확인해야 됨 
				if( (today.replaceAll("-","") == STR_YMD.replaceAll("-","")) &&  (((Number(GLS_SYSTEM_DATE)-16)+"") > "1800") )  {
					
					alert("연장근무 신청일 중 당일 오후에 대한 신청정보가 존재합니다.\n\n입력시간이 지난 시간에는 등록하실 수 없습니다.\n\n상단 연장시간 및 입력가능시간에 대한 정보를 확인해 주시기 바랍니다.");
					
					return;
					
				}
				*/
			
		} else {
			
			
			
			
		}
		
		
		
		
		
		if(ovr_ymd < END_YMD) {
			
			alert("연장근무 등록 가능 일자는 오늘 이후 최대 30일 입니다.");
			
			return;
			
		}
		
    	
		
		if(REQ_TIME == "0" || REQ_TIME == "") {
			
			alert("신청 시간설정이 올바르지 않습니다.");
			
			return;
			
		}
		
		
		
		if(document.getElementById("txtREMARK").value.trim() == ""){
			
			alert("근무내용을 입력해 주세요");
			
			document.getElementById("txtREMARK").focus();
			
			return;
			
			
		}
		
		
		
		STR_TIME = document.getElementById("cmbSTR_OVR_HOUR").value+document.getElementById("cmbSTR_OVR_MIN").value;
		END_TIME = document.getElementById("cmbEND_OVR_HOUR").value+document.getElementById("cmbEND_OVR_MIN").value;

		
		
		
		if(catg == "AM") {
			
			
			if(  !((STR_TIME >= "0600" && STR_TIME <= "0900") && (END_TIME >= "0600" && END_TIME <= "0900")) ) {
				
				alert("오전 : 당일 06:00 ~ 당일 09:00 사이에서 등록가능합니다.");
				
				return;
				
			}
			
		} else if(catg == "PM") {
			
			
			STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
			END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );

			if( !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
				
				alert("오후 : 당일 18:00 ~ 익일 06:00 사이에서 등록가능합니다.");
				
				return;
				
			}
			
		} else {
			
			
			
		}

		
		
		// 신청구분에 따른 연장근무일에 대한 등록가능일자 조회
		fnc_getOTPossibleDt(); 
		
		
		
    	dsT_DI_OVERTIMEWORK.ClearData();
		
    	
    	
    	// 해당 Dataset의 Header가 없으면 Header 선언
        if (dsT_DI_OVERTIMEWORK.CountColumn == 0) {
        	
        	dsT_DI_OVERTIMEWORK.setDataHeader("CONF_SEL:STRING,REG_YMD:STRING,STR_REG_YMD:STRING,END_REG_YMD:STRING,WK_MON:STRING,WK_FRI:STRING,AM_REQ_YN:STRING,PM_REQ_YN:STRING,WEEK_TOT_TIME:STRING,REQ_NO:STRING,ACC_TIME:STRING,END_TAG:STRING,STR_OVR_TIME:STRING,END_OVR_TIME:STRING,OVR_TIME:STRING,REMARK:STRING,APP_REMARK:STRING,PENO_NO:STRING,GUBN:STRING,HOL_TOT_TIME:STRING,ALL_TOT_TIME:STRING,WEEK_OF_YEAR:STRING,JOB_CD:STRING");
        
        }
		
		
    	
    	
    	
    	
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
			
			
	        // 휴일 check! 
	        if(catg == "AM" && dsOTPossibleDt.NameString(i, "HOL_YN") == "Y") {
	        	
	        	alert("해당일은 휴일로 오전연장근무 신청이 불가합니다. 근무일을 다시 선택해 주시기 바랍니다. ");
	        	
				continue;
				
	        } else if(catg == "PM" && dsOTPossibleDt.NameString(i, "HOL_YN") == "Y") {
	        	
	        	alert("해당일은 휴일로 오후연장근무 신청이 불가합니다. 근무일을 다시 선택해 주시기 바랍니다. ");
	        	
				continue;
				
	        } else if(catg == "WK" && dsOTPossibleDt.NameString(i, "HOL_YN") == "N") {
	        	
	        	alert("휴일근무신청은 법정 휴일에만 가능합니다.");
	        	
				continue;
				
	        }
	        
	        
	        
	        
			// 휴일근무 신청 또는 결재상태 데이터 삭제 처리 -- 우리는 없음. 
			//if(dsOTPossibleDt.NameString(i, "REG_YN") == "N" || dsOTPossibleDt.NameString(i, catg+"_REQ_YN") == "Y") continue;
	
			
			
			
			// 누적시간 계산 = 총 근무시간 + 요청시간
			TOT_TIME = Number(TOT_TIME) + Number(REQ_TIME);
			
			
			
			
			//받아오는 값 없음. 
			/*if(CHK_WK_MON != dsOTPossibleDt.NameString(i, "WK_MON") && CHK_WK_FRI != dsOTPossibleDt.NameString(i, "WK_FRI"))
			{
				TOT_WEEK_TIME = "0";
				CHK_WK_FLAG = "N";
				CHK_WK_MON = dsOTPossibleDt.NameString(i, "WK_MON");
		    	CHK_WK_FRI = dsOTPossibleDt.NameString(i, "WK_FRI");
			}*/
			
			
			
			
			// 주별 누적 시간 계산 = 0 + 요청시간
			if (catg == "AM" || catg == "PM") {
				
					TOT_WEEK_TIME = Number(TOT_WEEK_TIME) + Number(REQ_TIME);
					
					//관광쪽 계약직 주52시간 아닌 주48.5시간
				    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {
					
						if( Number(TOT_TIME) > 8.5 ) {
							alert("주별 누적 근무시간 : " + dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n초과 시간 : " + (Number(TOT_TIME) - 8.5 ) + 
						    			"H\n신청근무일 : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n주별 최대 등록가능한 8.5시간을 초과하였습니다.\n");
							continue;
						}
				    	
				    }else{
				    	

						if( Number(TOT_TIME) > 12 ) {
							alert("주별 누적 근무시간 : " + dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n초과 시간 : " + (Number(TOT_TIME) - 12 ) + 
						    			"H\n신청근무일 : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n주별 최대 등록가능한 12시간을 초과하였습니다.\n");
							continue;
						}
						
				    }
				
			} else {
				
				
					TOT_HOL_TIME = Number(TOT_HOL_TIME) + Number(REQ_TIME);
					
					//관광쪽 계약직 주52시간 아닌 주48.5시간
				    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {
					
						if(Number(TOT_TIME) > 8.5 ) {
							alert("주별 누적 근무시간 : " +  dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n초과 시간 : " + (Number(TOT_TIME) - 8.5 ) +  
						    			"H\n신청근무일 : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n주별 최대 등록가능한 8.5시간을 초과하였습니다.\n");
							continue;
						}
				    	
				    }else{

						if(Number(TOT_TIME) > 12 ) {
							alert("주별 누적 근무시간 : " +  dsMonAccHour.NameValue(i,"ALL_TOT_TIME") + "H\n초과 시간 : " + (Number(TOT_TIME) - 12 ) +  
						    			"H\n신청근무일 : " + dsOTPossibleDt.NameString(i, "REG_YMD") + "\n\n주별 최대 등록가능한 12시간을 초과하였습니다.\n");
							continue;
							
						}
						
					}
				
			}
			

			
			dsT_DI_OVERTIMEWORK.AddRow();
			

			
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "CONF_SEL") 	= "F";
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REG_YMD") 		= dsOTPossibleDt.NameString(i, "REG_YMD"); // 근무일
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_REG_YMD") 	= dsOTPossibleDt.NameString(i, "REG_YMD"); // 근무시작일
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_REG_YMD") 	= dsOTPossibleDt.NameString(i, "REG_YMD"); // 근무종료일
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "GUBN") 		= catg; //구분값
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_OF_YEAR") = dsWeekOfYear.NameString(i, "WEEK_NO"); //주차정보
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "JOB_CD") 		= dsT_DI_APPROVAL.NameString(i, "JOB_CD"); //직급코드
			
			
			
			
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WK_MON") = dsOTPossibleDt.NameString(i, "WK_MON"); // 주 월요일
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WK_FRI") = dsOTPossibleDt.NameString(i, "WK_FRI"); // 주 금요일
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "AM_REQ_YN") = dsOTPossibleDt.NameString(i, "AM_REQ_YN"); // 오전신청여부
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "PM_REQ_YN") = dsOTPossibleDt.NameString(i, "PM_REQ_YN"); // 오후신청여부
			//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REQ_NO") = dsOTPossibleDt.NameString(i, catg+"_REQ_NO"); // 신청번호
			
			
			
			
			if(dsOTPossibleDt.NameString(i, catg+"_END_TAG") == "N") {
				
				if(confirm("신청내용 중 부결정보가 포함되어 있습니다.\n부결정보를 불러 오시겠습니까?\n\n확인 - 부결정보로 신청정보 설정\n취소 - 신규정보로 신청정보 설정")) {
					
					APP_N_CHK = "Y";
					
				} else {
					
					APP_N_CHK = "N";
					
				}
				
				
			}
			
			
			// 부결일때 누적시간을 그 값만큼 더해준다.부결은 Y
			if(APP_N_CHK == "Y") {
				
				
				TOT_WEEK_TIME = (Number(TOT_WEEK_TIME) - Number(REQ_TIME)) + Number(dsOTPossibleDt.NameString(i, catg+"_OVR_TIME")); // 누적시간 계산
				TOT_HOL_TIME = (Number(TOT_HOL_TIME) - Number(REQ_TIME)) + Number(dsOTPossibleDt.NameString(i, catg+"_OVR_TIME")); // 누적시간 계산
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(TOT_WEEK_TIME) + Number(dsMonAccHour.NameString(i, "WEEK_TOT_TIME")))+""; // 주별누적근무시간
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "HOL_TOT_TIME") = (Number(TOT_HOL_TIME) + Number(dsMonAccHour.NameString(i, "HOL_TOT_TIME")))+""; // 주별누적근무시간
				
				
			} else {
				
				
				//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "ACC_TIME") = TOT_TIME; // 누적시간
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(TOT_WEEK_TIME) + Number(dsMonAccHour.NameString(i, "WEEK_TOT_TIME")))+""; // 주별누적근무시간
				//dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "WEEK_TOT_TIME") = (Number(REQ_TIME) + Number(dsOTPossibleDt.NameString(i, "WEEK_TOT_TIME")))+""; // 주별누적근무시간
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "HOL_TOT_TIME") = (Number(TOT_HOL_TIME) + Number(dsMonAccHour.NameString(i, "HOL_TOT_TIME")))+""; // 주별누적근무시간
			
			
			}
			
			
			
			
			// 부결일 때는 등록된 데이터 표시
			if(APP_N_CHK == "Y") {
				
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_STR_OVR_HOUR")+dsOTPossibleDt.NameString(i, catg+"_STR_OVR_MIN"); // 시작
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_END_OVR_HOUR")+dsOTPossibleDt.NameString(i, catg+"_END_OVR_MIN"); // 종료
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "OVR_TIME") = dsOTPossibleDt.NameString(i, catg+"_OVR_TIME"); // 시간
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REMARK") = dsOTPossibleDt.NameString(i, catg+"_REMARK"); // 근무내용
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_TAG") = dsOTPossibleDt.NameString(i, catg+"_END_TAG")+""; // 신청결재구분
			
				
			} else {
				
				
				var temp_str = document.getElementById("cmbSTR_OVR_HOUR").value;
				var temp_end = document.getElementById("cmbEND_OVR_HOUR").value;
				
				
				if(catg == "PM") {
					
					if(Number(temp_str) >= 24) {
						
						temp_str = "0"+(Number(temp_str) - 24);
						
					}
					
					if(Number(temp_end) >= 24) {
						
						temp_end = "0"+(Number(temp_end) - 24);
						
					}
					
				}
				
				
				
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "STR_OVR_TIME") = temp_str+document.getElementById("cmbSTR_OVR_MIN").value; // 시작
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_OVR_TIME") = temp_end+document.getElementById("cmbEND_OVR_MIN").value; // 종료
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "OVR_TIME") = REQ_TIME; // 시간
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "REMARK") = document.getElementById("txtREMARK").value; // 근무내용
				dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "END_TAG") = dsOTPossibleDt.NameString(i, catg+"_END_TAG")+""; // 신청결재구분
			
			
			
			}

			
			
			
			
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "ALL_TOT_TIME") = Number(TOT_TIME); // 누적시간
			dsT_DI_OVERTIMEWORK.NameString(dsT_DI_OVERTIMEWORK.RowPosition, "APP_REMARK") = dsOTPossibleDt.NameString(i, catg+"_APP_REMARK"); // 결재비고
			
			
			
			APP_N_CHK = "N"; // 부결 정보 초기화
			
			
			
		}
		
		
	}
    
    
    
    
    
    /**************************
     * 09. 제거 함수 - 완료   *
     **************************/
    function fnc_Remove() {
    	

       	var targetGrd = form1.grdT_DI_OVERTIMEWORK;

       	targetGrd.ReDraw = "false";	// 그리드 전체 draw 를 false 로 지정

       	
       	for(var i=dsT_DI_OVERTIMEWORK.CountRow; i>=1; i--) {
       		
       		
   			if(dsT_DI_OVERTIMEWORK.NameString(i, "CONF_SEL") == "T") {
   				
   				
   				
   				dsT_DI_OVERTIMEWORK.DeleteRow( i );
   				
   				
   				
   				// 주별 12시간 체크
   				var STR_TIME = dsT_DI_OVERTIMEWORK.NameString(i, "STR_OVR_TIME");
   				
				var END_TIME = dsT_DI_OVERTIMEWORK.NameString(i, "END_OVR_TIME");
				
				var CALC_TIME = ((fnc_covNumber(END_TIME.substring(0, 2)) * 60) + fnc_covNumber(END_TIME.substring(2, 4))) - 
				((fnc_covNumber(STR_TIME.substring(0, 2)) * 60) + fnc_covNumber(STR_TIME.substring(2, 4)));

				
				
				fnc_CalcAccReTime(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON"),dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI"),i,(CALC_TIME/60));
				
				
				
   			}
   			
   			
   		}
       	
       	
       	
       	//fnc_CalcReTime(); // 월 52시간 체크
       	
       	
       	
       	targetGrd.ReDraw = "true";
       	
       	
       	
    }
    
    
    
    
    
    

    /********************
     * 10. 초기화 함수   *
     ********************/
    function fnc_Clear() {
    	

    	
    }

    
    
    
    /************************
     * 11. 화면 종료(닫기)   *
     ***********************/
    function fnc_Exit() {

		
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
    	
    }

    
    
    
    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분    *
     *******************************************/
    function fnc_OnLoadProcess() {
    	
    	dsT_DI_APPROVAL.SetDataHeader(
						"GUN_YMD:STRING(10),"+			// 근태날짜
		                "GUN_GBN:STRING(1),"+			// 근태결재구분
						"DPT_CD:STRING(6),"+			// 근태부서
						"DPT_NM:STRING(10),"+			// 근태부서명
						"SEQ_NO:STRING(1),"+			// 결재선
						"ENO_NO:STRING(10),"+			// 결재자사번
						"JOB_CD:STRING(10),"+			// 결재자직위
						"APP_TIME:STRING(10),"+			// 결재시간
						"PENO_NO:STRING(10),"+			// 상신자사번
						"APP_YN:STRING(10),"+			// 결재여부
						"ENO_NM:STRING(10),"+			// 결재자명
						"JOB_NM:STRING(10)"				// 직위명
		);
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,0,"true","false"); // 연장근무 Grid Style 적용(그리드, 상태변경컬럼 width, 헤더체크박스, 헤더정렬)
    	
    
    	
        document.getElementById("txtENO_NO_SHR").value = gusrid;  
        document.getElementById("txtENO_NM_SHR").value = gusrnm;
        document.getElementById("txtDPT_NM").value = gdeptnm;
        document.getElementById("txtDPT_CD").value = gdeptcd;
        
        
        
    	// 1. 자동결재선 정보 설정
    	fnc_AutoApproval();
    	
    	
    	
    	// 2. 해당일 기간/주차 정보 설정 
    	fnc_WeekOfYear();
    	
    	
    	
    	// 3. 당월 연장근무 누적시간 계산
    	fnc_MonAccHour();
    	
    	
    	
    	// 4. 시 / 분에 대한 설정(데이터셋 생성)
    	fnc_SetTime();
		
    	
    	
    	// 5. 연장근무일 현재일자로 초기화 설정
    	document.getElementById("txtSTR_YMD").value = today;
    	document.getElementById("txtEND_YMD").value = today;
    	
    	
    	
    }

    
    
	/********************
     * 15. 단축키 처리   *
     *******************/
	function fnc_HotKey() {
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
	}

	
	
	
    /**
     * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
     */
    function fnc_ClickEmpPopup() {

    	
		//마스터가 아니면 소속 부서만 조회 하게
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {

			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}

		
        fnc_CommonEmpPopup("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD", '','');

        
        if (document.getElementById("txtENO_NO").value  != "") {
        	
            fnc_SearchEmpNo();
            
        }        
        
        
    }
    
    
    
    
    
    
    /**
     * 사원 정보를 조회 한다.
     * 사원명으로 검색
     */
    function fnc_SearchEmpNm() {
    	
    	
        //사번을 찾아오고 상세 내역 가져오기

        
	    //마스터가 아니면 소속 부서만 조회 하게
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
	    	
			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}

        
		fnc_GetCommonEnoNo("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');

		
        fnc_SearchEmpNo();
        
        
    }
    
    
    
    

    /**
     * 사원정보를 조회 한다.
     * 사번으로 검색
     */
    function fnc_SearchEmpNo() {
    	
        var obj = new String;

		//마스터가 아니면 소속 부서만 조회 하게
	    if(gusrid == "6060002" || gusrid == "6180001" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003") {
		
			document.getElementById("hidEMPL_DPT_CD").value  = "";

		}
		
        // 정규직 전체
        obj = fnc_GetCommonEnoNm("txtENO_NO", "txtENO_NM", "hidEMPL_DPT_CD",'','');
        
        //obj = fnc_GetCommonEnoObj_DH("txtENO_NO");
        

        if(obj != null && obj.eno_no != "") {
        	
            document.getElementById("txtENO_NO").value      = obj.eno_no;
            document.getElementById("txtENO_NM").value      = obj.eno_nm;
            document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
            document.getElementById("txtJOB_NM").value      = obj.job_nm;
            document.getElementById("hidEMPL_DPT_CD").value = obj.dpt_cd;
            

        } else {
        	
            document.getElementById("txtENO_NO").value      = "";
            document.getElementById("txtENO_NM").value      = "";
            document.getElementById("txtDPT_NM").value      = "";
            document.getElementById("txtJOB_NM").value      = "";
            
        }
        
        fnc_AutoApproval();

    }	
    
    
    
    
	
	/**************************
     *  16. 그외 함수 처리    *
     *************************/
     
	/**
     * 연장근무 신청일 기간 체크 - 완료
     */
	function fnc_CheckDate() {
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value.replaceAll("-","");
		var END_YMD = document.getElementById("txtEND_YMD").value.replaceAll("-","");
		
		
		if(STR_YMD > END_YMD) {
			
			alert("연장근무일의 시작일 설정이 잘못되었습니다.");
			
			return false;
			
		}
		
		
		return true;
		
	}
	
	
	
	
	
	
	/**
     * 누적시간재계산 - 완료
     */
     function fnc_CalcReTime() {
		
        //var TOT_TIME = document.getElementById("txtTOT_TIME").value; // 당월 누적 시간
        var TOT_TIME = dsMonAccHour.NameValue(1,"ALL_TOT_TIME"); // 주 누적 시간
        	
        
        for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
        	// 누적시간 계산
 			TOT_TIME = Number(TOT_TIME) + Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
        	
 			if(Number(TOT_TIME) > 52) {
				alert("월 최대 등록 가능한 52시간을 초과하였습니다.(휴일근무포함)\n추가 또는 변경을 하실 수 없습니다.");
				return false;
			}
 			
        	dsT_DI_OVERTIMEWORK.NameString(i, "ALL_TOT_TIME") = TOT_TIME; // 누적시간 재계산 처리
        	
        	
       	}
        
        
        return true;
        
	}
	
	
	
	
	
     /**
      * 누적시간재계산 - 완료
      */
	function fnc_CalcAccReTime(mon, fri, row, calc) {
    	 
    	 
		var tempVal = 0; // 재계산시간
		var tempVal2 = 0; // 주별 최초 누적 시간
		
		
		// 주별 누적시간 가져오기
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
			
			if(tempVal2 == 0 && mon == dsOTPossibleDt.NameString(i, "WK_MON") && fri == dsOTPossibleDt.NameString(i, "WK_FRI")) {
				
				tempVal2 = Number(dsOTPossibleDt.NameString(i, "WEEK_TOT_TIME"));
				
			}
			
			
		}
		
		
		
		// 합계시간 재계산
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				
				if(i == row) {
					
					
					tempVal += calc;
					
					
				} else {
					
					
					tempVal += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
					
				}
				
				
			}
			
		}
		
		
		
		
	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

			// 주별 12시간 체크
			if( (tempVal2+tempVal) > 8.5) return false;	    	
	    	
	    }else{
	    	
			// 주별 12시간 체크
			if( (tempVal2+tempVal) > 12) return false;
			
	    }
		
		// 주별 12시간 체크
		//if( (tempVal2+tempVal) > 12) return false;
		
		
		
		var tempVal3 = 0; // 새로 적용될 누적시간
		
		
		
		
		// 변경된 시간값 설정
		for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++) {
			
			
			
			if(dsT_DI_OVERTIMEWORK.NameString(i, "WK_MON") == mon && dsT_DI_OVERTIMEWORK.NameString(i, "WK_FRI") == fri) {
				
				
				if(i == row) {
					
					tempVal3 += calc;
					
				} else {
					
					tempVal3 += Number(dsT_DI_OVERTIMEWORK.NameString(i, "OVR_TIME"));
					
				}
				
				dsT_DI_OVERTIMEWORK.NameString(i, "WEEK_TOT_TIME") = (tempVal3+tempVal2)+"";
				
			}
			
		}
		
		return true;
		
	}
	
     
     
     
     
	/**
	* 근무시간에 대한 정보를 체크한다. - 완료
	*/
	function fnc_OVR_Time(catg) {
		
		var OVR_time =  "";
		
		
		OVR_time = ((fnc_covNumber(document.getElementById("cmbEND_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbEND_OVR_MIN").value)) - 
		((fnc_covNumber(document.getElementById("cmbSTR_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbSTR_OVR_MIN").value));
		
		
		
		if(parseInt(OVR_time) < 0){
			
			alert("종료시간이 시작시간보다 작습니다.\n다시 지정해 주세요");
			
			return;
			
		}
		
		
		document.getElementById("txtREQ_TIME").value = (OVR_time/60);
		
		
	}
	
	
	
	
	
	
	/**
	* 상신처리
	*/
	function fnc_Conduct() {
		
		
		if(dsT_DI_OVERTIMEWORK.CountRow < 1) {
			
			alert("상신가능한 연장근무신청내역이 없습니다");
			
			return;
			
		}
		
		
		
		if(!fnc_CheckDate()) return;

		
		
		// 자동 결재선 체크
		if(dsT_DI_APPROVAL.CountRow < 1) {
			
			alert("자동결재선 정보가 없습니다.");
			
			return;
			
		}
		
		
		
		if(!confirm("신청정보를 상신 하시겠습니까?")) return;
		
		
		
		
		dsT_DI_REQNO.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_MAX";
		dsT_DI_REQNO.reset();
		
		
		
		var req_no = dsT_DI_REQNO.NameValue(1, "REQ_NO");
		
		
		
		//alert(dsT_DI_OVERTIMEWORK.NameString(1, "ALL_TOT_TIME"));
		
		
		
		GBN = "SAV01";
		
		trT_DI_OVERTIMEWORK.KeyValue = "SAV01(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK, I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
		
		trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD"
												+ "&S_MODE=UPT_APP" // 모드
												+ "&APP_TYPE=" + document.getElementById("cmbAPP_TYPE").value // 오전 / 오후 구분
												+ "&APP_YN="  +"N" // 결재상태 : 상신
												+ "&GUN_YMD=" +today.replaceAll("-","") // 오늘날짜
												+ "&GUN_GBN=" +"O" // 문서모드 : 연장근무사전신청을 지칭함 O값 할당
												+ "&REQ_NO=" +req_no //
												;
		
		//prompt(this, trT_DI_OVERTIMEWORK.action);
		
		trT_DI_OVERTIMEWORK.post();
		
		
		
		
		// Oracle 저장한 뒤에 Ms-Sql 쪽으로 전송해주기
		//var param = "proType=A";   	
		
		var param = "proType=A,ENO_NO=" + document.getElementById('txtENO_NO_SHR').value;		  //사번	
		
		for(var i=0; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){    
			
			dsT_DI_OVERTIMEWORK.UserStatus(i) = 1;		
			
		}		
		
		
		ln_TRSetting(tr1, "../../../servlet/security.menu.li.MSSQL020",  "JSP(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK)",  param);
		
		//prompt(this, dsT_DI_OVERTIMEWORK.text);
			
		tr_post(tr1);	
						

		
		/* SMS 는 나중에 하자 */
		
		//if(confirm("메세지를 전송하시겠습니까?")){			
			
			//var date;
			//var phone;
			
			//if (ds_default01.CountColumn == 0) {
			//	ds_default01.setDataHeader("MESSAGE:STRING, EM_PHN_NO:STRING");
			//}
			
			// 행 추가
			//ds_default01.AddRow();	

			//date = gcem_staxdate.text;
			//date = date.substring(0,4) + "년" + date.substring(4,6) + "월" + date.substring(6,8) + "일";

			//phone = txt_phone_no.value;
			//phone = phone.replace("-","").replace("-", ""); 

		     
			   
				//trT_DI_SMSTRANS.KeyValue = "SAV01(I:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK)";
				
				//trT_DI_SMSTRANS.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD"
				//												+ "&S_MODE=SMS_TRANS" 			// 모드
				//												+ "&REQ_NO=" +req_no 			//
				//												;
				
				//prompt(this, trT_DI_SMSTRANS.action);
				
				//trT_DI_SMSTRANS.post();		     

		//}	
		

	}
	
	
	
	
	
	/**
	* 시 / 분 데이터 셋 생성 - 완료
	*/
	function fnc_SetTime() {
		
		
		// 신청정보 초기화
		dsT_DI_OVERTIMEWORK.ClearData();
		
		
		
		var catg = document.getElementById("cmbAPP_TYPE").value;
    	
		
		
    	document.getElementById("cmbSTR_OVR_HOUR").length = 0;
    	document.getElementById("cmbEND_OVR_HOUR").length = 0;
    	document.getElementById("cmbSTR_OVR_MIN").length = 0;
    	document.getElementById("cmbEND_OVR_MIN").length = 0;
		
    	
    	
		dsOT_Hour1.ClearData();
		dsOT_Hour2.ClearData();
		dsOT_Minute.ClearData();
		
		
		
		// 해당 Dataset의 Header가 없으면 Header 선언
        if (dsOT_Hour1.CountColumn == 0) {
        	dsOT_Hour1.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
		
		
		
     	// 해당 Dataset의 Header가 없으면 Header 선언
        if (dsOT_Hour2.CountColumn == 0) {
        	dsOT_Hour2.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
     	
     	
     	
    	// 해당 Dataset의 Header가 없으면 Header 선언
        if (dsOT_Minute.CountColumn == 0) {
        	dsOT_Minute.setDataHeader("CODE:STRING,CODE_NAME:STRING");
        }
		
    	
    	
		var cmbAMStr = new Array( "06","07","08" );
		var cmbAMEnd = new Array( "06","07","08","09" );
		
		
		
		//var cmbPMStr = new Array( "18","19","20","21","22","23" ); // 시작 시간과 종료 시간이 다를 경우 활용 - 현재는 시작시간과 종료시간이 동일하게 설정됨
		var cmbPMStr = new Array( "18","19","20","21","22","23","24","25","26","27","28","29","30" );
		var cmbPMEnd = new Array( "18","19","20","21","22","23","24","25","26","27","28","29","30" );
		
		
		
		var cmbWKStr = new Array( "00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24" );
		var cmbWKEnd = new Array( "00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24" );
		
		
		
		if(catg == "AM") {
			
				for(var i = 0; i < cmbAMStr.length; i++) {
					
					dsOT_Hour1.addrow();
					dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbAMStr[i];
					dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbAMStr[i];
					
				}
				
				
				for(var i = 0; i < cmbAMEnd.length; i++) {
					
					dsOT_Hour2.addrow();
					dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbAMEnd[i];
					dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = cmbAMEnd[i];
					
				}
			
		} else if(catg == "PM") {
			
			
			for(var i = 0; i < cmbPMStr.length; i++) {
				
				dsOT_Hour1.addrow();
				
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbPMStr[i];
				
				//dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbPMStr[i];
				
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = (Number(cmbPMEnd[i]) > 23 ? "0"+(Number(cmbPMEnd[i]) - 24) : cmbPMEnd[i]);
				
				
			}
			
			
			
			for(var i = 0; i < cmbPMEnd.length; i++) {
				
				dsOT_Hour2.addrow();
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbPMEnd[i];
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = (Number(cmbPMEnd[i]) > 23 ? "0"+(Number(cmbPMEnd[i]) - 24) : cmbPMEnd[i]);
				
			}
			
		} else  {
			

			for(var i = 0; i < cmbWKStr.length; i++) {
				
				dsOT_Hour1.addrow();
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE") = cmbWKStr[i];
				dsOT_Hour1.NameValue(dsOT_Hour1.RowPosition,"CODE_NAME") = cmbWKStr[i];
				
			}
			
			
			
			for(var i = 0; i < cmbWKEnd.length; i++) {
				
				dsOT_Hour2.addrow();
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE") = cmbWKEnd[i];
				dsOT_Hour2.NameValue(dsOT_Hour2.RowPosition,"CODE_NAME") = cmbWKEnd[i];
				
			}
			
			
		}
		
		
		
		
		
		dsOT_Minute.addrow();
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE") ="00";
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE_NAME") = "00";
		
		
		
		dsOT_Minute.addrow();
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE") ="30";
		dsOT_Minute.NameValue(dsOT_Minute.RowPosition,"CODE_NAME") = "30";
		
		
		
		fnc_BindingCommonCode(dsOT_Hour1, "cmbSTR_OVR_HOUR"); // 오전 시작 시
    	fnc_BindingCommonCode(dsOT_Hour2, "cmbEND_OVR_HOUR"); // 오전 종료 시
    	fnc_BindingCommonCode(dsOT_Minute, "cmbSTR_OVR_MIN"); // 오전 시작 분
    	fnc_BindingCommonCode(dsOT_Minute, "cmbEND_OVR_MIN"); // 오전 종료 분
    	
    	
    	
    	if(catg == "PM") {
    		
    		document.getElementById("cmbSTR_OVR_MIN").value = "00";
        	document.getElementById("cmbEND_OVR_MIN").value = "00";
        	
    	}
    	
    	
		
	}
	
	
	
	
	
	/**
	* 자동 결재선 처리 
	*/
	function fnc_AutoApproval() {
		
		var ENO_NO = document.getElementById('txtENO_NO_SHR').value;
		var DPT_CD = document.getElementById('txtDPT_CD').value;
		
		dsT_DI_APPROVAL.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_APP&ENO_NO="+ENO_NO+"&DPT_CD="+DPT_CD;
								
		dsT_DI_APPROVAL.Reset();
		
	}
	
	
	
	
	
	/**
	* 해당일 기간/주 조회 
	*/
	function fnc_WeekOfYear() {
		
		//var Today = document.getElementById('txtENO_NO_SHR').value;
		
		var REG_YMD = today;
		
		dsWeekOfYear.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_WK&REG_YMD="+REG_YMD;
		
		dsWeekOfYear.Reset();
		
	}
	
	
	
	
	
	/**
	* 당월 연장근무 누적시간 조회 
	*/
	function fnc_MonAccHour() {
		
		
		
		var ENO_NO = document.getElementById('txtENO_NO_SHR').value;
		
		var WEEK_NO = dsWeekOfYear.NameValue(1,"WEEK_NO");
		
		dsMonAccHour.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_ACC&ENO_NO="+ENO_NO
																													+"&WEEK_NO="+WEEK_NO;
		
		dsMonAccHour.Reset();
		
	}
	
	
	
	
	
	/**
	* 연장근무에 대한 등록가능일자를 조회 
	* 토,일,공휴일 제외
	*/
	function fnc_getOTPossibleDt() {
		
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value;
		
		
		GBN = "SVL01";
		
    	trT_DI_OVERTIMEWORK.KeyValue = "SVL01(O:dsOTPossibleDt=dsOTPossibleDt)";
    	
		trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune010.cmd.GUNE010CMD&S_MODE=SHR_OTD&REG_YMD="+STR_YMD;
		
		//prompt(this,trT_DI_OVERTIMEWORK.action);
		
		trT_DI_OVERTIMEWORK.post();
		
	}
	
	
	
	
	
	// 완료 - trim 공백제거
	String.prototype.trim = function(){
		
		return this.replace(/\s/g, "");
		
	}
	
	
	
	
	
	// 완료 - replaceAll 기능 - str.replaceAll("-","")
	String.prototype.replaceAll = function(taget, replacement){
		
		return this.split(taget).join(replacement);
		
	}
	
	
	</script>
	
	
	
	
	
</head>

<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)                      *
*                                                                                        *
***************************************************************************************-->
	<!----------------------------------------------+
    | 1. 시간 콤보 박스 처리용                                                         |
    | 2. 이름 : dsOT_Hour                             |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Hour1" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <Object ID="dsT_DI_REQNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    
    <!----------------------------------------------+
    | 1. 시간 콤보 박스 처리용                  |
    | 2. 이름 : dsOT_Hour                       |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsOT_Hour2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. 분 콤보 박스 처리용                     |
    | 2. 이름 : dsOT_Minute                     |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsOT_Minute" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                           |
    | 2. 이름 : dsT_DI_OVERTIMEWORK                   |
    | 3. Table List : T_DI_OVERTIMEWORK              |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                          |
    | 2. 이름 : dsT_DI_APPROVAL                       |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                          |
    | 2. 이름 :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsWeekOfYear" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                          |
    | 2. 이름 :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsMonAccHour" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                          |
    | 2. 이름 :                                       |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOTPossibleDt" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5"><!-- 사용  -->
		<Param Name=KeyName Value="toinb_dataid4">
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
	<!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    	
    	if (iCount > 0) {
    		
    	 // dsT_DI_APPROVAL.NameString(1, "DUTY_NM") = "팀장";
         // dsT_DI_APPROVAL.NameString(1, "HDPT_NM") = "경영관리팀";
         // dsT_DI_APPROVAL.NameString(1, "HJOB_NM") = "과장";
         // dsT_DI_APPROVAL.NameString(1, "HJOB_CD") = "200";
         // dsT_DI_APPROVAL.NameString(1, "HENO_NM") = "문지예";
         // dsT_DI_APPROVAL.NameString(1, "HENO_NO") = "6180001";	    
            
    		var tmpTxt = "상신자 : " + dsT_DI_APPROVAL.NameString(1, "DPT_NM") +" "+
    			   					dsT_DI_APPROVAL.NameString(1, "JOB_NM")+" "+
    			   					dsT_DI_APPROVAL.NameString(1, "ENO_NM")+" / "+
    		                "결재자("+dsT_DI_APPROVAL.NameString(1, "DUTY_NM")+") : "+
    		                dsT_DI_APPROVAL.NameString(1, "HDPT_NM")+" "+
    		                dsT_DI_APPROVAL.NameString(1, "HJOB_NM")+" "+
    		                dsT_DI_APPROVAL.NameString(1, "HENO_NM");
    		                
    		document.getElementById("resultAppLine").innerText = tmpTxt;
    		
    		
    	} else {
    		
			alert("자동결재선의 파트장 정보가 없습니다.\n");
			
    		document.getElementById("resultAppLine").innerText = "";
    		
   		}
    	
    	
    	
    </Script>
    
    
    
    
    
    
    <Script For=dsWeekOfYear Event="OnLoadCompleted(iCount)">
    
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultWkSq").innerText = dsWeekOfYear.NameValue(1,"WEEK_NO");
    		document.getElementById("resultWkterm").innerText = dsWeekOfYear.NameValue(1,"REG_YMD");
    		
    	}
    	
    	
    </Script>
    
    
    
    
    
    <Script For=dsMonAccHour Event="OnLoadCompleted(iCount)">
    
    	//2021.03.16 관광팀 계약직 주 52시간이 아닌 주 48.5시간 제한
    	if (iCount > 0) {

    	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

        		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(연장) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(휴일) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
        		document.getElementById("resultAllow").innerText = (8.5 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";

    		}else{    		

    		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(연장) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(휴일) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
    		document.getElementById("resultAllow").innerText = (12 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";

    		}
    		
    		
    	} else {
    		
    	    if(gusrid == "6060002" || gusrid == "2210012" || gusrid == "2210013") {

        		document.getElementById("resultUse").innerText = "0H(연장) + 0H(휴일) = 0H";
        		document.getElementById("resultAllow").innerText = "8.5H";
        		dsMonAccHour.AddRow();
        		
    		}else{    		
    		
    		
    		document.getElementById("resultUse").innerText = "0H(연장) + 0H(휴일) = 0H";
    		document.getElementById("resultAllow").innerText = "12H";
    		dsMonAccHour.AddRow();
    		
    		}
    		
    	}

    	
    </Script>
    
    
    
    
    
    
    <Script For=dsOTPossibleDt Event="OnLoadCompleted(iCount)">
    	
    	if (iCount > 0) {
    		
    		
    		var catg = document.getElementById("cmbAPP_TYPE").value;
    		
    		
    		//alert(catg);
    		
    		var REQ_CNT = 0;
    		
    		for(var i=1; i<=dsOTPossibleDt.CountRow; i++) {
    			
    			
    			if(dsOTPossibleDt.NameString(i, "HOL_YN") == "N") {
    				
    				
    				REQ_CNT++;
    				
    				
   				}
    			
    			
    			
    			
    			//  휴일 정보 체크
    			//if(dsOTPossibleDt.NameString(i, "REG_YN") == "N")
   				//{
    			//	REQ_CNT++;
   				//}
    			
    			// 기 신청 또는 결재완료 체크
    			//if(dsOTPossibleDt.NameString(i, catg+"_REQ_YN") == "Y")
    			//{
     			//	REQ_CNT++;
    			//}
   			}
    		
    		
    		
    		//if(REQ_CNT > 0)
    		//{
    		//	alert("신청일 중 신청/결재 상태 또는 휴일이 포함되어 있습니다.\n\n신청 또는 결재가 완료되었거나,\n휴일이 포함되어 있는 근무일은 신청일에서 제외됩니다.");
    		//}
    		
    		
    		
    		
    		if(REQ_CNT = 0) {
    			
    			
    			alert("신청일 중 신청/결재 상태 또는 휴일이 포함되어 있습니다.\n\n신청 또는 결재가 완료되었거나,\n휴일이 포함되어 있는 근무일은 신청일에서 제외됩니다.");
    			
    			
    		}
    		
    		
    		
    	}
    </Script>
    
    
    
    
    
    
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsWeekOfYear Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsMonAccHour Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsOTPossibleDt Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    
    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsWeekOfYear Event="OnDataError()">
        cfErrorMsg(this);
    </Script>    
    
    
    <Script For=dsMonAccHour Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    
    <Script For=dsOTPossibleDt Event="OnDataError()">
        cfErrorMsg(this);
    </Script>
    
    

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("정상적으로 상신 되었습니다.\n\n결재 현황은 연장근무결재 메뉴에서 확인하시기 바랍니다.");
        	
        	window.close();
        	
        }
        
    </script>


	<script for=trT_DI_SMSTRANS event="OnSuccess()">

        	alert("작업을 완료 하였습니다");

    </script>
    
	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnFail()">
	
	
		cfErrorMsg(this);
		
		
    </script>
    
	<script for=trT_DI_SMSTRANS event="OnFail()">
	
	
		cfErrorMsg(this);
		
		
    </script>
    
    
    <!------------------------------------------+
    | 그리드 조회시 화면설정 변경 및 결재선 조회|
    +------------------------------------------->
    <script language=JavaScript for=grdT_DI_OVERTIMEWORK event=OnExit(row,colid,olddata)>
    
    
	    var ovr_time = ""; 
	    
		var catg = document.getElementById("cmbAPP_TYPE").value;
		
		
		
		if(colid == "STR_OVR_TIME" || colid == "END_OVR_TIME") {
			
			
			if(colid == "STR_OVR_TIME") {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
				
			} else {
				
				ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
				
			}
			
			
			
			if(ovr_time == "") {
				
				alert("시간 설정이 잘못되었습니다.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(!fnc_isNumber(ovr_time)) {
				
				alert("숫자만 입력 가능합니다.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if(ovr_time.length > 4) {
				
				alert("시간설정은 4자리를 초과할 수 없습니다.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			if( !(ovr_time.substring(2, 4) == "00" || ovr_time.substring(2, 4) == "30") ) {
				
				alert("분단위는 30분 단위로 설정가능 합니다.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			
			var STR_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "STR_OVR_TIME");
			var END_TIME = dsT_DI_OVERTIMEWORK.NameString(row, "END_OVR_TIME");
			
			
			
			if(catg == "AM") {
				
				
				if(  !((STR_TIME >= "0600" && STR_TIME <= "0900") && (END_TIME >= "0600" && END_TIME <= "0900")) ) {
					
					alert("오전 : 당일 06:00 ~ 당일 09:00 사이에서 등록가능합니다.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
			} else if(catg == "PM") {
				

				if((Number(STR_TIME.substring(0, 2)) >= 24 && Number(STR_TIME.substring(0, 2)) <= 30) || (Number(END_TIME.substring(0, 2)) >= 24 && Number(END_TIME.substring(0, 2)) <= 30)   ) {
					
					alert("올바른 입력시간 값이 아닙니다.\n00:00 ~ 06:00 사이로 입력하십시오.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
				
				
				STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
				END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );
	
				
				
				if( !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
					
					alert("오후 : 당일 18:00 ~ 익일 06:00 사이에서 등록가능합니다.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
				}
				
			} else {
				
				
			}
			
			
			
			
			
			
			var CALC_TIME = ((fnc_covNumber(END_TIME.substring(0, 2)) * 60) + fnc_covNumber(END_TIME.substring(2, 4))) - 
			((fnc_covNumber(STR_TIME.substring(0, 2)) * 60) + fnc_covNumber(STR_TIME.substring(2, 4)));
			
			
			
			if(parseInt(CALC_TIME) < 0 && STR_TIME != "" && END_TIME != "") {
				
				alert("종료시간이 시작시간보다 작습니다.\n다시 지정해 주세요");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			// 주별 12시간 체크
			if(!fnc_CalcAccReTime(dsT_DI_OVERTIMEWORK.NameString(row, "WK_MON"),dsT_DI_OVERTIMEWORK.NameString(row, "WK_FRI"),row,(CALC_TIME/60))) {
				
				alert("주별 최대 등록가능한 12시간을 초과하였습니다.");
				
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				
				return;
				
			}
			
			
			
			var temp_ovr_time = dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME");
			
			
			dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME") = (CALC_TIME/60);
			
			
			// 월 52시간 체크
			/* if(!fnc_CalcReTime())
			{
				dsT_DI_OVERTIMEWORK.NameString(row, "OVR_TIME") = temp_ovr_time;
				dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
				return;
			} */
			
			
			
		}
		
		
		
		
		
	</script>
	
	
	
	
	
	
	<!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

    
    
	    this.ReDraw = "false";	// 그리드 전체 draw 를 false 로 지정
	
	    
	    
		if (bCheck == '1') {	// 전체체크
			
			
			for(var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'T';
				
			}
		
		
		}else{	// 전체체크해제
			
			
			for (var i=1; i<=dsT_DI_OVERTIMEWORK.CountRow; i++){
				
				dsT_DI_OVERTIMEWORK.NameString(i, Colid) = 'F';
				
			}
		
		}
	    
	    

		this.ReDraw = "true";

		
		
    </script>
    
    
    
    
    
    
    <!-----------------------------------------------------+
    | grdT_DI_OVERTIMEWORK OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnClick(Row,Colid)>
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK") != "" ) {
			
			var obj =  dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
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
		<td height="35" class="paddingTop5" align="left">
		</td>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgReport','','../../images/button/btn_ReportOver.gif',1)">
			<img src="../../images/button/btn_ReportOn.gif" name="imgReport" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct();"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->




<!-- 제약 테이블 시작 
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	<colgroup>
		<col width="340"/>
		<col width="340"/>
		<col width="320"/>
	</colgroup>
	<tr>
		<td align="center" class="blueBold">연장시간</td>
		<td align="center" class="blueBold">신청 입력 가능시간</td>
		<td align="center" class="blueBold">주별 누적 근무시간</td>
	</tr>
	<tr height="60">
		<td align="center">오전 : 당일 06:00 ~ 당일 09:00<br>오후 : 당일 18:00 ~ 익일 06:00</td>
		<td align="center">오전 : 사전신청 ~ 당일 06:00 이전<br>오후 : 사전신청 ~ 당일 18:00 이전</td>
		<td align="center">최대 12H 까지 인정<br>(휴일근무 포함)</td>
	</tr>
</table>
제약 테이블 끝 -->



<p><br></p>




<!-- 신청정보 시작 -->
<table width="1000" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	<colgroup>
		<col width="200"/>
		<col width="250"/>
		<col width="200"/>
		<col width="250"/>
	</colgroup>
	

	
	<tr>
		<td align="center" class="blueBold">자동결재선</td>
		<td class="padding2423" colspan="3">
			<span id="resultAppLine">&nbsp;</span>
		</td>
	</tr>
	
	
	<tr>
		<td align="center" class="blueBold">소속</td>
		<td class="padding2423" colspan="3">
			<input id="txtDPT_CD" name="txtDPT_CD" size="4" class="input_ReadOnly" readonly > 
			<input id="txtDPT_NM" name="txtDPT_NM" size="20" class="input_ReadOnly"  readonly >
			<!-- a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDptCd','','/images/button/btn_HelpOver.gif',1)">
			<img src="/images/button/btn_HelpOn.gif" id="ImgDptCd" name="ImgDptCd" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','소속','DEPT')"></a-->
		</td>
		<!-- 
		<td align="center" class="blueBold">파트</td> maxlength="4" onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')" 
		 <td class="padding2423">
			  <input type="hidden" id="txtPART_CD_SHR" name="txtPART_CD_SHR" size="25" class="input_ReadOnly"  readonly >  
			<input id="txtPART_NM" name="txtPART_NM" size="25" class="input_ReadOnly"  readonly >
		</td> 
		-->
	</tr>
	
	<tr>
		<td align="center" class="blueBold">사번</td>
		<td class="padding2423">
		
<!--  		
            <input id="txtENO_NO_SHR" size="8" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
            <input id="txtENO_NM_SHR" size="8" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','1','');">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD','','');"></a>
            <input type="hidden" id="hidEMPL_DPT_CD">
-->
 
			<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNo()" onchange="fnc_SearchEmpNo()" class="input_ReadOnly"  >
			<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "14" onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNm()" onchange="fnc_SearchEmpNm()" class="input_ReadOnly"  > 
			<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">

		</td>
		<td align="center" class="blueBold" rowspan="2">주 누적시간(<span id="resultWkSq">&nbsp;</span>주차)<br>(<span id="resultWkterm">&nbsp;</span>)</td>   
		<td class="padding2423">
			<!-- span id="resultMonth">&nbsp;</span> : <input id="txtTOT_TIME" name="txtTOT_TIME" size="5" class="input_ReadOnly" style="text-align: right"  readonly-->
			금주사용 : <span id="resultUse">&nbsp;</span>
		</td>
	</tr>
	
	<tr>
		<td align="center" class="blueBold">연장근무 구분</td>
		<td class="padding2423">
			<select id="cmbAPP_TYPE" name="cmbAPP_TYPE" onchange="fnc_SetTime();">
				<option value="AM">조기출근신청</option> 
				<option value="PM" selected>오후연장근무신청</option>
				<option value="WK" >휴일근무신청</option>
			</select>
		</td>
		<td class="padding2423">
			<!-- span id="resultMonth">&nbsp;</span> : <input id="txtTOT_TIME" name="txtTOT_TIME" size="5" class="input_ReadOnly" style="text-align: right"  readonly-->
			신청가능 : <span id="resultAllow">&nbsp;</span>
		</td>
	</tr>
	
	<tr>
		<td align="center" class="blueBold">연장근무일</td>
		<td class="padding2423" colspan="3">
		
			<input id="txtSTR_YMD" class="input_ReadOnly" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
			<img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtSTR_YMD','','187','285');">
			</a>
			

			<select id="cmbSTR_OVR_HOUR" style="width:50px" onChange="document.getElementById('cmbEND_OVR_HOUR').value = this.value;fnc_OVR_Time();">
			</select>:
			<select id="cmbSTR_OVR_MIN" style="width:50px" onChange="document.getElementById('cmbEND_OVR_MIN').value = this.value;fnc_OVR_Time();">
			</select>
			&nbsp;&nbsp;~&nbsp;&nbsp;
			
			
			
			
			
			<input id="txtEND_YMD" class="input_ReadOnly" readonly size="10" maxLength="10" onblur="cfCheckDate(this);"  onkeypress="javascript:if(event.keyCode==13) cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','../../images/button/btn_HelpOver.gif',1)">
			<img src="../../images/button/btn_HelpOn.gif" name="Image13" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtEND_YMD','','315','285');">
			</a>
						
			
			
			<select id="cmbEND_OVR_HOUR" style="width:50px" onChange="fnc_OVR_Time();">
			</select>:
			<select id="cmbEND_OVR_MIN" style="width:50px" onChange="fnc_OVR_Time();">
			</select>
			&nbsp;&nbsp;신청시간 : <input id="txtREQ_TIME" name="txtREQ_TIME" size="4" class="input_ReadOnly" style="text-align: center;" value="0"  readonly>&nbsp;H
			
		</td>
	</tr>
	
	
	<tr>
		<td align="center" class="blueBold">근무내용</td>
		<td class="padding2423" colspan="3">
			<input id="txtREMARK" style="width=100%" onKeyUp="fc_chk_byte(this,50)">
		</td>
	</tr>
	
	
</table>

<!-- 신청정보 끝 -->




<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState">
					<span id="resultMessage"> </span>
					</td>
				</tr>
			</table>
		</td>
		<td class="paddingTop8" align="right">  <!-- 추가 삭제 버튼 -->
			<img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)" style="cursor:hand;">
			<img src="../../images/button/btn_RemoveOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Remove()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_RemoveOver.gif',1)" style="cursor:hand;">
		</td>
	</tr>
</table>





<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:230px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="Editable"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='CONF_SEL'				width=50			name=''						align=center			EditStyle=CheckBox		Pointer=Hand		HeadCheckShow=true</C>
								<C> id='REG_YMD'				width=100			name='근무일자'				align=center			Edit=none MASK='XXXX-XX-XX' </C>
								<C> id='WK_MON'					width=50			name='주 월요일'				align=center			Edit=none show=false</C>
								<C> id='WK_FRI'					width=50			name='주 금요일'				align=center			Edit=none show=false</C>
								<C> id='AM_REQ_YN'				width=50			name='오전신청여부'				align=center			Edit=none show=false</C>
								<C> id='PM_REQ_YN'				width=50			name='오후신청여부'				align=center			Edit=none show=false</C>
								<C> id='WEEK_TOT_TIME'			width=100			name='주별누적시간'				align=center			Edit=none show=false</C>
								<C> id='REQ_NO'					width=50			name='신청번호'				align=center			Edit=none show=false</C>
								<C> id='ALL_TOT_TIME'			width=100			name='주별누적시간'				align=center			Edit=none </C>
								<C> id='END_TAG'				width=70			name='결재상태'				align=center			EditStyle=Combo		Data=' :신청중,R:상신,Y:결재,N:부결'		Edit=none		Color='Blue'</C>
								<C> id='STR_OVR_TIME'			width=100			name='시작시간'				align=center			MASK='XX:XX'</C>
								<C> id='END_OVR_TIME'			width=100			name='종료시간'				align=center			MASK='XX:XX'</C>
								<C> id='OVR_TIME'				width=100			name='총근무시간'				align=center			Edit=none</C>
								<C> id='REMARK'					width=350			name='근무내용'				align=center			</C>
								<C> id='APP_REMARK'				width=40			name='결재비고'				align=center			Edit=none show=false</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->


<BR>

<font size=2 color=blue face = "돋움" bold=10>* 주 누적시간(연장+휴일)은 상신/결재중/결재완료의 정보가 누적된 시간입니다.</font>


</form>


<!-- form 끝 -->



</body>



</html>




