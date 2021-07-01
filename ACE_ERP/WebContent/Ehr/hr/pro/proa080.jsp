	<!--*************************************************************************
	* @source      : proa080.jsp												*
	* @description : 사원별추천자관리 PAGE										    *
	*****************************************************************************	
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/02/02            채갑병          	        최초작성									    *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>사원별추천자관리(proa080)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->
    
	<script language="javascript">
	
		var next_yy = eval(getToday().substr(0,4)+"+"+1);
		var btnList = 'TFTTTFFT';
		
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

			var PMT_YY_SHR   = document.form1.txtPMT_YY_SHR.value;
			var ENO_NO_SHR   = document.form1.txtENO_NO_SHR.value;
			//var PMT_GBN_SHR  = document.form1.cmbPMT_GBN_SHR.value;
			var PMT_GBN_SHR  = "1"
			var JOB_GBN_SHR  = document.form1.cmbJOB_GBN_SHR.value;
			
			if( PMT_YY_SHR == "" ){
        		alert("승진년도를 입력하십시오. 예)"+next_yy);
        		return;
        	}
        	if( PMT_YY_SHR.length != 4 ){
        		alert("승진년도를 바르게 입력하십시오. 예)"+next_yy);
        		return;
        	}
			
            trT_PM_PROPOSER_SHR.KeyValue = "tr01(O:dsT_PM_PROPOSER=dsT_PM_PROPOSER, O:dsT_CP_WORKLOG=dsT_CP_WORKLOG)";
            trT_PM_PROPOSER_SHR.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SHR&PMT_YY_SHR="+PMT_YY_SHR+"&ENO_NO_SHR="+ENO_NO_SHR+"&PMT_GBN_SHR="+PMT_GBN_SHR+"&JOB_GBN_SHR="+JOB_GBN_SHR;
            trT_PM_PROPOSER_SHR.post();
            			
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
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
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
        
            if (dsT_PM_PROPOSER.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_PM_PROPOSER.GridToExcel("사원별추천자관리", '', 225);

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			if (dsT_PM_PROPOSER.CountColumn == 0) {
				dsT_PM_PROPOSER.setDataHeader("PMT_YY:STRING, PMT_GBN:STRING, ENO_NO:STRING, PENO_NO:STRING, PDPT_CD:STRING, PJOB_CD:STRING");
			}
			
			dsT_PM_PROPOSER.AddRow();
			
			enableInput();	
        }

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
	        if (dsT_PM_PROPOSER.CountRow < 1) {
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("삭제 할 자료가 없습니다!");
                return;
            }else{
           		var tmpMSG = "아래 행을 삭제하시겠습니까?\n";
            	tmpMSG += "승진년도  = "+dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_YY")+"\n";
            	var str = "정기";
            	if( dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_GBN") == "2") str = "특별";
            	tmpMSG += "승진구분   = "+str+"\n";
            	tmpMSG += "사번         = "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "ENO_NO")+"\n";
            	tmpMSG += "추천자사번= "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NO")+"\n";
            	tmpMSG += "추천자명   = "+ dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NM")+"\n";
            	
	            if( confirm(tmpMSG) ){
					var PMT_YY  = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_YY");
					var PMT_GBN = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PMT_GBN");
					var ENO_NO  = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "ENO_NO");
					var PENO_NO = dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "PENO_NO");
				
					dsT_PM_PROPOSER.DeleteRow(dsT_PM_PROPOSER.RowPosition);
					
					// 파라미터 추가
					trT_PM_PROPOSER.Parameters = "PMT_YY="+PMT_YY+",PMT_GBN="+PMT_GBN+",ENO_NO="+ENO_NO+",PENO_NO="+PENO_NO;
				
					trT_PM_PROPOSER.KeyValue = "tr01(I:dsT_PM_PROPOSER=dsT_PM_PROPOSER)";
					trT_PM_PROPOSER.action = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=DEL";
					trT_PM_PROPOSER.post();
				}
			}
        }

		/********************************************
         * 10. 초기화 함수  							*
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
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsT_PM_PROPOSER.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
        }
        
		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }
        
		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
         	if ( !dsT_PM_PROPOSER.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        
			cfStyleGrid(form1.grdT_PM_PROPOSER,15,"true","false");      // Grid Style 적용
			document.form1.txtPMT_YY_SHR.value = next_yy;
			
			disableInput();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form이 Active 될 때 처리 할 일 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form이 Active 될 때 마다 재조회 처리
		}
		
         /********************************************
         * 입력필드 사용 가능하게(Enable)          		 *
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
 			//document.getElementById("imgENO_NO").disabled = false;  // 승진대상자 입력
			//document.getElementById("imgPMT_YY").disabled = false; // 승진년도 입력
  		}
  		
        /********************************************
         * 입력필드 사용 불가능하게(Disable)         		*
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
         * 사원 검색 후 필드값 매핑(extends common.js - 배열을 인자로)*
         ********************************************/
        function fnc_chkPMT_YY(){
        	
			if( document.form1.txtPMT_YY.value == ""){
				alert("승진년도를 먼저 입력하세요.");
				document.form1.txtENO_NO.value = "";
	            document.form1.txtENO_NM.value = "";
	            document.form1.txtDPT_NM.value = "";
	            document.form1.txtJOB_NM.value = "";
	            
				return false;
			}
			
			return true;

        }
        
 		/********************************************
         * 선택된 사원에 해당하는 사원정보 조회     *
         ********************************************/
        function fnc_SearchInfo(){
			var ENO_NO = document.form1.txtENO_NO.value;
			var PMT_YY = document.form1.txtPMT_YY.value;
			//var PMT_GBN = document.form1.cmbPMT_GBN.value;  // 정기승진자만 조회
			
			if( ENO_NO == ""){
				return;
			}
			dsVI_T_PERSON.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SHR_01&ENO_NO="+ENO_NO+"&PMT_YY="+PMT_YY; //+"&PMT_GBN="+PMT_GBN;
			dsVI_T_PERSON.reset();
        }
  		
  		/********************************************
         * 날짜 형식 유효성 체크                           			*
         ********************************************/
        function fncCheckDate(obj) {
            if (obj.value == '') return; 
            if(!cfDateExpr(obj.value)) { 
                alert('유효한 날짜가 아닙니다.'); 
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
         * 사원별추천자관리 완료 처리
         */
        function fnc_Complete() {
            var PMT_YY_SHR  = document.form1.txtPMT_YY_SHR.value;
            
            if(dsT_CP_WORKLOG.CountRow == 1) {
                if(parseInt(dsT_CP_WORKLOG.NameValue(1, "PRO_STS")) > 1) {
                    alert("이미 사원별추천자관리 완료처리가 되었습니다.");
                    return;
                } 
            } else {
                alert("사원별추천자관리 완료처리를 할 수 없습니다.");
                return;
            }
            
            if(!confirm("사원별추천자관리 완료처리를 하시겠습니까?")){
                return false;
            }
            
            dsT_CP_WORKLOG_SAV.dataid = "/servlet/GauceChannelSVL?cmd=hr.pro.a.proa080.cmd.PROA080CMD&S_MODE=SAV_COM&PMT_YY_SHR="+PMT_YY_SHR;
            dsT_CP_WORKLOG_SAV.reset();
        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_PM_PROPOSER)			   |
    | 3. 사용되는 Table List(T_PM_PROPOSER) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_PM_PROPOSER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
	<!-----------------------------------------------------+
    | 1. 조회용 DataSet								       |
    | 2. 이름은 ds_ + 주요 테이블명(VI_T_CM_PERSON)			   |
    | 3. 사용되는 Table List(VI_T_CM_PERSON) 				   |
    +------------------------------------------------------>
	<Object ID="dsVI_T_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
	
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)             |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                   |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>   
        
    <!-----------------------------------------------------+
    | 1. 조회용 DataSet                                       |
    | 2. 이름은 ds_ + 주요 테이블명(T_CP_WORKLOG)             |
    | 3. 사용되는 Table List(T_CP_WORKLOG)                   |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG_SAV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>       
		
	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_PM_PROPOSER)		       |
    | 3. 사용되는 Table List(T_PM_PROPOSER)			       |
    +------------------------------------------------------>
    <Object ID="trT_PM_PROPOSER_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>
        
	<Object ID="trT_PM_PROPOSER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
 
    
	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("검색하신 조건의 자료가 없습니다!");
			disableInput();
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_PM_PROPOSER.CountRow);
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        if(dsT_CP_WORKLOG.CountRow == 1){ // 저장
            if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "1") {
                if(dsT_PM_PROPOSER.countrow == 0){
                    disableInput();
                }else{
                    enableInput();
		          	if(Number(dsT_PM_PROPOSER.nameValue(dsT_PM_PROPOSER.RowPosition, "JOB_SEQ")) < 153 || //대리(30) JOB_SEQ는 153이다.
			           dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "1"){
			            //과장이상은 본부장만
			            document.form1.txtPENO_NO.readOnly = true;
			            document.form1.txtPENO_NO.className = "input_ReadOnly"; 
			            document.form1.txtPENO_NM.readOnly = true;
			            document.form1.txtPENO_NM.className = "input_ReadOnly";
			            
			            document.getElementById("ImgPENO_NO").disabled = true;
			            
			        }else{
			            //대리이하
			            document.form1.txtPENO_NO.readOnly = false;
			            document.form1.txtPENO_NO.className = ""; 
			            document.form1.txtPENO_NM.readOnly = false;
			            document.form1.txtPENO_NM.className = "";
			            
			            document.getElementById("ImgPENO_NO").disabled = false;
			                    
			        }
                    
                }
                
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "2") {
                disableInput();
                alert("이미 사원별추천자관리 완료처리가 되었습니다.");
            } else if(dsT_CP_WORKLOG.NameValue(1, "PRO_STS") == "3") {
                disableInput();
                alert("이미 승진사항관리 처리가 되었습니다.");
            }
        }else{       
            disableInput();
            alert("승진대상자선정이 완료되지 않았습니다.");
        }
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnLoadCompleted(iCount)">
        alert("사원별추천자관리 완료처리가 되었습니다.");
        disableInput();
        dsT_CP_WORKLOG.NameValue(1, "PRO_STS") = "2";
    </Script>    

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsVI_T_PERSON Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			alert("선택하신 사원은 승진대상자가 아닙니다.");
			document.form1.txtENO_NO.value = "";
			document.form1.txtENO_NM.value = "";
			document.form1.txtDPT_NM.value = "";
			document.form1.txtJOB_NM.value = "";
		} else {
        }
    </Script>
    
	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>    

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_PM_PROPOSER Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>
    
    <Script For=dsT_CP_WORKLOG_SAV Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>    

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROPOSER event="OnSuccess()">
        fnc_SearchList();//저장후 재조회를 해야 직위 소속나옴
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_PM_PROPOSER event="OnFail()">
        alert(trT_PM_PROPOSER.ErrorMsg);
    </script>
    
	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>     	
	<script language=JavaScript for=dsT_PM_PROPOSER event=OnRowPosChanged(row)>

        if(Number(dsT_PM_PROPOSER.nameValue(row, "JOB_SEQ")) < 153 || //대리(30) JOB_SEQ는 153이다.
           dsT_CP_WORKLOG.NameValue(1, "PRO_STS") != "1"){
            //과장이상은 본부장만
            document.form1.txtPENO_NO.readOnly = true;
            document.form1.txtPENO_NO.className = "input_ReadOnly"; 
            document.form1.txtPENO_NM.readOnly = true;
            document.form1.txtPENO_NM.className = "input_ReadOnly";
            
            document.getElementById("ImgPENO_NO").disabled = true;
            
        }else{
            //대리이하
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

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>	
			
	<!-- form 시작 -->
	<form name="form1">
	
	<!-- 타이틀 바 테이블 시작 -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">사원별추천자관리</td>
					<td align="right" class="navigator">HOME/인사관리/승진/<font color="#000000">사원별추천자관리</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->
	
	<!-- 버튼 테이블 시작 -->
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
	<!-- 버튼 테이블 끝 -->

	<!-- power Search테이블 시작 -->
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
						<td align="right" class="searchState">승진년도&nbsp;</td>
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
                            <td class="searchState" align="right"><!-- 승진구분 -->&nbsp;</td>
                            <td class="padding2423" align="left">
                                <!-- 
                                <select id="cmbPMT_GBN_SHR" style="width='80';" onChange="fnc_SearchList()">
                                    <option value="0">모두</option>
                                    <option value="1">정기</option>
                                    <option value="2">특별</option>
                                </select>
                                 -->
                            </td>
                            <td class="searchState" align="right">직위구분&nbsp;</td>
                            <td class="padding2423" align="left">
                                <select id="cmbJOB_GBN_SHR" style="width='80';" onChange="fnc_SearchList()">
                                    <option value="0">모두</option>
                                    <option value="1">과장이상</option>
                                    <option value="2">대리이하</option>
                                </select>
                            </td>
							<td align="right" class="searchState">사번&nbsp;</td>
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
	<!-- power Search테이블 끝 -->
	
	<!-- 조건 입력 테이블 시작 -->
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
                    <td align="center" class="creamBold">승진년도</td>
                    <td class="padding2423">
                        <input type="text" id="txtPMT_YY" style="ime-mode:disabled" size="5" class="input_ReadOnly" readonly maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPMT_YY','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgPMT_YY" name="imgPMT_YY" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPMT_YY','','348','157');"></a> -->
                    </td>
				
					<td align="center" class="creamBold">승진대상자</td>
					<td class="padding2423" align="left">
                        <input id="txtENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_SearchInfo();}" onchange="fnc_GetCommonEnoNm('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();" onkeyup="fnc_chkPMT_YY();">
                        <input id="txtENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_SearchInfo();}" onchange="fnc_GetCommonEnoNo('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();" onkeyup="fnc_chkPMT_YY();">
                        <!-- <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="imgENO_NO" name="imgENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="var rtn=fnc_chkPMT_YY();if(rtn == false){return false;};fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_SearchInfo();"></a> -->
					</td>
					<td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
					<td class="padding2423"><input id="txtDPT_NM" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423"><input id="txtJOB_NM" size="8" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">승진직위</td>
                    <td class="padding2423"><input id="txtFJOB_NM" size="8" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold" colspan="2">1차 추천자</td>
					<td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
					<td class="padding2423" align="left">
                        <input id="txtPENO_NO" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNm('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();">
                        <input id="txtPENO_NM" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNo('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPENO_NO','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPENO_NO" name="ImgPENO_NO" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtPENO_NO','txtPENO_NM','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO();"></a>
					</td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
                    <td class="padding2423"><input id="txtPDPT_NM" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423" colspan="3"><input id="txtPJOB_NM" size="8" class="input_ReadOnly" readonly></td>
				</tr>
				<tr>
                    <td align="center" class="creamBold" colspan="2">2차 추천자</td>
					<td align="center" class="creamBold">사&nbsp;&nbsp;번</td>
					<td class="padding2423" align="left">
                        <input id="txtPENO_NO2" size="9" maxlength= "8"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNm('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNm('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();">
                        <input id="txtPENO_NM2" size="9" maxlength= "9"onkeypress="if(event.keyCode==13){fnc_GetCommonEnoNo('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','', '', '', '');fnc_chgPENO_NO();}" onchange="fnc_GetCommonEnoNo('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgPENO_NO2','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgPENO_NO2" name="ImgPENO_NO2" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtPENO_NO2','txtPENO_NM2','hidEMPL_DPT_CD','1', '1', '', '');fnc_chgPENO_NO2();"></a>
					</td>
                    <td align="center" class="creamBold">소&nbsp;&nbsp;속</td>
                    <td class="padding2423"><input id="txtPDPT_NM2" size="15" class="input_ReadOnly" readonly></td>
					<td align="center" class="creamBold">직&nbsp;&nbsp;위</td>
					<td class="padding2423" colspan="3"><input id="txtPJOB_NM2" size="8" class="input_ReadOnly" readonly></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->
		
	<!-- 조회 상태 테이블 시작 -->
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
	<!-- 조회 상태 테이블 끝 -->
	
	<!-- 내용 조회 그리드 테이블 시작-->
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
							<C> id="PMT_YY"      width=40    name="승진;년도"  align=center    Edit=none   </C>
							<C> id="DPT_NM"      width=100   name="소속"       align=center    Edit=none   </C>
                            <C> id="JOB_NM"      width=50    name="직위"       align=center    Edit=none   </C>
							<C> id="ENO_NO"      width=70    name="사번"       align=center    Edit=none   </C>
							<C> id="ENO_NM"      width=70    name="성명"       align=center    Edit=none   </C>
							<G> name="1차 추천자" HeadBgColor="#F7DCBB"
	                            <C> id="PDPT_NM"    width=100   name="소속"     align=center    Edit=none    </C>
								<C> id="PJOB_NM"	width=50	name="직위"		align=center	Edit=none    </C>
	                            <C> id="PENO_NO"    width=70    name="사번"     align=center    Edit=none    </C>							
								<C> id="PENO_NM"	width=70	name="성명"		align=center	Edit=none    </C>
							</G>
							<G> name="2차 추천자" HeadBgColor="#F7DCBB"
	                            <C> id="PDPT_NM2"   width=100   name="소속"     align=center    Edit=none    </C>
								<C> id="PJOB_NM2"	width=50	name="직위"		align=center	Edit=none    </C>
	                            <C> id="PENO_NO2"   width=70    name="사번"     align=center    Edit=none    </C>							
								<C> id="PENO_NM2"	width=70	name="성명"		align=center	Edit=none    </C>
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
	<!-- 내용 조회 그리드 데이블 끝-->

	</form>
	<!-- form 끝 -->
	
</body>
</html>

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_PM_PROPOSER 설정 테이블 -->
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