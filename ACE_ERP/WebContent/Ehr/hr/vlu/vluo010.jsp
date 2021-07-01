<!--
***********************************************************************
* @source      : vluo010.jsp
* @description : 목표설정 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/06      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>목표설정</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/style_new.css" rel="stylesheet" type="text/css">	
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var year    = "2018";
        var dsTemp = window.dialogArguments;

        var selectRow = 0;

        var ENO_NO = "";
        var ENO_NM = "";

			ENO_NO = gusrid;
			ENO_NM = gusrnm;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	fnc_Clear();

        	if(document.getElementById("txtENO_NM").value == "") {
	       		alert("성명을 입력해 주세요.");
	       		return;
	       	}

        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;
        	
        	
        	dsT_EVL_GOALLIST_CNT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO;
        	dsT_EVL_GOALLIST_CNT.Reset();      
        	
        	
            dsT_EVL_GOALLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ=1";
            dsT_EVL_GOALLIST.Reset();
            
            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);  
            
            //fnc_SetGrdHeight();
            
            
    		
            //상태 조회
            
            if(dsT_EVL_GOALLIST_01.NameValue(1, "APP_STATUS") == "R"){
            	
                alert("상신 상태입니다.\n\n조회만 가능합니다.");
                
                fnc_display("n");     
                
            }else if(dsT_EVL_GOALLIST_01.NameValue(1, "APP_STATUS") == "Y"){

                alert("결재 완료되었습니다.");
                
                fnc_display("n");
                
            }else{
            	
                fnc_display("y");            	
            	
            }
            
            grdT_EVL_GOALLIST_CNT.Focus();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {


        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            // 저장시 각 필드의 유효성체크
            if (!fnc_SaveItemCheck()) {
                return;
            }

			for(var i=0; i<=dsT_EVL_GOALLIST.CountRow; i++){       
				dsT_EVL_GOALLIST.UserStatus(i) = 1;				
			}
            

            
            trT_EVL_GOALLIST.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST)";
            
            trT_EVL_GOALLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SAV";
            
            //prompt(this, dsT_EVL_GOALLIST.text);
            
            trT_EVL_GOALLIST.post();
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            if (document.getElementById('txtEVL_YYYY').value != year) {
            	alert(fnc_GetMSG("MSG_10"));
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_10");
                document.getElementById('txtEVL_YYYY').focus();
                return;
            }

        	// 삭제 할 자료가 있는지 체크하고
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_05");
                alert(fnc_GetMSG("MSG_05"));
                return;
            }

            if(selectRow == 0) {
            	alert("삭제할 행을 선택해 주세요.");
                return;
            }

            if (confirm("삭제 후 저장해야 내용이 반영됩니다.") == false) return;

            var row = selectRow;

            dsT_EVL_GOALLIST.DeleteRow(row);
            dsT_EVL_GOALLIST_01.DeleteRow(row);
            selectRow = 0;

            //fnc_SetGrdHeight();

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {


            //이곳에 해당 코딩을 입력 하세요
    		if (dsT_EVL_GOALLIST.countrow<1) {
    			alert("출력하실 정보가 없습니다");
    		} else {
     
        
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;
        	var GOAL_SEQ = dsT_EVL_GOALLIST_CNT.rowposition;
        	
        	dsT_EVL_REPORT.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SHR_PRT&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+GOAL_SEQ;
        	dsT_EVL_REPORT.Reset();        	
            
    		ReportID.Preview();

    		}
        	
        	
        }
 

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {



        }

        /******************
         * 07. 신규 함수  *
         ******************/

        function fnc_AddNew() {

			for(var i=1; i<=dsT_EVL_GOALLIST.CountRow; i++){

				dsT_EVL_GOALLIST.NameValue(i,"CATEGORY") 			= dsT_EVL_GOALLIST_01.NameValue(i,"CATEGORY");
				dsT_EVL_GOALLIST.NameValue(i,"FORMULA") 			= dsT_EVL_GOALLIST_01.NameValue(i,"FORMULA");
				dsT_EVL_GOALLIST.NameValue(i,"GOALSET_HALF") 		= dsT_EVL_GOALLIST_01.NameValue(i,"GOALSET_HALF");
				dsT_EVL_GOALLIST.NameValue(i,"GOALSET_10") 			= dsT_EVL_GOALLIST_01.NameValue(i,"GOALSET_10");				
				dsT_EVL_GOALLIST.NameValue(i,"GOALSET") 			= dsT_EVL_GOALLIST_01.NameValue(i,"GOALSET");
				
			}

			var row = dsT_EVL_GOALLIST.CountRow;

			dsT_EVL_GOALLIST.InsertRow(row+1);
		
			dsT_EVL_GOALLIST_01.InsertRow(row+1);

            dsT_EVL_GOALLIST.nameValue(row+1, "EVL_YYYY") = document.getElementById('txtEVL_YYYY').value;
            dsT_EVL_GOALLIST.nameValue(row+1, "ENO_NO") = ENO_NO;
            dsT_EVL_GOALLIST.nameValue(row+1, "GOAL_SEQ") = dsT_EVL_GOALLIST_CNT.NameValue(dsT_EVL_GOALLIST_CNT.rowposition, "GOAL_SEQ");              
            dsT_EVL_GOALLIST.nameValue(row+1, "GOAL_NO") = 1;

            cfCopyDataSet(dsT_EVL_GOALLIST, dsT_EVL_GOALLIST_01);

			//fnc_SetGrdHeight();

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

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			
            document.getElementById("resultMessage").innerText = ' ';

            // DataSet Clear
            dsT_EVL_GOALLIST.ClearData();
            dsT_EVL_GOALLIST_01.ClearData();

            selectRow = 0;
        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();
            }else{
                window.close();
            }

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            if (document.getElementById("txtEVL_YYYY").value != year) {
            	
                alert(fnc_GetMSG("MSG_01"));
                
                document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_01");
                
                document.getElementById("txtEVL_YYYY").focus();
                
                return false;
            }

			for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

				if(dsT_EVL_GOALLIST.nameValue(i, "APP_STATUS") == 'R'){
					alert("상신하셨기때문에 수정하실 수 없습니다.");
					return false;
				}

				dsT_EVL_GOALLIST.nameValue(i, "GOAL_NO") 		= dsT_EVL_GOALLIST_01.nameValue(i, "GOAL_NO");				
				dsT_EVL_GOALLIST.nameValue(i, "CATEGORY") 		= dsT_EVL_GOALLIST_01.nameValue(i, "CATEGORY");
				dsT_EVL_GOALLIST.nameValue(i, "FORMULA") 		= dsT_EVL_GOALLIST_01.nameValue(i, "FORMULA");
				dsT_EVL_GOALLIST.nameValue(i, "GOALSET_HALF") 	= dsT_EVL_GOALLIST_01.nameValue(i, "GOALSET_HALF");				
				dsT_EVL_GOALLIST.nameValue(i, "GOALSET_10") 	= dsT_EVL_GOALLIST_01.nameValue(i, "GOALSET_10");				
				dsT_EVL_GOALLIST.nameValue(i, "GOALSET") 		= dsT_EVL_GOALLIST_01.nameValue(i, "GOALSET");
				dsT_EVL_GOALLIST.nameValue(i, "WEIGHT") 		= dsT_EVL_GOALLIST_01.nameValue(i, "WEIGHT");
				dsT_EVL_GOALLIST.nameValue(i, "GOAL_SEQ") 		= dsT_EVL_GOALLIST_01.nameValue(i, "GOAL_SEQ");			

			}

            // DataSet의 변경 여부 확인
            if ( !dsT_EVL_GOALLIST.IsUpdated ) {
				document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_02");
                return false;
            }

			// 가중치 합계 체크
			var weightTot = 0;
			
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	dsT_EVL_GOALLIST.NameValue(i, "GOAL_NO") = i;		// GOAL_NO 순번 채번
				weightTot = weightTot + parseInt(dsT_EVL_GOALLIST.NameValue(i, "WEIGHT"));

            }
            

            //중점추진과제 빈칸이 있으면 저장불가
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	if(dsT_EVL_GOALLIST.NameValue(i, "CATEGORY") == null || dsT_EVL_GOALLIST.NameValue(i, "CATEGORY") == ""){

            	alert(i + "번째 줄 중점추진과제를 입력해주시기 바랍니다.");
            	
            	return false;
            	
            	}

            }               
            

            //세부목표 빈칸이 있으면 저장불가
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	if(dsT_EVL_GOALLIST.NameValue(i, "FORMULA") == null || dsT_EVL_GOALLIST.NameValue(i, "FORMULA") == ""){

            	alert(i + "번째 줄 세부목표를 입력해주시기 바랍니다.");
            	
            	return false;
            	
            	}

            }               
                        
            

            //목표설정시 빈칸이 있으면 저장불가
            /* 상반기는 지났기에 validation check 해제 2018.07.16 이동훈
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	if(dsT_EVL_GOALLIST.NameValue(i, "GOALSET_HALF") == null || dsT_EVL_GOALLIST.NameValue(i, "GOALSET_HALF") == ""){

            	alert(i + "번째 줄 상반기 목표설정을 해주시기 바랍니다.");
            	
            	return false;
            	
            	}

            }            
            */
            
            
            //목표설정시 빈칸이 있으면 저장불가
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	if(dsT_EVL_GOALLIST.NameValue(i, "GOALSET_10") == null || dsT_EVL_GOALLIST.NameValue(i, "GOALSET_10") == ""){

            	alert(i + "번째 줄 10월까지 목표설정을 해주시기 바랍니다.");
            	
            	return false;
            	
            	}

            }    
            
            //목표설정시 빈칸이 있으면 저장불가
            for (var i = 1; i <= dsT_EVL_GOALLIST.CountRow; i++) {

            	if(dsT_EVL_GOALLIST.NameValue(i, "GOALSET") == null || dsT_EVL_GOALLIST.NameValue(i, "GOALSET") == ""){

            	alert(i + "번째 줄 연간 목표설정을 해주시기 바랍니다.");
            	
            	return false;
            	
            	}

            }               
            
            
            //alert(weightTot);
            
            if(weightTot != 100) {

            	alert("가중치 합계가 100이 아닙니다. 확인 후 작업해 주세요.");
            	return false;
            }

            
            return true;
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {
			
			cfStyleGrid_New(grdT_EVL_GOALLIST_CNT, 0, "false", "false");  // Grid Style         	
			cfStyleGrid_New(grdT_EVL_GOALLIST_01, 0, "true", "false");
			grdT_EVL_GOALLIST_01.RowHeight = 100;          // Grid Row Height Setting
			grdT_EVL_GOALLIST_01.TitleHeight = "40";

            //년도 Setting
            document.getElementById("txtEVL_YYYY").value = year;
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;

         
    	//관리자의 경우 년도, 사번 검색 활성화
    	if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2070020"){ 

			//document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		//document.getElementById("txtEVL_YYYY").readOnly = true;
			document.getElementById("txtENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";

		}else{

            //document.getElementById("txtEVL_YYYY").className = "";
	  		//document.getElementById("txtEVL_YYYY").readOnly = false;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

    	}

	        document.getElementById("txtEVL_YYYY").className = "";
	  		document.getElementById("txtEVL_YYYY").readOnly = false;    	
    	
    		fnc_SearchList();
    		


        }



        /*****************************************************
         * 15. 상신                                          *
         ****************************************************/
        function fnc_Submit() {

        	// 상신 할 자료가 있는지 체크하고
            if (dsT_EVL_GOALLIST.CountRow < 1) {
            	
                alert("상신할 자료가 없습니다");
                return;
            }

        	// DataSet의 변경 여부 확인
            if ( dsT_EVL_GOALLIST.IsUpdated || dsT_EVL_GOALLIST_01.IsUpdated ) {
				alert("저장한 후 상신하시기 바랍니다.");
                return false;
            }

            if (confirm("상신 이후에는 수정이 불가능합니다.\n\n상신하시겠습니까?") == false) return;


            //전체가 넘어가게 해야함
            dsT_EVL_GOALLIST_01.UseChangeInfo = "false";
 
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO = document.getElementById("txtENO_NO").value;            
        	//var GOAL_SEQ = dsT_EVL_GOALLIST_01.nameValue(1, "GOAL_SEQ");                      
            
        	var GOAL_SEQ = dsT_EVL_GOALLIST_CNT.rowposition;        	
        	
        	//alert(GOAL_SEQ);
        	
            trT_EVL_APPROVAL.Parameters = "EVL_YYYY="+EVL_YYYY+",ENO_NO="+ENO_NO+",GOAL_SEQ="+GOAL_SEQ;
            
            trT_EVL_APPROVAL.KeyValue = "tr01(I:SAV=dsT_EVL_GOALLIST_01)";
            trT_EVL_APPROVAL.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo010.cmd.VLUO010CMD&S_MODE=SAV_01";
            trT_EVL_APPROVAL.post();

            dsT_EVL_GOALLIST_01.UseChangeInfo = "true";

            alert("상신이 완료되었습니다");
            
        	document.getElementById("resultMessage").innerText = "상신이 완료되었습니다";

			fnc_display("n");

    		fnc_SearchList();			
			
        }


        
		// display
        function fnc_display(yn) {

        	if(yn == "n") {
	        	document.getElementById("imgSave").style.display = "none";
				//document.getElementById("Image1").style.display = "none";
				document.getElementById("Image2").style.display = "none";
				document.getElementById("Image6").style.display = "none";
				document.getElementById("Image7").style.display = "none";
				
				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET_HALF","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET_10","Edit") = "None";
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET","Edit") = "None";				
				grdT_EVL_GOALLIST_01.ColumnProp("WEIGHT","Edit") = "None";

			} else {
				
				document.getElementById("imgSave").style.display = "";
				//document.getElementById("Image1").style.display = "";
				document.getElementById("Image2").style.display = "";
				document.getElementById("Image6").style.display = "";
				document.getElementById("Image7").style.display = "";
				
				grdT_EVL_GOALLIST_01.ColumnProp("CATEGORY","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("FORMULA","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET_HALF","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET_10","Edit") = "Any";				
				grdT_EVL_GOALLIST_01.ColumnProp("GOALSET","Edit") = "Any";
				grdT_EVL_GOALLIST_01.ColumnProp("WEIGHT","Edit") = "Any";
				
			}
        }

        function fnc_SetGrdHeight() {
        	
        	var height = 0;

			height = (dsT_EVL_GOALLIST.CountRow * 100) + 20;

			if(height < 350) { // 최소 높이 400px
				height = 350;
			}
			
            grdT_EVL_GOALLIST_01.style.height = height;

        }

        
        function fnc_GetNm() {
	            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
	            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EVL_GOALLIST_CNT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_GOALLIST_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
  
	<!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_GOALLIST) |
    | 3. 사용되는 Table List(T_EVL_GOALLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_GOALLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST)">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_GOALLIST_01)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_GOALLIST Event="OnLoadCompleted(iCount)">


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_GOALLIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>

    <!-- 트랜젝션 성공. -->
    <script for=trT_EVL_GOALLIST event="OnSuccess()">

		if(dsTemp != "Modal") {

		} else {

		}

        fnc_SearchList();

    </script>

    <!--트랜젝션 실패 -->
    <script for=trT_EVL_GOALLIST event="OnFail()">

        cfErrorMsg(this);

    </script>



	<!-----------------------------------------------------+
    | 위쪽 grid에서 row를 클릭했을때                                  |
    +------------------------------------------------------>
	<script for=grdT_EVL_GOALLIST_CNT event=OnClick(Row,Colid)>

		//alert(dsT_EVL_GOALLIST_CNT.NameValue(Row, "APP_STATUS"));
		
	    if(dsT_EVL_GOALLIST_CNT.NameValue(Row, "APP_STATUS") == "R"){
	    	
	        //alert("상신 상태입니다.\n\n조회만 가능합니다.");
	        
	        fnc_display("n");     
	        
	    }else if(dsT_EVL_GOALLIST_CNT.NameValue(Row, "APP_STATUS") == "Y"){
	
	        //alert("결재 완료되었습니다.");
	        
	        fnc_display("n");
	        
	    }else{
	    	
	        fnc_display("y");            	
	    	
	    }	
	
	
	
	    if (dsT_EVL_GOALLIST_01.IsUpdated)  {
	    	
	        if (confirm("저장하지 않은 자료는 리셋됩니다.") == false){
	        	
	        	return;
	        }
	    }	
	
		if(Row < 1) {
			
			return;
			
		} else {
			
        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var ENO_NO   = document.getElementById("txtENO_NO").value;			
        	var GOAL_SEQ = dsT_EVL_GOALLIST_CNT.NameValue(Row, "GOAL_SEQ");
        	
			dsT_EVL_GOALLIST_01.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo020.cmd.VLUO020CMD&S_MODE=SHR_01&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&GOAL_SEQ="+GOAL_SEQ;
			dsT_EVL_GOALLIST_01.Reset();

            cfCopyDataSet(dsT_EVL_GOALLIST_01, dsT_EVL_GOALLIST);  

			if(dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '완료'){
				
	        	document.getElementById("Image5").style.display = "none";				
	        	document.getElementById("Image6").style.display = "none";
				document.getElementById("Image7").style.display = "none";
				document.getElementById("Image2").style.display = "none";
				document.getElementById("Image3").style.display = "";
				
				fnc_ChangeGrid(0);
			}else if(dsT_EVL_GOALLIST_CNT.nameValue(dsT_EVL_GOALLIST_CNT.rowposition, "STATUS") == '상신'){
				
	        	document.getElementById("Image5").style.display = "none";				
	        	document.getElementById("Image6").style.display = "none";
				document.getElementById("Image7").style.display = "none";
				document.getElementById("Image2").style.display = "none";
				document.getElementById("Image3").style.display = "none";
				
				fnc_ChangeGrid(1);				
				
			}else{

	        	document.getElementById("Image5").style.display = "";				
	        	document.getElementById("Image6").style.display = "";
				document.getElementById("Image7").style.display = "";				
				document.getElementById("Image2").style.display = "";		
				document.getElementById("Image3").style.display = "none";	
				
				fnc_ChangeGrid(1);
			}                
			
            //fnc_SetGrdHeight();			

		}
	</script>

	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_EVL_GOALLIST event=CanRowPosChange(row)>


	</script>

	<!-----------------------------------------------------+
    | 셀 및 레코드 영역 선택 변경이 완료된 이후에 발생하는 이벤트	|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_EVL_GOALLIST_01 event=OnClick(Row,Colid)>
	
	    selectRow = Row;
	    
  	</script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<div class="evl_container"><!-- evl_container 시작-->

<br>

	<div class="btn_group_right" ><!-- btn_group 시작-->
		<ul class="list">
	        <li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_ReportOver.gif',1)">  <img src="../../images/button/btn_ReportOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Submit()"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImagePRT','','../../images/button/btn_PrintOver.gif',1)"> <img src="../../images/button/btn_PrintOn.gif"  name="ImagePRT" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a></li>		
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image2','','../../images/button/btn_SaveOver.gif',1)"><img src="../../images/button/btn_SaveOn.gif" name="Image2" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a></li>
		</ul>
	</div><!-- //btn_group 끝-->




	<div class="inquiry"><!-- inquiry 시작-->
		<form action="" method="post" >
			<fieldset>
				<legend>목표설정</legend>
					<p>해당년도 :
					<span>
						<input type="text" id=txtEVL_YYYY name="txtEVL_YYYY" size="4" readonly class="input_ReadOnly" />
					</span>
					&nbsp;&nbsp;성명 :
					<span>
						<input type="text" id="txtENO_NO" name="txtENO_NO" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" /><input type="text" style="display:none" />
						<input type="text" id="txtENO_NM" name="txtENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" /><input type="text" style="display:none" />
						<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO','txtENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
						<input type="hidden" id="hidEMPL_DPT_CD">					
					</span>
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry 끝-->


		
		
		
<!-- 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr >
	        <td>
				<comment id="__NSID__">
					<object	id="grdT_EVL_GOALLIST_CNT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:150px;">
						<param name="DataID"					value="dsT_EVL_GOALLIST_CNT">
						<param name=HiddenHScroll 			value="true">
						<param name=HiddenVScroll 			value="true">
						<param name="Format"					value="
				            <C> id=GOAL_SEQ         width=50		name='순번'        		align=center </C>	
				           <G> name='피평가자'	HeadBgColor='#dae0ee'			
                            <C> id=TEAM_NM			width=100		name='소속'				align=center </C>
                            <C> id=PART_NM			width=140		name='파트'				align=left </C>                            
							<C> id=ENO_NM			width=70		name='작성자'			align=center </C>
				           </G>				           
				           <G> name='평가자' 	HeadBgColor='#dae0ee'
                            <C> id=HTEAM_NM			width=100		name='소속'				align=center </C>
                            <C> id=HPART_NM			width=140		name='파트'				align=left </C> 	                            
							<C> id=HENO_NM			width=70		name='평가자'			align=center </C>
				           </G>
							<C> id=STATUS			width=80		name='결재상태'			align=center </C>
			                <C> id=IPT_YMD       	width=80		name='작성일자'     	align=center </C>								
							<C> id=FROM_TO			width=150		name='기간'				align=center </C>
						">
					</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
