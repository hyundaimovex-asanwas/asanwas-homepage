<!--
*****************************************************
* @source       : gune015.jsp
* @description : 연장근무사전신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2019/10/18     MOON              최초작성
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<%

	String req_no = request.getParameter("REQ_NO");         //신청번호
	String eno_no = request.getParameter("ENO_NO");         //신청자사번
	String app_yn = request.getParameter("APP_YN");			//결재상태
	String app_status = request.getParameter("APP_STATUS"); //결재진행상황
	String app_cmt = request.getParameter("APP_CMT");       //결재자의견
%>


<html>


<head>

	<title>연장근무사전신청</title>
	
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../../css/style.css" rel="stylesheet" type="text/css">
		<link href="../../css/general.css" rel="stylesheet" type="text/css">
		
		<script language=javascript src="../../common/common.js"></script>
		<script language=javascript src="../../common/input.js"></script>
		<script language=javascript src="../../common/result.js"></script>
		<script language=javascript src="../../common/mdi_common.js"></script>
		<script language="javascript" src="../../common/calendar/calendar.js"></script>
	
	
	
	<!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
	<script language="javascript" >
	
	
	// 버튼순서 : 조회 신규 저장 취소 엑셀 인쇄 삭제 닫기
	var btnList = 'TTTTTFTT';
	
	
	//var today = getToday();
	
	
	var today = gcurdate;
	
	var GBN = "";
	
	var obj = new String();
	
     
	obj.app_cmt = "";
	// 전역변수
	
	
	
	
    /***********************************
     * 01. 조회 함수_List 형태의 조회*
     ***********************************/
    function fnc_SearchList()
    {
    	
		
    	trT_DI_OVERTIMEWORK.KeyValue = "tr(O:dsT_DI_OVERTIMEWORK=dsT_DI_OVERTIMEWORK, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
    	
    	trT_DI_OVERTIMEWORK.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SHR&REQ_NO=<%=req_no%>&ENO_NO=<%=eno_no%>";
    	
    	trT_DI_OVERTIMEWORK.post();
    	
    	
    	
    }

	
	
	
    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem()
    {
    	
    	
    }

    
    
    
    /******************
     * 03. 저장 함수   *
     ******************/
    function fnc_Save()
    {
    	
    	
    }

    
    
    
    /******************
     * 04. 삭제 함수  *
     ******************/
    function fnc_Delete()
    {
    	
    	
    }

    
    
    /******************
     * 05. 인쇄 함수  *
     ******************/
    function fnc_Print()
    {
    	
    	
    	
    }

    
    
    
    /***********************
     * 06. 엑셀 저장 함수   *
     ***********************/
    function fnc_ToExcel()
    {
    	
    	
    	
    }

    
    
    
    /******************
     * 07. 신규 함수  *
     ******************/
    function fnc_AddNew()
    {
    	
    	
    	
    }

    
    
    /******************
     * 08. 유효성 검사 *
     ******************/
    function fnc_Valid()
    {
    	
    	
    	
    }

    
    
    
    
    /******************
     * 08. 추가 함수   *
     ******************/
	function fnc_Append()
    {
    	
    	
		
	}
    
    /******************
     * 09. 제거 함수 - 완료   *
     ******************/
    function fnc_Remove()
    {
    	
    	

    }

    
    
    
    /********************
     * 10. 초기화 함수   *
     ********************/
    function fnc_Clear()
    {
    	
    	location.reload();
    	
    }

    
    
    /************************
     * 11. 화면 종료(닫기)   *
     ***********************/
    function fnc_Exit()
    {
    	
    	if (dsT_DI_OVERTIMEWORK.IsUpdated) {
    		
			if (!fnc_ExitQuestion()) return;
			
		}

    	
		frame = window.external.GetFrame(window);
		
		frame.CloseFrame();
		
		
    }
    
    
    
    

    /******************************
     * 12. 검색 조건 유효성 검사  *
     ******************************/
    function fnc_SearchItemCheck(year)
    {
    	
    	
    	
    }

    
    
    /*************************
     * 13. 저장 유효성 체크  *
     *************************/
    function fnc_SaveItemCheck()
    {
    	
    	
    	
    	
    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분    *
     *******************************************/
    function fnc_OnLoadProcess()
    {
    	
    	
    	
    	
    	dsT_DI_APPROVAL.SetDataHeader(
				"GUN_YMD:STRING(10),"+			// 근태날짜
                "GUN_GBN:STRING(1),"+			// 근태결재구분
				"DPT_CD:STRING(6),"+			// 근태부서
				"DPT_NM:STRING(10),"+			// 근태부서명
				"SEQ_NO:STRING(1),"+			// 결재선
				"ENO_NO:STRING(10),"+			// 결재자사번
				"JOB_CD:STRING(10),"+			// 결재자직위
				"APP_TIME:STRING(10),"+			// 결재시간
				"ENO_NO:STRING(10),"+			// 상신자사번
				"APP_YN:STRING(10),"+			// 결재여부
				"ENO_NM:STRING(10),"+			// 결재자명
				"JOB_NM:STRING(10)"				// 직위명
		);
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","false"); // 연장근무 Grid Style 적용(그리드, 상태변경컬럼 width, 헤더체크박스, 헤더정렬)
    	
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMEWORK,0,"true","false"); // 연장근무 Grid Style 적용(그리드, 상태변경컬럼 width, 헤더체크박스, 헤더정렬)
    	
    	
    	
    	fnc_SearchList();
    	
   		
    	// 결재자만, 미결재 인경우에만 버튼이 활성화
		if(dsT_DI_APPROVAL.NameValue(1,"ENO_NO") == gusrid && dsT_DI_APPROVAL.NameValue(1,"APP_TIME") == ""){
        	
			
        	document.getElementById("btn_approval").style.display = "";
        	
            
        }else{
        	
        	
        	document.getElementById("btn_approval").style.display = "none";
        	
        	
        }
    	
    	
    	
    	
    }

	/********************
     * 15. 단축키 처리   *
     *******************/
	function fnc_HotKey()
	{
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
		
	}
	

   
	
	/********************
     * 16. 그외 함수 처리  *
     *******************/
	/**
     * 연장근무 신청일 기간 체크 - 완료
     */
	function fnc_CheckDate()
	{
		
		
		var STR_YMD = document.getElementById("txtSTR_YMD").value.replaceAll("-","");
		var END_YMD = document.getElementById("txtEND_YMD").value.replaceAll("-","");
		
		
		
		
		if(STR_YMD > END_YMD){
			
			
			alert("연장근무일의 시작일 설정이 잘못되었습니다.");
			
			
			return false;
			
			
		}
		
		
		
		return true;
		
		
	}
	
	
	
	
	
	
	/**
     * 누적시간재계산 - 완료
     */
     function fnc_CalcReTime()
	{
		
		
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
	function fnc_CalcAccReTime(mon, fri, row, calc)
 	{
    	 
    	 
    	 
		var tempVal = 0; // 재계산시간
		var tempVal2 = 0; // 주별 최초 누적 시간
		
		
		
		
		// 주별 누적시간 가져오기
		for(var i=1; i<=dsOTPossibleDt.CountRow; i++){
			
			
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
		
		
		
		
		
		// 주별 12시간 체크
		if( (tempVal2+tempVal) > 12) return false;
		
		
		
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
	function fnc_OVR_Time(catg)
	{
		
		var OVR_time =  "";
		
		OVR_time = ((fnc_covNumber(document.getElementById("cmbEND_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbEND_OVR_MIN").value)) - 
		((fnc_covNumber(document.getElementById("cmbSTR_OVR_HOUR").value) * 60) + fnc_covNumber(document.getElementById("cmbSTR_OVR_MIN").value));
		
		
		
		if(parseInt(OVR_time) < 0) {
			alert("종료시간이 시작시간보다 작습니다.\n다시 지정해 주세요");
			return;
		}
		
		
		
		document.getElementById("txtREQ_TIME").value = (OVR_time/60);
		
		
		
		
	}
	
	
	
	
	
	/**
	* 상신처리
	*/
	function fnc_Conduct()
	{
		
		
		
		if(dsT_DI_OVERTIMEWORK.CountRow < 1){
			
			
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
	
	
	
	

    /*************************
     * 19. 상신, 결재 처리   *
     *************************/
	function fnc_SubmitApproval(kind) {

    	
    	
    	
        if (!confirm(kind+" 처리를 하시겠습니까?")) return;


        var app_yn = "";    //결재완료여부

       
        if(kind == "상신"){
        	
        	
            fnc_InputDisabled();//입력란 disabled
            
            
            document.getElementById("btn_appre").style.display = "none";//상신않보이게  ===>  수정 요망
            
            
            status = kind;
            
            
            return false;

            
            
        }else if(kind == "결재"){
        	
            app_yn = "Y";
            
        }else if(kind == "부결" || kind == "반송"){
        	

			if(obj.app_cmt == ""){
				
      			window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      	    
			}

            if(obj.app_cmt != ""){
            	
				app_yn = "N";
				
	            if(kind == "부결") {
	            	
	            	app_yn = "N";
	            	

	            }else if(kind == "반송") {
	            	
	            	app_yn = "E";
	            	
	            }
	            
            }else{
            	
                alert("부결 또는 반송사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
                
                return false;
                
        	}

        }
        
        
        
        
        dsT_DI_OVERTIMEWORK_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
        
        
        dsT_DI_OVERTIMEWORK_STATE.AddRow();
        
        
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"REQ_NO") = dsT_DI_OVERTIMEWORK.NameValue(1,"REQ_NO");
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"ENO_NO") = dsT_DI_OVERTIMEWORK.NameValue(1,"ENO_NO");
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_STATUS") = kind;
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;
        dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_YN") = app_yn;


        
        trT_DI_OVERTIMEWORK_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
		trT_DI_OVERTIMEWORK_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SAV";
		trT_DI_OVERTIMEWORK_STATE.post();
		
		
        document.getElementById("btn_approval").style.display = "none";//결재버튼들

        
        window.close();
        

    }
    
    
    
    
    /*************************
     * 21. 팝업일 경우 처리  *
     *************************/
	function fnc_OnLoadPop() {
    	
    	
    	
		//alert("팝업이당");
		
		
        status = "<%=app_status%>";
        
        cmt = "<%=app_cmt%>";

        fnc_SearchList(); //해당 신청서 조회
        
        fnc_InputDisabled();


        
        var APP_STATUS = "";
        
        
        var Aeno_no = "";

        
            for(var i= 1; i <= dsT_DI_APPROVAL.CountRow; i++){

	                Aeno_no = dsT_DI_APPROVAL.NameValue(i,"ENO_NO");   //결재자
	                
					APP_STATUS = dsT_DI_APPROVAL.NameValue(i,"APP_STATUS");   //결재여부  &&  (app_yn == null)			
					
					if(Aeno_no == gusrid && ( APP_STATUS == "미결")){
	
						document.getElementById("btn_approval").style.display = "";
						
						dsT_DI_APPROVAL.NameValue(i,"REMARK1") = "의견입력";
						
						break;
	
	            	}
				
				
			}
            

    }
    
    
    
    /*****************************************
     * 22. 사유입력팝업(부결, 반송처리)      *
     ****************************************/
	function fnc_SubmitCancle(kind) {


        var obj = new String();

        
        window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        
        if(obj.app_cmt != undefined){

        	
        	
            dsT_DI_OVERTIMEWORK_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
            
            
            dsT_DI_OVERTIMEWORK_STATE.AddRow();
            
            
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"REQ_NO") = document.getElementById("txtREQ_NO").value;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_STATUS") = kind;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_CMT") = kind+"처리-"+obj.app_cmt;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"KIND") = kind;
            dsT_DI_OVERTIMEWORK_STATE.NameValue(1,"APP_YN") = "N";
            
            

            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMEWORK_STATE=dsT_DI_OVERTIMEWORK_STATE)";
            trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.e.gune015.cmd.GUNE015CMD&S_MODE=SAV_03";
            trT_DI_BUSINESSTRIP_STATE.post();

            
            
            document.getElementById("btn_approval").style.display = "";
            
            

        }

        
    }
    
    
	</script>
	
	
	
</head>




<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
*                                                                                        *
***************************************************************************************-->
	<!----------------------------------------------+
    | 1. 시간 콤보 박스 처리용                  	|
    | 2. 이름 : dsOT_Hour                       	|
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
    | 1. 시간 콤보 박스 처리용                  	|
    | 2. 이름 : dsOT_Hour                       	|
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Hour2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 분 콤보 박스 처리용                        |
    | 2. 이름 : dsOT_Minute                         |
    | 3. Table List :                               |
    +----------------------------------------------->
    <Object ID="dsOT_Minute" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERTIMEWORK                 |
    | 3. Table List : T_DI_OVERTIMEWORK             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
        <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                 |
    | 2. 이름 : dsT_DI_APPROVAL               |
    | 3. Table List : T_DI_APPROVAL            |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                 |
    | 2. 이름 :                                      |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsWeekOfYear" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                 |
    | 2. 이름 :                                      |
    | 3. Table List :                                |
    +----------------------------------------------->
    <Object ID="dsMonAccHour" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                 |
    | 2. 이름 :                                      |
    | 3. Table List :                                |
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
	<Object ID="trT_DI_OVERTIMEWORK" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	
	
    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMEWORK_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    
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
			
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			
		}
        
    </Script>
    
    <Script For=dsWeekOfYear Event="OnLoadCompleted(iCount)">
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultWkSq").innerText = dsWeekOfYear.NameValue(1,"WEEK_NO");
    		document.getElementById("resultWkterm").innerText = dsWeekOfYear.NameValue(1,"REG_YMD");
    		
    	}
    	
    	
    </Script>
    
    
    
    
    <Script For=dsMonAccHour Event="OnLoadCompleted(iCount)">
    
    	if (iCount > 0) {
    		
    		document.getElementById("resultUse").innerText = dsMonAccHour.NameValue(1,"WEEK_TOT_TIME") + "H(연장) + " + dsMonAccHour.NameValue(1,"HOL_TOT_TIME") + "H(휴일) = " + dsMonAccHour.NameValue(1,"ALL_TOT_TIME") + "H";
    		document.getElementById("resultAllow").innerText = (12 - Number(dsMonAccHour.NameValue(1,"ALL_TOT_TIME"))) +"H";
    		//document.getElementById("resultWkSq").innerText = dsMonAccHour.NameValue(1,"WEEK_NO")
    		//document.getElementById("resultWkterm").innerText = dsMonAccHour.NameValue(1,"TARGET_WEEK");
    		
    		
    	} else {
    		
    		
    		document.getElementById("resultUse").innerText = "0H(연장) + 0H(휴일) = 0H";
    		document.getElementById("resultAllow").innerText = "12H";
    		dsMonAccHour.AddRow();
    		
    		//prompt(this,dsMonAccHour.text);
    		
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
    	
   			}
    		
    		
    		
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
    | Transaction Successful 처리     						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("작업을 완료 하였습니다!");
        	
        	fnc_Clear();
        	
        }
        
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMEWORK event="OnFail()">
	
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
				
			} else {
				
				
				if( (Number(STR_TIME.substring(0, 2)) >= 24 && Number(STR_TIME.substring(0, 2)) <= 30) || (Number(END_TIME.substring(0, 2)) >= 24 && Number(END_TIME.substring(0, 2)) <= 30)   ) {
					
					
					alert("올바른 입력시간 값이 아닙니다.\n00:00 ~ 06:00 사이로 입력하십시오.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
					
				}
				
				
				
				STR_TIME = (    (Number(STR_TIME.substring(0, 2)) >= 0 && Number(STR_TIME.substring(0, 2)) <= 6)    ?    ((Number(STR_TIME.substring(0, 2))+24)+""+STR_TIME.substring(2, 4)) : STR_TIME ); 
				END_TIME = (    (Number(END_TIME.substring(0, 2)) >= 0 && Number(END_TIME.substring(0, 2)) <= 6)    ?    ((Number(END_TIME.substring(0, 2))+24)+""+END_TIME.substring(2, 4)) : END_TIME );
	
				
				
				if(  !((STR_TIME >= "1800" && STR_TIME <= "3000") && (END_TIME >= "1800" && END_TIME <= "3000"))  && STR_TIME != "" && END_TIME != "") {
					
					alert("오후 : 당일 18:00 ~ 익일 06:00 사이에서 등록가능합니다.");
					
					dsT_DI_OVERTIMEWORK.NameString(row, colid) = olddata;
					
					return;
					
					
				}
				
				
				
				
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
			

		}
		
		
		
	</script>
	
	
	
	
	
	<!-----------------------------------------------------+
    | header를 클릭했을때 미반영 데이타 모두 체크
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_DI_OVERTIMEWORK event=OnHeadCheckClick(Col,Colid,bCheck)>

	    this.ReDraw = "false";	// 그리드 전체 draw 를 false 로 지정
	
		if (bCheck == '1'){	// 전체체크
			
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
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK") != "" ){
			
			var obj =  dsT_DI_OVERTIMEWORK.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
	</script>
    
    <!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

  
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

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
			 <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">
				<img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_SubmitApproval('결재');">
				</a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">
				<img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');">
				</a>
 			</span>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->





<p><br></p>	




<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
			<table width="210" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							
							<tr height="28">
								<td align="center" class="blueBold">신청번호</td>
								<td class="padding2423">
									<input id="txtREQNO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            
                          <!--   <tr height="27">
								<td align="center" class="blueBold">소속</td>
								<td class="padding2423">
									<input type="hidden" id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
                            <tr height="27">
								<td align="center" class="blueBold">직위</td>
								<td class="padding2423">
                                    <input type="hidden" id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							<tr height="27">
								<td align="center" class="blueBold">신청자</td>
								<td class="padding2423">
									<input type="hidden" id="txtENO_NO" size="10" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr> -->
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
			
			
			
        </td>
        <td width="25">&nbsp;</td>
        <td>
        
        
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="900" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:780px;height:100px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NM'			width=70	name='구분'				align=center	Value={IF(SEQ_NO > '90','협조', '결재')}</C>
								<C> id='ENO_NM'			width=90	name='결재자'			align=center	</C>
								<C> id='JOB_NM'			width=80	name='직위'				align=center	</C>
                                <C> id='DPT_NM'			width=150	name='팀'				align=center	</C>
								<C> id='APP_STATUS'		width=250	name='결재상태'			align=center    </C>
								<C> id='REMARK1'		width=120	name='의견'				align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
       		  </table>
        	<!-- 결재선 정보 테이블 끝 -->
        	
        	
        </td>
    </tr>
</table>





<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">* 주 누적시간(연장+휴일)은 상신/결재중/결재완료의 정보가 누적된 시간입니다.</span></td>
				</tr>
			</table>
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
						<object	id="grdT_DI_OVERTIMEWORK" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:250px;">
							<param name="DataID"				value="dsT_DI_OVERTIMEWORK">
							<param name="Editable"				value="true">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='{CUROW}'			width=40			name='NO'				align=center			value={String(Currow)}		</C>							
								<C> id='JOB_NM'				width=60			name='직위'				align=center			Edit=none		</C>
								<C> id='ENO_NO'				width=80			name='사번'				align=center			Edit=none		</C>
								<C> id='ENO_NM'				width=80			name='성명'				align=center			Edit=none		</C>
								<C> id='STR_REG_YMD'		width=100			name='근무일자'			align=center			Edit=none MASK='XXXX-XX-XX' </C>
								<C> id='REQ_NO'				width=50			name='신청번호'			align=center			Edit=none show=false</C>
								<C> id='STR_OVR_TIME'		width=80			name='시작시간'			align=center			Edit=none		MASK='XX:XX'</C>
								<C> id='END_OVR_TIME'		width=80			name='종료시간'			align=center			Edit=none		MASK='XX:XX'</C>
								<C> id='OVR_TIME'			width=80			name='총근무시간'		align=center			Edit=none</C>
								<C> id='REMARK'				width=380			name='근무내용'			align=center			Edit=none		</C>
								<C> id='APP_REMARK'			width=40			name='결재비고'			align=center			Edit=none show=false</C>
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



</form>
<!-- form 끝 -->



</body>
</html>