<!-- 그리드 테이블 끝-->		

<br>
		
	<div class="btn_group_right" width="1000"><!-- btn_group 시작-->
		<ul class="list">
			<li><span id="resultMessage">&nbsp;</span></li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_AppendOver.gif',1)"> <img src="../../images/button/btn_AppendOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image7','','../../images/button/btn_DeleteOver.gif',1)"> <img src="../../images/button/btn_DeleteOn.gif"  name="Image7" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a></li>
		</ul>
	</div><!-- //btn_group 끝-->		
		

<!-- 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr >
	        <td>
				<comment id="__NSID__">
					<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:400px;">
						<param name="DataID"					value="dsT_EVL_GOALLIST_01">
						<param name=HiddenHScroll 				value="false">
						<param name=HiddenVScroll 				value="false">
						<param name="Format"					value="
								<C> id={currow}			width=48   	name='NO'											align=center </C>
								<C> id='GOAL_SEQ'		width=150	name='GOAL_SEQ'										align=center	show=false </C>
								<C> id='CATEGORY'		width=150	name='중점추진과제'									align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=400	name='세부목표 달성수준\\(평가기준/측정방법)'		align=left		wordwrap=word Multiline=true </C>
			                <G> name='목표' 			BgColor='#dae0ee'	
								<C> id='GOALSET_HALF'	width=100	name='상반기목표'									align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET_10'		width=100	name='10월목표'										align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=100	name='연간목표'										align=left		wordwrap=word Multiline=true </C>
							</G>	
								<C> id='WEIGHT'			width=80	name='가중치'										align=center	 Edit=none</C>		
						">
					</object>
				</comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
<!-- 그리드 테이블 끝-->		
		
		
		
		
	<!-- 내용 조회 그리드 테이블 시작
	<table  summary="목표설정" class="evl_table">
	<caption>목표설정</caption>
			<colgroup>
				<col width="50px" />
				<col width="150px" />
				<col width="500px" />
				<col width="200px" />
				<col width="90px" />	
				<col width="20px" />												
			</colgroup>
			<thead>
				<tr>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">NO</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">중점추진과제</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">세부목표 달성수준<BR>(평가기준/측정방법)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">목표</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;">가중치<BR>(100%)</th>
					<th style = "height:10px; padding:7px 0 ;border:1px solid #d1deeb; border-bottom:1px solid #abc0dc; background:#dae0ee; font-weight:bold; color:#34578c;"> </th>

				</tr>		
			</thead>
			<tbody>
	<tr>
	<td colspan="7">
	<div style="width:1000px; height:350px; overflow-y:auto;">
		<table style='font:11px "돋움",Dotum,"굴림",Gulim,Verdana,Arial,sans-serif; color:#555; color:#454e69; font-weight:normal;'>
		    <tr align="center">
		        <td>
		        	<comment id="__NSID__">
						<object	id="grdT_EVL_GOALLIST_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:350px;">
							<param name="DataID"				value="dsT_EVL_GOALLIST_01">
		                	<param name=HiddenVScroll 			value="false">
		                	<param name=HiddenHScroll 			value="false">
	                		<param name=ViewHeader 				value="false">
							<param name="Format"				value="
								<C> id={currow}			width=48   	name='NO'				align=center </C>
								<C> id='GOAL_SEQ'		width=150	name='GOAL_SEQ'			align=center	show=false </C>
								<C> id='CATEGORY'		width=150	name='중점추진과제'		align=center	wordwrap=word Multiline=true </C>
								<C> id='FORMULA'		width=500	name='세부목표'			align=left		wordwrap=word Multiline=true </C>
								<C> id='GOALSET'		width=200	name='달성기한'			align=center	wordwrap=word Multiline=true </C>
								<C> id='WEIGHT'			width=100	name='가중치'			align=center	 Edit=none</C>																														
							">
						</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
		        </td>	        
		    </tr>
		</table>
	</div>
	</td>
	</tr>
	</table>	
	
<!-- 	
<table width="1000" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" align="left">
	<tr>
		<td>
        <table width="500" border="0" cellspacing="1" cellpadding="3" bgcolor="#666666" align="left">
          <tr bgcolor="#FFF8EE" height="15">
            <td width="500" height="15" colspan="4" align="center">
              	달성도 평가 기준 (정량적 구간의 Gap은 목표치에 따라 변동가능)
            </td>        
          </tr>
          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	등급
            </td>
            <td width="200" align="center">
              	정성적 기준
            </td>
            <td width="200" align="center">
              	정량적 기준
            </td>
            <td width="50" align="center">
              	평가점수
            </td>            
          </tr>          
          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	S
            </td>
            <td width="200" align="center">
                    목표치 매우 상회 달성(탁월)
            </td>
            <td width="200" align="center">
              	110% 이상
            </td>
            <td width="50" align="center">
              	100
            </td>            
          </tr>
    
          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	A
            </td>
            <td width="200" align="center">
                    목표치 이상 달성(우수)
            </td>
            <td width="200" align="center">
              	100%이상 ~ 110%미만
            </td>
            <td width="50" align="center">
              	85
            </td>            
          </tr>

          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	B
            </td>
            <td width="200" align="center">
                    목표치 준하여 달성(양호)
            </td>
            <td width="200" align="center">
              	90%이상 ~ 100%미만
            </td>
            <td width="50" align="center">
              	70
            </td>            
          </tr>
          
          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	C
            </td>
            <td width="200" align="center">
                    목표치 미달(저조)
            </td>
            <td width="200" align="center">
              	80%이상 ~ 90%미만
            </td>
            <td width="50" align="center">
              	55
            </td>            
          </tr>          
          
          <tr bgcolor="#FFFFFF" height="15">
            <td width="50" align="center">
              	D
            </td>
            <td width="200" align="center">
                    목표치 매우 미달(미진행)
            </td>
            <td width="200" align="center">
              	80% 미만
            </td>
            <td width="50" align="center">
              	40
            </td>            
          </tr>          
                                   
        </table>
        
        <td>
        	&nbsp;※ <B>Ctrl</B> + <B>Enter</B> 누르시면 줄바꿈됩니다.<BR>
			&nbsp;※ 가중치 입력시 숫자만 입력하시기 바랍니다. (ex : 50)<BR>
		</td>
     </tr>
 </table>
 -->

</div><!-- //evl_container 끝 -->




<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 목표 설정 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"					VALUE="dsT_EVL_REPORT">
	<param name="DetailDataID"	    			value="dsT_EVL_REPORT">
	<PARAM NAME="PaperSize"						VALUE="A4">
	<PARAM NAME="LandScape"						VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 			VALUE="true">
	<PARAM NAME="PreviewZoom"					VALUE="120">
	<PARAM NAME="Format" 						VALUE="


<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=410 ,face='Arial' ,size=12 ,penwidth=1
	<X>left=69 ,top=294 ,right=2818 ,bottom=407 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='순' ,left=79 ,top=320 ,right=153 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=172 ,top=294 ,right=172 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=717 ,top=294 ,right=717 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2643 ,top=294 ,right=2643 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='가중치' ,left=2659 ,top=320 ,right=2797 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='중점 추진 과제' ,left=238 ,top=323 ,right=669 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='세부목표 달성수준' ,left=1101 ,top=302 ,right=1632 ,bottom=349 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='(평가기준/측정방법)' ,left=1098 ,top=349 ,right=1630 ,bottom=397 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=1095 ,top=45 ,right=1680 ,bottom=257 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<I>id='../../../Common/img/2015slg.jpg' ,left=66 ,top=77 ,right=548 ,bottom=222</I>
	<X>left=1828 ,top=93 ,right=2813 ,bottom=185 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=1828 ,top=95 ,right=1828 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='JOB_NM', left=2265, top=191, right=2545, bottom=257, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1828 ,top=262 ,right=2813 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='성명' ,left=2588 ,top=111 ,right=2794 ,bottom=172 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='직위' ,left=2334 ,top=111 ,right=2477 ,bottom=172 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='소속' ,left=1966 ,top=111 ,right=2114 ,bottom=172 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='DPT_NM', left=1836, top=191, right=2241, bottom=257, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ENO_NM', left=2559, top=193, right=2807, bottom=259, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='목표설정' ,left=1193 ,top=87 ,right=1609 ,bottom=222 ,face='HY중고딕' ,size=20 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1897 ,top=296 ,right=1897 ,bottom=410 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2252 ,top=93 ,right=2252 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2551 ,top=93 ,right=2551 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2148 ,top=296 ,right=2148 ,bottom=410 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2400 ,top=294 ,right=2400 ,bottom=407 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='10월 목표' ,left=2154 ,top=323 ,right=2394 ,bottom=386 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='상반기 목표' ,left=1902 ,top=320 ,right=2143 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='년간 목표' ,left=2405 ,top=320 ,right=2638 ,bottom=384 ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=2813 ,top=93 ,right=2813 ,bottom=262 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=270 ,face='Arial' ,size=12 ,penwidth=1
	<L> left=69 ,top=0 ,right=69 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=717 ,top=0 ,right=717 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=172 ,top=0 ,right=172 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2643 ,top=0 ,right=2643 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='WEIGHT', left=2664, top=11, right=2797, bottom=265, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CATEGORY', left=177, top=11, right=709, bottom=265, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='{CURROW}', left=79, top=37, right=161, bottom=188, face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=69 ,top=270 ,right=2818 ,bottom=270 </L>
	<L> left=1897 ,top=0 ,right=1897 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GOALSET', left=2410, top=11, right=2641, bottom=265, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=2148 ,top=0 ,right=2148 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GOALSET_10', left=2162, top=8, right=2392, bottom=262, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=2400 ,top=0 ,right=2400 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GOALSET_HALF', left=1910, top=11, right=2140, bottom=265, align='left', face='Tahoma', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='FORMULA', left=728, top=11, right=1894, bottom=265, align='left', face='Tahoma', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=2813 ,top=0 ,right=2813 ,bottom=270 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=74 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='총계' ,left=69 ,top=0 ,right=2643 ,bottom=74 ,face='Tahoma체' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<X>left=2643 ,top=0 ,right=2813 ,bottom=74 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='100%' ,left=2667 ,top=5 ,right=2805 ,bottom=69 ,face='Tahoma' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=0 ,right=2813 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=26 ,right=2815 ,bottom=106</T>
	<I>id='../../images/common/icon.jpg' ,left=2400 ,top=11 ,right=2781 ,bottom=106</I>
</B>






">
</OBJECT>

</body>
</html>


